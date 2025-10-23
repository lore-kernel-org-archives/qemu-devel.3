Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4872CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxD6-0005ts-BT; Thu, 23 Oct 2025 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD3-0005ru-2q; Thu, 23 Oct 2025 11:26:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD0-0001Ae-Vd; Thu, 23 Oct 2025 11:26:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1AECD5972F4;
 Thu, 23 Oct 2025 17:26:33 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GfeCHIYTlYud; Thu, 23 Oct 2025 17:26:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 192895972EA; Thu, 23 Oct 2025 17:26:31 +0200 (CEST)
Message-ID: <db9fdd0d870b5e4b5739febcc69067973f1ab292.1761232473.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 10/13] hw/pci-host/raven: Move bus master address space
 creation to one place
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
Date: Thu, 23 Oct 2025 17:26:31 +0200 (CEST)
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

Move the lines related to creating the bus master address space
together and reduce the number of memory regions stored in the device
state. These are used once to create the address space and can be
tracked with their owner object so no need to keep track of them in
the device state. Keep only the address space that is used later in a
callback.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index bf4f4b7f71..ebf0c511dc 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -46,9 +46,6 @@ struct PREPPCIState {
     MemoryRegion pci_discontiguous_io;
     MemoryRegion pci_memory;
     MemoryRegion pci_intack;
-    MemoryRegion bm;
-    MemoryRegion bm_ram_alias;
-    MemoryRegion bm_pci_memory_alias;
     AddressSpace bm_as;
 };
 
@@ -178,7 +175,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
-    MemoryRegion *mr, *address_space_mem = get_system_memory();
+    Object *o = OBJECT(d);
+    MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
@@ -187,26 +185,37 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                                    &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
                                    TYPE_PCI_BUS);
 
-    memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
+    memory_region_init_io(&h->conf_mem, o, &pci_host_conf_le_ops, s,
                           "pci-conf-idx", 4);
     memory_region_add_subregion(&s->pci_io, 0xcf8, &h->conf_mem);
 
-    memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops, s,
+    memory_region_init_io(&h->data_mem, o, &pci_host_data_le_ops, s,
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
     mr = g_new0(MemoryRegion, 1);
-    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
+    memory_region_init_io(mr, o, &raven_mmcfg_ops, h->bus,
                           "pci-mmcfg", 8 * MiB);
     memory_region_add_subregion(&s->pci_io, 0x800000, mr);
 
-    memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
+    memory_region_init_io(&s->pci_intack, o, &raven_intack_ops, s,
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
     pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
 
-    address_space_init(&s->bm_as, &s->bm, "raven-bm");
+    /* Bus master address space */
+    bm = g_new0(MemoryRegion, 1);
+    memory_region_init(bm, o, "raven-bm", 4 * GiB);
+    mr = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mr, o, "bm-pci-memory", &s->pci_memory, 0,
+                             memory_region_size(&s->pci_memory));
+    memory_region_add_subregion(bm, 0, mr);
+    mr = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mr, o, "bm-system", get_system_memory(),
+                             0, 0x80000000);
+    memory_region_add_subregion(bm, 0x80000000, mr);
+    address_space_init(&s->bm_as, bm, "raven-bm-as");
     pci_setup_iommu(h->bus, &raven_iommu_ops, s);
 }
 
@@ -228,16 +237,6 @@ static void raven_pcihost_initfn(Object *obj)
                                         &s->pci_discontiguous_io, 1);
     memory_region_set_enabled(&s->pci_discontiguous_io, false);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-
-    /* Bus master address space */
-    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
-    memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
-                             &s->pci_memory, 0,
-                             memory_region_size(&s->pci_memory));
-    memory_region_init_alias(&s->bm_ram_alias, obj, "bm-system",
-                             get_system_memory(), 0, 0x80000000);
-    memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
-    memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
 }
 
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-- 
2.41.3


