Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0206C61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yr7-0002QI-LU; Sun, 30 Aug 2026 02:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yr5-0002Op-ER; Sun, 30 Aug 2026 02:17:23 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yr2-0005Fh-50; Sun, 30 Aug 2026 02:17:23 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXhjn3FXbz8338;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070637;
 bh=eS13Ssqri4iRX6kVa315iV+PIAJEgv3FuAsoOCa5nzQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U/o36QRHS8BGBD6XGgY2OqGI6Jyz8hRNF45w4tTW7jaIJjpa77U2eEcF/tCnZliul
 lAoH7+KCRgd5V0cik1BS012vqVgLzyGKBfH8newld0aoj8iO+ebZ5f/xPtdDHjVcS1
 rIFMnQy+PWG98UJbbRo9vIU71mAOvxBwNt1oJtIWVO9abaCIYlC2jLedES6qUoKNOJ
 rXpT3TreKFwtv9Ch9UV3nJfE24jOpmX3rErOXRK+v/aDr++rDeCaG0OOJiLOZ4x47Q
 0/trlGj8nhXdccvEMllNq7tOdscnot0K+Xw1W+0S5o+zqLRRiYBTlPsCkZF8O8h4L4
 qt2BpQguruh9g==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjn1nSMz7swM;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 17/30] tests/tcg/arm: test RP2040 SIO and multicore
Date: Sun, 30 Aug 2026 08:15:48 +0200
Message-ID: <20260830061601.52136-3-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/Makefile.softmmu-target        |  13 +-
 tests/tcg/arm/system/rp2040-core1-launch.S   | 216 +++++++++++++++++++
 tests/tcg/arm/system/rp2040-core1-launch.ref |   4 +
 tests/tcg/arm/system/rp2040-psm-proc1.S      | 143 ++++++++++++
 tests/tcg/arm/system/rp2040-psm-proc1.ref    |   5 +
 tests/tcg/arm/system/rp2040-sio-divider.S    | 169 +++++++++++++++
 tests/tcg/arm/system/rp2040-sio-divider.ref  |   2 +
 tests/tcg/arm/system/rp2040-sio-fifo.S       | 154 +++++++++++++
 tests/tcg/arm/system/rp2040-sio-fifo.ref     |   2 +
 9 files changed, 705 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/arm/system/rp2040-core1-launch.S
 create mode 100644 tests/tcg/arm/system/rp2040-core1-launch.ref
 create mode 100644 tests/tcg/arm/system/rp2040-psm-proc1.S
 create mode 100644 tests/tcg/arm/system/rp2040-psm-proc1.ref
 create mode 100644 tests/tcg/arm/system/rp2040-sio-divider.S
 create mode 100644 tests/tcg/arm/system/rp2040-sio-divider.ref
 create mode 100644 tests/tcg/arm/system/rp2040-sio-fifo.S
 create mode 100644 tests/tcg/arm/system/rp2040-sio-fifo.ref

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 429416ca58..28e4c5774a 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -20,7 +20,9 @@ run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,cha
 
 ARM_TESTS+=test-armv6m-undef
 
-RP2040_TESTS=rp2040-boot rp2040-uart rp2040-mpu
+RP2040_TESTS=rp2040-boot rp2040-uart rp2040-mpu \
+	rp2040-sio-fifo rp2040-sio-divider rp2040-psm-proc1 \
+	rp2040-core1-launch
 
 $(RP2040_TESTS): %: %.S rp2040-minimal.ld
 	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
@@ -31,11 +33,16 @@ $(RP2040_TESTS): %: %.S rp2040-minimal.ld
 run-rp2040-boot: QEMU_OPTS=-M raspi-pico \
 	-semihosting-config enable=on,target=native -kernel
 
-run-rp2040-uart run-rp2040-mpu: QEMU_OPTS=-M raspi-pico \
+run-rp2040-uart run-rp2040-mpu \
+run-rp2040-sio-fifo run-rp2040-sio-divider \
+run-rp2040-psm-proc1 run-rp2040-core1-launch: \
+	QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
 	-serial chardev:output \
 	-semihosting-config enable=on,target=native -kernel
 
