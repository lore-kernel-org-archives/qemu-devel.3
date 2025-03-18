Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F88C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgE-0005Sp-Lq; Tue, 18 Mar 2025 05:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfq-0004q3-O2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfo-0002Mm-NA
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8uOj8/yhRe7nxWa70tkPJbZNLTxdCFpV3a9rIrOXjE=;
 b=d55+KJLErrXLkdp+Kw+A8POhewOwkaL+E6b8Q4h3GXMFcwZ1NyfH0Zl4YIt6ef+E/RPIeq
 tiUiHui5ldY3IueXIrtBDLwwYdAyt9mn1R/b80TFP9HgNcTixyAMxOAIV0yoC2uE2za7rl
 +JlamHwPemkSganA0SGQAdX0E7J8mJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-F0S4p11NMDm6huBQ56v6ww-1; Tue,
 18 Mar 2025 05:55:46 -0400
X-MC-Unique: F0S4p11NMDm6huBQ56v6ww-1
X-Mimecast-MFC-AGG-ID: F0S4p11NMDm6huBQ56v6ww_1742291745
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C22A419560B6; Tue, 18 Mar 2025 09:55:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24B118001EF; Tue, 18 Mar 2025 09:55:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 20/32] vfio: Introduce new files for CPR definitions
 and declarations
Date: Tue, 18 Mar 2025 10:54:03 +0100
Message-ID: <20250318095415.670319-21-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

Gather all CPR related declarations into "cpr.h" to reduce exposure
of VFIO internals in "hw/vfio/vfio-common.h".

Order file list in meson.build while at it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr.h                 | 15 +++++++++++++++
 include/hw/vfio/vfio-common.h |  3 ---
 hw/vfio/container.c           |  1 +
 hw/vfio/cpr.c                 |  1 +
 hw/vfio/iommufd.c             |  1 +
 hw/vfio/meson.build           |  2 +-
 6 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 hw/vfio/cpr.h

diff --git a/hw/vfio/cpr.h b/hw/vfio/cpr.h
new file mode 100644
index 0000000000000000000000000000000000000000..88a5e7f878a3e01df3410f6f0a9c8b5ccddefe28
--- /dev/null
+++ b/hw/vfio/cpr.h
@@ -0,0 +1,15 @@
+/*
+ * VFIO display
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
index 848412ea53ccd903313855fd30490d897c8681c0..7f1df4fc0c545ceb117ad6c090bd3f701456a70c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -128,9 +128,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
-
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e1b06e71c47ab8d24e7da878f801020b22936430..4e41a7476549a0c5e464e499d059db5aca6e3470 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,6 +34,7 @@
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 #include "helpers.h"
+#include "cpr.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3d1c8d290a5e6b6d67e244931a9ef8c194a0b574..e1bba1726402f41ee394f25b6e613d27f44b2a2c 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -10,6 +10,7 @@
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
+#include "cpr.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bc586e02803af984d1801159eb427d3415e373ab..b25f3b4086d7b7fc6fcd519a9b8b2904513a655f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -28,6 +28,7 @@
 #include "migration.h"
 #include "iommufd.h"
 #include "helpers.h"
+#include "cpr.h"
 
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
2.48.1


