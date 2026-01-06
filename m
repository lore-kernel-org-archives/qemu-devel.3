Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E20CD043D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0LY-0005iv-0l; Tue, 06 Jan 2026 01:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0L6-0004d6-Sp
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:49 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0L3-0007NK-TY
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680082; x=1799216082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uwwMgZDoWs1LOscTwMg6pcryjtTBJBniguJPPb91ufM=;
 b=Y5ldWfT0qBGyzVNACPyNEbK6gXzO3PxKqYZ6ggmJdntc+stpwC4ba5zo
 e1lj1k6Qs79Wmsg6+o1ofmBe6leeOnIQrEdTl4gBVrqe+clLpmn2IyF+W
 VE0zeHHymrZFkZZOQRx2cOQzSEuKWkBbFNPrVy5l3QV/yhPVeP3sqdo+t
 1Va/P1MT96JgABTSXqDRAzIxLgRnmmtOU6KuVzEf9P6wIiOMM/P6caYLo
 d5uXi962et7YqX+5o/H7QgCkp3sfXFJoO/d0/C0stzuQcf67o7ReswlIe
 f/no5q0MC8TdjxSyj+EUOLW6Qt5gWO7VMyAeCICq2b+DW/blv9aguKkHr A==;
X-CSE-ConnectionGUID: TnYN8sJYTA+IV3w6q5NU4Q==
X-CSE-MsgGUID: hrwV3iy5TJ6z34ba0KpXPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094097"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094097"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:37 -0800
X-CSE-ConnectionGUID: HQtMe5EdRf+dOmj3dyseUg==
X-CSE-MsgGUID: xVDuFPqGTLWETy9y6tN4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588947"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:31 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 18/19] intel_iommu: Enable host device when x-flts=on in
 scalable mode
Date: Tue,  6 Jan 2026 01:13:00 -0500
Message-ID: <20260106061304.314546-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

Now that all infrastructures of supporting passthrough device running
with first stage translation are there, enable it now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_accel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 2996e4b640..89f3d55f6f 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -47,9 +47,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
         return false;
     }
 
-    error_setg(errp,
-               "host IOMMU is incompatible with guest first stage translation");
-    return false;
+    return true;
 }
 
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
-- 
2.47.1


