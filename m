Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AF3C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJl-0001X7-VY; Tue, 07 Jul 2026 02:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJX-0001Ad-E9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJU-0006jS-4u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3jh81BNPvEa/25rPIyX5eJlJ4if2rSjEX2dWyFb+AE=;
 b=FhYGBOBzsjOf5rELtEokpyejT5rgtaZ94CLFYvRaINYE7iKaO6FsPyAacEKJJ2IUvC5nqy
 WU48VXePpQ8bCzuJMVDHyMHX0AptIT8i9X+ocXypNDrzhC57SgDSlQEgvlOZF+rqQHI5y8
 /u4c8q6UqbK+NC/dKLFtkGcy2VaTokE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-bkweqyIDNfeGnJ5x1X57_A-1; Tue,
 07 Jul 2026 02:29:44 -0400
X-MC-Unique: bkweqyIDNfeGnJ5x1X57_A-1
X-Mimecast-MFC-AGG-ID: bkweqyIDNfeGnJ5x1X57_A_1783405783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A8FB1954B17; Tue,  7 Jul 2026 06:29:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B88D180065F; Tue,  7 Jul 2026 06:29:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/27] migration: Run final save_query_pending at switchover
Date: Tue,  7 Jul 2026 08:29:01 +0200
Message-ID: <20260707062920.317302-9-clg@redhat.com>
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

Before switchover, the source needs one last exact pending query so
modules can flush dirty state. This is currently done ad hoc in modules
handlers. For example, RAM syncs its dirty bitmap in its save_complete
handler.

This should be a general concept relevant for any module, so extract it
to migration core instead by running a final save_query_pending before
switchover.

The final query requires special handling by modules (e.g., it's called
with BQL locked, during VM stop), so extend save_query_pending
SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
flag so migration modules can tell the last pending query during
switchover from periodic iteration queries.

Call final pending query also in COLO checkpoint, which needs to flush
dirty state before the checkpoint's live state is saved. Unlike a
regular switchover, COLO reaches completion repeatedly for every
checkpoint, so this must be done on each one.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-4-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h   | 41 ++++++++++++++++++----------------
 migration/savevm.h             |  3 ++-
 hw/s390x/s390-stattrib.c       |  2 +-
 hw/vfio/migration.c            | 11 ++++++---
 migration/block-dirty-bitmap.c | 11 ++++++---
 migration/colo.c               | 10 +++++++++
 migration/migration.c          | 14 ++++++++++--
 migration/ram.c                | 40 +++++++++++++++++++--------------
 migration/savevm.c             | 20 +++++++++++++----
 hw/vfio/trace-events           |  2 +-
 migration/trace-events         |  2 +-
 11 files changed, 104 insertions(+), 52 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 5e5e0ee432e537781ce78e84b2ff2d81c33e8f37..6f632123f1d0710de0556e68ba53e068a1e02640 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
      */
     bool (*is_active_iterate)(void *opaque);
 
+    /**
+     * @save_query_pending
+     *
+     * This estimates the remaining data to transfer on the source side.
+     *
+     * When @exact is true, a module must report accurate results.  When
+     * @exact is false, a module may report estimates.
+     *
+     * It's highly recommended that modules implement a faster version of
+     * the query path (for example, by proper caching on the counters) if
+     * an accurate query will be time-consuming.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @pending: pointer to a MigPendingData struct
+     * @exact: set to true for an accurate (slow) query
+     * @final: set to true for the final query during switchover. When final is
+     * true, the query is called with BQL locked. Otherwise, it's called with
+     * BQL unlocked.
+     */
+    void (*save_query_pending)(void *opaque, MigPendingData *pending,
+                               bool exact, bool final);
+
     /* This runs outside the BQL in the migration case, and
      * within the lock in the savevm case.  The callback had better only
      * use data that is local to the migration thread or protected
@@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
      */
     bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
 
