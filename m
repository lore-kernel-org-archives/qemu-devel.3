Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C68C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc42-0008I9-R6; Fri, 04 Jul 2025 04:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc40-0008EN-Ov
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3y-0000xY-8I
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sT+G8lgaF3ob5cncLc2Lzg1tNO58OGE9EL60ly192Fk=;
 b=VtEqThDrzW1xXZzL2Zibcenw2Vny0SE8HtTlGpEX7C1dgGgkqRCGemLb7ta56BUlkjZMkU
 OI7xLOI+l/8+r4HCZMNHD/siaS5uibOOuNxP8VcMCgV/OG+iFm62SkXsEB9tnL90PxmyQl
 bxTlBDKmK79aB7GdMTUvXEeMVfjqWCE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-_G4d5APuMYi7FoOcoKgzLg-1; Fri,
 04 Jul 2025 04:46:25 -0400
X-MC-Unique: _G4d5APuMYi7FoOcoKgzLg-1
X-Mimecast-MFC-AGG-ID: _G4d5APuMYi7FoOcoKgzLg_1751618784
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E98A180028D; Fri,  4 Jul 2025 08:46:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4107A19560A7; Fri,  4 Jul 2025 08:46:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/27] vfio/iommufd: register container for cpr
Date: Fri,  4 Jul 2025 10:45:19 +0200
Message-ID: <20250704084528.1412959-19-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Register a vfio iommufd container and device for CPR, replacing the generic
CPR register call with a more specific iommufd register call.  Add a
blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.

This is mostly boiler plate.  The fields to to saved and restored are added
in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-13-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h | 12 ++++++
 include/system/iommufd.h   |  1 +
 backends/iommufd.c         | 10 +++++
 hw/vfio/cpr-iommufd.c      | 86 ++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c          |  6 ++-
 hw/vfio/meson.build        |  1 +
 6 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index fa7d43ddd8eccb305751f2311d4ca8248b5052d0..87b4206d8189c1cacd7fac629da5e3823a28c7ae 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -15,7 +15,10 @@
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
+struct VFIODevice;
 struct VFIOPCIDevice;
+struct VFIOIOMMUFDContainer;
+struct IOMMUFDBackend;
 
 typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
                           hwaddr iova, ram_addr_t size, void *vaddr,
@@ -44,6 +47,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
+bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
+                                         Error **errp);
+void vfio_iommufd_cpr_unregister_container(
+    struct VFIOIOMMUFDContainer *container);
+bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
+void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
+void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
+void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
+
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
 bool vfio_cpr_container_match(struct VFIOContainer *container,
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index db5f2c716c5be6cd1313045ab6dd28eb1f8356f3..c9c72ffc4509d7b5d09e8129c5065478aa23aec0 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
     /*< protected >*/
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
+    Error *cpr_blocker;/* set if be does not support CPR */
     uint32_t users;
 
     /*< public >*/
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 87f81a05f6465cabc5673745f95947db2bb4a4fb..c554ce5385dd603ba35f97167ab8031750ecdc2f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
         }
         be->fd = fd;
     }
+    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
+        if (be->owned) {
+            close(be->fd);
+            be->fd = -1;
+        }
+        return false;
+    }
     be->users++;
 
     trace_iommufd_backend_connect(be->fd, be->owned, be->users);
@@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
         be->fd = -1;
     }
 out:
+    if (!be->users) {
+        vfio_iommufd_cpr_unregister_iommufd(be);
+    }
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
new file mode 100644
index 0000000000000000000000000000000000000000..2f58b43793c048188ed61b560dcae1965383f061
--- /dev/null
+++ b/hw/vfio/cpr-iommufd.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright (c) 2024-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
+#include "migration/migration.h"
+#include "migration/vmstate.h"
+#include "system/iommufd.h"
+#include "vfio-iommufd.h"
+
+static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
+{
+    if (!iommufd_change_process_capable(be)) {
+        if (errp) {
+            error_setg(errp, "vfio iommufd backend does not support "
+                       "IOMMU_IOAS_CHANGE_PROCESS");
+        }
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription iommufd_cpr_vmstate = {
+    .name = "iommufd",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = cpr_incoming_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
+{
+    Error **cpr_blocker = &be->cpr_blocker;
+
+    if (!vfio_cpr_supported(be, cpr_blocker)) {
+        return migrate_add_blocker_modes(cpr_blocker, errp,
+                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+    }
+
+    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
+{
+    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
+    migrate_del_blocker(&be->cpr_blocker);
+}
+
+bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
+                                         Error **errp)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
+
+    vfio_cpr_add_kvm_notifier();
+
+    return true;
+}
+
+void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
+}
+
+void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
+{
+}
+
+void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
+{
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 962a1e2b1f28b297cc876fffa2677bd525479c8c..ff291be2356d1a2f59aa6dc7953dc3fc00a627bd 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
-    vfio_cpr_unregister_container(bcontainer);
+    vfio_iommufd_cpr_unregister_container(container);
     vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
@@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
+    if (!vfio_iommufd_cpr_register_container(container, errp)) {
         goto err_listener_register;
     }
 
@@ -623,6 +623,7 @@ found_container:
     }
 
     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
+    vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
@@ -660,6 +661,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
 
+    vfio_iommufd_cpr_unregister_device(vbasedev);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 63ea39307601cce4b0783766f68c4cf8d9af71f9..7a881740a6d8d2d6f4f78024020060f2e11623eb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 ))
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
+  'cpr-iommufd.c',
 ))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
-- 
2.50.0


