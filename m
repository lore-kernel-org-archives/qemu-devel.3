Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9070E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7D5F-0001a2-AQ; Sat, 02 Nov 2024 08:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5C-0001ZZ-GP; Sat, 02 Nov 2024 08:18:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7D5A-0007YC-6K; Sat, 02 Nov 2024 08:18:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E30034E602D;
 Sat, 02 Nov 2024 13:17:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 32izntbzirTI; Sat,  2 Nov 2024 13:17:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26F054E6013; Sat, 02 Nov 2024 13:17:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/ppc/pegasos2: Fix IRQ routing from pci.0
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20241102121711.26F054E6013@zero.eik.bme.hu>
Date: Sat, 02 Nov 2024 13:17:11 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The MV64361 has two PCI buses one of which is used for AGP on
PegasosII. So far we only emulated the PCI bus on pci.1 but some
graphics cards are only recognised by some guests when connected to
pci.0 corresponding to the AGP port. So far the interrupts were not
routed from pci.0 so this patch fixes that allowing the use of both
PCI buses. On real board only INTA and INTB are connected for AGP but
to avoid surprises we connect all 4 PCI interrupt lines so pci.0 can
be used for all PCI cards as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/mv64361.c |  1 +
 hw/ppc/pegasos2.c     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 1036d8600d..421c287eb0 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -95,6 +95,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
     g_free(name);
     pci_create_simple(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
+    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
 static Property mv64361_pcihost_props[] = {
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ff4a00c34..16abeaac82 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/irq.h"
+#include "hw/or-irq.h"
 #include "hw/pci-host/mv64361.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
@@ -73,8 +74,11 @@ OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
 struct Pegasos2MachineState {
     MachineState parent_obj;
+
     PowerPCCPU *cpu;
     DeviceState *mv;
+    IRQState pci_irqs[PCI_NUM_PINS];
+    OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
     qemu_irq via_pirq[PCI_NUM_PINS];
     Vof *vof;
@@ -177,7 +181,6 @@ static void pegasos2_init(MachineState *machine)
         pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->mv, "gpp", 12 + i);
     }
     pci_bus = mv64361_get_pci_bus(pm->mv, 1);
-    pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
@@ -209,6 +212,31 @@ static void pegasos2_init(MachineState *machine)
     /* other PC hardware */
     pci_vga_init(pci_bus);
 
+    /* PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
+    for (int h = 0; h < 2; h++) {
+        DeviceState *pd;
+        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
+
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->mv), pn));
+        assert(pd);
+        for (i = 0; i < PCI_NUM_PINS; i++) {
+            OrIRQState *ori = &pm->orirq[i];
+
+            if (h == 0) {
+                g_autofree const char *n = g_strdup_printf("pci-orirq[%d]", i);
+
+                object_initialize_child_with_props(OBJECT(pm), n,
+                                                   ori, sizeof(*ori),
+                                                   TYPE_OR_IRQ, &error_fatal,
+                                                   "num-lines", "2", NULL);
+                qdev_realize(DEVICE(ori), NULL, &error_fatal);
+                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
+                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
+            }
+            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
+        }
+    }
+
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
                       &pm->kernel_entry, &pm->kernel_addr, NULL, NULL, 1,
-- 
2.30.9


