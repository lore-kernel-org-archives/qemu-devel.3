Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F4C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YrG-0002Ul-4H; Sun, 30 Aug 2026 02:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrF-0002UN-BA; Sun, 30 Aug 2026 02:17:33 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrD-0005Gq-F0; Sun, 30 Aug 2026 02:17:33 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXhjn5g20z833L;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070637;
 bh=c4A9mjdzKitmoqARJ2fI5K6z4YrhdjXxJE1wNl1lxGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sst9B0mvFpBFUSyVkllqdsyaZplaBiIxa+Fx79GaTiS4l8E9gxOal1AVqEz5aFO9s
 Yrx0hTdg2Gk2YoU0dzzjsFycijqDt6jrxrc24ztUNgrPzzm/yQkwzd8ypIeH/FhEmu
 /ztDEHlYOgJyw77YiDspN9NQx2lUbns5wMFVG2CVxKQn+Sfnut1Cx72LAEiWt3L8jj
 vSxrfV4myiYeZtAS0It9IU8NL6K9oOk104AGOVJejx0bv06uQA38jWsllPjk8+E1vE
 bAFyzaWwdG2OUdDOGl9IhlQEPW+vqIMgBDCUAG5eYDCSlmncXkIjr7Y29V6geHvXEo
 w3B42FU4In0Sw==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjn4JhDz7swM;
 Sun, 30 Aug 2026 08:17:17 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 19/30] tests/tcg/arm: test RP2040 timer alarm interrupt
Date: Sun, 30 Aug 2026 08:15:50 +0200
Message-ID: <20260830061601.52136-5-gilles.grimaud@univ-lille.fr>
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
 tests/tcg/arm/Makefile.softmmu-target |   7 +-
 tests/tcg/arm/system/rp2040-timer.S   | 116 ++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-timer.ref |   2 +
 3 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/arm/system/rp2040-timer.S
 create mode 100644 tests/tcg/arm/system/rp2040-timer.ref

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 28e4c5774a..f3efe619d1 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -22,7 +22,7 @@ ARM_TESTS+=test-armv6m-undef
 
 RP2040_TESTS=rp2040-boot rp2040-uart rp2040-mpu \
 	rp2040-sio-fifo rp2040-sio-divider rp2040-psm-proc1 \
-	rp2040-core1-launch
+	rp2040-core1-launch rp2040-timer
 
 $(RP2040_TESTS): %: %.S rp2040-minimal.ld
 	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
@@ -35,14 +35,15 @@ run-rp2040-boot: QEMU_OPTS=-M raspi-pico \
 
 run-rp2040-uart run-rp2040-mpu \
 run-rp2040-sio-fifo run-rp2040-sio-divider \
-run-rp2040-psm-proc1 run-rp2040-core1-launch: \
+run-rp2040-psm-proc1 run-rp2040-core1-launch run-rp2040-timer: \
 	QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
 	-serial chardev:output \
 	-semihosting-config enable=on,target=native -kernel
 
 run-rp2040-uart run-rp2040-mpu \
 run-rp2040-sio-fifo run-rp2040-sio-divider \
-run-rp2040-psm-proc1 run-rp2040-core1-launch: run-rp2040-%: rp2040-%
+run-rp2040-psm-proc1 run-rp2040-core1-launch \
+run-rp2040-timer: run-rp2040-%: rp2040-%
 	$(call run-test, $<, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
diff --git a/tests/tcg/arm/system/rp2040-timer.S b/tests/tcg/arm/system/rp2040-timer.S
new file mode 100644
index 0000000000..249df6433a
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-timer.S
@@ -0,0 +1,116 @@
+/*
+ * Raspberry Pi Pico timer alarm interrupt test.
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
+#define TEST_FLAG              0x20000000
+#define UART0_DR               0x40034000
+#define TIMER_BASE             0x40054000
+#define TIMER_ALARM0           0x10
+#define TIMER_RAWL             0x28
+#define TIMER_INTR             0x34
+#define TIMER_INTE             0x38
+#define NVIC_ISER              0xe000e100
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
+    .rept 12
+    .word default_handler + 1
+    .endr
+    .word timer_irq + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    ldr r0, =start_message
+    bl puts
+
+    ldr r0, =TEST_FLAG
+    movs r1, 0
+    str r1, [r0]
+
+    ldr r0, =NVIC_ISER
+    movs r1, 1
+    str r1, [r0]
+
+    ldr r4, =TIMER_BASE
+    str r1, [r4, TIMER_INTR]
+    str r1, [r4, TIMER_INTE]
+    ldr r2, [r4, TIMER_RAWL]
+    ldr r3, =1000
+    adds r2, r2, r3
+    str r2, [r4, TIMER_ALARM0]
+
+1:
+    ldr r0, =TEST_FLAG
+    ldr r1, [r0]
+    cmp r1, 0
+    beq 1b
+
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
+timer_irq:
+    ldr r0, =TIMER_BASE
+    movs r1, 1
+    str r1, [r0, TIMER_INTR]
+    ldr r0, =TEST_FLAG
+    str r1, [r0]
+    bx lr
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+3:
+    b 3b
+
+.thumb_func
+puts:
+    ldr r2, =UART0_DR
+
+4:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 5f
+    str r1, [r2]
+    adds r0, 1
+    b 4b
+
+5:
+    bx lr
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG TIMER START\n"
+ok_message:
+    .asciz "PICO TCG TIMER OK\n"
+fail_message:
+    .asciz "PICO TCG TIMER FAIL\n"
diff --git a/tests/tcg/arm/system/rp2040-timer.ref b/tests/tcg/arm/system/rp2040-timer.ref
new file mode 100644
index 0000000000..32e6e169b6
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-timer.ref
@@ -0,0 +1,2 @@
+PICO TCG TIMER START
+PICO TCG TIMER OK
-- 
2.55.0


