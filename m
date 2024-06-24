Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEB1C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrBg-0002j6-CQ; Mon, 24 Jun 2024 17:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBe-0002iT-V7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBc-0006Xb-O5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Jnq15/t3RMRO+MlmhjiZee7/Nd/ewGCl8Vn49dNtKc=;
 b=SKNdDbIPIAAkAP01dNv0/F1UQ4Xcqp7YMOmDIVENbrE8YlnmA66uczjeg4K7tMpGCU69kZ
 GVLKDFHhdgtyUGnakOatLSi4+HMT+1Eb7uXBDVBlq5rycGXbcUAvikSw03KX8SMpn4whsW
 E2EOHprm3Sqg18iV79NYLazB0vP1LEA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-YJPoU2C6P5WhPPGKVGeqVA-1; Mon,
 24 Jun 2024 17:25:14 -0400
X-MC-Unique: YJPoU2C6P5WhPPGKVGeqVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9CAF19560B1; Mon, 24 Jun 2024 21:25:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B03001956054; Mon, 24 Jun 2024 21:25:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 04/42] backends/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD[_VFIO] devices
Date: Mon, 24 Jun 2024 23:24:18 +0200
Message-ID: <20240624212456.350919-5-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 +++
 include/sysemu/iommufd.h      | 16 ++++++++++++++++
 backends/iommufd.c            | 35 ++++++++++++++++++-----------------
 hw/vfio/iommufd.c             |  5 ++++-
 4 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 75b167979ac221e59b2681b2704c03778823fbb0..56d171721164991b408073488330bf1d79104970 100644
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
index 293bfbe967215381532b8267227dde61fa9157b7..f6e6d6e1f9f4e9b1c581100912e4864b08c9ed7d 100644
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
index c506afbdac4beddb7dac88f74f10544f7a083e58..012f18d8d802aea40798fe3368bbdca52634f95d 100644
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
index 554f9a6292454f51015ab3a56df3fab6a482ccb7..e4a507d55c4df972fb4c43d31571022910bae493 100644
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
2.45.2


