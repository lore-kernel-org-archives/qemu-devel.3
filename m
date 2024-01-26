Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA503C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHQ-0002dG-18; Fri, 26 Jan 2024 09:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHM-0002S0-4j
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:00 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHK-0007z7-2D
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:59 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-339289fead2so522683f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279636; x=1706884436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6GdiHkmihi3/CT5xTxzMMWZkQ0ZumRMBWRBDkHYF3cM=;
 b=HS4FzEvbXAzrow0tGa7JlFxepfrHvM6FhtXEJWSnCRsKmimebZG6u0sKsMc2AzMA5s
 dJ3qOyywTPIVxLQFVOa5FbIFYqKXoQpSirMnPt20kf8rkWb7z92zNuKICdC9Nwqw3+0d
 mlbSLMW3xXTHwyxkt4mLOVKa9YzpU57j6u3VP1YvghbelmQvFEXwo4S03KBbX0l68RLc
 WDvz1aYTlJ3i0TS8GE7gp7OuaYtMWD2OYeyJLYU/eyvlxBz12datRdm8pwQ/ACVwefsw
 LK2odhqR+QmLL01DxogAXcCh6CyYkB2pudaqd6MipyW+ZpgLDH0c2MyfL///9O/Ig9h+
 bNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279636; x=1706884436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GdiHkmihi3/CT5xTxzMMWZkQ0ZumRMBWRBDkHYF3cM=;
 b=CMt4g7dxuED9BthGXi0kS4qYKEoPet4DIb7pHtnPymrRMQKsfCSnjpddJcn5z3PpT7
 OFX071yunWZAZTEfwF22HdbqfV4E23nclCIg0fY0YqKiFOgCrEN8Gwh5xRPaoo4rByBC
 pxQp6pSPzio5A4ew4dFr8qfeOpg8F4G+675FxL/oJQNrM9GD87gsoliCGO8nAxJXJwxD
 Dm0qSf7yRAN3288zJebJoB5X4kJIwTgmFeUg5dXEEoe7OCw6ae6Mah1w+fofU/yC9pLl
 vnieV8qb5Vl8LFbAd+dhLJ6JbSY+uv0EtIARnHCB9tZJZh/+yDY1f9aLpouKBuZe+T2H
 XchQ==
X-Gm-Message-State: AOJu0YwyhrpvDiCoA57olg7kPJb8IgKWzCU2cmj/cBdxikPr4A2/GlyS
 jnlxzUrD7QnsLDgaIxoRFOAhUnrQ04Ofok2yK+O+HfngGpX7D8lolvJl+23dRUwQ9beq9oa3ukV
 5
X-Google-Smtp-Source: AGHT+IGnhXC9n4txh3nwEVwkGsFb6F0MNe4S3MfyCgzrS8pcOu8zEHl75/65Sm9GCklBo9ehi2YnJQ==
X-Received: by 2002:a5d:5741:0:b0:337:c943:5f04 with SMTP id
 q1-20020a5d5741000000b00337c9435f04mr984971wrw.90.1706279636735; 
 Fri, 26 Jan 2024 06:33:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/36] hw/char/imx_serial: Implement receive FIFO and ageing
 timer
Date: Fri, 26 Jan 2024 14:33:37 +0000
Message-Id: <20240126143341.2101237-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

This patch implements a 32 half word FIFO as per imx serial device
specifications.  If a non empty FIFO is below the trigger level, an
ageing timer will tick for a duration of 8 characters.  On expiry,
AGTIM will be set triggering an interrupt.  AGTIM timer resets when
there is activity in the receive FIFO.

Otherwise, RRDY is set when trigger level is exceeded.  The receive
trigger level is 8 in newer kernel versions and 1 in older ones.

This change will break migration compatibility for the imx boards.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Message-id: 20240125151931.83494-1-rayhan.faizel@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: commit message tidyups]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/imx_serial.h |  20 ++++++-
 hw/char/imx_serial.c         | 102 ++++++++++++++++++++++++++++++-----
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index b823f945195..65f0e97c76b 100644
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
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1df862eb7ff..ba37be6faab 100644
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
-- 
2.34.1


