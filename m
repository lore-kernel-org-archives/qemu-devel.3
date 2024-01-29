Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ACEC47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHxF-0004Y2-Bu; Sun, 28 Jan 2024 22:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHxE-0004Xi-4b
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:05:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHxC-0002eS-7c
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOekGLZ5Iux9C2j66vk+K55gh9tnpRlnKIjN6UkLCzo=;
 b=DGAMz5uWLk19wDT3onhiA+Sgxf/F7Pt88k6/yxZCj5EpJZ6vLiDozRqRoRUr8nVi4rXIg/
 qEn8nBauNtHvMDu6Jvb7OgNhCPhIMPKcZheUEGon7Jew1KWXYHu4toGokvV9/RcD4aAv5J
 mMi4RTmBaoeh10y/0eazzxnHgpKLFTY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-JnNmj2h-OISwatzyQqMptw-1; Sun,
 28 Jan 2024 22:04:54 -0500
X-MC-Unique: JnNmj2h-OISwatzyQqMptw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D459229AC011;
 Mon, 29 Jan 2024 03:04:53 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C21291121306;
 Mon, 29 Jan 2024 03:04:51 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 13/14] migration: Centralize BH creation and dispatch
Date: Mon, 29 Jan 2024 11:04:04 +0800
Message-ID: <20240129030405.177100-14-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Now that the migration state reference counting is correct, further
wrap the bottom half dispatch process to avoid future issues.

Move BH creation and scheduling together and wrap the dispatch with an
intermediary function that will ensure we always keep the ref/unref
balanced.

Also move the responsibility of deleting the BH into the wrapper and
remove the now unnecessary pointers.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-6-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  5 +---
 migration/migration.c | 65 +++++++++++++++++++++++++------------------
 migration/savevm.c    |  7 +----
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index a589ae8650..f2c8b8f286 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -159,8 +159,6 @@ struct MigrationIncomingState {
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
     GArray   *postcopy_remote_fds;
 
-    QEMUBH *bh;
-
     int state;
 
     /*
@@ -255,8 +253,6 @@ struct MigrationState {
 
     /*< public >*/
     QemuThread thread;
-    QEMUBH *vm_start_bh;
-    QEMUBH *cleanup_bh;
     /* Protected by qemu_file_lock */
     QEMUFile *to_dst_file;
     /* Postcopy specific transfer channel */
@@ -528,6 +524,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
+void migration_bh_schedule(QEMUBHFunc *cb, void *opaque);
 void migration_cancel(const Error *error);
 
 void migration_populate_vfio_info(MigrationInfo *info);
diff --git a/migration/migration.c b/migration/migration.c
index 0e7f101d64..d5f705ceef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -199,8 +199,39 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
-static void migration_bh_schedule(MigrationState *s, QEMUBH *bh)
+typedef struct {
+    QEMUBH *bh;
+    QEMUBHFunc *cb;
+    void *opaque;
+} MigrationBH;
+
+static void migration_bh_dispatch_bh(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
+    MigrationBH *migbh = opaque;
+
+    /* cleanup this BH */
+    qemu_bh_delete(migbh->bh);
+    migbh->bh = NULL;
+
+    /* dispatch the other one */
+    migbh->cb(migbh->opaque);
+    object_unref(OBJECT(s));
+
+    g_free(migbh);
+}
+
+void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
+{
+    MigrationState *s = migrate_get_current();
+    MigrationBH *migbh = g_new0(MigrationBH, 1);
+    QEMUBH *bh = qemu_bh_new(migration_bh_dispatch_bh, migbh);
+
+    /* Store these to dispatch when the BH runs */
+    migbh->bh = bh;
+    migbh->cb = cb;
+    migbh->opaque = opaque;
+
     /*
      * Ref the state for bh, because it may be called when
      * there're already no other refs
@@ -656,9 +687,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COMPLETED);
-    qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
-    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -723,8 +752,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
-    migration_bh_schedule(migrate_get_current(), mis->bh);
+    migration_bh_schedule(process_incoming_migration_bh, mis);
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1285,9 +1313,6 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
-    qemu_bh_delete(s->cleanup_bh);
-    s->cleanup_bh = NULL;
-
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1343,9 +1368,7 @@ static void migrate_fd_cleanup(MigrationState *s)
 
 static void migrate_fd_cleanup_bh(void *opaque)
 {
-    MigrationState *s = opaque;
-    migrate_fd_cleanup(s);
-    object_unref(OBJECT(s));
+    migrate_fd_cleanup(opaque);
 }
 
 void migrate_set_error(MigrationState *s, const Error *error)
@@ -1568,8 +1591,6 @@ int migrate_init(MigrationState *s, Error **errp)
      * parameters/capabilities that the user set, and
      * locks.
      */
-    s->cleanup_bh = 0;
-    s->vm_start_bh = 0;
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
     s->rp_state.from_dst_file = NULL;
@@ -3139,7 +3160,8 @@ static void migration_iteration_finish(MigrationState *s)
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
-    migration_bh_schedule(s, s->cleanup_bh);
+
+    migration_bh_schedule(migrate_fd_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3170,7 +3192,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migration_bh_schedule(s, s->cleanup_bh);
+    migration_bh_schedule(migrate_fd_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3376,12 +3398,8 @@ static void bg_migration_vm_start_bh(void *opaque)
 {
     MigrationState *s = opaque;
 
-    qemu_bh_delete(s->vm_start_bh);
-    s->vm_start_bh = NULL;
-
     vm_resume(s->vm_old_state);
     migration_downtime_end(s);
-    object_unref(OBJECT(s));
 }
 
 /**
@@ -3485,8 +3503,7 @@ static void *bg_migration_thread(void *opaque)
      * calling VM state change notifiers from vm_start() would initiate
      * writes to virtio VQs memory which is in write-protected region.
      */
-    s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
-    migration_bh_schedule(s, s->vm_start_bh);
+    migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
 
     while (migration_is_active(s)) {
@@ -3542,12 +3559,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     migrate_error_free(s);
 
     s->expected_downtime = migrate_downtime_limit();
-    if (resume) {
-        assert(s->cleanup_bh);
-    } else {
-        assert(!s->cleanup_bh);
-        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup_bh, s);
-    }
     if (error_in) {
         migrate_fd_error(s, error_in);
         if (resume) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 93387350c7..d612c8a902 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2171,10 +2171,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         runstate_set(RUN_STATE_PAUSED);
     }
 
-    qemu_bh_delete(mis->bh);
-
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
-    object_unref(OBJECT(migration_get_current()));
 }
 
 /* After all discards we can start running and asking for pages */
@@ -2189,9 +2186,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
-    mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
-    object_ref(OBJECT(migration_get_current()));
-    qemu_bh_schedule(mis->bh);
+    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
     /* We need to finish reading the stream from the package
      * and also stop reading anything more from the stream that loaded the
-- 
2.43.0


