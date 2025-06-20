Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D499C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5e-0004me-9I; Fri, 20 Jun 2025 03:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5b-0004gU-SD
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:07 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5Y-0008IS-3p
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404184; x=1781940184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B4cEMgSjmU068gRuPx5HIPdkt0+5w/rB4JeXu6eo3pQ=;
 b=eE3hBV17chtyl6G3wmH81p/0yvb5ZtFasEe6yEhsv/EgXqcPz9iKrE/9
 /dW1H5itt8O0Ox7BrXlC36O1kHPltGmRfR8yu+ZJKi1S5iIXFdAruwG/v
 zj2SnnpXgkOUay3KqrMc2MqzQr5aFdzwtyfdhp6JJ4MM85fHML8Tzeeqt
 aEqhwrGqYLC3oKbaUfS/S6BTr9DDBNX4l9Dcp5G9Q84cFa4QEWSTRkbNd
 e20gVnQhhAuizlrg5t41DJKMq2Cyh3gLr2lhSIx3R2+DS37rgr8036Pmq
 Er4wEbSZTDBAUIBKIWc9M8vrOrzDVW6C2Hn6uQr86e8DOrx6xln6fj1b5 Q==;
X-CSE-ConnectionGUID: 4XmFrKphT/ujm615ODxnZA==
X-CSE-MsgGUID: ikCIQ77WT42dnHxH3oyuNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532420"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532420"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:03 -0700
X-CSE-ConnectionGUID: fXo9SXzCTBCDHM3OoVTfpQ==
X-CSE-MsgGUID: lgOrHunRS9Kscjcm8A/OrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863222"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 11/19] intel_iommu: Handle PASID entry adding
Date: Fri, 20 Jun 2025 15:18:05 +0800
Message-Id: <20250620071813.55571-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When guest modifies a PASID entry, QEMU will capture the guest pasid selective
pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
invalidation reasons:

    a) a present pasid entry moved to non-present
    b) a present pasid entry to be a present entry
    c) a non-present pasid entry moved to present

This handles c).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/intel_iommu.c          | 169 ++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 01c881ed4d..025787b3b9 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -558,6 +558,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
+#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1db581d14a..f4273dc640 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -826,6 +826,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
+}
+
 static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
 {
     return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
@@ -3246,6 +3251,159 @@ remove:
     return true;
 }
 
