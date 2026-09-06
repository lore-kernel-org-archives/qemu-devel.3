Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26969C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Ina-0002Mb-Pn; Sun, 06 Sep 2026 15:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InZ-0002LO-A6; Sun, 06 Sep 2026 15:45:05 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InX-0006yh-83; Sun, 06 Sep 2026 15:45:05 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdLJB1LxHzBqYv;
 Sun,  6 Sep 2026 21:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723882;
 bh=TVKZcpQtv/u3uNqIDM8XyVI/mY5xzdqkE/AT2tor87E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KBSwqjrvT43dVk5ihvDtK7Jr7QGFJumvy+AbmvJZ0/QpMkK5f6CMHnrVVOh06dp97
 IaFzKhh4BnWe8DwQRncU2OwDXzhl2sYVNsDuhQFh5OXrHo/uggjcVaUMLOKxsyz92B
 Gz667hqpyN1Bvs5Qtxl+yTzJ1vjwKOMVuqG7oSfz0P+eIDJ1t18CAME7QpqGA8Mhmq
 H0BPXx53WJWP4sFxns1HADSuU7BTel+RnDYCDMvykyRuYIRmGDY4n6ZB3n7+GGiD2M
 wTdTsyE8MtGZLocEZJJQbgKdF27VPAeJgStqQ6P8HcK4ypEB3IihCNwpBvW2wmDDt0
 xAnVOgSZ+8InQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ96kfhz7wHs;
 Sun,  6 Sep 2026 21:44:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 08/36] tests/tcg/arm: test the RP2040 Cortex-M0+ MPU
Date: Sun,  6 Sep 2026 21:44:07 +0200
Message-ID: <20260906194438.93046-9-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add focused execution tests for the optional Armv6-M MPU exposed by the
RP2040 Cortex-M0+ cores.

Check register reset and readback, privileged and unprivileged accesses,
the 256-byte minimum region size, overlapping-region priority, subregion
disabling, and escalation of an MPU violation to HardFault.

The test runs after the generic Armv6-M CONTROL.nPRIV prerequisite and the
RP2040 machine have both been introduced.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/system/meson.build    |   5 +
 tests/tcg/arm/system/rp2040-mpu.S   | 356 ++++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-mpu.ref |  10 +
 3 files changed, 371 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.S
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.ref

diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 42e7614a11..a959830b1c 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -65,6 +65,11 @@ tests += {
     'qemu_args': ['-serial', 'stdio', rp2040_qemu_args],
     'expected_output': 'rp2040-uart.ref',
   },
