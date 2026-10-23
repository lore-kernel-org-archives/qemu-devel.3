Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2DA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlI-00030A-9V; Fri, 23 Oct 2026 15:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkx-0002wW-0D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:50 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKku-00020H-3u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:46 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkq-00000007BEb-0BRN; Fri, 23 Oct 2026 21:16:40 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 02/13] runstate: Introduce VM change state handlers
 explicit priority levels
Date: Fri, 23 Oct 2026 21:16:13 +0200
Message-ID: <a0b20e201722bbcebaf0d29d7aa6cdb68e8a0ca5.1792758435.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Replace the current two-level implicit priority system of prepare_cb()
and cb() with explicit multi-level priority system.

The old prepare_cb() maps to VM_CHANGE_STATE_PRI_HIGH in this new system,
while the old cb() maps to VM_CHANGE_STATE_PRI_NORMAL.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/vm-change-state-handler.c |  16 +++--
 hw/vfio/migration.c               |  14 ++--
 hw/vfio/vfio-migration-internal.h |   1 +
 include/system/runstate.h         |  38 ++++++-----
 system/runstate.c                 | 106 ++++++++++++++++--------------
 5 files changed, 98 insertions(+), 77 deletions(-)

diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 2c111350298d..3800f148af68 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -61,20 +61,22 @@ VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      void *opaque)
 {
     assert(!cb || !cb_ret);
-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ret, opaque);
+    return qdev_add_vm_change_state_handler_full(
+        dev, cb, cb_ret, opaque, VM_CHANGE_STATE_PRI_NORMAL);
 }
 
 /*
- * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
- * and the cb_ret arguments too.
+ * Exactly like qdev_add_vm_change_state_handler() but allows selecting the
+ * notification priority.
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
-    VMChangeStateHandlerWithRet *cb_ret, void *opaque)
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque,
+    VMChangeStateHandlerPri priority)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
     assert(!cb || !cb_ret);
-    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ret,
-                                                      opaque, depth);
+    return qemu_add_vm_change_state_handler_prio_full(cb, cb_ret, opaque,
+                                                      priority, depth);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 73c49d8c24f2..76ede0efbf02 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1149,7 +1149,6 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
     bool precopy_info_v2_used = false;
-    VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
         error_setg(errp, "no vfio_get_object handler");
@@ -1210,11 +1209,13 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
-                     vfio_vmstate_change_prepare :
-                     NULL;
-    migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
+    if (migration->mig_flags & VFIO_MIGRATION_P2P) {
+        migration->vm_state_prepare = qdev_add_vm_change_state_handler_full(
+            vbasedev->dev, vfio_vmstate_change_prepare, NULL, vbasedev,
+            VM_CHANGE_STATE_PRI_HIGH);
+    }
+    migration->vm_state = qdev_add_vm_change_state_handler(
+        vbasedev->dev, vfio_vmstate_change, NULL, vbasedev);
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
@@ -1289,6 +1290,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
     VFIOMigration *migration = vbasedev->migration;
 
     migration_remove_notifier(&migration->migration_state);
+    qemu_del_vm_change_state_handler(migration->vm_state_prepare);
     qemu_del_vm_change_state_handler(migration->vm_state);
     unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
     vfio_migration_free(vbasedev);
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a1c58b112685..b3c2f86cae78 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -38,6 +38,7 @@ typedef struct VFIOMultifd VFIOMultifd;
 
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
+    VMChangeStateEntry *vm_state_prepare;
     VMChangeStateEntry *vm_state;
     NotifierWithReturn migration_state;
     uint32_t device_state;
diff --git a/include/system/runstate.h b/include/system/runstate.h
index cceb88d2e3b0..e28261ec4a20 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,12 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+typedef enum VMChangeStateHandlerPri {
+    VM_CHANGE_STATE_PRI_HIGH,
+    VM_CHANGE_STATE_PRI_NORMAL,
+    VM_CHANGE_STATE_PRI_MAX,
+} VMChangeStateHandlerPri;
+
 /**
  * qemu_add_vm_change_state_handler:
  * @cb: the callback to invoke
@@ -30,8 +36,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
  * qemu_add_vm_change_state_handler_prio:
  * @cb: the callback to invoke
  * @opaque: user data passed to the callback
- * @depth: low depths execute first when the vm runs and the reverse is true
- *         when the vm stops
+ * @priority: priority at which to invoke the callback
  *
  * Register a callback function that is invoked when the vm starts or stops
  * running.
@@ -39,37 +44,38 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
  * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
  */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int depth);
