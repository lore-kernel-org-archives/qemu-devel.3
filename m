Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BF5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPi7Z-0002qc-0o; Wed, 20 May 2026 10:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7W-0002q8-NW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:02 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7V-0002GL-2i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:02 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7K-00000001uqY-2awI; Wed, 20 May 2026 16:41:50 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] system/runstate: Allow adjustment of priority for VM
 state change handlers
Date: Wed, 20 May 2026 16:41:37 +0200
Message-ID: <b8f3cf976ebe8221d70e0ebcb55da60bfe2a141f.1779217494.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779217494.git.maciej.szmigiero@oracle.com>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

A future patch will need an ability to register qdev VM state change
handlers below and above the normal priority level for the registering
device qdev tree depth, but still properly ordered with respect to handlers
registered at other tree depths.

To implement this split the priority argument passed to
qemu_add_vm_change_state_handler_prio_full() into two parts:
its 15 most significant bits will now carry the actual qdev tree depth
while the 16 least significant bits will now carry the caller provided
priority adjustment value.

Although this will limit the qdev tree to a depth of 32k such high limit
shouldn't be a problem in practice.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/vm-change-state-handler.c | 22 +++++++++++++++-------
 hw/vfio/migration.c               |  2 +-
 include/system/runstate.h         |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 2c111350298d..3db0819984c6 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -19,9 +19,9 @@
 #include "hw/core/qdev.h"
 #include "system/runstate.h"
 
-static int qdev_get_dev_tree_depth(DeviceState *dev)
+static unsigned int qdev_get_dev_tree_depth(DeviceState *dev)
 {
-    int depth;
+    unsigned int depth;
 
     for (depth = 0; dev; depth++) {
         BusState *bus = dev->parent_bus;
@@ -61,20 +61,28 @@ VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      void *opaque)
 {
     assert(!cb || !cb_ret);
-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ret, opaque);
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ret, opaque, 0);
 }
 
 /*
  * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
- * and the cb_ret arguments too.
+ * and the cb_ret arguments too and allows for adjustment of priority.
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
     DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
-    VMChangeStateHandlerWithRet *cb_ret, void *opaque)
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque, int adj)
 {
-    int depth = qdev_get_dev_tree_depth(dev);
+    unsigned int depth = qdev_get_dev_tree_depth(dev);
+    int prio;
+
+    /* 32k depth should be enough for everyone */
+    assert(depth <= INT16_MAX);
+
+    /* encode depth on 15 MSB and adj on 16 LSB */
+    assert(adj >= INT16_MIN && adj <= INT16_MAX);
+    prio = (depth << 16) + (adj - INT16_MIN);
 
     assert(!cb || !cb_ret);
     return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ret,
-                                                      opaque, depth);
+                                                      opaque, prio);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index dbfd13b83a15..9889b20ad7dd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1227,7 +1227,7 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
                      vfio_vmstate_change_prepare :
                      NULL;
     migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev, 0);
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
diff --git a/include/system/runstate.h b/include/system/runstate.h
index 929379adae41..306e2684c195 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -69,7 +69,7 @@ VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      void *opaque);
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
     DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
-    VMChangeStateHandlerWithRet *cb_ret, void *opaque);
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque, int adj);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM

