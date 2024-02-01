Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E3C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRWv-0005Em-Qh; Thu, 01 Feb 2024 02:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWp-0005Cx-BB
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:31 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWl-0001R8-L8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772627; x=1738308627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sAIPXTm87HB/uGpJ/9YNiXxwn8eta5zQASgPvOQiYZs=;
 b=RuV8fY7LGwZtXStYP9Cg2KK8VUo5C9WUs/pamSJP/pc2+2ntMyOzfxrI
 kjWk+lkWkOSBDbs5gr5corHnztTb88blaudnkFWRW/Yo5tGJMhn3CfHD9
 dc9hnIE5Bh4ez+EpzKBk/GlzWosrBzspkPdVX3nR1Ae5pr4RQYFZfGuk7
 Hxos8dilViyB2Rgth5T7+AkLhfmd5p/yN7nEG2iLgwquigwx+soHpn5If
 gX7tmwWTOYWdcrnrsfZFdMFsz3kKNkl4BnQpPa7TcpVROrcL0dm1+QhNy
 Vu0KqQAiOJZtQuRTqB3ysOUX9weHfcAPs+aKvBQteQiwymAfvV9o2/9qy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676638"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443168"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH rfcv2 02/18] backends/iommufd: Introduce IOMMUFDDevice
Date: Thu,  1 Feb 2024 15:28:02 +0800
Message-Id: <20240201072818.327930-3-zhenzhong.duan@intel.com>
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

IOMMUFDDevice represents a device in iommufd and can be used as
a communication interface between devices (i.e., VFIO, VDPA) and
vIOMMU.

Currently it includes only public iommufd handle and device id
which could be used by vIOMMU to get hw IOMMU information.

There will also be some elements in private field in future,
i.e., capability bits for dirty tracking; when nested translation
is supported in future, vIOMMU is going to have more iommufd related
operations like allocate hwpt for a device, attach/detach hwpt, etc.
So IOMMUFDDevice will be further extended with those needs.

IOMMUFDDevice is willingly not a QOM object because we don't want
it to be visible from the user interface.

Introduce a helper iommufd_device_init to initialize IOMMUFDDevice.

Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h | 14 ++++++++++++++
 backends/iommufd.c       |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6c..c3f3469760 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -4,6 +4,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
@@ -33,4 +34,17 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+
+
+/* Abstraction of host IOMMUFD device */
+typedef struct IOMMUFDDevice {
+    HostIOMMUDevice base;
+    /* private: */
+
+    /* public: */
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+} IOMMUFDDevice;
+
+void iommufd_device_init(IOMMUFDDevice *idev);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 1ef683c7b0..d92791bba9 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -231,3 +231,9 @@ static void register_types(void)
 }
 
 type_init(register_types);
+
+void iommufd_device_init(IOMMUFDDevice *idev)
+{
+    host_iommu_base_device_init(&idev->base, HID_IOMMUFD,
+                                sizeof(IOMMUFDDevice));
+}
-- 
2.34.1


