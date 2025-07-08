Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E3C83F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFm-0004Rf-HV; Tue, 08 Jul 2025 16:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDs9-0000c3-Tj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:08 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDs4-0008BN-NZ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002453; x=1783538453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yx3q7fEaiyQjL76h7X90Owo+JKa7Jft2+4mZy+vciR8=;
 b=lO1z3QfHFu/YXfKIRSfXX8nlBmEr08oeLQeucNrFObYTlxj3cd1FuERL
 XXV2irFb7XKDYwQqz1eXUaI+4xy2f+or+nGjkdMWOmCocMcat4AqrS7vx
 4R40cGn4B10nEH6nbCuZI1jUHpd0iPQYKn3WjqolTp4Y0ZU7sly54ZcND
 H0hoPkibBDS42j4vA1PYnmUjoXdVqBgH5NleMCSq9m1VJqCFxIlQK4FjG
 XamZXM7PrYUc+oCSIYidv3ZSwQCPpa/GdJdb7WlLo8ajTE60tck/vYPCS
 wPz0A95h3YUjDEZZtX2rp+ivMx5CBxsXscDTpABbBUn30a2MuzFBQrZrw g==;
X-CSE-ConnectionGUID: 5xOQo2H4Rta8iYlxhDccow==
X-CSE-MsgGUID: +Irfg+OQTpuaIgBKzdTbdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974014"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974014"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:55 -0700
X-CSE-ConnectionGUID: MXHBRPVsTZaBDb32suObzw==
X-CSE-MsgGUID: 2n0s/+9VQMSQYv5jw0hYzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192647969"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v3 10/20] intel_iommu: Handle PASID entry removing and updating
Date: Tue,  8 Jul 2025 07:05:51 -0400
Message-ID: <20250708110601.633308-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
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

This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
pasid entry and track PASID usage and future PASID tagged DMA address
translation support in vIOMMU.

VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
never freed. For other pasid, VTDAddressSpace instance is created/destroyed
per the guest pasid entry set up/destroy.

When guest modifies a PASID entry, QEMU will capture the guest pasid selective
pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
invalidation reasons:

    a) a present pasid entry moved to non-present
    b) a present pasid entry to be a present entry
    c) a non-present pasid entry moved to present

This patch handles a) and b), following patch will handle c).

vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
and compare it with cached PASID entry.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          | 194 +++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  27 ++++-
 hw/i386/trace-events           |   3 +
 include/hw/i386/intel_iommu.h  |   6 +
 4 files changed, 218 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 38e7f7b7be..5bda439de6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1675,7 +1675,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
-        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        return VTD_SM_PASID_ENTRY_DID(&pe);
     }
 
     return VTD_CONTEXT_ENTRY_DID(ce->hi);
@@ -3103,6 +3103,181 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
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
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
+                                   &ce);
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
+ * This function is used to update or clear cached pasid entry in vtd_as.
+ * vtd_as is released when corresponding cached pasid entry is cleared,
+ * except for PCI_NO_PASID which vtd_as is owen by PCI sub-system.
+ */
+static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
+                                       gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDPASIDEntry pe;
+    uint16_t did;
+    uint32_t pasid;
+    int ret;
+
+    if (!pc_entry->valid) {
+        return false;
+    }
+    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+
+    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
+        goto remove;
+    }
+
+    switch (pc_info->type) {
+    case VTD_PASID_CACHE_PASIDSI:
+        if (pc_info->pasid != pasid) {
+            return false;
+        }
+        /* fall through */
+    case VTD_PASID_CACHE_DOMSI:
+        if (pc_info->did != did) {
+            return false;
+        }
+        /* fall through */
+    case VTD_PASID_CACHE_GLOBAL_INV:
+        break;
+    default:
+        error_setg(&error_fatal, "invalid pc_info->type for flush");
+    }
+
+    /*
+     * pasid cache invalidation may indicate a present pasid
+     * entry to present pasid entry modification. To cover such
+     * case, vIOMMU emulator needs to fetch latest guest pasid
+     * entry and compares with cached pasid entry, then update
+     * pasid cache.
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
+    /* No need to update if cached pasid entry is latest */
+    if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        pc_entry->pasid_entry = pe;
+    }
+    return false;
+
+remove:
+    pc_entry->valid = false;
+
+    /*
+     * Don't remove address space of PCI_NO_PASID which is created for PCI
+     * sub-system.
+     */
+    if (vtd_as->pasid == PCI_NO_PASID) {
+        return false;
+    }
+    return true;
+}
+
+/* Update the pasid cache in vIOMMU */
+static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
+{
+    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    /*
+     * Regards to a pasid cache invalidation, e.g. a PSI.
+     * It could be either cases of below:
+     * a) a present pasid entry moved to non-present
+     * b) a present pasid entry to be a present entry
+     * c) a non-present pasid entry moved to present
+     */
+    vtd_iommu_lock(s);
+    /*
+     * a,b): loop all the existing vtd_as instances for pasid cache remove
+       or update.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
+                                pc_info);
+    vtd_iommu_unlock(s);
+}
+
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t did;
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
+    did = VTD_INV_DESC_PASIDC_DID(inv_desc);
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc);
+
+    switch (VTD_INV_DESC_PASIDC_G(inv_desc)) {
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        trace_vtd_pasid_cache_dsi(did);
+        pc_info.type = VTD_PASID_CACHE_DOMSI;
+        pc_info.did = did;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_pasid_cache_psi(did, pasid);
+        pc_info.type = VTD_PASID_CACHE_PASIDSI;
+        pc_info.did = did;
+        pc_info.pasid = pasid;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_GLOBAL:
+        trace_vtd_pasid_cache_gsi();
+        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+        break;
+
+    default:
+        error_report_once("invalid granularity field in PASID-cache invalidate "
+                          "descriptor, hi: 0x%"PRIx64" lo: 0x%" PRIx64,
+                           inv_desc->val[1], inv_desc->val[0]);
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
@@ -3264,6 +3439,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
@@ -3299,16 +3481,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 18bc22fc72..87059d26aa 100644
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
 
+/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
+#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
+#define VTD_INV_DESC_PASIDC_G_DSI       0
+#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
+#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
+#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16, 16)
+#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32, 20)
+#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -552,6 +562,21 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPCInvType {
+    /* VTD spec defined PASID cache invalidation type */
+    VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
+    VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
+    VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
+} VTDPCInvType;
+
+typedef struct VTDPASIDCacheInfo {
+    VTDPCInvType type;
+    uint16_t did;
+    uint32_t pasid;
+    PCIBus *bus;
+    uint16_t devfn;
+} VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
@@ -573,7 +598,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
 
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
-#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
 #define VTD_SM_PASID_ENTRY_FLPM          3ULL
 #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ac9e1a10aa..ae5bbfcdc0 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_gsi(void) ""
+vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
+vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 50f9b27a45..0e3826f6f0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -95,6 +95,11 @@ struct VTDPASIDEntry {
     uint64_t val[8];
 };
 
+typedef struct VTDPASIDCacheEntry {
+    struct VTDPASIDEntry pasid_entry;
+    bool valid;
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
-- 
2.47.1


