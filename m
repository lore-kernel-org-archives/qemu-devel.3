Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549C1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KtO-0001VG-SE; Mon, 29 Apr 2024 02:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtM-0001Uh-LP
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtK-0007m1-Qy
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373615; x=1745909615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1yPggyMNs61aRBGxOS3kTaEKj6zGxB47DetD9EbElz4=;
 b=m4amPHpUbMrxVVXZT1TB6jx+t7o8cxskjPaevEloP4s38IlVf1+zRE6U
 xON59dZo5A0+LYra4rYVAknDkZ30vWJJP+BO8ikEItlFSz/V6nyUKQUd0
 UoUo3/1kYUPr3UnzG2vulzpTH9aLKAHxOMSicMxle3Q8el33g+a3cqvCO
 fga7zxdgibBMafrb8RvUJp6LXKlxs1a7xUM5wD36xJ38pZ1S4KCMSsJ6d
 4jbRsuqXh5ewN9ZqlIXPrRhBO+gf9O41nTzFSokr6a6d0skUnxbnoglvl
 J7uopwWjTRuhMaUlZv5Nr/Bva6K8u6UZw1aSqtLyAgNJHHFGq1bfnzXjI g==;
X-CSE-ConnectionGUID: 97G6aVXkTK2zLXahBRA6Ow==
X-CSE-MsgGUID: 17KNBeywQPqmKCuOs9udSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560674"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560674"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:34 -0700
X-CSE-ConnectionGUID: dr6nY1xtTI69lbrhnyAVLg==
X-CSE-MsgGUID: dMUuyNrcT0ajtBTgPBRfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63487972"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 03/19] backends/iommufd: Introduce abstract
 HostIOMMUDeviceIOMMUFD device
Date: Mon, 29 Apr 2024 14:50:30 +0800
Message-Id: <20240429065046.3688701-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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

HostIOMMUDeviceIOMMUFD represents a host IOMMU device under iommufd
backend.

Currently it contains public iommufd handle and device id which
will be passed to vIOMMU to allocate/free ioas, hwpt, etc.

When nested translation is supported in future, vIOMMU will
request iommufd related operations like attaching/detaching hwpt.
VFIO and VDPA device have different way of attaching/detaching hwpt.
So HostIOMMUDeviceIOMMUFD is still an abstract class which will be
inherited by VFIO and VDPA device sub-classes.

Opportunistically, add missed header to include/sysemu/iommufd.h.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h | 30 ++++++++++++++++++++++++++++++
 backends/iommufd.c       | 37 ++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6c..6a9fb0007a 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -1,9 +1,23 @@
+/*
+ * iommufd container backend declaration
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ * Copyright Red Hat, Inc. 2024
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *          Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
 #ifndef SYSEMU_IOMMUFD_H
 #define SYSEMU_IOMMUFD_H
 
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
 OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
@@ -33,4 +47,20 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
+                    HOST_IOMMU_DEVICE_IOMMUFD)
+
+/* Abstract of host IOMMU device with iommufd backend */
+struct HostIOMMUDeviceIOMMUFD {
+    HostIOMMUDevice parent_obj;
+
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+};
+
+struct HostIOMMUDeviceIOMMUFDClass {
+    HostIOMMUDeviceClass parent_class;
+};
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 76a0204852..19e46194a2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -211,23 +211,26 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
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
+        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
+        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
+        .abstract = true,
     }
 };
 
-static void register_types(void)
-{
-    type_register_static(&iommufd_backend_info);
-}
-
-type_init(register_types);
+DEFINE_TYPES(types)
-- 
2.34.1


