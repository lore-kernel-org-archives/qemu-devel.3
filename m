Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5596ACD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLYzz-0001GJ-J9; Sat, 09 May 2026 00:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLYzs-0001FD-IY
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:02 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLYzp-0000K5-Mu
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299737; x=1809835737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WhVGnhbo+Pqtx83Hy48OkP5Wl8zor8CPU++Q6Tws2aA=;
 b=jdvRbHROOZz28wZbK7CwbBKA3mEZkT9pmcYbTy/5ymOUCN5xom/Qvcqr
 bRFutcsbpStflcr47UazqagnJg++i7u3XwErUf3Ob5fiJ5r5mVurFgPE8
 B8RsuJGVKYFg6iVfCJ+ZKWVAmXYFExtcvUbNYcZ8SSdR68qHyOFTdxVtY
 NFhoBNzJHxvRtdAB70HPAxB81V0q6O2yPGLTlBXq9T+xrv8wf+6U7/DcY
 nWYLwmwyU41p0ORY+BCQav9Xzoz5gnni2epEejPeP3jqrdI/wYtmFwORI
 qvjcfx0Vs6c/Aeh2UBF+UAB33XVAz2S6H98tnaNNWzsJNfKYZoCb37iXs w==;
X-CSE-ConnectionGUID: 9KRsdSKESdKAQSpfTIKFvw==
X-CSE-MsgGUID: I+IpFt8wTHOzfbg89EJeKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654438"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654438"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:08:55 -0700
X-CSE-ConnectionGUID: g6p6uZnYQP6sGT818eUj7A==
X-CSE-MsgGUID: iFp9za7PT0evKe82enOhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966502"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:08:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 04/15] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Sat,  9 May 2026 00:07:57 -0400
Message-ID: <20260509040819.1044702-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


