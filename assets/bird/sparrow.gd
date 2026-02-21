extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shadow: Sprite2D = $Shadow
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = randf_range(1.0, 3.0)
	timer.one_shot = true
	timer.timeout.connect(_animate_one_hop)
	timer.start()

func _animate_one_hop() -> void:
	
	const HOP_TIME := 0.4
	const HALF_HOP_TIME := HOP_TIME / 2.0

	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
	var random_distance := randf_range(0.0, 30.0)
	var land_position := random_direction * random_distance

	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(sprite_2d, "position:x", land_position.x, HOP_TIME)
	tween.tween_property(shadow, "position", land_position, HOP_TIME)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	var jump_high := 16.0
	tween.tween_property(sprite_2d, "position:y", land_position.y - jump_high, HALF_HOP_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite_2d, "position:y", land_position.y , HALF_HOP_TIME)
	timer.wait_time = randf_range(1.0, 3.0)
	tween.finished.connect(timer.start)
