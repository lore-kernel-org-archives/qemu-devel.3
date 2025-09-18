Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB51CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJiA-0001wa-Uw; Thu, 18 Sep 2025 14:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi7-0001tf-QW; Thu, 18 Sep 2025 14:50:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi4-0003J0-UW; Thu, 18 Sep 2025 14:50:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C336656F343;
 Thu, 18 Sep 2025 20:50:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rRhOXjmAeMTq; Thu, 18 Sep 2025 20:50:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CE25356F30C; Thu, 18 Sep 2025 20:50:12 +0200 (CEST)
Message-ID: <b5b4558125e2408ded29f7cdc306011358829044.1758219840.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1758219840.git.balaton@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 08/14] hw/pci-host/raven: Use correct parameter in direct
 access ops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Sep 2025 20:50:12 +0200 (CEST)
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

Instead of passing unneeded enclosing objects to the config direct
access ops that only need the bus we can pass that directly thus
simplifying the functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index d7a0bde382..2057a1869f 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -65,16 +65,16 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
 static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
+    PCIBus *hbus = opaque;
+
+    pci_data_write(hbus, raven_idsel_to_addr(addr), val, size);
 }
 
 static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    PREPPCIState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
+    PCIBus *hbus = opaque;
+
+    return pci_data_read(hbus, raven_idsel_to_addr(addr), size);
 }
 
 static const MemoryRegionOps raven_mmcfg_ops = {
@@ -233,7 +233,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
 
-    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
+    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
                           "pci-mmcfg", 0x00400000);
     memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
 
-- 
2.41.3


