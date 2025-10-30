Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B3CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 21:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEaWz-0006qk-Qu; Thu, 30 Oct 2025 17:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWx-0006ok-7n
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWg-0000cg-N8
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761860983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpQ1d9E8ywS7tsGQjPzaihaMRcKLRk5yK7Fv7M8iwJI=;
 b=Uz+HQOTfbExsf30ZEyfIal7mEP6hSewiOsLox0ZZRnR/17JN6xAV/JpZ0uAGEH68kNYKOM
 ken+79waWoS26VpXiKyuLCpRzddOQW4pk0jskmvq4nT6RBMLdl33cm9Z7hF825Ke6lS37j
 UPjKjrOAwFzOSOue69DO78x/ItLexbY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-KU6RiZMQMb-3kVZ643P1Jg-1; Thu,
 30 Oct 2025 17:49:40 -0400
X-MC-Unique: KU6RiZMQMb-3kVZ643P1Jg-1
X-Mimecast-MFC-AGG-ID: KU6RiZMQMb-3kVZ643P1Jg_1761860979
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95C261955F2A; Thu, 30 Oct 2025 21:49:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84F8E1800579; Thu, 30 Oct 2025 21:49:37 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 4/7] migration: Refactor all incoming cleanup info
 migration_incoming_destroy()
Date: Thu, 30 Oct 2025 22:49:08 +0100
Message-ID: <20251030214915.1411860-5-jmarcin@redhat.com>
In-Reply-To: <20251030214915.1411860-1-jmarcin@redhat.com>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, there are two functions that are responsible for calling the
cleanup of the incoming migration state. With successful precopy, it's
the incoming migration coroutine, and with successful postcopy it's the
postcopy listen thread. However, if postcopy fails during in the device
load, both functions will try to do the cleanup.

This patch refactors all cleanup that needs to be done on the incoming
side into a common function and defines a clear boundary, who is
responsible for the cleanup. The incoming migration coroutine is
responsible for calling the cleanup function, unless the listen thread
has been started, in which case the postcopy listen thread runs the
incoming migration cleanup in its BH.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c    | 44 +++++++++-------------------
 migration/migration.h    |  1 +
 migration/postcopy-ram.c | 63 +++++++++++++++++++++-------------------
 migration/trace-events   |  2 +-
 4 files changed, 49 insertions(+), 61 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9a367f717e..637be71bfe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -438,10 +438,15 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
 
 void migration_incoming_state_destroy(void)
 {
-    struct MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyState ps = postcopy_state_get();
 
     multifd_recv_cleanup();
 
+    if (ps != POSTCOPY_INCOMING_NONE) {
+        postcopy_incoming_cleanup(mis);
+    }
+
     /*
      * RAM state cleanup needs to happen after multifd cleanup, because
      * multifd threads can use some of its states (receivedmap).
@@ -866,7 +871,6 @@ process_incoming_migration_co(void *opaque)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
-    PostcopyState ps;
     int ret;
     Error *local_err = NULL;
 
@@ -883,25 +887,14 @@ process_incoming_migration_co(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
-    ps = postcopy_state_get();
-    trace_process_incoming_migration_co_end(ret, ps);
-    if (ps != POSTCOPY_INCOMING_NONE) {
-        if (ps == POSTCOPY_INCOMING_ADVISE) {
-            /*
-             * Where a migration had postcopy enabled (and thus went to advise)
-             * but managed to complete within the precopy period, we can use
-             * the normal exit.
-             */
-            postcopy_incoming_cleanup(mis);
-        } else if (ret >= 0) {
-            /*
-             * Postcopy was started, cleanup should happen at the end of the
-             * postcopy thread.
-             */
-            trace_process_incoming_migration_co_postcopy_end_main();
-            goto out;
-        }
-        /* Else if something went wrong then just fall out of the normal exit */
+    trace_process_incoming_migration_co_end(ret);
+    if (mis->have_listen_thread) {
+        /*
+         * Postcopy was started, cleanup should happen at the end of the
+         * postcopy listen thread.
+         */
+        trace_process_incoming_migration_co_postcopy_end_main();
+        goto out;
     }
 
     if (ret < 0) {
@@ -933,15 +926,6 @@ fail:
         }
 
         exit(EXIT_FAILURE);
-    } else {
-        /*
-         * Report the error here in case that QEMU abruptly exits
-         * when postcopy is enabled.
-         */
-        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
-            s->error = NULL;
-        }
     }
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..4a37f7202c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -254,6 +254,7 @@ struct MigrationIncomingState {
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
 void migration_incoming_transport_cleanup(MigrationIncomingState *mis);
+void migration_incoming_qemu_exit(void);
 /*
  * Functions to work with blocktime context
  */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index b47c955763..48cbb46c27 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2078,6 +2078,24 @@ bool postcopy_is_paused(MigrationStatus status)
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
 
+static void postcopy_listen_thread_bh(void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    migration_incoming_state_destroy();
+
+    if (mis->state == MIGRATION_STATUS_FAILED) {
+        /*
+         * If something went wrong then we have a bad state so exit;
+         * we only could have gotten here if something failed before
+         * POSTCOPY_INCOMING_RUNNING (for example device load), otherwise
+         * postcopy migration would pause inside qemu_loadvm_state_main().
+         * Failing dirty-bitmaps won't fail the whole migration.
+         */
+        exit(1);
+    }
+}
+
 /*
  * Triggered by a postcopy_listen command; this thread takes over reading
  * the input stream, leaving the main thread free to carry on loading the rest
@@ -2131,53 +2149,38 @@ static void *postcopy_listen_thread(void *opaque)
                          "bitmaps are correctly migrated and valid.",
                          __func__, load_res, error_get_pretty(local_err));
             g_clear_pointer(&local_err, error_free);
-            load_res = 0; /* prevent further exit() */
         } else {
+            /*
+             * Something went fatally wrong and we have a bad state, QEMU will
+             * exit depending on if postcopy-exit-on-error is true, but the
+             * migration cannot be recovered.
+             */
             error_prepend(&local_err,
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
             g_clear_pointer(&local_err, error_report_err);
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
-    postcopy_incoming_cleanup(mis);
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
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
+    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
+
     object_unref(OBJECT(migr));
 
     return NULL;
diff --git a/migration/trace-events b/migration/trace-events
index e8edd1fbba..772636f3ac 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -193,7 +193,7 @@ source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
-process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
+process_incoming_migration_co_end(int ret) "ret=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
-- 
2.51.0


