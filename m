Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F1BC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujz9A-0001Nt-Dj; Thu, 07 Aug 2025 07:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8q-0000tI-01
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ujz8n-0002Bs-3p
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754567436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6sPaZ/fmJzfki7bKGVqRai8GtstSj2d3rbzRsMWE8I=;
 b=MF4fjmlUweLFlmy3sYDhi0pvPnLvnHuTOpODnbiWlBr7JB1kT91bN1UQzeQ9liLax/MV30
 aHsRrtGVaTuUZzMlYvX88xVUC4NgUF6Ifz8nOqmlGpOdQFoY4hPEyIjiy56OOS6Oo0J6D3
 RBMORjNkpZRcj/TatjVFxSNuxl9d6L4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-23R8NRaNNteIRVnAvhSiHg-1; Thu,
 07 Aug 2025 07:50:33 -0400
X-MC-Unique: 23R8NRaNNteIRVnAvhSiHg-1
X-Mimecast-MFC-AGG-ID: 23R8NRaNNteIRVnAvhSiHg_1754567432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AE341956095; Thu,  7 Aug 2025 11:50:32 +0000 (UTC)
Received: from fedora (unknown [10.43.3.128])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF4B819560B5; Thu,  7 Aug 2025 11:50:29 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [RFC PATCH 4/4] migration: Introduce postcopy-setup capability and
 state
Date: Thu,  7 Aug 2025 13:49:12 +0200
Message-ID: <20250807114922.1013286-5-jmarcin@redhat.com>
In-Reply-To: <20250807114922.1013286-1-jmarcin@redhat.com>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

During switchover at the start of postcopy the source side sends a
package containing all non-postcopiable device state and a postcopy-run
command and transitions to a "postcopy-active" state. However, if the
destination side fails to load the device states or crashes during this
process, there is currently no way of recovering the source side.

To resolve this problem, this patch adds a new feature that includes a
new "postcopy-setup" state between "device" and "postcopy-active" states
and removes the run postcopy-run command from the package containing all
non-postcopiable device data. During this state, it is guaranteed that
the destination side has not been yet started, and in case of an error,
the source side can be resumed without losing any data.

The destination transitions to "postcopy-active" state only after it
successfully loads all non-postcopiable data included in the package
command and sends a POSTCOPY_RUN_ACK message signalling it can be
started. When the source side receives this ACK message, it finally
transitions to "postcopy-active" state and sends the run command, that
is processed by the listen thread on the destination side and the
destination is started. Postcopy migration then continues as usual.

This feature needs to be enabled with the "postcopy-setup" capability on
both sides before the migration starts, this ensures backwards
compatibility in both directions (migrating from QEMU without this
feature or migrating to QEMU without this feature).

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/migration.c                  | 71 +++++++++++++++++++++++---
 migration/migration.h                  |  7 +++
 migration/options.c                    | 16 ++++++
 migration/options.h                    |  1 +
 migration/postcopy-ram.c               |  7 +++
 migration/savevm.c                     | 51 ++++++++++++++++--
 qapi/migration.json                    | 19 ++++++-
 tests/qtest/migration/postcopy-tests.c | 55 ++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c  |  3 +-
 9 files changed, 217 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8174e811eb..5b3cf57712 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -91,6 +91,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
     MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
+    MIG_RP_MSG_POSTCOPY_RUN_ACK, /* tell source it's OK to send postcopy run */
 
     MIG_RP_MSG_MAX
 };
@@ -896,6 +897,15 @@ process_incoming_migration_co(void *opaque)
              * the normal exit.
              */
             postcopy_ram_incoming_cleanup(mis);
