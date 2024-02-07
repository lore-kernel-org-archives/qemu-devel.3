Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A194C4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4B-0006i8-7I; Wed, 07 Feb 2024 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi45-0006fg-2X
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi40-0008Oo-0A
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgJ4BThz4wyt;
 Thu,  8 Feb 2024 00:34:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgF0XYzz4wc6;
 Thu,  8 Feb 2024 00:34:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH 03/14] memory: Add Error** argument to .log_global*() handlers
Date: Wed,  7 Feb 2024 14:33:36 +0100
Message-ID: <20240207133347.1115903-4-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Modify memory_global_dirty_log_start() and memory_global_dirty_log_stop()
to also take an Error** parameter and report the error in the callers.
Aside from error reporting, there should be no functional changes.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/exec/memory.h | 12 ++++++++----
 hw/i386/xen/xen-hvm.c |  8 ++++----
 hw/vfio/common.c      |  6 ++++--
 hw/virtio/vhost.c     |  4 ++--
 migration/dirtyrate.c | 24 ++++++++++++++++++++----
 migration/ram.c       | 27 +++++++++++++++++++++++----
 system/memory.c       | 37 +++++++++++++++++++++++++------------
 7 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 177be23db709d8bab9cebfe6acbae57611073327..b348070dc8f17b3505196d3a92d8cfb2171b640f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -998,8 +998,9 @@ struct MemoryListener {
      * active at that time.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
      */
-    void (*log_global_start)(MemoryListener *listener);
+    void (*log_global_start)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_stop:
@@ -1009,8 +1010,9 @@ struct MemoryListener {
      * the address space.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
      */
-    void (*log_global_stop)(MemoryListener *listener);
+    void (*log_global_stop)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_after_sync:
@@ -2567,15 +2569,17 @@ void memory_listener_unregister(MemoryListener *listener);
  * memory_global_dirty_log_start: begin dirty logging for all regions
  *
  * @flags: purpose of starting dirty log, migration or dirty rate
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-void memory_global_dirty_log_start(unsigned int flags);
+void memory_global_dirty_log_start(unsigned int flags, Error **errp);
 
 /**
  * memory_global_dirty_log_stop: end dirty logging for all regions
  *
  * @flags: purpose of stopping dirty log, migration or dirty rate
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-void memory_global_dirty_log_stop(unsigned int flags);
+void memory_global_dirty_log_stop(unsigned int flags, Error **errp);
 
 void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e6742552035122ea58092c91c3458338ff..d9c80416343b71311389563c7bdaa748829ada29 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -446,14 +446,14 @@ static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
                           int128_get64(section->size));
 }
 
-static void xen_log_global_start(MemoryListener *listener)
+static void xen_log_global_start(MemoryListener *listener, Error **errp)
 {
     if (xen_enabled()) {
         xen_in_migration = true;
     }
 }
 
-static void xen_log_global_stop(MemoryListener *listener)
+static void xen_log_global_stop(MemoryListener *listener, Error **errp)
 {
     xen_in_migration = false;
 }
@@ -653,9 +653,9 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
     if (enable) {
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
     } else {
-        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
+        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, errp);
     }
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a85e2eb908df828c1f42104d683e911..45af5c675584e1931dfba3b4f78469cc4c00014e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1075,7 +1075,8 @@ out:
     return ret;
 }
 
-static void vfio_listener_log_global_start(MemoryListener *listener)
+static void vfio_listener_log_global_start(MemoryListener *listener,
+                                           Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1094,7 +1095,8 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
     }
 }
 
-static void vfio_listener_log_global_stop(MemoryListener *listener)
+static void vfio_listener_log_global_stop(MemoryListener *listener,
+                                          Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac794680ea9b65eba6cc22e70cf141e90aa73..970f5951cc0b2113f91a3c640e27add5752b2944 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1044,7 +1044,7 @@ check_dev_state:
     return r;
 }
 
-static void vhost_log_global_start(MemoryListener *listener)
+static void vhost_log_global_start(MemoryListener *listener, Error **errp)
 {
     int r;
 
@@ -1054,7 +1054,7 @@ static void vhost_log_global_start(MemoryListener *listener)
     }
 }
 
-static void vhost_log_global_stop(MemoryListener *listener)
+static void vhost_log_global_stop(MemoryListener *listener, Error **errp)
 {
     int r;
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746fb7b10eb7f149976970f9a92125af8a..443acab7a7efbd6e9c94883363e1a827a3538292 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -90,13 +90,19 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 
 void global_dirty_log_change(unsigned int flag, bool start)
 {
+    Error *local_err = NULL;
+
     bql_lock();
     if (start) {
-        memory_global_dirty_log_start(flag);
+        memory_global_dirty_log_start(flag, &local_err);
     } else {
-        memory_global_dirty_log_stop(flag);
+        memory_global_dirty_log_stop(flag, &local_err);
     }
     bql_unlock();
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
@@ -106,12 +112,18 @@ void global_dirty_log_change(unsigned int flag, bool start)
  */
 static void global_dirty_log_sync(unsigned int flag, bool one_shot)
 {
+    Error *local_err = NULL;
+
     bql_lock();
     memory_global_dirty_log_sync(false);
     if (one_shot) {
-        memory_global_dirty_log_stop(flag);
+        memory_global_dirty_log_stop(flag, &local_err);
     }
     bql_unlock();
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static DirtyPageRecord *vcpu_dirty_stat_alloc(VcpuStat *stat)
@@ -608,9 +620,13 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 {
     int64_t start_time;
     DirtyPageRecord dirty_pages;
+    Error *local_err = NULL;
 
     bql_lock();
-    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
+    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 
     /*
      * 1'round of log sync may return all 1 bits with
diff --git a/migration/ram.c b/migration/ram.c
index 8dac9bac2fe8b8c19e102c771a7ef6e976252906..d86626bb1c704b2d3497b323a702ca6ca8939a79 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2391,6 +2391,7 @@ static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
+    Error *local_err = NULL;
 
     /* We don't use dirty log with background snapshots */
     if (!migrate_background_snapshot()) {
@@ -2403,7 +2404,10 @@ static void ram_save_cleanup(void *opaque)
              * memory_global_dirty_log_stop will assert that
              * memory_global_dirty_log_start/stop used in pairs
              */
-            memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
+            memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+            }
         }
     }
 
@@ -2800,13 +2804,18 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static void ram_init_bitmaps(RAMState *rs)
 {
+    Error *local_err = NULL;
+
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+            }
             migration_bitmap_sync_precopy(rs, false);
         }
     }
