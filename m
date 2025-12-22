Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C50E6749B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXeP3-00013O-6z; Mon, 22 Dec 2025 06:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vXeP1-00012s-EZ
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 06:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vXeOz-0000qZ-9b
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 06:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766404115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5iYbn/0XxocowR0oOgYABsE7jXSB7pI6TxEI3yNlBJQ=;
 b=fFO1jqT2Z/bsVczZ2pPyLoeI9/9gKWpaMOk8Z/8cWBtrkVS/P96WwgDtv+jUC7CnAfi2Vf
 mHQdaYSisznePVyGNspTBTTUXP/Hi9FvVwhnyAJNcirZxI7WDfbphQQOtxBWIukl5pTYee
 HdlSuxUkfKiAt7upSeY+sVyuSVE3Krk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-LywDk2s9N5qbDl16YcnP_g-1; Mon,
 22 Dec 2025 06:48:32 -0500
X-MC-Unique: LywDk2s9N5qbDl16YcnP_g-1
X-Mimecast-MFC-AGG-ID: LywDk2s9N5qbDl16YcnP_g_1766404111
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3E4A1956095; Mon, 22 Dec 2025 11:48:30 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.80.71])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3DDE180049F; Mon, 22 Dec 2025 11:48:27 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Date: Mon, 22 Dec 2025 17:18:22 +0530
Message-ID: <20251222114822.327623-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

When migration connection is broken, the QEMU and libvirtd(8)
process on the source side receive TCP connection reset
notification. QEMU sets the migration status to FAILED and
proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
a QMP command to migrate_set_capabilities().

The migration_cleanup() and qmp_migrate_set_capabilities()
calls race with each other. When the latter is invoked first,
since the migration is not running (FAILED), migration
capabilities are reset to false, so during migration_cleanup()
the QEMU process crashes with assertion failure.

  Stack trace of thread 255014:
   #0  __pthread_kill_implementation (libc.so.6 + 0x822e8)
   #1  raise (libc.so.6 + 0x3a73c)
   #2  abort (libc.so.6 + 0x27034)
   #3  __assert_fail_base (libc.so.6 + 0x34090)
   #4  __assert_fail (libc.so.6 + 0x34100)
   #5  yank_unregister_instance (qemu-kvm + 0x8b8280)
   #6  migrate_fd_cleanup (qemu-kvm + 0x3c6308)
   #7  migration_bh_dispatch_bh (qemu-kvm + 0x3c2144)
   #8  aio_bh_poll (qemu-kvm + 0x8ba358)
   #9  aio_dispatch (qemu-kvm + 0x8a0ab4)
   #10 aio_ctx_dispatch (qemu-kvm + 0x8bb180)

Introduce a new migration status FAILING and use it as an
interim status when an error occurs. Once migration_cleanup()
is done, it sets the migration status to FAILED. This helps
to avoid the above race condition and ensuing failure.

Interim status FAILING is set wherever the execution moves
towards migration_cleanup() directly OR via:

  migration_iteration_finish  bg_migration_iteration_finish
  -> migration_bh_schedule    -> migration_bh_schedule
   -> migration_cleanup_bh     -> migration_cleanup_bh
    -> migration_cleanup        -> migration_cleanup
     -> FAILED                   -> FAILED

The migration status finally moves to FAILED and reports an
appropriate error to the user.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c                 | 33 +++++++++++++++------------
 migration/multifd.c                   |  4 ++--
 qapi/migration.json                   |  8 ++++---
 tests/qtest/migration/migration-qmp.c |  3 ++-
 tests/qtest/migration/precopy-tests.c |  5 ++--
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab..5c32bc8fe5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1216,6 +1216,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_WAIT_UNPLUG:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_COLO:
         return true;
     default:
@@ -1351,6 +1352,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1409,6 +1411,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
@@ -1531,6 +1534,9 @@ static void migration_cleanup(MigrationState *s)
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                           MIGRATION_STATUS_CANCELLED);
+    } else if (s->state == MIGRATION_STATUS_FAILING) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
+                          MIGRATION_STATUS_FAILED);
     }
 
     if (s->error) {
@@ -1584,7 +1590,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
-        next = MIGRATION_STATUS_FAILED;
+        next = MIGRATION_STATUS_FAILING;
         break;
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
@@ -1728,6 +1734,7 @@ bool migration_has_failed(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_CANCELLING ||
             s->state == MIGRATION_STATUS_CANCELLED ||
+            s->state == MIGRATION_STATUS_FAILING ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
@@ -2744,7 +2751,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         if (postcopy_preempt_establish_channel(ms)) {
             if (ms->state != MIGRATION_STATUS_CANCELLING) {
                 migrate_set_state(&ms->state, ms->state,
-                                  MIGRATION_STATUS_FAILED);
+                                  MIGRATION_STATUS_FAILING);
             }
             error_setg(errp, "%s: Failed to establish preempt channel",
                        __func__);
@@ -2907,7 +2914,7 @@ fail_closefb:
     qemu_fclose(fb);
 fail:
     if (ms->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
     }
     migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
@@ -3102,7 +3109,7 @@ fail:
     }
 
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
     }
 }
 
