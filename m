Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0839C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2k-00053b-FJ; Wed, 11 Jun 2025 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2i-0004sb-BC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2f-00078q-P3
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krTSwMcwgTojtoWqP6DWRFs5VyrJ3ZJrofXJEj1Rfkw=;
 b=bKrgKExbg0x/mp0TN5b5myPO4Ym9Kq/m6unl1+dUsY4xOQXJZaOl5AKraV7q9OuNCC1ctN
 RSCBWaexmplilt8qjvnOamwnz09frvvILuNcIr3HeFn9U+L8Xwq+oZ1oXbVSLjwrB4xupd
 pgGMefn+yhMIBEiTwtiXRyGCQZbKbms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-vrMyL2tdPNWwOjrcqMsDCg-1; Wed,
 11 Jun 2025 11:06:59 -0400
X-MC-Unique: vrMyL2tdPNWwOjrcqMsDCg-1
X-Mimecast-MFC-AGG-ID: vrMyL2tdPNWwOjrcqMsDCg_1749654418
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39956195608B; Wed, 11 Jun 2025 15:06:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D228D180045C; Wed, 11 Jun 2025 15:06:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 13/27] vfio/container: preserve descriptors
Date: Wed, 11 Jun 2025 17:06:05 +0200
Message-ID: <20250611150620.701903-14-clg@redhat.com>
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

At vfio creation time, save the value of vfio container, group, and device
descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
the saved descriptors.

During reuse, device and iommu state is already configured, so operations
in vfio_realize that would modify the configuration, such as vfio ioctl's,
are skipped.  The result is that vfio_realize constructs qemu data
structures that reflect the current state of the device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-5-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  6 ++++
 hw/vfio/container.c        | 67 +++++++++++++++++++++++++++++---------
 hw/vfio/cpr-legacy.c       | 42 ++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d4e0bd53c98f39a01f1d40fdc8bfe1690166e9c8..5a2e5f6b21e690cf91fd731ff9aa21a569f92f61 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -13,6 +13,7 @@
 
 struct VFIOContainer;
 struct VFIOContainerBase;
+struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
@@ -30,4 +31,9 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
+int vfio_cpr_group_get_device_fd(int d, const char *name);
+
+bool vfio_cpr_container_match(struct VFIOContainer *container,
+                              struct VFIOGroup *group, int fd);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 93cdf80e13df8cc6f7a66a410b5273519af77280..5caae4ccae59bf114f37a49019c40bb125ed4ba1 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -31,6 +31,8 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/blocker.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 #include "vfio-helpers.h"
@@ -425,7 +427,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
         return NULL;
     }
 
-    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
+    /*
+     * During CPR, just set the container type and skip the ioctls, as the
+     * container and group are already configured in the kernel.
+     */
+    if (!cpr_is_incoming() &&
+        !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
         return NULL;
     }
 
@@ -592,6 +599,11 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
     vfio_group_add_kvm_device(group);
+    /*
+     * Remember the container fd for each group, so we can attach to the same
+     * container after CPR.
+     */
+    cpr_resave_fd("vfio_container_for_group", group->groupid, container->fd);
     return true;
 }
 
@@ -601,6 +613,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
     group->container = NULL;
     vfio_group_del_kvm_device(group);
     vfio_ram_block_discard_disable(container, false);
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 }
 
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
@@ -615,17 +628,34 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     bool group_was_added = false;
 
     space = vfio_address_space_get(as);
+    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
 
-    QLIST_FOREACH(bcontainer, &space->containers, next) {
-        container = container_of(bcontainer, VFIOContainer, bcontainer);
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            return vfio_container_group_add(container, group, errp);
+    if (!cpr_is_incoming()) {
+        QLIST_FOREACH(bcontainer, &space->containers, next) {
+            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+                return vfio_container_group_add(container, group, errp);
+            }
         }
-    }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
-    if (fd < 0) {
-        goto fail;
+        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
+        if (fd < 0) {
+            goto fail;
+        }
+    } else {
+        /*
+         * For incoming CPR, the group is already attached in the kernel.
+         * If a container with matching fd is found, then update the
+         * userland group list and return.  If not, then after the loop,
+         * create the container struct and group list.
+         */
+        QLIST_FOREACH(bcontainer, &space->containers, next) {
+            container = container_of(bcontainer, VFIOContainer, bcontainer);
+
+            if (vfio_cpr_container_match(container, group, fd)) {
+                return vfio_container_group_add(container, group, errp);
+            }
+        }
     }
 
     ret = ioctl(fd, VFIO_GET_API_VERSION);
@@ -697,6 +727,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 
     /*
      * Explicitly release the listener first before unset container,
@@ -750,7 +781,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR, errp);
+    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, errp);
     if (group->fd < 0) {
         goto free_group_exit;
     }
@@ -782,6 +813,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     return group;
 
 close_fd_exit:
+    cpr_delete_fd("vfio_group", groupid);
     close(group->fd);
 
 free_group_exit:
@@ -803,6 +835,7 @@ static void vfio_group_put(VFIOGroup *group)
     vfio_container_disconnect(group);
     QLIST_REMOVE(group, next);
     trace_vfio_group_put(group->fd);
+    cpr_delete_fd("vfio_group", group->groupid);
     close(group->fd);
     g_free(group);
 }
@@ -813,7 +846,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    fd = vfio_cpr_group_get_device_fd(group->fd, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -826,8 +859,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     info = vfio_get_device_info(fd);
     if (!info) {
         error_setg_errno(errp, errno, "error getting device info");
-        close(fd);
-        return false;
+        goto fail;
     }
 
     /*
@@ -841,8 +873,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         if (!QLIST_EMPTY(&group->device_list)) {
             error_setg(errp, "Inconsistent setting of support for discarding "
                        "RAM (e.g., balloon) within group");
-            close(fd);
-            return false;
+            goto fail;
         }
 
         if (!group->ram_block_discard_allowed) {
@@ -860,6 +891,11 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
     return true;
+
+fail:
+    close(fd);
+    cpr_delete_fd(name, 0);
+    return false;
 }
 
 static void vfio_device_put(VFIODevice *vbasedev)
@@ -870,6 +906,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_device_put(vbasedev->fd);
+    cpr_delete_fd(vbasedev->name, 0);
     close(vbasedev->fd);
 }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index dd7ac84074c6fb12fb26e236263bc1a0b865f06e..ac4a9ab315eab515607fb2405032ddc1ab980cf0 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -8,6 +8,7 @@
 #include <linux/vfio.h>
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
@@ -66,3 +67,44 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
 }
+
+int vfio_cpr_group_get_device_fd(int d, const char *name)
+{
+    const int id = 0;
+    int fd = cpr_find_fd(name, id);
+
+    if (fd < 0) {
+        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
+        if (fd >= 0) {
+            cpr_save_fd(name, id, fd);
+        }
+    }
+    return fd;
+}
+
+static bool same_device(int fd1, int fd2)
+{
+    struct stat st1, st2;
+
+    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
+}
+
+bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+                              int fd)
+{
+    if (container->fd == fd) {
+        return true;
+    }
+    if (!same_device(container->fd, fd)) {
+        return false;
+    }
+    /*
+     * Same device, different fd.  This occurs when the container fd is
+     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
+     * produces duplicates.  De-dup it.
+     */
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
+    close(fd);
+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    return true;
+}
-- 
2.49.0


