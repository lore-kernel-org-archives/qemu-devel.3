Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D84BC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7Sw-0000xc-Us; Mon, 04 Mar 2024 07:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7SN-0000Xi-J4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:16 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7S6-0004n2-1o
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ163mTnz4x0m;
 Mon,  4 Mar 2024 23:29:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ115HvLz4x0r;
 Mon,  4 Mar 2024 23:29:41 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 14/26] memory: Add Error** argument to .log_global*()
 handlers
Date: Mon,  4 Mar 2024 13:28:32 +0100
Message-ID: <20240304122844.1888308-15-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Modify all log_global*() handlers to take an Error** parameter and
return a bool. A new MEMORY_LISTENER_CALL_LOG_GLOBAL macro looping on
the listeners is introduced to handle a possible error, which will
would interrupt the loop if necessary.

To be noted the change in memory_global_dirty_log_start() behavior as
it will return as soon as an error is detected.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v3: 

 - Fixed return value of vfio_listener_log_global_start() and
   vfio_listener_log_global_stop(). Went unnoticed because not tested.
   
 include/exec/memory.h | 15 ++++++--
 hw/i386/xen/xen-hvm.c |  6 ++--
 hw/vfio/common.c      |  8 +++--
 hw/virtio/vhost.c     |  6 ++--
 system/memory.c       | 83 +++++++++++++++++++++++++++++++++++++------
 system/physmem.c      |  5 +--
 6 files changed, 101 insertions(+), 22 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b310ed7b1a1db7978ba4b394032c2f15..4bc146c5ebdd377cd14a4e462f32cc945db5a0a8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -998,8 +998,11 @@ struct MemoryListener {
      * active at that time.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
      */
-    void (*log_global_start)(MemoryListener *listener);
+    bool (*log_global_start)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_stop:
@@ -1009,8 +1012,11 @@ struct MemoryListener {
      * the address space.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
      */
-    void (*log_global_stop)(MemoryListener *listener);
+    bool (*log_global_stop)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_after_sync:
@@ -1019,8 +1025,11 @@ struct MemoryListener {
      * for any #MemoryRegionSection.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
      */
-    void (*log_global_after_sync)(MemoryListener *listener);
+    bool (*log_global_after_sync)(MemoryListener *listener, Error **errp);
 
     /**
      * @eventfd_add:
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e6742552035122ea58092c91c3458338ff..925a207b494b4eed52d5f360b554f18ac8a9806d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -446,16 +446,18 @@ static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
                           int128_get64(section->size));
 }
 
-static void xen_log_global_start(MemoryListener *listener)
+static bool xen_log_global_start(MemoryListener *listener, Error **errp)
 {
     if (xen_enabled()) {
         xen_in_migration = true;
     }
+    return true;
 }
 
-static void xen_log_global_stop(MemoryListener *listener)
+static bool xen_log_global_stop(MemoryListener *listener, Error **errp)
 {
     xen_in_migration = false;
+    return true;
 }
 
 static const MemoryListener xen_memory_listener = {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ff88c3f31ca660b3c0a790601100fdc6116192a0..71352ad6532cad02f3a2ab53bdd531d769ea55b2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1075,7 +1075,8 @@ out:
     return ret;
 }
 
-static void vfio_listener_log_global_start(MemoryListener *listener)
+static bool vfio_listener_log_global_start(MemoryListener *listener,
+                                           Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1092,9 +1093,11 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
                      ret, strerror(-ret));
         vfio_set_migration_error(ret);
     }
+    return !ret;
 }
 
-static void vfio_listener_log_global_stop(MemoryListener *listener)
+static bool vfio_listener_log_global_stop(MemoryListener *listener,
+                                          Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1111,6 +1114,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
                      ret, strerror(-ret));
         vfio_set_migration_error(ret);
     }
+    return !ret;
 }
 
 static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac794680ea9b65eba6cc22e70cf141e90aa73..7a555f941934991a72a2817e5505fe0ce6d6fc64 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1044,7 +1044,7 @@ check_dev_state:
     return r;
 }
 
-static void vhost_log_global_start(MemoryListener *listener)
+static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
 {
     int r;
 
@@ -1052,9 +1052,10 @@ static void vhost_log_global_start(MemoryListener *listener)
     if (r < 0) {
         abort();
     }
+    return true;
 }
 
-static void vhost_log_global_stop(MemoryListener *listener)
+static bool vhost_log_global_stop(MemoryListener *listener, Error **errp)
 {
     int r;
 
@@ -1062,6 +1063,7 @@ static void vhost_log_global_stop(MemoryListener *listener)
     if (r < 0) {
         abort();
     }
+    return true;
 }
 
 static void vhost_log_start(MemoryListener *listener,
diff --git a/system/memory.c b/system/memory.c
index a229a79988fce2aa3cb77e3a130db4c694e8cd49..af06157ead5b1272548e87f79ab9fb3036055328 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -127,6 +127,35 @@ enum ListenerDirection { Forward, Reverse };
         }                                                               \
     } while (0)
 
+#define MEMORY_LISTENER_CALL_LOG_GLOBAL(_callback, _direction, _errp,   \
+                                        _args...)                       \
+    do {                                                                \
+        MemoryListener *_listener;                                      \
+                                                                        \
+        switch (_direction) {                                           \
+        case Forward:                                                   \
+            QTAILQ_FOREACH(_listener, &memory_listeners, link) {        \
+                if (_listener->_callback) {                             \
+                    if (!_listener->_callback(_listener, _errp, ##_args)) { \
+                        break;                                          \
+                    }                                                   \
+                }                                                       \
+            }                                                           \
+            break;                                                      \
+        case Reverse:                                                   \
+            QTAILQ_FOREACH_REVERSE(_listener, &memory_listeners, link) { \
+                if (_listener->_callback) {                             \
+                    if (!_listener->_callback(_listener, _errp, ##_args)) { \
+                        break;                                          \
+                    }                                                   \
+                }                                                       \
+            }                                                           \
+            break;                                                      \
+        default:                                                        \
+            abort();                                                    \
+        };                                                              \
+    } while (0)
+
 #define MEMORY_LISTENER_CALL(_as, _callback, _direction, _section, _args...) \
     do {                                                                \
         MemoryListener *_listener;                                      \
@@ -2903,7 +2932,13 @@ void memory_global_dirty_log_sync(bool last_stage)
 
 void memory_global_after_dirty_log_sync(void)
 {
-    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
+    Error *local_err = NULL;
+
+    MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_after_sync, Forward,
+                                    &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
@@ -2912,18 +2947,22 @@ void memory_global_after_dirty_log_sync(void)
  */
 static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
-static void memory_global_dirty_log_stop_postponed_run(void);
+static bool memory_global_dirty_log_stop_postponed_run(Error **errp);
 
 void memory_global_dirty_log_start(unsigned int flags)
 {
     unsigned int old_flags;
+    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
     if (vmstate_change) {
         /* If there is postponed stop(), operate on it first */
         postponed_stop_flags &= ~flags;
-        memory_global_dirty_log_stop_postponed_run();
+        if (!memory_global_dirty_log_stop_postponed_run(&local_err)) {
+            error_report_err(local_err);
+            return;
+        }
     }
 
     flags &= ~global_dirty_tracking;
@@ -2936,15 +2975,22 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
+        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward,
+                                        &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return;
+        }
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
     }
 }
 
-static void memory_global_dirty_log_do_stop(unsigned int flags)
+static bool memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
 {
+    ERRP_GUARD();
+
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
     assert((global_dirty_tracking & flags) == flags);
     global_dirty_tracking &= ~flags;
@@ -2955,39 +3001,49 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
+        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_stop, Reverse, errp);
     }
