Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22902C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejd-00044N-Q3; Fri, 25 Apr 2025 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjM-0003W6-98
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjK-0003HV-8H
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJvgmNFEoYpPlarzHxNwwFp3mPzZ439qDYCDrXnxmVg=;
 b=iNl+eaCNh4bqzI1fZtNRmWwVGw0owEVfV/6AJs+n7qdIxFCO3dImoVS9GEbexXfeo9oYqL
 gfjN2k+rmCoCO1PGrDPA2QeSY5ZMJv5h/Wq0YDoemDSOqyUVAsooJ6gj/1cHlASHYtyAXA
 rNiYzGfZHbLai646pbwnaHsH/23QrRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-PVfAltzcPsmolGv-00RHpA-1; Fri,
 25 Apr 2025 04:48:14 -0400
X-MC-Unique: PVfAltzcPsmolGv-00RHpA-1
X-Mimecast-MFC-AGG-ID: PVfAltzcPsmolGv-00RHpA_1745570893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F9F4180036E; Fri, 25 Apr 2025 08:48:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8121830001A2; Fri, 25 Apr 2025 08:48:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 25/50] vfio: Introduce new files for CPR definitions and
 declarations
Date: Fri, 25 Apr 2025 10:46:18 +0200
Message-ID: <20250425084644.102196-26-clg@redhat.com>
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

Gather all CPR related declarations into "vfio-cpr.h" to reduce exposure
of VFIO internals in "hw/vfio/vfio-common.h". These were introduced in
commit d9fa4223b30a ("vfio: register container for cpr").

Order file list in meson.build while at it.

Cc: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-22-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-cpr.h            | 15 +++++++++++++++
 include/hw/vfio/vfio-common.h |  3 ---
 hw/vfio/container.c           |  1 +
 hw/vfio/cpr.c                 |  1 +
 hw/vfio/iommufd.c             |  1 +
 hw/vfio/meson.build           |  2 +-
 6 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 hw/vfio/vfio-cpr.h

diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
new file mode 100644
index 0000000000000000000000000000000000000000..134b83a62461cbe9409bbe42057fb4134d84dcd1
--- /dev/null
+++ b/hw/vfio/vfio-cpr.h
@@ -0,0 +1,15 @@
+/*
+ * VFIO CPR
+ *
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_CPR_H
+#define HW_VFIO_CPR_H
+
+bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
+void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
+
+#endif /* HW_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index dca7a6a4b3dcc583eb430b8cf9380a007623ec26..2065c2f9e409b27a4c8f7e0d0d3340c6636c5fa2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -129,9 +129,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
-
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3fdd5dac379bd43fdd8f606e02029c1f44bdb69a..c55fe8e4bede9d7e228af2472242efb48bc7d037 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,6 +34,7 @@
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 #include "vfio-helpers.h"
+#include "vfio-cpr.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3d1c8d290a5e6b6d67e244931a9ef8c194a0b574..696987006b853227e76caedb3c7f4e4be31cfa06 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -10,6 +10,7 @@
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
+#include "vfio-cpr.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 85b5a8146ac401af6be8109c28ea4c7a39e84521..a5bd189a86d70bd11ecb80384ac145a51979322b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -27,6 +27,7 @@
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
+#include "vfio-cpr.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 60caa366175edee6bc69c0febebaef84e752e346..1f89bd28c13dea55bcfff476ce99d51b453d8533 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,10 +20,10 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'container-base.c',
+  'cpr.c',
   'device.c',
   'migration.c',
   'migration-multifd.c',
-  'cpr.c',
   'region.c',
 ))
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
-- 
2.49.0


