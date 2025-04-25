Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B8C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eiw-0002uT-Oe; Fri, 25 Apr 2025 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eiv-0002uC-Id
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eit-0003FH-5Q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPnHVBcgsWTqT+InYSFw9LQgKVoq4/hzYKs3O4CxH8I=;
 b=Nf6cJ5F5PMn/hthlEnU2JvFUxlY47k2IgxJ/j2AaUo8OSAFkr8twDN9wwhT+ZhxozhEbt9
 tXzrCyIQ3oIjYoTgHnzhu0scLqKUByDCBEsxdeuMBuf4iP322eJNZbL9vgaiFU4m1H1mCZ
 DHSTTwPw4n/A7QNjB9dfusXb5GshSNY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-Q6kfkM_5P9u4RVOMmh4-vg-1; Fri,
 25 Apr 2025 04:47:47 -0400
X-MC-Unique: Q6kfkM_5P9u4RVOMmh4-vg-1
X-Mimecast-MFC-AGG-ID: Q6kfkM_5P9u4RVOMmh4-vg_1745570867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08FBF1800264; Fri, 25 Apr 2025 08:47:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C2A530001A2; Fri, 25 Apr 2025 08:47:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 16/50] vfio: Introduce a new header file for VFIOcontainer
 declarations
Date: Fri, 25 Apr 2025 10:46:09 +0200
Message-ID: <20250425084644.102196-17-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Gather all VFIOcontainer related declarations into
"hw/vfio/vfio-container.h" to reduce exposure of VFIO internals in
"hw/vfio/vfio-common.h". These declarations were initially introduced
in commit 65501a745dba ("vfio: vfio-pci device assignment driver").
They are made available externally for PPC and s390x.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-12-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-13-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h    | 19 -----------------
 include/hw/vfio/vfio-container.h | 36 ++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c          |  1 +
 hw/s390x/s390-pci-vfio.c         |  2 +-
 hw/vfio/container.c              |  1 +
 hw/vfio/spapr.c                  |  1 +
 6 files changed, 40 insertions(+), 20 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b37203374178045f2b534bf6d8990f9dbea1fca7..bcdbc9de57dd11c2c93252b983ec4e4190a82fe5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -39,16 +39,6 @@ enum {
     VFIO_DEVICE_TYPE_CCW = 2,
     VFIO_DEVICE_TYPE_AP = 3,
 };
-struct VFIOGroup;
-
-typedef struct VFIOContainer {
-    VFIOContainerBase bcontainer;
-    int fd; /* /dev/vfio/vfio, empowered by the attached groups */
-    unsigned iommu_type;
-    QLIST_HEAD(, VFIOGroup) group_list;
-} VFIOContainer;
-
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
 
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIOMigration VFIOMigration;
@@ -125,15 +115,6 @@ struct VFIODeviceOps {
     int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
-typedef struct VFIOGroup {
-    int fd;
-    int groupid;
-    VFIOContainer *container;
-    QLIST_HEAD(, VFIODevice) device_list;
-    QLIST_ENTRY(VFIOGroup) next;
-    QLIST_ENTRY(VFIOGroup) container_next;
-    bool ram_block_discard_allowed;
-} VFIOGroup;
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
new file mode 100644
index 0000000000000000000000000000000000000000..afc498da49fd4aa7625e47a0749f2c524049296d
--- /dev/null
+++ b/include/hw/vfio/vfio-container.h
@@ -0,0 +1,36 @@
+/*
+ * VFIO container
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_CONTAINER_H
+#define HW_VFIO_CONTAINER_H
+
+#include "hw/vfio/vfio-container-base.h"
+
+typedef struct VFIOContainer VFIOContainer;
+typedef struct VFIODevice VFIODevice;
+
+typedef struct VFIOGroup {
+    int fd;
+    int groupid;
+    VFIOContainer *container;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOGroup) next;
+    QLIST_ENTRY(VFIOGroup) container_next;
+    bool ram_block_discard_allowed;
+} VFIOGroup;
+
+typedef struct VFIOContainer {
+    VFIOContainerBase bcontainer;
+    int fd; /* /dev/vfio/vfio, empowered by the attached groups */
+    unsigned iommu_type;
+    QLIST_HEAD(, VFIOGroup) group_list;
+} VFIOContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
+
+#endif /* HW_VFIO_CONTAINER_H */
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 76b2a3487b5d6f21528e9c301341eb27bc8fec1d..1722a5bfa3983d42baac558f22410e36eed375f5 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-container.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index db152a625253a0f4047353000ff3bafca1f09938..748a51fd8cc478604340b7c812e0da356836b807 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-container.h"
 
 /*
  * Get the current DMA available count from vfio.  Returns true if vfio is
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 812d5edbcf911911fa896ba3603b91a817ffec6b..bda1942662d1da24c3a47db0f4a389a2a0fbec7e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "pci.h"
+#include "hw/vfio/vfio-container.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index f21955a3442b956bdcb2964b0042a12e2ac8a03d..31e4dddc9e2707b18ebaf3e744d85009e635f172 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,6 +16,7 @@
 #include "system/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/hw.h"
 #include "system/ram_addr.h"
 #include "qemu/error-report.h"
-- 
2.49.0


