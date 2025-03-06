Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DAC28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC1W-0000fD-VY; Thu, 06 Mar 2025 09:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0m-0007cu-Si
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0k-0001px-Gg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7Bt2EpAIGgMArz6Dk8AbOWgsYJFhPuLViysJsREzs8=;
 b=eWz4t8APhBAkf0IUEzj1FGpeoBzsTD2FuE6ykQxdkDxrlGJFi6g0ZdE8FHunIIrFHfidJs
 4rYOClAgBAptyy++VMVTHloehqj6pT/rt1fg3dHZTfk9S00xbGGVri3Qw/i+CWfTX8vUES
 IDWlMQzbIi0Pf9cUFVh/TIdvrUKevE4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-Bmp2nXKAPAyBXX5uxFHJ4Q-1; Thu,
 06 Mar 2025 09:15:24 -0500
X-MC-Unique: Bmp2nXKAPAyBXX5uxFHJ4Q-1
X-Mimecast-MFC-AGG-ID: Bmp2nXKAPAyBXX5uxFHJ4Q_1741270523
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16F719560B0; Thu,  6 Mar 2025 14:15:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C499B180174C; Thu,  6 Mar 2025 14:15:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/42] migration: Add thread pool of optional load threads
Date: Thu,  6 Mar 2025 15:13:54 +0100
Message-ID: <20250306141419.2015340-19-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Some drivers might want to make use of auxiliary helper threads during VM
state loading, for example to make sure that their blocking (sync) I/O
operations don't block the rest of the migration process.

Add a migration core managed thread pool to facilitate this use case.

The migration core will wait for these threads to finish before
(re)starting the VM at destination.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/b09fd70369b6159c75847e69f235cb908b02570c.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h |  3 ++
 include/qemu/typedefs.h  |  2 +
 migration/migration.h    |  5 +++
 migration/savevm.h       |  2 +-
 migration/migration.c    |  2 +-
 migration/savevm.c       | 95 +++++++++++++++++++++++++++++++++++++++-
 6 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c660be80954abdd768e419d2ab892fc034c7349d..4c171f4e897e2bea9016a1559bef3e89c165b176 100644
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
index 3d84efcac47a2f1a34f177a1ed0df5aeae04fdb3..fd23ff7771b1bd6cd51f48bbc5be86aa57982307 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,5 +131,7 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
+                                    Error **errp);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/migration.h b/migration/migration.h
index 7b4278e2a32b2044fad4cf7f7a5defd4435333ea..d53f7cad84d8e4a8bd8546f94d635c9733d71961 100644
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
diff --git a/migration/savevm.h b/migration/savevm.h
index cb58434a9437f7f9752ae7ae02981e9927d4ce85..138c39a7f9f97f69957eac63f338e4807bd7e8c5 100644
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
diff --git a/migration/migration.c b/migration/migration.c
index 0bf70ea9717d73b0816f6ae52b99ae67924e8030..1833cfe3580cd6e587c6c7cb754458c34baf61e8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -419,7 +419,7 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
-    qemu_loadvm_state_cleanup();
+    qemu_loadvm_state_cleanup(mis);
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/savevm.c b/migration/savevm.c
index 3e86b572cfa82c201b1bf935080a2e0ca651be0e..1abc365570e324dd85f8a95adeb1a95f57b73264 100644
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
-- 
2.48.1


