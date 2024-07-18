Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1D2C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMMY-00070N-PJ; Thu, 18 Jul 2024 04:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMX-0006wT-Ev
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:41 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMU-0008CX-RC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290779; x=1752826779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIbrubkvEkSPS0YzQ6H3nvMCX3mqu3B1N5bY3N8r0+k=;
 b=hPb9UMTkbcjBGH3y8qoPdgWWXiUDll0p60bLbPYA1qDcW7+0ztPseCOe
 Q3PpwTIjiHgtmPuw46vSYMmbR/zAq4vhFxpsJFEYxRjCo/nT+GTJp0PYt
 9jxxcp7UufhzJs8eyuPCFdFtP4t3YmGTrlg+0BZpvQ3FjmORspls7XVnv
 pirF6gYOD9bhXW7oWTDt88m3z6d3rH7B9cbIXhvMrs/21FPJ0/fKnKSRv
 cqDMFCe3xIf81KKvxMQzxhAfPUUWF/VXtbP40pc26yVGPz3wHay/YxpQp
 z7UlhBatbBJ9xPMCAqLfSA2MKDEaTx274V+/11auOF5TiQqMrcRCAd6fO w==;
X-CSE-ConnectionGUID: 2p7MatdETkyi4keoLV6ykQ==
X-CSE-MsgGUID: MB69EeMSQX68seiD1npXTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996150"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:38 -0700
X-CSE-ConnectionGUID: u3Bgen0jTOORmpoHSwywrw==
X-CSE-MsgGUID: JjXWZoCvSgGDFzHVILc4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717156"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in PADID-selective
 PASID-based iotlb invalidation
Date: Thu, 18 Jul 2024 16:16:23 +0800
Message-Id: <20240718081636.879544-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 10 +++++
 hw/i386/intel_iommu.c          | 78 ++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4e0331caba..f71fc91234 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -440,6 +440,16 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
+#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
+
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000ffc0ULL
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
+
+#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & \
+                                             VTD_DOMAIN_ID_MASK)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 40cbd4a0f4..075a27adac 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2659,6 +2659,80 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
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
+        error_report_once("non-zero-field-in-piotlb_inv_desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
+    switch (inv_desc->val[0] & VTD_INV_DESC_IOTLB_G) {
+    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
+        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
+        break;
+
+    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        break;
+
+    default:
+        error_report_once("Invalid granularity in P-IOTLB desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -2769,6 +2843,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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


