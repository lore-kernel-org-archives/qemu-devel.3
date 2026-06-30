Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A049AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ8L-0006hb-UX; Tue, 30 Jun 2026 00:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8K-0006h3-FN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ8I-00031O-Jn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeNN+iJ5I7pcWcESTEyrwg305vGtmCWXpBihy6UJjmk=;
 b=V28kDw60v3ToM8YX8N+NaURxIzfzkXvPsj7BPr1c3XQIAnc1y29rO4w09V6KU2Sto0a06G
 a1kxbHrt9N5yshnsNt82+owJterqLdyjYk24OEuWobyyCC2odqDrmKD+TLjBoBz/Zso5LX
 bKaVdQQ4+AopruQ3GJ3Ks7QCMCHCRSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-VUyb61nXNSKgMi16yCg_KQ-1; Tue,
 30 Jun 2026 00:31:33 -0400
X-MC-Unique: VUyb61nXNSKgMi16yCg_KQ-1
X-Mimecast-MFC-AGG-ID: VUyb61nXNSKgMi16yCg_KQ_1782793892
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDEDF1956051; Tue, 30 Jun 2026 04:31:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43FD51956042; Tue, 30 Jun 2026 04:31:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/23] migration: Replace switchover_ack_needed SaveVMHandler
Date: Tue, 30 Jun 2026 06:30:54 +0200
Message-ID: <20260630043107.1511076-11-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

A new switchover-ack mechanism that will replace the existing one will
be added in the following patches. The new mechanism will not use
switchover_ack_needed SaveVMHandler, however, the old mechanism must
still be kept for backward compatibility.

To keep things clear and decrease API surface of old code, replace
switchover_ack_needed SaveVMHandler with a regular function
migration_request_switchover_ack().

No functional changes intended.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-6-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst |  3 ---
 include/migration/misc.h      |  2 ++
 include/migration/register.h  | 13 -------------
 hw/vfio/migration.c           | 18 ++++++++++--------
 migration/migration.c         | 15 +++++++++++++++
 migration/savevm.c            | 21 ---------------------
 migration/trace-events        |  2 +-
 7 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 691061d1820453a09df479f020abf0aab5fbabfd..854277b11ce64672f998ce1728bf8b5ddf1c129a 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -59,9 +59,6 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``save_live_iterate`` function that reads the VFIO device's data from the
   vendor driver during iterative pre-copy phase.
 
-* A ``switchover_ack_needed`` function that checks if the VFIO device uses
-  "switchover-ack" migration capability when this capability is enabled.
-
 * A ``switchover_start`` function that in the multifd mode starts a thread that
   reassembles the multifd received data and loads it in-order into the device.
   In the non-multifd mode this function is a NOP.
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c3c9aa3c1642ebd5ea4c43aef0675d0..a2219c981b07eca8a79287367e6f808d73b7af6d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -156,4 +156,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
+void migration_request_switchover_ack(const char *requester);
+
 #endif
diff --git a/include/migration/register.h b/include/migration/register.h
index 6f632123f1d0710de0556e68ba53e068a1e02640..a61c4236d22423a8477876971f1d73fe2e802f4a 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -302,19 +302,6 @@ typedef struct SaveVMHandlers {
      */
     int (*resume_prepare)(MigrationState *s, void *opaque);
 
-    /**
-     * @switchover_ack_needed
-     *
-     * Checks if switchover ack should be used. Called only on
-     * destination.
-     *
-     * @opaque: data pointer passed to register_savevm_live()
-     *
-     * Returns true if switchover ack should be used and false
-     * otherwise
-     */
-    bool (*switchover_ack_needed)(void *opaque);
-
     /**
      * @switchover_start
      *
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 180b316baecb980fbd475b1426726697f340ccc8..7055cfbd3e04bd2b1e95c9be45b879cb0bf06212 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -487,6 +487,14 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
     return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
+static void vfio_request_switchover_ack(VFIODevice *vbasedev)
+{
+    if (vfio_precopy_supported(vbasedev)) {
+        /* Precopy support implies switchover-ack is needed */
+        migration_request_switchover_ack(vbasedev->name);
+    }
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_prepare(void *opaque, Error **errp)
@@ -776,6 +784,8 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
+    vfio_request_switchover_ack(vbasedev);
+
     return 0;
 }
 
@@ -874,13 +884,6 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static bool vfio_switchover_ack_needed(void *opaque)
-{
-    VFIODevice *vbasedev = opaque;
-
-    return vfio_precopy_supported(vbasedev);
-}
-
 static int vfio_switchover_start(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -904,7 +907,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
-    .switchover_ack_needed = vfio_switchover_ack_needed,
     /*
      * Multifd support
      */
diff --git a/migration/migration.c b/migration/migration.c
index ea0b236597087cc005541e1916ceabb229afab4b..4d5e3b7c5ab7ad9ee2a5d0fca2e308b4f23be82e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2196,6 +2196,21 @@ void migration_rp_kick(MigrationState *s)
     qemu_sem_post(&s->rp_state.rp_sem);
 }
 
+/* This is called only on destination side */
+void migration_request_switchover_ack(const char *requester)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!migrate_switchover_ack()) {
+        return;
+    }
+
+    mis->switchover_ack_pending_num++;
+
+    trace_migration_request_switchover_ack(requester,
+                                           mis->switchover_ack_pending_num);
+}
+
 static struct rp_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
diff --git a/migration/savevm.c b/migration/savevm.c
index be81de26160d195488e5fb09a88dc37a7a06a3fe..98639630277b7543db7400ec97d6b009603a03bc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2800,23 +2800,6 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
     return 0;
 }
 
-static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
-{
-    SaveStateEntry *se;
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->switchover_ack_needed) {
-            continue;
-        }
-
-        if (se->ops->switchover_ack_needed(se->opaque)) {
-            mis->switchover_ack_pending_num++;
-        }
-    }
-
-    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
-}
-
 static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
 {
     ERRP_GUARD();
@@ -3078,10 +3061,6 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    if (migrate_switchover_ack()) {
-        qemu_loadvm_state_switchover_ack_needed(mis);
-    }
-
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis, errp);
diff --git a/migration/trace-events b/migration/trace-events
index c0c433744cd33d7e28496831bb8ce93c65670bf5..5955befcc66128b72dfdbc9711e5749f19b9faf8 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -8,7 +8,6 @@ qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
 qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
-loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -199,6 +198,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 migration_call_notifiers(int type) "type=%d"
+migration_request_switchover_ack(const char *requester, unsigned int switchover_ack_pending_num) "Requester %s, switchover_ack_pending_num %u"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.54.0


