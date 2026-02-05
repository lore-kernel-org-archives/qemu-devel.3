Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451EAEA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpnH-00055K-Gp; Wed, 04 Feb 2026 22:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnF-00055B-32
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:33 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnD-0001vH-IW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261151; x=1801797151;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7q6WAoAOEzP7uyh56bSheDDVfGGR9aLPFShh1k89EY8=;
 b=dwwofh67Qc3lH9IofahNY1mYM1kQysJPXcdgyZTC4TJnB2xxyI/ecEK5
 131F+QP/KRucbLEPW3ZGcGMfa9F2fd/j2ExnOGtyIbWkWKiu6CVvhKVR+
 Dpummss4w9KBmkOna03xV3tR5FI5f7wwfUNioERrNpIA3d9glgFRMyJ/o
 96ToF1q347A3Y9OdDh3LbFUfh1FT9sZt0u9jodrBPxBGdYyyovlW07ym3
 TGS2+Fqv6BldsSiFS48FrNH+goretXb9tH0h/Qwm2e9F2m5akvP2i9cJb
 LLTh4fcfsk3hbczA8G/piTRWz3i5g7Em0YexowMKlfgfAsHF/BLYGESQ1 Q==;
X-CSE-ConnectionGUID: 2Z2vBastTl+V5okyu+A2vg==
X-CSE-MsgGUID: qFJR4UQZTFKjtY6Stqh7aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910440"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910440"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:31 -0800
X-CSE-ConnectionGUID: utthaBveTzKQiIKUjIztVA==
X-CSE-MsgGUID: CdWs4sk0T2ebUtcznXbuIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209651999"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:27 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Date: Wed,  4 Feb 2026 22:11:22 -0500
Message-ID: <20260205031133.74357-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 67d54849f2..d61cfec1e6 100644
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
@@ -82,8 +84,8 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
 
     return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
-                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
-                                      &vtd, fs_hwpt_id, errp);
+                                      flags, IOMMU_HWPT_DATA_VTD_S1,
+                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
@@ -116,7 +118,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
             return false;
         }
     }
-- 
2.47.3


