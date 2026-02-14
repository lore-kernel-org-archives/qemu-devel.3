Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B6AEF99F6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6Y0-0005Bd-Bb; Fri, 13 Feb 2026 22:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xw-0005BE-Vp
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:17 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Xu-0008J1-No
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040535; x=1802576535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/24uhyM/Od+BHezlBFfol4UXOL2XJqBNPTrkAwP14ww=;
 b=mKCToUGDDDz/RW+62z8i6pzmMe4yWan/TH8b64RqlQYs/JDxjbVJPqzF
 7Or0vCo7/+K5wT7Q9ZhHc7Pj2Vs+qQb0ZwlcjOgtMKJTpZhaINU17eGYQ
 Df9g4H/A+DXtjUQOZNkQL85EOS6cqYM23yW57fDsllhfMk9lJ6YG1KYbz
 qfHhOM0/R9wNkSo6OYMCWbPmeAAlofoatEudBuy9bSTdkkkRa4omjerZq
 XLFIew34CS6SvKzFUuJ/Pz6hCD+oTEmtow58eFy7lG5qk5ezWiWlvq/UG
 RIEOPIifQInx/sjqZCI7kPfHE57qz1KEtUUwmams41DNe7I1pO0W0oroe w==;
X-CSE-ConnectionGUID: OGPRGOHTSTaWxzbSwbvzOQ==
X-CSE-MsgGUID: 8BiqaXg8Q6qrSiiQ85I1og==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666842"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:14 -0800
X-CSE-ConnectionGUID: 9kE6+MAeS4W+ZqSpkJwDQA==
X-CSE-MsgGUID: Fu7z/v4DSpaLrVS0uOOz8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212933091"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFCv2 PATCH 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Date: Fri, 13 Feb 2026 22:41:27 -0500
Message-ID: <20260214034135.220413-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214034135.220413-1-zhenzhong.duan@intel.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Structure VTDAddressSpace includes some elements suitable for emulated
device and passthrough device without PASID, e.g., address space,
different memory regions, etc, it is also protected by vtd iommu lock,
all these are useless and become a burden for passthrough device with
PASID.

When there are lots of PASIDs used in one device, the AS and MRs are
all registered to memory core and impact the whole system performance.

So instead of using VTDAddressSpace to cache pasid entry for each pasid
of a passthrough device, we define a light weight structure
VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
will use this struct as a parameter to conduct binding/unbinding to
nested hwpt and to record the current binded nested hwpt. It's also
designed to support PASID_0.

When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
(pasid cache invalidation) request, walk through each pasid in each
passthrough device for valid pasid entries, create a new
VTDACCELPASIDCacheEntry if not existing yet.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h    |  13 +++
 hw/i386/intel_iommu_internal.h |   8 ++
 hw/i386/intel_iommu.c          |   3 +
 hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index e5f0b077b4..a77fd06fe0 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -12,6 +12,13 @@
 #define HW_I386_INTEL_IOMMU_ACCEL_H
 #include CONFIG_DEVICES
 
+typedef struct VTDACCELPASIDCacheEntry {
+    VTDHostIOMMUDevice *vtd_hiod;
+    VTDPASIDEntry pe;
+    uint32_t pasid;
+    QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
+} VTDACCELPASIDCacheEntry;
+
 #ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
@@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
+void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
 {
 }
 
