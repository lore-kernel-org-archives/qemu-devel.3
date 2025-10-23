Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E8CCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxD7-0005v6-O8; Thu, 23 Oct 2025 11:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD4-0005sL-Lq; Thu, 23 Oct 2025 11:26:39 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD2-0001BL-MM; Thu, 23 Oct 2025 11:26:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 37F12597307;
 Thu, 23 Oct 2025 17:26:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id peSa1Y49Qmwh; Thu, 23 Oct 2025 17:26:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 32FA35972FF; Thu, 23 Oct 2025 17:26:33 +0200 (CEST)
Message-ID: <f1eaeaf1d777c358980b33f7a202319393dccf6f.1761232473.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 12/13] hw/ppc/prep: Fix non-contiguous IO control bit
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
Date: Thu, 23 Oct 2025 17:26:33 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The bit that is supposed to control if ISA IO ports are accessed with
discontiguous addresses was not connected so it did nothing. We can
now directly enable or disable the discontiguous region so allow the
bit to function. This did not cause a problem so far as nothing seems
to use this bit or discontiguous IO addresses.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c    |  9 ---------
 hw/ppc/prep.c          |  3 +++
 hw/ppc/prep_systemio.c | 17 +++++++++++------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 1e36a637a6..7ebca8186b 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -161,13 +161,6 @@ static const PCIIOMMUOps raven_iommu_ops = {
     .get_address_space = raven_pcihost_set_iommu,
 };
 
-static void raven_change_gpio(void *opaque, int n, int level)
-{
-    PREPPCIState *s = opaque;
-
-    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
-}
-
 static void raven_pcihost_realize(DeviceState *d, Error **errp)
 {
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
@@ -176,8 +169,6 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
     Object *o = OBJECT(d);
     MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
 
-    qdev_init_gpio_in(d, raven_change_gpio, 1);
-
     memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
     memory_region_init_io(&s->pci_discontiguous_io, o,
                           &raven_io_ops, &s->pci_io,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 973d2fb7eb..3f497910f4 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -322,6 +322,9 @@ static void ibm_40p_init(MachineState *machine)
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
     qdev_prop_set_uint32(dev, "equipment", 0xc0);
+    object_property_set_link(OBJECT(dev), "discontiguous-io",
+                             OBJECT(sysbus_mmio_get_region(pcihost, 1)),
+                             &error_fatal);
     isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
     /* Memory controller */
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 41cd923b94..6ef9b91317 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -44,9 +44,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
 
 struct PrepSystemIoState {
     ISADevice parent_obj;
+
     MemoryRegion ppc_parity_mem;
+    MemoryRegion *discontiguous_io;
 
-    qemu_irq non_contiguous_io_map_irq;
     uint8_t sreset; /* 0x0092 */
     uint8_t equipment; /* 0x080c */
     uint8_t system_control; /* 0x081c */
@@ -206,8 +207,8 @@ static void prep_port0850_write(void *opaque, uint32_t addr, uint32_t val)
     PrepSystemIoState *s = opaque;
 
     trace_prep_systemio_write(addr, val);
-    qemu_set_irq(s->non_contiguous_io_map_irq,
-                 val & PORT0850_IOMAP_NONCONTIGUOUS);
+    memory_region_set_enabled(s->discontiguous_io,
+                              !(val & PORT0850_IOMAP_NONCONTIGUOUS));
     s->iomap_type = val & PORT0850_IOMAP_NONCONTIGUOUS;
 }
 
@@ -257,10 +258,10 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
     PrepSystemIoState *s = PREP_SYSTEMIO(dev);
     PowerPCCPU *cpu;
 
-    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
+    assert(s->discontiguous_io);
     s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
-    qemu_set_irq(s->non_contiguous_io_map_irq,
-                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
+    memory_region_set_enabled(s->discontiguous_io,
+                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));
     cpu = POWERPC_CPU(first_cpu);
     s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
 
@@ -288,6 +289,8 @@ static const VMStateDescription vmstate_prep_systemio = {
 static const Property prep_systemio_properties[] = {
     DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
     DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
+    DEFINE_PROP_LINK("discontiguous-io", PrepSystemIoState, discontiguous_io,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
@@ -296,6 +299,8 @@ static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)
 
     dc->realize = prep_systemio_realize;
     dc->vmsd = &vmstate_prep_systemio;
+    /* Reason: PReP specific device, needs to be wired via properties */
+    dc->user_creatable = false;
     device_class_set_props(dc, prep_systemio_properties);
 }
 
-- 
2.41.3


