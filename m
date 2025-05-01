Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81964C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAdDI-00051m-RO; Thu, 01 May 2025 19:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdCw-0004kt-8L; Thu, 01 May 2025 19:20:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdCu-0007Gb-7m; Thu, 01 May 2025 19:20:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1ACE55D266;
 Fri, 02 May 2025 01:20:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id tR4n3kZLU_Vp; Fri,  2 May 2025 01:20:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9C1B055D25A; Fri, 02 May 2025 01:20:40 +0200 (CEST)
Message-ID: <aa0cc0d5f461ea12109ab1a05fb2659ebeb76813.1746139668.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746139668.git.balaton@eik.bme.hu>
References: <cover.1746139668.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 08/13] hw/ppc/pegasos2: Move PCI IRQ routing setup to a
 function
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 02 May 2025 01:20:40 +0200 (CEST)
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

Collect steps of setting up PCI IRQ routing in one function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 66bceec5ef..26a571f82e 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -107,6 +107,38 @@ static void pegasos2_pci_irq(void *opaque, int n, int level)
     qemu_set_irq(pm->via_pirq[n], level);
 }
 
+/* Set up PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
+static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
+{
+    for (int h = 0; h < 2; h++) {
+        DeviceState *pd;
+        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
+
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
+        assert(pd);
+        for (int i = 0; i < PCI_NUM_PINS; i++) {
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
+                pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
+                pm->via_pirq[i] = qdev_get_gpio_in_named(pm->sb, "pirq", i);
+            }
+            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
+        }
+    }
+    qdev_connect_gpio_out_named(pm->sb, "intr", 0,
+                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
+}
+
 static void pegasos2_init(MachineState *machine)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -118,7 +150,6 @@ static void pegasos2_init(MachineState *machine)
     I2CBus *i2c_bus;
     const char *fwname = machine->firmware ?: PROM_FILENAME;
     char *filename;
-    int i;
     ssize_t sz;
     uint8_t *spd_data;
 
@@ -169,9 +200,6 @@ static void pegasos2_init(MachineState *machine)
     /* Marvell Discovery II system controller */
     pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
                           qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
-    }
     pci_bus = mv64361_get_pci_bus(pm->nb, 1);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
@@ -185,14 +213,9 @@ static void pegasos2_init(MachineState *machine)
     }
 
     pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
-    }
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
@@ -205,30 +228,7 @@ static void pegasos2_init(MachineState *machine)
     /* other PC hardware */
     pci_vga_init(pci_bus);
 
-    /* PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
-    for (int h = 0; h < 2; h++) {
-        DeviceState *pd;
-        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
-
-        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
-        assert(pd);
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            OrIRQState *ori = &pm->orirq[i];
-
-            if (h == 0) {
-                g_autofree const char *n = g_strdup_printf("pci-orirq[%d]", i);
-
-                object_initialize_child_with_props(OBJECT(pm), n,
-                                                   ori, sizeof(*ori),
-                                                   TYPE_OR_IRQ, &error_fatal,
-                                                   "num-lines", "2", NULL);
-                qdev_realize(DEVICE(ori), NULL, &error_fatal);
-                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
-                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
-            }
-            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
-        }
-    }
+    pegasos2_setup_pci_irq(pm);
 
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
-- 
2.41.3


