Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C7FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgeX-0003NQ-RO; Wed, 24 Apr 2024 13:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeV-0003MQ-HL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:27 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeP-0004iT-5u
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 89A6260B39;
 Wed, 24 Apr 2024 20:43:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8811::1:29])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kgPOp63Iaa60-KRSzZzmS; Wed, 24 Apr 2024 20:43:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713980595;
 bh=5OSDWg6+P5VT4+lAHPEjXDXOLnj3GJUAQ6nXgKAjyzI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pUutSXya6qD7iXPZN2hA3fGtLlMN2ltt/cxrFqZMsjxqJ3FaFQvAMUCQSN69Sqb2R
 vcC1FcN9f+ZVjISb5HwX4gDQJyLlxU8I/pKmU1OjxMSHelzT/BV9teAzQHp7flBcCy
 Vr0avWY1GLPthZE6DunDIvcGFYYBs1veUy1BwMDU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 1/2] migration: rework migrate_set_error() to
 migrate_report_err()
Date: Wed, 24 Apr 2024 20:42:44 +0300
Message-Id: <20240424174245.1237942-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
References: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1. Most of callers want to free the error after call. Let's help them.

2. Some callers log the error, some not. We also have places where we
   log the stored error. Let's instead simply log every migration
   error.

3. Some callers have to retrieve current migration state only to pass
   it to migrate_set_error(). In the new helper let's get the state
   automatically.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration.c    | 48 ++++++++++++----------------------------
 migration/migration.h    |  2 +-
 migration/multifd.c      | 18 ++++++---------
 migration/postcopy-ram.c |  3 +--
 migration/savevm.c       | 16 +++++---------
 5 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 696762bc64..806b7b080b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -285,7 +285,7 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
 void migration_cancel(const Error *error)
 {
     if (error) {
-        migrate_set_error(current_migration, error);
+        migrate_report_err(error_copy(error));
     }
     if (migrate_dirty_limit()) {
         qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
@@ -779,13 +779,6 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
-        if (migrate_has_error(s)) {
-            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
-            }
-        }
         error_report("load of migration failed: %s", strerror(-ret));
         goto fail;
     }
@@ -1402,10 +1395,6 @@ static void migrate_fd_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
-    if (s->error) {
-        /* It is used on info migrate.  We can't free it */
-        error_report_err(error_copy(s->error));
-    }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
     migration_call_notifiers(s, type, NULL);
@@ -1418,12 +1407,14 @@ static void migrate_fd_cleanup_bh(void *opaque)
     migrate_fd_cleanup(opaque);
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
+void migrate_report_err(Error *error)
 {
+    MigrationState *s = migrate_get_current();
     QEMU_LOCK_GUARD(&s->error_mutex);
     if (!s->error) {
         s->error = error_copy(error);
     }
+    error_report_err(error);
 }
 
 bool migrate_has_error(MigrationState *s)
@@ -1448,7 +1439,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
     assert(s->to_dst_file == NULL);
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, error);
+    migrate_report_err(error_copy(error));
 }
 
 static void migrate_fd_cancel(MigrationState *s)
@@ -1863,8 +1854,7 @@ void qmp_migrate_pause(Error **errp)
 
         /* Tell the core migration that we're pausing */
         error_setg(&error, "Postcopy migration is paused by the user");
-        migrate_set_error(ms, error);
-        error_free(error);
+        migrate_report_err(error);
 
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
@@ -2413,8 +2403,7 @@ static void *source_return_path_thread(void *opaque)
 
 out:
     if (err) {
-        migrate_set_error(ms, err);
-        error_free(err);
+        migrate_report_err(err);
         trace_source_return_path_thread_bad_end();
     }
 
@@ -2842,12 +2831,10 @@ static void migration_completion(MigrationState *s)
 
 fail:
     if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_report_err(local_err);
     } else if (ret) {
         error_setg_errno(&local_err, -ret, "Error in migration completion");
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_report_err(local_err);
     }
 
     migration_completion_failed(s, current_active_state);
@@ -3070,8 +3057,7 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 
     if (local_error) {
-        migrate_set_error(s, local_error);
-        error_free(local_error);
+        migrate_report_err(local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
@@ -3242,8 +3228,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
         qatomic_read(&s->start_postcopy)) {
         if (postcopy_start(s, &local_err)) {
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
+            migrate_report_err(local_err);
         }
         return MIG_ITERATE_SKIP;
     }
@@ -3487,8 +3472,7 @@ static void *migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto out;
@@ -3613,8 +3597,7 @@ static void *bg_migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         goto fail_setup;
@@ -3723,8 +3706,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
              * It's normally done in migrate_fd_cleanup(), but call it here
              * explicitly.
              */
-            error_report_err(error_copy(s->error));
-        } else {
             migrate_fd_cleanup(s);
         }
         return;
