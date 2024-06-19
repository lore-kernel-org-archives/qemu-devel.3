Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJs7x-0004aV-HR; Wed, 19 Jun 2024 06:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sJs7w-0004Zn-Bk; Wed, 19 Jun 2024 06:01:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sJs7u-0002s9-FE; Wed, 19 Jun 2024 06:01:16 -0400
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 19 Jun
 2024 18:01:03 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Jun
 2024 18:01:03 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 19 Jun 2024 18:01:02 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Jason Wang <jasowang@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 2/2] hw/net:ftgmac100: support 64 bits dma dram address for
 AST2700
Date: Wed, 19 Jun 2024 18:01:02 +0800
Message-ID: <20240619100102.3137941-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619100102.3137941-1-jamin_lin@aspeedtech.com>
References: <20240619100102.3137941-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
And the base address of dram is "0x4 00000000" which
is 64bits address.

It have "Normal Priority Transmit Ring Base Address Register High(0x17C)",
"High Priority Transmit Ring Base Address Register High(0x184)" and
"Receive Ring Base Address Register High(0x18C)" to save the high part physical
address of descriptor manager.
Ex: TX descriptor manager address [34:0]
The "Normal Priority Transmit Ring Base Address Register High(0x17C)"
bits [2:0] which corresponds the bits [34:32] of the 64 bits address of
the TX ring buffer address.
The "Normal Priority Transmit Ring Base Address Register(0x20)" bits [31:0]
which corresponds the bits [31:0] of the 64 bits address
of the TX ring buffer address.

Besides, it have "TXDES 2 and 3" and "RXDES 2 and 3"
to save the high part physical address of packet buffer.
Ex: TX packet buffer address [34:0]
The "TXDES 2" bits [18:16] which corresponds the bits [34:32]
of the 64 bits address of the TX packet buffer address
and "TXDES 3" bits [31:0] which corresponds the bits [31:0]
of the 64 bits address of the TX packet buffer address.

Update TX/RX ring and descriptor data type to uint64_t
and supports TX/RX ring, descriptor and packet buffers
64 bits address for all ASPEED SOCs models.

Incrementing the version of vmstate to 2.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/net/ftgmac100.c         | 71 ++++++++++++++++++++++++++------------
 include/hw/net/ftgmac100.h |  9 +++--
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 25e4c0cd5b..add3c0e270 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -56,6 +56,10 @@
 #define FTGMAC100_PHYDATA         0x64
 #define FTGMAC100_FCR             0x68
 
+#define FTGMAC100_NPTXR_BADR_HIGH   0x17C
+#define FTGMAC100_HPTXR_BADR_HIGH   0x184
+#define FTGMAC100_RXR_BADR_HIGH     0x18C
+
 /*
  * Interrupt status register & interrupt enable register
  */
@@ -165,6 +169,8 @@
 #define FTGMAC100_TXDES1_TX2FIC          (1 << 30)
 #define FTGMAC100_TXDES1_TXIC            (1 << 31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive descriptor
  */
