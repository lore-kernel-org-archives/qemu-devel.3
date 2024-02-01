Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74168C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaD1-0005EL-N9; Thu, 01 Feb 2024 11:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB4-0002vQ-8e
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:39 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAt-0002SW-Uh
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=3dQ2dtRjo0uSs9MkgXkmPl7/brA9aWPKOEIpDR/YgVw=; b=jo4nG8Fpnb6Yqsy0ki7VOKQgDN
 wnMjk3IcdjAwqiWZ5+nq7ddCyFKfWPOYwuYkzVlYuY7OEB95UzdPGAAiBALk/Szk0YD0m4YrI3C5I
 x1S2IY19AeDgtHEixZ/ztC+9xUHrSI4CE1DIds2DJptsaZN7AzKx4RLP4o428vg8QhyLgl5oapU0L
 GgjRiZWeHN2GaNwLqzll7KVOBZfLHczoQ+PSfWgYs9kk5ZgmH0nlgY39LUanU3a29kKxmO49kMj+u
 3MmtVt0rhy39Gx57VVn0TI2QxpKKgc39GotoH/M28J1ISghuuBQWDkoDTR/nhKRsBDVcXVk7KVDqf
 3BLeN89A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdS-1ggH for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INp-1uCF for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/47] hw/arm: use qemu_configure_nic_device()
Date: Thu,  1 Feb 2024 16:43:55 +0000
Message-ID: <20240201164412.785520-31-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/mps2-tz.c     |  8 ++------
 hw/arm/msf2-soc.c    |  6 +-----
 hw/arm/musicpal.c    |  3 +--
 hw/arm/xilinx_zynq.c | 11 ++++-------
 hw/arm/xlnx-versal.c |  7 +------
 hw/arm/xlnx-zynqmp.c |  8 +-------
 6 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 5d8cdc1a4c..a2d18afd79 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -503,14 +503,12 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
                                   const PPCExtraData *extradata)
 {
     SysBusDevice *s;
-    NICInfo *nd = &nd_table[0];
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    qemu_check_nic_model(nd, "lan9118");
     mms->lan9118 = qdev_new(TYPE_LAN9118);
-    qdev_set_nic_properties(mms->lan9118, nd);
+    qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -528,7 +526,6 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * irqs[] is the ethernet IRQ.
      */
     SysBusDevice *s;
-    NICInfo *nd = &nd_table[0];
 
     memory_region_init(&mms->eth_usb_container, OBJECT(mms),
                        "mps2-tz-eth-usb-container", 0x200000);
@@ -537,9 +534,8 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    qemu_check_nic_model(nd, "lan9118");
     mms->lan9118 = qdev_new(TYPE_LAN9118);
-    qdev_set_nic_properties(mms->lan9118, nd);
+    qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index b5fe9f364d..35bf1d64e1 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -197,12 +197,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         g_free(bus_name);
     }
 
-    /* FIXME use qdev NIC properties instead of nd_table[] */
-    if (nd_table[0].used) {
-        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
-        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
-    }
     dev = DEVICE(&s->emac);
+    qemu_configure_nic_device(dev, true, NULL);
     object_property_set_link(OBJECT(&s->emac), "ahb-bus",
                              OBJECT(get_system_memory()), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 0fe0160b48..2020f73a57 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1277,9 +1277,8 @@ static void musicpal_init(MachineState *machine)
     }
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
-    qemu_check_nic_model(&nd_table[0], "mv88w8618");
     dev = qdev_new(TYPE_MV88W8618_ETH);
-    qdev_set_nic_properties(dev, &nd_table[0]);
+    qemu_configure_nic_device(dev, true, "mv88w8618");
     object_property_set_link(OBJECT(dev), "dma-memory",
                              OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 66d0de139f..35fa804b7d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -109,16 +109,13 @@ static void zynq_write_board_setup(ARMCPU *cpu,
 
 static struct arm_boot_info zynq_binfo = {};
 
-static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
+static void gem_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_CADENCE_GEM);
-    if (nd->used) {
-        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
-        qdev_set_nic_properties(dev, nd);
-    }
+    qemu_configure_nic_device(dev, true, NULL);
     object_property_set_int(OBJECT(dev), "phy-addr", 7, &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -280,8 +277,8 @@ static void zynq_init(MachineState *machine)
     sysbus_create_varargs("cadence_ttc", 0xF8002000,
             pic[69-IRQ_OFFSET], pic[70-IRQ_OFFSET], pic[71-IRQ_OFFSET], NULL);
 
-    gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
-    gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
+    gem_init(0xE000B000, pic[54 - IRQ_OFFSET]);
+    gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
 
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2798df3730..50cb0606cb 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -256,18 +256,13 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
         static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
         char *name = g_strdup_printf("gem%d", i);
-        NICInfo *nd = &nd_table[i];
         DeviceState *dev;
         MemoryRegion *mr;
 
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
                                 TYPE_CADENCE_GEM);
         dev = DEVICE(&s->lpd.iou.gem[i]);
-        /* FIXME use qdev NIC properties instead of nd_table[] */
-        if (nd->used) {
-            qemu_check_nic_model(nd, "cadence_gem");
-            qdev_set_nic_properties(dev, nd);
-        }
+        qemu_configure_nic_device(dev, true, NULL);
         object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 65901c6e74..afeb3f88f8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -618,13 +618,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        /* FIXME use qdev NIC properties instead of nd_table[] */
-        if (nd->used) {
-            qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
-            qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
-        }
+        qemu_configure_nic_device(DEVICE(&s->gem[i]), true, NULL);
         object_property_set_int(OBJECT(&s->gem[i]), "revision", GEM_REVISION,
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "phy-addr", 23,
-- 
2.43.0


