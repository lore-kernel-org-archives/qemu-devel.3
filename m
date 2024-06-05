Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39899C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5X-0001GS-1n; Wed, 05 Jun 2024 04:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5U-0001Fy-UW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:40 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5T-00062T-5e
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576420; x=1749112420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jdjwlp7+PMBELPvZ01klAKbsOq/SYXrN8XU/EL10k84=;
 b=g8q2n9mERHv7/5SJfYwinhhEZcLhFWCL0O5BBQB3yKsJR8g4cpwBz+5u
 fRqHhbwiqs0m5PnBiDvzm2FRpD5tOIMvqsJgg8N0ZZvwtT4Xi+oveGBJR
 FgBb8aMoj35G2CSPTrRs1hAWS4UkxiI7OLXf8KDz741BJDQj3C2Iedmtx
 snWmzg3XoeOZb3Ak4hwSK5qAGvo/pCae1lwUEA5p9yDRQsLA3fXats3p4
 FvPXhScceerxtNjlm4qT15iJW5degTETwvB0/kZPXEp6ril3/2Ur1122e
 G57G22MdNfqNV9cYFSYlmq8zs9gyl/FSDa7E03GCCxblNGX4UBVKF6hz7 g==;
X-CSE-ConnectionGUID: 2hJeCzHETbCHTwyC7tYiFQ==
X-CSE-MsgGUID: hjJMygGTTo6FdfmNuHofTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575325"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575325"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:30 -0700
X-CSE-ConnectionGUID: 67G8UVJtREKM5w7c0CzYfw==
X-CSE-MsgGUID: AwbL3JsgRMyoNg2XHyal7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954774"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 04/17] backends/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO] devices
Date: Wed,  5 Jun 2024 16:30:30 +0800
Message-Id: <20240605083043.317831-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

TYPE_HOST_IOMMU_DEVICE_IOMMUFD represents a host IOMMU device under
iommufd backend. It is abstract, because it is going to be derived
into VFIO or VDPA type'd device.

It will have its own .get_cap() implementation.

TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO is a sub-class of
TYPE_HOST_IOMMU_DEVICE_IOMMUFD, represents a VFIO type'd host IOMMU
device under iommufd backend. It will be created during VFIO device
attaching and passed to vIOMMU.

It will have its own .realize() implementation.

Opportunistically, add missed header to include/sysemu/iommufd.h.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  3 +++
 include/sysemu/iommufd.h      | 16 ++++++++++++++++
 backends/iommufd.c            | 35 ++++++++++++++++++-----------------
 hw/vfio/iommufd.c             |  5 ++++-
 4 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 75b167979a..56d1717211 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -173,6 +174,8 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 typedef struct VFIODMABuf {
     QemuDmaBuf *buf;
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
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 554f9a6292..e4a507d55c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -624,7 +624,10 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_iommufd_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


