Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9E5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jIV-0003VK-QH; Tue, 30 Apr 2024 04:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIS-0003S2-K7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:08 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIN-0000wX-1J
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3443260D43;
 Tue, 30 Apr 2024 11:57:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id muME9V11IOs0-HgIYQIOv; Tue, 30 Apr 2024 11:57:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714467420;
 bh=eF5pqu4NbY0kHC0LeCZzbmITys8AuXp9CImw7ZvBvYw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OZxeXe22wfTvUF2ABg/BUQb4D3+I1g06zRe2b9iVxCSw5HUrtLarkDdmJ75UCpwZg
 h218FIQhRvqzec/APgbLYHgdcFsuTW42vpA65gfenRbotle4jDacQDaFaQtAXbkjyX
 W0rJ7txiw7yvQ+Z8KthfBf7mGtKnJk1TatBhenJE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v6 4/5] migration: process_incoming_migration_co(): rework
 error reporting
Date: Tue, 30 Apr 2024 11:56:45 +0300
Message-Id: <20240430085646.2359711-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Unify error reporting in the function. This simplifies the following
commit, which will not-exit-on-error behavior variant to the function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b307a4bc59..a9599838e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -735,14 +735,16 @@ static void process_incoming_migration_bh(void *opaque)
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
 
     if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
+        error_setg(&local_err, "Failed to setup decompress threads");
         goto fail;
     }
 
@@ -779,19 +781,12 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
-        if (migrate_has_error(s)) {
-            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
-                s->error = NULL;
-            }
-        }
-        error_report("load of migration failed: %s", strerror(-ret));
+        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
         goto fail;
     }
 
     if (colo_incoming_co() < 0) {
+        error_setg(&local_err, "colo incoming failed");
         goto fail;
     }
 
@@ -800,8 +795,16 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
+    migrate_set_error(s, local_err);
+    error_free(local_err);
+
     migration_incoming_state_destroy();
 
+    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+        error_report_err(s->error);
+        s->error = NULL;
+    }
+
     exit(EXIT_FAILURE);
 }
 
-- 
2.34.1


