Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F91CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWxt-0000nR-ND; Fri, 06 Sep 2024 07:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxC-0006bn-C5; Fri, 06 Sep 2024 07:16:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWx9-00086r-RK; Fri, 06 Sep 2024 07:16:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E44EB8C494;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E416C1336FE;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353660 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jim Fehlig <jfehlig@suse.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 36/69] migration/multifd: Fix multifd_send_setup
 cleanup when channel creation fails
Date: Fri,  6 Sep 2024 14:12:45 +0300
Message-Id: <20240906111324.353230-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

When a channel fails to create, the code currently just returns. This
is wrong for two reasons:

1) Channel n+1 will not get to initialize it's semaphores, leading to
   an assert when terminate_threads tries to post to it:

 qemu-system-x86_64: ../util/qemu-thread-posix.c:92:
 qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

2) (theoretical) If channel n-1 already started creation it will
   defeat the purpose of the channels_created logic which is in place
   to avoid migrate_fd_cleanup() to run while channels are still being
   created.

   This cannot really happen today because the current failure cases
   for multifd_new_send_channel_create() are all synchronous,
   resulting from qio_channel_file_new_path() getting a bad
   filename. This would hit all channels equally.

   But I don't want to set a trap for future people, so have all
   channels try to create (even if failing), and only fail after the
   channels_created semaphore has been posted.

While here, remove the error_report_err call. There's one already at
migrate_fd_cleanup later on.

Cc: qemu-stable@nongnu.org
Reported-by: Jim Fehlig <jfehlig@suse.com>
Fixes: b7b03eb614 ("migration/multifd: Add outgoing QIOChannelFile support")
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 0bd5b9284fa94a6242a0d27a46380d93e753488b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd.c b/migration/multifd.c
index 2802afe79d..fa55586f89 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1145,7 +1145,6 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
 bool multifd_send_setup(void)
 {
     MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
@@ -1166,6 +1165,7 @@ bool multifd_send_setup(void)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1190,7 +1190,8 @@ bool multifd_send_setup(void)
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
-            return false;
+            migrate_set_error(s, local_err);
+            ret = -1;
         }
     }
 
@@ -1203,24 +1204,27 @@ bool multifd_send_setup(void)
         qemu_sem_wait(&multifd_send_state->channels_created);
     }
 
+    if (ret) {
+        goto err;
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            break;
+            migrate_set_error(s, local_err);
+            goto err;
         }
     }
 
-    if (ret) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
-        return false;
-    }
-
     return true;
+
+err:
+    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_FAILED);
+    return false;
 }
 
 bool multifd_recv(void)
-- 
2.39.2


