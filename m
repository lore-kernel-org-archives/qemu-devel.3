Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A3EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7VP-0003x0-Q1; Mon, 04 Mar 2024 07:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7Se-0000iS-6d
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:40 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7S8-0004oq-HK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ1D172kz4x1R;
 Mon,  4 Mar 2024 23:29:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ170lKmz4x0q;
 Mon,  4 Mar 2024 23:29:46 +1100 (AEDT)
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
 David Hildenbrand <david@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v3 15/26] memory: Add Error** argument to the global_dirty_log
 routines
Date: Mon,  4 Mar 2024 13:28:33 +0100
Message-ID: <20240304122844.1888308-16-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that the log_global*() handlers take an Error** parameter and
return a bool, do the same for memory_global_dirty_log_start() and
memory_global_dirty_log_stop(). The error is reported in the callers
for now and it will be propagated in the call stack in the next
changes.

To be noted a functional change in ram_init_bitmaps(), if the dirty
pages logger fails to start, there is no need to synchronize the dirty
pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
similar way.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/exec/memory.h | 10 ++++++++--
 hw/i386/xen/xen-hvm.c |  4 ++--
 migration/dirtyrate.c | 21 +++++++++++++++++----
 migration/ram.c       | 34 ++++++++++++++++++++++++++++++----
 system/memory.c       | 30 ++++++++++++------------------
 5 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4bc146c5ebdd377cd14a4e462f32cc945db5a0a8..8b019465ab13ce85c03075c80865a0865ea1feed 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2576,15 +2576,21 @@ void memory_listener_unregister(MemoryListener *listener);
  * memory_global_dirty_log_start: begin dirty logging for all regions
  *
  * @flags: purpose of starting dirty log, migration or dirty rate
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_global_dirty_log_start(unsigned int flags);
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
 
 /**
  * memory_global_dirty_log_stop: end dirty logging for all regions
  *
  * @flags: purpose of stopping dirty log, migration or dirty rate
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_global_dirty_log_stop(unsigned int flags);
+bool memory_global_dirty_log_stop(unsigned int flags, Error **errp);
 
 void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 925a207b494b4eed52d5f360b554f18ac8a9806d..286269b47572d90e57df5ff44835bb5f8e16c7ad 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -655,9 +655,9 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
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
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746fb7b10eb7f149976970f9a92125af8a..34f6d803ff5f4e6ccf2e06aaaed65a336c4be469 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -90,11 +90,17 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 
 void global_dirty_log_change(unsigned int flag, bool start)
 {
+    Error *local_err = NULL;
+    bool ret;
+
     bql_lock();
     if (start) {
-        memory_global_dirty_log_start(flag);
+        ret = memory_global_dirty_log_start(flag, &local_err);
     } else {
-        memory_global_dirty_log_stop(flag);
+        ret = memory_global_dirty_log_stop(flag, &local_err);
+    }
+    if (!ret) {
+        error_report_err(local_err);
     }
     bql_unlock();
 }
@@ -106,10 +112,14 @@ void global_dirty_log_change(unsigned int flag, bool start)
  */
 static void global_dirty_log_sync(unsigned int flag, bool one_shot)
 {
+    Error *local_err = NULL;
+
     bql_lock();
     memory_global_dirty_log_sync(false);
     if (one_shot) {
-        memory_global_dirty_log_stop(flag);
+        if (!memory_global_dirty_log_stop(flag, &local_err)) {
+            error_report_err(local_err);
+        }
     }
     bql_unlock();
 }
@@ -608,9 +618,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
 {
     int64_t start_time;
     DirtyPageRecord dirty_pages;
+    Error *local_err = NULL;
 
     bql_lock();
-    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
+    if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, &local_err)) {
+        error_report_err(local_err);
+    }
 
     /*
      * 1'round of log sync may return all 1 bits with
diff --git a/migration/ram.c b/migration/ram.c
index 20c6ad9e759b2b8ec7ae26b7ca72d5cbd20d481f..3d9c08cfae8a59031a7c1b3c70721c2a90daceba 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2390,6 +2390,7 @@ static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
+    Error *local_err = NULL;
 
     /* We don't use dirty log with background snapshots */
     if (!migrate_background_snapshot()) {
@@ -2402,7 +2403,10 @@ static void ram_save_cleanup(void *opaque)
              * memory_global_dirty_log_stop will assert that
              * memory_global_dirty_log_start/stop used in pairs
              */
-            memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
+            if (!memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION,
+                                              &local_err)) {
+                error_report_err(local_err);
+            }
         }
     }
 
