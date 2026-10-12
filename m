Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4777ECA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJNJ-00007R-U1; Mon, 12 Oct 2026 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMn-00084n-Ma; Mon, 12 Oct 2026 12:59:15 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMd-0006ES-Vl; Mon, 12 Oct 2026 12:59:12 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw16dW0z8BNx;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824321;
 bh=n/Rh9NOT0tf2DdviPPLi8SSJK4fnxZ0dt0bXhGsBWso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kOLkPSIbzxlNsAvrpyWo7JI3ZL7BANs+gKEqB33sLOX/CzXn8BwLIarimqk5FvOjF
 /6Gh3gt+uyPcK5EScd/AihovH7XX6nzEWQ5+gfyqSEO2942flfcXU0axz68GIqeRmO
 xyvg+kTwOKOQ4q7J4UjtzVuANMk8XTaTxc3oIzunROouR0pbhYUDrFKAoQefJ8JgGY
 1A5Jzxy6ocqT60o65lX3ZYSSzEE9O8FGttEGwAOihNZNELPmlG+7N0DX2DJIqmWRge
 dwa51Rfu1z4zWY6fQ2uG8K2YLOC4DBr6MUAh0MH54413EC+doISwm2RvrsLHPG/Syg
 SBXUgKxyV2kaA==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw15YZNz83nc;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH 4/9] tests/tcg/arm: add Raspberry Pi Pico smoke tests
Date: Mon, 12 Oct 2026 18:58:34 +0200
Message-ID: <20261012165840.99050-5-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
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

Build Cortex-M0+ guest programs from assembly sources to exercise the
minimal Pico boot path, UART0 output, and the Cortex-M0+ MPU. Keep the
vector table at the XIP base so these tests match the initial synthetic
boot stub without depending on boot2 or the later flash controller model.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/system/meson.build       | 14 +++++++
 tests/tcg/arm/system/rp2040-boot.S     | 30 +++++++++++++++
 tests/tcg/arm/system/rp2040-minimal.ld | 40 +++++++++++++++++++
 tests/tcg/arm/system/rp2040-uart.S     | 53 ++++++++++++++++++++++++++
 tests/tcg/arm/system/rp2040-uart.ref   |  1 +
 5 files changed, 138 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-boot.S
 create mode 100644 tests/tcg/arm/system/rp2040-minimal.ld
 create mode 100644 tests/tcg/arm/system/rp2040-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-uart.ref

diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 80c5461e62..29b03b64d0 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -15,6 +15,11 @@ qemu_base_args = ['-display', 'none',
                   '-semihosting-config', 'enable=on',
                   '-kernel']
 qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+rp2040_cflags = ['-mcpu=cortex-m0plus', '-mthumb', '-mfloat-abi=soft',
+                 '-nostdlib', '-Wl,--build-id=none',
+                 '-T', files('rp2040-minimal.ld')]
+rp2040_qemu_args = ['-M', 'raspi-pico', '-monitor', 'none',
+                    qemu_base_args]
 
 # Multi arch tests
 multi_src = []
@@ -51,6 +56,15 @@ tests += {
                '-T', files('test-armv6m-undef.ld')],
     'qemu_args': ['-M', 'microbit', qemu_base_args],
   },
+  'rp2040-boot.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_qemu_args,
+  },
+  'rp2040-uart.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': ['-serial', 'stdio', rp2040_qemu_args],
+    'expected_output': 'rp2040-uart.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
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


