Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3712DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJi-0001Kw-5f; Tue, 07 Jul 2026 02:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJV-0001AL-O8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJU-0006iY-2o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npsqq4Bw+tGFasRkCLKdQlk2D7kcYHLMY3VKU8/dnj8=;
 b=Tv44swsW2y1be7NV22DLYBQZC1z8YHY4AQH3RYFMk/eqbRDW4nDt6XCatFJlpIZ+fw4H5s
 JLUsMvfxskgF7tbOX7EFRdvFnCEkkLRQpKC561dFWNExzgrgfC5l56MFioh5MqXjmkvZmP
 zRwzYov42nQtBeB3qiHyzi7pl1Ob0t0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-Mdi-DAOWNeiVnblXIOOELA-1; Tue,
 07 Jul 2026 02:29:41 -0400
X-MC-Unique: Mdi-DAOWNeiVnblXIOOELA-1
X-Mimecast-MFC-AGG-ID: Mdi-DAOWNeiVnblXIOOELA_1783405779
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3966C1954B07; Tue,  7 Jul 2026 06:29:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D733180065F; Tue,  7 Jul 2026 06:29:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/27] migration: Propagate errors in
 migration_completion_precopy()
Date: Tue,  7 Jul 2026 08:28:59 +0200
Message-ID: <20260707062920.317302-7-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

migration_completion_precopy() doesn't propagate errors to migration
core which leads to error information loss. Fix that.

This prepares for a follow-up where migration_switchover_start() can
fail on switchover-ack and still report a useful error.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-2-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c | 13 ++++++++-----
 migration/savevm.c    | 29 +++++++++++++++++------------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4ef6f7fd174f50e8c1402f0b6d6b9e1f..b6bb4fa977fae84ed121b0668cdefdf49e3d9c67 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(MigrationState *s);
+int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 0f56432d903054883679a66ac5bd853577b5df66..7e0a0bea7ae823ee5ef6e7ba8876c9222f9ac834 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2820,7 +2820,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
     return true;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static int migration_completion_precopy(MigrationState *s, Error **errp)
 {
     int ret;
 
@@ -2829,16 +2829,17 @@ static int migration_completion_precopy(MigrationState *s)
     if (!migrate_mode_is_cpr()) {
         ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to stop the VM");
             goto out_unlock;
         }
     }
 
-    if (!migration_switchover_start(s, NULL)) {
+    if (!migration_switchover_start(s, errp)) {
         ret = -EFAULT;
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s);
+    ret = qemu_savevm_state_complete_precopy(s, errp);
 out_unlock:
     bql_unlock();
     return ret;
@@ -2875,7 +2876,7 @@ static void migration_completion(MigrationState *s)
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s);
+        ret = migration_completion_precopy(s, &local_err);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
@@ -2906,7 +2907,9 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
+    if (local_err) {
+        migrate_error_propagate(s, local_err);
+    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
         migrate_error_propagate(s, local_err);
     } else if (ret) {
         error_setg_errno(&local_err, -ret, "Error in migration completion");
diff --git a/migration/savevm.c b/migration/savevm.c
index 23adaf9dd9263b8dafe808f0637724fe4a5482b2..7e2a0c2b4a7470d9c2159eac1d18ae891740fe3e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1771,28 +1771,34 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(MigrationState *s)
+int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f = s->to_dst_file;
-    Error *local_err = NULL;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
     if (ret) {
+        qemu_file_get_error_obj(f, errp);
+        error_prepend(errp, "Failed to save iterable device state: ");
         return ret;
     }
 
-    /* TODO: pass error upper */
-    ret = qemu_savevm_state_non_iterable(f, &local_err);
+    ret = qemu_savevm_state_non_iterable(f, errp);
     if (ret) {
-        migrate_error_propagate(s, error_copy(local_err));
-        error_report_err(local_err);
         return ret;
     }
 
     qemu_savevm_state_end_precopy(s, f);
 
-    return qemu_fflush(f);
+    ret = qemu_fflush(f);
+    if (ret) {
+        qemu_file_get_error_obj(f, errp);
+        error_prepend(errp, "Failed to flush QEMUFile: ");
+        return ret;
+    }
+
+    return 0;
 }
 
 void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
@@ -1874,13 +1880,12 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     ret = qemu_file_get_error(f);
-    if (ret == 0) {
-        qemu_savevm_state_complete_precopy(ms);
-        ret = qemu_file_get_error(f);
-    }
-    if (ret != 0) {
+    if (ret) {
         error_setg_errno(errp, -ret, "Error while writing VM state");
+        goto cleanup;
     }
+
+    ret = qemu_savevm_state_complete_precopy(ms, errp);
 cleanup:
     qemu_savevm_state_cleanup();
 
-- 
2.54.0