+    VMChangeStateHandler *cb, void *opaque,
+    VMChangeStateHandlerPri priority);
 VMChangeStateEntry *
 /**
  * qemu_add_vm_change_state_handler_prio_full:
- * @cb: the main callback to invoke
- * @prepare_cb: a callback to invoke before the main callback
- * @cb_ret: the main callback to invoke with return value
+ * @cb: the callback to invoke
+ * @cb_ret: the callback to invoke with return value
  * @opaque: user data passed to the callbacks
+ * @priority: priority at which to invoke the callback
  * @depth: low depths execute first when the vm runs and the reverse is true
  *         when the vm stops
  *
- * Register a main callback function and an optional prepare callback function
- * that are invoked when the vm starts or stops running. The main callback and
- * the prepare callback are called in two separate phases: First all prepare
- * callbacks are called and only then all main callbacks are called. As its
- * name suggests, the prepare callback can be used to do some preparatory work
- * before invoking the main callback.
+ * Register a callback function that is invoked when the vm starts or stops
+ * running. All higher priority notifications are completed before calling any
+ * lower priority ones. In addition to that, depth ordering is maintained within
+ * each priority level.
  *
  * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
  */
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
-                                           VMChangeStateHandler *prepare_cb,
                                            VMChangeStateHandlerWithRet *cb_ret,
-                                           void *opaque, int depth);
+                                           void *opaque,
+                                           VMChangeStateHandlerPri priority,
+                                           int depth);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      VMChangeStateHandlerWithRet *cb_ret,
                                                      void *opaque);
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
-    VMChangeStateHandlerWithRet *cb_ret, void *opaque);
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque,
+    VMChangeStateHandlerPri priority);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
diff --git a/system/runstate.c b/system/runstate.c
index 60eba9a63e93..5f16f09507ed 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -300,55 +300,71 @@ void qemu_system_vmstop_request(RunState state)
 }
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
-    VMChangeStateHandler *prepare_cb;
     VMChangeStateHandlerWithRet *cb_ret;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
+    VMChangeStateHandlerPri priority;
     int depth;
 };
 
-static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
-    QTAILQ_HEAD_INITIALIZER(vm_change_state_head);
+typedef QTAILQ_HEAD(VMChangeStateHead, VMChangeStateEntry) VMChangeStateHead;
+
+static VMChangeStateHead vm_change_state_head[VM_CHANGE_STATE_PRI_MAX] = {
+    [VM_CHANGE_STATE_PRI_HIGH] =
+        QTAILQ_HEAD_INITIALIZER(
+            vm_change_state_head[VM_CHANGE_STATE_PRI_HIGH]),
+    [VM_CHANGE_STATE_PRI_NORMAL] =
+        QTAILQ_HEAD_INITIALIZER(
+            vm_change_state_head[VM_CHANGE_STATE_PRI_NORMAL]),
+};
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int depth)
+    VMChangeStateHandler *cb, void *opaque,
+    VMChangeStateHandlerPri priority)
 {
-    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
-                                                      opaque, depth);
+    return qemu_add_vm_change_state_handler_prio_full(
+        cb, NULL, opaque, priority, 0);
 }
 
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
-                                           VMChangeStateHandler *prepare_cb,
                                            VMChangeStateHandlerWithRet *cb_ret,