@@ -3450,6 +3459,8 @@ int colo_init_ram_cache(void)
 void colo_incoming_start_dirty_log(void)
 {
     RAMBlock *block = NULL;
+    Error *local_err = NULL;
+
     /* For memory_global_dirty_log_start below. */
     bql_lock();
     qemu_mutex_lock_ramlist();
@@ -3461,7 +3472,10 @@ void colo_incoming_start_dirty_log(void)
             /* Discard this dirty bitmap record */
             bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS);
         }
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
     ram_state->migration_dirty_pages = 0;
     qemu_mutex_unlock_ramlist();
@@ -3472,8 +3486,13 @@ void colo_incoming_start_dirty_log(void)
 void colo_release_ram_cache(void)
 {
     RAMBlock *block;
+    Error *local_err = NULL;
+
+    memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 
-    memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         g_free(block->bmap);
         block->bmap = NULL;
diff --git a/system/memory.c b/system/memory.c
index a229a79988fce2aa3cb77e3a130db4c694e8cd49..2fb9ef56e7302af120f6287e1beda7a181c9a349 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2912,18 +2912,22 @@ void memory_global_after_dirty_log_sync(void)
  */
 static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
-static void memory_global_dirty_log_stop_postponed_run(void);
+static void memory_global_dirty_log_stop_postponed_run(Error **errp);
 
-void memory_global_dirty_log_start(unsigned int flags)
+void memory_global_dirty_log_start(unsigned int flags, Error **errp)
 {
     unsigned int old_flags;
+    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
     if (vmstate_change) {
         /* If there is postponed stop(), operate on it first */
         postponed_stop_flags &= ~flags;
-        memory_global_dirty_log_stop_postponed_run();
+        memory_global_dirty_log_stop_postponed_run(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 
     flags &= ~global_dirty_tracking;
@@ -2936,14 +2940,14 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
+        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward, errp);
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
     }
 }
 
-static void memory_global_dirty_log_do_stop(unsigned int flags)
+static void memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
 {
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
     assert((global_dirty_tracking & flags) == flags);
@@ -2955,7 +2959,7 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
+        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse, errp);
     }
 }
 
@@ -2963,14 +2967,14 @@ static void memory_global_dirty_log_do_stop(unsigned int flags)
  * Execute the postponed dirty log stop operations if there is, then reset
  * everything (including the flags and the vmstate change hook).
  */
-static void memory_global_dirty_log_stop_postponed_run(void)
+static void memory_global_dirty_log_stop_postponed_run(Error **errp)
 {
     /* This must be called with the vmstate handler registered */
     assert(vmstate_change);
 
     /* Note: postponed_stop_flags can be cleared in log start routine */
     if (postponed_stop_flags) {
-        memory_global_dirty_log_do_stop(postponed_stop_flags);
+        memory_global_dirty_log_do_stop(postponed_stop_flags, errp);
         postponed_stop_flags = 0;
     }
 
@@ -2981,12 +2985,17 @@ static void memory_global_dirty_log_stop_postponed_run(void)
 static void memory_vm_change_state_handler(void *opaque, bool running,
                                            RunState state)
 {
+    Error *local_err = NULL;
+
     if (running) {
-        memory_global_dirty_log_stop_postponed_run();
+        memory_global_dirty_log_stop_postponed_run(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
-void memory_global_dirty_log_stop(unsigned int flags)
+void memory_global_dirty_log_stop(unsigned int flags, Error **errp)
 {
     if (!runstate_is_running()) {
         /* Postpone the dirty log stop, e.g., to when VM starts again */
@@ -3001,7 +3010,7 @@ void memory_global_dirty_log_stop(unsigned int flags)
         return;
     }
 
-    memory_global_dirty_log_do_stop(flags);
+    memory_global_dirty_log_do_stop(flags, errp);
 }
 
 static void listener_add_address_space(MemoryListener *listener,
@@ -3009,13 +3018,17 @@ static void listener_add_address_space(MemoryListener *listener,
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
+            listener->log_global_start(listener, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+            }
         }
     }
 
-- 
2.43.0


