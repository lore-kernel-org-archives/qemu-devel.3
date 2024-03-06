Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D36EC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQo-0008JO-Fc; Wed, 06 Mar 2024 08:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQk-0008IX-3D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:34 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQi-0005ZV-38
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYN20v6Nz4wyk;
 Thu,  7 Mar 2024 00:35:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMy6d6Jz4wcF;
 Thu,  7 Mar 2024 00:35:26 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Date: Wed,  6 Mar 2024 14:34:25 +0100
Message-ID: <20240306133441.2351700-11-clg@redhat.com>
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

This prepares ground for the changes coming next which add an Error**
argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
now handle the error and fail earlier setting the migration state from
MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.

In qemu_savevm_state(), move the cleanup to preserve the error
reported by .save_setup() handlers.

Since the previous behavior was to ignore errors at this step of
migration, this change should be examined closely to check that
cleanups are still correctly done.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:
 
 - Merged cleanup change in qemu_savevm_state()
   
 Changes in v3:
 
 - Set migration state to MIGRATION_STATUS_FAILED 
 - Fixed error handling to be done under lock in bg_migration_thread()
 - Made sure an error is always set in case of failure in
   qemu_savevm_state_setup()
   
 migration/savevm.h    |  2 +-
 migration/migration.c | 27 ++++++++++++++++++++++++---
 migration/savevm.c    | 26 +++++++++++++++-----------
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -32,7 +32,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
-void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
+    Error *local_err = NULL;
+    int ret;
 
     thread = migration_threads_add("live_migration", qemu_get_thread_id());
 
@@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_FAILED);
+        goto out;
+     }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
@@ -3530,6 +3540,9 @@ static void *bg_migration_thread(void *opaque)
     MigThrError thr_error;
     QEMUFile *fb;
     bool early_fail = true;
+    bool setup_fail = true;
+    Error *local_err = NULL;
+    int ret;
 
     rcu_register_thread();
     object_ref(OBJECT(s));
@@ -3563,9 +3576,16 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        goto fail;
+    }
     bql_unlock();
 
+    setup_fail = false;
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
@@ -3632,7 +3652,8 @@ static void *bg_migration_thread(void *opaque)
 
 fail:
     if (early_fail) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+        migrate_set_state(&s->state,
+                setup_fail ? MIGRATION_STATUS_SETUP : MIGRATION_STATUS_ACTIVE,
                 MIGRATION_STATUS_FAILED);
         bql_unlock();
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index ee31ffb5e88cea723039c754c30ce2c8a0ef35f3..63fdbb5ad7d4dbfaef1d2094350bf302cc677602 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
-void qemu_savevm_state_setup(QEMUFile *f)
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     MigrationState *ms = migrate_get_current();
     SaveStateEntry *se;
-    Error *local_err = NULL;
     int ret = 0;
 
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
@@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
+            ret = vmstate_save(f, se, ms->vmdesc, errp);
             if (ret) {
-                migrate_set_error(ms, local_err);
-                error_report_err(local_err);
+                migrate_set_error(ms, *errp);
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
         ret = se->ops->save_setup(f, se->opaque);
         save_section_footer(f, se);
         if (ret < 0) {
+            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
+                       "%d(%s): %d", se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
             break;
         }
     }
 
     if (ret) {
-        return;
+        return ret;
     }
 
-    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
-        error_report_err(local_err);
-    }
+    /* TODO: Should we check that errp is set in case of failure ? */
+    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
 }
 
 int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1728,7 +1728,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    qemu_savevm_state_setup(f);
+    ret = qemu_savevm_state_setup(f, errp);
+    if (ret) {
+        goto cleanup;
+    }
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
@@ -1741,10 +1744,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         qemu_savevm_state_complete_precopy(f, false, false);
         ret = qemu_file_get_error(f);
     }
-    qemu_savevm_state_cleanup();
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
+cleanup:
+    qemu_savevm_state_cleanup();
 
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
-- 
2.44.0


