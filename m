Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65A2FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbd-0005lF-KL; Thu, 30 Apr 2026 03:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILbb-0005h2-Ni
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:39 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILba-0008U6-1F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533278; x=1809069278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OJH0uQm/PUg87n8wiYnQPTuuOuM6744iYfEDVw7jb0w=;
 b=HG+KaIYflaAJPkDmj4qIxUl0e70XPvH94GOHMeDFce49qZHfPC3DdOlF
 eii+RP/ELXZs8KdvJ2Iy5OaMs7H2ABotQS4vnxhe5MNkVpwVIJsjFRX5a
 T4htnm9Qg2ujwxM2ZnK6cmYi43+sYNXNoJfK27Ks2dZwtE43hj1E39aRk
 jtB4pSYSo/NNKT7bZmWg6zTy7tT2jCHq+24NndFElkEpQcah+GNsCJAq/
 eb9iV3MlPVaF+8FqRRvd3O8NxFO2hErQbPf3EEcbbz5nf8ueegoMp/1wi
 4ILz8RavuAAbmXorkQx2/AcMh7RDaGCTBs3EfU+sJ8VDhCtbGraOU45gO Q==;
X-CSE-ConnectionGUID: sJlvydVGSh+jyoExm6IpWg==
X-CSE-MsgGUID: 1xDKDz+LQHWllixnCiMpXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051694"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051694"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:14:27 -0700
X-CSE-ConnectionGUID: 0UECyR4sT5WbfWLRxxQkWg==
X-CSE-MsgGUID: C62WOBlsT6a6G61OMUXHhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771613"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:14:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 15/15] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 and VIOMMU_FLAG_WANT_PASID_ATTACH
Date: Thu, 30 Apr 2026 03:13:11 -0400
Message-ID: <20260430071315.354333-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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

VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
capability, also check VIOMMU_FLAG_WANT_PASID_ATTACH to enable pasid
attachment, without those guest could not enable PASID of this device even
if vIOMMU's pasid is configured.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d6eb3ac94b..8a5d5e4b66 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4827,6 +4827,10 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
                 VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
     }
 
+    if (s->pasid) {
+        flags |= VIOMMU_FLAG_PASID_SUPPORTED | VIOMMU_FLAG_WANT_PASID_ATTACH;
+    }
+
     return flags;
 }
 
-- 
2.47.3


