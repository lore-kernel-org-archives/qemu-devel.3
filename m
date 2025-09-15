Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B11CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEvk-0001rb-Jd; Mon, 15 Sep 2025 15:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvZ-0001oI-0c; Mon, 15 Sep 2025 15:31:54 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEvC-0001u5-9T; Mon, 15 Sep 2025 15:31:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 286968099A;
 Mon, 15 Sep 2025 22:31:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AVVVql1FrOs0-UIrkraLT; Mon, 15 Sep 2025 22:31:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757964676;
 bh=dSoRpVPRnci8f0kJaoOmL6uYo62KUNPttjNJEMfNbuw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qHr2Kdo0yEkZomNAOUgDbhI2VqvQoolc9e0Fn7HQEdWUXfR3U18SGVsMA349KJApq
 cvra21n8BC0JmXcGfUV7UXOhtq2IaRbzigwvCF66+cV5e7sXsSLY/dEPGmncXrDY5Z
 /tevQfHbwNGEdgiIwwGMH/CGv6xqOLf/G+TEtOH0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
Date: Mon, 15 Sep 2025 22:30:57 +0300
Message-ID: <20250915193105.230085-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915193105.230085-1-vsementsov@yandex-team.ru>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
so let's passthrough the errp.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/colo.c         | 5 ++++-
 migration/migration.c    | 8 +++++---
 migration/postcopy-ram.c | 2 +-
 migration/qemu-file.c    | 4 ++--
 migration/qemu-file.h    | 2 +-
 migration/savevm.c       | 4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837..cf4d71d9ed 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -859,7 +859,10 @@ static void *colo_process_incoming_thread(void *opaque)
      * coroutine, and here we are in the COLO incoming thread, so it is ok to
      * set the fd back to blocked.
      */
-    qemu_file_set_blocking(mis->from_src_file, true);
+    if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
+        error_report_err(local_err);
+        goto out;
+    }
 
     colo_incoming_start_dirty_log();
 
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..e1ac4d73c2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -951,7 +951,7 @@ static void migration_incoming_setup(QEMUFile *f)
 
     assert(!mis->from_src_file);
     mis->from_src_file = f;
-    qemu_file_set_blocking(f, false);
+    qemu_file_set_blocking(f, false, &error_abort);
 }
 
 void migration_incoming_process(void)
@@ -971,7 +971,7 @@ static bool postcopy_try_recover(void)
         /* This should be set already in migration_incoming_setup() */
         assert(mis->from_src_file);
         /* Postcopy has standalone thread to do vm load */
-        qemu_file_set_blocking(mis->from_src_file, true);
+        qemu_file_set_blocking(mis->from_src_file, true, &error_abort);
 
         /* Re-configure the return path */
         mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -4002,7 +4002,9 @@ void migration_connect(MigrationState *s, Error *error_in)
     }
 
     migration_rate_set(rate_limit);
-    qemu_file_set_blocking(s->to_dst_file, true);
+    if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
+        goto fail;
+    }
 
     /*
      * Open the return path. For postcopy, it is used exclusively. For
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e..0172172343 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1909,7 +1909,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
      * The new loading channel has its own threads, so it needs to be
      * blocked too.  It's by default true, just be explicit.
      */
-    qemu_file_set_blocking(file, true);
+    qemu_file_set_blocking(file, true, &error_abort);
     mis->postcopy_qemufile_dst = file;
     qemu_sem_post(&mis->postcopy_qemufile_dst_done);
     trace_postcopy_preempt_new_channel();
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5c6e7ec61..0f4280df21 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -888,9 +888,9 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
  *       both directions, and thus changing the blocking on the main
  *       QEMUFile can also affect the return path.
  */
-void qemu_file_set_blocking(QEMUFile *f, bool block)
+bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp)
 {
-    qio_channel_set_blocking(f->ioc, block, NULL);
+    return qio_channel_set_blocking(f->ioc, block, errp);
 }
 
 /*
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index f5b9f430e0..c13c967167 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -71,7 +71,7 @@ void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 int qemu_fflush(QEMUFile *f);
-void qemu_file_set_blocking(QEMUFile *f, bool block);
+bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296a..abe0547f9b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,7 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * Because we're a thread and not a coroutine we can't yield
      * in qemu_file, and thus we must be blocking now.
      */
-    qemu_file_set_blocking(f, true);
+    qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
     load_res = qemu_loadvm_state_main(f, mis);
@@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     f = mis->from_src_file;
 
     /* And non-blocking again so we don't block in any cleanup */
-    qemu_file_set_blocking(f, false);
+    qemu_file_set_blocking(f, false, &error_fatal);
 
     trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
-- 
2.48.1


