private _header = LLSTRING(category);
private _category = [_header, LLSTRING(subCategoryArmorPlates)];
private _aceMedicalLoaded = isClass(configFile >> "CfgPatches" >> "ace_medical_engine");

[
    QGVAR(numWearablePlates),
    "SLIDER",
    [LLSTRING(numWearablePlates), LLSTRING(numWearablePlates_desc)],
    _category,
    [0, 10, 3, 0],
    true,
    {
        params ["_value"];
        GVAR(numWearablePlates) = round _value;
        if (time < 1) exitWith {};
        {
            ctrlDelete (_x select 0);
            ctrlDelete (_x select 1);
        } forEach (uiNamespace getVariable [QGVAR(plateControls), []]);
        uiNamespace setVariable [QGVAR(plateControls), []];
        [] call FUNC(initPlates);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(maxPlateHealth),
    "SLIDER",
    [LLSTRING(maxPlateHealth), LLSTRING(maxPlateHealth_desc)],
    _category,
    [1, 200, 25, 0],
    true,
    {
        params ["_value"];
        GVAR(maxPlateHealth) = round _value;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(timeToAddPlate),
    "SLIDER",
    [LLSTRING(timeToAddPlate), LLSTRING(timeToAddPlate_desc)],
    _category,
    [0, 30, 8, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(allowPlateReplace),
    "CHECKBOX",
    [LLSTRING(allowPlateReplace), LLSTRING(allowPlateReplace_desc)],
    _category,
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(spawnWithFullPlates),
    "CHECKBOX",
    [LLSTRING(spawnWithFullPlates), LLSTRING(spawnWithFullPlates_desc)],
    _category,
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(AIchancePlateInVest),
    "SLIDER",
    [LLSTRING(AIchancePlateInVest), LLSTRING(AIchancePlateInVest_desc)],
    _category,
    [0, 1, 0.4, 0, true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(AIchancePlateInVestMaxNo),
    "SLIDER",
    [LLSTRING(AIchancePlateInVestMaxNo), LLSTRING(AIchancePlateInVestMaxNo_desc)],
    _category,
    [0, 10, 0, 0],
    true,
    {
        params ["_value"];
        GVAR(AIchancePlateInVestMaxNo) = round _value;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(AIchancePlateInInventory),
    "SLIDER",
    [LLSTRING(AIchancePlateInInventory), LLSTRING(AIchancePlateInInventory_desc)],
    _category,
    [0, 1, 0.2, 0, true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(AIchancePlateInInventoryMaxNo),
    "SLIDER",
    [LLSTRING(AIchancePlateInInventoryMaxNo), LLSTRING(AIchancePlateInInventoryMaxNo_desc)],
    _category,
    [0, 10, 0, 0],
    true,
    {
        params ["_value"];
        GVAR(AIchancePlateInInventoryMaxNo) = round _value;
    }
] call CBA_fnc_addSetting;

_category = [_header, LLSTRING(subCategoryFeedback)];

[
    QGVAR(showDamageMarker),
    "CHECKBOX",
    [LLSTRING(showDamageMarker), LLSTRING(showDamageMarker_desc)],
    _category,
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(downedFeedback),
    "LIST",
    [LLSTRING(downedFeedback), LLSTRING(downedFeedback_desc)],
    _category,
    [[0, 1, 2], [LLSTRING(downedFeedback_0), LLSTRING(downedFeedback_1), LLSTRING(downedFeedback_2)], 2],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(audioFeedback),
    "LIST",
    [LLSTRING(audioFeedback), LLSTRING(audioFeedback_desc)],
    _category,
    [[0, 1, 2, 3, 4], [LLSTRING(downedFeedback_0), LLSTRING(audioFeedback_1), LLSTRING(audioFeedback_2), LLSTRING(audioFeedback_3), LLSTRING(audioFeedback_4)], 3],
    true
] call CBA_fnc_addSetting;

_category = [_header, LLSTRING(subCategoryGeneral)];

[
    QGVAR(enable),
    "CHECKBOX",
    [LLSTRING(enable), LLSTRING(enable_desc)],
    _category,
    true,
    true,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(damageCoef),
    "SLIDER",
    [LLSTRING(damageCoef), LLSTRING(damageCoef_desc)],
    _category,
    [0.01, 100, [50, 5] select _aceMedicalLoaded, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(headshotMult),
    "SLIDER",
    [LLSTRING(headshotMult), LLSTRING(headshotMult_desc)],
    _category,
    [0.01, 10, 2, 0, true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(limbMult),
    "SLIDER",
    [LLSTRING(limbMult), LLSTRING(limbMult_desc)],
    _category,
    [0, 10, 0.7, 0, true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(disallowFriendfire),
    "CHECKBOX",
    [LLSTRING(disallowFriendfire), LLSTRING(disallowFriendfire_desc)],
    _category,
    false,
    true
] call CBA_fnc_addSetting;

if (_aceMedicalLoaded) exitWith {};

[
    QGVAR(damageEhVariant),
    "LIST",
    [LLSTRING(damageEhVariant), LLSTRING(damageEhVariant_desc)],
    _category,
    [[0, 1], ["Hit","HandleDamage"], 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enablePlayerUnconscious),
    "CHECKBOX",
    [LLSTRING(enablePlayerUnconscious), LLSTRING(enablePlayerUnconscious_desc)],
    _category,
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(bleedoutTime),
    "SLIDER",
    [LLSTRING(bleedoutTime), LLSTRING(bleedoutTime_desc)],
    _category,
    [0, 15 * 60, 60, 0],
    true,
    {
        params ["_value"];
        GVAR(bleedoutTime) = round _value;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(medicReviveTime),
    "SLIDER",
    [LLSTRING(medicReviveTime), LLSTRING(medicReviveTime_desc)],
    _category,
    [1, 60, 8, 1],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(noneMedicReviveTime),
    "SLIDER",
    [LLSTRING(noneMedicReviveTime), LLSTRING(noneMedicReviveTime_desc)],
    _category,
    [1, 60, 16, 1],
    true
] call CBA_fnc_addSetting;

_category = [_header, LLSTRING(subCategoryHealth)];

[
    QGVAR(maxPlayerHP),
    "SLIDER",
    [LLSTRING(maxPlayerHP), LLSTRING(maxPlayerHP_desc)],
    _category,
    [1, 1000, 100, 0],
    true,
    {
        params ["_value"];
        GVAR(maxPlayerHP) = round _value;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(maxAiHP),
    "SLIDER",
    [LLSTRING(maxAiHP), LLSTRING(maxAiHP_desc)],
    _category,
    [1, 1000, 100, 0],
    true,
    {
        params ["_value"];
        GVAR(maxAiHP) = round _value;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(enableHpRegen),
    "CHECKBOX",
    [LLSTRING(enableHpRegen), LLSTRING(enableHpRegen_desc)],
    _category,
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enableHpRegenForAI),
    "CHECKBOX",
    [LLSTRING(enableHpRegenForAI), LLSTRING(enableHpRegenForAI_desc)],
    _category,
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(hpRegenRate),
    "SLIDER",
    [LLSTRING(hpRegenRate), LLSTRING(hpRegenRate_desc)],
    _category,
    [1, 100, 10, 2],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(maxHealMedic),
    "SLIDER",
    [LLSTRING(maxHealMedic), LLSTRING(maxHealMedic_desc)],
    _category,
    [0, 2, 0.75, 0, true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(maxHealRifleman),
    "SLIDER",
    [LLSTRING(maxHealRifleman), LLSTRING(maxHealRifleman_desc)],
    _category,
    [0, 1, 0.5, 0, true],
    true
] call CBA_fnc_addSetting;
