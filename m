Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2466DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raX5U-0007vB-Qd; Thu, 15 Feb 2024 03:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raX5S-0007up-PD
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:27:18 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raX5O-0004ei-9Q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:27:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:36ad:0:640:5aad:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 04C0260EB0;
 Thu, 15 Feb 2024 11:27:08 +0300 (MSK)
Received: from rkhapov-nux.yandex.net (unknown
 [2a02:6b8:82:604:e806:5ea2:b505:d402])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4RkUWR5IgKo0-DYAbvAr0; Thu, 15 Feb 2024 11:27:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1707985626;
 bh=y3397fPl3A0A+RjLLlOS4AzJsjKSebty9NUioCBoNT8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=EVpyeHjea3ob5br7yl66c9o0fpK1mZTYQ9F6+O6XlNHrKT0wKFEJohooDumWCD/80
 APpu3ybPbQwLhR5WmTLlA9+wETBQ8xZNyvu66LWyGztD6tiy57Uwqbv8a1fXDXBv/u
 AW8G08qbmcaf1G/nz2miE6kCTC1WG6/yXoRRJe+k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Roman Khapov <rkhapov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 yc-core@yandex-team.ru, Roman Khapov <rkhapov@yandex-team.ru>
Subject: [PATCH 1/2] qapi/migration.json: add reason to MIGRATION event
Date: Thu, 15 Feb 2024 13:26:58 +0500
Message-Id: <20240215082659.1378342-2-rkhapov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215082659.1378342-1-rkhapov@yandex-team.ru>
References: <20240215082659.1378342-1-rkhapov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds the optional field reason for the events, which
contains the string, describing reason of status changing.
For example: reason of migration fail.

Function migrate_set_state now accepts 4th argument: the reason to
pass to event. Every call of this function appended with NULL argument.

Also migrate_set_state_err_reason was added to form reason from Error*

Signed-off-by: Roman Khapov <rkhapov@yandex-team.ru>
---
 migration/colo.c      |  6 +--
 migration/migration.c | 86 ++++++++++++++++++++++++++-----------------
 migration/migration.h |  5 ++-
 migration/multifd.c   |  6 +--
 migration/savevm.c    | 14 +++----
 qapi/migration.json   |  3 +-
 6 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 315e31fe32..3c95291a83 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -102,7 +102,7 @@ static void secondary_vm_do_failover(void)
     }
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
-                      MIGRATION_STATUS_COMPLETED);
+                      MIGRATION_STATUS_COMPLETED, NULL);
 
     replication_stop_all(true, &local_err);
     if (local_err) {
@@ -157,7 +157,7 @@ static void primary_vm_do_failover(void)
     Error *local_err = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
-                      MIGRATION_STATUS_COMPLETED);
+                      MIGRATION_STATUS_COMPLETED, NULL);
     /*
      * kick COLO thread which might wait at
      * qemu_sem_wait(&s->colo_checkpoint_sem).
@@ -823,7 +823,7 @@ static void *colo_process_incoming_thread(void *opaque)
     qemu_sem_init(&mis->colo_incoming_sem, 0);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_COLO);
+                      MIGRATION_STATUS_COLO, NULL);
 
     if (get_colo_mode() != COLO_MODE_SECONDARY) {
         error_report("COLO mode must be COLO_MODE_SECONDARY");
diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..d28885a55b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -354,10 +354,10 @@ void migration_incoming_state_destroy(void)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_generate_event(int new_state)
+static void migrate_generate_event(int new_state, const char *reason)
 {
     if (migrate_events()) {
-        qapi_event_send_migration(new_state);
+        qapi_event_send_migration(new_state, reason);
     }
 }
 
@@ -598,7 +598,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     }
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
-                      MIGRATION_STATUS_SETUP);
+                      MIGRATION_STATUS_SETUP, NULL);
 
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
@@ -692,7 +692,7 @@ static void process_incoming_migration_bh(void *opaque)
      * it's ready to use.
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_COMPLETED);
+                      MIGRATION_STATUS_COMPLETED, NULL);
     migration_incoming_state_destroy();
 }
 
@@ -713,7 +713,7 @@ process_incoming_migration_co(void *opaque)
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_ACTIVE);
+                      MIGRATION_STATUS_ACTIVE, NULL);
 
     mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file);
@@ -762,7 +762,7 @@ process_incoming_migration_co(void *opaque)
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILED, NULL);
     qemu_fclose(mis->from_src_file);
 
     multifd_recv_cleanup();
@@ -808,7 +808,7 @@ static bool postcopy_try_recover(void)
         mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
 
         migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
-                          MIGRATION_STATUS_POSTCOPY_RECOVER);
+                          MIGRATION_STATUS_POSTCOPY_RECOVER, NULL);
 
         /*
          * Here, we only wake up the main loading thread (while the
@@ -1308,15 +1308,27 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 /* shared migration helpers */
 
