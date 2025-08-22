Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F026CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTC-0007wl-Vo; Fri, 22 Aug 2025 02:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTA-0007vi-4Y
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:48 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLT6-0000jU-Jm
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844905; x=1787380905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mr67aEYKMDhmS6xMylNnySePBuQpUauAiP6fTNis1Dw=;
 b=GEVrnFEpynrNqJUXbNbsgdsLeBTZoIv/HtQg/lbLJ41DpubCASV42DhM
 FZdr5xfWE5s1Ys8TQp3eBjpqGgjZMAt6S8LS1918pWkqxGJoZ/7l0uITh
 kUFbUxnPzIeykEtHWnzlnnf3+1jITJUKXKrwF2FWl8qSgRcFj5aEnBzDx
 veaLA7mVO5kDJ7xdo/jjghLr1pJmVHCib2pXyWQ7Mr72kxPfdY3buPJU2
 GCscgcRedwDcpnBKCZozC+pN/VdX1UaAmtNR7n+Oj7kdrRny3OpS2drtj
 MtIChbzQXEuVQbk+bmCe2/bx1Im87kpk8w/chULAC0Ap0R2Ysb0+yGXfH g==;
X-CSE-ConnectionGUID: u7N1BJ02QGS7UxQfuCH0EQ==
X-CSE-MsgGUID: QJEHYUEuQjunRlNranHGeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851840"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:43 -0700
X-CSE-ConnectionGUID: AVNMUW7QT1q7yuuktzuGMA==
X-CSE-MsgGUID: Z2N2N0KeTCWNCNkr6hWpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244922"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Date: Fri, 22 Aug 2025 02:40:43 -0400
Message-ID: <20250822064101.123526-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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

Introduce helper vfio_device_viommu_get_nested to facilitate this
implementation.

It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
forbidden and VFIO device fails in set_iommu_device() call, until we support
passthrough device with x-flts=on.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 12 ++++++++++++
 hw/vfio/iommufd.c             |  8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac..ecd82c16c7 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
+bool vfio_device_viommu_get_nested(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 08f12ac31f..3eeb71bd51 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/iommu.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
+                  VIOMMU_CAP_HW_NESTED);
+    }
+    return false;
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..e503c232e1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -379,6 +379,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
+    /*
+     * If vIOMMU supports stage-1 translation, force to create nested parent
+     * domain which could be reused by vIOMMU to create nested domain.
+     */
+    if (vfio_device_viommu_get_nested(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.47.1


