Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF67C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB9A-0007VV-JV; Tue, 27 Feb 2024 23:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB99-0007Gs-CQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:02:19 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB95-000117-Lc
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092936; x=1740628936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tgFCwv/7Yk27/h7/Nc9J58CONVxBSdPJewlTX/Yvjno=;
 b=VNRsSnZJnEEzgqF7iSobDmL4Adz6OTMh5yeKXV5qgD2VpAmepb06LRyH
 Q+HJtUmeBLjGvZfnHmG8xQy6q3O5Slqj2sn62G2LnCg/n9bo9m1puBGsg
 WvYdd3F1eZuAzdHoY31lNvml+R81K7ArUNxkz6c92lCREHJB/tEM607Ja
 Ua72hJSnbocniuwec/OCzN+tXCwwW5vHFps2ckv0Z9R19TMUAivBEnqOm
 gStRntY2ulKjfqwwkXEy3eQ4m8iWiDpGUo2PuBo8wUBaPaxbWtizZBQuP
 AwljU4WEK2wowMrebsahmhPIMg+VAobvyr+Cx5jU35K0NEMr8pTXU3Von Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342531"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342531"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917386"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:51 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Date: Wed, 28 Feb 2024 11:59:00 +0800
Message-Id: <20240228035900.1085727-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 backends/iommufd.c       | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index d509ff88ef..518b97bfed 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -4,6 +4,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include <linux/iommufd.h>
 #include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
@@ -48,4 +49,7 @@ typedef struct IOMMUFDDevice {
 
 void iommufd_device_init(IOMMUFDDevice *idev,
                          IOMMUFDBackend *iommufd, int devid);
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data, Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 6d280e4aea..69f3f75ea5 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -20,7 +20,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
-#include <linux/iommufd.h>
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -240,3 +239,25 @@ void iommufd_device_init(IOMMUFDDevice *idev,
     idev->iommufd = iommufd;
     idev->devid = devid;
 }
+
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data, Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = idev->devid,
+        .data_len = len,
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


