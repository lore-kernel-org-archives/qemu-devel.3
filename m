Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE31C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 00:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAe4m-0007IH-1D; Thu, 01 May 2025 20:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAe4b-0007GB-Ea
 for qemu-devel@nongnu.org; Thu, 01 May 2025 20:16:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAe4Y-0000Mn-Kn
 for qemu-devel@nongnu.org; Thu, 01 May 2025 20:16:13 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4524D55D25C;
 Fri, 02 May 2025 02:16:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bXlgPmXHlMJ2; Fri,  2 May 2025 02:16:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 45A3B55D25A; Fri, 02 May 2025 02:16:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/char/serial: Remove unused prog_if compat property
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael S. Tsirkin <mst@redhat.com>, philmd@linaro.org
Message-Id: <20250502001605.45A3B55D25A@zero.eik.bme.hu>
Date: Fri, 02 May 2025 02:16:05 +0200 (CEST)
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

This property was added to preserve previous value when this was fixed
in version 2.1 but the 2.0 machine using it was already removed
leaving this property unused and unnecessary. This was also copy &
pasted into diva-gsp where it was probably never used so get rid of
this property at last.

Fixes: dbe442ad48 (hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/char/diva-gsp.c         |  6 ++----
 hw/char/serial-pci-multi.c |  7 ++-----
 hw/char/serial-pci.c       | 10 ++--------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 60f933191d..e1f0713cb7 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    uint8_t      prog_if;
     bool         disable;
 } PCIDivaSerialState;
 
@@ -124,8 +123,8 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
     size_t i, offset = 0;
     size_t portmask = di.omask;
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->membar, OBJECT(pci), "serial_ports", 4096);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &pci->membar);
     pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci, di.nports);
@@ -178,7 +177,6 @@ static const Property diva_serial_properties[] = {
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),
     DEFINE_PROP_CHR("chardev4",  PCIDivaSerialState, state[3].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIDivaSerialState, prog_if, 0x02),
     DEFINE_PROP_UINT32("subvendor", PCIDivaSerialState, subvendor,
                                     PCI_DEVICE_ID_HP_DIVA_TOSCA1),
 };
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index fb184c2e6d..13df272691 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -46,7 +46,6 @@ typedef struct PCIMultiSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     IRQState     irqs[PCI_SERIAL_MAX_PORTS];
-    uint8_t      prog_if;
 } PCIMultiSerialState;
 
 static void multi_serial_pci_exit(PCIDevice *dev)
@@ -97,8 +96,8 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     SerialState *s;
     size_t i, nports = multi_serial_get_port_count(pc);
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nports);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
 
@@ -133,7 +132,6 @@ static const VMStateDescription vmstate_pci_multi_serial = {
 static const Property multi_2x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
 };
 
 static const Property multi_4x_serial_pci_properties[] = {
@@ -141,7 +139,6 @@ static const Property multi_4x_serial_pci_properties[] = {
     DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
     DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
-    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
 };
 
 static void multi_2x_serial_pci_class_initfn(ObjectClass *klass,
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 8707e81914..46efabc4cb 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -38,7 +38,6 @@
 struct PCISerialState {
     PCIDevice dev;
     SerialState state;
-    uint8_t prog_if;
 };
 
 #define TYPE_PCI_SERIAL "pci-serial"
@@ -53,8 +52,8 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
-    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
+    pci->dev.config[PCI_CLASS_PROG] = 2; /* 16550 compatible */
+    pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     s->irq = pci_allocate_irq(&pci->dev);
 
     memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
@@ -81,10 +80,6 @@ static const VMStateDescription vmstate_pci_serial = {
     }
 };
 
-static const Property serial_pci_properties[] = {
-    DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
-};
-
 static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -96,7 +91,6 @@ static void serial_pci_class_initfn(ObjectClass *klass, const void *data)
     pc->revision = 1;
     pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
     dc->vmsd = &vmstate_pci_serial;
-    device_class_set_props(dc, serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
-- 
2.41.3


