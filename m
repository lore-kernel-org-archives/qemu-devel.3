Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B27C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7X-00020x-4D; Wed, 29 May 2024 12:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM74-0001Hu-1N
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:23 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM71-0006Mo-Up
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:17 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6l-006CQA-3Z;
 Wed, 29 May 2024 17:24:59 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 20/26] vfio-user: proxy container connect/disconnect
Date: Wed, 29 May 2024 17:23:13 +0100
Message-Id: <20240529162319.1476680-21-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c           |  4 ++-
 hw/vfio/user-container.c      | 52 ++++++++++++++++++++++++++++-------
 hw/vfio/user-protocol.h       |  2 ++
 hw/vfio/user.c                |  4 +++
 hw/vfio/user.h                | 10 +++++++
 include/hw/vfio/vfio-common.h |  1 +
 6 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7e1a1a010a..e60e92066d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -914,7 +914,9 @@ void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
-    close(vbasedev->fd);
+    if (vbasedev->fd != -1) {
+        close(vbasedev->fd);
+    }
 }
 
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index f1218560a4..f0414509d5 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -56,34 +56,62 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
 /*
  * Try to mirror vfio_connect_container() as much as possible.
  */
 static VFIOUserContainer *
-vfio_connect_user_container(AddressSpace *as, Error **errp)
+vfio_connect_user_container(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
-    VFIOAddressSpace *space;
-    VFIOUserContainer *container;
     VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    const VFIOIOMMUClass *ops;
+    VFIOAddressSpace *space;
+    int ret;
 
     space = vfio_get_address_space(as);
 
     container = g_malloc0(sizeof(*container));
-
+    container->proxy = vbasedev->proxy;
     bcontainer = &container->bcontainer;
 
+    ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_USER));
+
+    vfio_container_init(&container->bcontainer, space, ops);
+
     if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
     }
 
+    /*
+     * VFIO user allows the device server to map guest memory so it has the same
+     * issue with discards as a local IOMMU has.
+     */
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     assert(bcontainer->ops->setup);
 
     if (!bcontainer->ops->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
@@ -109,6 +137,9 @@ listener_release_exit:
         bcontainer->ops->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -123,14 +154,15 @@ free_container_exit:
 static void vfio_disconnect_user_container(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     memory_listener_unregister(&bcontainer->listener);
     if (bcontainer->ops->release) {
         bcontainer->ops->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_container_destroy(bcontainer);
 
     vfio_cpr_unregister_container(bcontainer);
@@ -166,7 +198,7 @@ static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_connect_user_container(as, errp);
+    container = vfio_connect_user_container(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 48dd475ab3..87e43ddc72 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -16,6 +16,8 @@
  * region and offset info for read and write commands.
  */
 
+#include <stdint.h>
+
 typedef struct {
     uint16_t id;
     uint16_t command;
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 352c10d37b..224b5febd8 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -18,10 +18,14 @@
 #include "qemu/lockable.h"
 #include "hw/hw.h"
 #include "hw/vfio/vfio-common.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
 #include "qemu/sockets.h"
 #include "io/channel.h"
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
+#include "sysemu/reset.h"
 #include "sysemu/iothread.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 1f99a976d6..9039e96069 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -11,7 +11,17 @@
  *
  */
 
+#include <stdbool.h>
+
+#include "glib-compat.h"
 #include "user-protocol.h"
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "qemu/queue.h"
+#include "qemu/sockets.h"
+#include "qemu/thread.h"
+
+typedef struct VFIODevice VFIODevice;
 
 typedef struct {
     int send_fds;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 747b343596..c06099edce 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -90,6 +90,7 @@ typedef struct VFIOContainer {
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 typedef struct VFIOHostDMAWindow {
-- 
2.34.1


