Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26924CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPM9-0001yl-P5; Mon, 27 Oct 2025 11:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPM5-0001wu-Nh
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPLu-0008NC-SJ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t180PYNalySODgaWYpV7NHiAYPKhiHRd9Vru2Y5LYN0=;
 b=duYo6PkkvGmiLjF843zZI1strkjhb8mHNNio1J82ge8zReX2eLogz9rlbl2u2ocrz8hB54
 1Lf7aRdm/XOiD/ev5pEHOJAIKJM6hGG7Ix7Z6aI6gB5ndH1v/jfMstv7W9u0d9q9c/LgMC
 agsYAJoIPlQHQxqBsFJhWgCqjOmMPCg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-YTB0RVUrPLiUyx-3MlzZmw-1; Mon,
 27 Oct 2025 11:41:40 -0400
X-MC-Unique: YTB0RVUrPLiUyx-3MlzZmw-1
X-Mimecast-MFC-AGG-ID: YTB0RVUrPLiUyx-3MlzZmw_1761579699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56DB618001D6; Mon, 27 Oct 2025 15:41:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.183])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66AFF30001A2; Mon, 27 Oct 2025 15:41:36 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/4] migration: Move postcopy_ram_listen_thread() to
 postcopy-ram.c
Date: Mon, 27 Oct 2025 16:41:09 +0100
Message-ID: <20251027154115.4138677-3-jmarcin@redhat.com>
In-Reply-To: <20251027154115.4138677-1-jmarcin@redhat.com>
References: <20251027154115.4138677-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This patch addresses a TODO about moving postcopy_ram_listen_thread() to
postcopy file. Furthermore, this patch adds a pair of functions,
postcopy_incoming_setup() and postcopy_incoming_cleanup(), which sets up
and cleans the postcopy_ram_incoming state and the listen thread.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c    |   2 +-
 migration/postcopy-ram.c | 144 +++++++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |   3 +
 migration/savevm.c       | 131 +----------------------------------
 4 files changed, 150 insertions(+), 130 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e9acd0f63b..8827884a15 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -892,7 +892,7 @@ process_incoming_migration_co(void *opaque)
              * but managed to complete within the precopy period, we can use
              * the normal exit.
              */
-            postcopy_ram_incoming_cleanup(mis);
+            postcopy_incoming_cleanup(mis);
         } else if (ret >= 0) {
             /*
              * Postcopy was started, cleanup should happen at the end of the
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5471efb4f0..dbbb2dfb78 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2077,3 +2077,147 @@ bool postcopy_is_paused(MigrationStatus status)
     return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
+
+/*
+ * Triggered by a postcopy_listen command; this thread takes over reading
+ * the input stream, leaving the main thread free to carry on loading the rest
+ * of the device state (from RAM).
+ */
+static void *postcopy_listen_thread(void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f = mis->from_src_file;
+    int load_res;
+    MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
+
+    object_ref(OBJECT(migr));
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    qemu_event_set(&mis->thread_sync_event);
+    trace_postcopy_ram_listen_thread_start();
+
+    rcu_register_thread();
+    /*
+     * Because we're a thread and not a coroutine we can't yield
+     * in qemu_file, and thus we must be blocking now.
+     */
+    qemu_file_set_blocking(f, true, &error_fatal);
+
+    /* TODO: sanity check that only postcopiable data will be loaded here */
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
+
+    /*
+     * This is tricky, but, mis->from_src_file can change after it
+     * returns, when postcopy recovery happened. In the future, we may
+     * want a wrapper for the QEMUFile handle.
+     */
+    f = mis->from_src_file;
+
+    /* And non-blocking again so we don't block in any cleanup */
+    qemu_file_set_blocking(f, false, &error_fatal);
+
+    trace_postcopy_ram_listen_thread_exit();
+    if (load_res < 0) {
+        qemu_file_set_error(f, load_res);
+        dirty_bitmap_mig_cancel_incoming();
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
+        {
+            error_report("%s: loadvm failed during postcopy: %d. All states "
+                         "are migrated except dirty bitmaps. Some dirty "
+                         "bitmaps may be lost, and present migrated dirty "
+                         "bitmaps are correctly migrated and valid.",
+                         __func__, load_res);
+            load_res = 0; /* prevent further exit() */
+        } else {
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
+            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                           MIGRATION_STATUS_FAILED);
+        }
+    }
+    if (load_res >= 0) {
+        /*
+         * This looks good, but it's possible that the device loading in the
+         * main thread hasn't finished yet, and so we might not be in 'RUN'
+         * state yet; wait for the end of the main thread.
+         */
+        qemu_event_wait(&mis->main_thread_load_event);
+    }
+    postcopy_incoming_cleanup(mis);
+
+    if (load_res < 0) {
+        /*
+         * If something went wrong then we have a bad state so exit;
+         * depending how far we got it might be possible at this point
+         * to leave the guest running and fire MCEs for pages that never
+         * arrived as a desperate recovery step.
+         */
+        rcu_unregister_thread();
+        exit(EXIT_FAILURE);
+    }
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                   MIGRATION_STATUS_COMPLETED);
+    /*
+     * If everything has worked fine, then the main thread has waited
+     * for us to start, and we're the last use of the mis.
+     * (If something broke then qemu will have to exit anyway since it's
+     * got a bad migration state).
+     */
+    bql_lock();
+    migration_incoming_state_destroy();
+    bql_unlock();
+
+    rcu_unregister_thread();
+    mis->have_listen_thread = false;
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+
+    object_unref(OBJECT(migr));
+
+    return NULL;
+}
+
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
+{
+    /*
+     * Sensitise RAM - can now generate requests for blocks that don't exist
+     * However, at this point the CPU shouldn't be running, and the IO
+     * shouldn't be doing anything yet so don't actually expect requests
+     */
+    if (migrate_postcopy_ram()) {
+        if (postcopy_ram_incoming_setup(mis)) {
+            postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
+            return -1;
+        }
+    }
+
+    trace_loadvm_postcopy_handle_listen("after uffd");
+
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
+        return -1;
+    }
+
+    mis->have_listen_thread = true;
+    postcopy_thread_create(mis, &mis->listen_thread,
+                           MIGRATION_THREAD_DST_LISTEN,
+                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
+
+    return 0;
+}
+
+int postcopy_incoming_cleanup(MigrationIncomingState *mis)
+{
+    int rc = 0;
+
+    if (migrate_postcopy_ram()) {
+        rc = postcopy_ram_incoming_cleanup(mis);
+    }
+
+    return rc;
+}
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ca19433b24..a080dd65a7 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -199,4 +199,7 @@ bool postcopy_is_paused(MigrationStatus status);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
+int postcopy_incoming_cleanup(MigrationIncomingState *mis);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd0..96a2699ca7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2087,112 +2087,6 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
     return 0;
 }
 
