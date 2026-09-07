Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C803C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Rqp-0004zB-Ru; Mon, 07 Sep 2026 01:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqn-0004yN-D5; Mon, 07 Sep 2026 01:25:01 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqi-0007uV-QI; Mon, 07 Sep 2026 01:25:01 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdb9B5XTdzBqZN;
 Mon,  7 Sep 2026 07:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758670;
 bh=OsGCmWV03Ke3JX40enfi6nxqO+kzde3ZACqNa+kLNZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=np9yz5oMFw1jjCJgBq6H4bbd1OCdtrXe9qo/whJ5ymr/YdpOPUSXd/5d1Fd/exGYk
 1d+7PS3LkHSFMjwlm3iuSyifI8AjQ69+uWOHJeo4mm81Uw3k7qEtjRgO6smFgW2YGD
 56rH9eWnfkFRb4g9K12pBunHiajq9w6c/bR632zGLE1DW9LsB7+TVrJccPLVGWpSU8
 Y49EjaHrKFBZQFDrnGJRARu0/3gA6uo+XSUVYduyuHfqT8sMhrSBgYBLkO+wW4O2hQ
 heP2OtYiC3tIg1xhey677ptEa0xi7LvQmmgiB8ydToOSB2rNet54GVfw5sNknqcyre
 Vbyg+MU/QjijQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb9B406hz7xqd;
 Mon,  7 Sep 2026 07:24:30 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 26/36] tests/tcg/arm: test RP2040 flash and XIP behavior
Date: Mon,  7 Sep 2026 07:24:14 +0200
Message-ID: <20260907052426.24849-10-gilles.grimaud@univ-lille.fr>
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

Exercise write-enable, page programming, sector erase and NOR bit semantics
through the RP2040 SSI command path. Verify raw flash persistence across
QEMU invocations and IO_QSPI chip-select behavior.

Cover XIP accesses while the flash is busy, including direct HardFault
delivery, multicore lockout, and faults observed independently by core 0
and core 1.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/system/meson.build              |  33 ++
 tests/tcg/arm/system/rp2040-core0-xip-fault.S | 193 ++++++++
 .../tcg/arm/system/rp2040-core0-xip-fault.ref |   2 +
 tests/tcg/arm/system/rp2040-core1-xip-fault.S | 331 +++++++++++++
 .../tcg/arm/system/rp2040-core1-xip-fault.ref |   3 +
 .../arm/system/rp2040-flash-busy-hardfault.S  | 179 ++++++++
 .../system/rp2040-flash-busy-hardfault.ref    |   2 +
 .../arm/system/rp2040-flash-busy-lockout.S    | 434 ++++++++++++++++++
 .../arm/system/rp2040-flash-busy-lockout.ref  |   4 +
 tests/tcg/arm/system/rp2040-flash-commands.S  | 405 ++++++++++++++++
 .../tcg/arm/system/rp2040-flash-commands.ref  |   6 +
 tests/tcg/arm/system/rp2040-flash-ioqspi.S    | 212 +++++++++
 tests/tcg/arm/system/rp2040-flash-ioqspi.ref  |   2 +
 .../system/rp2040-flash-persist-reader.ref    |   1 +
 tests/tcg/arm/system/rp2040-flash-persist.sh  |  34 ++
 15 files changed, 1841 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-core0-xip-fault.S
 create mode 100644 tests/tcg/arm/system/rp2040-core0-xip-fault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-core1-xip-fault.S
 create mode 100644 tests/tcg/arm/system/rp2040-core1-xip-fault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-hardfault.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-hardfault.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-lockout.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-busy-lockout.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-commands.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-commands.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-ioqspi.S
 create mode 100644 tests/tcg/arm/system/rp2040-flash-ioqspi.ref
 create mode 100644 tests/tcg/arm/system/rp2040-flash-persist-reader.ref
 create mode 100755 tests/tcg/arm/system/rp2040-flash-persist.sh

diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 8e7286e390..c57bf5f0d0 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -24,6 +24,7 @@ rp2040_qemu_args = ['-M', 'raspi-pico', '-monitor', 'none',
 rp2040_uart_qemu_args = ['-M', 'raspi-pico,strict-uart-pins=off',
                          '-monitor', 'none', '-serial', 'stdio',
                          qemu_base_args]
+rp2040_flash_persist = find_program('rp2040-flash-persist.sh')
 
 # Multi arch tests
 multi_src = []
@@ -99,6 +100,38 @@ tests += {
     'qemu_args': rp2040_uart_qemu_args,
     'expected_output': 'rp2040-timer.ref',
   },
+  'rp2040-flash-commands.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'wrapper': [rp2040_flash_persist,
+                files('rp2040-flash-commands.ref'),
+                files('rp2040-flash-persist-reader.ref')],
+  },
+  'rp2040-flash-ioqspi.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-flash-ioqspi.ref',
+  },
+  'rp2040-flash-busy-hardfault.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-flash-busy-hardfault.ref',
+  },
+  'rp2040-flash-busy-lockout.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-flash-busy-lockout.ref',
+  },
+  'rp2040-core0-xip-fault.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-core0-xip-fault.ref',
+  },
+  'rp2040-core1-xip-fault.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-core1-xip-fault.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/rp2040-core0-xip-fault.S b/tests/tcg/arm/system/rp2040-core0-xip-fault.S
new file mode 100644
index 0000000000..675dd231d2
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core0-xip-fault.S
@@ -0,0 +1,193 @@
+/*
+ * Raspberry Pi Pico core 0 XIP-busy instruction fault test.
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
+#define SRAM_BASE              0x20000000
+#define UART0_DR               0x40034000
+#define SCB_VTOR               0xe000ed08
+#define SSI_BASE               0x18000000
+#define SSI_CTRLR0             0x00
+#define SSI_SSIENR             0x08
+#define SSI_SER                0x10
+#define SSI_RXFLR              0x24
+#define SSI_DR0                0x60
+#define SSI_CTRLR0_SPI_TXRX    0x00070000
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
+    bl xip_puts
+    ldr r0, =SRAM_BASE
+    ldr r1, =sram_start
+    ldr r2, =sram_end
+
+1:
+    cmp r1, r2
+    bhs 2f
+    ldr r3, [r1]
+    str r3, [r0]
+    adds r1, 4
+    adds r0, 4
+    b 1b
+
+2:
+    ldr r0, =SRAM_BASE
+    adds r0, 1
+    bx r0
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.thumb_func
+xip_probe:
+    ldr r0, =xip_no_fault_message
+    bl xip_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+3:
+    b 3b
+
+.thumb_func
+xip_puts:
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
+.align 2
+sram_start:
+    ldr r0, =SRAM_BASE
+    ldr r1, =SRAM_END
+    str r1, [r0]
+    adr r1, sram_entry
+    adds r1, 1
+    str r1, [r0, 4]
+    movs r1, 0
+    str r1, [r0, 8]
+    adr r1, sram_hardfault
+    adds r1, 1
+    str r1, [r0, 12]
+    ldr r2, =SCB_VTOR
+    str r0, [r2]
+
+.align 2
+.thumb_func
+sram_entry:
+    ldr r4, =SSI_BASE
+    movs r0, 0
+    str r0, [r4, SSI_SSIENR]
+    ldr r0, =SSI_CTRLR0_SPI_TXRX
+    str r0, [r4, SSI_CTRLR0]
+    movs r0, 1
+    str r0, [r4, SSI_SSIENR]
+
+    str r0, [r4, SSI_SER]
+    movs r0, 0x06
+    bl sram_ssi_txrx
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+
+    movs r0, 1
+    str r0, [r4, SSI_SER]
+    movs r0, 0x02
+    bl sram_ssi_txrx
+    movs r0, 0x00
+    bl sram_ssi_txrx
+    movs r0, 0x20
+    bl sram_ssi_txrx
+    movs r0, 0x00
+    bl sram_ssi_txrx
+    movs r0, 0x5a
+    bl sram_ssi_txrx
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+
+    ldr r0, =xip_probe
+    adds r0, 1
+    bx r0
+
+.thumb_func
+sram_ssi_txrx:
+    ldr r2, =(SSI_BASE + SSI_DR0)
+    str r0, [r2]
+    ldr r3, =(SSI_BASE + SSI_RXFLR)
+
+6:
+    ldr r0, [r3]
+    cmp r0, 0
+    beq 6b
+    ldr r0, [r2]
+    bx lr
+
+.align 2
+.thumb_func
+sram_hardfault:
+    adr r0, sram_ok_message
+    bl sram_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+7:
+    b 7b
+
+.thumb_func
+sram_puts:
+    ldr r2, =UART0_DR
+
+8:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 9f
+    str r1, [r2]
+    adds r0, 1
+    b 8b
+
+9:
+    bx lr
+
+.align 2
+sram_ok_message:
+    .asciz "PICO TCG CORE0 XIP HARDFAULT OK\n"
+
+.ltorg
+.align 2
+sram_end:
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG CORE0 XIP START\n"
+xip_no_fault_message:
+    .asciz "PICO TCG CORE0 XIP FAIL: NO FAULT\n"
diff --git a/tests/tcg/arm/system/rp2040-core0-xip-fault.ref b/tests/tcg/arm/system/rp2040-core0-xip-fault.ref
new file mode 100644
index 0000000000..22232ee864
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core0-xip-fault.ref
@@ -0,0 +1,2 @@
+PICO TCG CORE0 XIP START
+PICO TCG CORE0 XIP HARDFAULT OK
diff --git a/tests/tcg/arm/system/rp2040-core1-xip-fault.S b/tests/tcg/arm/system/rp2040-core1-xip-fault.S
new file mode 100644
index 0000000000..5f8a1217eb
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core1-xip-fault.S
@@ -0,0 +1,331 @@
+/*
+ * Raspberry Pi Pico core 1 XIP-busy instruction fault test.
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
+#define SRAM_BASE              0x20000000
+#define CORE1_STACK            0x20041000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_CPUID              0x00
+#define SIO_FIFO_ST            0x50
+#define SIO_FIFO_WR            0x54
+#define SIO_FIFO_RD            0x58
+#define SIO_FIFO_ST_VLD        0x01
+#define SIO_FIFO_ST_RDY        0x02
+#define SCB_VTOR               0xe000ed08
+#define SSI_BASE               0x18000000
+#define SSI_CTRLR0             0x00
+#define SSI_SSIENR             0x08
+#define SSI_SER                0x10
+#define SSI_RXFLR              0x24
+#define SSI_DR0                0x60
+#define SSI_CTRLR0_SPI_TXRX    0x00070000
+#define CORE1_READY            0xc01e1001
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
+    bl xip_puts
+    ldr r0, =SRAM_BASE
+    ldr r1, =sram_start
+    ldr r2, =sram_end
+
+1:
+    cmp r1, r2
+    bhs 2f
+    ldr r3, [r1]
+    str r3, [r0]
+    adds r1, 4
+    adds r0, 4
+    b 1b
+
+2:
+    ldr r0, =SRAM_BASE
+    adds r0, sram_core0_main - sram_start + 1
+    bx r0
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.thumb_func
+xip_core1_loop:
+    ldr r0, =CORE1_READY
+    bl xip_fifo_push
+
+3:
+    b 3b
+
+.thumb_func
+xip_fifo_push:
+    ldr r1, =(SIO_BASE + SIO_FIFO_ST)
+
+4:
+    ldr r2, [r1]
+    movs r3, SIO_FIFO_ST_RDY
+    tst r2, r3
+    beq 4b
+    ldr r1, =(SIO_BASE + SIO_FIFO_WR)
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+xip_puts:
+    ldr r2, =UART0_DR
+
+5:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 6f
+    str r1, [r2]
+    adds r0, 1
+    b 5b
+
+6:
+    bx lr
+
+.align 2
+sram_start:
+    .word SRAM_END
+    .word SRAM_BASE + (sram_core0_main - sram_start) + 1
+    .word 0
+    .word SRAM_BASE + (sram_hardfault - sram_start) + 1
+
+.align 2
+.thumb_func
+sram_core0_main:
+    ldr r0, =SCB_VTOR
+    ldr r1, =SRAM_BASE
+    str r1, [r0]
+    bl sram_launch_core1
+    bl sram_fifo_pop
+    ldr r1, =CORE1_READY
+    cmp r0, r1
+    bne sram_fail_ready
+
+    adr r0, sram_ready_message
+    bl sram_puts
+    bl sram_start_flash_program
+
+7:
+    b 7b
+
+.thumb_func
+sram_launch_core1:
+    push {r4, r5, lr}
+    adr r4, sram_launch_sequence
+    movs r5, 6
+
+8:
+    ldr r0, [r4]
+    cmp r0, 0
+    bne 9f
+    bl sram_fifo_drain
+    sev
+    ldr r0, [r4]
+
+9:
+    bl sram_fifo_push
+    sev
+    bl sram_fifo_pop
+    ldr r1, [r4]
+    cmp r0, r1
+    bne sram_fail_launch
+    adds r4, 4
+    subs r5, 1
+    bne 8b
+    pop {r4, r5, pc}
+
+.thumb_func
+sram_fifo_push:
+    ldr r1, =(SIO_BASE + SIO_FIFO_ST)
+
+10:
+    ldr r2, [r1]
+    movs r3, SIO_FIFO_ST_RDY
+    tst r2, r3
+    beq 10b
+    ldr r1, =(SIO_BASE + SIO_FIFO_WR)
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+sram_fifo_pop:
+    ldr r1, =(SIO_BASE + SIO_FIFO_ST)
+
+11:
+    ldr r2, [r1]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 11b
+    ldr r1, =(SIO_BASE + SIO_FIFO_RD)
+    ldr r0, [r1]
+    bx lr
+
+.thumb_func
+sram_fifo_drain:
+    push {r0, r1, r2, r3, lr}
+    ldr r1, =(SIO_BASE + SIO_FIFO_ST)
+
+12:
+    ldr r2, [r1]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 13f
+    ldr r0, =(SIO_BASE + SIO_FIFO_RD)
+    ldr r0, [r0]
+    b 12b
+
+13:
+    pop {r0, r1, r2, r3, pc}
+
+.thumb_func
+sram_start_flash_program:
+    push {lr}
+    ldr r4, =SSI_BASE
+    movs r0, 0
+    str r0, [r4, SSI_SSIENR]
+    ldr r0, =SSI_CTRLR0_SPI_TXRX
+    str r0, [r4, SSI_CTRLR0]
+    movs r0, 1
+    str r0, [r4, SSI_SSIENR]
+
+    str r0, [r4, SSI_SER]
+    movs r0, 0x06
+    bl sram_ssi_txrx
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+
+    movs r0, 1
+    str r0, [r4, SSI_SER]
+    movs r0, 0x02
+    bl sram_ssi_txrx
+    movs r0, 0x00
+    bl sram_ssi_txrx
+    movs r0, 0x30
+    bl sram_ssi_txrx
+    movs r0, 0x00
+    bl sram_ssi_txrx
+    movs r0, 0xa5
+    bl sram_ssi_txrx
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+    pop {pc}
+
+.thumb_func
+sram_ssi_txrx:
+    ldr r2, =(SSI_BASE + SSI_DR0)
+    str r0, [r2]
+    ldr r3, =(SSI_BASE + SSI_RXFLR)
+
+14:
+    ldr r0, [r3]
+    cmp r0, 0
+    beq 14b
+    ldr r0, [r2]
+    bx lr
+
+.align 2
+.thumb_func
+sram_hardfault:
+    ldr r0, =SIO_BASE
+    ldr r0, [r0, SIO_CPUID]
+    cmp r0, 1
+    bne sram_fail_core
+    adr r0, sram_ok_message
+    bl sram_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+15:
+    b 15b
+
+sram_fail_launch:
+    adr r0, sram_fail_launch_message
+    b sram_test_failed
+
+sram_fail_ready:
+    adr r0, sram_fail_ready_message
+    b sram_test_failed
+
+sram_fail_core:
+    adr r0, sram_fail_core_message
+
+sram_test_failed:
+    bl sram_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+16:
+    b 16b
+
+.thumb_func
+sram_puts:
+    ldr r2, =UART0_DR
+
+17:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 18f
+    str r1, [r2]
+    adds r0, 1
+    b 17b
+
+18:
+    bx lr
+
+.align 2
+sram_launch_sequence:
+    .word 0
+    .word 0
+    .word 1
+    .word SRAM_BASE
+    .word CORE1_STACK
+    .word xip_core1_loop + 1
+
+.align 2
+sram_ready_message:
+    .asciz "PICO TCG CORE1 XIP READY\n"
+.align 2
+sram_ok_message:
+    .asciz "PICO TCG CORE1 XIP HARDFAULT OK\n"
+.align 2
+sram_fail_launch_message:
+    .asciz "PICO TCG CORE1 XIP FAIL: LAUNCH\n"
+.align 2
+sram_fail_ready_message:
+    .asciz "PICO TCG CORE1 XIP FAIL: READY\n"
+.align 2
+sram_fail_core_message:
+    .asciz "PICO TCG CORE1 XIP FAIL: CPUID\n"
+
+.ltorg
+.align 2
+sram_end:
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG CORE1 XIP START\n"
diff --git a/tests/tcg/arm/system/rp2040-core1-xip-fault.ref b/tests/tcg/arm/system/rp2040-core1-xip-fault.ref
new file mode 100644
index 0000000000..4488763747
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-core1-xip-fault.ref
@@ -0,0 +1,3 @@
+PICO TCG CORE1 XIP START
+PICO TCG CORE1 XIP READY
+PICO TCG CORE1 XIP HARDFAULT OK
diff --git a/tests/tcg/arm/system/rp2040-flash-busy-hardfault.S b/tests/tcg/arm/system/rp2040-flash-busy-hardfault.S
new file mode 100644
index 0000000000..81bcafe260
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-busy-hardfault.S
@@ -0,0 +1,179 @@
+/*
+ * Raspberry Pi Pico XIP access while flash is busy test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_BASE               0x20000000
+#define SRAM_VTOR               0x20001000
+#define SRAM_END                0x20042000
+#define VTOR                    0xe000ed08
+#define UART0_DR                0x40034000
+#define SSI_SER                 0x18000010
+#define SSI_RXFLR               0x18000024
+#define SSI_DR0                 0x18000060
+#define XIP_TARGET              0x10001400
+#define SYS_EXIT                0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
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
+    ldr r0, =SRAM_BASE
+    ldr r1, =ram_code_start
+    ldr r2, =ram_code_end
+
+copy_loop:
+    cmp r1, r2
+    bhs copy_done
+    ldr r3, [r1]
+    str r3, [r0]
+    adds r0, 4
+    adds r1, 4
+    b copy_loop
+
+copy_done:
+    ldr r0, =SRAM_BASE + 1
+    bx r0
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.align 2
+ram_code_start:
+.thumb_func
+ram_main:
+    ldr r0, =SRAM_VTOR
+    ldr r1, =SRAM_END
+    str r1, [r0]
+    ldr r1, =SRAM_BASE + 1
+    str r1, [r0, 4]
+    movs r1, 0
+    str r1, [r0, 8]
+    adr r1, hardfault_handler
+    adds r1, 1
+    str r1, [r0, 12]
+    ldr r1, =VTOR
+    str r0, [r1]
+
+    adr r0, start_message
+    bl puts
+    bl write_enable
+    bl select_flash
+    movs r0, 0x02
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    movs r0, 0x14
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    movs r0, 'X'
+    bl ssi_byte
+    bl deselect_flash
+
+    ldr r1, =XIP_TARGET
+faulting_access:
+    ldrb r0, [r1]
+    adr r0, fail_message
+    b test_failed
+
+.thumb_func
+write_enable:
+    push {lr}
+    bl select_flash
+    movs r0, 0x06
+    bl ssi_byte
+    bl deselect_flash
+    pop {pc}
+
+.thumb_func
+select_flash:
+    ldr r1, =SSI_SER
+    movs r0, 1
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+deselect_flash:
+    ldr r1, =SSI_SER
+    movs r0, 0
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+ssi_byte:
+    ldr r2, =SSI_DR0
+    str r0, [r2]
+    ldr r3, =SSI_RXFLR
+
+1:
+    ldr r0, [r3]
+    cmp r0, 0
+    beq 1b
+    ldr r0, [r2]
+    bx lr
+
+.align 2
+.thumb_func
+hardfault_handler:
+    adr r0, ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+2:
+    b 2b
+
+test_failed:
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
+.align 2
+start_message:
+    .asciz "PICO TCG FLASH XIP BUSY START\n"
+.align 2
+ok_message:
+    .asciz "PICO TCG FLASH XIP BUSY HARDFAULT OK\n"
+.align 2
+fail_message:
+    .asciz "PICO TCG FLASH XIP BUSY FAIL: NO HARDFAULT\n"
+.align 2
+.ltorg
+ram_code_end:
diff --git a/tests/tcg/arm/system/rp2040-flash-busy-hardfault.ref b/tests/tcg/arm/system/rp2040-flash-busy-hardfault.ref
new file mode 100644
index 0000000000..ee43e3ae15
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-busy-hardfault.ref
@@ -0,0 +1,2 @@
+PICO TCG FLASH XIP BUSY START
+PICO TCG FLASH XIP BUSY HARDFAULT OK
diff --git a/tests/tcg/arm/system/rp2040-flash-busy-lockout.S b/tests/tcg/arm/system/rp2040-flash-busy-lockout.S
new file mode 100644
index 0000000000..a0397d7a1d
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-busy-lockout.S
@@ -0,0 +1,434 @@
+/*
+ * Raspberry Pi Pico multicore flash-busy lockout test.
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
+#define CORE0_SRAM_VTOR        0x20000000
+#define CORE0_SRAM_CODE        0x20000100
+#define PAGE_BUFFER            0x20000400
+#define CORE1_SRAM_VTOR        0x20001000
+#define CORE1_STACK            0x20041000
+#define UART0_DR               0x40034000
+#define SIO_BASE               0xd0000000
+#define SIO_FIFO_ST            0x50
+#define SIO_FIFO_WR            0x54
+#define SIO_FIFO_RD            0x58
+#define SIO_SPINLOCK0          0x100
+#define SIO_FIFO_ST_VLD        0x01
+#define SIO_FIFO_ST_RDY        0x02
+#define NVIC_ISER              0xe000e100
+#define SCB_VTOR               0xe000ed08
+#define SIO_IRQ_PROC1_MASK     0x00010000
+#define SSI_BASE               0x18000000
+#define SSI_SSIENR             0x08
+#define SSI_SER                0x10
+#define SSI_DR0                0x60
+#define FLASH_ADDRESS          0x10101000
+#define LOCK_REQUEST           0xfacefeed
+#define LOCK_ACK               0xface0001
+#define BAD_ACK                0xbad10003
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
+    bl copy_core1_sram
+    bl launch_core1
+
+    ldr r0, =launch_message
+    bl puts
+    bl claim_spinlock
+    ldr r0, =LOCK_REQUEST
+    bl fifo_push
+    sev
+    ldr r0, =LOCK_ACK
+    bl fifo_pop_expect
+
+    ldr r0, =locked_message
+    bl puts
+    bl copy_and_run_core0_sram
+    ldr r0, =fail_return_message
+    b test_failed
+
+.thumb_func
+launch_core1:
+    push {r4, r5, lr}
+    ldr r4, =launch_sequence
+    movs r5, 6
+
+1:
+    ldr r0, [r4]
+    cmp r0, 0
+    bne 2f
+    bl fifo_drain
+    sev
+    ldr r0, [r4]
+
+2:
+    bl fifo_push
+    sev
+    bl fifo_pop
+    ldr r1, [r4]
+    cmp r0, r1
+    bne fail_launch
+    adds r4, 4
+    subs r5, 1
+    bne 1b
+    pop {r4, r5, pc}
+
+.thumb_func
+copy_core1_sram:
+    ldr r0, =core1_sram_start
+    ldr r1, =CORE1_SRAM_VTOR
+    ldr r2, =core1_sram_end
+
+3:
+    cmp r0, r2
+    bhs 4f
+    ldr r3, [r0]
+    str r3, [r1]
+    adds r0, 4
+    adds r1, 4
+    b 3b
+
+4:
+    bx lr
+
+.thumb_func
+claim_spinlock:
+    ldr r0, =(SIO_BASE + SIO_SPINLOCK0)
+    ldr r1, [r0]
+    cmp r1, 0
+    beq fail_spinlock
+    bx lr
+
+.thumb_func
+copy_and_run_core0_sram:
+    ldr r0, =core0_sram_start
+    ldr r1, =CORE0_SRAM_CODE
+    ldr r2, =core0_sram_end
+
+5:
+    cmp r0, r2
+    bhs 6f
+    ldr r3, [r0]
+    str r3, [r1]
+    adds r0, 4
+    adds r1, 4
+    b 5b
+
+6:
+    ldr r0, =CORE0_SRAM_CODE
+    adds r0, 1
+    bx r0
+
+.thumb_func
+fifo_push:
+    push {r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+7:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_RDY
+    tst r2, r3
+    beq 7b
+    str r0, [r1, SIO_FIFO_WR]
+    pop {r1, r2, r3, pc}
+
+.thumb_func
+fifo_pop:
+    push {r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+8:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 8b
+    ldr r0, [r1, SIO_FIFO_RD]
+    pop {r1, r2, r3, pc}
+
+.thumb_func
+fifo_drain:
+    push {r0, r1, r2, r3, lr}
+    ldr r1, =SIO_BASE
+
+9:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 10f
+    ldr r0, [r1, SIO_FIFO_RD]
+    b 9b
+
+10:
+    pop {r0, r1, r2, r3, pc}
+
+.thumb_func
+fifo_pop_expect:
+    push {r4, lr}
+    mov r4, r0
+    bl fifo_pop
+    cmp r0, r4
+    bne fail_fifo
+    pop {r4, pc}
+
+fail_launch:
+    ldr r0, =fail_launch_message
+    b test_failed
+
+fail_spinlock:
+    ldr r0, =fail_spinlock_message
+    b test_failed
+
+fail_fifo:
+    ldr r0, =fail_fifo_message
+    b test_failed
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+11:
+    b 11b
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_exception_message
+    b test_failed
+
+.thumb_func
+puts:
+    push {r1, r2, lr}
+    ldr r1, =UART0_DR
+
+12:
+    ldrb r2, [r0]
+    cmp r2, 0
+    beq 13f
+    str r2, [r1]
+    adds r0, 1
+    b 12b
+
+13:
+    pop {r1, r2, pc}
+
+.align 2
+core0_sram_start:
+    ldr r0, =CORE0_SRAM_VTOR
+    ldr r1, =SRAM_END
+    str r1, [r0]
+    movs r1, 0
+    str r1, [r0, 4]
+    ldr r1, =core0_sram_hardfault
+    ldr r2, =core0_sram_start
+    subs r1, r2
+    ldr r2, =CORE0_SRAM_CODE
+    adds r1, r1, r2
+    str r1, [r0, 12]
+    ldr r0, =SCB_VTOR
+    ldr r1, =CORE0_SRAM_VTOR
+    str r1, [r0]
+
+    ldr r0, =PAGE_BUFFER
+    movs r1, 0x5a
+    str r1, [r0]
+
+    ldr r4, =SSI_BASE
+    movs r0, 1
+    str r0, [r4, SSI_SSIENR]
+    str r0, [r4, SSI_SER]
+    movs r0, 0x06
+    str r0, [r4, SSI_DR0]
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+
+    movs r0, 1
+    str r0, [r4, SSI_SER]
+    movs r0, 0x02
+    str r0, [r4, SSI_DR0]
+    movs r0, 0x10
+    str r0, [r4, SSI_DR0]
+    str r0, [r4, SSI_DR0]
+    movs r0, 0
+    str r0, [r4, SSI_DR0]
+    movs r0, 0x5a
+    str r0, [r4, SSI_DR0]
+    movs r0, 0
+    str r0, [r4, SSI_SER]
+
+    ldr r0, =FLASH_ADDRESS
+    ldrb r0, [r0]
+    ldr r0, =core0_sram_no_fault_message
+    ldr r1, =core0_sram_start
+    subs r0, r1
+    ldr r1, =CORE0_SRAM_CODE
+    adds r0, r1
+    bl core0_sram_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+14:
+    b 14b
+
+.thumb_func
+core0_sram_hardfault:
+    ldr r0, =core0_sram_ok_message
+    ldr r1, =core0_sram_start
+    subs r0, r1
+    ldr r1, =CORE0_SRAM_CODE
+    adds r0, r1
+    bl core0_sram_puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+15:
+    b 15b
+
+.thumb_func
+core0_sram_puts:
+    ldr r1, =UART0_DR
+
+16:
+    ldrb r2, [r0]
+    cmp r2, 0
+    beq 17f
+    str r2, [r1]
+    adds r0, 1
+    b 16b
+
+17:
+    bx lr
+
+.align 2
+core0_sram_ok_message:
+    .asciz "PICO TCG FLASH BUSY LOCKOUT OK\n"
+core0_sram_no_fault_message:
+    .asciz "PICO TCG FLASH BUSY LOCKOUT FAIL: NO FAULT\n"
+
+.ltorg
+.align 2
+core0_sram_end:
+
+core1_sram_start:
+    .word CORE1_STACK
+    .word CORE1_SRAM_VTOR + (core1_sram_entry - core1_sram_start) + 1
+    .word 0
+    .word 0
+    .space 0x80 - 16
+    .word CORE1_SRAM_VTOR + (core1_sram_fifo_irq - core1_sram_start) + 1
+    .space 0x100 - 0x84
+
+.thumb_func
+core1_sram_entry:
+    ldr r0, =SCB_VTOR
+    ldr r1, =CORE1_SRAM_VTOR
+    str r1, [r0]
+    ldr r0, =NVIC_ISER
+    ldr r1, =SIO_IRQ_PROC1_MASK
+    str r1, [r0]
+    cpsie i
+
+18:
+    wfe
+    b 18b
+
+.thumb_func
+core1_sram_fifo_irq:
+    push {r0, r1, r2, r3, lr}
+    bl core1_sram_fifo_pop
+    ldr r1, =LOCK_REQUEST
+    cmp r0, r1
+    bne core1_sram_bad_request
+    ldr r0, =LOCK_ACK
+    bl core1_sram_fifo_push
+
+19:
+    wfe
+    b 19b
+
+core1_sram_bad_request:
+    ldr r0, =BAD_ACK
+    bl core1_sram_fifo_push
+
+20:
+    b 20b
+
+.thumb_func
+core1_sram_fifo_push:
+    ldr r1, =SIO_BASE
+
+21:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_RDY
+    tst r2, r3
+    beq 21b
+    str r0, [r1, SIO_FIFO_WR]
+    bx lr
+
+.thumb_func
+core1_sram_fifo_pop:
+    ldr r1, =SIO_BASE
+
+22:
+    ldr r2, [r1, SIO_FIFO_ST]
+    movs r3, SIO_FIFO_ST_VLD
+    tst r2, r3
+    beq 22b
+    ldr r0, [r1, SIO_FIFO_RD]
+    bx lr
+
+.ltorg
+.align 2
+core1_sram_end:
+
+.section .rodata, "a", %progbits
+.align 2
+launch_sequence:
+    .word 0
+    .word 0
+    .word 1
+    .word CORE1_SRAM_VTOR
+    .word CORE1_STACK
+    .word CORE1_SRAM_VTOR + (core1_sram_entry - core1_sram_start) + 1
+
+start_message:
+    .asciz "PICO TCG FLASH BUSY START\n"
+launch_message:
+    .asciz "PICO TCG FLASH BUSY CORE1 SRAM OK\n"
+locked_message:
+    .asciz "PICO TCG FLASH BUSY LOCKED\n"
+fail_launch_message:
+    .asciz "PICO TCG FLASH BUSY FAIL: LAUNCH\n"
+fail_spinlock_message:
+    .asciz "PICO TCG FLASH BUSY FAIL: SPINLOCK\n"
+fail_fifo_message:
+    .asciz "PICO TCG FLASH BUSY FAIL: FIFO\n"
+fail_return_message:
+    .asciz "PICO TCG FLASH BUSY FAIL: RETURN\n"
+fail_exception_message:
+    .asciz "PICO TCG FLASH BUSY FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-flash-busy-lockout.ref b/tests/tcg/arm/system/rp2040-flash-busy-lockout.ref
new file mode 100644
index 0000000000..53b85daabd
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-busy-lockout.ref
@@ -0,0 +1,4 @@
+PICO TCG FLASH BUSY START
+PICO TCG FLASH BUSY CORE1 SRAM OK
+PICO TCG FLASH BUSY LOCKED
+PICO TCG FLASH BUSY LOCKOUT OK
diff --git a/tests/tcg/arm/system/rp2040-flash-commands.S b/tests/tcg/arm/system/rp2040-flash-commands.S
new file mode 100644
index 0000000000..a3440fe889
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-commands.S
@@ -0,0 +1,405 @@
+/*
+ * Raspberry Pi Pico flash command and NOR semantics test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_BASE               0x20000000
+#define SRAM_END                0x20042000
+#define UART0_DR                0x40034000
+#define SSI_SSIENR              0x18000008
+#define SSI_SER                 0x18000010
+#define SSI_RXFLR               0x18000024
+#define SSI_DR0                 0x18000060
+#define XIP_TARGET              0x10001000
+#define FLASH_TARGET_OFFSET     0x00001000
+#define FLASH_STATUS_WIP        0x01
+#define FLASH_STATUS_WEL        0x02
+#define SYS_EXIT                0x18
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
+    ldr r0, =SRAM_BASE
+    ldr r1, =ram_code_start
+    ldr r2, =ram_code_end
+
+copy_loop:
+    cmp r1, r2
+    bhs copy_done
+    ldr r3, [r1]
+    str r3, [r0]
+    adds r0, 4
+    adds r1, 4
+    b copy_loop
+
+copy_done:
+    ldr r0, =SRAM_BASE + 1
+    bx r0
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.align 2
+ram_code_start:
+.thumb_func
+ram_main:
+    ldr r0, =SSI_SSIENR
+    movs r1, 0
+    str r1, [r0]
+    movs r1, 1
+    str r1, [r0]
+
+    ldr r0, =XIP_TARGET
+    ldr r1, =flash_message
+    movs r2, 5
+
+check_persisted_loop:
+    ldrb r3, [r0]
+    ldrb r4, [r1]
+    cmp r3, r4
+    bne run_command_tests
+    adds r0, 1
+    adds r1, 1
+    subs r2, 1
+    bne check_persisted_loop
+
+    ldr r0, =persist_ok_message
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+run_command_tests:
+    ldr r0, =start_message
+    bl puts
+
+    bl write_enable
+    bl expect_wel
+    ldr r0, =FLASH_TARGET_OFFSET
+    bl erase_sector
+    bl expect_busy_wel_clear
+    bl expect_target_erased
+
+    bl write_enable
+    bl expect_wel
+    ldr r0, =FLASH_TARGET_OFFSET
+    ldr r1, =flash_message
+    movs r2, 5
+    bl program_data
+    bl expect_busy_wel_clear
+    bl expect_flash_message
+    ldr r0, =program_ok_message
+    bl puts
+
+    bl write_enable
+    ldr r0, =FLASH_TARGET_OFFSET
+    bl erase_sector
+    bl expect_busy_wel_clear
+    bl expect_target_erased
+    ldr r0, =erase_ok_message
+    bl puts
+
+    bl write_enable
+    ldr r0, =FLASH_TARGET_OFFSET
+    ldr r1, =flash_message
+    movs r2, 5
+    bl program_data
+    bl expect_busy_wel_clear
+    bl expect_flash_message
+
+    ldr r0, =FLASH_TARGET_OFFSET + 8
+    ldr r1, =no_wel_value
+    movs r2, 1
+    bl program_data
+    bl read_status
+    movs r1, FLASH_STATUS_WIP | FLASH_STATUS_WEL
+    tst r0, r1
+    beq 8f
+    b fail_no_wel
+8:
+    ldr r1, =XIP_TARGET + 8
+    ldrb r0, [r1]
+    cmp r0, 0xff
+    beq 9f
+    b fail_no_wel
+9:
+    ldr r0, =no_wel_ok_message
+    bl puts
+
+    bl write_enable
+    ldr r0, =FLASH_TARGET_OFFSET + 16
+    ldr r1, =zero_value
+    movs r2, 1
+    bl program_data
+    bl expect_busy_wel_clear
+    bl write_enable
+    ldr r0, =FLASH_TARGET_OFFSET + 16
+    ldr r1, =erased_value
+    movs r2, 1
+    bl program_data
+    bl expect_busy_wel_clear
+    ldr r1, =XIP_TARGET + 16
+    ldrb r0, [r1]
+    cmp r0, 0
+    beq 10f
+    b fail_old_and_new
+10:
+    ldr r0, =old_and_new_ok_message
+    bl puts
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
+.thumb_func
+write_enable:
+    push {lr}
+    bl select_flash
+    movs r0, 0x06
+    bl ssi_byte
+    bl deselect_flash
+    pop {pc}
+
+.thumb_func
+read_status:
+    push {r4, lr}
+    bl select_flash
+    movs r0, 0x05
+    bl ssi_byte
+    mov r4, r0
+    bl deselect_flash
+    mov r0, r4
+    pop {r4, pc}
+
+.thumb_func
+expect_wel:
+    push {lr}
+    bl read_status
+    movs r1, FLASH_STATUS_WEL
+    tst r0, r1
+    beq fail_wel
+    pop {pc}
+
+.thumb_func
+expect_busy_wel_clear:
+    push {lr}
+    bl read_status
+    movs r1, FLASH_STATUS_WIP
+    tst r0, r1
+    beq fail_status
+    movs r1, FLASH_STATUS_WEL
+    tst r0, r1
+    bne fail_status
+    pop {pc}
+
+.thumb_func
+erase_sector:
+    push {r4, lr}
+    mov r4, r0
+    bl select_flash
+    movs r0, 0x20
+    bl ssi_byte
+    lsrs r0, r4, 16
+    bl ssi_byte
+    lsrs r0, r4, 8
+    bl ssi_byte
+    mov r0, r4
+    bl ssi_byte
+    bl deselect_flash
+    pop {r4, pc}
+
+.thumb_func
+program_data:
+    push {r4, r5, r6, lr}
+    mov r4, r0
+    mov r5, r1
+    mov r6, r2
+    bl select_flash
+    movs r0, 0x02
+    bl ssi_byte
+    lsrs r0, r4, 16
+    bl ssi_byte
+    lsrs r0, r4, 8
+    bl ssi_byte
+    mov r0, r4
+    bl ssi_byte
+
+program_loop:
+    cmp r6, 0
+    beq program_done
+    ldrb r0, [r5]
+    bl ssi_byte
+    adds r5, 1
+    subs r6, 1
+    b program_loop
+
+program_done:
+    bl deselect_flash
+    pop {r4, r5, r6, pc}
+
+.thumb_func
+select_flash:
+    ldr r1, =SSI_SER
+    movs r0, 1
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+deselect_flash:
+    ldr r1, =SSI_SER
+    movs r0, 0
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+ssi_byte:
+    ldr r2, =SSI_DR0
+    str r0, [r2]
+    ldr r3, =SSI_RXFLR
+
+2:
+    ldr r0, [r3]
+    cmp r0, 0
+    beq 2b
+    ldr r0, [r2]
+    bx lr
+
+.thumb_func
+expect_target_erased:
+    ldr r1, =XIP_TARGET
+    movs r2, 20
+
+3:
+    ldrb r0, [r1]
+    cmp r0, 0xff
+    bne fail_erase
+    adds r1, 1
+    subs r2, 1
+    bne 3b
+    bx lr
+
+.thumb_func
+expect_flash_message:
+    ldr r0, =XIP_TARGET
+    ldr r1, =flash_message
+    movs r2, 5
+
+4:
+    ldrb r3, [r0]
+    ldrb r4, [r1]
+    cmp r3, r4
+    bne fail_program
+    adds r0, 1
+    adds r1, 1
+    subs r2, 1
+    bne 4b
+    bx lr
+
+fail_wel:
+    ldr r0, =fail_wel_message
+    b test_failed
+
+fail_status:
+    ldr r0, =fail_status_message
+    b test_failed
+
+fail_program:
+    ldr r0, =fail_program_message
+    b test_failed
+
+fail_erase:
+    ldr r0, =fail_erase_message
+    b test_failed
+
+fail_no_wel:
+    ldr r0, =fail_no_wel_message
+    b test_failed
+
+fail_old_and_new:
+    ldr r0, =fail_old_and_new_message
+
+test_failed:
+    bl puts
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_RUNTIME_ERROR
+    bkpt 0xab
+
+5:
+    b 5b
+
+.thumb_func
+puts:
+    ldr r2, =UART0_DR
+
+6:
+    ldrb r1, [r0]
+    cmp r1, 0
+    beq 7f
+    str r1, [r2]
+    adds r0, 1
+    b 6b
+
+7:
+    bx lr
+
+.align 2
+flash_message:
+    .ascii "FLASH"
+no_wel_value:
+    .byte 0xa5
+zero_value:
+    .byte 0x00
+erased_value:
+    .byte 0xff
+start_message:
+    .asciz "PICO TCG FLASH COMMANDS START\n"
+program_ok_message:
+    .asciz "PICO TCG FLASH PROGRAM OK\n"
+erase_ok_message:
+    .asciz "PICO TCG FLASH ERASE OK\n"
+no_wel_ok_message:
+    .asciz "PICO TCG FLASH NO WEL OK\n"
+old_and_new_ok_message:
+    .asciz "PICO TCG FLASH OLD AND NEW OK\n"
+ok_message:
+    .asciz "PICO TCG FLASH COMMANDS OK\n"
+persist_ok_message:
+    .asciz "PICO TCG FLASH PERSIST OK\n"
+fail_wel_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: WEL\n"
+fail_status_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: STATUS\n"
+fail_program_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: PROGRAM\n"
+fail_erase_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: ERASE\n"
+fail_no_wel_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: NO WEL\n"
+fail_old_and_new_message:
+    .asciz "PICO TCG FLASH COMMANDS FAIL: OLD AND NEW\n"
+.align 2
+.ltorg
+ram_code_end:
diff --git a/tests/tcg/arm/system/rp2040-flash-commands.ref b/tests/tcg/arm/system/rp2040-flash-commands.ref
new file mode 100644
index 0000000000..ac90dcb404
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-commands.ref
@@ -0,0 +1,6 @@
+PICO TCG FLASH COMMANDS START
+PICO TCG FLASH PROGRAM OK
+PICO TCG FLASH ERASE OK
+PICO TCG FLASH NO WEL OK
+PICO TCG FLASH OLD AND NEW OK
+PICO TCG FLASH COMMANDS OK
diff --git a/tests/tcg/arm/system/rp2040-flash-ioqspi.S b/tests/tcg/arm/system/rp2040-flash-ioqspi.S
new file mode 100644
index 0000000000..081c643529
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-ioqspi.S
@@ -0,0 +1,212 @@
+/*
+ * Raspberry Pi Pico IO_QSPI chip-select flash command test.
+ *
+ * Copyright 2026 Gilles Grimaud
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_BASE               0x20000000
+#define SRAM_END                0x20042000
+#define UART0_DR                0x40034000
+#define SSI_CTRLR0              0x18000000
+#define SSI_SSIENR              0x18000008
+#define SSI_RXFLR               0x18000024
+#define SSI_DR0                 0x18000060
+#define IO_QSPI_SS_CTRL         0x4001800c
+#define XIP_TARGET              0x10001200
+#define FLASH_TARGET_OFFSET     0x00001200
+#define SYS_EXIT                0x18
+#define ADP_STOPPED_APPLICATION_EXIT 0x20026
+#define ADP_STOPPED_RUNTIME_ERROR    0x20023
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
+    ldr r0, =SRAM_BASE
+    ldr r1, =ram_code_start
+    ldr r2, =ram_code_end
+
+copy_loop:
+    cmp r1, r2
+    bhs copy_done
+    ldr r3, [r1]
+    str r3, [r0]
+    adds r0, 4
+    adds r1, 4
+    b copy_loop
+
+copy_done:
+    ldr r0, =SRAM_BASE + 1
+    bx r0
+
+.thumb_func
+default_handler:
+    b default_handler
+
+.align 2
+ram_code_start:
+.thumb_func
+ram_main:
+    ldr r0, =start_message
+    bl puts
+    ldr r1, =SSI_SSIENR
+    movs r0, 0
+    str r0, [r1]
+    ldr r1, =SSI_CTRLR0
+    ldr r0, =0x00070000
+    str r0, [r1]
+    ldr r1, =SSI_SSIENR
+    movs r0, 1
+    str r0, [r1]
+
+    bl write_enable
+    bl cs_low
+    movs r0, 0x20
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    movs r0, 0x12
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    bl cs_high
+    bl read_status
+
+    bl write_enable
+    bl cs_low
+    movs r0, 0x02
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    movs r0, 0x12
+    bl ssi_byte
+    movs r0, 0x00
+    bl ssi_byte
+    movs r0, 'Q'
+    bl ssi_byte
+    movs r0, 'S'
+    bl ssi_byte
+    movs r0, 'P'
+    bl ssi_byte
+    movs r0, 'I'
+    bl ssi_byte
+    bl cs_high
+    bl read_status
+
+    ldr r1, =XIP_TARGET
+    ldrb r0, [r1]
+    cmp r0, 'Q'
+    bne test_failed
+    ldrb r0, [r1, 1]
+    cmp r0, 'S'
+    bne test_failed
+    ldrb r0, [r1, 2]
+    cmp r0, 'P'
+    bne test_failed
+    ldrb r0, [r1, 3]
+    cmp r0, 'I'
+    bne test_failed
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
+.thumb_func
+write_enable:
+    push {lr}
+    bl cs_low
+    movs r0, 0x06
+    bl ssi_byte
+    bl cs_high
+    pop {pc}
+
+.thumb_func
+read_status:
+    push {lr}
+    bl cs_low
+    movs r0, 0x05
+    bl ssi_byte
+    bl cs_high
+    pop {pc}
+
+.thumb_func
+ssi_byte:
+    ldr r2, =SSI_DR0
+    str r0, [r2]
+    ldr r3, =SSI_RXFLR
+
+2:
+    ldr r0, [r3]
+    cmp r0, 0
+    beq 2b
+    ldr r0, [r2]
+    bx lr
+
+.thumb_func
+cs_low:
+    ldr r1, =IO_QSPI_SS_CTRL
+    movs r0, 2
+    lsls r0, r0, 8
+    str r0, [r1]
+    bx lr
+
+.thumb_func
+cs_high:
+    ldr r1, =IO_QSPI_SS_CTRL
+    movs r0, 3
+    lsls r0, r0, 8
+    str r0, [r1]
+    bx lr
+
+test_failed:
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
+.align 2
+start_message:
+    .asciz "PICO TCG IO_QSPI FLASH START\n"
+ok_message:
+    .asciz "PICO TCG IO_QSPI FLASH OK\n"
+fail_message:
+    .asciz "PICO TCG IO_QSPI FLASH FAIL\n"
+.align 2
+.ltorg
+ram_code_end:
diff --git a/tests/tcg/arm/system/rp2040-flash-ioqspi.ref b/tests/tcg/arm/system/rp2040-flash-ioqspi.ref
new file mode 100644
index 0000000000..8261199083
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-ioqspi.ref
@@ -0,0 +1,2 @@
+PICO TCG IO_QSPI FLASH START
+PICO TCG IO_QSPI FLASH OK
diff --git a/tests/tcg/arm/system/rp2040-flash-persist-reader.ref b/tests/tcg/arm/system/rp2040-flash-persist-reader.ref
new file mode 100644
index 0000000000..0ac066b0cf
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-persist-reader.ref
@@ -0,0 +1 @@
+PICO TCG FLASH PERSIST OK
diff --git a/tests/tcg/arm/system/rp2040-flash-persist.sh b/tests/tcg/arm/system/rp2040-flash-persist.sh
new file mode 100755
index 0000000000..7119ed68de
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-flash-persist.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -eu
+
+expected=$1
+persist_expected=$2
+shift 2
+
+qemu=$1
+guest=
+for arg do
+    guest=$arg
+done
+
+tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/rp2040-flash-persist.XXXXXX")
+trap 'rm -rf "$tmpdir"' EXIT HUP INT TERM
+
+"$@" > "$tmpdir/commands.out"
+diff -u "$expected" "$tmpdir/commands.out"
+
+dd if=/dev/zero bs=512 count=1 2>/dev/null |
+    tr '\000' '\377' > "$tmpdir/flash.bin"
+
+"$qemu" -display none -monitor none \
+    -M "raspi-pico,strict-uart-pins=off,flash-file=$tmpdir/flash.bin" \
+    -serial null -semihosting-config enable=on,target=native \
+    -kernel "$guest"
+
+"$qemu" -display none -monitor none \
+    -M "raspi-pico,strict-uart-pins=off,flash-file=$tmpdir/flash.bin" \
+    -serial stdio -semihosting-config enable=on,target=native \
+    > "$tmpdir/persist.out"
+diff -u "$persist_expected" "$tmpdir/persist.out"
-- 
2.55.0


