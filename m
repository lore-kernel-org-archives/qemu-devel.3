Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFDBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJr-000219-JN; Tue, 07 Jul 2026 02:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJo-0001lY-Lq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJl-00075t-6y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x34HIOEKH6d6TycJrHe/MKsvH8yiBoVfcWEpa1MSU+4=;
 b=GQ8TIQ28jZLcjc3eliyz1O67p+MmJF67KKkxpXRjSbY0SDBZXAFc4LnYfk26WjDvN/rrJW
 mL6RfQy2Ne86ePYig7AdAM9+gugB/2IbItbIZzMLi9lZDjTpIsLwwPXZeYof5KKUbHsc9T
 /YRdkA5b6AL3aX0llY1z3gkz9rn3Tq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-EUrNoZfNOEqkP6rKzD0cGg-1; Tue,
 07 Jul 2026 02:29:54 -0400
X-MC-Unique: EUrNoZfNOEqkP6rKzD0cGg-1
X-Mimecast-MFC-AGG-ID: EUrNoZfNOEqkP6rKzD0cGg_1783405790
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD6221955DBB; Tue,  7 Jul 2026 06:29:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5163D180067F; Tue,  7 Jul 2026 06:29:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/27] migration: Make switchover-ack re-usable
Date: Tue,  7 Jul 2026 08:29:05 +0200
Message-ID: <20260707062920.317302-13-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Switchover-ack is a mechanism to synchronize between source and
destination QEMU during migration to prevent the source from switching
over prematurely.

VFIO uses switchover-ack to ensure switchover happens only after
destination side has loaded the precopy initial bytes. This is important
for VFIO, as otherwise downtime could be impacted and be higher.

In its current state, switchover-ack is a one-time mechanism, meaning
that switchover is acked only once and past that another ACK cannot be
requested again. This was sufficient until now, as VFIO precopy initial
bytes was defined to be monotonically decreasing. Thus, when precopy
initial bytes reached zero for all VFIO devices, a single ACK would be
sent and its validity would hold.

However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
initial bytes to be re-initialized during precopy. Specifically, it
means that initial bytes can grow after reaching zero, which would
invalidate a previously sent switchover ACK.

To solve this, make switchover-ack reusable and allow devices to request
switchover ACKs when needed via the save_query_pending SaveVMHandler.

Since now switchover ACK can be requested for a specific device and in
different times, make switchover ACK per-device (instead of a single ACK
for all devices) and let source side do the pending ACKs accounting.

Keep the legacy switchover-ack mechanism for backward compatibility and
turn it on by a compatibility property for older machines. Enable the
property until VFIO implements the new switchover-ack.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-8-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 qapi/migration.json                | 14 ++++----
 include/migration/client-options.h |  1 +
 include/migration/register.h       |  2 ++
 migration/migration.h              | 32 ++++++++++++++++--
 migration/savevm.h                 |  6 ++--
 migration/colo.c                   |  2 +-
 migration/migration.c              | 37 ++++++++++++++-------
 migration/options.c                | 10 ++++++
 migration/savevm.c                 | 53 +++++++++++++++++++++++-------
 migration/trace-events             |  5 +--
 10 files changed, 124 insertions(+), 38 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index e8756308cf9610182f75997ab81946f3b03dea63..d2f42c4b0ffd0a9e6bb757b8d105fed89b423537 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -508,14 +508,12 @@
 #     (since 7.1)
 #
 # @switchover-ack: If enabled, migration will not stop the source VM
-#     and complete the migration until an ACK is received from the
-#     destination that it's OK to do so.  Exactly when this ACK is
-#     sent depends on the migrated devices that use this feature.  For
-#     example, a device can use it to make sure some of its data is
-#     sent and loaded in the destination before doing switchover.
-#     This can reduce downtime if devices that support this capability
-#     are present.  'return-path' capability must be enabled to use
-#     it.  (since 8.1)
+#     and complete the migration until the destination has
+#     acknowledged that it is OK to switchover.  The acknowledgement
+#     may depend, for example, on some device's data being loaded in
+#     the destination before doing switchover.  This can reduce
+#     downtime if devices that support this capability are present.
+#     Capability @return-path must be enabled to use it.  (since 8.1)
 #
 # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
 #     keep their dirty page rate within @vcpu-dirty-limit.  This can
diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 289c9d776221ce3cf35d86f91ce3313fd79427d3..78b1daa1a615ceb601da5dc8914f4fb5fe04f8a9 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -13,6 +13,7 @@
 
 /* properties */
 bool migrate_send_switchover_start(void);
+bool migrate_switchover_ack_legacy(void);
 
 /* capabilities */
 
