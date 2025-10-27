Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C4DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPML-00021b-Ma; Mon, 27 Oct 2025 11:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPMJ-00021Q-FM
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vDPM7-0008PA-Qm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4wCPrB0FE5zMpzTf7Vw06fgxpDTYJ+oLyKltTOfttA=;
 b=f6Z0wii8sU/QQsqsrao1AugDVWvz3i/yvD17jBh+8wxTruKGNJOTBzm5/Gn42jeODCRZCP
 3dBJmPDCBWoN2xFscUsVxV/Osk9GgUwqpVPCOhgQrBIjKuBDq1e6mb1BTA9tSfQXWdeCMz
 HcX27i7WLOvY1iIQsmwks7e1ixGwtw4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-jaSl1Ea2P9mgXCJA87tZXQ-1; Mon,
 27 Oct 2025 11:41:52 -0400
X-MC-Unique: jaSl1Ea2P9mgXCJA87tZXQ-1
X-Mimecast-MFC-AGG-ID: jaSl1Ea2P9mgXCJA87tZXQ_1761579711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA7DC19560B0; Mon, 27 Oct 2025 15:41:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.183])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05D7230001A2; Mon, 27 Oct 2025 15:41:48 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 4/4] migration: Introduce POSTCOPY_DEVICE state
Date: Mon, 27 Oct 2025 16:41:11 +0100
Message-ID: <20251027154115.4138677-5-jmarcin@redhat.com>
In-Reply-To: <20251027154115.4138677-1-jmarcin@redhat.com>
References: <20251027154115.4138677-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Thus, this feature is effective even if the destination side does not
yet support this new state.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c                 | 42 ++++++++++++++++++++++++---
 migration/migration.h                 |  3 ++
 migration/postcopy-ram.c              |  8 +++--
 migration/savevm.c                    |  2 ++
 migration/savevm.h                    |  2 ++
 migration/trace-events                |  1 +
 qapi/migration.json                   |  8 +++--
 tests/qtest/migration/precopy-tests.c |  3 +-
 8 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2cc6327c39..38f1a888a1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1217,6 +1217,7 @@ bool migration_is_running(void)
 
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1238,6 +1239,7 @@ static bool migration_is_active(void)
     MigrationState *s = current_migration;
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
@@ -1360,6 +1362,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -1413,6 +1416,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
@@ -1752,6 +1756,7 @@ bool migration_in_postcopy(void)
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1853,6 +1858,8 @@ int migrate_init(MigrationState *s, Error **errp)
     memset(&mig_stats, 0, sizeof(mig_stats));
     migration_reset_vfio_bytes_transferred();
 
+    s->postcopy_package_loaded = false;
+
     return 0;
 }
 
@@ -2608,6 +2615,11 @@ static void *source_return_path_thread(void *opaque)
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
             qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+                trace_source_return_path_thread_postcopy_package_loaded();
+                ms->postcopy_package_loaded = true;
+                qemu_event_set(&ms->postcopy_package_loaded_event);
+            }
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2853,6 +2865,13 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
+    /*
+     * This ping will tell us that all non-postcopiable device state has been
+     * successfully loaded and the destination is about to start. When response
+     * is received, it will trigger transition from POSTCOPY_DEVICE to
+     * POSTCOPY_ACTIVE state.
+     */
+    qemu_savevm_send_ping(fb, QEMU_VM_PING_PACKAGED_LOADED);
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -2910,7 +2929,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now, switchover looks all fine, switching to postcopy-active */
     migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
-                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                      MIGRATION_STATUS_POSTCOPY_DEVICE);
 
     bql_unlock();
 
@@ -3351,8 +3370,8 @@ static MigThrError migration_detect_error(MigrationState *s)
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
@@ -3487,7 +3506,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
-    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
+                        s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
     bool complete_ready;
 
@@ -3503,6 +3523,18 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * POSTCOPY_ACTIVE it means switchover already happened.
          */
         complete_ready = !pending_size;
+        if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
+            (s->postcopy_package_loaded || complete_ready)) {
+            /*
+             * If package has been loaded, the event is set and we will
+             * immediatelly transition to POSTCOPY_ACTIVE. If we are ready for
+             * completion, we need to wait for destination to load the postcopy
+             * package before actually completing.
+             */
+            qemu_event_wait(&s->postcopy_package_loaded_event);
+            migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
+        }
     } else {
         /*
          * Exact pending reporting is only needed for precopy.  Taking RAM
@@ -4157,6 +4189,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
+    qemu_event_destroy(&ms->postcopy_package_loaded_event);
 }
 
 static void migration_instance_init(Object *obj)
@@ -4178,6 +4211,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
+    qemu_event_init(&ms->postcopy_package_loaded_event, 0);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 9d9e95ae90..050ded9e69 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -511,6 +511,9 @@ struct MigrationState {
     /* Is this a rdma migration */
     bool rdma_migration;
 
+    bool postcopy_package_loaded;
+    QemuEvent postcopy_package_loaded_event;
+
     GSource *hup_source;
 };
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0375366ed0..985b66d1a6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2094,7 +2094,7 @@ static void *postcopy_listen_thread(void *opaque)
     object_ref(OBJECT(migr));
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+                                   MIGRATION_STATUS_POSTCOPY_DEVICE);
     qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
@@ -2140,7 +2140,7 @@ static void *postcopy_listen_thread(void *opaque)
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
             error_report_err(local_err);
-            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+            migrate_set_state(&mis->state, mis->state,
                                            MIGRATION_STATUS_FAILED);
             goto out;
         }
@@ -2152,6 +2152,10 @@ static void *postcopy_listen_thread(void *opaque)
      */
     qemu_event_wait(&mis->main_thread_load_event);
 
+    /*
+     * Device load in the main thread has finished, we should be in
+     * POSTCOPY_ACTIVE now.
+     */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                    MIGRATION_STATUS_COMPLETED);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 27fe815731..209c41c5b6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2169,6 +2169,8 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
         return -1;
     }
 
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
diff --git a/migration/savevm.h b/migration/savevm.h
index c337e3e3d1..125a2507b7 100644
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
index e8edd1fbba..48518a4b2c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -191,6 +191,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_postcopy_package_loaded(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
diff --git a/qapi/migration.json b/qapi/migration.json
index da5b3a4d8c..c22285fd1c 100644
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


