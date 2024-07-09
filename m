Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B88C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9P0-0001aQ-Mn; Tue, 09 Jul 2024 07:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Oz-0001Pl-4S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Oo-0006WS-EU
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3biFDdRU1immrFwaBbGrdEUhaLDtCr2UB++Ns4nktOw=;
 b=jWSY6rgUm4tSIGE5iszGQQLFwzG57HEgJcQm/Ckzo7bNLhLxn7oj8Exn7EXQkvqlfn0/g9
 fad7G+xCNaAhtZ5Vz+7DGTaTHpYXQtyPKpncnbWB0z1KvET7ZNuOIMWrIY6ggUeV0FP1Yx
 v8WJvxboF7QEKU7izwwAWGcReSP7MCI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-9mQ6sEmVO0inK5e6obToJg-1; Tue,
 09 Jul 2024 07:52:40 -0400
X-MC-Unique: 9mQ6sEmVO0inK5e6obToJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADC3A195419C; Tue,  9 Jul 2024 11:52:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40E1D3000184; Tue,  9 Jul 2024 11:52:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/8] hw/net:ftgmac100: introduce TX and RX ring base address
 high registers to support 64 bits
Date: Tue,  9 Jul 2024 13:52:23 +0200
Message-ID: <20240709115228.798904-4-clg@redhat.com>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
References: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/net/ftgmac100.h |  4 ++
 hw/net/ftgmac100.c         | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index aae57ae8cbed..24ccdf0260a9 100644
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
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d026242e2b54..68956aeb94ae 100644
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
 
-- 
2.45.2