+        } else if (ret < 0 && ps == POSTCOPY_INCOMING_LISTENING &&
+                   mis->state == MIGRATION_STATUS_ACTIVE) {
+            /*
+             * An error happened during postcopy start while we have not yet
+             * acknowledged to be started, wait for listen thread to exit and
+             * then do a normal cleanup.
+             */
+            qemu_thread_join(&mis->listen_thread);
+            postcopy_ram_incoming_cleanup(mis);
         } else if (ret >= 0) {
             /*
              * Postcopy was started, cleanup should happen at the end of the
@@ -1206,6 +1216,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
     migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
 }
 
+int migrate_send_rp_postcopy_run_ack(MigrationIncomingState *mis)
+{
+    return migrate_send_rp_message(mis, MIG_RP_MSG_POSTCOPY_RUN_ACK, 0, NULL);
+}
+
 bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
@@ -1216,6 +1231,7 @@ bool migration_is_running(void)
 
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_SETUP:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1237,6 +1253,7 @@ static bool migration_is_active(void)
     MigrationState *s = current_migration;
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_SETUP ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
@@ -1359,6 +1376,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_POSTCOPY_SETUP:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -1412,6 +1430,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_SETUP:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
@@ -1712,6 +1731,7 @@ bool migration_in_postcopy(void)
     MigrationState *s = migrate_get_current();
 
     switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_SETUP:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
@@ -1725,6 +1745,7 @@ bool migration_in_postcopy(void)
 bool migration_postcopy_is_alive(MigrationStatus state)
 {
     switch (state) {
+    case MIGRATION_STATUS_POSTCOPY_SETUP:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         return true;
@@ -1806,6 +1827,7 @@ int migrate_init(MigrationState *s, Error **errp)
     s->threshold_size = 0;
     s->switchover_acked = false;
     s->rdma_migration = false;
+    s->postcopy_run_acked = false;
     /*
      * set mig_stats memory to zero for a new migration
      */
@@ -2615,6 +2637,10 @@ static void *source_return_path_thread(void *opaque)
             trace_source_return_path_thread_switchover_acked();
             break;
 
+        case MIG_RP_MSG_POSTCOPY_RUN_ACK:
+            ms->postcopy_run_acked = true;
+            break;
+
         default:
             break;
         }
@@ -2808,7 +2834,16 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         qemu_savevm_send_ping(fb, 3);
     }
 
-    qemu_savevm_send_postcopy_run(fb);
+    if (migrate_postcopy_setup()) {
+        /*
+         * EOF mark is necessary for the receiving side to stop reading contents
+         * of the CMD_PACKAGED buffer.
+         */
+        qemu_put_byte(fb, QEMU_VM_EOF);
+        qemu_fflush(fb);
+    } else {
+        qemu_savevm_send_postcopy_run(fb);
+    }
 
     /* <><> end of stuff going into the package */
 
@@ -2835,7 +2870,13 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
 
-    migration_downtime_end(ms);
+    if (!migrate_postcopy_setup()) {
+        /*
+         * With postcopy-setup enabled, POSTCOPY_RUN command is not present in
+         * the package. Downtime will end when the command is actually sent.
+         */
+        migration_downtime_end(ms);
+    }
 
     if (migrate_postcopy_ram()) {
         /*
@@ -2862,8 +2903,13 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
-    /* Now, switchover looks all fine, switching to postcopy-active */
+    /*
+    * Now, switchover looks all fine, switching to either postcopy-setup or
+    * directly postcopy-active depending on capabilities.
+    */
     migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
+                      migrate_postcopy_setup() ?
+                      MIGRATION_STATUS_POSTCOPY_SETUP :
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     bql_unlock();
@@ -3305,8 +3351,8 @@ static MigThrError migration_detect_error(MigrationState *s)
         return postcopy_pause(s);
     } else {
         /*
-         * For precopy (or postcopy with error outside IO), we fail
-         * with no time.
+         * For precopy (or postcopy with error outside IO, or postcopy before
+         * the destination has been started), we fail with no time.
          */
         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
         trace_migration_thread_file_err();
@@ -3441,7 +3487,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
-    bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_SETUP ||
+                        s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
     bool complete_ready;
 
@@ -3491,6 +3538,18 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         complete_ready = can_switchover && (pending_size <= s->threshold_size);
     }
 
