Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4843C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrR9-0000hE-2w; Wed, 06 Mar 2024 08:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrR7-0000cZ-3M
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:57 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrR4-0006B3-Ot
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYNS4q0Sz4wyt;
 Thu,  7 Mar 2024 00:35:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYNM0kzsz4wcF;
 Thu,  7 Mar 2024 00:35:46 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 14/25] memory: Add Error** argument to the global_dirty_log
 routines
Date: Wed,  6 Mar 2024 14:34:29 +0100
Message-ID: <20240306133441.2351700-15-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Dropped log_global_stop() and log_global_sync() changes
 
 include/exec/memory.h |  5 ++++-
 hw/i386/xen/xen-hvm.c |  2 +-
 migration/dirtyrate.c | 13 +++++++++++--
 migration/ram.c       | 22 ++++++++++++++++++++--
 system/memory.c       | 11 +++++------
 5 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5555567bc4c9fdb53e8f63487f1400980275687d..c129ee6db7162504bd72d4cfc69b5affb2cd87e8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener *listener);
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
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 0608ca99f5166fd6379ee674442484e805eff9c0..57cb7df50788a6c31eff68c95e8eaa856fdebede 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -654,7 +654,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
     if (enable) {
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
     } else {
         memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
     }
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746fb7b10eb7f149976970f9a92125af8a..d02d70b7b4b86a29d4d5540ded416543536d8f98 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
 
 void global_dirty_log_change(unsigned int flag, bool start)
 {
+    Error *local_err = NULL;
+    bool ret;
+
     bql_lock();
     if (start) {
-        memory_global_dirty_log_start(flag);
+        ret = memory_global_dirty_log_start(flag, &local_err);
+        if (!ret) {
+            error_report_err(local_err);
+        }
     } else {
         memory_global_dirty_log_stop(flag);
     }
@@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
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
index c5149b7d717aefad7f590422af0ea4a40e7507be..397b4c0f218a66d194e44f9c5f9fe8e9885c48b6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
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
@@ -3631,6 +3644,8 @@ int colo_init_ram_cache(void)
 void colo_incoming_start_dirty_log(void)
 {
     RAMBlock *block = NULL;
+    Error *local_err = NULL;
+
     /* For memory_global_dirty_log_start below. */
     bql_lock();
     qemu_mutex_lock_ramlist();
@@ -3642,7 +3657,10 @@ void colo_incoming_start_dirty_log(void)
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
diff --git a/system/memory.c b/system/memory.c
index 3600e716149407c10a1f6bf8f0a81c2611cf15ba..cbc098216b789f50460f1d1bc7ec122030693d9e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2931,10 +2931,9 @@ static void memory_global_dirty_log_rollback(MemoryListener *listener,
     }
 }
 
-void memory_global_dirty_log_start(unsigned int flags)
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
 {
     unsigned int old_flags;
-    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
@@ -2946,7 +2945,7 @@ void memory_global_dirty_log_start(unsigned int flags)
 
     flags &= ~global_dirty_tracking;
     if (!flags) {
-        return;
+        return true;
     }
 
     old_flags = global_dirty_tracking;
@@ -2959,7 +2958,7 @@ void memory_global_dirty_log_start(unsigned int flags)
 
         QTAILQ_FOREACH(listener, &memory_listeners, link) {
             if (listener->log_global_start) {
-                ret = listener->log_global_start(listener, &local_err);
+                ret = listener->log_global_start(listener, errp);
                 if (!ret) {
                     break;
                 }
@@ -2969,14 +2968,14 @@ void memory_global_dirty_log_start(unsigned int flags)
         if (!ret) {
             memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link),
                                              flags);
-            error_report_err(local_err);
-            return;
+            return false;
         }
 
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
     }
+    return true;
 }
 
 static void memory_global_dirty_log_do_stop(unsigned int flags)
-- 
2.44.0


