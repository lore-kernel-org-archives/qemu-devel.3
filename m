Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9246DF513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7C-0004LS-UE; Thu, 05 Mar 2026 22:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7A-0004LK-Qm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:37 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM79-00066q-5j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768675; x=1804304675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eonLPTLYxHldYtymxYRdcAgJia5SUfNkvhTZV0PxX1E=;
 b=iPgYHdLM+4t62EPeY8woRHqAXwXE2N8DlpLaUDKSzwx2Zy3YNDmsyden
 /DLzUl3sSjbDqZEiN2A5Ugih1f7Cn8pWYn6mXGCJyM6OEp0gx8cGk+mny
 FYb5/nRvYaAOBXLtn/+eHQFjYHqroGDLKiSgvbvgX+gWPJT20O6wYHAXv
 7KdfvlrbcKJ/v6mn3ZVqWuawDDCd6BEs7UFsGdI3jSVQfvnzkeNx9X7WV
 vFK+OL50Aw1tcYZgUfsfWJ70O1jIP1TYu+WQkJeae3fe29WEtP9H5Dm1l
 zb0nK/nS4LKaDmknnUZOfa/UEWsRXMiyik9Yn/S6FA3xLQe5plFqnLL/u w==;
X-CSE-ConnectionGUID: nWUV2aClQc++VuZ8egRLtw==
X-CSE-MsgGUID: cw8rb+nBRb6WRZBEfnzeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448267"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448267"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:33 -0800
X-CSE-ConnectionGUID: UvSvuhViQz2cLlYXrvlHoA==
X-CSE-MsgGUID: 2gAVdIDNSxyRYKg82obZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613340"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:30 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 04/13] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Thu,  5 Mar 2026 22:43:58 -0500
Message-ID: <20260306034409.184873-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306034409.184873-1-zhenzhong.duan@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

When pasid is enabled, any hwpt attached to non-PASID or PASID should be
IOMMU_HWPT_ALLOC_PASID flagged, or else attachment fails.

Change vtd_destroy_old_fs_hwpt() to pass in 'VTDHostIOMMUDevice *' for
naming consistency.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 45c08c8f6f..c2757f3bcd 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -69,11 +69,13 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
                                Error **errp)
 {
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     struct iommu_hwpt_vtd_s1 vtd = {};
+    uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
 
     vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
                 (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
@@ -82,13 +84,15 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
 
     return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
-                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
-                                      &vtd, fs_hwpt_id, errp);
+                                      flags, IOMMU_HWPT_DATA_VTD_S1,
+                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                     VTDAddressSpace *vtd_as)
 {
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
     if (!vtd_as->fs_hwpt_id) {
         return;
     }
@@ -116,7 +120,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
             return false;
         }
     }
@@ -126,7 +130,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_as->fs_hwpt_id = hwpt_id;
         }
@@ -161,7 +165,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
     }
 
     return ret;
-- 
2.47.3


