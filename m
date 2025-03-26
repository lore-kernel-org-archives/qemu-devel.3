Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C3DC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLZO-0000m9-GU; Wed, 26 Mar 2025 03:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZL-0000X0-IT
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZJ-0006KF-4s
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42xjpOB3qjIU6YWboinIzrzdNR37ElSrZpwuXv64Xno=;
 b=DpZtY0rIxkJKbDhUdAkuYnCA+YD2Zu5kzjtJHC4MPS0xX9VxAPOTeZuB4gxLNWmBfiMgyl
 VjO1QcwTqowE3fxr/5GEtyImU9B73iiN5chmComb0X2CQiBKHeWFJ32fn1wmlOh57xFmGS
 2mI54sAJBPj3bNRhaY/UbOUQ72ab2lQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-dmHndeCHMD-2aYLisfkPEw-1; Wed,
 26 Mar 2025 03:52:54 -0400
X-MC-Unique: dmHndeCHMD-2aYLisfkPEw-1
X-Mimecast-MFC-AGG-ID: dmHndeCHMD-2aYLisfkPEw_1742975573
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81CD118007E1; Wed, 26 Mar 2025 07:52:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81BBA19560AB; Wed, 26 Mar 2025 07:52:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH for-10.1 v2 21/37] vfio: Introduce new files for CPR
 definitions and declarations
Date: Wed, 26 Mar 2025 08:51:06 +0100
Message-ID: <20250326075122.1299361-22-clg@redhat.com>
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

Gather all CPR related declarations into "vfio-cpr.h" to reduce exposure
of VFIO internals in "hw/vfio/vfio-common.h". These were introduced in
commit d9fa4223b30a ("vfio: register container for cpr").

Order file list in meson.build while at it.

Cc: Steve Sistare <steven.sistare@oracle.com>
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
index 0000000000000000000000000000000000000000..9e78b422623683509929f2982f0be465306f4e99
--- /dev/null
+++ b/hw/vfio/vfio-cpr.h
@@ -0,0 +1,15 @@
+/*
+ * VFIO CPR
+ *
+ * Copyright Red Hat, Inc. 2025
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
index 75c48ebf5c21ea93aa8ac4c3aecc63172b633f0e..c587ed08feabd0c4845d824960dd0799e9ace69b 100644
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
index 6e9378434377f4b03176a16157c337ab1286c53e..7436388a73a424b11e6bad9ce80b86c3792242dd 100644
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


