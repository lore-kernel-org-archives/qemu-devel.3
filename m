Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B395C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVc7n-000707-S0; Thu, 01 Feb 2024 13:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=bR2n=JK=redhat.com=clg@ozlabs.org>)
 id 1rVc7g-0006sy-Hp
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=bR2n=JK=redhat.com=clg@ozlabs.org>)
 id 1rVc7Z-0000Zm-D0
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TQnxV2J3cz4wcQ;
 Fri,  2 Feb 2024 05:49:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQnxS5Fqbz4wcM;
 Fri,  2 Feb 2024 05:49:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] migration: Add a file_error argument to
 close_return_path_on_source()
Date: Thu,  1 Feb 2024 19:48:52 +0100
Message-ID: <20240201184853.890471-2-clg@redhat.com>
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

close_return_path_on_source() retrieves the migration error from the
the QEMUFile '->to_dst_file' to know if a shutdown is required to exit
the return-path thread. However, in migrate_fd_cleanup(), '->to_dst_file'
is cleaned up before calling close_return_path_on_source() and the
shutdown is never performed, leaving the source and destination
waiting for an event to occur.

Cache the file error in a temporary variable and pass it to
close_return_path_on_source() to avoid relying on '->to_dst_file'.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d5f705ceef4c925589aa49335969672c0d761fa2..2c3362235c7651c11d581f3c3639571f1f9636ef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -100,7 +100,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
-static bool close_return_path_on_source(MigrationState *s);
+static bool close_return_path_on_source(MigrationState *s, int eror);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -1313,6 +1313,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    int file_error = 0;
+
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1333,6 +1335,7 @@ static void migrate_fd_cleanup(MigrationState *s)
 
         multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
+        file_error = qemu_file_get_error(s->to_dst_file);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
         qemu_mutex_unlock(&s->qemu_file_lock);
@@ -1348,7 +1351,7 @@ static void migrate_fd_cleanup(MigrationState *s)
      * We already cleaned up to_dst_file, so errors from the return
      * path might be due to that, ignore them.
      */
-    close_return_path_on_source(s);
+    close_return_path_on_source(s, file_error);
 
     assert(!migration_is_active(s));
 
@@ -2357,7 +2360,7 @@ static int open_return_path_on_source(MigrationState *ms)
 }
 
 /* Return true if error detected, or false otherwise */
-static bool close_return_path_on_source(MigrationState *ms)
+static bool close_return_path_on_source(MigrationState *ms, int file_error)
 {
     if (!ms->rp_state.rp_thread_created) {
         return false;
@@ -2372,8 +2375,7 @@ static bool close_return_path_on_source(MigrationState *ms)
      * cause it to unblock if it's stuck waiting for the destination.
      */
     WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
-            qemu_file_get_error(ms->to_dst_file)) {
+        if (file_error && ms->rp_state.from_dst_file) {
             qemu_file_shutdown(ms->rp_state.from_dst_file);
         }
     }
@@ -2707,6 +2709,7 @@ static void migration_completion(MigrationState *s)
 {
     int ret = 0;
     int current_active_state = s->state;
+    int file_error = qemu_file_get_error(s->to_dst_file);
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         ret = migration_completion_precopy(s, &current_active_state);
@@ -2720,11 +2723,11 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    if (close_return_path_on_source(s)) {
+    if (close_return_path_on_source(s, file_error)) {
         goto fail;
     }
 
-    if (qemu_file_get_error(s->to_dst_file)) {
+    if (file_error) {
         trace_migration_completion_file_err();
         goto fail;
     }
@@ -2861,6 +2864,7 @@ static MigThrError postcopy_pause(MigrationState *s)
 
     while (true) {
         QEMUFile *file;
+        int file_error;
 
         /*
          * Current channel is possibly broken. Release it.  Note that this is
@@ -2874,6 +2878,7 @@ static MigThrError postcopy_pause(MigrationState *s)
         assert(s->to_dst_file);
         migration_ioc_unregister_yank_from_file(s->to_dst_file);
         qemu_mutex_lock(&s->qemu_file_lock);
+        file_error = qemu_file_get_error(s->to_dst_file);
         file = s->to_dst_file;
         s->to_dst_file = NULL;
         qemu_mutex_unlock(&s->qemu_file_lock);
@@ -2886,7 +2891,7 @@ static MigThrError postcopy_pause(MigrationState *s)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        close_return_path_on_source(s);
+        close_return_path_on_source(s, file_error);
 
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
-- 
2.43.0


