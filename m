Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C2BC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4A-0006hr-Re; Wed, 07 Feb 2024 08:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi45-0006fi-4l
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:15 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi42-0008P0-E7
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgL6CXPz4x04;
 Thu,  8 Feb 2024 00:34:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgK0dYTz4wc6;
 Thu,  8 Feb 2024 00:34:04 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 04/14] migration: Modify ram_init_bitmaps() to report dirty
 tracking errors
Date: Wed,  7 Feb 2024 14:33:37 +0100
Message-ID: <20240207133347.1115903-5-clg@redhat.com>
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

The .save_setup() handler has now an Error** argument that we can use
to propagate errors reported by the .log_global_start() handler. Do
that for the RAM. qemu_savevm_state_setup() will store the error under
the migration stream for later detection in the migration sequence.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/ram.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d86626bb1c704b2d3497b323a702ca6ca8939a79..b87245466bb46937fd0358d0c66432bcc6280018 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2802,19 +2802,17 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
     }
 }
 
-static void ram_init_bitmaps(RAMState *rs)
+static void ram_init_bitmaps(RAMState *rs, Error **errp)
 {
-    Error *local_err = NULL;
-
     qemu_mutex_lock_ramlist();
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
-            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
-            if (local_err) {
-                error_report_err(local_err);
+            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
+            if (*errp) {
+                break;
             }
             migration_bitmap_sync_precopy(rs, false);
         }
@@ -2828,7 +2826,7 @@ static void ram_init_bitmaps(RAMState *rs)
     migration_bitmap_clear_discarded_pages(rs);
 }
 
-static int ram_init_all(RAMState **rsp)
+static int ram_init_all(RAMState **rsp, Error **errp)
 {
     if (ram_state_init(rsp)) {
         return -1;
@@ -2839,7 +2837,10 @@ static int ram_init_all(RAMState **rsp)
         return -1;
     }
 
-    ram_init_bitmaps(*rsp);
+    ram_init_bitmaps(*rsp, errp);
+    if (*errp) {
+        return -1;
+    }
 
     return 0;
 }
@@ -2952,7 +2953,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp) != 0) {
+        if (ram_init_all(rsp, errp) != 0) {
             compress_threads_save_cleanup();
             return -1;
         }
-- 
2.43.0