@@ -198,6 +204,8 @@
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR  (1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR   (1 << 27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive and transmit Buffer Descriptor
  */
@@ -515,12 +523,13 @@ out:
     return frame_size;
 }
 
-static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
-                            uint32_t tx_descriptor)
+static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
+                            uint64_t tx_descriptor)
 {
     int frame_size = 0;
     uint8_t *ptr = s->frame;
-    uint32_t addr = tx_descriptor;
+    uint64_t addr = tx_descriptor;
+    uint64_t buf_addr = 0;
     uint32_t flags = 0;
 
     while (1) {
@@ -559,7 +568,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
             len =  sizeof(s->frame) - frame_size;
         }
 
-        if (dma_memory_read(&address_space_memory, bd.des3,
+        buf_addr = deposit64(buf_addr, 32, 32,
+                             FTGMAC100_TXDES2_TXBUF_BADR_HI(bd.des2));
+        buf_addr = deposit64(buf_addr, 0, 32, bd.des3);
+        if (dma_memory_read(&address_space_memory, buf_addr,
                             ptr, len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ 0x%x\n",
                           __func__, bd.des3);
@@ -710,7 +722,7 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
 {
     FTGMAC100State *s = FTGMAC100(opaque);
 
-    switch (addr & 0xff) {
+    switch (addr) {
     case FTGMAC100_ISR:
         return s->isr;
     case FTGMAC100_IER:
@@ -726,9 +738,9 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
     case FTGMAC100_MATH1:
         return s->math[1];
     case FTGMAC100_RXR_BADR:
-        return s->rx_ring;
+        return extract64(s->rx_ring, 0, 32);
     case FTGMAC100_NPTXR_BADR:
-        return s->tx_ring;
+        return extract64(s->tx_ring, 0, 32);
     case FTGMAC100_ITC:
         return s->itc;
     case FTGMAC100_DBLAC:
@@ -751,10 +763,15 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
         /* We might want to support these one day */
     case FTGMAC100_HPTXPD: /* High Priority Transmit Poll Demand */
     case FTGMAC100_HPTXR_BADR: /* High Priority Transmit Ring Base Address */
+    case FTGMAC100_HPTXR_BADR_HIGH:
     case FTGMAC100_MACSR: /* MAC Status Register (MACSR) */
         qemu_log_mask(LOG_UNIMP, "%s: read to unimplemented register 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
         return 0;
+    case FTGMAC100_NPTXR_BADR_HIGH:
+        return extract64(s->tx_ring, 32, 32);
+    case FTGMAC100_RXR_BADR_HIGH:
+        return extract64(s->rx_ring, 32, 32);
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
@@ -767,7 +784,7 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
 {
     FTGMAC100State *s = FTGMAC100(opaque);
 
-    switch (addr & 0xff) {
+    switch (addr) {
     case FTGMAC100_ISR: /* Interrupt status */
         s->isr &= ~value;
         break;
@@ -799,9 +816,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-
-        s->rx_ring = value;
-        s->rx_descriptor = s->rx_ring;
+        s->rx_ring = deposit64(s->rx_ring, 0, 32, value);
+        s->rx_descriptor = deposit64(s->rx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_RBSR: /* DMA buffer size */
@@ -814,8 +830,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-        s->tx_ring = value;
-        s->tx_descriptor = s->tx_ring;
+        s->tx_ring = deposit64(s->tx_ring, 0, 32, value);
+        s->tx_descriptor = deposit64(s->tx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_NPTXPD: /* Trigger transmit */
@@ -905,6 +921,14 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
         break;
+    case FTGMAC100_NPTXR_BADR_HIGH: /* Transmit buffer address high */
+        s->tx_ring = deposit64(s->tx_ring, 32, 32, value);
+        s->tx_descriptor = deposit64(s->tx_descriptor, 32, 32, value);
+        break;
+    case FTGMAC100_RXR_BADR_HIGH: /* Ring buffer address high */
+        s->rx_ring = deposit64(s->rx_ring, 32, 32, value);
+        s->rx_descriptor = deposit64(s->rx_descriptor, 32, 32, value);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
@@ -957,9 +981,9 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
     FTGMAC100Desc bd;
     uint32_t flags = 0;
-    uint32_t addr;
+    uint64_t addr;
     uint32_t crc;
-    uint32_t buf_addr;
+    uint64_t buf_addr = 0;
     uint8_t *crc_ptr;
     uint32_t buf_len;
     size_t size = len;
@@ -1024,7 +1048,10 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         if (size < 4) {
             buf_len += size - 4;
         }
-        buf_addr = bd.des3;
+
+        buf_addr = deposit64(buf_addr, 32, 32,
+                             FTGMAC100_RXDES2_RXBUF_BADR_HI(bd.des2));
+        buf_addr = deposit64(buf_addr, 0, 32, bd.des3);
         if (first && proto == ETH_P_VLAN && buf_len >= 18) {
             bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
 
@@ -1121,18 +1148,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_ftgmac100 = {
     .name = TYPE_FTGMAC100,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_state, FTGMAC100State),
         VMSTATE_UINT32(isr, FTGMAC100State),
         VMSTATE_UINT32(ier, FTGMAC100State),
         VMSTATE_UINT32(rx_enabled, FTGMAC100State),
-        VMSTATE_UINT32(rx_ring, FTGMAC100State),
         VMSTATE_UINT32(rbsr, FTGMAC100State),
-        VMSTATE_UINT32(tx_ring, FTGMAC100State),
-        VMSTATE_UINT32(rx_descriptor, FTGMAC100State),
-        VMSTATE_UINT32(tx_descriptor, FTGMAC100State),
         VMSTATE_UINT32_ARRAY(math, FTGMAC100State, 2),
         VMSTATE_UINT32(itc, FTGMAC100State),
         VMSTATE_UINT32(aptcr, FTGMAC100State),
@@ -1151,6 +1174,10 @@ static const VMStateDescription vmstate_ftgmac100 = {
         VMSTATE_UINT32(phy_int_mask, FTGMAC100State),
         VMSTATE_UINT32(txdes0_edotr, FTGMAC100State),
         VMSTATE_UINT32(rxdes0_edorr, FTGMAC100State),
+        VMSTATE_UINT64(rx_ring, FTGMAC100State),
+        VMSTATE_UINT64(tx_ring, FTGMAC100State),
+        VMSTATE_UINT64(rx_descriptor, FTGMAC100State),
+        VMSTATE_UINT64(tx_descriptor, FTGMAC100State),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 765d1538a4..01e653b1b4 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -38,10 +38,6 @@ struct FTGMAC100State {
     uint32_t isr;
     uint32_t ier;
     uint32_t rx_enabled;
-    uint32_t rx_ring;
-    uint32_t rx_descriptor;
-    uint32_t tx_ring;
-    uint32_t tx_descriptor;
     uint32_t math[2];
     uint32_t rbsr;
     uint32_t itc;
@@ -54,7 +50,10 @@ struct FTGMAC100State {
     uint32_t phycr;
     uint32_t phydata;
     uint32_t fcr;
-
+    uint64_t rx_ring;
+    uint64_t rx_descriptor;
+    uint64_t tx_ring;
+    uint64_t tx_descriptor;
 
     uint32_t phy_status;
     uint32_t phy_control;
-- 
2.34.1


