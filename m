Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62465C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2e-0004hE-S7; Wed, 11 Jun 2025 11:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2b-0004Zl-Fz
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2Z-000784-D6
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Feu0yBBfKVaJzO62UIhvSLbf/yLRlTpVAei5D3Fg23g=;
 b=a/1cn3QhC/Tzt/WgmvP/POxmVD+QVO0yv0OQRYUKUa32+zAhh0ZljyimstZ4R5WIyA4kpy
 6IGLlpe4PTwtEVWmV+s8n7BGejvZNcXD0d9HEK8ODVYIxXYe8tCAXCenSsUgN/Mmo8soy3
 5yGQ48eUC7hrTI4ot70kpu4tCrp25Fs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-KPEltXStPZWKQRW9PB12Ug-1; Wed,
 11 Jun 2025 11:06:56 -0400
X-MC-Unique: KPEltXStPZWKQRW9PB12Ug-1
X-Mimecast-MFC-AGG-ID: KPEltXStPZWKQRW9PB12Ug_1749654415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57DB31956064; Wed, 11 Jun 2025 15:06:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1F5E180045C; Wed, 11 Jun 2025 15:06:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/27] vfio/container: register container for cpr
Date: Wed, 11 Jun 2025 17:06:04 +0200
Message-ID: <20250611150620.701903-13-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

From: Steve Sistare <steven.sistare@oracle.com>

Register a legacy container for cpr-transfer, replacing the generic CPR
register call with a more specific legacy container register call.  Add a
blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  2 +
 include/hw/vfio/vfio-cpr.h       | 15 +++++++
 hw/vfio/container.c              |  7 ++--
 hw/vfio/cpr-legacy.c             | 68 ++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                    |  5 +--
 hw/vfio/meson.build              |  1 +
 6 files changed, 91 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index afc498da49fd4aa7625e47a0749f2c524049296d..21e5807e48e1be69a67fa864a7deddb141cb0cf7 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -10,6 +10,7 @@
 #define HW_VFIO_CONTAINER_H
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-cpr.h"
 
 typedef struct VFIOContainer VFIOContainer;
 typedef struct VFIODevice VFIODevice;
@@ -29,6 +30,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
     QLIST_HEAD(, VFIOGroup) group_list;
+    VFIOContainerCPR cpr;
 } VFIOContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 750ea5bcea38a953c781817f7e76a64422b79d4c..d4e0bd53c98f39a01f1d40fdc8bfe1690166e9c8 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -9,8 +9,23 @@
 #ifndef HW_VFIO_VFIO_CPR_H
 #define HW_VFIO_VFIO_CPR_H
 
+#include "migration/misc.h"
+
+struct VFIOContainer;
 struct VFIOContainerBase;
 
+typedef struct VFIOContainerCPR {
+    Error *blocker;
+} VFIOContainerCPR;
+
+
+bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+                                        Error **errp);
+void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+
+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
+                             Error **errp);
+
 bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0f948d024711062e2facf44b4d4694a0f1e59b83..93cdf80e13df8cc6f7a66a410b5273519af77280 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,7 +33,6 @@
 #include "qapi/error.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
-#include "hw/vfio/vfio-cpr.h"
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
 
@@ -643,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     new_container = true;
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
     }
 
@@ -679,7 +678,7 @@ fail:
         vioc->release(bcontainer);
     }
     if (new_container) {
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         object_unref(container);
     }
     if (fd >= 0) {
@@ -720,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
         VFIOAddressSpace *space = bcontainer->space;
 
         trace_vfio_container_disconnect(container->fd);
-        vfio_cpr_unregister_container(bcontainer);
+        vfio_legacy_cpr_unregister_container(container);
         close(container->fd);
         object_unref(container);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
new file mode 100644
index 0000000000000000000000000000000000000000..dd7ac84074c6fb12fb26e236263bc1a0b865f06e
--- /dev/null
+++ b/hw/vfio/cpr-legacy.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-container.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+
+static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
+{
+    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
+        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
+        return false;
+
+    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
+        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
+        return false;
+
+    } else {
+        return true;
+    }
+}
+
+static const VMStateDescription vfio_container_vmstate = {
+    .name = "vfio-container",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_incoming_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    Error **cpr_blocker = &container->cpr.blocker;
+
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
+
+    if (!vfio_cpr_supported(container, cpr_blocker)) {
+        return migrate_add_blocker_modes(cpr_blocker, errp,
+                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+    }
+
+    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
+
+    return true;
+}
+
+void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+    migrate_del_blocker(&container->cpr.blocker);
+    vmstate_unregister(NULL, &vfio_container_vmstate, container);
+}
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0210e76a10993e0c01403fec51918cc9fca7b636..0e596122284507cb419cceabaf90ca37871cd9f1 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,13 +7,12 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
-#include "migration/misc.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
 
-static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
-                                    MigrationEvent *e, Error **errp)
+int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
+                             MigrationEvent *e, Error **errp)
 {
     if (e->type == MIG_EVENT_PRECOPY_SETUP &&
         !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bccb05098ce18968caaa4d5d8dec3df0852d0398..73d29f925ff5c668518698effc3e48cdf71c3a9a 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
+  'cpr-legacy.c',
   'device.c',
   'migration.c',
   'migration-multifd.c',
-- 
2.49.0


