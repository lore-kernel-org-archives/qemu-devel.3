Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2569C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4Ku-00060M-35; Tue, 27 Feb 2024 15:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1ob-0003SK-1w
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:29 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oL-0001V6-DC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tkljl2ffDz4wyk;
 Wed, 28 Feb 2024 05:04:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkljh5WjMz4wyj;
 Wed, 28 Feb 2024 05:04:08 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/21] migration: Add Error** argument to
 qemu_savevm_state_setup()
Date: Tue, 27 Feb 2024 19:03:29 +0100
Message-ID: <20240227180345.548960-6-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:31 -0500
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
now handle the error and fail earlier. This is a functional change
that should be examined closely.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c | 20 ++++++++++++++++++--
 migration/savevm.c    | 14 +++++++-------
 3 files changed, 26 insertions(+), 10 deletions(-)

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
index 5316bbe6704742e604ae55dc7b47a4e11e73c2a4..c1a62b696f62c0d5aca0505e58bc4dc0ff561fde 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3314,6 +3314,8 @@ static void *migration_thread(void *opaque)
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
+    Error *local_err = NULL;
+    int ret;
 
     thread = migration_threads_add("live_migration", qemu_get_thread_id());
 
@@ -3357,9 +3359,15 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        goto out;
+     }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
@@ -3436,6 +3444,8 @@ static void *bg_migration_thread(void *opaque)
     MigThrError thr_error;
     QEMUFile *fb;
     bool early_fail = true;
+    Error *local_err = NULL;
+    int ret;
 
     rcu_register_thread();
     object_ref(OBJECT(s));
@@ -3469,9 +3479,15 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        goto fail;
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 51876f2ef674bb76c7e7ef96e1119a083883deac..bc168371a31acf85f29f2c284be181250db45df4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1311,11 +1311,10 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
-void qemu_savevm_state_setup(QEMUFile *f)
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     SaveStateEntry *se;
-    Error *local_err = NULL;
     int ret = 0;
 
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
@@ -1351,12 +1350,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
     }
 
     if (ret) {
-        return;
+        return ret;
     }
 
-    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
-        error_report_err(local_err);
-    }
+    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
 }
 
 int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1725,7 +1722,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    qemu_savevm_state_setup(f);
+    ret = qemu_savevm_state_setup(f, errp);
+    if (ret) {
+        return ret;
+    }
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
-- 
2.43.2


