Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC6C87FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggWv-00058s-Uv; Tue, 29 Jul 2025 05:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWR-0004iS-SI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:24 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWL-0002ac-0l
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780877; x=1785316877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UWpd/VRWPG7FVB4+KQGN73R7irDtEtxt5kp80om8+L0=;
 b=PxrjLN7Va6M5eIfj1VOFhdbwcxb/S0tO3QGfixLGrgM0TdyfjIIGS+Sl
 rlKvnDMtOk71LUB5WR2R1HPSZSxJRLirQptbU4ZxzuI5Yypw7XZy0MYbX
 aua2AqGUg4N8N5qQe+UUJz9cE20gloggDzsaQzcKfevuWvnY0dyVUTMc3
 NOYCDbHEl0IV2ERfuaCGdD+2oYX/M01RtjkS6PONJ/avjWHeqnl+EmNkf
 lgYguffwoPeozLxIbz5n8+62YidGGxA7HyUw4nloAojufX85QqiUWwvvI
 Z0OSZuUlPDZcZqN8hc0xn0+yfulGjowuPwRq6V6MkQgjvNxIymqAJ0Fev w==;
X-CSE-ConnectionGUID: uHCk/aueS7y2KrGIBYzpAA==
X-CSE-MsgGUID: Dh7GtUGdSfKFzgQmjOzQgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981877"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981877"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:16 -0700
X-CSE-ConnectionGUID: f3/AOldyTL2kbSKUUcsjAQ==
X-CSE-MsgGUID: 4SPOzT1kT4CtWmu1o5hmQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691130"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent domain
Date: Tue, 29 Jul 2025 05:20:26 -0400
Message-ID: <20250729092043.785836-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_HW_NESTED,
if yes, create nested parent domain which could be reused by vIOMMU to create
nested domain.

It is safe because hw_caps & VIOMMU_CAP_HW_NESTED cannot be set yet because
s->flts is forbidden until we support passthrough device with x-flts=on.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..61a548f13f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "system/iommufd.h"
+#include "hw/iommu.h"
 #include "hw/qdev-core.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
@@ -379,6 +380,19 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
+    /*
+     * If vIOMMU supports stage-1 translation, force to create nested parent
+     * domain which could be reused by vIOMMU to create nested domain.
+     */
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+
+        hw_caps = pci_device_get_viommu_cap(&vdev->pdev);
+        if (hw_caps & VIOMMU_CAP_HW_NESTED) {
+            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+        }
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.47.1