@@ -2799,18 +2803,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static void ram_init_bitmaps(RAMState *rs)
 {
+    Error *local_err = NULL;
+    bool ret = true;
+
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
+                                                &local_err);
+            if (!ret) {
+                error_report_err(local_err);
+                goto out_unlock;
+            }
             migration_bitmap_sync_precopy(rs, false);
         }
     }
+out_unlock:
     qemu_mutex_unlock_ramlist();
 
+    if (!ret) {
+        return;
+    }
+
     /*
      * After an eventual first bitmap sync, fixup the initial bitmap
      * containing all 1s to exclude any discarded pages from migration.
@@ -3459,6 +3476,8 @@ int colo_init_ram_cache(void)
 void colo_incoming_start_dirty_log(void)
 {
     RAMBlock *block = NULL;
+    Error *local_err = NULL;
+
     /* For memory_global_dirty_log_start below. */
     bql_lock();
     qemu_mutex_lock_ramlist();
@@ -3470,7 +3489,10 @@ void colo_incoming_start_dirty_log(void)
             /* Discard this dirty bitmap record */
             bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS);
         }
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        if (!memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
+                                           &local_err)) {
+            error_report_err(local_err);
+        }
     }
     ram_state->migration_dirty_pages = 0;
     qemu_mutex_unlock_ramlist();
@@ -3481,8 +3503,12 @@ void colo_incoming_start_dirty_log(void)
 void colo_release_ram_cache(void)
 {
     RAMBlock *block;
+    Error *local_err = NULL;
+
+    if (!memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, &local_err)) {
+        error_report_err(local_err);
+    }
 
-    memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         g_free(block->bmap);
         block->bmap = NULL;
diff --git a/system/memory.c b/system/memory.c
index af06157ead5b1272548e87f79ab9fb3036055328..48aed0f8ece1c731849636c442b8ab8e5d7ff6a5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2949,25 +2949,24 @@ static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
 static bool memory_global_dirty_log_stop_postponed_run(Error **errp);
 
-void memory_global_dirty_log_start(unsigned int flags)
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
 {
+    ERRP_GUARD();
     unsigned int old_flags;
-    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
     if (vmstate_change) {
         /* If there is postponed stop(), operate on it first */
         postponed_stop_flags &= ~flags;
-        if (!memory_global_dirty_log_stop_postponed_run(&local_err)) {
-            error_report_err(local_err);
-            return;
+        if (!memory_global_dirty_log_stop_postponed_run(errp)) {
+            return false;
         }
     }
 
     flags &= ~global_dirty_tracking;
     if (!flags) {
-        return;
+        return true;
     }
 
     old_flags = global_dirty_tracking;
@@ -2975,16 +2974,15 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward,
-                                        &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            return;
+        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward, errp);
+        if (*errp) {
+            return false;
         }
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
     }
+    return true;
 }
 
 static bool memory_global_dirty_log_do_stop(unsigned int flags, Error **errp)
@@ -3040,10 +3038,8 @@ static void memory_vm_change_state_handler(void *opaque, bool running,
     }
 }
 
-void memory_global_dirty_log_stop(unsigned int flags)
+bool memory_global_dirty_log_stop(unsigned int flags, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!runstate_is_running()) {
         /* Postpone the dirty log stop, e.g., to when VM starts again */
         if (vmstate_change) {
@@ -3054,12 +3050,10 @@ void memory_global_dirty_log_stop(unsigned int flags)
             vmstate_change = qemu_add_vm_change_state_handler(
                 memory_vm_change_state_handler, NULL);
         }
-        return;
+        return true;
     }
 
-    if (!memory_global_dirty_log_do_stop(flags, &local_err)) {
-        error_report_err(local_err);
-    }
+    return memory_global_dirty_log_do_stop(flags, errp);
 }
 
 static void listener_add_address_space(MemoryListener *listener,
-- 
2.44.0


