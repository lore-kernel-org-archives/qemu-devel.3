Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88412CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTh-00086w-0M; Fri, 22 Aug 2025 02:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTf-000868-7D
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:19 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTY-0000lZ-Jc
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844933; x=1787380933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LfrC8XPlME7rgvU2pHuZGqdNFskAahIu0MKI2S1IxLI=;
 b=F4l9cWBYrmisqjNzkSfIRwG6vB1X+Is+s3IXu5LN7R/f9109WUL3hMXo
 tWLjzpL3QoizYkOMgQCZeWhG5lBksXUqB4rVf+JFvgJkjj/ucM7h8KA6x
 R8U8bnOC0jYGhqgXamsYGrpqOeV+PyKrU1ikpajJpSPweKmFX/glP0t9X
 /Dsap5lksGPez20fdmhC0vvQLSk1ZEgw91XpYa+w4CMeuDyG63Emw5xH+
 8rGYO6HQuIfAWG1lxCPkR1/X/T6WpyFQLqrzXip2uZjr+G49t8hvwouIf
 1m6AtQjxHFpfqpHbn1l6NQZuH/SMWfhcP0wi4Tm12JYbq9QwV+sgoC8DU w==;
X-CSE-ConnectionGUID: HB5ULAiUT/OYpJrAWtOpaw==
X-CSE-MsgGUID: kbzOGE41ToG/zDulqOZunw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851928"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851928"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:12 -0700
X-CSE-ConnectionGUID: Qy/kPDBJR0ic7iVxKEfJbQ==
X-CSE-MsgGUID: TYECliqyTc6KKlsYSEvPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244996"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v5 12/21] intel_iommu: Handle PASID entry addition
Date: Fri, 22 Aug 2025 02:40:50 -0400
Message-ID: <20250822064101.123526-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When guest creates new PASID entries, QEMU will capture the guest pasid
selective pasid cache invalidation, walk through each passthrough device
and each pasid, when a match is found, identify an existing vtd_as or
create a new one and update its corresponding cached pasid entry.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |   2 +
 hw/i386/intel_iommu.c          | 176 ++++++++++++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index b9b76dd996..fb2a919e87 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -559,6 +559,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
+#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
@@ -589,6 +590,7 @@ typedef struct VTDPASIDCacheInfo {
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a2ee6d684e..7d2c9feae7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -826,6 +826,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1647,9 +1652,9 @@ static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
 }
 
 /* Translate iommu pasid to vtd_as */
-static inline
-VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
-                                                uint16_t sid, uint32_t pasid)
+static VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
+                                                       uint16_t sid,
+                                                       uint32_t pasid)
 {
     struct vtd_as_raw_key key = {
         .sid = sid,
@@ -3220,10 +3225,172 @@ remove:
     return true;
 }
 
+/*
+ * This function walks over PASID range within [start, end) in a single
+ * PASID table for entries matching @info type/did, then retrieve/create
+ * vtd_as and fill associated pasid entry cache.
+ */
+static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
+                                        dma_addr_t pt_base,
+                                        int start,
+                                        int end,
+                                        VTDPASIDCacheInfo *info)
+{
+    VTDPASIDEntry pe;
+    int pasid = start;
+
+    while (pasid < end) {
+        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
+            && vtd_pe_present(&pe)) {
+            int bus_n = pci_bus_num(info->bus), devfn = info->devfn;
+            uint16_t sid = PCI_BUILD_BDF(bus_n, devfn);
+            VTDPASIDCacheEntry *pc_entry;
+            VTDAddressSpace *vtd_as;
+
+            vtd_iommu_lock(s);
+            /*
+             * When indexed by rid2pasid, vtd_as should have been created,
+             * e.g., by PCI subsystem. For other iommu pasid, we need to
+             * create vtd_as dynamically. Other iommu pasid is same value
+             * as PCI's pasid, so it's used as input of vtd_find_add_as().
+             */
+            vtd_as = vtd_as_from_iommu_pasid_locked(s, sid, pasid);
+            vtd_iommu_unlock(s);
+            if (!vtd_as) {
+                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
+            }
+
+            if ((info->type == VTD_PASID_CACHE_DOMSI ||
+                 info->type == VTD_PASID_CACHE_PASIDSI) &&
+                (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
+                /*
+                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+                 * requires domain id check. If domain id check fail,
+                 * go to next pasid.
+                 */
+                pasid++;
+                continue;
+            }
+
+            pc_entry = &vtd_as->pasid_cache_entry;
+            /*
+             * pasid cache update and clear are handled in
+             * vtd_flush_pasid_locked(), only care new pasid entry here.
+             */
+            if (!pc_entry->valid) {
+                pc_entry->pasid_entry = pe;
+                pc_entry->valid = true;
+            }
+        }
+        pasid++;
+    }
+}
+
+/*
+ * In VT-d scalable mode translation, PASID dir + PASID table is used.
+ * This function aims at looping over a range of PASIDs in the given
+ * two level table to identify the pasid config in guest.
+ */
+static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
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
+        pasid_next =
+             (pasid + VTD_PASID_TBL_ENTRY_NUM) & ~(VTD_PASID_TBL_ENTRY_NUM - 1);
+        pasid_next = pasid_next < end ? pasid_next : end;
+
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
+ * This function replays the guest pasid bindings by walking the two level
+ * guest PASID table. For each valid pasid entry, it finds or creates a
+ * vtd_as and caches pasid entry in vtd_as.
+ */
+static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
+                                            VTDPASIDCacheInfo *pc_info)
+{
+    /*
+     * Currently only Requests-without-PASID is supported, as vIOMMU doesn't
+     * support RPS(RID-PASID Support), pasid scope is fixed to [0, 1).
+     */
+    int start = 0, end = 1;
+    VTDHostIOMMUDevice *vtd_hiod;
+    VTDPASIDCacheInfo walk_info;
+    GHashTableIter as_it;
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_PASIDSI:
+        start = pc_info->pasid;
+        end = pc_info->pasid + 1;
+       /* fall through */
+    case VTD_PASID_CACHE_DOMSI:
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        /* loop all assigned devices */
+        break;
+    default:
+        error_setg(&error_fatal, "invalid pc_info->type for replay");
+    }
+
+    /*
+     * In this replay, one only needs to care about the devices which are
+     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
+     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
+     * is not necessary to replay the bindings since their cache could be
+     * re-created in the future DMA address translation.
+     *
+     * VTD translation callback never accesses vtd_hiod and its corresponding
+     * cached pasid entry, so no iommu lock needed here.
+     */
+    walk_info = *pc_info;
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        walk_info.bus = vtd_hiod->bus;
+        walk_info.devfn = vtd_hiod->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+    }
+}
+
 /*
  * For a PASID cache invalidation, this function handles below scenarios:
  * a) a present cached pasid entry needs to be removed
  * b) a present cached pasid entry needs to be updated
+ * c) a present cached pasid entry needs to be created
  */
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
 {
@@ -3239,6 +3406,9 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
                                 pc_info);
     vtd_iommu_unlock(s);
+
+    /* c): loop all passthrough device for new pasid entries */
+    vtd_replay_guest_pasid_bindings(s, pc_info);
 }
 
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
-- 
2.47.1