+    return !*errp;
 }
 
 /*
  * Execute the postponed dirty log stop operations if there is, then reset
  * everything (including the flags and the vmstate change hook).
  */
-static void memory_global_dirty_log_stop_postponed_run(void)
+static bool memory_global_dirty_log_stop_postponed_run(Error **errp)
 {
+    bool ret = true;
+
     /* This must be called with the vmstate handler registered */
     assert(vmstate_change);
 
     /* Note: postponed_stop_flags can be cleared in log start routine */
     if (postponed_stop_flags) {
-        memory_global_dirty_log_do_stop(postponed_stop_flags);
+        ret = memory_global_dirty_log_do_stop(postponed_stop_flags, errp);
         postponed_stop_flags = 0;
     }
 
     qemu_del_vm_change_state_handler(vmstate_change);
     vmstate_change = NULL;
+    return ret;
 }
 
 static void memory_vm_change_state_handler(void *opaque, bool running,
                                            RunState state)
 {
+    Error *local_err = NULL;
+
     if (running) {
-        memory_global_dirty_log_stop_postponed_run();
+        if (!memory_global_dirty_log_stop_postponed_run(&local_err)) {
+            error_report_err(local_err);
+        }
     }
 }
 
 void memory_global_dirty_log_stop(unsigned int flags)
 {
+    Error *local_err = NULL;
+
     if (!runstate_is_running()) {
         /* Postpone the dirty log stop, e.g., to when VM starts again */
         if (vmstate_change) {
@@ -3001,7 +3057,9 @@ void memory_global_dirty_log_stop(unsigned int flags)
         return;
     }
 
-    memory_global_dirty_log_do_stop(flags);
+    if (!memory_global_dirty_log_do_stop(flags, &local_err)) {
+        error_report_err(local_err);
+    }
 }
 
 static void listener_add_address_space(MemoryListener *listener,
@@ -3009,13 +3067,16 @@ static void listener_add_address_space(MemoryListener *listener,
 {
     FlatView *view;
     FlatRange *fr;
+    Error *local_err = NULL;
 
     if (listener->begin) {
         listener->begin(listener);
     }
     if (global_dirty_tracking) {
         if (listener->log_global_start) {
-            listener->log_global_start(listener);
+            if (!listener->log_global_start(listener, &local_err)) {
+                error_report_err(local_err);
+            }
         }
     }
 
diff --git a/system/physmem.c b/system/physmem.c
index e3ebc19eefd8050a1dee16e3d1449f0c144f751f..9adbf9aea847cd80bdac6dca466fb476844ac048 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -148,7 +148,7 @@ typedef struct subpage_t {
 
 static void io_mem_init(void);
 static void memory_map_init(void);
-static void tcg_log_global_after_sync(MemoryListener *listener);
+static bool tcg_log_global_after_sync(MemoryListener *listener, Error **errp);
 static void tcg_commit(MemoryListener *listener);
 
 /**
@@ -2475,7 +2475,7 @@ static void do_nothing(CPUState *cpu, run_on_cpu_data d)
 {
 }
 
-static void tcg_log_global_after_sync(MemoryListener *listener)
+static bool tcg_log_global_after_sync(MemoryListener *listener, Error **errp)
 {
     CPUAddressSpace *cpuas;
 
@@ -2507,6 +2507,7 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
         cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
         run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
     }
+    return true;
 }
 
 static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
-- 
2.44.0


