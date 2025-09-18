Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309C0CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUA-0001F5-9b; Thu, 18 Sep 2025 04:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATw-0000xQ-As
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATu-0004kz-1z
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185950; x=1789721950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p6gnyAA7xY2Xlvul8FV60Qy83JGL2sEDIdofNLNkPmk=;
 b=A8dD6PBTQMjHIv1raVI6V0x01HOS/6+YLLJkoc8jiT887o9CgSLoEs7K
 jRjZXLn1TK/JRGWouP+6R/IpCWlMZCeUR5v2Qy+TlINlXv2YjzH3nlorv
 Jl8rSayhX8nipKqMc6kAW8xuvrJvsAdyGkBQzLt5TdkW+2KwcwasX430x
 7ZEKQqhj5ZYoh1wVZIipUu45fTOBSHiBzPLeYJR56fPcEAruYIb/YrxTJ
 uUUfCpVl8n6OE1ITsmWq8fLDf1KbufZNYlGpbH6HuikneV9RLeGtCm3/e
 UqBBBhr1ThmWtVQiZxPM02hIn07/4FDw53PDnoEMhiX/LcwHwl+izrkpN w==;
X-CSE-ConnectionGUID: yCnvafGxQ2+txK5TIEXXOA==
X-CSE-MsgGUID: gxSOos0jS4qfzJFSKLY6lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109498"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109498"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:08 -0700
X-CSE-ConnectionGUID: jiPy0jKJSUezm+3S7eIsTg==
X-CSE-MsgGUID: BjxqV/ZjSjiYvQJalyad4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930369"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 09/22] intel_iommu: Stick to system MR for IOMMUFD backed
 host device when x-fls=on
Date: Thu, 18 Sep 2025 04:57:48 -0400
Message-ID: <20250918085803.796942-10-zhenzhong.duan@intel.com>
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

When guest enables scalable mode and setup first stage page table, we don't
want to use IOMMU MR but rather continue using the system MR for IOMMUFD
backed host device.

Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
as nesting parent HWPT to construct nested HWPT in vIOMMU.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ba40649c85..bd80de1670 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -40,6 +40,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define RID_PASID    0
@@ -1702,6 +1703,24 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
 
 }
 
+static VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    IntelIOMMUState *s = as->iommu_state;
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
+    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
+                                                       &key);
+
+    if (vtd_hiod && vtd_hiod->hiod &&
+        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        return vtd_hiod;
+    }
+    return NULL;
+}
+
 static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
@@ -1710,6 +1729,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
     assert(as);
 
     s = as->iommu_state;
+
     if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
                                  &ce)) {
         /*
@@ -1727,12 +1747,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 /* Return whether the device is using IOMMU translation. */
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
+    IntelIOMMUState *s;
     bool use_iommu, pt;
 
     assert(as);
 
-    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
-    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
+    s = as->iommu_state;
+    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
+    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+
+    /*
+     * When guest enables scalable mode and setup first stage page table,
+     * we stick to system MR for IOMMUFD backed host device. Then its
+     * default hwpt contains GPA->HPA mappings which is used directly
+     * if PGTT=PT and used as nesting parent if PGTT=FST. Otherwise
+     * fallback to original processing.
+     */
+    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
+        use_iommu = false;
+    }
 
     trace_vtd_switch_address_space(pci_bus_num(as->bus),
                                    VTD_PCI_SLOT(as->devfn),
-- 
2.47.1


