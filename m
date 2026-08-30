Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3952DC61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yrc-0002gO-TL; Sun, 30 Aug 2026 02:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrb-0002er-2H; Sun, 30 Aug 2026 02:17:55 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0YrY-0005J0-D2; Sun, 30 Aug 2026 02:17:54 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXhjp3s7qzBqYk;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070638;
 bh=SmE0oazU4gxkDkJwfNizh86WOIHEMkky/buRlU3j15A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hf1yfjEnz0g7DHv04/kHTNcyqbUu1xXW2sVT+BdNzTwvlHLykz8I6MDa6l+jkw1Yk
 XsO88iV0d4MqXLeYlkhOYoEtid78u8NmavpbsrJY6dpA4cO8m7ktVu1X5okw7WsL5r
 sy+wdPKoMSdUH+iKaoSBvUJWE5WuyK71+tmH+OBqAGnxlEqMCxtPZ6Yq6CamArAX8+
 0UKgAnG1ZGtRfCh8cpk8+hYucf10F3izvYpL1+RbxcM8Zh4MScpIH9Tsn6GveLzjtq
 v8X8BCxRgMJ5iu81kksMXxQps6hmfqrqwjux+Q4JePBFMDkoZqfM4hqAqvGLyCs9Hc
 1//70F650xq4w==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjp2ThDz7swM;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 23/30] tests/tcg/arm: test RP2040 DMA transfers
Date: Sun, 30 Aug 2026 08:15:54 +0200
Message-ID: <20260830061601.52136-9-gilles.grimaud@univ-lille.fr>
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

Add source-built bare-metal tests for memory copy and fill transfers, completion status and interrupt acknowledgement.\n\nExercise UART0 and UART1 transmit and receive pacing through their DMA request lines. Each UART test waits for DMA IRQ completion and validates looped-back input before reporting success.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/tcg/arm/Makefile.softmmu-target      |  34 ++-
 tests/tcg/arm/system/rp2040-dma-memory.S   | 198 +++++++++++++++
 tests/tcg/arm/system/rp2040-dma-memory.ref |   4 +
 tests/tcg/arm/system/rp2040-dma-uart.S     | 267 +++++++++++++++++++++
 tests/tcg/arm/system/rp2040-dma-uart0.ref  |   3 +
 tests/tcg/arm/system/rp2040-dma-uart1.ref  |   3 +
 6 files changed, 505 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-memory.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart.S
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart0.ref
 create mode 100644 tests/tcg/arm/system/rp2040-dma-uart1.ref

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index c282ff5ad0..acb90458be 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -28,8 +28,10 @@ RP2040_FLASH_TESTS=rp2040-flash-commands rp2040-flash-ioqspi \
 	rp2040-flash-busy-hardfault rp2040-flash-busy-lockout \
 	rp2040-core0-xip-fault rp2040-core1-xip-fault
 
+RP2040_DMA_TESTS=rp2040-dma-memory rp2040-dma-uart0 rp2040-dma-uart1
+
 RP2040_GUESTS=$(RP2040_TESTS) $(RP2040_FLASH_TESTS) \
-	rp2040-flash-persist-reader
+	rp2040-dma-memory rp2040-flash-persist-reader
 
 $(RP2040_GUESTS): %: %.S rp2040-boot2-w25q080.S rp2040.ld
 	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
@@ -46,7 +48,8 @@ run-rp2040-sio-fifo run-rp2040-sio-divider \
 run-rp2040-psm-proc1 run-rp2040-core1-launch run-rp2040-timer \
 run-rp2040-flash-commands run-rp2040-flash-ioqspi \
 run-rp2040-flash-busy-hardfault run-rp2040-flash-busy-lockout \
-run-rp2040-core0-xip-fault run-rp2040-core1-xip-fault: \
+run-rp2040-core0-xip-fault run-rp2040-core1-xip-fault \
+run-rp2040-dma-memory: \
 	QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
 	-serial chardev:output \
 	-semihosting-config enable=on,target=native -kernel
@@ -57,7 +60,8 @@ run-rp2040-psm-proc1 run-rp2040-core1-launch \
 run-rp2040-timer run-rp2040-flash-ioqspi \
 run-rp2040-flash-busy-hardfault run-rp2040-flash-busy-lockout \
 run-rp2040-core0-xip-fault \
-run-rp2040-core1-xip-fault: run-rp2040-%: rp2040-%
+run-rp2040-core1-xip-fault \
+run-rp2040-dma-memory: run-rp2040-%: rp2040-%
 	$(call run-test, $<, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
@@ -84,7 +88,29 @@ run-rp2040-flash-commands: rp2040-flash-commands \
 	$(call diff-out,$<.persist,$(ARM_SRC)/rp2040-flash-persist-reader.ref)
 	rm -f $<.flash $<.persist.out
 
-ARM_TESTS+=$(RP2040_TESTS) $(RP2040_FLASH_TESTS)
+rp2040-dma-uart0 rp2040-dma-uart1: rp2040-dma-uart%: \
+		rp2040-dma-uart.S rp2040-boot2-w25q080.S rp2040.ld
+	$(CC) -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
+		-DUART_INDEX=$* -Wl,--build-id=none -x assembler-with-cpp \
+		$(ARM_SRC)/rp2040-boot2-w25q080.S $< \
+		-o $@ -nostdlib -static \
+		-T $(ARM_SRC)/rp2040.ld
+
+run-rp2040-dma-uart0: QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
+	-serial chardev:output \
+	-semihosting-config enable=on,target=native -kernel
+run-rp2040-dma-uart1: QEMU_OPTS=-M raspi-pico,strict-uart-pins=off \
+	-serial null -serial chardev:output \
+	-semihosting-config enable=on,target=native -kernel
+
+run-rp2040-dma-uart0 run-rp2040-dma-uart1: run-%: %
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  $(QEMU_OPTS) $<)
+	$(call diff-out,$<,$(ARM_SRC)/$<.ref)
+
+ARM_TESTS+=$(RP2040_TESTS) $(RP2040_FLASH_TESTS) $(RP2040_DMA_TESTS)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
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


