Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE35CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUM-0001nq-Ph; Thu, 18 Sep 2025 04:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAU8-0001Fa-Px
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:24 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAU4-0004kl-LZ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185960; x=1789721960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yQiKzhGBfK8VyD3v53IITrSdxMzYeGm4fZs4KxzhbZU=;
 b=YDGWk1ZerS4vH7HkUXXWSlqB26tlrSN6Jc+qBLOwBn65F5gUp2//J4Gn
 0bBROD7zBGQlcAYde3EZmc1R3EUJ/MmiSv5ViFp2ec667msQJfQvWgaYs
 SiOKIOJEXMuoqGYsQYjj0WjY9fYiN20jZZN1SSdIVu3hIIM7ptx7FfKW1
 KsPWgjcfRlpMvF6pG8vhSgUUZcgzIXpihtiPBQfhnF4MaE88CqRR1e/1M
 kWXtOkVOv5CnC88Es3C8KzozJUwW5hrF/D9CXxWTQk5yd9mtOWsFipQBx
 YQRemJBiP3ECqffOcapAGkLuj0OylFFky+0XCpLbIVlh3jPhwwkuS3z71 g==;
X-CSE-ConnectionGUID: Rm0C3Fc0TSO6xmP8Q3nkSQ==
X-CSE-MsgGUID: x2+iXNFNSMG36ZBAlLrpnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109524"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109524"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:19 -0700
X-CSE-ConnectionGUID: NB2D5vfuSp+QLhl3Y+66zA==
X-CSE-MsgGUID: c7ZzSddASy20KxQTPKIm1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930394"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 12/22] intel_iommu: Handle PASID cache invalidation
Date: Thu, 18 Sep 2025 04:57:51 -0400
Message-ID: <20250918085803.796942-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

This adds PASID cache sync for RID_PASID, non-RID_PASID isn't supported.

Adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the pasid
entry and track PASID usage and future PASID tagged DMA address translation
support in vIOMMU.

When guest triggers pasid cache invalidation, QEMU will capture it and
update or invalidate pasid cache.

vIOMMU emulator could figure out the reason by fetching latest guest pasid
entry in memory and compare it with cached PASID entry if it's valid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  19 +++-
 include/hw/i386/intel_iommu.h  |   6 ++
 hw/i386/intel_iommu.c          | 157 ++++++++++++++++++++++++++++++---
 hw/i386/trace-events           |   3 +
 4 files changed, 173 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9cdc8d5dbb..d400bcee21 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
     /* PASID directory entry access failure */
     VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
     /* The Present(P) field of pasid directory entry is 0 */
@@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
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
@@ -552,6 +562,13 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef struct VTDPASIDCacheInfo {
+    uint8_t type;
+    uint16_t did;
+    uint32_t pasid;
+    bool reset;
+} VTDPASIDCacheInfo;
+
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
 #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
@@ -573,7 +590,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
 
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
-#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
 #define VTD_SM_PASID_ENTRY_FSPM          3ULL
 #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 3351892da0..ff01e5c82d 100644
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
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d37d47115a..24061f6dc6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1614,7 +1614,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
-        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        return VTD_SM_PASID_ENTRY_DID(&pe);
     }
 
     return VTD_CONTEXT_ENTRY_DID(ce->hi);
@@ -3074,6 +3074,144 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
+                                            VTDPASIDEntry *pe)
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
+    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
+}
+
+/*
+ * For each IOMMUFD backed device, update or invalidate pasid cache based on
+ * the value in memory.
+ */
+static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
+                                        gpointer user_data)
+{
+    VTDPASIDCacheInfo *pc_info = user_data;
+    VTDAddressSpace *vtd_as = value;
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDPASIDEntry pe;
+    uint16_t did;
+
+    /* Ignore emulated device or legacy VFIO backed device */
+    if (!vtd_find_hiod_iommufd(vtd_as)) {
+        return;
+    }
+
+    /* non-RID_PASID isn't supported yet */
+    assert(vtd_as->pasid == PCI_NO_PASID);
+
+    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry was modified
+         * to be either all-zero or non-present. Either case means existing
+         * pasid cache should be invalidated.
+         */
+        pc_entry->valid = false;
+        return;
+    }
+
+    /*
+     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
+     * DID check. If DID doesn't match the value in cache or memory, then
+     * it's not a pasid entry we want to invalidate.
+     */
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        if (pc_entry->valid) {
+            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
+            if (pc_info->did == did) {
+                break;
+            }
+        }
+        did = VTD_SM_PASID_ENTRY_DID(&pe);
+        if (pc_info->did == did) {
+            break;
+        }
+        return;
+    }
+
+    pc_entry->pasid_entry = pe;
+    pc_entry->valid = true;
+}
+
+static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
+{
+    if (!s->fsts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
+                         pc_info);
+    vtd_iommu_unlock(s);
+}
+
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t did;
+    uint32_t pasid;
+    VTDPASIDCacheInfo pc_info = {};
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
+    pc_info.type = VTD_INV_DESC_PASIDC_G(inv_desc);
+
+    switch (pc_info.type) {
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        trace_vtd_inv_desc_pasid_cache_dsi(did);
+        pc_info.did = did;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        /* PASID selective implies a DID selective */
+        trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
+        /* Currently non-RID_PASID invalidation requests are ignored */
+        if (pasid != RID_PASID) {
+            return true;
+        }
+        pc_info.did = did;
+        pc_info.pasid = pasid;
+        break;
+
+    case VTD_INV_DESC_PASIDC_G_GLOBAL:
+        trace_vtd_inv_desc_pasid_cache_gsi();
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
@@ -3236,6 +3374,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
@@ -3271,16 +3416,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
index ac9e1a10aa..298addb24d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_inv_desc_pasid_cache_gsi(void) ""
+vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
+vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.47.1


