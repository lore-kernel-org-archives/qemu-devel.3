Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9BBCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 02:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNLU4-0006qA-Ls; Wed, 13 May 2026 22:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1wNLTw-0006oU-AH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:07:25 -0400
Received: from out28-92.mail.aliyun.com ([115.124.28.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1wNLTt-0006sz-1p
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1778724419; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=GMktV4XTnPON4W29gMFRYPo+MOSCIZjed8trymtP+tw=;
 b=Nk54EgHXXF+eY8LxLg2gDe+8pZWdLNHDzIgVRzU+Kkj9AtkjhAfVAxnW0Q/gYVMGdcpAUHmjyMcdoW6lwNxjNaJa6zI7YZWEEC+G5A+5I5HUl33D590VJnFZooywMhW8YPbN7LqZipWwRvmJfhR6MdtaTGbooCnD++WrQBQmPgwwQrEtnr4crRw0h6CH4mHhdf85m12QJBEcDOteWNDZ2AVJhBX3i3u7mlLh1Shj2td6puP3hitKiXuTfxTXfMmdAWhOugEGYcCawAQdHmLXn/pI3d532HpyfAW5piNB2CMaAUSW403SAAOCo5dJ9E6LSbITCNZU/gztA0TsS4RFsg==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1;
 BR=01201311R121S34rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00408917-8.41824e-05-0.995827;
 FP=11545387188656563608|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033040074035; MF=gaochengbo@bosc.ac.cn; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.hWcLmPV_1778724399; 
Received: from gao-3680..(mailfrom:gaochengbo@bosc.ac.cn
 fp:SMTPD_---.hWcLmPV_1778724399 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 14 May 2026 10:06:58 +0800
From: Chengbo Gao <gaochengbo@bosc.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
	Chengbo Gao <gaochengbo@bosc.ac.cn>
Subject: [PATCH v1] hw/riscv/riscv-iommu: Avoid caching PCI device IDs
Date: Thu, 14 May 2026 10:06:37 +0800
Message-Id: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.92; envelope-from=gaochengbo@bosc.ac.cn;
 helo=out28-92.mail.aliyun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
---
 hw/riscv/riscv-iommu.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7ba3240552..9a75639549 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -49,7 +49,8 @@ struct RISCVIOMMUSpace {
     IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
     AddressSpace iova_as;       /* IOVA address space for attached device */
     RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
-    uint32_t devid;             /* Requester identifier, AKA device_id */
+    PCIBus *bus;                /* PCI bus of the requester */
+    uint8_t devfn;              /* Requester identifier, AKA device_id */
     bool notifier;              /* IOMMU unmap notifier enabled */
     QLIST_ENTRY(RISCVIOMMUSpace) list;
 };
@@ -74,6 +75,15 @@ struct RISCVIOMMUEntry {
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
@@ -1343,15 +1353,13 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
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
@@ -1361,10 +1369,11 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
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
@@ -1374,8 +1383,8 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
 
         QLIST_INSERT_HEAD(&s->spaces, as, list);
 
-        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
-                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
+        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
+                PCI_SLOT(devfn), PCI_FUNC(devfn));
     }
     return &as->iova_as;
 }
@@ -1696,7 +1705,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
     pid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
 
     QLIST_FOREACH(as, &s->spaces, list) {
-        if (as->devid == devid) {
+        if (riscv_iommu_space_devid(as) == devid) {
             break;
         }
     }
@@ -2710,8 +2719,9 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         .addr_mask = ~0ULL,
         .perm = flag,
     };
+    uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
+    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
@@ -2723,8 +2733,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     }
 
     /* Trace all dma translations with original access flags. */
-    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
-                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
+    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(devid),
+                          PCI_SLOT(devid), PCI_FUNC(devid), iommu_idx,
                           IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
                           iotlb.translated_addr);
 
@@ -2772,7 +2782,7 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
 
     /* Find first matching IOMMU */
     while (s != NULL && as == NULL) {
-        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
+        as = riscv_iommu_space(s, bus, devfn);
         s = s->iommus.le_next;
     }
 
-- 
2.34.1