diff --git a/include/migration/register.h b/include/migration/register.h
index a61c4236d22423a8477876971f1d73fe2e802f4a..5825eb30cb33e1721bec399f8a1c01df154d143b 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -23,6 +23,8 @@ typedef struct MigPendingData {
     uint64_t postcopy_bytes;
     /* Amount of pending bytes can be transferred only in stopcopy */
     uint64_t stopcopy_bytes;
+    /* Number of new pending switchover ACKs */
+    uint32_t switchover_ack_pending;
     /*
      * Total pending data, modules do not need to update this field, it
      * will be automatically calculated by migration core API.
diff --git a/migration/migration.h b/migration/migration.h
index 570349d8581354bda30f5a37ccddf5476ec518ce..44bce199cd8c3518998ad7204d599566d1ef9ddd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -487,6 +487,29 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    /*
+     * This decides whether to use legacy switchover-ack or new switchover-ack.
+     * The main difference between them is that the former allows acknowledging
+     * switchover only once while the latter multiple times.
+     *
+     * In legacy, the destination keeps track of a pending ACKs counter. As
+     * migration progresses, the devices on the destination acknowledge
+     * switchover, decreasing the counter. When the counter reaches zero, a
+     * single ACK message is sent to the source via the return path, indicating
+     * that it's OK to switchover.
+     *
+     * In new switchover-ack, the source is the one that keeps track of a
+     * pending ACKs counter. As migration progresses, the destination sends ACK
+     * message per-device via the return path, which decrements the source
+     * counter. When the counter reaches zero, it's OK to switchover. During
+     * precopy, source-side devices may request additional ACKs, which increment
+     * the counter again.
+     *
+     * In both legacy and new schemes, we rely on per-device protocol to request
+     * switchover ACK from the destination-side counterpart.
+     */
+    bool switchover_ack_legacy;
+
     /*
      * This save hostname when out-going migration starts
      */
@@ -496,10 +519,13 @@ struct MigrationState {
     JSONWriter *vmdesc;
 
     /*
-     * Indicates whether an ACK from the destination that it's OK to do
-     * switchover has been received.
+     * Indicates the number of pending ACKs from the destination. The value may
+     * increase or decrease during precopy as new ACKs are requested or
+     * received. When zero is reached, it's OK to switchover. In legacy
+     * switchover-ack, it's initialized to 1 and decreased to zero upon ACK.
      */
-    bool switchover_acked;
+    uint32_t switchover_ack_pending_num;
+
     /* Is this a rdma migration */
     bool rdma_migration;
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 44424be347494c51e6976749d7c60d27ca7f0628..fb92d3bc8586553c490eb03d68be3cb56c8d0554 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,8 +45,10 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
-void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
-void qemu_savevm_query_pending_final(MigPendingData *pending);
+void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
+                                    bool exact);
+void qemu_savevm_query_pending_final(MigrationState *s,
+                                     MigPendingData *pending);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/colo.c b/migration/colo.c
index 08632d5e4ad0d05de386ecf0af42f648fa24ecf5..0cef0f6b0e650500496f51f49b2149154166a90f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -473,7 +473,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * state is saved. Unlike a regular switchover, COLO reaches completion
      * repeatedly for every checkpoint, so this must be done on each one.
      */
-    qemu_savevm_query_pending_final(&pending);
+    qemu_savevm_query_pending_final(s, &pending);
 
     /*
      * Only save VM's live state, which not including device state.
diff --git a/migration/migration.c b/migration/migration.c
index 1d3387da0f4d5c64d64e8afb25af38ea143dad32..2b625da114dbfbbc8f77a359d896eb4b8c10378e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1713,7 +1713,9 @@ int migrate_init(MigrationState *s, Error **errp)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
-    s->switchover_acked = false;
+    /* Legacy switchover-ack sends a single ACK for all devices */
+    qatomic_set(&s->switchover_ack_pending_num,
+                migrate_switchover_ack_legacy() ? 1 : 0);
     s->rdma_migration = false;
 
     /*
@@ -2207,7 +2209,7 @@ void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return;
     }
 
@@ -2463,9 +2465,18 @@ static void *source_return_path_thread(void *opaque)
             break;
 
         case MIG_RP_MSG_SWITCHOVER_ACK:
-            ms->switchover_acked = true;
-            trace_source_return_path_thread_switchover_acked();
+        {
+            uint32_t pending_num;
+
+            pending_num = qatomic_dec_fetch(&ms->switchover_ack_pending_num);
+            trace_source_return_path_thread_switchover_acked(pending_num);
+            if (pending_num == UINT32_MAX) {
+                error_setg(&err, "Switchover ack pending num underflowed");
+                goto out;
+            }
+
             break;
+        }
 
         default:
             break;
@@ -2822,7 +2833,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
      * properly update all the dirty bitmaps to finally generate the
      * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
      */
-    qemu_savevm_query_pending_final(&pending);
+    qemu_savevm_query_pending_final(s, &pending);
 
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
@@ -3272,7 +3283,7 @@ static bool migration_can_switchover(MigrationState *s)
         return true;
     }
 
-    return s->switchover_acked;
+    return qatomic_read(&s->switchover_ack_pending_num) == 0;
 }
 
 /* Migration thread iteration status */
@@ -3311,12 +3322,13 @@ static bool migration_iteration_next_ready(MigrationState *s,
     return false;
 }
 
