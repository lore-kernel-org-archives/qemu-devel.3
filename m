Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C70C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarEq-0002R2-85; Mon, 05 Aug 2024 02:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEn-0002EL-2Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:34 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEg-00029G-OK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839427; x=1754375427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NZt17FWZUx2Aa1+AVbgbpJyQ9o1iDE5qgd6Cq+0OOXk=;
 b=h5onyc1AjIkH+49VZY/sOoG/kQJBC9mNL/GfDaWWfmKJivNv7pLnpi2S
 7CN7QdYl7WqD9Nmya0V4oysQldfWrHFRnhSQzESUyWScgPcqEjJwQG8EC
 JqMEH30OcKZrF25Dt8YevG42tqvu2z1sgx9Mic/+ukD8AALJeCM0onPot
 jzlKYqmWf7RaXZxibsN4a0gIgBjzNgZcEZ1VX/xqyjbPGqh29HB4z82Ez
 r1k4haHHIrlnCy2UQ6iVypIYIg8q+O1CJAn4N2F3SE+qnvEfkm7cy7ZcW
 VcV+Y2XbowamTu3EzWnN5mqP1MPba7Cc5tQ57XYpKwYrlAg0Mrq91z6T8 g==;
X-CSE-ConnectionGUID: LCyz9CVETIOo71kvaQPCQQ==
X-CSE-MsgGUID: iRCkZkhCQmeBySXW3cfLag==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282698"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:26 -0700
X-CSE-ConnectionGUID: W8Ajc3dfSW2R+ACkQ0qOTw==
X-CSE-MsgGUID: A+u4vpSMTz2joKprmi/MMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786631"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in PASID-selective
 PASID-based iotlb invalidation
Date: Mon,  5 Aug 2024 14:27:14 +0800
Message-Id: <20240805062727.2307552-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
flush stage-2 iotlb entries with matching domain id and pasid.

With scalable modern mode introduced, guest could send PASID-selective
PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.

By this chance, remove old IOTLB related definition.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 14 +++---
 hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 8fa27c7f3b..19e4ed52ca 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -402,11 +402,6 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
 #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
-#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
 
 /* Mask for Device IOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
@@ -438,6 +433,15 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Masks for PIOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
+#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c1382a5651..df591419b7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2656,6 +2656,83 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     return true;
 }
 
+static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+
+    return ((entry->domain_id == info->domain_id) &&
+            (entry->pasid == info->pasid));
+}
+
+static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
+                                        uint16_t domain_id, uint32_t pasid)
+{
+    VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
+                                &info);
+    vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+                vtd_as->pasid != pasid) {
+                continue;
+            }
+
+            if (!s->scalable_modern) {
+                vtd_address_space_sync(vtd_as);
+            }
+        }
+    }
+}
+
+static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
+                                    VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+
+    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
+        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
+        error_report_once("%s: invalid piotlb inv desc hi=0x%"PRIx64
+                          " lo=0x%"PRIx64" (reserved bits unzero)",
+                          __func__, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
+    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
+    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
+        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
+        break;
+
+    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        break;
+
+    default:
+        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
+                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
+                          __func__, inv_desc->val[1], inv_desc->val[0],
+                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
+        return false;
+    }
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -2775,6 +2852,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         break;
 
     case VTD_INV_DESC_PIOTLB:
+        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
         break;
 
     case VTD_INV_DESC_WAIT:
-- 
2.34.1


