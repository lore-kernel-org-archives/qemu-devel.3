Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6409D73097
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Vdi-0001C7-7U; Thu, 02 Apr 2026 23:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdg-0001BP-5P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:08 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vde-0004N9-HK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188566; x=1806724566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WhVGnhbo+Pqtx83Hy48OkP5Wl8zor8CPU++Q6Tws2aA=;
 b=JBVuOFBnleSL/KvoANYAU1Ilw6z51DXZE+z5klDdaGBvUujKYAd1DbJ+
 DzGSJrWIFTZ2yr1uBFMAqKyTvt6Le/6GpgSlVh09nFfqMh+30k6EIrg9a
 /EVPDn5Z4SL7325aQX6W6D3m0b8aH1ACVX8yJzA5Hi2YK0a7lP67jWfxH
 KJJ6zkxC34/o/c9lXMdp1rUs9T8kggu82kG8xTW72HKHsdOrvvaAvCEJW
 ThLy0l/795b3asSTmM7JXKgqo5QmZ6VaUi6xnqVMfCiB3AwzVvqKHVeuw
 2cJnbEylNyiG+D6ATQSbgmnlAZdJlgVfVEB1v/Qa1A1qtEIBJ0yZQMIyq g==;
X-CSE-ConnectionGUID: R2Nqa2C2Rwa2lQXmuUNMNA==
X-CSE-MsgGUID: PJ8VrpDnSdSLmETvJgX+cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140609"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140609"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:05 -0700
X-CSE-ConnectionGUID: sjJeVgYlTcC5k+JuG4N1Aw==
X-CSE-MsgGUID: Gsxqc7fMSpWtsbd7rEXfNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884861"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Thu,  2 Apr 2026 23:55:28 -0400
Message-ID: <20260403035541.18355-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 3217a2afac..bd1236c070 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -69,11 +69,13 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
                                Error **errp)
 {
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     struct iommu_hwpt_vtd_s1 vtd = {};
+    uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
 
     vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
                 (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
@@ -82,13 +84,16 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
     vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
 
     return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
-                                      hiodi->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
-                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
+                                      hiodi->hwpt_id, flags,
+                                      IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
+                                      fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
+static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
                                     VTDAddressSpace *vtd_as)
 {
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
     if (!vtd_as->fs_hwpt_id) {
         return;
     }
@@ -116,7 +121,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(hiodi, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
             return false;
         }
     }
@@ -126,7 +131,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     trace_vtd_device_attach_hwpt(hiodi->devid, IOMMU_NO_PASID, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_as->fs_hwpt_id = hwpt_id;
         }
@@ -161,7 +166,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
+        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
     }
 
     return ret;
-- 
2.47.3


