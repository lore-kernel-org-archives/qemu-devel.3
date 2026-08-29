Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B928CC61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiN-00085G-9t; Sat, 29 Aug 2026 19:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiM-00084g-41; Sat, 29 Aug 2026 19:43:58 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiK-0006DI-2P; Sat, 29 Aug 2026 19:43:57 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzb6syjzBqXf;
 Sun, 30 Aug 2026 01:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047020;
 bh=9iAgLGXyWoTTI0QSPHKdEKH5qEMaoF2aVyd4k8UxUSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZcnznBlTAyAsrpNtQ2XyfPHtm0kmGzUo/8n8rw+htDM4SWR6u/oW68BI3GM36y5rK
 t7k/i9hFX4k1qfJEzlVM/vuwlMJPq1Hbf8QpwDVDfHQcZbFbPW3RnczugpvYeRH1lQ
 B3tkMOCrw7fev+jPDcXN1nMn5JQIKgX/TB3frA1muuj0PX6GVska0zUaIG9Z8POZQ5
 cHVnNVmvCQnE0poz8gK9HBtwSVg5wjTBmOZ7a6YbqT+nAYuGcUjxAf0I5e+tjfVEkv
 xzWZDSI4CnYNQX88x2OkuKWVou2Gnc0yhQJkozfVTaVb1KSyG2FWykudwlSO+F3Mod
 KRJSqvBX3MPUQ==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzb53KHz7vrV;
 Sun, 30 Aug 2026 01:43:39 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RFC v2 05/30] tests/tcg/arm: add Raspberry Pi Pico smoke tests
Date: Sun, 30 Aug 2026 01:42:39 +0200
Message-ID: <20260829234308.33725-6-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Build Cortex-M0+ guest programs from assembly sources to exercise the minimal Pico boot path, UART0 output, and the Cortex-M0+ MPU. Keep the vector table at the XIP base so these tests match the initial synthetic boot stub without depending on boot2 or the later flash controller model.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS                            |   1 +
 tests/tcg/arm/Makefile.softmmu-target  |  24 ++++
 tests/tcg/arm/system/rp2040-boot.S     |  30 ++++
 tests/tcg/arm/system/rp2040-minimal.ld |  40 ++++++
 tests/tcg/arm/system/rp2040-mpu.S      | 183 +++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-mpu.ref    |   5 +
 tests/tcg/arm/system/rp2040-uart.S     |  53 +++++++
 tests/tcg/arm/system/rp2040-uart.ref   |   1 +
 8 files changed, 337 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-boot.S
 create mode 100644 tests/tcg/arm/system/rp2040-minimal.ld
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.S
 create mode 100644 tests/tcg/arm/system/rp2040-mpu.ref
 create mode 100644 tests/tcg/arm/system/rp2040-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-uart.ref

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fd7385d83..b000b3287d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1042,6 +1042,7 @@ S: Maintained
 F: hw/*/rp2040*
 F: include/hw/*/rp2040*
 F: hw/arm/raspi_pico.c
+F: tests/tcg/arm/system/rp2040*
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 3e8a9b4073..429416ca58 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -20,6 +20,30 @@ run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,cha
 
 ARM_TESTS+=test-armv6m-undef
 
