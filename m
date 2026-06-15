Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB77CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFcB-0001zP-Jf; Mon, 15 Jun 2026 18:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc9-0001y4-Hx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc7-0007q8-EB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 35B485969B4;
 Tue, 16 Jun 2026 00:17:02 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Spzaikcf0Sj8; Tue, 16 Jun 2026 00:17:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3335F5969B5; Tue, 16 Jun 2026 00:17:00 +0200 (CEST)
Message-ID: <49d3fc146cfdfc36bb03adf9babee139cf90943f.1781561370.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1781561370.git.balaton@eik.bme.hu>
References: <cover.1781561370.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 4/7] hw/ide/sii3112: Use memory_region_new to avoid leaking
 regions
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 philmd@mailo.com
Date: Tue, 16 Jun 2026 00:17:00 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Memory regions created with memory_region_init are not freed with
their owner. Use memory_region_new instead to let QOM manage the
lifetime of the memory regions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/sii3112.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 9b28c691fd..d2dcfc3830 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -31,7 +31,7 @@ typedef struct SiI3112Regs {
 
 struct SiI3112PCIState {
     PCIIDEState i;
-    MemoryRegion mmio;
+
     SiI3112Regs regs[2];
 };
 
@@ -249,39 +249,33 @@ static void sii3112_reset(DeviceState *dev)
 
 static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
 {
-    SiI3112PCIState *d = SII3112_PCI(dev);
     PCIIDEState *s = PCI_IDE(dev);
     DeviceState *ds = DEVICE(dev);
-    MemoryRegion *mr;
-    int i;
+    Object *o = OBJECT(dev);
+    MemoryRegion *mmio, *mr;
 
     pci_config_set_interrupt_pin(dev->config, 1);
     pci_set_byte(dev->config + PCI_CACHE_LINE_SIZE, 8);
 
     /* BAR5 is in PCI memory space */
-    memory_region_init_io(&d->mmio, OBJECT(d), &sii3112_reg_ops, d,
-                         "sii3112.bar5", 0x200);
-    pci_register_bar(dev, 5, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
+    mmio = memory_region_new_io(o, &sii3112_reg_ops, SII3112_PCI(dev),
+                                "sii3112.bar5", 0x200);
+    pci_register_bar(dev, 5, PCI_BASE_ADDRESS_SPACE_MEMORY, mmio);
 
     /* BAR0-BAR4 are PCI I/O space aliases into BAR5 */
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar0", &d->mmio, 0x80, 8);
+    mr = memory_region_new_alias(o, "sii3112.bar0", mmio, 0x80, 8);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, mr);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar1", &d->mmio, 0x88, 4);
+    mr = memory_region_new_alias(o, "sii3112.bar1", mmio, 0x88, 4);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, mr);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar2", &d->mmio, 0xc0, 8);
+    mr = memory_region_new_alias(o, "sii3112.bar2", mmio, 0xc0, 8);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, mr);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar3", &d->mmio, 0xc8, 4);
+    mr = memory_region_new_alias(o, "sii3112.bar3", mmio, 0xc8, 4);
     pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, mr);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
+    mr = memory_region_new_alias(o, "sii3112.bar4", mmio, 0, 16);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
 
     qdev_init_gpio_in(ds, sii3112_set_irq, 2);
-    for (i = 0; i < 2; i++) {
+    for (int i = 0; i < 2; i++) {
         ide_bus_init(&s->bus[i], sizeof(s->bus[i]), ds, i, 1);
         ide_bus_init_output_irq(&s->bus[i], qdev_get_gpio_in(ds, i));
 
-- 
2.41.3