@@ -3794,9 +3775,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     return;
 
 fail:
-    migrate_set_error(s, local_err);
+    migrate_report_err(local_err);
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
-    error_report_err(local_err);
     migrate_fd_cleanup(s);
 }
 
diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26..f9f436c33e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -475,7 +475,7 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
+void migrate_report_err(Error *error);
 bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
diff --git a/migration/multifd.c b/migration/multifd.c
index f317bff077..ce51744054 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -678,7 +678,7 @@ retry:
 }
 
 /* Multifd send side hit an error; remember it and prepare to quit */
-static void multifd_send_set_error(Error *err)
+static void multifd_report_err(Error *err)
 {
     /*
      * We don't want to exit each threads twice.  Depending on where
@@ -692,7 +692,7 @@ static void multifd_send_set_error(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
+        migrate_report_err(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -819,8 +819,7 @@ void multifd_send_shutdown(void)
         Error *local_err = NULL;
 
         if (!multifd_send_cleanup_channel(p, &local_err)) {
-            migrate_set_error(migrate_get_current(), local_err);
-            error_free(local_err);
+            migrate_report_err(local_err);
         }
     }
 
@@ -998,9 +997,8 @@ out:
     if (ret) {
         assert(local_err);
         trace_multifd_send_error(p->id);
-        multifd_send_set_error(local_err);
+        multifd_report_err(local_err);
         multifd_send_kick_main(p);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -1123,14 +1121,13 @@ out:
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_send_set_error(local_err);
+    multifd_report_err(local_err);
     /*
      * For error cases (TLS or non-TLS), IO channel is always freed here
      * rather than when cleanup multifd: since p->c is not set, multifd
      * cleanup code doesn't even know its existence.
      */
     object_unref(OBJECT(ioc));
-    error_free(local_err);
 }
 
 static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
@@ -1214,8 +1211,7 @@ bool multifd_send_setup(void)
     }
 
     if (ret) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
+        migrate_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         return false;
@@ -1287,7 +1283,7 @@ static void multifd_recv_terminate_threads(Error *err)
 
     if (err) {
         MigrationState *s = migrate_get_current();
-        migrate_set_error(s, err);
+        migrate_report_err(error_copy(err));
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index eccff499cb..dff220d529 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1626,8 +1626,7 @@ postcopy_preempt_send_channel_done(MigrationState *s,
                                    QIOChannel *ioc, Error *local_err)
 {
     if (local_err) {
-        migrate_set_error(s, local_err);
-        error_free(local_err);
+        migrate_report_err(local_err);
     } else {
         migration_ioc_register_yank(ioc);
         s->postcopy_qemufile_src = qemu_file_new_output(ioc);
diff --git a/migration/savevm.c b/migration/savevm.c
index 5d200cf42a..839957b5d7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1103,14 +1103,12 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 {
     uint32_t tmp;
-    MigrationState *ms = migrate_get_current();
     Error *local_err = NULL;
 
     if (len > MAX_VM_CMD_PACKAGED_SIZE) {
         error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
                      __func__, len);
-        migrate_set_error(ms, local_err);
-        error_report_err(local_err);
+        migrate_report_err(local_err);
         return -1;
     }
 
@@ -1325,7 +1323,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, ms->vmdesc, errp);
             if (ret) {
-                migrate_set_error(ms, *errp);
+                migrate_report_err(error_copy(*errp));
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1553,8 +1551,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
-            error_report_err(local_err);
+            migrate_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1571,8 +1568,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         if (ret) {
             error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
                        __func__, ret);
-            migrate_set_error(ms, local_err);
-            error_report_err(local_err);
+            migrate_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1768,7 +1764,6 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
-    MigrationState *ms = migrate_get_current();
     Error *local_err = NULL;
     SaveStateEntry *se;
 
@@ -1786,8 +1781,7 @@ int qemu_save_device_state(QEMUFile *f)
         }
         ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
-            migrate_set_error(ms, local_err);
-            error_report_err(local_err);
+            migrate_report_err(local_err);
             return ret;
         }
     }
-- 
2.34.1


