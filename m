Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027EAC3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYx-00087g-2w; Wed, 26 Mar 2025 03:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYv-000873-02
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYt-0006Ho-10
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Krb75TsMnwRAiI2Hx9sPpV3hjqk6Gh4IPAQF3HKAFB0=;
 b=RTb7Gd7iN9ywntPZsLcJl343YDjbsFkLZGnq/O8gL44pbx4a0/cC8WRcEjWHvwAYt2LFJb
 LVSJuZOe586sdU5w15G+AclWNrIH2rg/Xgr0vFEm6KYgE+7tPg7Z4dYP0d2s1J3Dj7VPZE
 SJqHnTKMicaGsjYXsG+MxaG0+l7LWYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-WdMAL48iN6WJbbRKsYLyXA-1; Wed,
 26 Mar 2025 03:52:23 -0400
X-MC-Unique: WdMAL48iN6WJbbRKsYLyXA-1
X-Mimecast-MFC-AGG-ID: WdMAL48iN6WJbbRKsYLyXA_1742975541
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBAA518007E1; Wed, 26 Mar 2025 07:52:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05CE619560AB; Wed, 26 Mar 2025 07:52:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 12/37] vfio: Introduce a new header file for
 VFIOcontainer declarations
Date: Wed, 26 Mar 2025 08:50:57 +0100
Message-ID: <20250326075122.1299361-13-clg@redhat.com>
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

Gather all VFIOcontainer related declarations into
"hw/vfio/vfio-container.h" to reduce exposure of VFIO internals in
"hw/vfio/vfio-common.h". These declarations were initially introduced
in commit 65501a745dba ("vfio: vfio-pci device assignment driver").
They are made available externally for PPC and s390x.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-12-clg@redhat.com
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
index 3d470d79325526e0508683c445a7635c78a57e34..aebce091088f5027c31c7782a1683e763bd766ec 100644
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
index 6236ac7f1e686c9774ade172bf57a1e526b59939..88d4c5b3ecc617c5b93ca53cba0850666db3a67b 100644
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
index 7c57bdd27b72731db5cf4f9446d954e143b4747e..75b5ebf4716c55d8c32a845c875981cef8fb5610 100644
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
index 021cdedbfa483f0599ad3c858a77fc6570f1ace8..4adfd50967313d1a5c3c4033a57c37eeb3a779a7 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,6 +16,7 @@
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
-- 
2.49.0


