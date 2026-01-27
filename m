Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8A4D2F033
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjhA-00089O-PR; Tue, 27 Jan 2026 09:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjh5-00083o-Up
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjh3-0007QG-Rv
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769522719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgI2iIGYTMzBG+3WYg2+H0hPIP9D8VvWshMQU6D9iDk=;
 b=UWpctH7vXbidlsu8cxcw+/nui/qu0wPwZ/TMGXeE7sjF0rZEhnIS3WBnBMSFq3RWegCWH8
 rPoYxI3KIPC/dZFUS0GA6YFg96JG0acl/JejBJ6yLxepW9cEZyFs5ql6j0QFsaOpxMagwi
 y6D2QMXsI9bme/oVfhlXJRu3jeIUmoM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-K7dgzMoRNoKRp5Zg_X5cvA-1; Tue,
 27 Jan 2026 09:03:50 -0500
X-MC-Unique: K7dgzMoRNoKRp5Zg_X5cvA-1
X-Mimecast-MFC-AGG-ID: K7dgzMoRNoKRp5Zg_X5cvA_1769522630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E7011955D93; Tue, 27 Jan 2026 14:03:49 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88B9F18007D2; Tue, 27 Jan 2026 14:03:47 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/4] migration: Introduce VM_STARTED return-path message
Date: Tue, 27 Jan 2026 15:03:08 +0100
Message-ID: <20260127140316.4187221-3-jmarcin@redhat.com>
In-Reply-To: <20260127140316.4187221-1-jmarcin@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Currently there is no universal way for the destination to tell the
source it has started. In precopy it could be deduced from the RP_SHUT
message and in postcopy from the response to the ping just before the
POSTCOPY_RUN command, but neither method is precise. Moreover, there is
no way to send more data after the destination has started with precopy
migration.

This patch adds new message type to the return-path which tells the
source that the destination VM has just started (or can be started if
autostart is false). Source VM can use this message to precisely
calculate the downtime regardless of if postcopy is used and can also
send more data, for example network packets.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 hw/core/machine.c     |  4 +++-
 migration/migration.c | 34 ++++++++++++++++++++++++++++++----
 migration/migration.h |  9 +++++++++
 migration/options.c   |  8 ++++++++
 migration/options.h   |  1 +
 migration/savevm.c    |  3 +++
 6 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..dc73217a5f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_10_2[] = {};
+GlobalProperty hw_compat_10_2[] = {
+    { "migration", "send-vm-started", "off" },
+};
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
 GlobalProperty hw_compat_10_1[] = {
diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..4871db2365 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -82,6 +82,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
     MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
+    MIG_RP_MSG_VM_STARTED,   /* tell source destination has started */
 
     MIG_RP_MSG_MAX
 };
@@ -750,6 +751,10 @@ static void process_incoming_migration_bh(void *opaque)
         runstate_set(global_state_get_runstate());
     }
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-vm-started");
+    if (mis->to_src_file && migrate_send_vm_started()) {
+        migrate_send_rp_vm_started(mis);
+    }
+
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -996,6 +1001,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
     migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
 }
 
+void migrate_send_rp_vm_started(MigrationIncomingState *mis)
+{
+    migrate_send_rp_message(mis, MIG_RP_MSG_VM_STARTED, 0, NULL);
+}
+
 bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
@@ -1660,6 +1670,9 @@ int migrate_init(MigrationState *s, Error **errp)
     s->postcopy_package_loaded = false;
     qemu_event_reset(&s->postcopy_package_loaded_event);
 
+    s->dest_vm_started = false;
+    qemu_event_reset(&s->dest_vm_started_event);
+
     return 0;
 }
 
@@ -2368,6 +2381,12 @@ static void *source_return_path_thread(void *opaque)
             trace_source_return_path_thread_switchover_acked();
             break;
 
+        case MIG_RP_MSG_VM_STARTED:
+            migration_downtime_end(ms);
+            ms->dest_vm_started = true;
+            qemu_event_set(&ms->dest_vm_started_event);
+            break;
+
         default:
             break;
         }
@@ -2591,7 +2610,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
 
-    migration_downtime_end(ms);
+    if (!ms->rp_state.rp_thread_created || !migrate_send_vm_started()) {
+        migration_downtime_end(ms);
+    }
 
     if (migrate_postcopy_ram()) {
         /*
@@ -3086,7 +3107,9 @@ static void migration_completion_end(MigrationState *s)
      * - correct ordering of s->mbps update vs. s->state;
      */
     bql_lock();
-    migration_downtime_end(s);
+    if (!s->rp_state.rp_thread_created || !migrate_send_vm_started()) {
+        migration_downtime_end(s);
+    }
     s->total_time = end_time - s->start_time;
     transfer_time = s->total_time - s->setup_time;
     if (transfer_time) {
@@ -3300,9 +3323,10 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        if (!migration_block_activate(&local_err)) {
+        if (s->dest_vm_started || !migration_block_activate(&local_err)) {
             /*
-            * Re-activate the block drives if they're inactivated.
+            * Re-activate the block drives if they're inactivated and the dest
+            * vm has not reported that it has started.
             *
             * If it fails (e.g. in case of a split brain, where dest QEMU
             * might have taken some of the drive locks and running!), do
@@ -3853,6 +3877,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
     qemu_event_destroy(&ms->postcopy_package_loaded_event);
+    qemu_event_destroy(&ms->dest_vm_started_event);
 }
 
 static void migration_instance_init(Object *obj)
@@ -3875,6 +3900,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
     qemu_event_init(&ms->postcopy_package_loaded_event, 0);
+    qemu_event_init(&ms->dest_vm_started_event, false);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..a3fab4f27e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -522,6 +522,14 @@ struct MigrationState {
      * anything as input.
      */
     bool has_block_bitmap_mapping;
+
+    /*
+     * Do send VM_START message on the return-path when dest VM finishes
+     * loading device state and switches out of INMIGRATE run state.
+     */
+    bool send_vm_started;
+    bool dest_vm_started;
+    QemuEvent dest_vm_started_event;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
@@ -564,6 +572,7 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
+void migrate_send_rp_vm_started(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/options.c b/migration/options.c
index 1ffe85a2d8..a5a233183b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -108,6 +108,7 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
+    DEFINE_PROP_BOOL("send-vm-started", MigrationState, send_vm_started, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
@@ -434,6 +435,13 @@ bool migrate_zero_copy_send(void)
     return s->capabilities[MIGRATION_CAPABILITY_ZERO_COPY_SEND];
 }
 
+bool migrate_send_vm_started(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->send_vm_started;
+}
+
 /* pseudo capabilities */
 
 bool migrate_multifd_flush_after_each_section(void)
diff --git a/migration/options.h b/migration/options.h
index b502871097..5fdc8fc6fe 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -42,6 +42,7 @@ bool migrate_return_path(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_copy_send(void);
+bool migrate_send_vm_started(void);
 
 /*
  * pseudo capabilities
diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bb..1020094fc8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2157,6 +2157,9 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     }
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+    if (mis->to_src_file && migrate_send_vm_started()) {
+        migrate_send_rp_vm_started(mis);
+    }
 }
 
 /* After all discards we can start running and asking for pages */
-- 
2.52.0


