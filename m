Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831DEC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJk-0001QD-DK; Tue, 07 Jul 2026 02:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJa-0001BC-2G
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJX-0006qW-O8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPyeZcZbBYm3wm6QQNUkMGhDrgOnK4aWwTChYaLdlBo=;
 b=AHQW340iTfzDrr6mDp5pdfisqZ4dwxuAsyrrECQrpsXOHsNJWNkb8ody7KaG1FBCTASunu
 NxPBcuN6oNGkayWGPLVeMCoVhsyNG9M/EmNFO3QJh9tCI34NNd1lngUnKI1x3LYeVwQoPw
 jARSqpb/Y6QNcVQteo58fY+cVCehZy8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-g5lPDxkiNgyohj4C8v3bdg-1; Tue,
 07 Jul 2026 02:29:49 -0400
X-MC-Unique: g5lPDxkiNgyohj4C8v3bdg-1
X-Mimecast-MFC-AGG-ID: g5lPDxkiNgyohj4C8v3bdg_1783405788
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D51C31801305; Tue,  7 Jul 2026 06:29:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A3421800678; Tue,  7 Jul 2026 06:29:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/27] migration: Rename switchover-ack code to legacy
Date: Tue,  7 Jul 2026 08:29:04 +0200
Message-ID: <20260707062920.317302-12-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

A new switchover-ack mechanism will be added in the following patches.
However, the old mechanism must still be kept for backward
compatibility.

Rename existing code that will be used only for old switchover-ack
mechanism as legacy. This will help to distinguish legacy code from new
code and make it more readable and easier for removal later when no
longer needed.

No functional change intended.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-7-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h |  2 +-
 migration/migration.h    |  2 +-
 hw/vfio/migration.c      |  6 ++---
 migration/migration.c    |  8 +++----
 migration/savevm.c       | 49 +++++++++++++++++++++++++++-------------
 migration/trace-events   |  4 ++--
 6 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 17b42949d4b68dc3ed9341d254e7ccc69e18735e..2b2fbb59a409a35163b4578cf0d386977d3e5f80 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -159,6 +159,6 @@ bool multifd_device_state_save_thread_should_exit(void);
 void multifd_abort_device_state_save_threads(void);
 bool multifd_join_device_state_save_threads(void);
 
-void migration_request_switchover_ack(const char *requester);
+void migration_request_switchover_ack_legacy(const char *requester);
 
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 293ad60e07bd4dd059ec0e0b5aa2ed2d2ba11d29..570349d8581354bda30f5a37ccddf5476ec518ce 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -246,7 +246,7 @@ struct MigrationIncomingState {
      * zero an ACK that it's OK to do switchover is sent to the source. No lock
      * is needed as this field is updated serially.
      */
-    unsigned int switchover_ack_pending_num;
+    unsigned int switchover_ack_pending_num_legacy;
 
     /* Do exit on incoming migration failure */
     bool exit_on_error;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 7055cfbd3e04bd2b1e95c9be45b879cb0bf06212..6b7acb2fa19d3ee618e73365ca995bbdb4676055 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -487,11 +487,11 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
     return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
-static void vfio_request_switchover_ack(VFIODevice *vbasedev)
+static void vfio_request_switchover_ack_legacy(VFIODevice *vbasedev)
 {
     if (vfio_precopy_supported(vbasedev)) {
         /* Precopy support implies switchover-ack is needed */
-        migration_request_switchover_ack(vbasedev->name);
+        migration_request_switchover_ack_legacy(vbasedev->name);
     }
 }
 
@@ -784,7 +784,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    vfio_request_switchover_ack(vbasedev);
+    vfio_request_switchover_ack_legacy(vbasedev);
 
     return 0;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 9a8d47ba9637eb57ee9f3bc6cfe8f580161fb36c..1d3387da0f4d5c64d64e8afb25af38ea143dad32 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2203,7 +2203,7 @@ void migration_rp_kick(MigrationState *s)
 }
 
 /* This is called only on destination side */
-void migration_request_switchover_ack(const char *requester)
+void migration_request_switchover_ack_legacy(const char *requester)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -2211,10 +2211,10 @@ void migration_request_switchover_ack(const char *requester)
         return;
     }
 
-    mis->switchover_ack_pending_num++;
+    mis->switchover_ack_pending_num_legacy++;
 
-    trace_migration_request_switchover_ack(requester,
-                                           mis->switchover_ack_pending_num);
+    trace_migration_request_switchover_ack_legacy(
+        requester, mis->switchover_ack_pending_num_legacy);
 }
 
 static struct rp_cmd_args {
diff --git a/migration/savevm.c b/migration/savevm.c
index 98639630277b7543db7400ec97d6b009603a03bc..804c76e3bd93d6b4433df12d524a803491b0aa08 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2478,6 +2478,31 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
     return 0;
 }
 
+/*
+ * If legacy switchover-ack is enabled but no device uses it, need to send an
+ * ACK to source that it's OK to switchover.
+ */
+static int loadvm_switchover_ack_no_users_legacy(MigrationIncomingState *mis,
+                                                 Error **errp)
+{
+    int ret;
+
+    if (!migrate_switchover_ack()) {
+        return 0;
+    }
+
+    if (!mis->switchover_ack_pending_num_legacy) {
+        ret = migrate_send_rp_switchover_ack(mis);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Could not send switchover ack RP MSG");
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -2527,18 +2552,9 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
 
-        /*
-         * Switchover ack is enabled but no device uses it, so send an ACK to
-         * source that it's OK to switchover. Do it here, after return path has
-         * been created.
-         */
-        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            ret = migrate_send_rp_switchover_ack(mis);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Could not send switchover ack RP MSG");
-                return ret;
-            }
+        ret = loadvm_switchover_ack_no_users_legacy(mis, errp);
+        if (ret) {
+            return ret;
         }
         return 0;
 
@@ -3157,14 +3173,15 @@ int qemu_loadvm_approve_switchover(const char *approver)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!mis->switchover_ack_pending_num) {
+    if (!mis->switchover_ack_pending_num_legacy) {
         return -EINVAL;
     }
 
-    mis->switchover_ack_pending_num--;
-    trace_loadvm_approve_switchover(approver, mis->switchover_ack_pending_num);
+    mis->switchover_ack_pending_num_legacy--;
+    trace_loadvm_approve_switchover_legacy(
+        approver, mis->switchover_ack_pending_num_legacy);
 
-    if (mis->switchover_ack_pending_num) {
+    if (mis->switchover_ack_pending_num_legacy) {
         return 0;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 5955befcc66128b72dfdbc9711e5749f19b9faf8..a6b8c31ee1d3eddc59798d7a9b97d2718814e1cb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -23,7 +23,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
-loadvm_approve_switchover(const char *approver, unsigned int switchover_ack_pending_num) "Approver %s, switchover_ack_pending_num %u"
+loadvm_approve_switchover_legacy(const char *approver, unsigned int switchover_ack_pending_num_legacy) "Approver %s, switchover_ack_pending_num_legacy %u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -198,7 +198,7 @@ process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
 migration_call_notifiers(int type) "type=%d"
-migration_request_switchover_ack(const char *requester, unsigned int switchover_ack_pending_num) "Requester %s, switchover_ack_pending_num %u"
+migration_request_switchover_ack_legacy(const char *requester, unsigned int switchover_ack_pending_num_legacy) "Requester %s, switchover_ack_pending_num_legacy %u"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.54.0