+static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
+                                              VTDPASIDCacheInfo *pc_info)
+{
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 8b020fb3a4..e4bcc884b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -615,6 +615,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
 #define PASID_0                             0
+#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
@@ -645,6 +646,7 @@ typedef struct VTDPIOTLBInvInfo {
 #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
 #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
 #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
@@ -710,6 +712,7 @@ typedef struct VTDHostIOMMUDevice {
     PCIBus *bus;
     uint8_t devfn;
     HostIOMMUDevice *hiod;
+    QLIST_HEAD(, VTDACCELPASIDCacheEntry) pasid_cache_list;
 } VTDHostIOMMUDevice;
 
 /*
@@ -767,6 +770,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
     return memcmp(p1, p2, sizeof(*p1));
 }
 
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
+}
+
 int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
                                   VTDPASIDDirEntry *pdire);
 int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d257dd95f6..bc7589a776 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3185,6 +3185,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
                          pc_info);
     vtd_iommu_unlock(s);
+
+    vtd_pasid_cache_sync_accel(s, pc_info);
 }
 
 static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
@@ -4743,6 +4745,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->devfn = (uint8_t)devfn;
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
+    QLIST_INIT(&vtd_hiod->pasid_cache_list);
 
     if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index c2757f3bcd..0acf3ae77f 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -257,6 +257,176 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
 
+static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
+                            VTDPASIDEntry *pe)
+{
+    VTDACCELPASIDCacheEntry *vtd_pce;
+
+    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+        if (vtd_pce->pasid == pasid) {
+            if (vtd_pasid_entry_compare(pe, &vtd_pce->pe)) {
+                vtd_pce->pe = *pe;
+            }
+            return;
+        }
+    }
+
+    vtd_pce = g_malloc0(sizeof(VTDACCELPASIDCacheEntry));
+    vtd_pce->vtd_hiod = vtd_hiod;
+    vtd_pce->pasid = pasid;
+    vtd_pce->pe = *pe;
+    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
+}
+
+/*
+ * This function walks over PASID range within [start, end) in a single
+ * PASID table for entries matching @info type/did, then create
+ * VTDACCELPASIDCacheEntry if not exist yet.
+ */
+static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
+                                        dma_addr_t pt_base,
+                                        int start,
+                                        int end,
+                                        VTDPASIDCacheInfo *info)
+{
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    VTDPASIDEntry pe;
+    int pasid;
+
+    for (pasid = start; pasid < end; pasid++) {
+        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
+            !vtd_pe_present(&pe)) {
+            continue;
+        }
+
+        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
+             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
+            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
+            /*
+             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+             * requires domain id check. If domain id check fail,
+             * go to next pasid.
+             */
+            continue;
+        }
+
+        vtd_find_add_pc(vtd_hiod, pasid, &pe);
+    }
+}
+
+/*
+ * In VT-d scalable mode translation, PASID dir + PASID table is used.
+ * This function aims at looping over a range of PASIDs in the given
+ * two level table to identify the pasid config in guest.
+ */
+static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
+                                    dma_addr_t pdt_base,
+                                    int start, int end,
+                                    VTDPASIDCacheInfo *info)
+{
+    VTDPASIDDirEntry pdire;
+    int pasid = start;
+    int pasid_next;
+    dma_addr_t pt_base;
+
+    while (pasid < end) {
+        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
+                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
+        pasid_next = pasid_next < end ? pasid_next : end;
+
+        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
+            && vtd_pdire_present(&pdire)) {
+            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
+                                        info);
+        }
+        pasid = pasid_next;
+    }
+}
+
+static void vtd_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
+                                          int start, int end,
+                                          VTDPASIDCacheInfo *pc_info)
+{
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    VTDContextEntry ce;
+    int dev_max_pasid = 1 << vtd_hiod->hiod->caps.max_pasid_log2;
+
+    if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
+                                  vtd_hiod->devfn, &ce)) {
+        VTDPASIDCacheInfo walk_info = *pc_info;
+        uint32_t ce_max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
+                                VTD_PASID_TABLE_ENTRY_NUM;
+
+        end = MIN(end, MIN(dev_max_pasid, ce_max_pasid));
+
+        vtd_sm_pasid_table_walk(vtd_hiod, VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                start, end, &walk_info);
+    }
+}
+
+/*
+ * This function replays the guest pasid bindings by walking the two level
+ * guest PASID table. For each valid pasid entry, it creates an entry
+ * VTDACCELPASIDCacheEntry dynamically if not exist yet. This entry holds
+ * info specific to a pasid
+ */
+void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
+{
+    int start = PASID_0, end = 1 << s->pasid;
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter as_it;
+
+    if (!s->fsts) {
+        return;
+    }
+
+    /*
+     * VTDPASIDCacheInfo honors PCI pasid but VTDACCELPASIDCacheEntry honors
+     * iommu pasid
+     */
+    if (pc_info->pasid == PCI_NO_PASID) {
+        pc_info->pasid = PASID_0;
+    }
+
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        start = pc_info->pasid;
+        end = pc_info->pasid + 1;
+        /* fall through */
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        /*
+         * loop all assigned devices, do domain id check in
+         * vtd_sm_pasid_table_walk_one() after get pasid entry.
+         */
+        break;
+    case VTD_INV_DESC_PASIDC_G_GLOBAL:
+        /* loop all assigned devices */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * In this replay, one only needs to care about the devices which are
+     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
+     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
+     * is not necessary to replay the bindings since their cache should be
+     * created in the future DMA address translation.
+     *
+     * VTD translation callback never accesses vtd_hiod and its corresponding
+     * cached pasid entry, so no iommu lock needed here.
+     */
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+            continue;
+        }
+        vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+    }
+}
+
 static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
                                           void *caps, uint32_t size)
 {
-- 
2.47.3


