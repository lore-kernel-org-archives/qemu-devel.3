Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338EDC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4KW-0005Zx-4D; Tue, 27 Feb 2024 15:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1ol-00049O-Nd
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:39 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1oi-0001XD-Op
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:04:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TklkB5Jcbz4wyx;
 Wed, 28 Feb 2024 05:04:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tklk812QSz4wyj;
 Wed, 28 Feb 2024 05:04:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 10/21] migration: Modify ram_init_bitmaps() to report dirty
 tracking errors
Date: Tue, 27 Feb 2024 19:03:34 +0100
Message-ID: <20240227180345.548960-11-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:32 -0500
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

The .save_setup() handler has now an Error** argument that we can use
to propagate errors reported by the .log_global_start() handler. Do
that for the RAM. The caller qemu_savevm_state_setup() will store the
error under the migration stream for later detection in the migration
sequence.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9fb1875aad73b2fa009199bdfa8960339df7287d..23f4df4779309bbbe164c56c1436b60d65749860 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2802,9 +2802,8 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
     }
 }
 
-static void ram_init_bitmaps(RAMState *rs)
+static bool ram_init_bitmaps(RAMState *rs, Error **errp)
 {
-    Error *local_err = NULL;
     bool ret = true;
 
     qemu_mutex_lock_ramlist();
@@ -2813,10 +2812,8 @@ static void ram_init_bitmaps(RAMState *rs)
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
-                                                &local_err);
+            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
             if (!ret) {
-                error_report_err(local_err);
                 goto out_unlock;
             }
             migration_bitmap_sync_precopy(rs, false);
@@ -2826,7 +2823,7 @@ out_unlock:
     qemu_mutex_unlock_ramlist();
 
     if (!ret) {
-        return;
+        return false;
     }
 
     /*
@@ -2834,9 +2831,10 @@ out_unlock:
      * containing all 1s to exclude any discarded pages from migration.
      */
     migration_bitmap_clear_discarded_pages(rs);
+    return true;
 }
 
-static int ram_init_all(RAMState **rsp)
+static int ram_init_all(RAMState **rsp, Error **errp)
 {
     if (ram_state_init(rsp)) {
         return -1;
@@ -2847,7 +2845,9 @@ static int ram_init_all(RAMState **rsp)
         return -1;
     }
 
-    ram_init_bitmaps(*rsp);
+    if (!ram_init_bitmaps(*rsp, errp)) {
+        return -1;
+    }
 
     return 0;
 }
@@ -2961,7 +2961,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp) != 0) {
+        if (ram_init_all(rsp, errp) != 0) {
             compress_threads_save_cleanup();
             return -1;
         }
-- 
2.43.2


