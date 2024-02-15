Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1739CC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXLM-00018O-5p; Thu, 15 Feb 2024 03:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raXLB-00013w-Db
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:43:34 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raXL7-000168-SD
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:43:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:36ad:0:640:5aad:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id DA744618B5;
 Thu, 15 Feb 2024 11:43:25 +0300 (MSK)
Received: from rkhapov-nux.yandex.net (unknown
 [2a02:6b8:82:604:e806:5ea2:b505:d402])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OhkPjR5IiKo0-AtGKAhQQ; Thu, 15 Feb 2024 11:43:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1707986604;
 bh=BO/mv5C6yvXXAB+zZEM52PqUHZ9pC8DMMequyOZtvus=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=CR+hJPO5EteGb9coiV6x2W9FvaCee6zkjxWYYL0jOpYpfBU0Bjp3tHjgUN9B9W/ce
 t8r+6KjwvbSgE7s5JmE9RDAgdp/fp4vCGlRrZ8LDeFt9tiEVxXKjzWbPk9M5g3p/TC
 AZoYgbtS8opf9S/bXej0Rfs4sbYCpS/MdrMCCwwg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Roman Khapov <rkhapov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 yc-core@yandex-team.ru, Roman Khapov <rkhapov@yandex-team.ru>
Subject: [PATCH 2/2] migration: add error reason for failed MIGRATION events
Date: Thu, 15 Feb 2024 13:43:22 +0500
Message-Id: <20240215084322.1384090-1-rkhapov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This patch adds error description as reason for event MIGRATION in every
place that generates MIGRATION_STATE_FAILED

Signed-off-by: Roman Khapov <rkhapov@yandex-team.ru>
---
 migration/migration.c | 62 ++++++++++++++++++++++++++++++-------------
 migration/multifd.c   |  8 +++---
 migration/savevm.c    | 12 ++++-----
 3 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d28885a55b..0af16d5fa9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -702,11 +702,14 @@ process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    g_autofree char *fail_reason = NULL;
 
     assert(mis->from_src_file);
 
     if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
+        fail_reason = g_strdup("Failed to setup decompress threads");
+        /* wrap with %s to silence compiler warning of non-literal in format */
+        error_report("%s", fail_reason);
         goto fail;
     }
 
@@ -750,11 +753,15 @@ process_incoming_migration_co(void *opaque)
                 error_report_err(s->error);
             }
         }
-        error_report("load of migration failed: %s", strerror(-ret));
+        fail_reason = g_strdup_printf("load of migration failed: %s",
+                                      strerror(-ret));
+        /* wrap with %s to silence compiler warning of non-literal in format */
+        error_report("%s", fail_reason);
         goto fail;
     }
 
     if (colo_incoming_co() < 0) {
+        fail_reason = g_strdup("colo_incoming failed");
         goto fail;
     }
 
@@ -762,7 +769,7 @@ process_incoming_migration_co(void *opaque)
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_FAILED, NULL);
+                      MIGRATION_STATUS_FAILED, fail_reason);
     qemu_fclose(mis->from_src_file);
 
     multifd_recv_cleanup();
@@ -1417,8 +1424,8 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
-    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED, NULL);
+    migrate_set_state_err_reason(&s->state, MIGRATION_STATUS_SETUP,
+                                 MIGRATION_STATUS_FAILED, error);
     migrate_set_error(s, error);
 }
 
@@ -1968,6 +1975,7 @@ void qmp_migrate(const char *uri, bool has_channels,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
+    ERRP_GUARD();
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
@@ -2037,8 +2045,8 @@ void qmp_migrate(const char *uri, bool has_channels,
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED, NULL);
+        migrate_set_state_err_reason(&s->state, MIGRATION_STATUS_SETUP,
+                                     MIGRATION_STATUS_FAILED, *errp);
         block_cleanup_parameters();
     }
 
@@ -2426,6 +2434,7 @@ migration_wait_main_channel(MigrationState *ms)
  */
 static int postcopy_start(MigrationState *ms, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
@@ -2436,8 +2445,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-            migrate_set_state(&ms->state, ms->state,
-                              MIGRATION_STATUS_FAILED, NULL);
+            error_setg(errp,
+                       "postcopy_start: establishing channel failed");
+            migrate_set_state_err_reason(&ms->state, ms->state,
+                                         MIGRATION_STATUS_FAILED, *errp);
             return -1;
         }
     }
@@ -2456,17 +2467,21 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     global_state_store();
     ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
+        error_setg(errp, "postcopy_start: vm stop failed");
         goto fail;
     }
 
     ret = migration_maybe_pause(ms, &cur_state,
                                 MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
+        error_setg(errp, "postcopy_start: migratoin pause failed");
         goto fail;
     }
 
     ret = bdrv_inactivate_all();
     if (ret < 0) {
+        error_setg(errp,
+                   "postcopy_start: making block drivers inactive failed");
         goto fail;
     }
     restart_block = true;
@@ -2543,6 +2558,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
+        error_setg(errp, "postcopy_start: blob sending failed");
         goto fail_closefb;
     }
     qemu_fclose(fb);
