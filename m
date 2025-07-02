Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF953C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX65y-0008Nt-UV; Wed, 02 Jul 2025 18:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65n-0008Dq-7s; Wed, 02 Jul 2025 18:38:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65k-0005ET-Qa; Wed, 02 Jul 2025 18:38:14 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6FDD55CA5E;
 Thu, 03 Jul 2025 00:38:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AtgO22nnPWkB; Thu,  3 Jul 2025 00:38:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B560255C1B9; Thu, 03 Jul 2025 00:38:07 +0200 (CEST)
Message-ID: <166561951a975bdc22cfa2b0517ac4515e89586c.1751494995.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1751494995.git.balaton@eik.bme.hu>
References: <cover.1751494995.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 05/13] hw/ppc/pegasos2: Rename mv field in machine state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Jul 2025 00:38:07 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use more generic name for the field used to store the north bridge in
the machine state.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pegasos2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 7dc7803c64..9b50cd3dab 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -68,7 +68,7 @@ struct Pegasos2MachineState {
     MachineState parent_obj;
 
     PowerPCCPU *cpu;
-    DeviceState *mv;
+    DeviceState *nb; /* north bridge */
     IRQState pci_irqs[PCI_NUM_PINS];
     OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
@@ -166,12 +166,12 @@ static void pegasos2_init(MachineState *machine)
     }
 
     /* Marvell Discovery II system controller */
-    pm->mv = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
+    pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
                           qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->mv, "gpp", 12 + i);
+        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
     }
-    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 1);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
@@ -190,7 +190,7 @@ static void pegasos2_init(MachineState *machine)
                               object_resolve_path_component(via, "rtc"),
                               "date");
     qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
+                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
@@ -208,7 +208,7 @@ static void pegasos2_init(MachineState *machine)
         DeviceState *pd;
         g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
 
-        pd = DEVICE(object_resolve_path_component(OBJECT(pm->mv), pn));
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
         assert(pd);
         for (i = 0; i < PCI_NUM_PINS; i++) {
             OrIRQState *ori = &pm->orirq[i];
@@ -267,7 +267,7 @@ static void pegasos2_init(MachineState *machine)
 static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
                                      uint32_t addr, uint32_t len)
 {
-    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->mv), 0);
+    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
     uint64_t val = 0xffffffffULL;
     memory_region_dispatch_read(r, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
@@ -277,7 +277,7 @@ static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
 static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                   uint32_t len, uint32_t val)
 {
-    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->mv), 0);
+    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
     memory_region_dispatch_write(r, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
@@ -858,10 +858,10 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
 
     fi.fdt = fdt;
     fi.path = "/pci@c0000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 0);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 0);
     pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
     fi.path = "/pci@80000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 1);
     pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
 
     return fdt;
-- 
2.41.3


