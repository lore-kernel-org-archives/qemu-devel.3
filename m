Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ACAC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3RrD-0005U8-Pl; Mon, 07 Sep 2026 01:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rr2-0005CG-MK; Mon, 07 Sep 2026 01:25:16 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rr0-00086z-5I; Mon, 07 Sep 2026 01:25:16 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdb9C301zz7vQq;
 Mon,  7 Sep 2026 07:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758671;
 bh=iJAd8xK1wbVjEJStVw35E2Sq0UVDnS9fGGQAa4fj0Xg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CQr8QdzHSLtU/6/jiQDDmBg/AhFquKpqFpjkgfSTSX7ROzexZ167S9+PmuqjAWaU/
 O5PIQDY6yhpSFIRR5J+IZ7zTOacXCGKHgadzF5g2ACibL3s4j+ONh0Jm8Tzd5jme2z
 LXPIZL0yWvrnxFbM9ptOVGsaeuE/DCS4ut6JdDzb60vGX0EfwMR2axEDeF3jDmoubj
 XLMHW4nvEBlFDAoTBlPrwET6wui8XGB9V8ZeOr7B7F+vSewyjtRc+8VeLv7yf04iU8
 QBibHawUufWrmRrl3+V+8RKG4Yr3TJtVB4btMWDxYhG5pbTzZqfntJrWhrKkdE/CHl
 e+qRZukFXVjSw==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb9C1W2bz7xqd;
 Mon,  7 Sep 2026 07:24:31 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 28/36] tests/tcg/arm: test RP2040 DMA transfers
Date: Mon,  7 Sep 2026 07:24:16 +0200
Message-ID: <20260907052426.24849-12-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
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

Add source-built bare-metal tests for memory copy and fill transfers,
completion status and interrupt acknowledgement.

Exercise UART0 and UART1 transmit and receive pacing through their DMA
request lines. Each UART test waits for DMA IRQ completion and validates
looped-back input before reporting success.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/system/meson.build           |  25 ++
 tests/tcg/arm/system/rp2040-dma-memory.S   | 198 +++++++++++++++
 tests/tcg/arm/system/rp2040-dma-memory.ref |   4 +
 tests/tcg/arm/system/rp2040-dma-uart.S     | 267 +++++++++++++++++++++
 tests/tcg/arm/system/rp2040-dma-uart0.ref  |   3 +
 tests/tcg/arm/system/rp2040-dma-uart1.ref  |   3 +
 6 files changed, 500 insertions(+)
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart0.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart1.ref

diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index c57bf5f0d0..a12aed74fa 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -24,6 +24,9 @@ rp2040_qemu_args = ['-M', 'raspi-pico', '-monitor', 'none',
 rp2040_uart_qemu_args = ['-M', 'raspi-pico,strict-uart-pins=off',
                          '-monitor', 'none', '-serial', 'stdio',
                          qemu_base_args]
+rp2040_uart1_qemu_args = ['-M', 'raspi-pico,strict-uart-pins=off',
+                          '-monitor', 'none', '-serial', 'null',
+                          '-serial', 'stdio', qemu_base_args]
 rp2040_flash_persist = find_program('rp2040-flash-persist.sh')
 
 # Multi arch tests
@@ -132,6 +135,28 @@ tests += {
     'qemu_args': rp2040_uart_qemu_args,
     'expected_output': 'rp2040-core1-xip-fault.ref',
   },
+  'rp2040-dma-memory.S': {
+    'cflags': rp2040_cflags,
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-dma-memory.ref',
+  },
+  'rp2040-dma-uart.S': {
+    'exe_name': 'rp2040-dma-uart0',
+    'test_name': 'rp2040-dma-uart0',
+    'cflags': rp2040_cflags + ['-DUART_INDEX=0'],
+    'qemu_args': rp2040_uart_qemu_args,
+    'expected_output': 'rp2040-dma-uart0.ref',
+  },
+}
+
+tests += {
+  'rp2040-dma-uart.S': {
+    'exe_name': 'rp2040-dma-uart1',
+    'test_name': 'rp2040-dma-uart1',
+    'cflags': rp2040_cflags + ['-DUART_INDEX=1'],
+    'qemu_args': rp2040_uart1_qemu_args,
+    'expected_output': 'rp2040-dma-uart1.ref',
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/rp2040-dma-memory.S b/tests/tcg/arm/system/rp2040-dma-memory.S
new file mode 100644
index 0000000000..015c7241dc
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-dma-memory.S
@@ -0,0 +1,198 @@
+/*
+ * Raspberry Pi Pico DMA memory transfer test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#define SRAM_END               0x20042000
+#define UART0_DR               0x40034000
+#define DMA_BASE               0x50000000
+#define DMA_READ_ADDR          0x000
+#define DMA_WRITE_ADDR         0x004
+#define DMA_TRANS_COUNT        0x008
+#define DMA_CTRL_TRIG          0x00c
+#define DMA_INTR               0x400
+#define DMA_CTRL_WORD_COPY     0x001f8039
+#define DMA_CTRL_WORD_FILL     0x001f8029
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
+
+    ldr r5, =copy_source
+    ldr r0, =0x11223344
+    str r0, [r5, #0]
+    ldr r0, =0xaabbccdd
+    str r0, [r5, #4]
+    ldr r0, =0x01020304
+    str r0, [r5, #8]
+    ldr r0, =0xfeedc0de
+    str r0, [r5, #12]
+    ldr r5, =fill_source
+    ldr r0, =0x55aa55aa
+    str r0, [r5]
+
+    ldr r4, =DMA_BASE
+
+    ldr r0, =copy_source
+    str r0, [r4, DMA_READ_ADDR]
+    ldr r0, =copy_destination
+    str r0, [r4, DMA_WRITE_ADDR]
+    movs r0, 4
+    str r0, [r4, DMA_TRANS_COUNT]
+    ldr r0, =DMA_CTRL_WORD_COPY
+    str r0, [r4, DMA_CTRL_TRIG]
+
+    ldr r5, =copy_source
+    ldr r6, =copy_destination
+    movs r3, 4
+
+copy_check_loop:
+    ldr r0, [r5]
+    ldr r1, [r6]
+    cmp r0, r1
+    bne fail_copy
+    adds r5, 4
+    adds r6, 4
+    subs r3, 1
+    bne copy_check_loop
+
+    ldr r6, =DMA_BASE + DMA_INTR
+    ldr r0, [r6]
+    movs r1, 1
+    tst r0, r1
+    beq fail_irq
+    str r1, [r6]
+    ldr r0, [r6]
+    tst r0, r1
+    bne fail_irq
+
+    ldr r0, =copy_ok_message
+    bl puts
+
+    ldr r0, =fill_source
+    str r0, [r4, DMA_READ_ADDR]
+    ldr r0, =fill_destination
+    str r0, [r4, DMA_WRITE_ADDR]
+    movs r0, 4
+    str r0, [r4, DMA_TRANS_COUNT]
+    ldr r0, =DMA_CTRL_WORD_FILL
+    str r0, [r4, DMA_CTRL_TRIG]
+
+    ldr r5, =fill_destination
+    ldr r1, =0x55aa55aa
+    movs r3, 4
+
+fill_check_loop:
+    ldr r0, [r5]
+    cmp r0, r1
+    bne fail_fill
+    adds r5, 4
+    subs r3, 1
+    bne fill_check_loop
+
+    ldr r0, =fill_ok_message
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
+fail_copy:
+    ldr r0, =fail_copy_message
+    b test_failed
+
+fail_fill:
+    ldr r0, =fail_fill_message
+    b test_failed
+
+fail_irq:
+    ldr r0, =fail_irq_message
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
+.section .bss, "aw", %nobits
+.align 2
+copy_source:
+    .space 16
+copy_destination:
+    .space 16
+fill_source:
+    .space 4
+fill_destination:
+    .space 16
+
+.section .rodata, "a", %progbits
+start_message:
+    .asciz "PICO TCG DMA MEMORY START\n"
+copy_ok_message:
+    .asciz "PICO TCG DMA MEMORY COPY OK\n"
+fill_ok_message:
+    .asciz "PICO TCG DMA MEMORY FILL OK\n"
+ok_message:
+    .asciz "PICO TCG DMA MEMORY OK\n"
+fail_copy_message:
+    .asciz "PICO TCG DMA MEMORY FAIL: COPY\n"
+fail_fill_message:
+    .asciz "PICO TCG DMA MEMORY FAIL: FILL\n"
+fail_irq_message:
+    .asciz "PICO TCG DMA MEMORY FAIL: IRQ\n"
+fail_exception_message:
+    .asciz "PICO TCG DMA MEMORY FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-dma-memory.ref b/tests/tcg/arm/system/rp2040-dma-memory.ref
new file mode 100644
index 0000000000..5960220ead
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-dma-memory.ref
@@ -0,0 +1,4 @@
+PICO TCG DMA MEMORY START
+PICO TCG DMA MEMORY COPY OK
+PICO TCG DMA MEMORY FILL OK
+PICO TCG DMA MEMORY OK
diff --git a/tests/tcg/arm/system/rp2040-dma-uart.S b/tests/tcg/arm/system/rp2040-dma-uart.S
new file mode 100644
index 0000000000..36972bbc98
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-dma-uart.S
@@ -0,0 +1,267 @@
+/*
+ * Raspberry Pi Pico UART-paced DMA transfer test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.syntax unified
+.cpu cortex-m0plus
+.thumb
+
+#ifndef UART_INDEX
+#error UART_INDEX must select UART0 or UART1
+#elif UART_INDEX == 0
+#define UART_BASE              0x40034000
+#define DREQ_UART_TX           20
+#define DREQ_UART_RX           21
+#define UART_NAME              "UART0"
+#elif UART_INDEX == 1
+#define UART_BASE              0x40038000
+#define DREQ_UART_TX           22
+#define DREQ_UART_RX           23
+#define UART_NAME              "UART1"
+#else
+#error Unsupported UART_INDEX
+#endif
+
+#define SRAM_END               0x20042000
+#define UART_LCR_H             0x2c
+#define UART_CR                0x30
+#define UART_DMACR             0x48
+#define UART_CR_ENABLED        0x301
+#define UART_CR_LOOPBACK       0x381
+#define DMA_BASE               0x50000000
+#define DMA_READ_ADDR          0x000
+#define DMA_WRITE_ADDR         0x004
+#define DMA_TRANS_COUNT        0x008
+#define DMA_CTRL_TRIG          0x00c
+#define DMA_INTR               0x400
+#define DMA_INTE0              0x404
+#define DMA_CTRL_EN            0x00000001
+#define DMA_CTRL_INCR_R        0x00000010
+#define DMA_CTRL_INCR_W        0x00000020
+#define DMA_CTRL_TX            (DMA_CTRL_EN | DMA_CTRL_INCR_R | \
+                                (DREQ_UART_TX << 15))
+#define DMA_CTRL_RX            (DMA_CTRL_EN | DMA_CTRL_INCR_W | \
+                                (DREQ_UART_RX << 15))
+#define DMA_IRQ_0              11
+#define NVIC_ISER              0xe000e100
+#define NVIC_ICER              0xe000e180
+#define NVIC_ICPR              0xe000e280
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
+    .rept DMA_IRQ_0
+    .word default_handler + 1
+    .endr
+    .word dma_irq_handler + 1
+
+.section .text, "ax", %progbits
+.thumb_func
+.global reset_handler
+reset_handler:
+    cpsid i
+    ldr r0, =UART_BASE
+    movs r1, 0x10
+    str r1, [r0, UART_LCR_H]
+    ldr r1, =UART_CR_ENABLED
+    str r1, [r0, UART_CR]
+    movs r1, 3
+    str r1, [r0, UART_DMACR]
+
+    ldr r0, =NVIC_ICER
+    movs r2, 0
+    mvns r2, r2
+    str r2, [r0]
+    ldr r0, =NVIC_ICPR
+    str r2, [r0]
+    ldr r0, =NVIC_ISER
+    ldr r1, =(1 << DMA_IRQ_0)
+    str r1, [r0]
+    cpsie i
+
+    ldr r0, =start_message
+    movs r1, START_MESSAGE_LEN
+    bl dma_tx
+
+    ldr r0, =UART_BASE
+    ldr r1, =UART_CR_LOOPBACK
+    str r1, [r0, UART_CR]
+    ldr r0, =hello_message
+    movs r1, 5
+    bl dma_tx
+    ldr r0, =UART_BASE
+    ldr r1, =UART_CR_ENABLED
+    str r1, [r0, UART_CR]
+    ldr r0, =newline_message
+    bl puts
+
+    ldr r0, =rx_buffer
+    movs r1, 5
+    bl dma_rx
+
+    ldr r0, =rx_buffer
+    ldr r1, =hello_message
+    movs r2, 5
+
+check_loop:
+    ldrb r3, [r0]
+    ldrb r4, [r1]
+    cmp r3, r4
+    bne fail_data
+    adds r0, 1
+    adds r1, 1
+    subs r2, 1
+    bne check_loop
+
+    ldr r0, =ok_message
+    movs r1, OK_MESSAGE_LEN
+    bl dma_tx
+    movs r0, SYS_EXIT
+    ldr r1, =ADP_STOPPED_APPLICATION_EXIT
+    bkpt 0xab
+
+1:
+    b 1b
+
+fail_data:
+    ldr r0, =fail_data_message
+    b test_failed
+
+fail_irq:
+    ldr r0, =fail_irq_message
+    b test_failed
+
+.thumb_func
+default_handler:
+    ldr r0, =fail_exception_message
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
+dma_tx:
+    push {r4, lr}
+    mov r4, r1
+    bl clear_dma_irq
+    ldr r2, =DMA_BASE
+    str r0, [r2, DMA_READ_ADDR]
+    ldr r3, =UART_BASE
+    str r3, [r2, DMA_WRITE_ADDR]
+    str r4, [r2, DMA_TRANS_COUNT]
+    ldr r3, =DMA_CTRL_TX
+    str r3, [r2, DMA_CTRL_TRIG]
+    bl wait_dma_irq
+    pop {r4, pc}
+
+.thumb_func
+dma_rx:
+    push {r4, lr}
+    mov r4, r1
+    bl clear_dma_irq
+    ldr r2, =DMA_BASE
+    ldr r3, =UART_BASE
+    str r3, [r2, DMA_READ_ADDR]
+    str r0, [r2, DMA_WRITE_ADDR]
+    str r4, [r2, DMA_TRANS_COUNT]
+    ldr r3, =DMA_CTRL_RX
+    str r3, [r2, DMA_CTRL_TRIG]
+    bl wait_dma_irq
+    pop {r4, pc}
+
+.thumb_func
+clear_dma_irq:
+    ldr r2, =irq_flag
+    movs r3, 0
+    str r3, [r2]
+    ldr r2, =DMA_BASE + DMA_INTR
+    movs r3, 1
+    str r3, [r2]
+    ldr r2, =DMA_BASE + DMA_INTE0
+    str r3, [r2]
+    bx lr
+
+.thumb_func
+wait_dma_irq:
+    ldr r2, =irq_flag
+
+3:
+    ldr r3, [r2]
+    movs r4, 1
+    tst r3, r4
+    bne 4f
+    b 3b
+
+4:
+    bx lr
+
+.thumb_func
+dma_irq_handler:
+    ldr r0, =DMA_BASE + DMA_INTR
+    ldr r1, [r0]
+    movs r2, 1
+    tst r1, r2
+    beq fail_irq
+    str r1, [r0]
+    ldr r0, =irq_flag
+    str r1, [r0]
+    bx lr
+
+.thumb_func
+puts:
+    ldr r2, =UART_BASE
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
+.section .bss, "aw", %nobits
+.align 2
+irq_flag:
+    .word 0
+rx_buffer:
+    .space 8
+
+.section .rodata, "a", %progbits
+start_message:
+    .ascii "PICO TCG DMA " UART_NAME " START\n"
+start_message_end:
+hello_message:
+    .ascii "HELLO"
+newline_message:
+    .asciz "\n"
+ok_message:
+    .ascii "PICO TCG DMA " UART_NAME " TX/RX OK\n"
+ok_message_end:
+.equ START_MESSAGE_LEN, start_message_end - start_message
+.equ OK_MESSAGE_LEN, ok_message_end - ok_message
+fail_data_message:
+    .asciz "PICO TCG DMA " UART_NAME " FAIL: DATA\n"
+fail_irq_message:
+    .asciz "PICO TCG DMA " UART_NAME " FAIL: IRQ\n"
+fail_exception_message:
+    .asciz "PICO TCG DMA " UART_NAME " FAIL: EXCEPTION\n"
diff --git a/tests/tcg/arm/system/rp2040-dma-uart0.ref b/tests/tcg/arm/system/rp2040-dma-uart0.ref
new file mode 100644
index 0000000000..5cb57c56cc
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-dma-uart0.ref
@@ -0,0 +1,3 @@
+PICO TCG DMA UART0 START
+HELLO
+PICO TCG DMA UART0 TX/RX OK
diff --git a/tests/tcg/arm/system/rp2040-dma-uart1.ref b/tests/tcg/arm/system/rp2040-dma-uart1.ref
new file mode 100644
index 0000000000..1509dc034a
--- /dev/null
+++ b/tests/tcg/arm/system/rp2040-dma-uart1.ref
@@ -0,0 +1,3 @@
+PICO TCG DMA UART1 START
+HELLO
+PICO TCG DMA UART1 TX/RX OK
-- 
2.55.0


