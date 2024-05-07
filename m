Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54076C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H3y-0001jc-B4; Tue, 07 May 2024 05:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2u-0000O6-0o
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:38 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2s-0000Bi-AV
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073814; x=1746609814;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WeswOauUsaVYyqkGscGH7PezcABsM8CfGRKKDlw8bvE=;
 b=cHytTYk9V5XnLjdSAaJUa1ohqhQYQczEHlPH9pR6kD3QgfibR4L8dMgy
 T4VVXJ9KWA1GsfuynF0UE0dkwdexDyF5E3mPQ0WZLjH0gNXciYovWqeUb
 WPYARnTLEW88WF/wF+IApF7deg+zfgyRPu+gWt7Lo4p2/Q7hUp43i7tTQ
 bZ9ynlfYhQ2hw7e1JkZK7D8CZtG9ZAJ6OXJ3h9SoPfyRqBP3f7mJW9Y6a
 tXA0cgG87PoYs/Xmo6Pi1O/Xo0GJ2xw4f0zLv63cQuFJsXvUIVDZT8UmD
 2HtD9QLzTBPANECuNcH5cNei5BwelPz6xYGLIdTuoQSeuNAFDXYIulvIK g==;
X-CSE-ConnectionGUID: pIha95czSe+caslI7IYjog==
X-CSE-MsgGUID: 5Wm/oD+VSyWQChxgrWIRaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785239"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:33 -0700
X-CSE-ConnectionGUID: kNNn6mDMTsSd8SayYAp+uA==
X-CSE-MsgGUID: Ydg2xP4HQMWf6EqtwL/g3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553341"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v4 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Date: Tue,  7 May 2024 17:20:32 +0800
Message-Id: <20240507092043.1172717-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
index f6e6d6e1f9..ee1907c23a 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -17,6 +17,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include <linux/iommufd.h>
 #include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
@@ -47,6 +48,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     enum iommu_hw_info_type *type,
+                                     void *data, uint32_t len, Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 012f18d8d8..06bf20fd05 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -19,7 +19,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
-#include <linux/iommufd.h>
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -208,6 +207,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     enum iommu_hw_info_type *type,
+                                     void *data, uint32_t len, Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = devid,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data,
+    };
+
+    if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+        return false;
+    }
+
+    g_assert(type);
+    *type = info.out_data_type;
+
+    return true;
+}
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
-- 
2.34.1


