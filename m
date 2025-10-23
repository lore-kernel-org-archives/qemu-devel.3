Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C30CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxDC-0005wx-2l; Thu, 23 Oct 2025 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD1-0005r4-KO; Thu, 23 Oct 2025 11:26:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCy-00019q-Jc; Thu, 23 Oct 2025 11:26:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E5FC45972F5;
 Thu, 23 Oct 2025 17:26:28 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zvoU887IQbrb; Thu, 23 Oct 2025 17:26:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DF6E95972EA; Thu, 23 Oct 2025 17:26:26 +0200 (CEST)
Message-ID: <f7b0329b72ca8740cc55f380fdf5cb4db2803620.1761232472.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 06/13] hw/pci-host/raven: Simplify PCI interrupt routing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 23 Oct 2025 17:26:26 +0200 (CEST)
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

No need to use an or-irq to map interrupt lines to a single IRQ as the
PCI code can handle this internally so simplify by dropping the or-irq
similar to how ppc440_pcix.c does it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 39 +++++++++++++++------------------------
 hw/ppc/prep.c       |  5 ++++-
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 22ad244eb6..2057a1869f 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -30,11 +30,8 @@
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/qdev-properties.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
-#include "hw/or-irq.h"
-#include "qom/object.h"
 
 #define TYPE_RAVEN_PCI_DEVICE "raven"
 #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
@@ -44,8 +41,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PREPPCIState, RAVEN_PCI_HOST_BRIDGE)
 struct PREPPCIState {
     PCIHostState parent_obj;
 
-    OrIRQState *or_irq;
-    qemu_irq pci_irqs[PCI_NUM_PINS];
+    qemu_irq irq;
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
@@ -175,16 +171,25 @@ static const MemoryRegionOps raven_io_ops = {
     .valid.unaligned = true,
 };
 
+/*
+ * All four IRQ[ABCD] pins from all slots are tied to a single board
+ * IRQ, so our mapping function here maps everything to IRQ 0.
+ * The code in pci_change_irq_level() tracks the number of times
+ * the mapped IRQ is asserted and deasserted, so if multiple devices
+ * assert an IRQ at the same time the behaviour is correct.
+ *
+ * This may need further refactoring for boards that use multiple IRQ lines.
+ */
 static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
 {
-    return (irq_num + (pci_dev->devfn >> 3)) & 1;
+    return 0;
 }
 
 static void raven_set_irq(void *opaque, int irq_num, int level)
 {
-    PREPPCIState *s = opaque;
+    qemu_irq *irq = opaque;
 
-    qemu_set_irq(s->pci_irqs[irq_num], level);
+    qemu_set_irq(*irq, level);
 }
 
 static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
@@ -212,26 +217,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
     MemoryRegion *address_space_mem = get_system_memory();
-    int i;
-
-    /*
-     * According to PReP specification section 6.1.6 "System Interrupt
-     * Assignments", all PCI interrupts are routed via IRQ 15
-     */
-    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
-                            &error_fatal);
-    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
-    sysbus_init_irq(dev, &s->or_irq->out_irq);
-
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
-    }
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
+    sysbus_init_irq(dev, &s->irq);
     h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
-                                   s, &s->pci_memory, &s->pci_io, 0, 4,
+                                   &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
                                    TYPE_PCI_BUS);
 
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c730cb3429..816455d289 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -304,7 +304,10 @@ static void ibm_40p_init(MachineState *machine)
     qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
     qdev_connect_gpio_out(i82378_dev, 0,
                           qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
-
+    /*
+     * According to PReP specification section 6.1.6 "System Interrupt
+     * Assignments", all PCI interrupts are routed via IRQ 15
+     */
     sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
     isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
-- 
2.41.3


