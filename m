Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8758C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHql-0000V7-VL; Thu, 04 Jul 2024 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqk-0000U8-7n; Thu, 04 Jul 2024 04:29:54 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqi-0002HT-Bp; Thu, 04 Jul 2024 04:29:53 -0400
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 16:29:23 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Jul
 2024 16:29:24 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 4 Jul 2024 16:29:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 3/8] hw/net:ftgmac100: introduce TX and RX ring base
 address high registers to support 64 bits
Date: Thu, 4 Jul 2024 16:29:17 +0800
Message-ID: <20240704082922.1464317-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
References: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a new sub region which size is 0x100 for the set of new registers
and map it at 0x100 in the container region.
This sub region range is from 0x100 to 0x1ff.

Introduce a new property and object attribute to activate the region for new registers.
Introduce a new memop handlers for the new register read and write.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/net/ftgmac100.c         | 82 ++++++++++++++++++++++++++++++++++++++
 include/hw/net/ftgmac100.h |  4 ++
 2 files changed, 86 insertions(+)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d026242e2b..68956aeb94 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -56,6 +56,16 @@
 #define FTGMAC100_PHYDATA         0x64
 #define FTGMAC100_FCR             0x68
 
+/*
+ * FTGMAC100 registers high
+ *
+ * values below are offset by - FTGMAC100_REG_HIGH_OFFSET from datasheet
+ * because its memory region is start at FTGMAC100_REG_HIGH_OFFSET
+ */
+#define FTGMAC100_NPTXR_BADR_HIGH   (0x17C - FTGMAC100_REG_HIGH_OFFSET)
+#define FTGMAC100_HPTXR_BADR_HIGH   (0x184 - FTGMAC100_REG_HIGH_OFFSET)
+#define FTGMAC100_RXR_BADR_HIGH     (0x18C - FTGMAC100_REG_HIGH_OFFSET)
+
 /*
  * Interrupt status register & interrupt enable register
  */
@@ -913,6 +923,60 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
     ftgmac100_update_irq(s);
 }
 
+static uint64_t ftgmac100_high_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FTGMAC100State *s = FTGMAC100(opaque);
+    uint64_t val = 0;
+
+    switch (addr) {
+    case FTGMAC100_NPTXR_BADR_HIGH:
+        val = extract64(s->tx_ring, 32, 32);
+        break;
+    case FTGMAC100_HPTXR_BADR_HIGH:
+        /* High Priority Transmit Ring Base High Address */
+        qemu_log_mask(LOG_UNIMP, "%s: read to unimplemented register 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    case FTGMAC100_RXR_BADR_HIGH:
+        val = extract64(s->rx_ring, 32, 32);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+
+    return val;
+}
+
+static void ftgmac100_high_write(void *opaque, hwaddr addr,
+                          uint64_t value, unsigned size)
+{
+    FTGMAC100State *s = FTGMAC100(opaque);
+
+    switch (addr) {
+    case FTGMAC100_NPTXR_BADR_HIGH:
+        s->tx_ring = deposit64(s->tx_ring, 32, 32, value);
+        s->tx_descriptor = deposit64(s->tx_descriptor, 32, 32, value);
+        break;
+    case FTGMAC100_HPTXR_BADR_HIGH:
+        /* High Priority Transmit Ring Base High Address */
+        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    case FTGMAC100_RXR_BADR_HIGH:
+        s->rx_ring = deposit64(s->rx_ring, 32, 32, value);
+        s->rx_descriptor = deposit64(s->rx_descriptor, 32, 32, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+
+    ftgmac100_update_irq(s);
+}
+
 static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_t len)
 {
     unsigned mcast_idx;
@@ -1077,6 +1141,14 @@ static const MemoryRegionOps ftgmac100_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static const MemoryRegionOps ftgmac100_high_ops = {
+    .read = ftgmac100_high_read,
+    .write = ftgmac100_high_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void ftgmac100_cleanup(NetClientState *nc)
 {
     FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
@@ -1114,6 +1186,15 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
                           TYPE_FTGMAC100 ".regs", FTGMAC100_REG_MEM_SIZE);
     memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
 
+    if (s->dma64) {
+        memory_region_init_io(&s->iomem_high, OBJECT(s), &ftgmac100_high_ops,
+                              s, TYPE_FTGMAC100 ".regs.high",
+                              FTGMAC100_REG_HIGH_MEM_SIZE);
+        memory_region_add_subregion(&s->iomem_container,
+                                    FTGMAC100_REG_HIGH_OFFSET,
+                                    &s->iomem_high);
+    }
+
     sysbus_init_irq(sbd, &s->irq);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
@@ -1162,6 +1243,7 @@ static const VMStateDescription vmstate_ftgmac100 = {
 static Property ftgmac100_properties[] = {
     DEFINE_PROP_BOOL("aspeed", FTGMAC100State, aspeed, false),
     DEFINE_NIC_PROPERTIES(FTGMAC100State, conf),
+    DEFINE_PROP_BOOL("dma64", FTGMAC100State, dma64, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index aae57ae8cb..24ccdf0260 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -16,6 +16,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
 
 #define FTGMAC100_MEM_SIZE 0x1000
 #define FTGMAC100_REG_MEM_SIZE 0x100
+#define FTGMAC100_REG_HIGH_MEM_SIZE 0x100
+#define FTGMAC100_REG_HIGH_OFFSET 0x100
 
 #include "hw/sysbus.h"
 #include "net/net.h"
@@ -35,6 +37,7 @@ struct FTGMAC100State {
     qemu_irq irq;
     MemoryRegion iomem_container;
     MemoryRegion iomem;
+    MemoryRegion iomem_high;
 
     uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
 
@@ -68,6 +71,7 @@ struct FTGMAC100State {
     bool aspeed;
     uint32_t txdes0_edotr;
     uint32_t rxdes0_edorr;
+    bool dma64;
 };
 
 #define TYPE_ASPEED_MII "aspeed-mmi"
-- 
2.34.1


