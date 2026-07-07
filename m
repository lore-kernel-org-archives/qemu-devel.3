Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C29C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJw-0002NK-Q5; Tue, 07 Jul 2026 02:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJu-0002Bo-ET
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJr-0007Bk-Po
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux4Zx6CrlDPxpVtI0bDiKKaSEwHrXHcs532LFmuX6oQ=;
 b=MqV1Z24c2KXFJ60usmmbMTeAM+cLI2DJQg3s0nz7JCuZkvxcKcfLzxZu8vVjkdt0Rr8906
 8asOGYZnFYodK8eGrvsDSeRBUDHqn30AGRW+ZZjomV6qAYHrn9scoOxSAKOdVZ+bZHoxJQ
 /eumGdOtlAoHqY/NNSmmdzbU7vcd0w4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-8nfOB6ioOUydLRei3r57GA-1; Tue,
 07 Jul 2026 02:30:06 -0400
X-MC-Unique: 8nfOB6ioOUydLRei3r57GA-1
X-Mimecast-MFC-AGG-ID: 8nfOB6ioOUydLRei3r57GA_1783405805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C702C1954ADC; Tue,  7 Jul 2026 06:30:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 949BA180065F; Tue,  7 Jul 2026 06:30:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/27] migration: Refactor migration_completion_precopy() to
 return bool
Date: Tue,  7 Jul 2026 08:29:13 +0200
Message-ID: <20260707062920.317302-21-clg@redhat.com>
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

migration_completion_precopy() reports its error through the Error
**errp argument, so its int return value carries no information beyond
success/failure. Convert it to return a bool, matching the common
convention.

Convert its underlying helper qemu_savevm_state_complete_precopy()
likewise, and in turn qemu_savevm_state_non_iterable(), which it calls.
Adjust all callers accordingly.

Refactor and clean migration_completion() code too, which no longer
needs to track int return values.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-16-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h    |  4 ++--
 migration/migration.c | 35 ++++++++++++++---------------------
 migration/savevm.c    | 32 +++++++++++++++-----------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 415198423f578049c209a1e40b796cfe63b410f0..f7dcdd7d1b6b7b5397eb1b6aab5cb5816a92f1a8 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
+bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *pending,
                                     bool exact);
 bool qemu_savevm_query_pending_final(MigrationState *s,
@@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(const char *approver);
-int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
+bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
                                          Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 98603ee19c34531d069400d1ab0ed36b65bb228e..7d5acd93c32393c9611731ab153b23f4bbc826a3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2659,8 +2659,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_non_iterable(fb, errp);
-    if (ret) {
+    if (!qemu_savevm_state_non_iterable(fb, errp)) {
         error_prepend(errp, "Postcopy save non-iterable states failed: ");
         goto fail_closefb;
     }
@@ -2858,22 +2857,22 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s, Error **errp)
+static bool migration_completion_precopy(MigrationState *s, Error **errp)
 {
-    int ret;
+    bool ret = false;
 
     bql_lock();
 
     if (!migrate_mode_is_cpr()) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "Failed to stop the VM");
+        int r = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+
+        if (r < 0) {
+            error_setg_errno(errp, -r, "Failed to stop the VM");
             goto out_unlock;
         }
     }
 
     if (!migration_switchover_start(s, errp)) {
-        ret = -EFAULT;
         goto out_unlock;
     }
 
@@ -2910,18 +2909,17 @@ static void migration_completion_postcopy(MigrationState *s)
  */
 static void migration_completion(MigrationState *s)
 {
-    int ret = 0;
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s, &local_err);
+        if (!migration_completion_precopy(s, &local_err)) {
+            goto fail;
+        }
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
-        ret = -1;
-    }
-
-    if (ret < 0) {
+        error_setg(&local_err, "Unexpected migration completion status %s",
+                   MigrationStatus_str(s->state));
         goto fail;
     }
 
@@ -2945,12 +2943,7 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (local_err) {
-        migrate_error_propagate(s, local_err);
-    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
-        migrate_error_propagate(s, local_err);
-    } else if (ret) {
-        error_setg_errno(&local_err, -ret, "Error in migration completion");
+    if (local_err || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
         migrate_error_propagate(s, local_err);
     }
 
@@ -3863,7 +3856,7 @@ static void *bg_migration_thread(void *opaque)
         goto fail_with_bql;
     }
 
-    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
+    if (!qemu_savevm_state_non_iterable(fb, &local_err)) {
         error_prepend(&local_err, "Failed to save non-iterable devices ");
         goto fail_with_bql;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index f654a1c563df40d546e42018a3706e92fb11cfa7..bbb8d2b47c6452b228c67cbbdaacc7c333985be7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1737,13 +1737,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
+bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    int ret;
 
     /* Making sure cpu states are synchronized before saving non-iterable */
     cpu_synchronize_all_states();
@@ -1756,9 +1755,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc, errp);
-        if (ret) {
-            return ret;
+        if (vmstate_save(f, se, vmdesc, errp) < 0) {
+            return false;
         }
 
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
@@ -1768,10 +1766,10 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
-    return 0;
+    return true;
 }
 
-int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
+bool qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
 {
     ERRP_GUARD();
     QEMUFile *f = s->to_dst_file;
@@ -1781,12 +1779,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     if (ret) {
         qemu_file_get_error_obj(f, errp);
         error_prepend(errp, "Failed to save iterable device state: ");
-        return ret;
+        return false;
     }
 
-    ret = qemu_savevm_state_non_iterable(f, errp);
-    if (ret) {
-        return ret;
+    if (!qemu_savevm_state_non_iterable(f, errp)) {
+        return false;
     }
 
     qemu_savevm_state_end_precopy(s, f);
@@ -1795,10 +1792,10 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
     if (ret) {
         qemu_file_get_error_obj(f, errp);
         error_prepend(errp, "Failed to flush QEMUFile: ");
-        return ret;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static void qemu_savevm_query_pending(MigrationState *s,
@@ -1928,7 +1925,9 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         goto cleanup;
     }
 
-    ret = qemu_savevm_state_complete_precopy(ms, errp);
+    if (!qemu_savevm_state_complete_precopy(ms, errp)) {
+        ret = -1;
+    }
 cleanup:
     qemu_savevm_state_cleanup();
 
@@ -1962,9 +1961,8 @@ int qemu_save_device_state(QEMUFile *f, Error **errp)
         return ret;
     }
 
-    ret = qemu_savevm_state_non_iterable(f, errp);
-    if (ret) {
-        return ret;
+    if (!qemu_savevm_state_non_iterable(f, errp)) {
+        return -1;
     }
 
     qemu_savevm_state_end(f);
-- 
2.54.0


