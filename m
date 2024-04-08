Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D008CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk9v-00030i-3H; Mon, 08 Apr 2024 04:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9t-0002y7-Ha
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:17 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9r-00089q-Nz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564116; x=1744100116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mThwLA2cpqB/Ub1Co78HjfLcWVvgAn50zoxRT0ghxDo=;
 b=ebPNTtPakWIp6QOjpZHjEnsXFiUQmHnOSqEBlON5mEEO3t4o+aF+1m2O
 7idCUguaw4n6xEGZzBKunvfJZZt4T3lxmSKZTqYAzvY6LwHQNDcCf3666
 PVRRBKk2agzauEZokAVBbQA8KAWAOiuVDsinpP4G+izrGWudq/EOEoTl4
 f5mGbMNIHz5uW10P3eolqWSQewYDkcD1NbQtfXJ5OgoKU9FyS8Atdesc9
 5tRJ577rNvrHRA6wahcPjaUE4InY2lW2aiu/+lWkTAsYyq77Y0uNK3vnG
 o1rfVmWTtH3H3ogfiKKvXuOdjb0WCZrkQbFylYSMJN6CEiFysiOmJm5/G Q==;
X-CSE-ConnectionGUID: WMmEY20hTrykIicrsAK46Q==
X-CSE-MsgGUID: jpPJ00l+T6W/0vnbSeXCVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199680"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199680"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:14 -0700
X-CSE-ConnectionGUID: 8Mh8REmGQ/KKVYHWXwmyqw==
X-CSE-MsgGUID: DogWqoJiTUyyZOH1poh80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845186"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v2 03/10] backends/iommufd: Introduce abstract HIODIOMMUFD
 device
Date: Mon,  8 Apr 2024 16:12:23 +0800
Message-Id: <20240408081230.1030078-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

HIODIOMMUFD represents a host IOMMU device under iommufd backend.

Currently it includes only public iommufd handle and device id.
which could be used to get hw IOMMU information.

When nested translation is supported in future, vIOMMU is going
to have iommufd related operations like attaching/detaching hwpt,
So IOMMUFDDevice interface will be further extended at that time.

VFIO and VDPA device have different way of attaching/detaching hwpt.
So HIODIOMMUFD is still an abstract class which will be inherited by
VFIO and VDPA device.

Introduce a helper hiod_iommufd_init() to initialize HIODIOMMUFD
device.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h | 22 +++++++++++++++++++
 backends/iommufd.c       | 47 ++++++++++++++++++++++++++--------------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6c..71c53cbb45 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -4,6 +4,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
@@ -33,4 +34,25 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+
+#define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
+
+struct HIODIOMMUFD {
+    /*< private >*/
+    HostIOMMUDevice parent;
+    void *opaque;
+
+    /*< public >*/
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+};
+
+struct HIODIOMMUFDClass {
+    /*< private >*/
+    HostIOMMUDeviceClass parent_class;
+};
+
+void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
+                       uint32_t devid);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 62a79fa6b0..ef8b3a808b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -212,23 +212,38 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
-static const TypeInfo iommufd_backend_info = {
-    .name = TYPE_IOMMUFD_BACKEND,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(IOMMUFDBackend),
-    .instance_init = iommufd_backend_init,
-    .instance_finalize = iommufd_backend_finalize,
-    .class_size = sizeof(IOMMUFDBackendClass),
-    .class_init = iommufd_backend_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
+void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
+                       uint32_t devid)
+{
+    idev->iommufd = iommufd;
+    idev->devid = devid;
+}
 
-static void register_types(void)
+static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
 {
-    type_register_static(&iommufd_backend_info);
 }
 
-type_init(register_types);
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_IOMMUFD_BACKEND,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(IOMMUFDBackend),
+        .instance_init = iommufd_backend_init,
+        .instance_finalize = iommufd_backend_finalize,
+        .class_size = sizeof(IOMMUFDBackendClass),
+        .class_init = iommufd_backend_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_USER_CREATABLE },
+            { }
+        }
+    }, {
+        .name = TYPE_HIOD_IOMMUFD,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HIODIOMMUFD),
+        .class_size = sizeof(HIODIOMMUFDClass),
+        .class_init = hiod_iommufd_class_init,
+        .abstract = true,
+    }
+};
+
+DEFINE_TYPES(types)
-- 
2.34.1


