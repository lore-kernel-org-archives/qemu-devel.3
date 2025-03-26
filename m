Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E58C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYn-0007tz-Un; Wed, 26 Mar 2025 03:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYm-0007th-6m
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYk-0006GZ-Es
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbSnFxJ5W8RIIcWney/zlJ/GiWz3ThHiX+K+pR/J5go=;
 b=HIGNqSAx67LV4D70M2dp6B4G0USdHZBkDQa2KsVEb8eQQ0uhLXNuyJtbyCUiXvbHe8V32m
 eKTu60kvcf6GLp448RIthrQ5t1Y8NiN+QFq0BxcpyDcVp16o0EO3au9tUfIjTWAVy37kNL
 Od/FrvdpXZmJQ6xEwtEkk1T//Pj1D7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-ameCLK-lPduRN02ecf2bWw-1; Wed,
 26 Mar 2025 03:52:15 -0400
X-MC-Unique: ameCLK-lPduRN02ecf2bWw-1
X-Mimecast-MFC-AGG-ID: ameCLK-lPduRN02ecf2bWw_1742975534
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A9E4180AB16; Wed, 26 Mar 2025 07:52:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9642C19560AD; Wed, 26 Mar 2025 07:52:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH for-10.1 v2 10/37] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Date: Wed, 26 Mar 2025 08:50:55 +0100
Message-ID: <20250326075122.1299361-11-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gather all VFIOIOMMUFD related declarations introduced by commits
5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend") and
5b1e96e65403 ("vfio/iommufd: Introduce auto domain creation") into
"vfio-iommufd.h". This to reduce exposure of VFIO internals in
"hw/vfio/vfio-common.h".

Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-10-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-iommufd.h        | 34 ++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h | 21 +++------------------
 hw/vfio/iommufd.c             |  1 +
 3 files changed, 38 insertions(+), 18 deletions(-)
 create mode 100644 hw/vfio/vfio-iommufd.h

diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
new file mode 100644
index 0000000000000000000000000000000000000000..07ea0f43049645a5f3782048117fd9bf22083053
--- /dev/null
+++ b/hw/vfio/vfio-iommufd.h
@@ -0,0 +1,34 @@
+/*
+ * VFIO iommufd
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_IOMMUFD_H
+#define HW_VFIO_VFIO_IOMMUFD_H
+
+#include "hw/vfio/vfio-container-base.h"
+
+typedef struct VFIODevice VFIODevice;
+
+typedef struct VFIOIOASHwpt {
+    uint32_t hwpt_id;
+    uint32_t hwpt_flags;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOIOASHwpt) next;
+} VFIOIOASHwpt;
+
+typedef struct IOMMUFDBackend IOMMUFDBackend;
+
+typedef struct VFIOIOMMUFDContainer {
+    VFIOContainerBase bcontainer;
+    IOMMUFDBackend *be;
+    uint32_t ioas_id;
+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
+} VFIOIOMMUFDContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
+
+#endif /* HW_VFIO_VFIO_IOMMUFD_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3355c2d4e57569d7bb01b4d9378fb49a807335e8..8d48f5300a791d8858fe29d1bb905f814ef11990 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -69,27 +69,12 @@ typedef struct VFIOContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
 
-typedef struct IOMMUFDBackend IOMMUFDBackend;
-
-typedef struct VFIOIOASHwpt {
-    uint32_t hwpt_id;
-    uint32_t hwpt_flags;
-    QLIST_HEAD(, VFIODevice) device_list;
-    QLIST_ENTRY(VFIOIOASHwpt) next;
-} VFIOIOASHwpt;
-
-typedef struct VFIOIOMMUFDContainer {
-    VFIOContainerBase bcontainer;
-    IOMMUFDBackend *be;
-    uint32_t ioas_id;
-    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
-} VFIOIOMMUFDContainer;
-
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
-
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIOMigration VFIOMigration;
 
+typedef struct IOMMUFDBackend IOMMUFDBackend;
+typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 42c8412bbf50724dddb43f9b19a3aa40c8bc311d..7196c4080125674ec58b1ebf02dad84b4387c355 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "vfio-iommufd.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
-- 
2.49.0


