Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2030CC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaOZ-0000a7-90; Tue, 04 Mar 2025 17:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOR-0000Nt-A7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:42 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOP-0000wJ-7R
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:05:39 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaOL-00000000LXp-1rap; Tue, 04 Mar 2025 23:05:33 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 09/36] migration: Add thread pool of optional load threads
Date: Tue,  4 Mar 2025 23:03:36 +0100
Message-ID: <b09fd70369b6159c75847e69f235cb908b02570c.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Some drivers might want to make use of auxiliary helper threads during VM
state loading, for example to make sure that their blocking (sync) I/O
operations don't block the rest of the migration process.

Add a migration core managed thread pool to facilitate this use case.

The migration core will wait for these threads to finish before
(re)starting the VM at destination.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h |  3 ++
 include/qemu/typedefs.h  |  2 +
 migration/migration.c    |  2 +-
 migration/migration.h    |  5 +++
 migration/savevm.c       | 95 +++++++++++++++++++++++++++++++++++++++-
 migration/savevm.h       |  2 +-
 6 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c660be80954a..4c171f4e897e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
 /* migration/block.c */
 
 AnnounceParameters *migrate_announce_params(void);
+
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque);
 
 /* migration/migration.c */
 void migration_object_init(void);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3d84efcac47a..fd23ff7771b1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,5 +131,7 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
+                                    Error **errp);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/migration.c b/migration/migration.c
index 6b2a8af4231d..e28cebb0a775 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -422,7 +422,7 @@ void migration_incoming_state_destroy(void)
      * Check proper BQL state here rather than risk possible deadlock later.
      */
     assert(bql_locked());
-    qemu_loadvm_state_cleanup();
+    qemu_loadvm_state_cleanup(mis);
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/migration.h b/migration/migration.h
index 7b4278e2a32b..d53f7cad84d8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -43,6 +43,7 @@
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
 
 struct PostcopyBlocktimeContext;
+typedef struct ThreadPool ThreadPool;
 
 #define  MIGRATION_RESUME_ACK_VALUE  (1)
 
@@ -187,6 +188,10 @@ struct MigrationIncomingState {
     Coroutine *colo_incoming_co;
     QemuSemaphore colo_incoming_sem;
 
+    /* Optional load threads pool and its thread exit request flag */
+    ThreadPool *load_threads;
+    bool load_threads_abort;
+
     /*
      * PostcopyBlocktimeContext to keep information for postcopy
      * live migration, to calculate vCPU block time
diff --git a/migration/savevm.c b/migration/savevm.c
index 3e86b572cfa8..1abc365570e3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "block/snapshot.h"
+#include "block/thread-pool.h"
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
@@ -131,6 +132,35 @@ static struct mig_cmd_args {
  * generic extendable format with an exception for two old entities.
  */
 
+/***********************************************************/
+/* Optional load threads pool support */
+
+static void qemu_loadvm_thread_pool_create(MigrationIncomingState *mis)
+{
+    assert(!mis->load_threads);
+    mis->load_threads = thread_pool_new();
+    mis->load_threads_abort = false;
+}
+
+static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
+{
+    qatomic_set(&mis->load_threads_abort, true);
+
+    bql_unlock(); /* Load threads might be waiting for BQL */
+    g_clear_pointer(&mis->load_threads, thread_pool_free);
+    bql_lock();
+}
+
+static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
+                                         MigrationIncomingState *mis)
+{
+    bql_unlock(); /* Let load threads do work requiring BQL */
+    thread_pool_wait(mis->load_threads);
+    bql_lock();
+
+    return !migrate_has_error(s);
+}
+
 /***********************************************************/
 /* savevm/loadvm support */
 
@@ -2783,16 +2813,68 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
     return 0;
 }
 
-void qemu_loadvm_state_cleanup(void)
+struct LoadThreadData {
+    MigrationLoadThread function;
+    void *opaque;
+};
+
+static int qemu_loadvm_load_thread(void *thread_opaque)
+{
+    struct LoadThreadData *data = thread_opaque;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    g_autoptr(Error) local_err = NULL;
+
+    if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
+        MigrationState *s = migrate_get_current();
+
+        /*
+         * Can't set load_threads_abort here since processing of main migration
+         * channel data could still be happening, resulting in launching of new
+         * load threads.
+         */
+
+        assert(local_err);
+
+        /*
+         * In case of multiple load threads failing which thread error
+         * return we end setting is purely arbitrary.
+         */
+        migrate_set_error(s, local_err);
+    }
+
+    return 0;
+}
+
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    struct LoadThreadData *data;
+
+    /* We only set it from this thread so it's okay to read it directly */
+    assert(!mis->load_threads_abort);
+
+    data = g_new(struct LoadThreadData, 1);
+    data->function = function;
+    data->opaque = opaque;
+
+    thread_pool_submit_immediate(mis->load_threads, qemu_loadvm_load_thread,
+                                 data, g_free);
+}
+
+void qemu_loadvm_state_cleanup(MigrationIncomingState *mis)
 {
     SaveStateEntry *se;
 
     trace_loadvm_state_cleanup();
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->ops && se->ops->load_cleanup) {
             se->ops->load_cleanup(se->opaque);
         }
     }
+
+    qemu_loadvm_thread_pool_destroy(mis);
 }
 
 /* Return true if we should continue the migration, or false. */
@@ -2943,6 +3025,7 @@ out:
 
 int qemu_loadvm_state(QEMUFile *f)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     int ret;
@@ -2952,6 +3035,8 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    qemu_loadvm_thread_pool_create(mis);
+
     ret = qemu_loadvm_state_header(f);
     if (ret) {
         return ret;
@@ -2983,12 +3068,18 @@ int qemu_loadvm_state(QEMUFile *f)
 
     /* When reaching here, it must be precopy */
     if (ret == 0) {
-        if (migrate_has_error(migrate_get_current())) {
+        if (migrate_has_error(migrate_get_current()) ||
+            !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
         } else {
             ret = qemu_file_get_error(f);
         }
     }
+    /*
+     * Set this flag unconditionally so we'll catch further attempts to
+     * start additional threads via an appropriate assert()
+     */
+    qatomic_set(&mis->load_threads_abort, true);
 
     /*
      * Try to read in the VMDESC section as well, so that dumping tools that
diff --git a/migration/savevm.h b/migration/savevm.h
index cb58434a9437..138c39a7f9f9 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
-void qemu_loadvm_state_cleanup(void);
+void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);