@@ -3139,7 +3146,7 @@ static void bg_migration_completion(MigrationState *s)
 
 fail:
     migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILING);
 }
 
 typedef enum MigThrError {
@@ -3341,7 +3348,7 @@ static MigThrError migration_detect_error(MigrationState *s)
          * For precopy (or postcopy with error outside IO, or before dest
          * starts), we fail with no time.
          */
-        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
         trace_migration_thread_file_err();
 
         /* Time to stop the migration, now. */
@@ -3572,7 +3579,7 @@ static void migration_iteration_finish(MigrationState *s)
         migrate_start_colo_process(s);
         s->vm_old_state = RUN_STATE_RUNNING;
         /* Fallthrough */
-    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
         if (!migration_block_activate(&local_err)) {
@@ -3631,7 +3638,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
     case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_FAILING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
         break;
@@ -3821,7 +3828,7 @@ static void *migration_thread(void *opaque)
         migrate_set_error(s, local_err);
         error_free(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+                          MIGRATION_STATUS_FAILING);
         goto out;
     }
 
@@ -3945,8 +3952,6 @@ static void *bg_migration_thread(void *opaque)
     if (ret) {
         migrate_set_error(s, local_err);
         error_free(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
         goto fail_setup;
     }
 
@@ -4008,12 +4013,12 @@ static void *bg_migration_thread(void *opaque)
 
 fail:
     if (early_fail) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                MIGRATION_STATUS_FAILED);
         bql_unlock();
     }
 
 fail_setup:
+    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                        MIGRATION_STATUS_FAILING);
     bg_migration_iteration_finish(s);
 
     qemu_fclose(fb);
@@ -4128,7 +4133,7 @@ void migration_connect(MigrationState *s, Error *error_in)
 fail:
     migrate_set_error(s, local_err);
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
     }
     error_report_err(local_err);
     migration_cleanup(s);
diff --git a/migration/multifd.c b/migration/multifd.c
index 3203dc98e1..970633474e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -434,7 +434,7 @@ static void multifd_send_set_error(Error *err)
             s->state == MIGRATION_STATUS_DEVICE ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
+                              MIGRATION_STATUS_FAILING);
         }
     }
 }
@@ -1001,7 +1001,7 @@ bool multifd_send_setup(void)
 
 err:
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+                      MIGRATION_STATUS_FAILING);
     return false;
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index cf023bd29d..85f4961781 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -158,7 +158,9 @@
 #
 # @completed: migration is finished.
 #
-# @failed: some error occurred during migration process.
+# @failing: error occurred during migration, clean-up underway.
+#
+# @failed: error occurred during migration, clean-up done.
 #
 # @colo: VM is in the process of fault tolerance, VM can not get into
 #     this state unless colo capability is enabled for migration.
@@ -181,8 +183,8 @@
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-device', 'postcopy-active',
             'postcopy-paused', 'postcopy-recover-setup',
-            'postcopy-recover', 'completed', 'failed', 'colo',
-            'pre-switchover', 'device', 'wait-unplug' ] }
+            'postcopy-recover', 'completed', 'failing', 'failed',
+            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
 
 ##
 # @VfioStats:
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index c803fcee9d..ceb40efd56 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -241,7 +241,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     do {
         status = migrate_query_status(from);
         bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
-            (allow_active && !strcmp(status, "active"));
+            (allow_active && !strcmp(status, "active")) ||
+            !strcmp(status, "failing");
         if (!result) {
             fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
                     __func__, status, allow_active);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 57ca623de5..a04442df96 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -807,7 +807,8 @@ static void test_cancel_src_after_status(void *opaque)
     } else if (g_str_equal(phase, "completed")) {
         test_cancel_src_after_complete(from, to, uri, phase);
 
-    } else if (g_str_equal(phase, "failed")) {
+    } else if (g_str_equal(phase, "failing") ||
+               g_str_equal(phase, "failed")) {
         test_cancel_src_after_failed(from, to, uri, phase);
 
     } else if (g_str_equal(phase, "none")) {
@@ -1316,7 +1317,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     }
 
     /* ensure new status don't go unnoticed */
-    assert(MIGRATION_STATUS__MAX == 16);
+    assert(MIGRATION_STATUS__MAX == 17);
 
     for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
         switch (i) {
-- 
2.52.0


