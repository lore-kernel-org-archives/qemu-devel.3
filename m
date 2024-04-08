Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9D7CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkA6-0003EL-IL; Mon, 08 Apr 2024 04:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA5-0003Bg-1D
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:29 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA2-00089q-Bm
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564126; x=1744100126;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OEWdQXklwv4XAzXDZ24doa8pgMnpGHHQ2cUDfFr+BSg=;
 b=EscL1OsXRbd9lMpiKkbtrEyckacGYt2YgudMJ/h44iljKb4U2E9eGO5t
 iQIdVmpzmBvXuDXqKNHaJDFaPbXqYWPE2HfOe/yP0EfbBBQ7/g2s+p81Q
 bZOIDJmOMTSmY4llx6BAR9dOSLw5o0xJJiX0RE68iox7nRscW4RfdQbAA
 CaVWBwfCBlpLo5ShY6GbBZJaLb/bI5CKIrW04JnqnqEej6NXWNuqkdLFg
 9T0WqEw4HSLQdw6nd4wn5kPZkdyz/Gevyp3pCOg7G7lreie/Pan/prPti
 auuge6vjd7K25EGDJIlknJa+cLSB75MVerLVQoYuDtWHF3JJu9Je7BPQe Q==;
X-CSE-ConnectionGUID: 7/LfREySRqKgr6C9mo1fWw==
X-CSE-MsgGUID: ccJNiClERRWSVYXvrqAduQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199722"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199722"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:26 -0700
X-CSE-ConnectionGUID: j4JXK4wBQImrPHCXFQIKeQ==
X-CSE-MsgGUID: XnhhlLBaQBKl+om8ORecHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845210"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v2 06/10] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Date: Mon,  8 Apr 2024 16:12:26 +0800
Message-Id: <20240408081230.1030078-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Introduce a helper function iommufd_backend_get_device_info() to get
host IOMMU related information through iommufd uAPI.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  4 ++++
 backends/iommufd.c       | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 71c53cbb45..fa1a866237 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -4,6 +4,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include <linux/iommufd.h>
 #include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
@@ -34,6 +35,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                    enum iommu_hw_info_type *type,
+                                    void *data, uint32_t len, Error **errp);
 
 #define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
diff --git a/backends/iommufd.c b/backends/iommufd.c
index ef8b3a808b..559affa9ec 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -20,7 +20,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
-#include <linux/iommufd.h>
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -212,6 +211,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                    enum iommu_hw_info_type *type,
+                                    void *data, uint32_t len, Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = devid,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data,
+    };
+    int ret;
+
+    ret = ioctl(be->fd, IOMMU_GET_HW_INFO, &info);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+    } else {
+        *type = info.out_data_type;
+    }
+
+    return ret;
+}
+
 void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
                        uint32_t devid)
 {
-- 
2.34.1