+    /*
+     * Destination ACKed POSTCOPY_RUN to be sent, or the migration is going to
+     * end in this iteration, so the destination must start.
+     */
+    if (s->state == MIGRATION_STATUS_POSTCOPY_SETUP &&
+        (s->postcopy_run_acked || complete_ready)) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_SETUP,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+        qemu_savevm_send_postcopy_run(s->to_dst_file);
+        migration_downtime_end(s);
+    }
+
     if (complete_ready) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..fff79f0647 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -509,6 +509,12 @@ struct MigrationState {
     /* Is this a rdma migration */
     bool rdma_migration;
 
+    /*
+     * Indicates whether the destination ACKed loading the device state and is
+     * ready to receive POSTCOPY_RUN command.
+     */
+    bool postcopy_run_acked;
+
     GSource *hup_source;
 };
 
@@ -553,6 +559,7 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
+int migrate_send_rp_postcopy_run_ack(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/options.c b/migration/options.c
index 4e923a2e07..e4541ced6f 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -203,6 +203,7 @@ const Property migration_properties[] = {
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
+    DEFINE_PROP_MIG_CAP("postcopy-setup", MIGRATION_CAPABILITY_POSTCOPY_SETUP),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
@@ -360,6 +361,13 @@ bool migrate_zero_copy_send(void)
     return s->capabilities[MIGRATION_CAPABILITY_ZERO_COPY_SEND];
 }
 
+bool migrate_postcopy_setup(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_SETUP];
+}
+
 /* pseudo capabilities */
 
 bool migrate_multifd_flush_after_each_section(void)
@@ -626,6 +634,14 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_SETUP]) {
+        if (!migrate_postcopy_setup() && migration_is_running()) {
+            error_setg(errp,
+                       "Postcopy-setup cannot be enabled during migration");
+            return false;
+        }
+    }
+
     /*
      * On destination side, check the cases that capability is being set
      * after incoming thread has started.
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..2c5d232d43 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -42,6 +42,7 @@ bool migrate_return_path(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_copy_send(void);
+bool migrate_postcopy_setup(void);
 
 /*
  * pseudo capabilities
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e..6bc16fd2dc 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1393,6 +1393,13 @@ retry:
                                         msg.arg.pagefault.address,
                                         msg.arg.pagefault.feat.ptid);
             if (ret) {
+                if (mis->state == MIGRATION_STATUS_ACTIVE) {
+                    /*
+                     * Not postcopy-active yet, there is no recovery from that,
+                     * exit the thread.
+                     */
+                    break;
+                }
                 /* May be network failure, try to wait for recovery */
                 postcopy_pause_fault_thread(mis);
                 goto retry;
diff --git a/migration/savevm.c b/migration/savevm.c
index d2360be53c..3efe499ff1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
     case MIGRATION_CAPABILITY_MAPPED_RAM:
+    case MIGRATION_CAPABILITY_POSTCOPY_SETUP:
         return true;
     default:
         return false;
@@ -2085,8 +2086,15 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     object_ref(OBJECT(migr));
 
-    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                                   MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    if (!migrate_postcopy_setup()) {
+        /*
+         * If postcopy-setup is enabled, we transition to postcopy-active after
+         * the machine finishes loading CMD_PACKAGED and ACKs to be started.
+         */
+        migrate_set_state(&mis->state,
+                          MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    }
     qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
@@ -2099,6 +2107,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
     load_res = qemu_loadvm_state_main(f, mis);
+    if (load_res < 0 && mis->state != MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        /*
+        * Something happened during device load in the main thread, as we are
+        * not running yet. Don't force exit, the main thread will handle
+        * incoming_state and postcopy_ram_incoming cleanups.
+        */
+        goto out;
+    }
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2150,6 +2166,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
         exit(EXIT_FAILURE);
     }
 
