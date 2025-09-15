Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D32DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7sx-0004Ce-Hs; Mon, 15 Sep 2025 08:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7se-00049U-51
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sP-0004dl-5p
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757937603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tp5oeg6dvweY9fzo/znq4Z2Pm2mGPwulbHE8Lic6BM=;
 b=FbvuRH4qi7fSAn3xaD8l4qK6pFDOZmkK2nFPl0pIkDARLKs+Roj0yZrG74u9yIoACFHgZY
 fbioMy+34sJdhlB78gEQ9C+rvHryHkdFCI6Tuo7B1RNSyiK+RqfJMKzxKrfrdrHAaxZxqC
 GS/KxBOY71NKyh0cpt3WfoA/cOMXxss=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-mfCfdxoTOguO1-mMIvy6ag-1; Mon,
 15 Sep 2025 07:59:58 -0400
X-MC-Unique: mfCfdxoTOguO1-mMIvy6ag-1
X-Mimecast-MFC-AGG-ID: mfCfdxoTOguO1-mMIvy6ag_1757937597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CF981953946; Mon, 15 Sep 2025 11:59:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC9A319540EB; Mon, 15 Sep 2025 11:59:54 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Date: Mon, 15 Sep 2025 13:59:15 +0200
Message-ID: <20250915115918.3520735-5-jmarcin@redhat.com>
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

Currently, when postcopy starts, the source VM starts switchover and
sends a package containing the state of all non-postcopiable devices.
When the destination loads this package, the switchover is complete and
the destination VM starts. However, if the device state load fails or
the destination side crashes, the source side is already in
POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
up-to-date machine state as the destination has not yet started.

This patch introduces a new POSTCOPY_DEVICE state which is active
while the destination machine is loading the device state, is not yet
running, and the source side can be resumed in case of a migration
failure.

To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
side uses a PONG message that is a response to a PING message processed
just before the POSTCOPY_RUN command that starts the destination VM.
Thus, this change does not require any changes on the destination side
and is effective even with older destination versions.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c                 | 23 ++++++++++++++++++-----
 migration/savevm.h                    |  2 ++
 migration/trace-events                |  1 +
 qapi/migration.json                   |  8 ++++++--
 tests/qtest/migration/precopy-tests.c |  3 ++-
 5 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7222e3de13..e63a7487be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1223,6 +1223,7 @@ bool migration_is_running(void)
 
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1244,6 +1245,7 @@ static bool migration_is_active(void)
     MigrationState *s = current_migration;
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
@@ -1366,6 +1368,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -1419,6 +1422,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
@@ -1719,6 +1723,7 @@ bool migration_in_postcopy(void)
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -2564,6 +2569,11 @@ static void *source_return_path_thread(void *opaque)
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
             qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+                trace_source_return_path_thread_dst_started();
+                migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                                  MIGRATION_STATUS_POSTCOPY_ACTIVE);
+            }
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2814,6 +2824,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
+    qemu_savevm_send_ping(fb, QEMU_VM_PING_PACKAGED_LOADED);
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -2871,7 +2882,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now, switchover looks all fine, switching to postcopy-active */
     migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
-                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      MIGRATION_STATUS_POSTCOPY_DEVICE);
 
     bql_unlock();
 
@@ -3035,7 +3046,8 @@ static void migration_completion(MigrationState *s)
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         ret = migration_completion_precopy(s);
-    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    } else if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
+               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
         ret = -1;
@@ -3311,8 +3323,8 @@ static MigThrError migration_detect_error(MigrationState *s)
         return postcopy_pause(s);
     } else {
         /*
-         * For precopy (or postcopy with error outside IO), we fail
-         * with no time.
+         * For precopy (or postcopy with error outside IO, or before dest
+         * starts), we fail with no time.
          */
         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
         trace_migration_thread_file_err();
@@ -3447,7 +3459,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
-    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
+                        s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
     bool complete_ready;
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c7166..c4de0325eb 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -29,6 +29,8 @@
 #define QEMU_VM_COMMAND              0x08
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
+#define QEMU_VM_PING_PACKAGED_LOADED 0x42
+
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
diff --git a/migration/trace-events b/migration/trace-events
index 706db97def..007b5c407e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -191,6 +191,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_dst_started(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..89a20d858d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,6 +142,10 @@
 # @postcopy-active: like active, but now in postcopy mode.
 #     (since 2.5)
 #
+# @postcopy-device: like postcopy-active, but the destination is still
+#     loading device state and is not running yet.  If migration fails
+#     during this state, the source side will resume.  (since 10.2)
+#
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
 # @postcopy-recover-setup: setup phase for a postcopy recovery
@@ -173,8 +177,8 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'postcopy-paused',
-            'postcopy-recover-setup',
+            'active', 'postcopy-device', 'postcopy-active',
+            'postcopy-paused', 'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
 ##
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index bb38292550..57ca623de5 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -1316,13 +1316,14 @@ void migration_test_add_precopy(MigrationTestEnv *env)
     }
 
     /* ensure new status don't go unnoticed */
-    assert(MIGRATION_STATUS__MAX == 15);
+    assert(MIGRATION_STATUS__MAX == 16);
 
     for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
         switch (i) {
         case MIGRATION_STATUS_DEVICE: /* happens too fast */
         case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
         case MIGRATION_STATUS_COLO: /* no support in tests */
+        case MIGRATION_STATUS_POSTCOPY_DEVICE: /* postcopy can't be cancelled */
         case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
         case MIGRATION_STATUS_POSTCOPY_PAUSED:
         case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
-- 
2.51.0