-                                           void *opaque, int depth)
+                                           void *opaque,
+                                           VMChangeStateHandlerPri priority,
+                                           int depth)
 {
     VMChangeStateEntry *e;
     VMChangeStateEntry *other;
+    VMChangeStateHead *head;
+
+    assert(priority >= 0 && priority < VM_CHANGE_STATE_PRI_MAX);
+    assert(!cb || !cb_ret);
 
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
-    e->prepare_cb = prepare_cb;
     e->cb_ret = cb_ret;
     e->opaque = opaque;
+    e->priority = priority;
     e->depth = depth;
 
+    head = &vm_change_state_head[priority];
     /* Keep list sorted in ascending depth order */
-    QTAILQ_FOREACH(other, &vm_change_state_head, entries) {
+    QTAILQ_FOREACH(other, head, entries) {
         if (depth < other->depth) {
             QTAILQ_INSERT_BEFORE(other, e, entries);
             return e;
         }
     }
 
-    QTAILQ_INSERT_TAIL(&vm_change_state_head, e, entries);
+    QTAILQ_INSERT_TAIL(head, e, entries);
     return e;
 }
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque)
 {
-    return qemu_add_vm_change_state_handler_prio(cb, opaque, 0);
+    return qemu_add_vm_change_state_handler_prio(
+        cb, opaque, VM_CHANGE_STATE_PRI_NORMAL);
 }
 
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
@@ -356,54 +372,48 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
     if (!e) {
         return;
     }
-    QTAILQ_REMOVE(&vm_change_state_head, e, entries);
+    QTAILQ_REMOVE(&vm_change_state_head[e->priority], e, entries);
     g_free(e);
 }
 
 int vm_state_notify(bool running, RunState state)
 {
     VMChangeStateEntry *e, *next;
+    int pri;
     int ret = 0;
 
     trace_vm_state_notify(running, state, RunState_str(state));
 
-    if (running) {
-        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            if (e->prepare_cb) {
-                e->prepare_cb(e->opaque, running, state);
-            }
-        }
+    for (pri = VM_CHANGE_STATE_PRI_HIGH;
+         pri < VM_CHANGE_STATE_PRI_MAX; pri++) {
+        VMChangeStateHead *head = &vm_change_state_head[pri];
 
-        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            if (e->cb) {
-                e->cb(e->opaque, running, state);
-            } else if (e->cb_ret) {
-                /*
-                 * Here ignore the return value of cb_ret because
-                 * we only care about the stopping the device during
-                 * the VM live migration to indicate whether the
-                 * connection between qemu and backend is normal.
-                 */
-                e->cb_ret(e->opaque, running, state);
+        if (running) {
+            QTAILQ_FOREACH_SAFE(e, head, entries, next) {
+                if (e->cb) {
+                    e->cb(e->opaque, running, state);
+                } else if (e->cb_ret) {
+                    /*
+                     * Here ignore the return value of cb_ret because
+                     * we only care about stopping the device during
+                     * the VM live migration to indicate whether the
+                     * connection between qemu and backend is normal.
+                     */
+                    e->cb_ret(e->opaque, running, state);
+                }
             }
-        }
-    } else {
-        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
-            if (e->prepare_cb) {
-                e->prepare_cb(e->opaque, running, state);
-            }
-        }
-
-        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
-            if (e->cb) {
-                e->cb(e->opaque, running, state);
-            } else if (e->cb_ret) {
-                /*
-                 * We should execute all registered callbacks even if
-                 * one of them returns failure, otherwise, some cleanup
-                 * work of the device will be skipped.
-                 */
-                ret |= e->cb_ret(e->opaque, running, state);
+        } else {
+            QTAILQ_FOREACH_REVERSE_SAFE(e, head, entries, next) {
+                if (e->cb) {
+                    e->cb(e->opaque, running, state);
+                } else if (e->cb_ret) {
+                    /*
+                     * We should execute all registered callbacks even if
+                     * one of them returns failure, otherwise, some cleanup
+                     * work of the device will be skipped.
+                     */
+                    ret |= e->cb_ret(e->opaque, running, state);
+                }
             }
         }
     }

