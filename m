Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82665CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJiI-00025i-ON; Thu, 18 Sep 2025 14:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi9-0001uN-28; Thu, 18 Sep 2025 14:50:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi4-0003Iv-VI; Thu, 18 Sep 2025 14:50:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B312A56F342;
 Thu, 18 Sep 2025 20:50:13 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id gMqlMP0iNZa3; Thu, 18 Sep 2025 20:50:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C16F056F325; Thu, 18 Sep 2025 20:50:11 +0200 (CEST)
Message-ID: <07eaef3ca91a8d7c9a4c71fe144ded6e9c4f9211.1758219840.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1758219840.git.balaton@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 07/14] hw/pci-host/raven: Rename direct config access ops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Sep 2025 20:50:11 +0200 (CEST)
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

Rename memory io ops implementing PCI configuration direct access to
mmcfg which describes better what these are for.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 66dab28a29..d7a0bde382 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -62,25 +62,24 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
     return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
 }
 
-static void raven_pci_io_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned int size)
+static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
 }
 
-static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
-                                  unsigned int size)
+static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
 }
 
-static const MemoryRegionOps raven_pci_io_ops = {
-    .read = raven_pci_io_read,
-    .write = raven_pci_io_write,
+static const MemoryRegionOps raven_mmcfg_ops = {
+    .read = raven_mmcfg_read,
+    .write = raven_mmcfg_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -234,8 +233,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_pci_io_ops, s,
-                          "pciio", 0x00400000);
+    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
+                          "pci-mmcfg", 0x00400000);
     memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
 
     memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
-- 
2.41.3


