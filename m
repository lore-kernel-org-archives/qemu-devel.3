Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A723C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW58-0004b9-K7; Fri, 20 Jun 2025 03:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW52-0004a3-Qx
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:34 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW50-0008HF-Lq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404151; x=1781940151;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=72XD2+orGphVnlfDHx8HuqM/mIuRt3K0/KSIIUT9oYU=;
 b=PTjw+eicLVUdZENrvS7akO9/lUcFgerLVDyOR4ZIpGlFPBCSTGmyzpsJ
 zBKnRcBk/gpEMXtvG1X9gIJhnyeJyxyvwl101F2pC10T9kzzPEPiGjM+s
 P0zFZY8JJh1IHnj63dxDYNfehgg62JoGl+9kGMaRGacqqKVx05EmGQfYK
 1uH4mdGo/u+PKELXOwN72mv4nMzCw73WxS8byuEru+X/bu/KrRAjNEIB8
 RCUk1GTJ3JfetJGJ4vL905nzRvB3SNjI2w47128E1svSL/xNS+0Xzscqr
 g12cVI1cuejqW+lk07ZWtw66Zr6RiiYom+yVUn8MXqGdy99i5dOD/7SeF Q==;
X-CSE-ConnectionGUID: toBo3QigSn6AbDoyTJ2aRw==
X-CSE-MsgGUID: GmzJsTnZQym3lDL2bdpudw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532303"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532303"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:28 -0700
X-CSE-ConnectionGUID: sIe+/h4vRi+a7QhIV/4j7g==
X-CSE-MsgGUID: NJCCrAtHRNqld5JTDVTD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863079"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 04/19] vfio/iommufd: Force creating nested parent domain
Date: Fri, 20 Jun 2025 15:17:58 +0800
Message-Id: <20250620071813.55571-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_STAGE1,
if yes, create nested parent domain which could be reused by vIOMMU to create
nested domain.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d3efef71af..83a632bdee 100644
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
@@ -352,6 +353,19 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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
+        if (hw_caps & VIOMMU_CAP_STAGE1) {
+            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+        }
+    }
+
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
-- 
2.34.1