@@ -2573,8 +2589,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_setg(errp, "postcopy_start: Migration stream errored");
-        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED, NULL);
+        migrate_set_state_err_reason(&ms->state,
+                                     MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                     MIGRATION_STATUS_FAILED, *errp);
     }
 
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
@@ -2584,8 +2601,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                      MIGRATION_STATUS_FAILED, NULL);
+    migrate_set_state_err_reason(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                 MIGRATION_STATUS_FAILED, *errp);
     if (restart_block) {
         /* A failure happened early enough that we know the destination hasn't
          * accessed block devices, so we're safe to recover.
@@ -2700,7 +2717,8 @@ static void migration_completion_postcopy(MigrationState *s)
 }
 
 static void migration_completion_failed(MigrationState *s,
-                                        int current_active_state)
+                                        int current_active_state,
+                                        const char *fail_reason)
 {
     if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
                               s->state == MIGRATION_STATUS_DEVICE)) {
@@ -2721,7 +2739,7 @@ static void migration_completion_failed(MigrationState *s,
     }
 
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED, NULL);
+                      MIGRATION_STATUS_FAILED, fail_reason);
 }
 
 /**
@@ -2733,6 +2751,7 @@ static void migration_completion_failed(MigrationState *s,
 static void migration_completion(MigrationState *s)
 {
     int ret = 0;
+    const char *fail_reason = NULL;
     int current_active_state = s->state;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
@@ -2740,6 +2759,7 @@ static void migration_completion(MigrationState *s)
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
+        fail_reason = "migration completion: unexpected migration state";
         ret = -1;
     }
 
@@ -2748,6 +2768,7 @@ static void migration_completion(MigrationState *s)
     }
 
     if (close_return_path_on_source(s)) {
+        fail_reason = "migration completion: return path thread close failed";
         goto fail;
     }
 
@@ -2768,7 +2789,7 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    migration_completion_failed(s, current_active_state);
+    migration_completion_failed(s, current_active_state, fail_reason);
 }
 
 /**
@@ -2994,7 +3015,8 @@ static MigThrError migration_detect_error(MigrationState *s)
          * For precopy (or postcopy with error outside IO), we fail
          * with no time.
          */
-        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED, NULL);
+        migrate_set_state_err_reason(&s->state, state,
+                                     MIGRATION_STATUS_FAILED, s->error);
         trace_migration_thread_file_err();
 
         /* Time to stop the migration, now. */
@@ -3458,6 +3480,7 @@ static void *bg_migration_thread(void *opaque)
     MigThrError thr_error;
     QEMUFile *fb;
     bool early_fail = true;
+    const char *fail_reason = NULL;
 
     rcu_register_thread();
     object_ref(OBJECT(s));
@@ -3509,6 +3532,7 @@ static void *bg_migration_thread(void *opaque)
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
     if (migration_stop_vm(RUN_STATE_PAUSED)) {
+        fail_reason = "stopping vm failed";
         goto fail;
     }
     /*
@@ -3517,6 +3541,7 @@ static void *bg_migration_thread(void *opaque)
      */
     cpu_synchronize_all_states();
     if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
+        fail_reason = "savevm state failed";
         goto fail;
     }
     /*
@@ -3527,6 +3552,7 @@ static void *bg_migration_thread(void *opaque)
 
     /* Now initialize UFFD context and start tracking RAM writes */
     if (ram_write_tracking_start()) {
+        fail_reason = "starting UFFD-WP memory tracking failed";
         goto fail;
     }
     early_fail = false;
@@ -3566,7 +3592,7 @@ static void *bg_migration_thread(void *opaque)
 fail:
     if (early_fail) {
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED, NULL);
+                          MIGRATION_STATUS_FAILED, fail_reason);
         bql_unlock();
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index da3d397642..cb52ebc062 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -594,8 +594,8 @@ static void multifd_send_set_error(Error *err)
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
             s->state == MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED, NULL);
+            migrate_set_state_err_reason(&s->state, s->state,
+                                         MIGRATION_STATUS_FAILED, err);
         }
     }
 }
@@ -1086,8 +1086,8 @@ static void multifd_recv_terminate_threads(Error *err)
         migrate_set_error(s, err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED, NULL);
+            migrate_set_state_err_reason(&s->state, s->state,
+                                         MIGRATION_STATUS_FAILED, err);
         }
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index be6cce8a51..52fd3e37db 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1700,9 +1700,9 @@ void qemu_savevm_state_cleanup(void)
 
 static int qemu_savevm_state(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     MigrationState *ms = migrate_get_current();
-    MigrationStatus status;
 
     if (migration_is_running(ms->state)) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
@@ -1735,16 +1735,16 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         ret = qemu_file_get_error(f);
     }
     qemu_savevm_state_cleanup();
+
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Error while writing VM state");
-    }
 
-    if (ret != 0) {
-        status = MIGRATION_STATUS_FAILED;
+        migrate_set_state_err_reason(&ms->state, MIGRATION_STATUS_SETUP,
+                                     MIGRATION_STATUS_FAILED, *errp);
     } else {
-        status = MIGRATION_STATUS_COMPLETED;
+        migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_COMPLETED, NULL);
     }
-    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status, NULL);
 
     /* f is outer parameter, it should not stay in global migration state after
      * this function finished */
-- 
2.34.1


