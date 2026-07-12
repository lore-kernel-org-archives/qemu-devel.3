Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A2C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiljs-0007nV-1x; Sun, 12 Jul 2026 00:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilib-0006PI-0B; Sun, 12 Jul 2026 00:23:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiliY-0007M0-Cm; Sun, 12 Jul 2026 00:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=SHH8SSUEZ0aYdLzJIEDv3hjtuTI4QUCllenGHZLjTHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EBeJFJ10rFgPDD50Jq+nAsNGwGuf8mrQEIOHYDkUSC7AKD+y4XuLnlTWvEb/FdzLl
 u78ohX4u24kvpWls8unbNgBP1F8ADYk39F1nGXJgMtTMPl8bflr+WBruPAf5Mz77cH
 QknyF6L1cznjj2YX2tY1Xmkny4WeKka5cZtG6P/m19vFMYHpgaGsJqZaZswBTrMTwn
 IWrkxRlGyzC83ofYa7aabee0lIvHREIx4Wn1TE/6LY2XehfCpMB+slGR4tA+7CyLVh
 2gQO9+RvjjGMWXYegJt23y1XqcCMtg0Cbm4+sgLvmnz11u1pimkRy9rNkWY3Z6QmzQ
 Tp6Wbb+tXVZsQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5776B1C0C1F;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B2383EB97F;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B70E513441; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chengbo Gao <gaochengbo@bosc.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 68/75] hw/riscv/riscv-iommu: Avoid caching PCI device
 IDs
Date: Sun, 12 Jul 2026 07:15:26 +0300
Message-ID: <20260712041539.108341-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Chengbo Gao <gaochengbo@bosc.ac.cn>

PCI bus numbers may still be unassigned when QEMU initializes a PCI
device's bus-master address space.  For devices behind bridges,
pci_bus_num() can return 0 at that point because the guest has not yet
programmed the bridge Secondary Bus Number register.

The RISC-V IOMMU currently stores a fixed device_id in RISCVIOMMUSpace
when the address space is created.  If the guest later enumerates the
device on a non-zero bus, DMA translation still uses the stale device_id
and may look up the wrong device context in the DDT.

Store the stable PCIBus pointer and devfn in RISCVIOMMUSpace instead,
and compute the device_id from the current bus number when it is needed.
This keeps DMA translation and ATS invalidation in sync with guest PCI
bus enumeration.

Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ca7bac51e04fa1ad384963577fabd3a58355ae23)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a7b0ab6d887..8e649b77752 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -46,7 +46,8 @@ struct RISCVIOMMUSpace {
     IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
     AddressSpace iova_as;       /* IOVA address space for attached device */
     RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
-    uint32_t devid;             /* Requester identifier, AKA device_id */
+    PCIBus *bus;                /* PCI bus of the requester */
+    uint8_t devfn;              /* Requester identifier, AKA device_id */
     bool notifier;              /* IOMMU unmap notifier enabled */
     QLIST_ENTRY(RISCVIOMMUSpace) list;
 };
@@ -71,6 +72,15 @@ struct RISCVIOMMUEntry {
 /* IOMMU index for transactions without process_id specified. */
 #define RISCV_IOMMU_NOPROCID 0
 
+static uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
+{
+    uint32_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+
+    /* FIXME: PCIe bus remapping for attached endpoints. */
+    devid |= as->iommu->bus << 8;
+    return devid;
+}
+
 static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
 {
     switch (vec_type) {
@@ -1440,15 +1450,13 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 }
 
 /* Find or allocate address space for a given device */
-static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
+static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
+                                            int devfn)
 {
     RISCVIOMMUSpace *as;
 
-    /* FIXME: PCIe bus remapping for attached endpoints. */
-    devid |= s->bus << 8;
-
     QLIST_FOREACH(as, &s->spaces, list) {
-        if (as->devid == devid) {
+        if (as->bus == bus && as->devfn == devfn) {
             break;
         }
     }
@@ -1458,10 +1466,11 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
         as = g_new0(RISCVIOMMUSpace, 1);
 
         as->iommu = s;
-        as->devid = devid;
+        as->bus = bus;
+        as->devfn = devfn;
 
         snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
-            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
+            pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
 
         /* IOVA address space, untranslated addresses */
         memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
@@ -1471,8 +1480,8 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
 
         QLIST_INSERT_HEAD(&s->spaces, as, list);
 
-        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
-                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
+        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
+                PCI_SLOT(devfn), PCI_FUNC(devfn));
     }
     return &as->iova_as;
 }
@@ -1797,7 +1806,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
     pid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
 
     QLIST_FOREACH(as, &s->spaces, list) {
-        if (as->devid == devid) {
+        if (riscv_iommu_space_devid(as) == devid) {
             break;
         }
     }
@@ -2800,8 +2809,9 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         .addr_mask = ~0ULL,
         .perm = flag,
     };
+    uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
@@ -2813,8 +2823,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     }
 
     /* Trace all dma translations with original access flags. */
-    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
-                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
+    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(devid),
+                          PCI_SLOT(devid), PCI_FUNC(devid), iommu_idx,
                           IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
                           iotlb.translated_addr);
 
@@ -2862,7 +2872,7 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
 
     /* Find first matching IOMMU */
     while (s != NULL && as == NULL) {
-        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
+        as = riscv_iommu_space(s, bus, devfn);
         s = s->iommus.le_next;
     }
 
-- 
2.47.3


