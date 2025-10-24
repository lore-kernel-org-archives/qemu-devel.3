Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07913CCF9EA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 23:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRFn-0006P1-Vy; Fri, 24 Oct 2025 19:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFj-0006N6-0B; Fri, 24 Oct 2025 19:31:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFf-0000GJ-Dw; Fri, 24 Oct 2025 19:31:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21757597459;
 Sat, 25 Oct 2025 01:31:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3TlyQG24R-vC; Sat, 25 Oct 2025 01:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D084E597455; Sat, 25 Oct 2025 01:31:14 +0200 (CEST)
Message-ID: <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761346145.git.balaton@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 25 Oct 2025 01:31:14 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These memory windows are a result of the address decoding in the
Articia S north bridge so better model it there and not in board code.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/articia.c | 15 ++++++++++++++-
 hw/ppc/amigaone.c     | 28 +++++-----------------------
 hw/ppc/pegasos2.c     | 13 -------------
 3 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index cc65aac2a8..761e89bc8f 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -22,6 +22,11 @@
  * Most features are missing but those are not needed by firmware and guests.
  */
 
+#define PCI_HIGH_ADDR 0x80000000
+#define PCI_HIGH_SIZE 0x7d000000
+#define PCI_LOW_ADDR  0xfd000000
+#define PCI_LOW_SIZE   0x1000000
+
 OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
 
 OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
@@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, Error **errp)
 {
     ArticiaState *s = ARTICIA(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
+    MemoryRegion *mr;
     PCIDevice *pdev;
 
     bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
@@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
                           TYPE_ARTICIA, 0x1000000);
     memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", &s->mem,
+                             0, PCI_LOW_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", &s->mem,
+                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
 
     /* devfn_min is 8 that matches first PCI slot in AmigaOne */
     h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
@@ -191,7 +205,6 @@ static void articia_realize(DeviceState *dev, Error **errp)
     pci_create_simple(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
     qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 47fb016b4a..ddfb5c9ec5 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -34,13 +34,6 @@
 #define INITRD_MIN_ADDR 0x600000
 #define INIT_RAM_ADDR 0x40000000
 
-#define PCI_HIGH_ADDR 0x80000000
-#define PCI_HIGH_SIZE 0x7d000000
-#define PCI_LOW_ADDR  0xfd000000
-#define PCI_LOW_SIZE  0xe0000
-
-#define ARTICIA_ADDR 0xfe000000
-
 /*
  * Firmware binary available at
  * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
@@ -266,7 +259,7 @@ static void amigaone_init(MachineState *machine)
 {
     PowerPCCPU *cpu;
     CPUPPCState *env;
-    MemoryRegion *rom, *pci_mem, *mr;
+    MemoryRegion *rom, *mr;
     ssize_t sz;
     PCIBus *pci_bus;
     Object *via;
@@ -307,8 +300,8 @@ static void amigaone_init(MachineState *machine)
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(get_system_memory(), NVRAM_ADDR, mr, 1);
 
     /* allocate and load firmware */
     rom = g_new(MemoryRegion, 1);
@@ -332,8 +325,8 @@ static void amigaone_init(MachineState *machine)
     }
 
     /* Articia S */
-    dev = sysbus_create_simple(TYPE_ARTICIA, ARTICIA_ADDR, NULL);
-
+    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
+    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
     if (machine->ram_size > 512 * MiB) {
         spd_data = spd_data_generate(SDR, machine->ram_size / 2);
@@ -346,17 +339,6 @@ static void amigaone_init(MachineState *machine)
         smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
     }
 
-    pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
-                             0, PCI_LOW_SIZE);
-    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
-    mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
-                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
-    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
-    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
-
     /* VIA VT82c686B South Bridge (multifunction PCI device) */
     via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
                                                  TYPE_VT82C686B_ISA));
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 21299dde3c..c89102cfdc 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -211,23 +211,10 @@ static void pegasos_init(MachineState *machine)
     /* north bridge */
     switch (pm->type) {
     case PEGASOS1:
-    {
-        MemoryRegion *pci_mem, *mr;
-
         /* Articia S */
         pm->nb = DEVICE(sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL));
-        pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
-        mr = g_new(MemoryRegion, 1);
-        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", pci_mem,
-                                 0, 0x1000000);
-        memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
-        mr = g_new(MemoryRegion, 1);
-        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-high", pci_mem,
-                                 0x80000000, 0x7d000000);
-        memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
         pci_bus = PCI_BUS(qdev_get_child_bus(pm->nb, "pci.0"));
         break;
-    }
     case PEGASOS2:
         /* Marvell Discovery II system controller */
         pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
-- 
2.41.3


