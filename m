Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F512C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgVJx-0006md-3w; Sun, 05 Jul 2026 18:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUw0-0002BE-Ud; Sun, 05 Jul 2026 18:03:32 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUvy-0001gF-Tq; Sun, 05 Jul 2026 18:03:32 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4gthMG3K0XzBsqx;
 Mon,  6 Jul 2026 00:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783289002;
 bh=qIHCJs8odbg5/PUzASEvth7UI0FqeJM5X0+4+tlDNmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bLWqsffcaEf6F0cN1O2A35Gg/0ze1t+k+e2icv4kqcPvj+nxeeEKnscGfK4KGAbEc
 /Mvj/c+Zb8qnA4M4j24RQq6/d6MXZgFJgGqZSjy0Mmpds9Q+3SYpFowXDky2cy0cIj
 HSpO5l4yC/ThmEyuN/befviiBViy7nKPYEt+k6z4YVk90nYu0qqeOA+JcQXtXbXHtn
 hXT8BWmN/9WS+vonVl3JMkSfC+uDd4Lif8sB5xlLGFaPkNtteK0MF0jNS69uCzT444
 YvLsTIe1wO3ZSJZekkZhYLV0X+fYqCWVHuqY1041LDnx4FuLhHFnQH5YzeamOO4Wao
 m5+W1m4qZM4yw==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gthMG2F7sz6sT6;
 Mon,  6 Jul 2026 00:03:22 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH RFC v1 4/9] hw/char/pl011: expose DMA request notifications
Date: Mon,  6 Jul 2026 00:03:15 +0200
Message-ID: <20260705220320.90395-5-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
References: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
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
X-Mailman-Approved-At: Sun, 05 Jul 2026 18:28:16 -0400
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

Allow board code to observe PL011 DMA request line changes. The RP2040 Pico machine uses this to connect UART0 and UART1 TX/RX activity to the RP2040 DMA DREQ model without forking the PL011 device.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/char/pl011.c         | 116 +++++++++++++++++++++++++++++++++++++---
 include/hw/char/pl011.h |   8 +++
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224..40876b92df 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -80,6 +80,11 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_FEN     (1 << 4)
 #define LCR_BRK     (1 << 0)
 
+/* DMA Control Register, UARTDMACR */
+#define DMACR_RXDMAE (1 << 0)
+#define DMACR_TXDMAE (1 << 1)
+#define DMACR_DMAONERR (1 << 2)
+
 /* Control Register, UARTCR */
 #define CR_OUT2     (1 << 13)
 #define CR_OUT1     (1 << 12)
@@ -96,6 +101,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 /* Fractional Baud Rate Divider, UARTFBRD */
 #define FBRD_MASK 0x3f
 
+/* RP2040 APB atomic register aliases. */
+#define PL011_ATOMIC_ALIAS_MASK 0x3000
+#define PL011_ATOMIC_XOR        0x1000
+#define PL011_ATOMIC_SET        0x2000
+#define PL011_ATOMIC_CLR        0x3000
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -157,6 +168,34 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
+static void pl011_update_dreq(PL011State *s)
+{
+    if (s->dreq_tx) {
+        qemu_set_irq(s->dreq_tx,
+                     (s->dmacr & DMACR_TXDMAE) &&
+                     !(s->flags & PL011_FLAG_TXFF));
+    }
+    if (s->dreq_rx) {
+        qemu_set_irq(s->dreq_rx,
+                     (s->dmacr & DMACR_RXDMAE) && s->read_count > 0);
+    }
+}
+
+static uint32_t pl011_apply_atomic_alias(uint32_t old, uint32_t value,
+                                         hwaddr alias)
+{
+    switch (alias) {
+    case PL011_ATOMIC_XOR:
+        return old ^ value;
+    case PL011_ATOMIC_SET:
+        return old | value;
+    case PL011_ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
 static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
@@ -190,6 +229,7 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
         trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
     }
+    pl011_update_dreq(s);
     if (s->read_count == s->read_trigger) {
         s->int_level |= INT_RX;
         pl011_update(s);
@@ -254,10 +294,17 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
      * XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks
      */
-    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    if (s->tx_connected) {
+        qemu_chr_fe_write_all(&s->chr, &data, 1);
+    } else if (!s->logged_disconnected_tx) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PL011 data written while TX pin is disconnected\n");
+        s->logged_disconnected_tx = true;
+    }
     pl011_loopback_tx(s, data);
     s->int_level |= INT_TX;
     pl011_update(s);
+    pl011_update_dreq(s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
@@ -280,6 +327,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
     trace_pl011_read_fifo(s->read_count, fifo_depth);
     s->rsr = c >> 8;
     pl011_update(s);
+    pl011_update_dreq(s);
     qemu_chr_fe_accept_input(&s->chr);
     return c;
 }
@@ -469,6 +517,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         }
         s->lcr = value;
         pl011_set_read_trigger(s);
