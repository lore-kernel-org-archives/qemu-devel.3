Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2E5C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmplj-00029S-68; Wed, 20 Mar 2024 02:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplh-00028l-D9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplf-0001SY-JL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qc8+kwIplriLMJjmvgiN/RV8fauIBBcW/1ePlQepQTY=;
 b=M0kswbUnoce95quUN43nOJKcZN2KdxqphHQqgRY15myXnef0syLMWSZtnO/d6hMW4Ii6Ug
 81fvywBUP/foH5b2/lxnvYEsRelMJumyPp7FpAqB1uDrHTv0qK3cKw1uOLkHQn7CZ7p+Vu
 WJR61GVcs6u6mBOColmeZ07oJNK7hY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-a1u6__2NNqWE7_F6U5Uhkg-1; Wed, 20 Mar 2024 02:49:41 -0400
X-MC-Unique: a1u6__2NNqWE7_F6U5Uhkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C32AA872807;
 Wed, 20 Mar 2024 06:49:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C59331C060A4;
 Wed, 20 Mar 2024 06:49:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 06/14] migration: Add Error** argument to
 qemu_savevm_state_setup()
Date: Wed, 20 Mar 2024 07:49:02 +0100
Message-ID: <20240320064911.545001-7-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

 Changes in v5:
 
 - Removed Fabiano's R-b because of changes 
 - Handled qemu_savevm_state_setup() failures after waiting for
   virtio-net-failover devices to unplug.
   
 migration/savevm.h    |  2 +-
 migration/migration.c | 33 +++++++++++++++++++++++++++++++--
 migration/savevm.c    | 26 +++++++++++++++-----------
 3 files changed, 47 insertions(+), 14 deletions(-)

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
index f60bd371e3f896a74df8be4282a15b4280eba732..cd6b6120e31798de9361d02ee43d89989c8d30ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3427,6 +3427,8 @@ static void *migration_thread(void *opaque)
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
+    Error *local_err = NULL;
+    int ret;
 
     thread = migration_threads_add("live_migration", qemu_get_thread_id());
 
@@ -3470,12 +3472,24 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * Handle SETUP failures after waiting for virtio-net-failover
+     * devices to unplug. This to preserve migration state transitions.
+     */
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto out;
+    }
+
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
@@ -3549,6 +3563,8 @@ static void *bg_migration_thread(void *opaque)
     MigThrError thr_error;
     QEMUFile *fb;
     bool early_fail = true;
+    Error *local_err = NULL;
+    int ret;
 
     rcu_register_thread();
     object_ref(OBJECT(s));
@@ -3582,12 +3598,24 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * Handle SETUP failures after waiting for virtio-net-failover
+     * devices to unplug. This to preserve migration state transitions.
+     */
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto fail_setup;
+    }
+
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
@@ -3656,6 +3684,7 @@ fail:
         bql_unlock();
     }
 
+fail_setup:
     bg_migration_iteration_finish(s);
 
     qemu_fclose(fb);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1a7b5cb78a912c36ae16db703afc90ef2906b61f..0eb94e61f888adba2c0732c2cb701b110814c455 100644
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
@@ -1725,7 +1725,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    qemu_savevm_state_setup(f);
+    ret = qemu_savevm_state_setup(f, errp);
+    if (ret) {
+        goto cleanup;
+    }
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
@@ -1738,10 +1741,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
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


