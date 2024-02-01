Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670FC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRYE-00075p-Ro; Thu, 01 Feb 2024 02:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRY4-0006kL-Qq
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:50 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXr-0001hD-Ob
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772695; x=1738308695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4UuNU52+wzlDsbtsKgRQzd/clhv4zIKmdvD3x0j7SeU=;
 b=kB4Z1eRUBjkQFRWxhO0LUzRLJ5dWICyd+d325pT6Q20nAIGLKOgYvdSG
 G/NXXOeoiSB7fx5VI84jchp69LtKahcY8n9XzhJb7hSDHcCKKwQ6yRpvw
 WczHERK7Lma11lP2xNps6aSDmgVDMe67PcvEJ5f0eiFRHBkjCAxQLSlqc
 mEdq+B2ebH4XRP6bu9dDzJKcMLwLzjQYFdOXeB8ym5CfSJ3Tv4Zvo5cYO
 kXWarlxntbM6sAVVeYaWqZZah58Jf0OBBii30W8Fa0BEwW20coZgA9HWV
 LxSuKz0xmeNavcX6PyHgBV2t6XgUxlbdtfsu6O63Vw/lO8lEdItqS+pTP Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676925"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676925"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443378"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:29 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH rfcv2 15/18] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Date: Thu,  1 Feb 2024 15:28:15 +0800
Message-Id: <20240201072818.327930-16-zhenzhong.duan@intel.com>
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

Introduce a helper function iommufd_device_get_info() to get
host IOMMU related information through iommufd uAPI.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  4 ++++
 backends/iommufd.c       | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index c3f3469760..ec8b80d8d9 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -4,6 +4,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include <linux/iommufd.h>
 #include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
@@ -47,4 +48,7 @@ typedef struct IOMMUFDDevice {
 } IOMMUFDDevice;
 
 void iommufd_device_init(IOMMUFDDevice *idev);
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index d92791bba9..1b0b991747 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -20,7 +20,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
-#include <linux/iommufd.h>
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -237,3 +236,27 @@ void iommufd_device_init(IOMMUFDDevice *idev)
     host_iommu_base_device_init(&idev->base, HID_IOMMUFD,
                                 sizeof(IOMMUFDDevice));
 }
+
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data, Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .flags = 0,
+        .dev_id = idev->devid,
+        .data_len = len,
+        .__reserved = 0,
+        .data_uptr = (uintptr_t)data,
+    };
+    int ret;
+
+    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+    } else {
+        *type = info.out_data_type;
+    }
+
+    return ret;
+}
-- 
2.34.1