+        pl011_update_dreq(s);
         break;
     case 12: /* UARTCR */
         /* ??? Need to implement the enable bit.  */
@@ -492,10 +541,8 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_update(s);
         break;
     case 18: /* UARTDMACR */
-        s->dmacr = value;
-        if (value & 3) {
-            qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-        }
+        s->dmacr = value & (DMACR_RXDMAE | DMACR_TXDMAE | DMACR_DMAONERR);
+        pl011_update_dreq(s);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -503,6 +550,23 @@ static void pl011_write(void *opaque, hwaddr offset,
     }
 }
 
+static uint64_t pl011_atomic_alias_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    return pl011_read(opaque, offset & 0xfff, size);
+}
+
+static void pl011_atomic_alias_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    hwaddr alias = (offset + PL011_ATOMIC_XOR) & PL011_ATOMIC_ALIAS_MASK;
+    hwaddr reg = offset & 0xfff;
+    uint32_t old = pl011_read(opaque, reg, size);
+    uint32_t new = pl011_apply_atomic_alias(old, value, alias);
+
+    pl011_write(opaque, reg, new, size);
+}
+
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
@@ -518,6 +582,9 @@ static int pl011_can_receive(void *opaque)
      * historically never enforced that. So we effectively keep the
      * UART continuously enabled regardless of the enable bits.
      */
+    if (!s->rx_connected) {
+        return 0;
+    }
 
     trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available);
     return fifo_available;
@@ -526,6 +593,9 @@ static int pl011_can_receive(void *opaque)
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
     trace_pl011_receive(size);
+    if (!PL011(opaque)->rx_connected) {
+        return;
+    }
     /*
      * In loopback mode, the RX input signal is internally disconnected
      * from the entire receiving logics; thus, all inputs are ignored,
@@ -542,11 +612,28 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
-    if (event == CHR_EVENT_BREAK && !pl011_loopback_enabled(opaque)) {
+    PL011State *s = opaque;
+
+    if (event == CHR_EVENT_BREAK && s->rx_connected &&
+        !pl011_loopback_enabled(opaque)) {
         pl011_fifo_rx_put(opaque, DR_BE);
     }
 }
 
+void pl011_set_tx_connected(PL011State *s, bool connected)
+{
+    s->tx_connected = connected;
+    if (connected) {
+        s->logged_disconnected_tx = false;
+    }
+}
+
+void pl011_set_rx_connected(PL011State *s, bool connected)
+{
+    s->rx_connected = connected;
+    qemu_chr_fe_accept_input(&s->chr);
+}
+
 static void pl011_clock_update(void *opaque, ClockEvent event)
 {
     PL011State *s = PL011(opaque);
@@ -562,6 +649,14 @@ static const MemoryRegionOps pl011_ops = {
     .impl.max_access_size = 4,
 };
 
+static const MemoryRegionOps pl011_atomic_alias_ops = {
+    .read = pl011_atomic_alias_read,
+    .write = pl011_atomic_alias_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
 static bool pl011_clock_needed(void *opaque)
 {
     PL011State *s = PL011(opaque);
@@ -648,11 +743,19 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    s->tx_connected = true;
+    s->rx_connected = true;
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init_io(&s->atomic_alias_iomem, OBJECT(s),
+                          &pl011_atomic_alias_ops, s,
+                          "pl011-atomic-alias", 0x3000);
+    sysbus_init_mmio(sbd, &s->atomic_alias_iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_tx, "dreq-tx", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_rx, "dreq-rx", 1);
 
     s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s,
                                 ClockUpdate);
@@ -687,6 +790,7 @@ static void pl011_reset(DeviceState *dev)
     s->logged_disabled_uart = false;
     pl011_reset_rx_fifo(s);
     pl011_reset_tx_fifo(s);
+    pl011_update_dreq(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 5695787650..20c0b5694b 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -32,6 +32,7 @@ struct PL011State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    MemoryRegion atomic_alias_iomem;
     uint32_t flags;
     uint32_t lcr;
     uint32_t rsr;
@@ -49,9 +50,14 @@ struct PL011State {
     int read_trigger;
     CharFrontend chr;
     qemu_irq irq[6];
+    qemu_irq dreq_tx;
+    qemu_irq dreq_rx;
     Clock *clk;
     bool migrate_clk;
+    bool tx_connected;
+    bool rx_connected;
     bool logged_disabled_uart;
+    bool logged_disconnected_tx;
     const unsigned char *id;
     /*
      * Since some users embed this struct directly, we must
@@ -61,5 +67,7 @@ struct PL011State {
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
+void pl011_set_tx_connected(PL011State *s, bool connected);
+void pl011_set_rx_connected(PL011State *s, bool connected);
 
 #endif
-- 
2.53.0


