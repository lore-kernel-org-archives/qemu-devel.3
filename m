Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2231094486
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yY1-00039d-Vl; Sat, 21 Mar 2026 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXw-000372-LA; Sat, 21 Mar 2026 11:47:28 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXs-0003Jw-Cj; Sat, 21 Mar 2026 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=33
 iqMCZUcYPVcy5tmZ1IkGgi+pR1DjAFjfAG8qZP/rs=; b=mRAczWxitTtCSJ0JKM
 deAZnp0xoEYiPq3zwrNKjMGB+N27la/t9nYqiC2pAwAbPf94pcm7gqtGYf0Qf/xV
 0iLxEn9gH+x7tGDi9GAdPN413+mojpVN3i9NU5iPG/AN2at9GH513FCyj03NSpPw
 Knr2J3BLfpKnTa1sLIWEY/dfM=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S5;
 Sat, 21 Mar 2026 23:47:05 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 3/5] Implement the DMA interface of PL011
Date: Sat, 21 Mar 2026 23:46:58 +0800
Message-ID: <ee083c07983216dd9c12aa5c79283b41a3d3c815.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
References: <cover.1774099044.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1ktw1ruw1xtF4DGF45KFg_yoWrJF1xpr
 4kCFs8Kw4Yg3W3ZrZaya1UA3W3Grs7WrW2kr47K34xWayUJwsYqrykta4aqrWxW3y0gryU
 u393Wr4UuFyxuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UArc3UUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-RmX1Wm+vXkX-QAA3f
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Use gpio_out to emulate DMA requests and gpio_in to emulate clear requests.
The DMA function of pl011 is affected by the register UARDMACR.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/char/pl011.c         | 47 ++++++++++++++++++++++++++++++++++++++---
 include/hw/char/pl011.h |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 58803f0fc2..d3fcc6a02b 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -16,6 +16,10 @@
  *  + sysbus IRQ 3: UARTRTINTR (receive timeout interrupt line)
  *  + sysbus IRQ 4: UARTMSINTR (momem status interrupt line)
  *  + sysbus IRQ 5: UARTEINTR (error interrupt line)
+ *  + sysbus IRQ 6: UARTTXDMASREQ (transmit DMA single request)
+ *  + sysbus IRQ 7: UARTRXDMASREQ (receive DMA single request)
+ *  + sysbus IRQ 8: UARTTXDMABREQ (transmit DMA burst request)
+ *  + sysbus IRQ 9: UARTRXDMABREQ (receive DMA burst request)
  */
 
 #include "qemu/osdep.h"
@@ -96,6 +100,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 /* Fractional Baud Rate Divider, UARTFBRD */
 #define FBRD_MASK 0x3f
 
+/* UART DMA interface*/
+#define DMA_TX_SREQ 0x0
+#define DMA_RX_SREQ 0x1
+#define DMA_TX_BREQ 0x2
+#define DMA_RX_BREQ 0x3
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -147,6 +157,25 @@ static void pl011_update(PL011State *s)
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         qemu_set_irq(s->irq[i], (flags & irqmask[i]) != 0);
     }
+    if (s->dmacr & (1 << 1)) {
+        /*data in tx fifo is always lower than fifo level*/
+        qemu_set_irq(s->dma_req_irq[DMA_TX_SREQ], 1);
+        qemu_set_irq(s->dma_req_irq[DMA_TX_BREQ], 1);
+    } else {
+        qemu_set_irq(s->dma_req_irq[DMA_TX_SREQ], 0);
+        qemu_set_irq(s->dma_req_irq[DMA_TX_BREQ], 0);
+    }
+
+    if ((s->dmacr & 1) && s->read_count) {
+        qemu_set_irq(s->dma_req_irq[DMA_RX_SREQ], 1);
+    } else {
+        qemu_set_irq(s->dma_req_irq[DMA_RX_SREQ], 0);
+    }
+    if ((s->dmacr & 1) && s->read_count >= s->read_trigger) {
+        qemu_set_irq(s->dma_req_irq[DMA_RX_BREQ], 1);
+    } else {
+        qemu_set_irq(s->dma_req_irq[DMA_RX_BREQ], 0);
+    }
 }
 
 static bool pl011_loopback_enabled(PL011State *s)
@@ -512,9 +541,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         break;
     case 18: /* UARTDMACR */
         s->dmacr = value;
-        if (value & 3) {
-            qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-        }
+        pl011_update(s);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -626,6 +653,16 @@ static int pl011_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static void pl011_dma_clear_handler(void *opaque, int n, int level)
+{
+    if (!level) {
+        return;
+    }
+
+    PL011State *s = PL011(opaque);
+    pl011_update(s);
+}
+
 static const VMStateDescription vmstate_pl011 = {
     .name = "pl011",
     .version_id = 2,
@@ -672,6 +709,10 @@ static void pl011_init(Object *obj)
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
+    for (i = 0; i < ARRAY_SIZE(s->dma_req_irq); i++) {
+        sysbus_init_irq(sbd, &s->dma_req_irq[i]);
+    }
+    qdev_init_gpio_in(DEVICE(obj), pl011_dma_clear_handler, 2);
 
     s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s,
                                 ClockUpdate);
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 5695787650..6f46151777 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -49,6 +49,7 @@ struct PL011State {
     int read_trigger;
     CharFrontend chr;
     qemu_irq irq[6];
+    qemu_irq dma_req_irq[4];
     Clock *clk;
     bool migrate_clk;
     bool logged_disabled_uart;
-- 
2.43.0


