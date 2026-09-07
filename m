Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A10C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Rqj-0004x1-D5; Mon, 07 Sep 2026 01:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqg-0004wG-LI; Mon, 07 Sep 2026 01:24:54 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqf-0007u8-2h; Mon, 07 Sep 2026 01:24:54 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdb9964VzzBqZH;
 Mon,  7 Sep 2026 07:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758669;
 bh=vOL17FJv2z28se4xWO4GYv7cQg5RGDjD+Q+FlL96zWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KvLXYuQooAzU+shRGdrAp6diTJ+6Gt4cNQy43ekfyAAb781oCYc/69vcnTTH1ETE4
 260iYy9y0kqLj6ZSIphDzqnJCzMp6pGCTCi/ytDcjgLRVwVuj6KUUJfnHOA2KPxmz7
 RoytK5V72ryovARMawIWF0vN1DqxjNEiAk9cXJwfFTVXinFinFr8mL17IJRpl4x40A
 LMfXwyi9q2oP4TlpAhe0ULMmlt4KbHWriP1YE1u3jnt6uvBLd2JVqZSpTMdSBwcrgC
 rduMqZxzlXC/3LRiZrUGwCFsouvy+drwa+x/WD1dmpM6B60U5k7ZejSK0DkqyB9sKc
 +8Fr2Qgj7RHNQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb994LMFz7xqf;
 Mon,  7 Sep 2026 07:24:29 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 24/36] tests/tcg/arm: test RP2040 timer alarm interrupt
Date: Mon,  7 Sep 2026 07:24:12 +0200
Message-ID: <20260907052426.24849-8-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/system/meson.build      |   5 ++
 tests/tcg/arm/system/rp2040-timer.S   | 116 ++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-timer.ref |   2 +
 3 files changed, 123 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-timer.S
 create mode 100644 tests/tcg/arm/system/rp2040-timer.ref

diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 494f13995f..d39359419b 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -93,6 +93,11 @@ tests += {
     'qemu_args': rp2040_uart_qemu_args,
     'expected_output': 'rp2040-core1-launch.ref',
   },
+  'rp2040-timer.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-timer.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
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


