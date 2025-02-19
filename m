Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55DAC021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQn-00069w-D1; Wed, 19 Feb 2025 03:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQL-0005rV-DJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:18 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQH-0004eO-Sn
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953634; x=1771489634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2sVWgDs4RI7dmwZT9u6bFAhLp8LgsfK8oLChJpWHE7M=;
 b=bU1Q/InRK6Bo7NDYkB8vY/QaKhfs2BVCvm2DN61DrrUlJ119K7kB4p2I
 UM6rcy3xZ0kyu3ylYsKtmZytE3cde1X5E+G1MZetJZIiOwK14NV7o4Bnb
 xyOqUCgBQSo5rrayFFo2z0Gd1673DXadjdvS8crzYQfmZFU6vM0/0NqWl
 QuO2mLupHYS4w6FBqcpRSDGcG0fP8lLdEGyNfmHJ9XpNAVitcq+bdVWxR
 1lJXCDOBwPbX08iPlVgC+u45aYk7QBxQnaOSlv3sqo6e6jYLEDGKX5mh6
 X57HtGO2ZMywtlpgfaeFSyMjJxF+lKyIPDnTGWvvTHvWkqB0F3vRmwli+ Q==;
X-CSE-ConnectionGUID: w5vPf67HQ+eSy7D8BF9GJQ==
X-CSE-MsgGUID: ueEag07OQ+iJaISGGQHfKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544239"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:09 -0800
X-CSE-ConnectionGUID: ObXa9MF/T/2YyiY9TIqGKQ==
X-CSE-MsgGUID: kpdNl1mFSP2VAD0WPT3TwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851265"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 13/20] intel_iommu: Add PASID cache management
 infrastructure
Date: Wed, 19 Feb 2025 16:22:21 +0800
Message-Id: <20250219082228.3303163-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
pasid entry and track PASID usage and future PASID tagged DMA address
translation support in vIOMMU.

VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
never freed. For other pasid, VTDAddressSpace instance is created/destroyed
per the guest pasid entry set up/destroy for passthrough devices. While for
emulated devices, VTDAddressSpace instance is created in the PASID tagged DMA
translation and be destroyed per guest PASID cache invalidation. This focuses
on the PASID cache management for passthrough devices as there is no PASID
capable emulated devices yet.

When guest modifies a PASID entry, QEMU will capture the guest pasid selective
pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
invalidation reasons:

    *) a present pasid entry moved to non-present
    *) a present pasid entry to be a present entry
    *) a non-present pasid entry moved to present

vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
and compare it with the PASID cache.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  29 ++
 include/hw/i386/intel_iommu.h  |   6 +
 hw/i386/intel_iommu.c          | 484 ++++++++++++++++++++++++++++++++-
 hw/i386/trace-events           |   4 +
 4 files changed, 513 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 18bc22fc72..632fda2853 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -315,6 +315,7 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
     /* PASID directory entry access failure */
     VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
     /* The Present(P) field of pasid directory entry is 0 */
@@ -492,6 +493,15 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
+#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000f1c0ULL
+
+#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
+#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -548,10 +558,28 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
+#define VTD_SM_CONTEXT_ENTRY_PDTS(val)      (((val) >> 9) & 0x7)
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPCInvType {
+    /* force reset all */
+    VTD_PASID_CACHE_FORCE_RESET = 0,
+    /* pasid cache invalidation rely on guest PASID entry */
+    VTD_PASID_CACHE_GLOBAL_INV,
+    VTD_PASID_CACHE_DOMSI,
+    VTD_PASID_CACHE_PASIDSI,
+} VTDPCInvType;
+
+typedef struct VTDPASIDCacheInfo {
+    VTDPCInvType type;
+    uint16_t domain_id;
+    uint32_t pasid;
+    PCIBus *bus;
+    uint16_t devfn;
+} VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
@@ -563,6 +591,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 50f9b27a45..fbc9da903a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -95,6 +95,11 @@ struct VTDPASIDEntry {
     uint64_t val[8];
 };
 
