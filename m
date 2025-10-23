Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FE1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxD5-0005tl-Ty; Thu, 23 Oct 2025 11:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxD0-0005pS-39; Thu, 23 Oct 2025 11:26:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCy-00019o-7f; Thu, 23 Oct 2025 11:26:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F10AD5972ED;
 Thu, 23 Oct 2025 17:26:29 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id gHLPOF2eK34r; Thu, 23 Oct 2025 17:26:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EEC3B5972F4; Thu, 23 Oct 2025 17:26:27 +0200 (CEST)
Message-ID: <797587b52159d2db79ed924b4962be7e7ba84207.1761232472.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 07/13] hw/pci-host/raven: Do not use parent object for
 mmcfg region
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
Date: Thu, 23 Oct 2025 17:26:27 +0200 (CEST)
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

The mmcfg field in PCIHostState is only used by raven for the PCI
config direct access but is not actually needed as the memory region
lifetime can be managed by the object given during init so use that
and remove the unused field from PCIHostState.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c       | 7 ++++---
 include/hw/pci/pci_host.h | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 2057a1869f..23020fd09f 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -216,7 +216,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
-    MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *mr, *address_space_mem = get_system_memory();
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
@@ -233,9 +233,10 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
+    mr = g_new0(MemoryRegion, 1);
+    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
                           "pci-mmcfg", 0x00400000);
-    memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
+    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
 
     memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
                           "pci-intack", 1);
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 954dd446fa..a13f879872 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -41,7 +41,6 @@ struct PCIHostState {
 
     MemoryRegion conf_mem;
     MemoryRegion data_mem;
-    MemoryRegion mmcfg;
     uint32_t config_reg;
     bool mig_enabled;
     PCIBus *bus;
-- 
2.41.3


