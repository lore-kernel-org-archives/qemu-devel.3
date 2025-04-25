Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eit-0002tP-Lv; Fri, 25 Apr 2025 04:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Eiq-0002sG-MZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ein-0003Ea-2y
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZSS12jJn3Ab8jgyon0Rq7AsqZv904HgNZr+YuZoE5Q=;
 b=S+o26oePHvc9zkO0KXrQHaSeXKzPe7tVTxQJ4xF/VgoEqxrgH69wGG8IeIYSta6rdmcVUF
 rMMPJwZRpJoy/3E2v+78fB5OTG4KXllb2sn151333sspgqNkYXmTTyUMdI69dNbX7L3Pij
 F4eLt6N4bXDbDg3g8uzYp78jQPOfn9U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-2g8EwTomMpC3CG5La_52vw-1; Fri,
 25 Apr 2025 04:47:41 -0400
X-MC-Unique: 2g8EwTomMpC3CG5La_52vw-1
X-Mimecast-MFC-AGG-ID: 2g8EwTomMpC3CG5La_52vw_1745570860
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E09F01956095; Fri, 25 Apr 2025 08:47:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CD8A30001AB; Fri, 25 Apr 2025 08:47:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Yi Liu <yi.l.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 14/50] vfio: Introduce a new header file for VFIOIOMMUFD
 declarations
Date: Fri, 25 Apr 2025 10:46:07 +0200
Message-ID: <20250425084644.102196-15-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Gather all VFIOIOMMUFD related declarations introduced by commits
5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend") and
5b1e96e65403 ("vfio/iommufd: Introduce auto domain creation") into
"vfio-iommufd.h". This to reduce exposure of VFIO internals in
"hw/vfio/vfio-common.h".

Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-10-clg@redhat.com
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-11-clg@redhat.com
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
index 83b1f7be805998c00f02d5b264a4171b51c1d55c..9ec90fbac007f39d222cc42c25cca96be4e4421b 100644
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