+    if (mis->state != MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        error_report("%s: at this point the destination should have been started already",
+                     __func__);
+    }
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                    MIGRATION_STATUS_COMPLETED);
     /*
@@ -2162,6 +2182,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     migration_incoming_state_destroy();
     bql_unlock();
 
+out:
     rcu_unregister_thread();
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
@@ -2276,6 +2297,13 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
+    if (migrate_postcopy_setup()) {
+        /*
+         * With postcopy-setup enabled POSTCOPY_RUN command is processed by the
+         * listen thread instead of the main thread.
+         */
+        return 0;
+    }
     /* We need to finish reading the stream from the package
      * and also stop reading anything more from the stream that loaded the
      * package (since it's now being read by the listener thread).
@@ -2453,8 +2481,23 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
-
-    return ret;
+    if (ret < 0) {
+        return ret;
+    }
+    if (migrate_postcopy_setup()) {
+        ret = migrate_send_rp_postcopy_run_ack(mis);
+        if (ret < 0) {
+            return ret;
+        }
+        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    }
+    /* We need to finish reading the stream from the package
+     * and also stop reading anything more from the stream that loaded the
+     * package (since it's now being read by the listener thread).
+     * LOADVM_QUIT will quit all the layers of nested loadvm loops.
+     */
+    return LOADVM_QUIT;
 }
 
 /*
diff --git a/qapi/migration.json b/qapi/migration.json
index 2387c21e9c..f1f434613a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -139,6 +139,13 @@
 #
 # @active: in the process of doing migration.
 #
+# @postcopy-setup: Postcopy migration has been initiated, but the
+#     destination is not running yet, as it is processing the contents
+#     of CMD_PACKAGED.  After the destination ACKs to be started, the
+#     source transitions to postcopy-active state and sends
+#     POSTCOPY_RUN command.  Only present if postcopy-setup capability
+#     is enabled.  (Since 10.2)
+#
 # @postcopy-active: like active, but now in postcopy mode.
 #     (since 2.5)
 #
@@ -173,7 +180,7 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'postcopy-paused',
+            'active', 'postcopy-setup', 'postcopy-active', 'postcopy-paused',
             'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
@@ -517,6 +524,14 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @postcopy-setup: If enabled, POSTCOPY_RUN command is not sent at the
+#     end of device states during postcopy switchover, but rather
+#     after the destination side ACKs that it has successfully loaded
+#     the device state and can be started.  Between these two events,
+#     machines are in postcopy-setup state which allows the source
+#     machine to fully recover and resume operation in case of errors.
+#     (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -536,7 +551,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram', 'postcopy-setup'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 3773525843..80ce6320d9 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -27,6 +27,17 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_setup(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_SETUP] = true,
+        }
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -47,6 +58,18 @@ static void test_postcopy_preempt(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_preempt_setup(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_SETUP] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_recovery(void)
 {
     MigrateCommon args = { };
@@ -87,10 +110,13 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
 {
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/setup", test_postcopy_setup);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
                            test_postcopy_preempt);
+        migration_test_add("/migration/postcopy/preempt/setup",
+                           test_postcopy_preempt_setup);
     }
 }
 
@@ -105,6 +131,18 @@ static void test_multifd_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_multifd_postcopy_setup(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_SETUP] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_multifd_postcopy_preempt(void)
 {
     MigrateCommon args = {
@@ -117,6 +155,19 @@ static void test_multifd_postcopy_preempt(void)
     test_postcopy_common(&args);
 }
 
+static void test_multifd_postcopy_preempt_setup(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_SETUP] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -139,8 +190,12 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
 
         migration_test_add("/migration/multifd+postcopy/plain",
                            test_multifd_postcopy);
+        migration_test_add("/migration/multifd+postcopy/setup",
+                           test_multifd_postcopy_setup);
         migration_test_add("/migration/multifd+postcopy/preempt/plain",
                            test_multifd_postcopy_preempt);
+        migration_test_add("/migration/multifd+postcopy/preempt/setup",
+                           test_multifd_postcopy_preempt_setup);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index bb38292550..0e5e949cc3 100644
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
+        case MIGRATION_STATUS_POSTCOPY_SETUP: /* happens too fast */
         case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
         case MIGRATION_STATUS_POSTCOPY_PAUSED:
         case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
-- 
2.50.1