+RP2040_TESTS=rp2040-boot rp2040-uart rp2040-mpu
+
+$(RP2040_TESTS): %: %.S rp2040-minimal.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-Wl,--build-id=none -x assembler-with-cpp \
+		$< -o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040-minimal.ld
+
+run-rp2040-boot: QEMU_OPTS=-M raspi-pico \
+	-semihosting-config enable=on,target=native -kernel
+
+run-rp2040-uart run-rp2040-mpu: QEMU_OPTS=-M raspi-pico \
+	-serial chardev:output \
+	-semihosting-config enable=on,target=native -kernel
+
+run-rp2040-uart run-rp2040-mpu: run-rp2040-%: rp2040-%
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  $(QEMU_OPTS) $<)
+	$(call diff-out,$<,$(ARM_SRC)/$<.ref)
+
+ARM_TESTS+=$(RP2040_TESTS)
+
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
diff --git a/tests/tcg/arm/system/rp2040-boot.S b/tests/tcg/arm/system/rp2040-boot.S
new file mode 100644
index 0000000000..0537a54d44
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-boot.S
@@ -0,0 +1,30 @@
+/*
+ * Raspberry Pi Pico boot smoke test.
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
+#define SYS_EXIT 0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+
+.section .vectors, "a", %progbits
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
diff --git a/tests/tcg/arm/system/rp2040-minimal.ld b/tests/tcg/arm/system/rp2040-minimal.ld
new file mode 100644
index 0000000000..ebfbac8cf2
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-minimal.ld
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+ENTRY(reset_handler)
+
+MEMORY
+{
+    FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 2M
+    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
+}
+
+SECTIONS
+{
+    .vectors ORIGIN(FLASH) :
+    {
+        KEEP(*(.vectors))
+    } > FLASH
+
+    .text :
+    {
+        *(.text*)
+        *(.rodata*)
+    } > FLASH
+
+    .data :
+    {
+        *(.data*)
+    } > SRAM AT > FLASH
+
+    .bss (NOLOAD) :
+    {
+        *(.bss*)
+        *(COMMON)
+    } > SRAM
+
+    /DISCARD/ :
+    {
+        *(.ARM.attributes)
+        *(.comment)
+    }
+}
diff --git a/tests/tcg/arm/system/rp2040-mpu.S b/tests/tcg/arm/system/rp2040-mpu.S
new file mode 100644
index 0000000000..a3aef55f5f
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-mpu.S
@@ -0,0 +1,183 @@
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
+    bne fail_type
+
+    ldr r0, =type_message
+    bl puts
+
+    ldr r4, =TEST_ADDRESS
+    ldr r5, =TEST_VALUE
+    str r5, [r4]
+    ldr r0, [r4]
+    cmp r0, r5
+    bne fail_plain
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
+    ldr r0, =MPU_CTRL
+    movs r1, MPU_CTRL_ENABLE_PRIVDEFENA
+    str r1, [r0]
+    dsb
+    isb
+
+    ldr r0, [r4]
+    cmp r0, r5
+    bne fail_privileged
+
+    ldr r0, =privileged_message
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
+fail_plain:
+    ldr r0, =fail_plain_message
+    b test_failed
+
+fail_privileged:
+    ldr r0, =fail_privileged_message
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
+plain_message:
+    .asciz "PICO TCG MPU PLAIN\n"
+privileged_message:
+    .asciz "PICO TCG MPU PRIV\n"
+ok_message:
+    .asciz "PICO TCG MPU OK\n"
+fail_type_message:
+    .asciz "PICO TCG MPU FAIL: TYPE\n"
+fail_plain_message:
+    .asciz "PICO TCG MPU FAIL: PLAIN\n"
+fail_privileged_message:
+    .asciz "PICO TCG MPU FAIL: PRIV\n"
+fail_no_fault_message:
+    .asciz "PICO TCG MPU FAIL: NOFAULT\n"
+fail_exception_message:
+    .asciz "PICO TCG MPU FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-mpu.ref b/tests/tcg/arm/system/rp2040-mpu.ref
new file mode 100644
index 0000000000..e55590ea16
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-mpu.ref
@@ -0,0 +1,5 @@
+PICO TCG MPU START
+PICO TCG MPU TYPE
+PICO TCG MPU PLAIN
+PICO TCG MPU PRIV
+PICO TCG MPU OK
diff --git a/tests/tcg/arm/system/rp2040-uart.S b/tests/tcg/arm/system/rp2040-uart.S
new file mode 100644
index 0000000000..bdb58cc7f2
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-uart.S
@@ -0,0 +1,53 @@
+/*
+ * Raspberry Pi Pico UART boot smoke test.
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
+#define UART0_DR 0x40034000
+#define SYS_EXIT 0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+
+.section .vectors, "a", %progbits
+vector_table:
+    .word SRAM_END
+    .word reset_handler + 1
+    .word default_handler + 1
+    .word default_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =UART0_DR
+    ldr r1, =message
+
+1:
+    ldrb r2, [r1]
+    cmp r2, 0
+    beq 2f
+    str r2, [r0]
+    adds r1, 1
+    b 1b
+
+2:
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+3:
+    b 3b
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.section .rodata, "a", %progbits
+message:
+    .asciz "PICO TCG UART OK\n"
diff --git a/tests/tcg/arm/system/rp2040-uart.ref b/tests/tcg/arm/system/rp2040-uart.ref
new file mode 100644
index 0000000000..1ef16e8299
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-uart.ref
@@ -0,0 +1 @@
+PICO TCG UART OK
-- 
2.55.0