-static void migration_iteration_go_next(MigPendingData *pending)
+static void migration_iteration_go_next(MigrationState *s,
+                                        MigPendingData *pending)
 {
     /*
      * Do a slow sync first before boosting the iteration count.
      */
-    qemu_savevm_query_pending_iter(pending, true);
+    qemu_savevm_query_pending_iter(s, pending, true);
 
     /*
      * Update the dirty information for the whole system for this
@@ -3362,12 +3374,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    bool can_switchover = migration_can_switchover(s);
+    bool can_switchover;
     MigPendingData pending = { };
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_query_pending_iter(&pending, false);
+    qemu_savevm_query_pending_iter(s, &pending, false);
 
     if (in_postcopy) {
         /*
@@ -3408,9 +3420,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * during postcopy phase.
          */
         if (migration_iteration_next_ready(s, &pending)) {
-            migration_iteration_go_next(&pending);
+            migration_iteration_go_next(s, &pending);
         }
 
+        /* Check can switchover after qemu_savevm_query_pending() */
+        can_switchover = migration_can_switchover(s);
+
         /* Should we switch to postcopy now? */
         if (can_switchover && postcopy_should_start(s, &pending)) {
             if (postcopy_start(s, &local_err)) {
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099ba69f8826cc57a0e9cb43ed68b3bf2..4c9b25372e03b55ee9127c027c5d4eefba796b06 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -110,6 +110,9 @@ const Property migration_properties[] = {
                      preempt_pre_7_2, false),
     DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
                      multifd_clean_tls_termination, true),
+    /* Use legacy until VFIO implements new switchover-ack */
+    DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
+                     switchover_ack_legacy, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
@@ -467,6 +470,13 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
+bool migrate_switchover_ack_legacy(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->switchover_ack_legacy;
+}
+
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
diff --git a/migration/savevm.c b/migration/savevm.c
index 804c76e3bd93d6b4433df12d524a803491b0aa08..1f6e696c50d189370a311c25d8eb092bc41c2b24 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     return 0;
 }
 
-static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
+static void qemu_savevm_query_pending(MigrationState *s,
+                                      MigPendingData *pending, bool exact,
                                       bool final)
 {
     SaveStateEntry *se;
@@ -1827,22 +1828,35 @@ static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
      * close to reality when this got invoked frequently while iterating.
      */
     mig_stats.dirty_bytes_total = pending->total_bytes;
-    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
-                                    pending->stopcopy_bytes,
-                                    pending->postcopy_bytes,
-                                    pending->total_bytes);
+
+    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
+        pending->switchover_ack_pending) {
+        /*
+         * NOTE: Currently we rely on per-device protocol to request switchover
+         * ACK from the device on the destination side.
+         */
+        qatomic_add(&s->switchover_ack_pending_num,
+                    pending->switchover_ack_pending);
+    }
+
+    trace_qemu_savevm_query_pending(
+        exact, final, pending->precopy_bytes, pending->stopcopy_bytes,
+        pending->postcopy_bytes, pending->total_bytes,
+        pending->switchover_ack_pending,
+        qatomic_read(&s->switchover_ack_pending_num));
 }
 
-void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
+void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
+                                    bool exact)
 {
-    qemu_savevm_query_pending(pending, exact, false);
+    qemu_savevm_query_pending(s, pending, exact, false);
 }
 
-void qemu_savevm_query_pending_final(MigPendingData *pending)
+void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *pending)
 {
     g_assert(bql_locked());
 
-    qemu_savevm_query_pending(pending, true, true);
+    qemu_savevm_query_pending(s, pending, true, true);
 }
 
 void qemu_savevm_state_cleanup(void)
@@ -2487,7 +2501,7 @@ static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
 {
     int ret;
 
-    if (!migrate_switchover_ack()) {
+    if (!migrate_switchover_ack() || !migrate_switchover_ack_legacy()) {
         return 0;
     }
 
@@ -3169,7 +3183,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_loadvm_approve_switchover(const char *approver)
+static int qemu_loadvm_approve_switchover_legacy(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -3188,6 +3202,23 @@ int qemu_loadvm_approve_switchover(const char *approver)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+int qemu_loadvm_approve_switchover(const char *approver)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!migrate_switchover_ack()) {
+        return 0;
+    }
+
+    if (migrate_switchover_ack_legacy()) {
+        return qemu_loadvm_approve_switchover_legacy(approver);
+    }
+
+    trace_loadvm_approve_switchover(approver);
+
+    return migrate_send_rp_switchover_ack(mis);
+}
+
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp)
 {
diff --git a/migration/trace-events b/migration/trace-events
index a6b8c31ee1d3eddc59798d7a9b97d2718814e1cb..f5339f4193d20d2a15abf713eeb2869df7149b4d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
+qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total, uint32_t switchover_ack_pending, uint32_t total_switchover_ack_pending) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64", collected switchover ack pending=%"PRIu32", total switchover ack pending=%"PRIu32
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -24,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s:
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
 loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
+loadvm_approve_switchover(const char *approver) "Approver %s"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -189,7 +190,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
-source_return_path_thread_switchover_acked(void) ""
+source_return_path_thread_switchover_acked(uint32_t pending_num) "switchover_ack_pending_num %" PRIu32
 source_return_path_thread_postcopy_package_loaded(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
-- 
2.54.0


