Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD74C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVc7o-00071Q-K8; Thu, 01 Feb 2024 13:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=bR2n=JK=redhat.com=clg@ozlabs.org>)
 id 1rVc7g-0006sx-He
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=bR2n=JK=redhat.com=clg@ozlabs.org>)
 id 1rVc7Z-0000Zy-EG
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TQnxX2x9rz4wcS;
 Fri,  2 Feb 2024 05:49:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQnxV5tNCz4wcM;
 Fri,  2 Feb 2024 05:49:02 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] migration: Fix return-path thread exit
Date: Thu,  1 Feb 2024 19:48:53 +0100
Message-ID: <20240201184853.890471-3-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201184853.890471-1-clg@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=bR2n=JK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In case of error, close_return_path_on_source() can perform a shutdown
to exit the return-path thread.  However, in migrate_fd_cleanup(),
'to_dst_file' is closed before calling close_return_path_on_source()
and the shutdown fails, leaving the source and destination waiting for
an event to occur.

Close the file after calling close_return_path_on_source() so that the
shutdown succeeds and the return-path thread exits.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2c3362235c7651c11d581f3c3639571f1f9636ef..1e0b6acaedc272e8ce26ad40be2c42177f5fd14e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1314,6 +1314,7 @@ void migrate_set_state(int *state, int old_state, int new_state)
 static void migrate_fd_cleanup(MigrationState *s)
 {
     int file_error = 0;
+    QEMUFile *tmp = NULL;
 
     g_free(s->hostname);
     s->hostname = NULL;
@@ -1323,8 +1324,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        QEMUFile *tmp;
-
         trace_migrate_fd_cleanup();
         bql_unlock();
         if (s->migration_thread_running) {
@@ -1344,15 +1343,14 @@ static void migrate_fd_cleanup(MigrationState *s)
          * critical section won't block for long.
          */
         migration_ioc_unregister_yank_from_file(tmp);
-        qemu_fclose(tmp);
     }
 
-    /*
-     * We already cleaned up to_dst_file, so errors from the return
-     * path might be due to that, ignore them.
-     */
     close_return_path_on_source(s, file_error);
 
+    if (tmp) {
+        qemu_fclose(tmp);
+    }
+
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
-- 
2.43.0


