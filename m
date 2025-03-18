Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF00C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfQ-0004J8-8m; Tue, 18 Mar 2025 05:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfP-0004Ir-4J
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfN-0002J5-CQ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hm1KIxWcJMLY3EQHGKSrmh14Z3NzBbT4aQJc39/3PU=;
 b=CrF/9woaOLwkTk6eBhxhFowTWjVibDVdj9kZPpCTIXa9i1OtzvzTGlQocreBTHL4wZhFJR
 gEQ2axJoQDM0K29kYNJHhGfi6pUVPSSTng9KnFl/kBzMxAXkn+AeOLpXV84clu7nmmMVI7
 34FeqqxatPJeMyR0M4UnH+DD0KsK6WE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-WoRvhJGRNn29zpxcnBYBGg-1; Tue,
 18 Mar 2025 05:55:16 -0400
X-MC-Unique: WoRvhJGRNn29zpxcnBYBGg-1
X-Mimecast-MFC-AGG-ID: WoRvhJGRNn29zpxcnBYBGg_1742291715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC36180AB19; Tue, 18 Mar 2025 09:55:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25A6A1828A84; Tue, 18 Mar 2025 09:55:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 09/32] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Date: Tue, 18 Mar 2025 10:53:52 +0100
Message-ID: <20250318095415.670319-10-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Gather all VFIOIOMMUFD related declarations into "iommufd.h" to
reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.h             | 29 +++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h | 21 +++------------------
 hw/vfio/iommufd.c             |  1 +
 3 files changed, 33 insertions(+), 18 deletions(-)
 create mode 100644 hw/vfio/iommufd.h

diff --git a/hw/vfio/iommufd.h b/hw/vfio/iommufd.h
new file mode 100644
index 0000000000000000000000000000000000000000..7d87994c4fadbc328b6ac7f9aee00469dd8808b0
--- /dev/null
+++ b/hw/vfio/iommufd.h
@@ -0,0 +1,29 @@
+/*
+ * VFIO iommufd
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_IOMMUFD_H
+#define HW_VFIO_IOMMUFD_H
+
+
+typedef struct VFIOIOASHwpt {
+    uint32_t hwpt_id;
+    uint32_t hwpt_flags;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOIOASHwpt) next;
+} VFIOIOASHwpt;
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
+#endif /* HW_VFIO_IOMMUFD_H */
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
index 2fb2a01ec6d29dbc284cfd9830c24e78ce560dd0..a219b6453037e2d4e0d12800ea25678885af98f8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,7 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "migration.h"
+#include "iommufd.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
-- 
2.48.1


