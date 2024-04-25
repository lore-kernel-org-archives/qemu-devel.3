Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4FFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 18:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s03eM-0001Wh-JB; Thu, 25 Apr 2024 14:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s03eA-0001Uu-3k
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:16:43 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s03e6-0003zP-EJ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:16:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7E3B860AEE;
 Thu, 25 Apr 2024 21:16:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b58e::1:22])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qFR9v101Pa60-6cUwCaUw; Thu, 25 Apr 2024 21:16:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714068986;
 bh=B0FdPWCGfpPQABb71E9kETJra9abg0Yu2BvemQLsKCk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Qww8qj3FYOIglvPLRho1qfcfQzPyUKDCXTC41lJFiWYlIekdy5evGkag2DAGsSmWO
 wf0viYzTxtIpL/bZodyL1BNijiIPT4JZIyXKZuwlYK5fjJGrBQBo5qio1ils8pKm3V
 9ja8Vg0Rw63TYdbWvIhSeE+ftUsATrV2jXHMOrgE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 3/4] migration: process_incoming_migration_co(): rework
 error reporting
Date: Thu, 25 Apr 2024 21:15:50 +0300
Message-Id: <20240425181551.1465739-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 migration/migration.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0d26db47f7..0b15f7ccf4 100644
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
 
@@ -779,18 +781,12 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
-        if (migrate_has_error(s)) {
-            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
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
 
@@ -801,6 +797,12 @@ fail:
                       MIGRATION_STATUS_FAILED);
     migration_incoming_state_destroy();
 
+    if (migrate_has_error(s)) {
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+        }
+    }
+    error_report_err(local_err);
     exit(EXIT_FAILURE);
 }
 
-- 
2.34.1


