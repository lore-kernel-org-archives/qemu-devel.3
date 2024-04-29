Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D16C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WT3-00074o-Cy; Mon, 29 Apr 2024 15:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1WT0-000748-9Y
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1WSq-0004y6-0r
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:15:10 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BC10C60CC8;
 Mon, 29 Apr 2024 22:14:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hEWuLX0IkKo0-jRXyXKDB; Mon, 29 Apr 2024 22:14:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714418094;
 bh=EjG01w0ZewrQrMMGogXRmrmdHkTzWdbk9YqLV9bWgLM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=rCk/jeQkkqnvHpzYKB/c4fh+8FRAtZiozAGZWTvNmYJp4UCDNsTvLyxcdkQVpeYva
 Xx+tOUdMs7HtZIXe2wsoKgiUPqfHdJq8GshBc8Zv2Vg2HigP/cmymFRhLGNPUl1guf
 vJYfz6QisK+MCdqbyW5apyFgiHXg66stsfnYrsSk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v5 3/5] migration: process_incoming_migration_co(): fix
 reporting s->error
Date: Mon, 29 Apr 2024 22:14:24 +0300
Message-Id: <20240429191426.2327225-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

It's bad idea to leave critical section with error object freed, but
s->error still set, this theoretically may lead to use-after-free
crash. Let's avoid it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0d26db47f7..58fd5819bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -732,9 +732,19 @@ static void process_incoming_migration_bh(void *opaque)
     migration_incoming_state_destroy();
 }
 
+static void migrate_error_free(MigrationState *s)
+{
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    if (s->error) {
+        error_free(s->error);
+        s->error = NULL;
+    }
+}
+
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
@@ -779,11 +789,9 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
         if (migrate_has_error(s)) {
             WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
+                error_report_err(error_copy(s->error));
             }
         }
         error_report("load of migration failed: %s", strerror(-ret));
@@ -801,6 +809,7 @@ fail:
                       MIGRATION_STATUS_FAILED);
     migration_incoming_state_destroy();
 
+    migrate_error_free(s);
     exit(EXIT_FAILURE);
 }
 
@@ -1433,15 +1442,6 @@ bool migrate_has_error(MigrationState *s)
     return qatomic_read(&s->error);
 }
 
-static void migrate_error_free(MigrationState *s)
-{
-    QEMU_LOCK_GUARD(&s->error_mutex);
-    if (s->error) {
-        error_free(s->error);
-        s->error = NULL;
-    }
-}
-
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
     assert(s->to_dst_file == NULL);
-- 
2.34.1


