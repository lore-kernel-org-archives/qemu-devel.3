Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FAC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TKZ-0008LM-2U; Tue, 01 Sep 2026 14:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TKV-0008Kc-CF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:35:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TKS-0004tX-31
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:35:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4843c41f35bso98176f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788287726; x=1788892526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4rCI6ALSqHSesKNWjBfSzIvjUYJzDYaGxkANBnpkHdg=;
 b=gBvXIH04xDQ1iS5BGAnP+0gbP+15GjiyikXJHN88NMGR0ChpAX7ZR7ImKEa3p7mkF3
 R9hvy+K9fIT9xjPTL8sk2Qc5TTqX1aRsy8C0A6q40fTMTtlUndYW8AmVbzCZFLRh14R5
 75OgLn+h9yo5Q2Mu7TocUsQy3NuNSunLJUPqEyyePCYBAF0kZy4Ye44vAXbr6vS/mK5F
 xVYexc4uGafthATWBb4QxFn497ax2CyiSBE5peDRBVDC6coKO0wjRWV7R8pszSmBlC2o
 MBFewIJWtnCwfed6hD7I5NndZLQ4TF8Z1UbH+tTqDzlhxxXsGUNWwuNdTeprFgKYZ1Gd
 Z7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287726; x=1788892526;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rCI6ALSqHSesKNWjBfSzIvjUYJzDYaGxkANBnpkHdg=;
 b=PXYH+8M7JOttnXTvbSgtfmIq2vm50eAGufmcxKwf5PollYc7OZVadS6UWoc3X80l9x
 Kf4C4rWDaXdA1S51Sa4+/Aq7GpbKj6WZqGTTzp5u9M/BugxLyuktFdRgXy8Vyxb4zAuE
 3dYe7h34aVnBP13u2r57u3WHPkO7ZZuhmrr6NBcNPs4x98zmPahV+2YmUqtmp/SqU78I
 r8OMMQxusANyXwmEqHuZXovxMrnYxbSGw8y+GpwIT277zc8KVhhNjawIE6vw5irhhBaP
 0tiQmen03f81N+Gw8621bi2yY5rgwVfxUzBiRG773pQ0w0c3C20q+hihul14YgO7AfFE
 IVjQ==
X-Gm-Message-State: AFuF++nWoDP14n6iJIP1pqwp2st0QhVOw3XJnSIx697LZQI00kCcfTuL
 YE0PmxlylPGXTBcFo0ZgHWouQTKaEd++f5Or3YyshI0DdQ6H4O9Gs3gxHbpUNyQiE8c=
X-Gm-Gg: AYBFou0NY4lm9FIYVn4A1btC+dc8FvWOK0UWKwxc0Tt1QZMNPKaheAmSQxgwM30iYxk
 JQBWcVekPxXK4XQt5nzjCj+QFI+7vkRcsn8q3/Cmq5YsQWYkgl6Ommt9KOGUiz9HbjJk+LWyaWS
 9FE5HQKDUXGNSWSFKFSgIcp5Kf5vlT0PlEcNjStJhcWgKALbdCgwjYrKdje/qe8oPB/YtkzcXxS
 /prMAwYo30JPf54kM9Od2DbHQyc5bxIWwIPfOtCi6Kpz+xFdvLwwRYENNlCURRGTY9iDfe+/YTy
 Dfbm9LgpJA/oXqSH5hwKkVOrWcLbLU/1HewbFzKcAa04eSY85PWj1Sr+OhoOw8CFedNTJjTNYBH
 XgQOCajAHt+YG3cT8F2ObU4jKrlCMj0K9sG2fHHJNLz0+M7SKAGP3Olp7bwXcP+7bP0wikFPFzi
 OaAf6gBj1FLARTaSB7J0Zt/CKencNpIlU+BHv/e0FaG+cf2R2ENLzIR9X21vdm