-    /**
-     * @save_query_pending
-     *
-     * This estimates the remaining data to transfer on the source side.
-     *
-     * When @exact is true, a module must report accurate results.  When
-     * @exact is false, a module may report estimates.
-     *
-     * It's highly recommended that modules implement a faster version of
-     * the query path (for example, by proper caching on the counters) if
-     * an accurate query will be time-consuming.
-     *
-     * @opaque: data pointer passed to register_savevm_live()
-     * @pending: pointer to a MigPendingData struct
-     * @exact: set to true for an accurate (slow) query
-     */
-    void (*save_query_pending)(void *opaque, MigPendingData *pending,
-                               bool exact);
-
     /**
      * @load_state
      *
diff --git a/migration/savevm.h b/migration/savevm.h
index b6bb4fa977fae84ed121b0668cdefdf49e3d9c67..81abd96dda94c6c95cc40b3c188df23d11c19463 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
-void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
+void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
+void qemu_savevm_query_pending_final(MigPendingData *pending);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c334714b31ab4313e26c0cf57091a8cb21e55306..b0f04eb30c7f73e5dd91b1345d71a14cb404a4eb 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
 }
 
 static void cmma_state_pending(void *opaque, MigPendingData *pending,
-                               bool exact)
+                               bool exact, bool final)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fb12b9717f773fdde657911517de9d74c1eb3931..195498845ed95d6a55cf68537a100b4e83221fb0 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
 }
 
 static void vfio_state_pending(void *opaque, MigPendingData *pending,
-                               bool exact)
+                               bool exact, bool final)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     uint64_t precopy_size, stopcopy_size;
 
-    if (exact) {
+    /*
+     * The final pending query runs during switchover downtime. VFIO does not
+     * need a fresh device pending-data query then to get the latest dirty
+     * data, so avoid the extra work and report the cached counters below.
+     */
+    if (exact && !final) {
         vfio_state_pending_sync(vbasedev);
     }
 
@@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-                             migration->precopy_dirty_size, exact);
+                             migration->precopy_dirty_size, exact, final);
 }
 
 static bool vfio_is_active_iterate(void *opaque)
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7ef3759e5348a6907c0fb3773e2c6cbb0850632e..cba54e25cd50da924e1958bdfc23ce060784b0ac 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 }
 
 static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
-                                       bool exact)
+                                       bool exact, bool final)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms;
     uint64_t pending = 0;
 
-    bql_lock();
+    /* Final pending query is called with BQL locked */
+    if (!final) {
+        bql_lock();
+    }
 
     QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
@@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
         pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
     }
 
-    bql_unlock();
+    if (!final) {
+        bql_unlock();
+    }
 
     trace_dirty_bitmap_state_pending(pending);
 