+static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
+                                        dma_addr_t pt_base,
+                                        int start,
+                                        int end,
+                                        VTDPASIDCacheInfo *info)
+{
+    VTDPASIDEntry pe;
+    int pasid = start;
+    int pasid_next;
+
+    while (pasid < end) {
+        pasid_next = pasid + 1;
+
+        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
+            && vtd_pe_present(&pe)) {
+            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
+            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
+            VTDAddressSpace *vtd_as;
+
+            vtd_iommu_lock(s);
+            /*
+             * When indexed by rid2pasid, vtd_as should have been created,
+             * e.g., by PCI subsystem. For other iommu pasid, we need to
+             * create vtd_as dynamically. The other iommu pasid is same as
+             * PCI's pasid, so it's used as input of vtd_find_add_as().
+             */
+            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
+            vtd_iommu_unlock(s);
+            if (!vtd_as) {
+                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
+            }
+
+            if ((info->type == VTD_PASID_CACHE_DOMSI ||
+                 info->type == VTD_PASID_CACHE_PASIDSI) &&
+                !(info->domain_id == vtd_pe_get_did(&pe))) {
+                /*
+                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+                 * requires domain ID check. If domain Id check fail,
+                 * go to next pasid.
+                 */
+                pasid = pasid_next;
+                continue;
+            }
+            if (vtd_fill_pe_in_cache(s, vtd_as, &pe)) {
+                pasid_cache_info_set_error(info);
+            }
+        }
+        pasid = pasid_next;
+    }
+}
+
+/*
+ * Currently, VT-d scalable mode pasid table is a two level table,
+ * this function aims to loop a range of PASIDs in a given pasid
+ * table to identify the pasid config in guest.
+ */
+static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
+                                    dma_addr_t pdt_base,
+                                    int start,
+                                    int end,
+                                    VTDPASIDCacheInfo *info)
+{
+    VTDPASIDDirEntry pdire;
+    int pasid = start;
+    int pasid_next;
+    dma_addr_t pt_base;
+
+    while (pasid < end) {
+        pasid_next = ((end - pasid) > VTD_PASID_TBL_ENTRY_NUM) ?
+                      (pasid + VTD_PASID_TBL_ENTRY_NUM) : end;
+        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
+            && vtd_pdire_present(&pdire)) {
+            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+            vtd_sm_pasid_table_walk_one(s, pt_base, pasid, pasid_next, info);
+        }
+        pasid = pasid_next;
+    }
+}
+
+static void vtd_replay_pasid_bind_for_dev(IntelIOMMUState *s,
+                                          int start, int end,
+                                          VTDPASIDCacheInfo *info)
+{
+    VTDContextEntry ce;
+
+    if (!vtd_dev_to_context_entry(s, pci_bus_num(info->bus), info->devfn,
+                                  &ce)) {
+        uint32_t max_pasid;
+
+        max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) * VTD_PASID_TBL_ENTRY_NUM;
+        if (end > max_pasid) {
+            end = max_pasid;
+        }
+        vtd_sm_pasid_table_walk(s,
+                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                start,
+                                end,
+                                info);
+    }
+}
+
+/*
+ * This function replay the guest pasid bindings to hosts by
+ * walking the guest PASID table. This ensures host will have
+ * latest guest pasid bindings.
+ */
+static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
+                                            VTDPASIDCacheInfo *pc_info)
+{
+    VTDHostIOMMUDevice *vtd_hiod;
+    int start = 0, end = 1; /* only rid2pasid is supported */
+    VTDPASIDCacheInfo walk_info;
+    GHashTableIter as_it;
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_PASIDSI:
+        start = pc_info->pasid;
+        end = pc_info->pasid + 1;
+        /*
+         * PASID selective invalidation is within domain,
+         * thus fall through.
+         */
+    case VTD_PASID_CACHE_DOMSI:
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        /* loop all assigned devices */
+        break;
+    default:
+        error_report("invalid pc_info->type for replay");
+        abort();
+    }
+
+    /*
+     * In this replay, only needs to care about the devices which
+     * are backed by host IOMMU. For such devices, their vtd_hiod
+     * instances are in the s->vtd_host_iommu_dev. For devices which
+     * are not backed by host IOMMU, it is not necessary to replay
+     * the bindings since their cache could be re-created in the future
+     * DMA address translation. Access to vtd_host_iommu_dev is already
+     * protected by BQL, so no iommu lock needed here.
+     */
+    walk_info = *pc_info;
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        /* bus|devfn fields are not identical with pc_info */
+        walk_info.bus = vtd_hiod->bus;
+        walk_info.devfn = vtd_hiod->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+    }
+    if (walk_info.error_happened) {
+        pasid_cache_info_set_error(pc_info);
+    }
+}
+
 /*
  * This function syncs the pasid bindings between guest and host.
  * It includes updating the pasid cache in vIOMMU and updating the
@@ -3301,7 +3459,16 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
                                 pc_info);
     vtd_iommu_unlock(s);
 
-    /* TODO: Step 2: loop all the existing vtd_hiod instances for pasid bind. */
+    /*
+     * Step 2: loop all the existing vtd_hiod instances for pasid bind.
+     * Ideally, needs to loop all devices to find if there is any new
+     * PASID binding regards to the PASID cache invalidation request.
+     * But it is enough to loop the devices which are backed by host
+     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
+     * if new PASID happened on them, their vtd_as instance could
+     * be created during future vIOMMU DMA translation.
+     */
+    vtd_replay_guest_pasid_bindings(s, pc_info);
 }
 
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
-- 
2.34.1