-/*
- * Triggered by a postcopy_listen command; this thread takes over reading
- * the input stream, leaving the main thread free to carry on loading the rest
- * of the device state (from RAM).
- * (TODO:This could do with being in a postcopy file - but there again it's
- * just another input loop, not that postcopy specific)
- */
-static void *postcopy_ram_listen_thread(void *opaque)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    QEMUFile *f = mis->from_src_file;
-    int load_res;
-    MigrationState *migr = migrate_get_current();
-    Error *local_err = NULL;
-
-    object_ref(OBJECT(migr));
-
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_event_set(&mis->thread_sync_event);
-    trace_postcopy_ram_listen_thread_start();
-
-    rcu_register_thread();
-    /*
-     * Because we're a thread and not a coroutine we can't yield
-     * in qemu_file, and thus we must be blocking now.
-     */
-    qemu_file_set_blocking(f, true, &error_fatal);
-
-    /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &local_err);
-
-    /*
-     * This is tricky, but, mis->from_src_file can change after it
-     * returns, when postcopy recovery happened. In the future, we may
-     * want a wrapper for the QEMUFile handle.
-     */
-    f = mis->from_src_file;
-
-    /* And non-blocking again so we don't block in any cleanup */
-    qemu_file_set_blocking(f, false, &error_fatal);
-
-    trace_postcopy_ram_listen_thread_exit();
-    if (load_res < 0) {
-        qemu_file_set_error(f, load_res);
-        dirty_bitmap_mig_cancel_incoming();
-        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
-        {
-            error_report("%s: loadvm failed during postcopy: %d. All states "
-                         "are migrated except dirty bitmaps. Some dirty "
-                         "bitmaps may be lost, and present migrated dirty "
-                         "bitmaps are correctly migrated and valid.",
-                         __func__, load_res);
-            load_res = 0; /* prevent further exit() */
-        } else {
-            error_prepend(&local_err,
-                          "loadvm failed during postcopy: %d: ", load_res);
-            migrate_set_error(migr, local_err);
-            error_report_err(local_err);
-            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                           MIGRATION_STATUS_FAILED);
-        }
-    }
-    if (load_res >= 0) {
-        /*
-         * This looks good, but it's possible that the device loading in the
-         * main thread hasn't finished yet, and so we might not be in 'RUN'
-         * state yet; wait for the end of the main thread.
-         */
-        qemu_event_wait(&mis->main_thread_load_event);
-    }
-    postcopy_ram_incoming_cleanup(mis);
-
-    if (load_res < 0) {
-        /*
-         * If something went wrong then we have a bad state so exit;
-         * depending how far we got it might be possible at this point
-         * to leave the guest running and fire MCEs for pages that never
-         * arrived as a desperate recovery step.
-         */
-        rcu_unregister_thread();
-        exit(EXIT_FAILURE);
-    }
-
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                   MIGRATION_STATUS_COMPLETED);
-    /*
-     * If everything has worked fine, then the main thread has waited
-     * for us to start, and we're the last use of the mis.
-     * (If something broke then qemu will have to exit anyway since it's
-     * got a bad migration state).
-     */
-    bql_lock();
-    migration_incoming_state_destroy();
-    bql_unlock();
-
-    rcu_unregister_thread();
-    mis->have_listen_thread = false;
-    postcopy_state_set(POSTCOPY_INCOMING_END);
-
-    object_unref(OBJECT(migr));
-
-    return NULL;
-}
-
 /* After this message we must be able to immediately receive postcopy data */
 static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
                                          Error **errp)
@@ -2218,32 +2112,11 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
 
     trace_loadvm_postcopy_handle_listen("after discard");
 
-    /*
-     * Sensitise RAM - can now generate requests for blocks that don't exist
-     * However, at this point the CPU shouldn't be running, and the IO
-     * shouldn't be doing anything yet so don't actually expect requests
-     */
-    if (migrate_postcopy_ram()) {
-        if (postcopy_ram_incoming_setup(mis)) {
-            postcopy_ram_incoming_cleanup(mis);
-            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
-            return -1;
-        }
-    }
+    int rc = postcopy_incoming_setup(mis, errp);
 
-    trace_loadvm_postcopy_handle_listen("after uffd");
-
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
-        return -1;
-    }
-
-    mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread,
-                           MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-    return 0;
+    return rc;
 }
 
 static void loadvm_postcopy_handle_run_bh(void *opaque)
-- 
2.51.0