+typedef struct VTDPASIDCacheEntry {
+    struct VTDPASIDEntry pasid_entry;
+    bool cache_filled;
+} VTDPASIDCacheEntry;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -107,6 +112,7 @@ struct VTDAddressSpace {
     MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
+    VTDPASIDCacheEntry pasid_cache_entry;
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fafa199f52..b8f3b85803 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -86,6 +86,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset(IntelIOMMUState *s);
+
 static void vtd_panic_require_caching_mode(void)
 {
     error_report("We need to set caching-mode=on for intel-iommu to enable "
@@ -390,6 +392,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset(s);
     vtd_iommu_unlock(s);
 }
 
@@ -825,6 +828,16 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
+{
+    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
+}
+
+static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
+{
+    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1617,6 +1630,54 @@ static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
     }
 }
 
+/* Translate to iommu pasid if PCI_NO_PASID */
+static int vtd_as_to_iommu_pasid(VTDAddressSpace *vtd_as, uint32_t *pasid)
+{
+    VTDContextEntry ce;
+    int ret;
+
+    ret = vtd_as_to_context_entry(vtd_as, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        *pasid = VTD_CE_GET_RID2PASID(&ce);
+    } else {
+        *pasid = vtd_as->pasid;
+    }
+
+    return 0;
+}
+
+static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
+                                                   gpointer user_data)
+{
+    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
+    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
+    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
+    uint32_t pasid;
+
+    if (vtd_as_to_iommu_pasid(vtd_as, &pasid)) {
+        return false;
+    }
+
+    return (pasid == target->pasid) && (sid == target->sid);
+}
+
+/* Translate iommu pasid to vtd_as */
+static VTDAddressSpace *vtd_as_from_iommu_pasid(IntelIOMMUState *s,
+                                                uint16_t sid, uint32_t pasid)
+{
+    struct vtd_as_raw_key key = {
+        .sid = sid,
+        .pasid = pasid
+    };
+
+    return g_hash_table_find(s->vtd_address_spaces,
+                             vtd_find_as_by_sid_and_iommu_pasid, &key);
+}
+
 static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
                                      void *private)
 {
@@ -3062,6 +3123,412 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
+                                            uint32_t pasid, VTDPASIDEntry *pe)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDContextEntry ce;
+    int ret;
+
+    if (!s->root_scalable) {
+        return -VTD_FR_RTADDR_INV_TTM;
+    }
+
+    ret = vtd_as_to_context_entry(vtd_as, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
+}
+
+static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return !memcmp(p1, p2, sizeof(*p1));
+}
+
+/*
+ * This function fills in the pasid entry in &vtd_as. Caller
+ * of this function should hold iommu_lock.
+ */
+static void vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
+                                 VTDPASIDEntry *pe)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+
+    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+        /* No need to go further as cached pasid entry is latest */
+        return;
+    }
+
+    pc_entry->pasid_entry = *pe;
+    pc_entry->cache_filled = true;
+    /*
+     * TODO: send pasid bind to host for passthru devices
+     */
+}
+
+/*
+ * This function is used to clear cached pasid entry in vtd_as
+ * instances. Caller of this function should hold iommu_lock.
+ */
+static gboolean vtd_flush_pasid(gpointer key, gpointer value,
+                                gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDPASIDEntry pe;
+    uint16_t did;
+    uint32_t pasid;
+    int ret;
+
+    /* Replay only fill pasid entry cache for passthrough device */
+    if (!pc_entry->cache_filled) {
+        return false;
+    }
+    did = vtd_pe_get_domain_id(&pc_entry->pasid_entry);
+
+    if (vtd_as_to_iommu_pasid(vtd_as, &pasid)) {
+        goto remove;
+    }
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_FORCE_RESET:
+        goto remove;
+    case VTD_PASID_CACHE_PASIDSI:
+        if (pc_info->pasid != pasid) {
+            return false;
+        }
+        /* Fall through */
+    case VTD_PASID_CACHE_DOMSI:
+        if (pc_info->domain_id != did) {
+            return false;
+        }
+        /* Fall through */
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        break;
+    default:
+        error_report("invalid pc_info->type");
+        abort();
+    }
+
+    /*
+     * pasid cache invalidation may indicate a present pasid
+     * entry to present pasid entry modification. To cover such
+     * case, vIOMMU emulator needs to fetch latest guest pasid
+     * entry and check cached pasid entry, then update pasid
+     * cache and send pasid bind/unbind to host properly.
+     */
+    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
+    if (ret) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry
+         * was modified to be either all-zero or non-present. Either
+         * case means existing pasid cache should be removed.
+         */
+        goto remove;
+    }
+
+    vtd_fill_pe_in_cache(s, vtd_as, &pe);
+    return false;
+
+remove:
+    /*
+     * TODO: send pasid unbind to host for passthru devices
+     */
+    pc_entry->cache_filled = false;
+
+    /*
+     * Don't remove address space of PCI_NO_PASID which is created by PCI
+     * sub-system.
+     */
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        return false;
+    }
+    return true;
+}
+
+/* Caller of this function should hold iommu_lock */
+static void vtd_pasid_cache_reset(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_reset();
+
+    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
+
+    /*
+     * Reset pasid cache is a big hammer, so use
+     * g_hash_table_foreach_remove which will free
+     * the vtd_as instances. Also, as a big
+     * hammer, use VTD_PASID_CACHE_FORCE_RESET to
+     * ensure all the vtd_as instances are
+     * dropped, meanwhile the change will be passed
+     * to host if HostIOMMUDeviceIOMMUFD is available.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces,
+                                vtd_flush_pasid, &pc_info);
+}
+
+/* Caller of this function should hold iommu_lock. */
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
+            vtd_as = vtd_as_from_iommu_pasid(s, sid, pasid);
+            if (!vtd_as) {
+                vtd_as = vtd_find_add_as(s, info->bus, devfn, pasid);
+            }
+
+            if ((info->type == VTD_PASID_CACHE_DOMSI ||
+                 info->type == VTD_PASID_CACHE_PASIDSI) &&
+                !(info->domain_id == vtd_pe_get_domain_id(&pe))) {
+                /*
+                 * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
+                 * requires domain ID check. If domain Id check fail,
+                 * go to next pasid.
+                 */
+                pasid = pasid_next;
+                continue;
+            }
+            vtd_fill_pe_in_cache(s, vtd_as, &pe);
+        }
+        pasid = pasid_next;
+    }
+}
+
+/*
+ * Currently, VT-d scalable mode pasid table is a two level table,
+ * this function aims to loop a range of PASIDs in a given pasid
+ * table to identify the pasid config in guest.
+ * Caller of this function should hold iommu_lock.
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
+    VTDAddressSpace *vtd_as;
+
+    vtd_as = vtd_find_add_as(s, info->bus, info->devfn, PCI_NO_PASID);
+
+    if (!vtd_as_to_context_entry(vtd_as, &ce)) {
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
+ * latest guest pasid bindings. Caller should hold iommu_lock.
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
+    case VTD_PASID_CACHE_FORCE_RESET:
+        /* For force reset, no need to go further replay */
+        return;
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
+     * DMA address translation.
+     */
+    walk_info = *pc_info;
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        /* bus|devfn fields are not identical with pc_info */
+        walk_info.bus = vtd_hiod->bus;
+        walk_info.devfn = vtd_hiod->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+    }
+}
+
+/*
+ * This function syncs the pasid bindings between guest and host.
+ * It includes updating the pasid cache in vIOMMU and updating the
+ * pasid bindings per guest's latest pasid entry presence.
+ */
+static void vtd_pasid_cache_sync(IntelIOMMUState *s,
+                                 VTDPASIDCacheInfo *pc_info)
+{
+    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    /*
+     * Regards to a pasid cache invalidation, e.g. a PSI.
+     * it could be either cases of below:
+     * a) a present pasid entry moved to non-present
+     * b) a present pasid entry to be a present entry
+     * c) a non-present pasid entry moved to present
+     *
+     * Different invalidation granularity may affect different device
+     * scope and pasid scope. But for each invalidation granularity,
+     * it needs to do two steps to sync host and guest pasid binding.
+     *
+     * Here is the handling of a PSI:
+     * 1) loop all the existing vtd_as instances to update them
+     *    according to the latest guest pasid entry in pasid table.
+     *    this will make sure affected existing vtd_as instances
+     *    cached the latest pasid entries. Also, during the loop, the
+     *    host should be notified if needed. e.g. pasid unbind or pasid
+     *    update. Should be able to cover case a) and case b).
+     *
+     * 2) loop all devices to cover case c)
+     *    - For devices which are backed by HostIOMMUDeviceIOMMUFD instances,
+     *      we loop them and check if guest pasid entry exists. If yes,
+     *      it is case c), we update the pasid cache and also notify
+     *      host.
+     *    - For devices which are not backed by HostIOMMUDeviceIOMMUFD,
+     *      it is not necessary to create pasid cache at this phase since
+     *      it could be created when vIOMMU does DMA address translation.
+     *      This is not yet implemented since there is no emulated
+     *      pasid-capable devices today. If we have such devices in
+     *      future, the pasid cache shall be created there.
+     * Other granularity follow the same steps, just with different scope
+     *
+     */
+
+    vtd_iommu_lock(s);
+    /* Step 1: loop all the existing vtd_as instances */
+    g_hash_table_foreach_remove(s->vtd_address_spaces,
+                                vtd_flush_pasid, pc_info);
+
+    /*
+     * Step 2: loop all the existing vtd_hiod instances.
+     * Ideally, needs to loop all devices to find if there is any new
+     * PASID binding regards to the PASID cache invalidation request.
+     * But it is enough to loop the devices which are backed by host
+     * IOMMU. For devices backed by vIOMMU (a.k.a emulated devices),
+     * if new PASID happened on them, their vtd_as instance could
+     * be created during future vIOMMU DMA translation.
+     */
+    vtd_replay_guest_pasid_bindings(s, pc_info);
+    vtd_iommu_unlock(s);
+}
+
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    VTDPASIDCacheInfo pc_info;
+    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "pasid cache inv")) {
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->val[0]);
+
+    switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
+    case VTD_INV_DESC_PASIDC_DSI:
+        trace_vtd_pasid_cache_dsi(domain_id);
+        pc_info.type = VTD_PASID_CACHE_DOMSI;
+        pc_info.domain_id = domain_id;
+        break;
+
+    case VTD_INV_DESC_PASIDC_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_pasid_cache_psi(domain_id, pasid);
+        pc_info.type = VTD_PASID_CACHE_PASIDSI;
+        pc_info.domain_id = domain_id;
+        pc_info.pasid = pasid;
+        break;
+
+    case VTD_INV_DESC_PASIDC_GLOBAL:
+        trace_vtd_pasid_cache_gsi();
+        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+        break;
+
+    default:
+        error_report_once("invalid-inv-granu-in-pc_inv_desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    vtd_pasid_cache_sync(s, &pc_info);
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -3223,6 +3690,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PC:
+        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_pasid_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_PIOTLB:
         trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_piotlb_desc(s, &inv_desc)) {
@@ -3258,16 +3732,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
-    /*
-     * TODO: the entity of below two cases will be implemented in future series.
-     * To make guest (which integrates scalable mode support patch set in
-     * iommu driver) work, just return true is enough so far.
-     */
-    case VTD_INV_DESC_PC:
-        if (s->scalable_mode) {
-            break;
-        }
-    /* fallthrough */
     default:
         error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc.hi,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 53c02d7ac8..a26b38b52c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,10 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_gsi(void) ""
+vtd_pasid_cache_reset(void) ""
+vtd_pasid_cache_dsi(uint16_t domain) "Domain slective PC invalidation domain 0x%"PRIx16
+vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.34.1


