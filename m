Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F9ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7sf-00048y-99; Mon, 15 Sep 2025 08:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sP-00046Y-9c
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sE-0004aa-Jf
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757937594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7vTnrxV4V0xgC6bS9L8wnCdMT60fT69SjLq8DL/rM4=;
 b=P3WPHfD20Pu14WPLd/Ilh6xiur+NXcQf1IvR7T9WBxBDAkfwfeJEC48a537eg+t9irGvKl
 Mzxv+1VwHJY8OHlIb2ZANDpext565jdfZGXF+e/PQchqN7ao4o7dqvrI2VDZkzQvlNLdub
 OQh+oT22ac/90LkNjjWKRXUua6XRDPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-Y16CNe5eMJCZ1dHw3Pme7w-1; Mon,
 15 Sep 2025 07:59:50 -0400
X-MC-Unique: Y16CNe5eMJCZ1dHw3Pme7w-1
X-Mimecast-MFC-AGG-ID: Y16CNe5eMJCZ1dHw3Pme7w_1757937590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63271944F11; Mon, 15 Sep 2025 11:59:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CD2119432AE; Mon, 15 Sep 2025 11:59:46 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Date: Mon, 15 Sep 2025 13:59:14 +0200
Message-ID: <20250915115918.3520735-4-jmarcin@redhat.com>
In-Reply-To: <20250915115918.3520735-1-jmarcin@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, there are two functions that are responsible for cleanup of
the incoming migration state. With successful precopy, it's the main
thread and with successful postcopy it's the listen thread. However, if
postcopy fails during in the device load, both functions will try to do
the cleanup. Moreover, when exit-on-error parameter was added, it was
applied only to precopy.

This patch refactors common cleanup and exiting on error into a helper
function that can be started either from precopy or postcopy, reducing
the duplication. If the listen thread has been started (the postcopy
state is at least LISTENING), the listen thread is responsible for all
cleanup and exiting, otherwise it's the main thread's responsibility.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c | 64 ++++++++++++++++++++++++-------------------
 migration/migration.h |  1 +
 migration/savevm.c    | 48 +++++++++++---------------------
 3 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2c0b3a7229..7222e3de13 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -442,9 +442,19 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
 void migration_incoming_state_destroy(void)
 {
     struct MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyState ps = postcopy_state_get();
 
     multifd_recv_cleanup();
 
+    if (mis->have_listen_thread) {
+        qemu_thread_join(&mis->listen_thread);
+        mis->have_listen_thread = false;
+    }
+
+    if (ps != POSTCOPY_INCOMING_NONE) {
+        postcopy_ram_incoming_cleanup(mis);
+    }
+
     /*
      * RAM state cleanup needs to happen after multifd cleanup, because
      * multifd threads can use some of its states (receivedmap).
@@ -809,6 +819,23 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     cpr_state_close();
 }
 
+void migration_incoming_finish(void)
+{
+    MigrationState *s = migrate_get_current();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    migration_incoming_state_destroy();
+
+    if (migration_has_failed(mis->state) && mis->exit_on_error) {
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
+
+        exit(EXIT_FAILURE);
+    }
+}
+
 static void process_incoming_migration_bh(void *opaque)
 {
     MigrationIncomingState *mis = opaque;
@@ -861,7 +888,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COMPLETED);
-    migration_incoming_state_destroy();
+    migration_incoming_finish();
 }
 
 static void coroutine_fn
@@ -888,23 +915,13 @@ process_incoming_migration_co(void *opaque)
 
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
-    if (ps != POSTCOPY_INCOMING_NONE) {
-        if (ps == POSTCOPY_INCOMING_ADVISE) {
-            /*
-             * Where a migration had postcopy enabled (and thus went to advise)
-             * but managed to complete within the precopy period, we can use
-             * the normal exit.
-             */
-            postcopy_ram_incoming_cleanup(mis);
-        } else if (ret >= 0) {
-            /*
-             * Postcopy was started, cleanup should happen at the end of the
-             * postcopy thread.
-             */
-            trace_process_incoming_migration_co_postcopy_end_main();
-            goto out;
-        }
-        /* Else if something went wrong then just fall out of the normal exit */
+    if (ps >= POSTCOPY_INCOMING_LISTENING) {
+        /*
+         * Postcopy was started, cleanup should happen at the end of the
+         * postcopy thread.
+         */
+        trace_process_incoming_migration_co_postcopy_end_main();
+        goto out;
     }
 
     if (ret < 0) {
@@ -926,16 +943,7 @@ fail:
     migrate_set_error(s, local_err);
     error_free(local_err);
 
-    migration_incoming_state_destroy();
-
-    if (mis->exit_on_error) {
-        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
-            s->error = NULL;
-        }
-
-        exit(EXIT_FAILURE);
-    }
+    migration_incoming_finish();
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
     migrate_incoming_unref_outgoing_state();
diff --git a/migration/migration.h b/migration/migration.h
index 2c2331f40d..67e3318467 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -518,6 +518,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
+void migration_incoming_finish(void);
 
 bool  migration_has_all_channels(void);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296a..d7eb416d48 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
     return 0;
 }
 
+static void postcopy_ram_listen_thread_bh(void *opaque)
+{
+    migration_incoming_finish();
+}
+
 /*
  * Triggered by a postcopy_listen command; this thread takes over reading
  * the input stream, leaving the main thread free to carry on loading the rest
@@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          "bitmaps may be lost, and present migrated dirty "
                          "bitmaps are correctly migrated and valid.",
                          __func__, load_res);
-            load_res = 0; /* prevent further exit() */
         } else {
             error_report("%s: loadvm failed: %d", __func__, load_res);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
+            goto out;
         }
     }
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
+    /*
+     * This looks good, but it's possible that the device loading in the
+     * main thread hasn't finished yet, and so we might not be in 'RUN'
+     * state yet; wait for the end of the main thread.
+     */
+    qemu_event_wait(&mis->main_thread_load_event);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                    MIGRATION_STATUS_COMPLETED);
-    /*
-     * If everything has worked fine, then the main thread has waited
-     * for us to start, and we're the last use of the mis.
-     * (If something broke then qemu will have to exit anyway since it's
-     * got a bad migration state).
-     */
-    bql_lock();
-    migration_incoming_state_destroy();
-    bql_unlock();
 
+out:
     rcu_unregister_thread();
-    mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
     object_unref(OBJECT(migr));
 
+    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);
+
     return NULL;
 }
 
@@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     postcopy_thread_create(mis, &mis->listen_thread,
                            MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
+                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
     trace_loadvm_postcopy_handle_listen("return");
 
     return 0;
-- 
2.51.0