+  'rp2040-mpu.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': ['-serial', 'stdio', rp2040_qemu_args],
+    'expected_output': 'rp2040-mpu.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/rp2040-mpu.S b/tests/tcg/arm/system/rp2040-mpu.S
new file mode 100644
index 0000000000..5cc98f3d0e
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-mpu.S
@@ -0,0 +1,356 @@
+/*
+ * Raspberry Pi Pico Cortex-M0+ MPU test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END 0x20042000
+#define TEST_ADDRESS 0x20001000
+#define TEST_VALUE 0x12345678
+#define UART0_DR 0x40034000
+#define MPU_TYPE 0xe000ed90
+#define MPU_CTRL 0xe000ed94
+#define MPU_RNR 0xe000ed98
+#define MPU_RBAR 0xe000ed9c
+#define MPU_RASR 0xe000eda0
+#define MPU_TYPE_DREGION_MASK 0x0000ff00
+#define MPU_TYPE_DREGION_SHIFT 8
+#define MPU_CTRL_ENABLE_PRIVDEFENA 0x05
+#define MPU_RASR_SRAM_FULL_ACCESS 0x03000025
+#define MPU_RASR_XIP_READ_ONLY 0x06000039
+#define MPU_RASR_TEST_PRIV_RW 0x0100000f
+#define MPU_RASR_TEST_NO_ACCESS_32B 0x00000009
+#define MPU_RASR_TEST_NO_ACCESS_256B 0x0000000f
+#define MPU_RASR_TEST_SUBREGION0_OFF 0x0000010f
+#define SYS_EXIT 0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR 0x20023
+
+.section .vectors, "a", %progbits
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word default_handler + 1
+    .word hardfault_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =start_message
+    bl puts
+
+    ldr r0, =MPU_TYPE
+    ldr r0, [r0]
+    ldr r1, =MPU_TYPE_DREGION_MASK
+    ands r0, r1
+    lsrs r0, r0, MPU_TYPE_DREGION_SHIFT
+    cmp r0, 8
+    beq 1f
+    b fail_type
+1:
+
+    ldr r0, =type_message
+    bl puts
+
+    ldr r0, =MPU_CTRL
+    ldr r1, [r0]
+    cmp r1, 0
+    beq 1f
+    b fail_reset
+1:
+    ldr r0, =MPU_RNR
+    ldr r1, [r0]
+    cmp r1, 0
+    beq 1f
+    b fail_reset
+1:
+    ldr r0, =MPU_RBAR
+    ldr r1, [r0]
+    cmp r1, 0
+    beq 1f
+    b fail_reset
+1:
+    ldr r0, =MPU_RASR
+    ldr r1, [r0]
+    cmp r1, 0
+    beq 1f
+    b fail_reset
+1:
+
+    ldr r0, =reset_message
+    bl puts
+
+    ldr r4, =TEST_ADDRESS
+    ldr r5, =TEST_VALUE
+    str r5, [r4]
+    ldr r0, [r4]
+    cmp r0, r5
+    beq 1f
+    b fail_plain
+1:
+
+    ldr r0, =plain_message
+    bl puts
+
+    movs r0, 0
+    ldr r1, =0x20000000
+    ldr r2, =MPU_RASR_SRAM_FULL_ACCESS
+    bl configure_region
+
+    movs r0, 1
+    movs r1, 0
+    ldr r2, =MPU_RASR_XIP_READ_ONLY
+    bl configure_region
+
+    movs r0, 2
+    ldr r1, =TEST_ADDRESS
+    ldr r2, =MPU_RASR_TEST_PRIV_RW
+    bl configure_region
+
+    ldr r0, =MPU_RNR
+    ldr r0, [r0]
+    cmp r0, 2
+    beq 1f
+    b fail_registers
+1:
+    ldr r0, =MPU_RBAR
+    ldr r0, [r0]
+    ldr r1, =(TEST_ADDRESS | 2)
+    cmp r0, r1
+    beq 1f
+    b fail_registers
+1:
+    ldr r0, =MPU_RASR
+    ldr r0, [r0]
+    ldr r1, =MPU_RASR_TEST_PRIV_RW
+    cmp r0, r1
+    beq 1f
+    b fail_registers
+1:
+
+    ldr r0, =registers_message
+    bl puts
+
+    ldr r0, =MPU_CTRL
+    movs r1, MPU_CTRL_ENABLE_PRIVDEFENA
+    str r1, [r0]
+    dsb
+    isb
+
+    ldr r0, [r4]
+    cmp r0, r5
+    beq 1f
+    b fail_privileged
+1:
+
+    ldr r0, =privileged_message
+    bl puts
+
+    movs r0, 3
+    ldr r1, =TEST_ADDRESS
+    ldr r2, =MPU_RASR_TEST_NO_ACCESS_32B
+    bl configure_region
+    dsb
+    isb
+    ldr r0, [r4]
+    cmp r0, r5
+    beq 1f
+    b fail_min_size
+1:
+
+    ldr r0, =min_size_message
+    bl puts
+
+    ldr r0, =fault_phase
+    movs r1, 1
+    str r1, [r0]
+    movs r0, 3
+    ldr r1, =TEST_ADDRESS
+    ldr r2, =MPU_RASR_TEST_NO_ACCESS_256B
+    bl configure_region
+    dsb
+    isb
+    ldr r0, [r4]
+    ldr r1, =fault_phase
+    ldr r1, [r1]
+    cmp r1, 0
+    beq 1f
+    b fail_priority
+1:
+
+    ldr r0, =priority_message
+    bl puts
+
+    movs r0, 3
+    ldr r1, =TEST_ADDRESS
+    ldr r2, =MPU_RASR_TEST_SUBREGION0_OFF
+    bl configure_region
+    dsb
+    isb
+    ldr r0, [r4]
+    cmp r0, r5
+    beq 1f
+    b fail_subregion
+1:
+
+    ldr r0, =subregion_message
+    bl puts
+
+    movs r0, 1
+    msr control, r0
+    isb
+
+    ldr r0, [r4]
+    ldr r0, =fail_no_fault_message
+    b test_failed
+
+.thumb_func
+configure_region:
+    ldr r3, =MPU_RNR
+    str r0, [r3]
+    ldr r3, =MPU_RBAR
+    str r1, [r3]
+    ldr r3, =MPU_RASR
+    str r2, [r3]
+    bx lr
+
+fail_type:
+    ldr r0, =fail_type_message
+    b test_failed
+
+fail_reset:
+    ldr r0, =fail_reset_message
+    b test_failed
+
+fail_registers:
+    ldr r0, =fail_registers_message
+    b test_failed
+
+fail_plain:
+    ldr r0, =fail_plain_message
+    b test_failed
+
+fail_privileged:
+    ldr r0, =fail_privileged_message
+    b test_failed
+
+fail_min_size:
+    ldr r0, =fail_min_size_message
+    b test_failed
+
+fail_priority:
+    ldr r0, =fail_priority_message
+    b test_failed
+
+fail_subregion:
+    ldr r0, =fail_subregion_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+1:
+    b 1b
+
+.thumb_func
+hardfault_handler:
+    ldr r0, =fault_phase
+    ldr r1, [r0]
+    cmp r1, 0
+    beq hardfault_done
+    movs r1, 0
+    str r1, [r0]
+    ldr r0, =MPU_RNR
+    movs r1, 3
+    str r1, [r0]
+    ldr r0, =MPU_RASR
+    movs r1, 0
+    str r1, [r0]
+    dsb
+    isb
+    bx lr
+
+hardfault_done:
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+2:
+    b 2b
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_exception_message
+    b test_failed
+
+.thumb_func
+puts:
+    ldr r2, =UART0_DR
+
+3:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 4f
+    str r1, [r2]
+    adds r0, 1
+    b 3b
+
+4:
+    bx lr
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG MPU START\n"
+type_message:
+    .asciz "PICO TCG MPU TYPE\n"
+reset_message:
+    .asciz "PICO TCG MPU RESET\n"
+plain_message:
+    .asciz "PICO TCG MPU PLAIN\n"
+registers_message:
+    .asciz "PICO TCG MPU REGISTERS\n"
+privileged_message:
+    .asciz "PICO TCG MPU PRIV\n"
+min_size_message:
+    .asciz "PICO TCG MPU MIN SIZE\n"
+priority_message:
+    .asciz "PICO TCG MPU PRIORITY\n"
+subregion_message:
+    .asciz "PICO TCG MPU SUBREGION\n"
+ok_message:
+    .asciz "PICO TCG MPU OK\n"
+fail_type_message:
+    .asciz "PICO TCG MPU FAIL: TYPE\n"
+fail_reset_message:
+    .asciz "PICO TCG MPU FAIL: RESET\n"
+fail_plain_message:
+    .asciz "PICO TCG MPU FAIL: PLAIN\n"
+fail_registers_message:
+    .asciz "PICO TCG MPU FAIL: REGISTERS\n"
+fail_privileged_message:
+    .asciz "PICO TCG MPU FAIL: PRIV\n"
+fail_min_size_message:
+    .asciz "PICO TCG MPU FAIL: MIN SIZE\n"
+fail_priority_message:
+    .asciz "PICO TCG MPU FAIL: PRIORITY\n"
+fail_subregion_message:
+    .asciz "PICO TCG MPU FAIL: SUBREGION\n"
+fail_no_fault_message:
+    .asciz "PICO TCG MPU FAIL: NOFAULT\n"
+fail_exception_message:
+    .asciz "PICO TCG MPU FAIL: EXCEPTION\n"
+
+.section .bss, "aw", %nobits
+.align 2
+fault_phase:
+    .word 0
diff --git a/tests/tcg/arm/system/rp2040-mpu.ref b/tests/tcg/arm/system/rp2040-mpu.ref
new file mode 100644
index 0000000000..d3938add02
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-mpu.ref
@@ -0,0 +1,10 @@
+PICO TCG MPU START
+PICO TCG MPU TYPE
+PICO TCG MPU RESET
+PICO TCG MPU PLAIN
+PICO TCG MPU REGISTERS
+PICO TCG MPU PRIV
+PICO TCG MPU MIN SIZE
+PICO TCG MPU PRIORITY
+PICO TCG MPU SUBREGION
+PICO TCG MPU OK
-- 
2.55.0