diff --git a/migration/colo.c b/migration/colo.c
index 2d36f933cf155c1084565162294a61d32e28fe86..08632d5e4ad0d05de386ecf0af42f648fa24ecf5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -409,6 +409,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
                                           QEMUFile *fb)
 {
     Error *local_err = NULL;
+    MigPendingData pending = {};
     int ret = -1;
 
     colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
@@ -465,6 +466,15 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     if (migrate_auto_converge()) {
         mig_throttle_counter_reset();
     }
+
+    /*
+     * Run the final pending query so migration modules can flush their dirty
+     * state (e.g., RAM syncs its dirty bitmap) before this checkpoint's live
+     * state is saved. Unlike a regular switchover, COLO reaches completion
+     * repeatedly for every checkpoint, so this must be done on each one.
+     */
+    qemu_savevm_query_pending_final(&pending);
+
     /*
      * Only save VM's live state, which not including device state.
      * TODO: We may need a timeout mechanism to prevent COLO process
diff --git a/migration/migration.c b/migration/migration.c
index 7e0a0bea7ae823ee5ef6e7ba8876c9222f9ac834..442f950c43cef47ed23856a16bdda3af5549a5bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2793,12 +2793,22 @@ static bool migration_switchover_prepare(MigrationState *s)
 static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
+    MigPendingData pending = {};
 
     if (!migration_switchover_prepare(s)) {
         error_setg(errp, "Switchover is interrupted");
         return false;
     }
 
+    /*
+     * The final query to the whole system on dirty data to make sure we
+     * collect the latest status of the VM.  For precopy, source QEMU will
+     * dump all the dirty data during switchover.  For postcopy, this will
+     * properly update all the dirty bitmaps to finally generate the
+     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
+     */
+    qemu_savevm_query_pending_final(&pending);
+
     /* Inactivate disks except in COLO */
     if (!migrate_colo()) {
         /*
@@ -3291,7 +3301,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
     /*
      * Do a slow sync first before boosting the iteration count.
      */
-    qemu_savevm_query_pending(pending, true);
+    qemu_savevm_query_pending_iter(pending, true);
 
     /*
      * Update the dirty information for the whole system for this
@@ -3342,7 +3352,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_query_pending(&pending, false);
+    qemu_savevm_query_pending_iter(&pending, false);
 
     if (in_postcopy) {
         /*
diff --git a/migration/ram.c b/migration/ram.c
index 55aa9b47dc8ab8463fd1aeba19726a493b81b070..8918b2f03b6fbcc98532bb45ab905f9bac59384c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
 
     RCU_READ_LOCK_GUARD();
 
-    /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync_precopy(true);
-
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
     rs->last_seen_block = NULL;
@@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
-        if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(true);
-        }
-
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -3442,25 +3435,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     return qemu_fflush(f);
 }
 
-static void ram_state_pending(void *opaque, MigPendingData *pending,
-                              bool exact)
+static void ram_state_pending_sync(bool exact, bool final)
 {
-    RAMState **temp = opaque;
-    RAMState *rs = *temp;
-    uint64_t remaining_size;
-
     /*
      * Sync is not needed either with: (1) a fast query, or (2) after
      * postcopy has started (no new dirty will generate anymore).
      */
-    if (exact && !migration_in_postcopy()) {
+    if (!exact || migration_in_postcopy()) {
+        return;
+    }
+
+    /* Final pending query is called with BQL locked */
+    if (!final) {
         bql_lock();
-        WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(false);
-        }
+    }
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        migration_bitmap_sync_precopy(final);
+    }
+
+    if (!final) {
         bql_unlock();
     }
+}
+
+static void ram_state_pending(void *opaque, MigPendingData *pending,
+                              bool exact, bool final)
+{
+    RAMState **temp = opaque;
+    RAMState *rs = *temp;
+    uint64_t remaining_size;
 
+    ram_state_pending_sync(exact, final);
     remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
 
     if (migrate_postcopy_ram()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 7e2a0c2b4a7470d9c2159eac1d18ae891740fe3e..74d622583e345bdc96b9189aad0c8f6bad41964d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     return 0;
 }
 
-void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
+static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
+                                      bool final)
 {
     SaveStateEntry *se;
 
@@ -1814,7 +1815,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
         if (!qemu_savevm_state_active(se)) {
             continue;
         }
-        se->ops->save_query_pending(se->opaque, pending, exact);
+        se->ops->save_query_pending(se->opaque, pending, exact, final);
     }
 
     pending->total_bytes = pending->precopy_bytes +
@@ -1826,13 +1827,24 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
      * close to reality when this got invoked frequently while iterating.
      */
     mig_stats.dirty_bytes_total = pending->total_bytes;
-
-    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
+    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
                                     pending->stopcopy_bytes,
                                     pending->postcopy_bytes,
                                     pending->total_bytes);
 }
 
+void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
+{
+    qemu_savevm_query_pending(pending, exact, false);
+}
+
+void qemu_savevm_query_pending_final(MigPendingData *pending)
+{
+    g_assert(bql_locked());
+
+    qemu_savevm_query_pending(pending, true, true);
+}
+
 void qemu_savevm_state_cleanup(void)
 {
     SaveStateEntry *se;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 4c28b3291cc687c06490bdd090f393b67c9c4d88..fa2204f002970c31eb987ae13113a9a5edb3e172 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
-vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
+vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 
diff --git a/migration/trace-events b/migration/trace-events
index de99d976abc637e9361f8467daacf3cc8787976f..1c9212d3e20555902f008e4c999f32642cc8fa48 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
+qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.54.0


