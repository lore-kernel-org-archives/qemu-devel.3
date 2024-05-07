Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA24C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2d-0008Vw-1q; Tue, 07 May 2024 05:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2a-0008Ni-7a
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:16 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2Y-00008K-J4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073794; x=1746609794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HyMVnPMTTEUPdrB/hPu5Ki1bM4XiJMJIG5t/CiWycQo=;
 b=IZcxQFb3pOr1EbmiKSyhJRMK4CqxJM8udfbB1D0HguZrL5Ofuj4QITMx
 N57L+Cym8151I17jgmjcncU9diOx5snNFHQvx/eGVIOruJxjSYvqzkd/k
 bzukjMhy7qUQw3Ggv5Tes15KDtBBvUfw729WSyC6X7mRUPEeZHE4Wdx8G
 b6Vc/rIxXdiQGqciwCPB+kttTF7k6JxBP04JP96YMCMqt8ljqbiHS7Nm7
 lmlbNzwmtR0rdklN7z0NG1+VJaa9O+OV9aJkqHdedQ2ZDakxJ4pdvwm/h
 3+QsLDkERx/Xyoq9WW49MCJ99zptzJzuZXIYJUfKaaZKIEhl0nnjUlnnx A==;
X-CSE-ConnectionGUID: x1g8tC/9RyCmmQRkzKmRPQ==
X-CSE-MsgGUID: U/d7zMnqSACYcvYc4c+79Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785192"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:13 -0700
X-CSE-ConnectionGUID: qR6OjBf3TLuihySds+RiXQ==
X-CSE-MsgGUID: 0rGw4IQASL6k/0LZoM17kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553258"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 03/19] backends/iommufd: Introduce abstract
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD device
Date: Tue,  7 May 2024 17:20:27 +0800
Message-Id: <20240507092043.1172717-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

TYPE_HOST_IOMMU_DEVICE_IOMMUFD represents a host IOMMU device under
iommufd backend.

It will have its own .get_cap() implementation.

Opportunistically, add missed header to include/sysemu/iommufd.h.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h | 16 ++++++++++++++++
 backends/iommufd.c       | 35 ++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 293bfbe967..f6e6d6e1f9 100644
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
@@ -33,4 +47,6 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index c506afbdac..012f18d8d8 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -208,23 +208,24 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
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


