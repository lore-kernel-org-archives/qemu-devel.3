Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB94C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT1ZG-0005Xz-4K; Thu, 25 Jan 2024 10:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rT1ZD-0005Qi-R3; Thu, 25 Jan 2024 10:22:59 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rT1ZB-0007wZ-JL; Thu, 25 Jan 2024 10:22:59 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6daa89a6452so4971985b3a.2; 
 Thu, 25 Jan 2024 07:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706196174; x=1706800974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ICa7rCIzRHezzvI5p5tcpvg1MJA1MmCX0bzbSzFqJ9U=;
 b=B+DIfvAlNl5mKrXZ93dAdzEKpHbBeKS4nybPxIlCqwkWa/DRsmaIfKZo60PPH4+UnY
 HPVmY2Zghgch2ec5Cy4dw0OwJiZuYoubLM86KwrIH4leRhot8rotEx2BZpcVo2FJoXAh
 sNlt0jBIfSw5/E0usj2Fj3MC0sJC2jHc7XKAZchNc90ajDCUIM+jRPmQHnxY+aDOpYEA
 QTQOWVW0hZB6ZGlpZ9om6cFEHzs6V02+1l83uHFLpJC7QMXsSXYz+erZcNYltpXU4y+S
 7vzmuuuZu8M2nbkN9WnJrws2yaX867vSkG3nOtbuTfzx6ueJ2yxDYRWfNVnPdrmPs8Lp
 LNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706196174; x=1706800974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ICa7rCIzRHezzvI5p5tcpvg1MJA1MmCX0bzbSzFqJ9U=;
 b=L0QXOn/tLYXQk/6BQ3dDgMjcDfywX72Yc6zn37ZcHf5PB54Va8JUI/y+8KO5CZQvcw
 zo38K9PyuQv6Kieqyjxhs7bVMbM65msKIRMetC/uTua7BXxpy2UmuMyiq60k/SBDKZFd
 FD0ao9bZWv+qh24ZcWFTSrm0bukI1P7dpFIl0X+QaUY590BRbvxODgXDP5/FAFzTMXCT
 AAOGElCJ4FC7oFcMcwVGek3KakupJ0CL7Td8HBZCDEJ2ipX7jiymOVD6e9uEjDh2iHqQ
 c7nn3l3RjZqsfn6k8UCSR623jLpzJLoyvygfLIzLNGB7UtDkkcn1LUxcJFYYCfEqzQ6R
 HLIA==
X-Gm-Message-State: AOJu0YyBaSZGajX0xgkiMPmrQBF95GNzqyCrqzcOBliVmdMCC7UKmfRS
 gN1aLEEQ+fwn3aJMTES1JHU9I5F9Scl5ZWBufNO2LByg7Gv8i5AztIXkO/ijtR6sPg==
X-Google-Smtp-Source: AGHT+IFSR1EO7itIyFu6nkRfsudvc6p21/Hd02F6qkiry4aIflZLq6uvbvTQ2AyZA0akHSya56dBNw==
X-Received: by 2002:a05:6a21:2d89:b0:19c:768b:b77a with SMTP id
 ty9-20020a056a212d8900b0019c768bb77amr984783pzb.113.1706196174281; 
 Thu, 25 Jan 2024 07:22:54 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 z2-20020aa785c2000000b006d99d986624sm15930366pfn.151.2024.01.25.07.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:22:53 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v4] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
Date: Thu, 25 Jan 2024 20:49:32 +0530
Message-Id: <20240125151931.83494-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch implements a 32 half word FIFO as per imx serial device
specifications. If a non empty FIFO is below the trigger level, an ageing
timer will tick for a duration of 8 characters. On expiry, AGTIM will be set
triggering an interrupt. AGTIM timer resets when there is activity in
the receive FIFO.

Otherwise, RRDY is set when trigger level is
exceeded. The receive trigger level is 8 in newer kernel versions and 1 in
older ones.

This change will break migration compatibility.

[Changes in v4]

- Correct handling of fifo overflow including ORE and OVRRUN flag setting.
- Correct behaviour of empty FIFO popping.
- Remove unnecessary RRDYEN check in can_receive.
- In ageing timer restart function, use flag checks instead of directly
  checking FIFO levels.
- Further fixes to code formatting.

[Changes in v3]

- Caught more whitespace changes that went overlooked
- Moved fifo and timer initialization to realize