X-Received: by 2002:a05:6000:4b16:b0:481:50ae:df9a with SMTP id
 ffacd0b85a97d-484421d4083mr14246363f8f.9.1788287726201; 
 Tue, 01 Sep 2026 11:35:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492ce5e5sm661724f8f.36.2026.09.01.11.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:35:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59C405F829;
 Tue, 01 Sep 2026 19:35:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC v2 05/30] tests/tcg/arm: add Raspberry Pi Pico smoke
 tests
In-Reply-To: <20260829234308.33725-6-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:39 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-6-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 19:35:23 +0100
Message-ID: <87fqzsu8es.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Build Cortex-M0+ guest programs from assembly sources to exercise the
> minimal Pico boot path, UART0 output, and the Cortex-M0+ MPU. Keep the
> vector table at the XIP base so these tests match the initial
> synthetic boot stub without depending on boot2 or the later flash
> controller model.
>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  MAINTAINERS                            |   1 +
>  tests/tcg/arm/Makefile.softmmu-target  |  24 ++++

Just FYI there is an update coming to tests/tcg that converts the build
to meson. The change should be relatively mechanical to make.

>  tests/tcg/arm/system/rp2040-boot.S     |  30 ++++
>  tests/tcg/arm/system/rp2040-minimal.ld |  40 ++++++
>  tests/tcg/arm/system/rp2040-mpu.S      | 183 +++++++++++++++++++++++++
>  tests/tcg/arm/system/rp2040-mpu.ref    |   5 +
>  tests/tcg/arm/system/rp2040-uart.S     |  53 +++++++
>  tests/tcg/arm/system/rp2040-uart.ref   |   1 +
>  8 files changed, 337 insertions(+)
>  create mode 100644 tests/tcg/arm/system/rp2040-boot.S
>  create mode 100644 tests/tcg/arm/system/rp2040-minimal.ld
>  create mode 100644 tests/tcg/arm/system/rp2040-mpu.S
>  create mode 100644 tests/tcg/arm/system/rp2040-mpu.ref
>  create mode 100644 tests/tcg/arm/system/rp2040-uart.S
>  create mode 100644 tests/tcg/arm/system/rp2040-uart.ref
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fd7385d83..b000b3287d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1042,6 +1042,7 @@ S: Maintained
>  F: hw/*/rp2040*
>  F: include/hw/*/rp2040*
>  F: hw/arm/raspi_pico.c
> +F: tests/tcg/arm/system/rp2040*
>=20=20
>  Real View
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefi=
le.softmmu-target
> index 3e8a9b4073..429416ca58 100644
> --- a/tests/tcg/arm/Makefile.softmmu-target
> +++ b/tests/tcg/arm/Makefile.softmmu-target
> @@ -20,6 +20,30 @@ run-test-armv6m-undef: QEMU_OPTS=3D-semihosting-config=
 enable=3Don,target=3Dnative,cha
>=20=20
>  ARM_TESTS+=3Dtest-armv6m-undef
>=20=20
> +RP2040_TESTS=3Drp2040-boot rp2040-uart rp2040-mpu
> +
> +$(RP2040_TESTS): %: %.S rp2040-minimal.ld
> +	$(CC) -mcpu=3Dcortex-m0plus -mthumb -mfloat-abi=3Dsoft \
> +		-Wl,--build-id=3Dnone -x assembler-with-cpp \
> +		$< -o $@ -nostdlib -static \
> +		-T $(ARM_SRC)/rp2040-minimal.ld
> +
> +run-rp2040-boot: QEMU_OPTS=3D-M raspi-pico \
> +	-semihosting-config enable=3Don,target=3Dnative -kernel
> +
> +run-rp2040-uart run-rp2040-mpu: QEMU_OPTS=3D-M raspi-pico \
> +	-serial chardev:output \
> +	-semihosting-config enable=3Don,target=3Dnative -kernel
> +
> +run-rp2040-uart run-rp2040-mpu: run-rp2040-%: rp2040-%
> +	$(call run-test, $<, \
> +	  $(QEMU) -monitor none -display none \
> +		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
> +		  $(QEMU_OPTS) $<)
> +	$(call diff-out,$<,$(ARM_SRC)/$<.ref)
> +
> +ARM_TESTS+=3D$(RP2040_TESTS)
> +
>  # These objects provide the basic boot code and helper functions for all=
 tests
