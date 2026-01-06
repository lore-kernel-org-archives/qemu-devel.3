Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24184CD043F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0Yg-0007H9-Ti; Tue, 06 Jan 2026 01:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0YS-00079O-FS
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:34 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0YP-00036J-DC
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680909; x=1799216909;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=96lneYKLZsMOh+cDtpoWjfEObWa/iE8+8j0Li0F8f7I=;
 b=KwV1Mqj/0vdMe7YCxqF4IslD7HPx2cQkid2yVZxA7BN7ftgtH85LlkMf
 Asc7FtaBPvMrYpXOsg1Q24ZkXhTYtHsTziKTfP+qRYTwwD6Q9ebO/F344
 oMRSryCjCmkkItoQ/InPpZEF+tbZZrPNCnGduop7UnxMlz7hfC1xw4/LV
 13YCkbR2/WmzV/daor3SaMFZG4R4/gMIuMpXK1kBx5jKpI4StWYZveiT6
 pDGvpkEilXPhLYez8smLlMwCxTO7fa0iPf4C5tlwI4WusxDL3whLLGSXt
 Te7OgI345JT8gqlwJ37e11hQlMlRgNUemVTggZn5su8R6JT7yJmeefydu Q==;
X-CSE-ConnectionGUID: TqQMMJLLQa2w1PWOrGiMwg==
X-CSE-MsgGUID: CTj94WnvQ4iCJm6MtajEPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69025413"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69025413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:27 -0800
X-CSE-ConnectionGUID: f9Nc6yZ0Qiybobz4xMECdA==
X-CSE-MsgGUID: HghobdCMSmaoyrRaJ0+llw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202346111"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:24 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 2/4] intel_iommu_accel: Implement get_host_iommu_quirks()
 callback
Date: Tue,  6 Jan 2026 01:28:04 -0500
Message-ID: <20260106062808.316574-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106062808.316574-1-zhenzhong.duan@intel.com>
References: <20260106062808.316574-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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

Implement get_host_iommu_quirks() callback to retrieve the vendor specific
hardware information data and convert it into bitmaps defined with enum
host_iommu_quirks. It will be used by VFIO in subsequent patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h |  5 +++++
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 3b0ecc7e22..b19db6b63b 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -20,6 +20,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -47,5 +48,9 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
                                                     uint64_t npages, bool ih)
 {
 }
+
+static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bb21ae1743..e8a6f50a5a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5590,6 +5590,8 @@ static void vtd_class_init(ObjectClass *klass, const void *data)
     x86_class->int_remap = vtd_int_remap;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
+
+    vtd_iommu_ops_update_accel(&vtd_iommu_ops);
 }
 
 static const TypeInfo vtd_info = {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 89f3d55f6f..e1e668b8e0 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -12,6 +12,7 @@
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
@@ -249,3 +250,23 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach(s->vtd_address_spaces,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
+
+static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
+                                          void *caps, uint32_t size)
+{
+    struct iommu_hw_info_vtd *vtd = caps;
+    uint64_t quirks = 0;
+
+    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
+        sizeof(struct iommu_hw_info_vtd) <= size &&
+        vtd->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
+    }
+
+    return quirks;
+}
+
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+    ops->get_host_iommu_quirks = vtd_get_host_iommu_quirks;
+}
-- 
2.47.1


