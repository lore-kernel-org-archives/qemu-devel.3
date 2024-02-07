Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20F2C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4S-0006zp-61; Wed, 07 Feb 2024 08:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4P-0006wQ-Kq
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4N-0008Uo-Tj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgn5zxMz4x1s;
 Thu,  8 Feb 2024 00:34:29 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgm0KSgz4x1m;
 Thu,  8 Feb 2024 00:34:27 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 14/14] migration: Fix return-path thread exit
Date: Wed,  7 Feb 2024 14:33:47 +0100
Message-ID: <20240207133347.1115903-15-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

 This is an RFC because the correct fix implies reworking the QEMUFile
 construct, built on top of the QEMU I/O channel.

 migration/migration.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5f55af3d7624750ca416c4177781241b3e291e5d..de329f2c553288935d824748286e79e535929b8b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1313,6 +1313,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    QEMUFile *tmp = NULL;
+
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1321,8 +1323,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        QEMUFile *tmp;
-
         trace_migrate_fd_cleanup();
         bql_unlock();
         if (s->migration_thread_running) {
@@ -1341,15 +1341,14 @@ static void migrate_fd_cleanup(MigrationState *s)
          * critical section won't block for long.
          */
         migration_ioc_unregister_yank_from_file(tmp);
-        qemu_fclose(tmp);
     }
 
-    /*
-     * We already cleaned up to_dst_file, so errors from the return
-     * path might be due to that, ignore them.
-     */
     close_return_path_on_source(s);
 
+    if (tmp) {
+        qemu_fclose(tmp);
+    }
+
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
-- 
2.43.0