>  CRT_OBJS=3Dboot.o
>=20=20
> diff --git a/tests/tcg/arm/system/rp2040-boot.S b/tests/tcg/arm/system/rp=
2040-boot.S
> new file mode 100644
> index 0000000000..0537a54d44
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-boot.S
> @@ -0,0 +1,30 @@
> +/*
> + * Raspberry Pi Pico boot smoke test.
> + *
> + * Copyright 2026 Gilles Grimaud
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +.syntax unified
> +.cpu cortex-m0plus
> +.thumb
> +
> +#define SRAM_END 0x20042000
> +#define SYS_EXIT 0x18
> +#define ADP_STOPPED_APPLICATION_EXIT 0x20026
> +
> +.section .vectors, "a", %progbits
> +vector_table:
> +    .word SRAM_END
> +    .word reset_handler + 1
> +
> +.section .text, "ax", %progbits
> +.thumb_func
> +.global reset_handler
> +reset_handler:
> +    movs r0, SYS_EXIT
> +    ldr r1, =3DADP_STOPPED_APPLICATION_EXIT
> +    bkpt 0xab
> +
> +1:
> +    b 1b
> diff --git a/tests/tcg/arm/system/rp2040-minimal.ld b/tests/tcg/arm/syste=
m/rp2040-minimal.ld
> new file mode 100644
> index 0000000000..ebfbac8cf2
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-minimal.ld
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +ENTRY(reset_handler)
> +
> +MEMORY
> +{
> +    FLASH (rx) : ORIGIN =3D 0x10000000, LENGTH =3D 2M
> +    SRAM (rwx) : ORIGIN =3D 0x20000000, LENGTH =3D 264K
> +}
> +
> +SECTIONS
> +{
> +    .vectors ORIGIN(FLASH) :
> +    {
> +        KEEP(*(.vectors))
> +    } > FLASH
> +
> +    .text :
> +    {
> +        *(.text*)
> +        *(.rodata*)
> +    } > FLASH
> +
> +    .data :
> +    {
> +        *(.data*)
> +    } > SRAM AT > FLASH
> +
> +    .bss (NOLOAD) :
> +    {
> +        *(.bss*)
> +        *(COMMON)
> +    } > SRAM
> +
> +    /DISCARD/ :
> +    {
> +        *(.ARM.attributes)
> +        *(.comment)
> +    }
> +}
> diff --git a/tests/tcg/arm/system/rp2040-mpu.S b/tests/tcg/arm/system/rp2=
040-mpu.S
> new file mode 100644
> index 0000000000..a3aef55f5f
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-mpu.S
> @@ -0,0 +1,183 @@
> +/*
> + * Raspberry Pi Pico Cortex-M0+ MPU test.
> + *
> + * Copyright 2026 Gilles Grimaud
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +.syntax unified
> +.cpu cortex-m0plus
> +.thumb
> +
> +#define SRAM_END 0x20042000
> +#define TEST_ADDRESS 0x20001000
> +#define TEST_VALUE 0x12345678
> +#define UART0_DR 0x40034000
> +#define MPU_TYPE 0xe000ed90
> +#define MPU_CTRL 0xe000ed94
> +#define MPU_RNR 0xe000ed98
> +#define MPU_RBAR 0xe000ed9c
> +#define MPU_RASR 0xe000eda0
> +#define MPU_TYPE_DREGION_MASK 0x0000ff00
> +#define MPU_TYPE_DREGION_SHIFT 8
> +#define MPU_CTRL_ENABLE_PRIVDEFENA 0x05
> +#define MPU_RASR_SRAM_FULL_ACCESS 0x03000025
> +#define MPU_RASR_XIP_READ_ONLY 0x06000039
> +#define MPU_RASR_TEST_PRIV_RW 0x0100000f
> +#define SYS_EXIT 0x18
> +#define ADP_STOPPED_APPLICATION_EXIT 0x20026
> +#define ADP_STOPPED_RUNTIME_ERROR 0x20023
> +
> +.section .vectors, "a", %progbits
> +vector_table:
> +    .word SRAM_END
> +    .word reset_handler + 1
> +    .word default_handler + 1
> +    .word hardfault_handler + 1
> +
> +.section .text, "ax", %progbits
> +.thumb_func
> +.global reset_handler
> +reset_handler:
> +    ldr r0, =3Dstart_message
> +    bl puts
> +
> +    ldr r0, =3DMPU_TYPE
> +    ldr r0, [r0]
> +    ldr r1, =3DMPU_TYPE_DREGION_MASK
> +    ands r0, r1
> +    lsrs r0, r0, MPU_TYPE_DREGION_SHIFT
> +    cmp r0, 8
> +    bne fail_type
> +
> +    ldr r0, =3Dtype_message
> +    bl puts
> +
> +    ldr r4, =3DTEST_ADDRESS
> +    ldr r5, =3DTEST_VALUE
> +    str r5, [r4]
> +    ldr r0, [r4]
> +    cmp r0, r5
> +    bne fail_plain
> +
> +    ldr r0, =3Dplain_message
> +    bl puts
> +
> +    movs r0, 0
> +    ldr r1, =3D0x20000000
> +    ldr r2, =3DMPU_RASR_SRAM_FULL_ACCESS
> +    bl configure_region
> +
> +    movs r0, 1
> +    movs r1, 0
> +    ldr r2, =3DMPU_RASR_XIP_READ_ONLY
> +    bl configure_region
> +
> +    movs r0, 2
> +    ldr r1, =3DTEST_ADDRESS
> +    ldr r2, =3DMPU_RASR_TEST_PRIV_RW
> +    bl configure_region
> +
> +    ldr r0, =3DMPU_CTRL
> +    movs r1, MPU_CTRL_ENABLE_PRIVDEFENA
> +    str r1, [r0]
> +    dsb
> +    isb
> +
> +    ldr r0, [r4]
> +    cmp r0, r5
> +    bne fail_privileged
> +
> +    ldr r0, =3Dprivileged_message
> +    bl puts
> +
> +    movs r0, 1
> +    msr control, r0
> +    isb
> +
> +    ldr r0, [r4]
> +    ldr r0, =3Dfail_no_fault_message
> +    b test_failed
> +
> +.thumb_func
> +configure_region:
> +    ldr r3, =3DMPU_RNR
> +    str r0, [r3]
> +    ldr r3, =3DMPU_RBAR
> +    str r1, [r3]
> +    ldr r3, =3DMPU_RASR
> +    str r2, [r3]
> +    bx lr
> +
> +fail_type:
> +    ldr r0, =3Dfail_type_message
> +    b test_failed
> +
> +fail_plain:
> +    ldr r0, =3Dfail_plain_message
> +    b test_failed
> +
> +fail_privileged:
> +    ldr r0, =3Dfail_privileged_message
> +
> +test_failed:
> +    bl puts
> +    movs r0, SYS_EXIT
> +    ldr r1, =3DADP_STOPPED_RUNTIME_ERROR
> +    bkpt 0xab
> +
> +1:
> +    b 1b
> +
> +.thumb_func
> +hardfault_handler:
> +    ldr r0, =3Dok_message
> +    bl puts
> +    movs r0, SYS_EXIT
> +    ldr r1, =3DADP_STOPPED_APPLICATION_EXIT
> +    bkpt 0xab
> +
> +2:
> +    b 2b
> +
> +.thumb_func
> +default_handler:
> +    ldr r0, =3Dfail_exception_message
> +    b test_failed
> +
> +.thumb_func
> +puts:
> +    ldr r2, =3DUART0_DR
> +
> +3:
> +    ldrb r1, [r0]
> +    cmp r1, 0
> +    beq 4f
> +    str r1, [r2]
> +    adds r0, 1
> +    b 3b
> +
> +4:
> +    bx lr
> +
> +.section .rodata, "a", %progbits
> +start_message:
> +    .asciz "PICO TCG MPU START\n"
> +type_message:
> +    .asciz "PICO TCG MPU TYPE\n"
> +plain_message:
> +    .asciz "PICO TCG MPU PLAIN\n"
> +privileged_message:
> +    .asciz "PICO TCG MPU PRIV\n"
> +ok_message:
> +    .asciz "PICO TCG MPU OK\n"
> +fail_type_message:
> +    .asciz "PICO TCG MPU FAIL: TYPE\n"
> +fail_plain_message:
> +    .asciz "PICO TCG MPU FAIL: PLAIN\n"
> +fail_privileged_message:
> +    .asciz "PICO TCG MPU FAIL: PRIV\n"
> +fail_no_fault_message:
> +    .asciz "PICO TCG MPU FAIL: NOFAULT\n"
> +fail_exception_message:
> +    .asciz "PICO TCG MPU FAIL: EXCEPTION\n"
> diff --git a/tests/tcg/arm/system/rp2040-mpu.ref b/tests/tcg/arm/system/r=
p2040-mpu.ref
> new file mode 100644
> index 0000000000..e55590ea16
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-mpu.ref
> @@ -0,0 +1,5 @@
> +PICO TCG MPU START
> +PICO TCG MPU TYPE
> +PICO TCG MPU PLAIN
> +PICO TCG MPU PRIV
> +PICO TCG MPU OK
> diff --git a/tests/tcg/arm/system/rp2040-uart.S b/tests/tcg/arm/system/rp=
2040-uart.S
> new file mode 100644
> index 0000000000..bdb58cc7f2
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-uart.S
> @@ -0,0 +1,53 @@
> +/*
> + * Raspberry Pi Pico UART boot smoke test.
> + *
> + * Copyright 2026 Gilles Grimaud
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +.syntax unified
> +.cpu cortex-m0plus
> +.thumb
> +
> +#define SRAM_END 0x20042000
> +#define UART0_DR 0x40034000
> +#define SYS_EXIT 0x18
> +#define ADP_STOPPED_APPLICATION_EXIT 0x20026
> +
> +.section .vectors, "a", %progbits
> +vector_table:
> +    .word SRAM_END
> +    .word reset_handler + 1
> +    .word default_handler + 1
> +    .word default_handler + 1
> +
> +.section .text, "ax", %progbits
> +.thumb_func
> +.global reset_handler
> +reset_handler:
> +    ldr r0, =3DUART0_DR
> +    ldr r1, =3Dmessage
> +
> +1:
> +    ldrb r2, [r1]
> +    cmp r2, 0
> +    beq 2f
> +    str r2, [r0]
> +    adds r1, 1
> +    b 1b
> +
> +2:
> +    movs r0, SYS_EXIT
> +    ldr r1, =3DADP_STOPPED_APPLICATION_EXIT
> +    bkpt 0xab
> +
> +3:
> +    b 3b
> +
> +.thumb_func
> +default_handler:
> +    b default_handler
> +
> +.section .rodata, "a", %progbits
> +message:
> +    .asciz "PICO TCG UART OK\n"
> diff --git a/tests/tcg/arm/system/rp2040-uart.ref b/tests/tcg/arm/system/=
rp2040-uart.ref
> new file mode 100644
> index 0000000000..1ef16e8299
> --- /dev/null
> +++ b/tests/tcg/arm/system/rp2040-uart.ref
> @@ -0,0 +1 @@
> +PICO TCG UART OK

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