[Changes in v2]

As per Peter Maydell's suggestions,

- Use generic FIFO32 implementation in place of handmade impl.
- Moved timer_init to serial init and use timer_del in reset
- Removed stray whitespaces
- Increment VMSTATE version

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/char/imx_serial.c         | 102 ++++++++++++++++++++++++++++++-----
 include/hw/char/imx_serial.h |  20 ++++++-
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1df862eb7f..ba37be6faa 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -26,6 +26,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/fifo32.h"
 
 #ifndef DEBUG_IMX_UART
 #define DEBUG_IMX_UART 0
@@ -41,10 +42,11 @@
 
 static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32(readbuff, IMXSerialState),
+        VMSTATE_FIFO32(rx_fifo, IMXSerialState),
+        VMSTATE_TIMER(ageing_timer, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
         VMSTATE_UINT32(ucr1, IMXSerialState),
@@ -71,6 +73,10 @@ static void imx_update(IMXSerialState *s)
      * following:
      */
     usr1 = s->usr1 & s->ucr1 & (USR1_TRDY | USR1_RRDY);
+    /*
+     * Interrupt if AGTIM is set (ageing timer interrupt in RxFIFO)
+     */
+    usr1 |= (s->ucr2 & UCR2_ATEN) ? (s->usr1 & USR1_AGTIM) : 0;
     /*
      * Bits that we want in USR2 are not as conveniently laid out,
      * unfortunately.
@@ -78,15 +84,66 @@ static void imx_update(IMXSerialState *s)
     mask = (s->ucr1 & UCR1_TXMPTYEN) ? USR2_TXFE : 0;
     /*
      * TCEN and TXDC are both bit 3
+     * ORE and OREN are both bit 1
      * RDR and DREN are both bit 0
      */
-    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN);
+    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN | UCR4_OREN);
 
     usr2 = s->usr2 & mask;
 
     qemu_set_irq(s->irq, usr1 || usr2);
 }
 
+static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
+{
+    uint32_t pushed_value = value;
+    if (fifo32_is_full(&s->rx_fifo)) {
+        /* Set ORE if FIFO is already full */
+        s->usr2 |= USR2_ORE;
+    } else {
+        if (fifo32_num_used(&s->rx_fifo) == FIFO_SIZE - 1) {
+            /* Set OVRRUN on 32nd character in FIFO */
+            pushed_value |= URXD_ERR | URXD_OVRRUN;
+        }
+        fifo32_push(&s->rx_fifo, pushed_value);
+    }
+}
+
+static uint32_t imx_serial_rx_fifo_pop(IMXSerialState *s)
+{
+    if (fifo32_is_empty(&s->rx_fifo)) {
+        return 0;
+    }
+    return fifo32_pop(&s->rx_fifo);
+}
+
+static void imx_serial_rx_fifo_ageing_timer_int(void *opaque)
+{
+    IMXSerialState *s = (IMXSerialState *) opaque;
+    s->usr1 |= USR1_AGTIM;
+    imx_update(s);
+}
+
+static void imx_serial_rx_fifo_ageing_timer_restart(void *opaque)
+{
+    /*
+     * Ageing timer starts ticking when
+     * RX FIFO is non empty and below trigger level.
+     * Timer is reset if new character is received or
+     * a FIFO read occurs.
+     * Timer triggers an interrupt when duration of
+     * 8 characters has passed (assuming 115200 baudrate).
+     */
+    IMXSerialState *s = (IMXSerialState *) opaque;
+
+    if (!(s->usr1 & USR1_RRDY) && !(s->uts1 & UTS1_RXEMPTY)) {
+        timer_mod_ns(&s->ageing_timer,
+                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + AGE_DURATION_NS);
+    } else {
+        timer_del(&s->ageing_timer);
+    }
+}
+
 static void imx_serial_reset(IMXSerialState *s)
 {
 
@@ -102,7 +159,9 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
-    s->readbuff = URXD_ERR;
+
+    fifo32_reset(&s->rx_fifo);
+    timer_del(&s->ageing_timer);
 }
 
 static void imx_serial_reset_at_boot(DeviceState *dev)
@@ -125,20 +184,28 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
                                 unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    uint32_t c;