-void migrate_set_state(int *state, int old_state, int new_state)
+void migrate_set_state(int *state, int old_state,
+                       int new_state, const char *reason)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
         trace_migrate_set_state(MigrationStatus_str(new_state));
-        migrate_generate_event(new_state);
+        migrate_generate_event(new_state, reason);
     }
 }
 
+void migrate_set_state_err_reason(int *state, int old_state,
+                                  int new_state, const Error *err)
+{
+    const char *reason = NULL;
+    if (likely(err != NULL)) {
+        reason = error_get_pretty(err);
+    }
+
+    migrate_set_state(state, old_state, new_state, reason);
+}
+
 static void migrate_fd_cleanup(MigrationState *s)
 {
     g_free(s->hostname);
@@ -1360,7 +1372,7 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
-                          MIGRATION_STATUS_CANCELLED);
+                          MIGRATION_STATUS_CANCELLED, NULL);
     }
 
     if (s->error) {
@@ -1406,7 +1418,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILED, NULL);
     migrate_set_error(s, error);
 }
 
@@ -1432,7 +1444,8 @@ static void migrate_fd_cancel(MigrationState *s)
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
             qemu_sem_post(&s->pause_sem);
         }
-        migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
+        migrate_set_state(&s->state, old_state,
+                          MIGRATION_STATUS_CANCELLING, NULL);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
 
     /*
@@ -1612,7 +1625,8 @@ int migrate_init(MigrationState *s, Error **errp)
     s->error = NULL;
     s->vmdesc = NULL;
 
-    migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
+    migrate_set_state(&s->state, MIGRATION_STATUS_NONE,
+                      MIGRATION_STATUS_SETUP, NULL);
 
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
@@ -2024,7 +2038,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILED, NULL);
         block_cleanup_parameters();
     }
 
@@ -2145,7 +2159,7 @@ static bool migrate_handle_rp_resume_ack(MigrationState *s,
 
     /* Now both sides are active. */
     migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
-                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE, NULL);
 
     /* Notify send thread that time to continue send pages */
     migration_rp_kick(s);
@@ -2422,14 +2436,15 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            migrate_set_state(&ms->state, ms->state,
+                              MIGRATION_STATUS_FAILED, NULL);
             return -1;
         }
     }
 
     if (!migrate_pause_before_switchover()) {
         migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE, NULL);
     }
 
     trace_postcopy_start();
@@ -2559,7 +2574,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (ret) {
         error_setg(errp, "postcopy_start: Migration stream errored");
         migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                              MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILED, NULL);
     }
 
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
@@ -2570,7 +2585,7 @@ fail_closefb:
     qemu_fclose(fb);
 fail:
     migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILED, NULL);
     if (restart_block) {
         /* A failure happened early enough that we know the destination hasn't
          * accessed block devices, so we're safe to recover.
@@ -2618,10 +2633,10 @@ static int migration_maybe_pause(MigrationState *s,
     if (s->state != MIGRATION_STATUS_CANCELLING) {
         bql_unlock();
         migrate_set_state(&s->state, *current_active_state,
-                          MIGRATION_STATUS_PRE_SWITCHOVER);
+                          MIGRATION_STATUS_PRE_SWITCHOVER, NULL);
         qemu_sem_wait(&s->pause_sem);
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
-                          new_state);
+                          new_state, NULL);
         *current_active_state = new_state;
         bql_lock();
     }
@@ -2706,7 +2721,7 @@ static void migration_completion_failed(MigrationState *s,
     }
 
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILED, NULL);
 }
 
 /**
@@ -2744,10 +2759,10 @@ static void migration_completion(MigrationState *s)
     if (migrate_colo() && s->state == MIGRATION_STATUS_ACTIVE) {
         /* COLO does not support postcopy */
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_COLO);
+                          MIGRATION_STATUS_COLO, NULL);
     } else {
         migrate_set_state(&s->state, current_active_state,
-                          MIGRATION_STATUS_COMPLETED);
+                          MIGRATION_STATUS_COMPLETED, NULL);
     }
 
     return;
@@ -2785,12 +2800,12 @@ static void bg_migration_completion(MigrationState *s)
     }
 
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_COMPLETED);
+                      MIGRATION_STATUS_COMPLETED, NULL);
     return;
 
 fail:
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILED, NULL);
 }
 
 typedef enum MigThrError {
@@ -2901,7 +2916,7 @@ static MigThrError postcopy_pause(MigrationState *s)
         close_return_path_on_source(s);
 
         migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_POSTCOPY_PAUSED);
+                          MIGRATION_STATUS_POSTCOPY_PAUSED, NULL);
 
         error_report("Detected IO failure for postcopy. "
                      "Migration paused.");
@@ -2979,7 +2994,7 @@ static MigThrError migration_detect_error(MigrationState *s)
          * For precopy (or postcopy with error outside IO), we fail
          * with no time.
          */
