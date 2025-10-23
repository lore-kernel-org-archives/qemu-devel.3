Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E17CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxD2-0005rm-UJ; Thu, 23 Oct 2025 11:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCx-0005of-P0; Thu, 23 Oct 2025 11:26:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCt-00018T-TI; Thu, 23 Oct 2025 11:26:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9A8815972E8;
 Thu, 23 Oct 2025 17:26:23 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id VPNQlTcISdtv; Thu, 23 Oct 2025 17:26:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 945565972EA; Thu, 23 Oct 2025 17:26:21 +0200 (CEST)
Message-ID: <5a60e395d72e5eb4d01093434fbb645d72ac567a.1761232472.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 01/13] hw/pci-host/raven: Simplify creating PCI facing part
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
Date: Thu, 23 Oct 2025 17:26:21 +0200 (CEST)
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

There is no need to init and realize the PCI facing part of the host
bridge separately as it does not expose any properties that need to be
available before realize. It can be simpilfied using pci_create_simple.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index eacffc86d8..c0492d1456 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -65,7 +65,6 @@ struct PRePPCIState {
     MemoryRegion bm_ram_alias;
     MemoryRegion bm_pci_memory_alias;
     AddressSpace bm_as;
-    RavenPCIState pci_dev;
 
     int contiguous_map;
 };
@@ -260,8 +259,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    /* TODO Remove once realize propagates to child devices. */
-    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
+    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
 }
 
 static void raven_pcihost_initfn(Object *obj)
@@ -269,7 +267,6 @@ static void raven_pcihost_initfn(Object *obj)
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
     MemoryRegion *address_space_mem = get_system_memory();
-    DeviceState *pci_dev;
 
     memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
@@ -306,12 +303,6 @@ static void raven_pcihost_initfn(Object *obj)
     pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
 
     h->bus = &s->pci_bus;
-
-    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
-    pci_dev = DEVICE(&s->pci_dev);
-    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
-                            NULL);
-    qdev_prop_set_bit(pci_dev, "multifunction", false);
 }
 
 static void raven_realize(PCIDevice *d, Error **errp)
-- 
2.41.3