+    uint32_t c, rx_used;
+    uint8_t rxtl = s->ufcr & TL_MASK;
 
     DPRINTF("read(offset=0x%" HWADDR_PRIx ")\n", offset);
 
     switch (offset >> 2) {
     case 0x0: /* URXD */
-        c = s->readbuff;
+        c = imx_serial_rx_fifo_pop(s);
         if (!(s->uts1 & UTS1_RXEMPTY)) {
             /* Character is valid */
             c |= URXD_CHARRDY;
-            s->usr1 &= ~USR1_RRDY;
-            s->usr2 &= ~USR2_RDR;
-            s->uts1 |= UTS1_RXEMPTY;
+            rx_used = fifo32_num_used(&s->rx_fifo);
+            /* Clear RRDY if below threshold */
+            if (rx_used < rxtl) {
+                s->usr1 &= ~USR1_RRDY;
+            }
+            if (rx_used == 0) {
+                s->usr2 &= ~USR2_RDR;
+                s->uts1 |= UTS1_RXEMPTY;
+            }
             imx_update(s);
+            imx_serial_rx_fifo_ageing_timer_restart(s);
             qemu_chr_fe_accept_input(&s->chr);
         }
         return c;
@@ -300,19 +367,24 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 static int imx_can_receive(void *opaque)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    return !(s->usr1 & USR1_RRDY);
+    return s->ucr2 & UCR2_RXEN && fifo32_num_used(&s->rx_fifo) < FIFO_SIZE;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
+    uint8_t rxtl = s->ufcr & TL_MASK;
 
     DPRINTF("received char\n");
+    imx_serial_rx_fifo_push(s, value);
+    if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
+        s->usr1 |= USR1_RRDY;
+    }
+
+    imx_serial_rx_fifo_ageing_timer_restart(s);
 
-    s->usr1 |= USR1_RRDY;
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
-    s->readbuff = value;
     if (value & URXD_BRK) {
         s->usr2 |= USR2_BRCD;
     }
@@ -345,6 +417,10 @@ static void imx_serial_realize(DeviceState *dev, Error **errp)
 {
     IMXSerialState *s = IMX_SERIAL(dev);
 
+    fifo32_create(&s->rx_fifo, FIFO_SIZE);
+    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
+                  imx_serial_rx_fifo_ageing_timer_int, s);
+
     DPRINTF("char dev for uart: %p\n", qemu_chr_fe_get_driver(&s->chr));
 
     qemu_chr_fe_set_handlers(&s->chr, imx_can_receive, imx_receive,
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index b823f94519..65f0e97c76 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -21,12 +21,16 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "qemu/fifo32.h"
 
 #define TYPE_IMX_SERIAL "imx.serial"
 OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 
+#define FIFO_SIZE       32
+
 #define URXD_CHARRDY    (1<<15)   /* character read is valid */
 #define URXD_ERR        (1<<14)   /* Character has error */
+#define URXD_OVRRUN     (1<<13)   /* 32nd character in RX FIFO */
 #define URXD_FRMERR     (1<<12)   /* Character has frame error */
 #define URXD_BRK        (1<<11)   /* Break received */
 
@@ -65,11 +69,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 #define UCR1_TXMPTYEN   (1<<6)    /* Tx Empty Interrupt Enable */
 #define UCR1_UARTEN     (1<<0)    /* UART Enable */
 
+#define UCR2_ATEN       (1<<3)    /* Ageing Timer Enable */
 #define UCR2_TXEN       (1<<2)    /* Transmitter enable */
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
 
 #define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
+#define UCR4_OREN       BIT(1)    /* Overrun interrupt enable */
 #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
 #define UCR4_WKEN       BIT(7)    /* WAKE interrupt enable */
 
@@ -78,13 +84,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
 #define UTS1_TXFULL     (1<<4)
 #define UTS1_RXFULL     (1<<3)
 
+#define TL_MASK         0x3f
+
+ /* Bit time in nanoseconds assuming maximum baud rate of 115200 */
+#define BIT_TIME_NS     8681
+
+/* Assume 8 bits per character */
+#define NUM_BITS        8
+
+/* Ageing timer triggers after 8 characters */
+#define AGE_DURATION_NS (8 * NUM_BITS * BIT_TIME_NS)
+
 struct IMXSerialState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion iomem;
-    int32_t readbuff;
+    QEMUTimer ageing_timer;
+    Fifo32 rx_fifo;
 
     uint32_t usr1;
     uint32_t usr2;
-- 
2.34.1