-        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED, NULL);
         trace_migration_thread_file_err();
 
         /* Time to stop the migration, now. */
@@ -3279,7 +3294,8 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
                                     int new_state)
 {
     if (qemu_savevm_state_guest_unplug_pending()) {
-        migrate_set_state(&s->state, old_state, MIGRATION_STATUS_WAIT_UNPLUG);
+        migrate_set_state(&s->state, old_state,
+                          MIGRATION_STATUS_WAIT_UNPLUG, NULL);
 
         while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
                qemu_savevm_state_guest_unplug_pending()) {
@@ -3302,9 +3318,10 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
             }
         }
 
-        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG, new_state);
+        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
+                          new_state, NULL);
     } else {
-        migrate_set_state(&s->state, old_state, new_state);
+        migrate_set_state(&s->state, old_state, new_state, NULL);
     }
 }
 
@@ -3549,7 +3566,7 @@ static void *bg_migration_thread(void *opaque)
 fail:
     if (early_fail) {
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILED, NULL);
         bql_unlock();
     }
 
@@ -3615,7 +3632,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
-            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            migrate_set_state(&s->state, s->state,
+                              MIGRATION_STATUS_FAILED, NULL);
             migrate_set_error(s, local_err);
             error_report_err(local_err);
             migrate_fd_cleanup(s);
@@ -3635,7 +3653,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     if (resume) {
         /* Wakeup the main migration thread to do the recovery */
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
-                          MIGRATION_STATUS_POSTCOPY_RECOVER);
+                          MIGRATION_STATUS_POSTCOPY_RECOVER, NULL);
         qemu_sem_post(&s->postcopy_pause_sem);
         return;
     }
diff --git a/migration/migration.h b/migration/migration.h
index f2c8b8f286..9150478654 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -468,7 +468,10 @@ struct MigrationState {
     bool rdma_migration;
 };
 
-void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_state(int *state, int old_state,
+                       int new_state, const char *reason);
+void migrate_set_state_err_reason(int *state, int old_state,
+                                  int new_state, const Error *err);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..da3d397642 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -595,7 +595,7 @@ static void multifd_send_set_error(Error *err)
             s->state == MIGRATION_STATUS_DEVICE ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
+                              MIGRATION_STATUS_FAILED, NULL);
         }
     }
 }
@@ -1056,7 +1056,7 @@ bool multifd_send_setup(void)
         migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILED, NULL);
         return false;
     }
 
@@ -1087,7 +1087,7 @@ static void multifd_recv_terminate_threads(Error *err)
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
+                              MIGRATION_STATUS_FAILED, NULL);
         }
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index d612c8a902..be6cce8a51 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1744,7 +1744,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     } else {
         status = MIGRATION_STATUS_COMPLETED;
     }
-    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
+    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status, NULL);
 
     /* f is outer parameter, it should not stay in global migration state after
      * this function finished */
@@ -1999,7 +1999,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     object_ref(OBJECT(migr));
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE, NULL);
     qemu_sem_post(&mis->thread_sync_sem);
     trace_postcopy_ram_listen_thread_start();
 
@@ -2037,7 +2037,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
         } else {
             error_report("%s: loadvm failed: %d", __func__, load_res);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                           MIGRATION_STATUS_FAILED);
+                              MIGRATION_STATUS_FAILED, NULL);
         }
     }
     if (load_res >= 0) {
@@ -2062,7 +2062,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     }
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                   MIGRATION_STATUS_COMPLETED);
+                      MIGRATION_STATUS_COMPLETED, NULL);
     /*
      * If everything has worked fine, then the main thread has waited
      * for us to start, and we're the last use of the mis.
@@ -2257,7 +2257,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
      * This means source VM is ready to resume the postcopy migration.
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
-                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE, NULL);
 
     trace_loadvm_postcopy_handle_resume();
 
@@ -2818,8 +2818,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     }
 
     /* Current state can be either ACTIVE or RECOVER */
-    migrate_set_state(&mis->state, mis->state,
-                      MIGRATION_STATUS_POSTCOPY_PAUSED);
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_POSTCOPY_PAUSED, NULL);
 
     /* Notify the fault thread for the invalidated file handle */
     postcopy_fault_thread_notify(mis);
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..33bb5b7f50 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1392,6 +1392,7 @@
 # Emitted when a migration event happens
 #
 # @status: @MigrationStatus describing the current migration status.
+# @reason: Optional description of status changing reason.
 #
 # Since: 2.4
 #
@@ -1402,7 +1403,7 @@
 #     "data": {"status": "completed"} }
 ##
 { 'event': 'MIGRATION',
-  'data': {'status': 'MigrationStatus'}}
+  'data': {'status': 'MigrationStatus', '*reason': 'str'}}
 
 ##
 # @MIGRATION_PASS:
-- 
2.34.1


