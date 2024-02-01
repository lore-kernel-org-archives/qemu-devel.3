Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E26C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRX5-0005KJ-Ui; Thu, 01 Feb 2024 02:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWy-0005IY-KD
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:42 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWw-0001bh-8D
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772638; x=1738308638;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CTDEsm16kYgmZEZrIhRTFu5mtzMEIhIQsKe4RoTDPvE=;
 b=npxF3gjRfWw/d0UvzbrjEsMvPWsysYW3xkdZrQKeANjFyfwt3Q+7fwpq
 ++n+nL2F1j5E3OSz1p2bSfqhJFlGgQbKYWdJ+wy4j/4rqIAexWq3N2AUq
 3KtZn0dgQX1/kw6/jRbulSjwvevk+OBN6EYuBmhk6/UzzM5eBrPszfnEy
 f5PXQGgCVPU75BaeU/CpAxtwOsGPcWVVlwsy5fEdbZ0+fu6XJi8Jlq1+w
 PXo/HaAfsFVPHtnow8ECs+SRM0OoryR36qo5GB5vn3J/9fliy29lJga6d
 RYuzxv38vXKgvekS0icRZwG7h7sjoYlr6oPmxdXKdn0lBvOtyyHEUXIyN g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676666"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676666"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443212"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:32 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 04/18] vfio: Add host iommu device instance into
 VFIODevice
Date: Thu,  1 Feb 2024 15:28:04 +0800
Message-Id: <20240201072818.327930-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Either IOMMULegacyDevice or IOMMUFDDevice into VFIODevice, neither
both.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8bfb9cbe94..1bbad003ee 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -132,8 +133,18 @@ typedef struct VFIODevice {
     bool dirty_tracking;
     int devid;
     IOMMUFDBackend *iommufd;
+    union {
+        HostIOMMUDevice base_hdev;
+        IOMMULegacyDevice legacy_dev;
+        IOMMUFDDevice iommufd_dev;
+    };
 } VFIODevice;
 
+QEMU_BUILD_BUG_ON(offsetof(VFIODevice, legacy_dev.base) !=
+                  offsetof(VFIODevice, base_hdev));
+QEMU_BUILD_BUG_ON(offsetof(VFIODevice, iommufd_dev.base) !=
+                  offsetof(VFIODevice, base_hdev));
+
 struct VFIODeviceOps {
     void (*vfio_compute_needs_reset)(VFIODevice *vdev);
     int (*vfio_hot_reset_multi)(VFIODevice *vdev);
-- 
2.34.1