-run-rp2040-uart run-rp2040-mpu: run-rp2040-%: rp2040-%
+run-rp2040-uart run-rp2040-mpu \
+run-rp2040-sio-fifo run-rp2040-sio-divider \
+run-rp2040-psm-proc1 run-rp2040-core1-launch: run-rp2040-%: rp2040-%
 	$(call run-test, $<, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
diff --git a/tests/tcg/arm/system/rp2040-core1-launch.S b/tests/tcg/arm/system/rp2040-core1-launch.S
new file mode 100644
index 0000000000..a280014b3c
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core1-launch.S
@@ -0,0 +1,216 @@
+/*
+ * Raspberry Pi Pico core 1 mask-ROM launch protocol test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define CORE1_STACK            0x20041000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_CPUID              0x00
+#define SIO_FIFO_ST            0x50
+#define SIO_FIFO_WR            0x54
+#define SIO_FIFO_RD            0x58
+#define SIO_FIFO_ST_VLD        0x01
+#define SIO_FIFO_ST_RDY        0x02
+#define CORE1_ACK              0x0000d01e
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.section .vectors, "a", %progbits
+.global vector_table
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
+    ldr r0, =start_message
+    bl puts
+
+    ldr r4, =SIO_BASE
+    ldr r0, [r4, SIO_CPUID]
+    cmp r0, 0
+    bne fail_core0_id
+
+    ldr r6, =launch_sequence
+    movs r7, 0
+
+launch_next:
+    ldr r0, [r6, r7]
+    cmp r0, 0
+    bne launch_send
+    bl fifo_drain
+    sev
+
+launch_send:
+    bl fifo_push
+    bl fifo_pop
+    ldr r1, [r6, r7]
+    cmp r0, r1
+    bne fail_echo
+    adds r7, 4
+    cmp r7, 24
+    bne launch_next
+
+    ldr r0, =echo_message
+    bl puts
+
+    bl fifo_pop
+    ldr r1, =CORE1_ACK
+    cmp r0, r1
+    bne fail_ack
+
+    ldr r0, =ack_message
+    bl puts
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+.thumb_func
+core1_entry:
+    ldr r4, =SIO_BASE
+    ldr r0, [r4, SIO_CPUID]
+    cmp r0, 1
+    bne core1_failed
+    bl core1_send_ack
+
+2:
+    b 2b
+
+.thumb_func
+core1_send_ack:
+    push {lr}
+    ldr r0, =CORE1_ACK
+    bl fifo_push
+    pop {pc}
+
+core1_failed:
+    ldr r0, =0xbad10001
+    bl fifo_push
+
+3:
+    b 3b
+
+.thumb_func
+fifo_drain:
+    push {r0, r1, lr}
+
+4:
+    ldr r0, [r4, SIO_FIFO_ST]
+    movs r1, SIO_FIFO_ST_VLD
+    tst r0, r1
+    beq 5f
+    ldr r0, [r4, SIO_FIFO_RD]
+    b 4b
+
+5:
+    pop {r0, r1, pc}
+
+.thumb_func
+fifo_push:
+    push {r1, r2, lr}
+
+6:
+    ldr r1, [r4, SIO_FIFO_ST]
+    movs r2, SIO_FIFO_ST_RDY
+    tst r1, r2
+    beq 6b
+    str r0, [r4, SIO_FIFO_WR]
+    sev
+    pop {r1, r2, pc}
+
+.thumb_func
+fifo_pop:
+    push {r1, lr}
+
+7:
+    ldr r1, [r4, SIO_FIFO_ST]
+    movs r0, SIO_FIFO_ST_VLD
+    tst r1, r0
+    beq 7b
+    ldr r0, [r4, SIO_FIFO_RD]
+    pop {r1, pc}
+
+fail_core0_id:
+    ldr r0, =fail_core0_id_message
+    b test_failed
+
+fail_echo:
+    ldr r0, =fail_echo_message
+    b test_failed
+
+fail_ack:
+    ldr r0, =fail_ack_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+8:
+    b 8b
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
+9:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 10f
+    str r1, [r2]
+    adds r0, 1
+    b 9b
+
+10:
+    bx lr
+
+.section .rodata, "a", %progbits
+.align 2
+launch_sequence:
+    .word 0
+    .word 0
+    .word 1
+    .word vector_table
+    .word CORE1_STACK
+    .word core1_entry + 1
+
+start_message:
+    .asciz "PICO TCG CORE1 START\n"
+echo_message:
+    .asciz "PICO TCG CORE1 ECHO OK\n"
+ack_message:
+    .asciz "PICO TCG CORE1 ACK OK\n"
+ok_message:
+    .asciz "PICO TCG CORE1 OK\n"
+fail_core0_id_message:
+    .asciz "PICO TCG CORE1 FAIL: CORE0 ID\n"
+fail_echo_message:
+    .asciz "PICO TCG CORE1 FAIL: ECHO\n"
+fail_ack_message:
+    .asciz "PICO TCG CORE1 FAIL: ACK\n"
+fail_exception_message:
+    .asciz "PICO TCG CORE1 FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-core1-launch.ref b/tests/tcg/arm/system/rp2040-core1-launch.ref
new file mode 100644
index 0000000000..b9f9d4252d
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core1-launch.ref
@@ -0,0 +1,4 @@
+PICO TCG CORE1 START
+PICO TCG CORE1 ECHO OK
+PICO TCG CORE1 ACK OK
+PICO TCG CORE1 OK
diff --git a/tests/tcg/arm/system/rp2040-psm-proc1.S b/tests/tcg/arm/system/rp2040-psm-proc1.S
new file mode 100644
index 0000000000..f88166b906
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-psm-proc1.S
@@ -0,0 +1,143 @@
+/*
+ * Raspberry Pi Pico PSM PROC1 power-state test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define PSM_BASE               0x40010000
+#define PSM_FRCE_OFF           0x04
+#define PSM_DONE               0x0c
+#define PSM_SET_ALIAS          0x2000
+#define PSM_CLR_ALIAS          0x3000
+#define PSM_PROC1              0x00010000
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.section .vectors, "a", %progbits
+.global vector_table
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
+    ldr r0, =start_message
+    bl puts
+
+    ldr r4, =(PSM_BASE + PSM_FRCE_OFF)
+    ldr r5, =PSM_PROC1
+    ldr r6, =(PSM_BASE + PSM_DONE)
+
+    ldr r0, [r4]
+    tst r0, r5
+    bne fail_initial
+    ldr r0, [r6]
+    tst r0, r5
+    beq fail_initial
+
+    ldr r0, =initial_message
+    bl puts
+
+    ldr r0, =(PSM_BASE + PSM_SET_ALIAS + PSM_FRCE_OFF)
+    str r5, [r0]
+    ldr r0, [r4]
+    tst r0, r5
+    beq fail_force_off
+    ldr r0, [r6]
+    tst r0, r5
+    bne fail_force_off
+
+    ldr r0, =off_message
+    bl puts
+
+    ldr r0, =(PSM_BASE + PSM_CLR_ALIAS + PSM_FRCE_OFF)
+    str r5, [r0]
+    ldr r0, [r4]
+    tst r0, r5
+    bne fail_restart
+    ldr r0, [r6]
+    tst r0, r5
+    beq fail_restart
+
+    ldr r0, =on_message
+    bl puts
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_initial:
+    ldr r0, =fail_initial_message
+    b test_failed
+
+fail_force_off:
+    ldr r0, =fail_force_off_message
+    b test_failed
+
+fail_restart:
+    ldr r0, =fail_restart_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
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
+    .asciz "PICO TCG PSM PROC1 START\n"
+initial_message:
+    .asciz "PICO TCG PSM PROC1 INITIAL ON\n"
+off_message:
+    .asciz "PICO TCG PSM PROC1 FORCED OFF\n"
+on_message:
+    .asciz "PICO TCG PSM PROC1 RESTARTED\n"
+ok_message:
+    .asciz "PICO TCG PSM PROC1 OK\n"
+fail_initial_message:
+    .asciz "PICO TCG PSM PROC1 FAIL: INITIAL\n"
+fail_force_off_message:
+    .asciz "PICO TCG PSM PROC1 FAIL: FORCE OFF\n"
+fail_restart_message:
+    .asciz "PICO TCG PSM PROC1 FAIL: RESTART\n"
+fail_exception_message:
+    .asciz "PICO TCG PSM PROC1 FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-psm-proc1.ref b/tests/tcg/arm/system/rp2040-psm-proc1.ref
new file mode 100644
index 0000000000..b14da263b9
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-psm-proc1.ref
@@ -0,0 +1,5 @@
+PICO TCG PSM PROC1 START
+PICO TCG PSM PROC1 INITIAL ON
+PICO TCG PSM PROC1 FORCED OFF
+PICO TCG PSM PROC1 RESTARTED
+PICO TCG PSM PROC1 OK
diff --git a/tests/tcg/arm/system/rp2040-sio-divider.S b/tests/tcg/arm/system/rp2040-sio-divider.S
new file mode 100644
index 0000000000..fc924a2f3d
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-sio-divider.S
@@ -0,0 +1,169 @@
+/*
+ * Raspberry Pi Pico SIO hardware divider test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_DIV_UDIVIDEND      0x60
+#define SIO_DIV_UDIVISOR       0x64
+#define SIO_DIV_SDIVIDEND      0x68
+#define SIO_DIV_SDIVISOR       0x6c
+#define SIO_DIV_QUOTIENT       0x70
+#define SIO_DIV_REMAINDER      0x74
+#define SIO_DIV_CSR            0x78
+#define SIO_DIV_CSR_READY_DIRTY 0x03
+#define SIO_DIV_CSR_READY      0x01
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.macro fail_if_ne reg, expected, target
+    ldr r2, =\expected
+    cmp \reg, r2
+    beq 0f
+    b \target
+0:
+.endm
+
+.section .vectors, "a", %progbits
+.global vector_table
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
+    ldr r0, =start_message
+    bl puts
+    ldr r4, =SIO_BASE
+
+    /* Unsigned: 100 / 7 = 14 remainder 2. */
+    movs r0, 100
+    str r0, [r4, SIO_DIV_UDIVIDEND]
+    movs r0, 7
+    str r0, [r4, SIO_DIV_UDIVISOR]
+    ldr r0, [r4, SIO_DIV_CSR]
+    fail_if_ne r0, SIO_DIV_CSR_READY_DIRTY, fail_unsigned
+    ldr r0, [r4, SIO_DIV_REMAINDER]
+    fail_if_ne r0, 2, fail_unsigned
+    ldr r0, [r4, SIO_DIV_CSR]
+    fail_if_ne r0, SIO_DIV_CSR_READY_DIRTY, fail_unsigned
+    ldr r0, [r4, SIO_DIV_QUOTIENT]
+    fail_if_ne r0, 14, fail_unsigned
+    ldr r0, [r4, SIO_DIV_CSR]
+    fail_if_ne r0, SIO_DIV_CSR_READY, fail_unsigned
+
+    /* Signed: -100 / 7 = -14 remainder -2. */
+    ldr r0, =-100
+    str r0, [r4, SIO_DIV_SDIVIDEND]
+    movs r0, 7
+    str r0, [r4, SIO_DIV_SDIVISOR]
+    ldr r0, [r4, SIO_DIV_REMAINDER]
+    fail_if_ne r0, -2, fail_signed
+    ldr r0, [r4, SIO_DIV_QUOTIENT]
+    fail_if_ne r0, -14, fail_signed
+
+    /* Division by zero follows the RP2040 result contract. */
+    ldr r0, =0x1234
+    str r0, [r4, SIO_DIV_UDIVIDEND]
+    movs r0, 0
+    str r0, [r4, SIO_DIV_UDIVISOR]
+    ldr r0, [r4, SIO_DIV_REMAINDER]
+    fail_if_ne r0, 0x1234, fail_divzero
+    ldr r0, [r4, SIO_DIV_QUOTIENT]
+    fail_if_ne r0, 0xffffffff, fail_divzero
+
+    /* Result writes restore a saved divider context and set DIRTY. */
+    ldr r0, =0xaabbccdd
+    str r0, [r4, SIO_DIV_REMAINDER]
+    ldr r0, =0x11223344
+    str r0, [r4, SIO_DIV_QUOTIENT]
+    ldr r0, [r4, SIO_DIV_CSR]
+    fail_if_ne r0, SIO_DIV_CSR_READY_DIRTY, fail_restore
+    ldr r0, [r4, SIO_DIV_REMAINDER]
+    fail_if_ne r0, 0xaabbccdd, fail_restore
+    ldr r0, [r4, SIO_DIV_QUOTIENT]
+    fail_if_ne r0, 0x11223344, fail_restore
+    ldr r0, [r4, SIO_DIV_CSR]
+    fail_if_ne r0, SIO_DIV_CSR_READY, fail_restore
+
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_unsigned:
+    ldr r0, =fail_unsigned_message
+    b test_failed
+
+fail_signed:
+    ldr r0, =fail_signed_message
+    b test_failed
+
+fail_divzero:
+    ldr r0, =fail_divzero_message
+    b test_failed
+
+fail_restore:
+    ldr r0, =fail_restore_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
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
+    .asciz "PICO TCG SIO DIVIDER START\n"
+ok_message:
+    .asciz "PICO TCG SIO DIVIDER OK\n"
+fail_unsigned_message:
+    .asciz "PICO TCG SIO DIVIDER FAIL: UNSIGNED\n"
+fail_signed_message:
+    .asciz "PICO TCG SIO DIVIDER FAIL: SIGNED\n"
+fail_divzero_message:
+    .asciz "PICO TCG SIO DIVIDER FAIL: DIVZERO\n"
+fail_restore_message:
+    .asciz "PICO TCG SIO DIVIDER FAIL: RESTORE\n"
+fail_exception_message:
+    .asciz "PICO TCG SIO DIVIDER FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-sio-divider.ref b/tests/tcg/arm/system/rp2040-sio-divider.ref
new file mode 100644
index 0000000000..c03c8338dd
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-sio-divider.ref
@@ -0,0 +1,2 @@
+PICO TCG SIO DIVIDER START
+PICO TCG SIO DIVIDER OK
diff --git a/tests/tcg/arm/system/rp2040-sio-fifo.S b/tests/tcg/arm/system/rp2040-sio-fifo.S
new file mode 100644
index 0000000000..4395167203
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-sio-fifo.S
@@ -0,0 +1,154 @@
+/*
+ * Raspberry Pi Pico SIO FIFO status test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_CPUID              0x00
+#define SIO_FIFO_ST            0x50
+#define SIO_FIFO_RD            0x58
+#define SIO_FIFO_ST_VLD        0x01
+#define SIO_FIFO_ST_RDY        0x02
+#define SIO_FIFO_ST_ROE        0x08
+#define SYS_EXIT               0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
+
+.section .vectors, "a", %progbits
+.global vector_table
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
+    ldr r0, =start_message
+    bl puts
+
+    ldr r4, =SIO_BASE
+    ldr r0, [r4, SIO_CPUID]
+    cmp r0, 0
+    bne fail_cpuid
+
+    ldr r0, [r4, SIO_FIFO_ST]
+    movs r1, SIO_FIFO_ST_RDY
+    tst r0, r1
+    beq fail_rdy
+
+    /* The mask ROM on core 1 may have queued its initial ready word. */
+    movs r1, SIO_FIFO_ST_VLD
+    tst r0, r1
+    beq fifo_empty
+    ldr r0, [r4, SIO_FIFO_RD]
+    cmp r0, 0
+    bne fail_ready_word
+
+fifo_empty:
+    ldr r0, [r4, SIO_FIFO_ST]
+    movs r1, SIO_FIFO_ST_VLD
+    tst r0, r1
+    bne fail_vld
+
+    ldr r0, [r4, SIO_FIFO_RD]
+    ldr r0, [r4, SIO_FIFO_ST]
+    movs r1, SIO_FIFO_ST_ROE
+    tst r0, r1
+    beq fail_roe
+
+    str r1, [r4, SIO_FIFO_ST]
+    ldr r0, [r4, SIO_FIFO_ST]
+    tst r0, r1
+    bne fail_roe_clear
+
+    ldr r0, =ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_cpuid:
+    ldr r0, =fail_cpuid_message
+    b test_failed
+
+fail_rdy:
+    ldr r0, =fail_rdy_message
+    b test_failed
+
+fail_vld:
+    ldr r0, =fail_vld_message
+    b test_failed
+
+fail_ready_word:
+    ldr r0, =fail_ready_word_message
+    b test_failed
+
+fail_roe:
+    ldr r0, =fail_roe_message
+    b test_failed
+
+fail_roe_clear:
+    ldr r0, =fail_roe_clear_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
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
+    .asciz "PICO TCG SIO FIFO START\n"
+ok_message:
+    .asciz "PICO TCG SIO FIFO OK\n"
+fail_cpuid_message:
+    .asciz "PICO TCG SIO FIFO FAIL: CPUID\n"
+fail_rdy_message:
+    .asciz "PICO TCG SIO FIFO FAIL: RDY\n"
+fail_vld_message:
+    .asciz "PICO TCG SIO FIFO FAIL: VLD\n"
+fail_ready_word_message:
+    .asciz "PICO TCG SIO FIFO FAIL: READY WORD\n"
+fail_roe_message:
+    .asciz "PICO TCG SIO FIFO FAIL: ROE\n"
+fail_roe_clear_message:
+    .asciz "PICO TCG SIO FIFO FAIL: ROE CLEAR\n"
+fail_exception_message:
+    .asciz "PICO TCG SIO FIFO FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-sio-fifo.ref b/tests/tcg/arm/system/rp2040-sio-fifo.ref
new file mode 100644
index 0000000000..c0de9abb9f
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-sio-fifo.ref
@@ -0,0 +1,2 @@
+PICO TCG SIO FIFO START
+PICO TCG SIO FIFO OK
-- 
2.55.0


