Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC37C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7RT-00089O-HT; Mon, 04 Mar 2024 07:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RL-00084f-Ih
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:11 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RJ-0004U4-Q0
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ0H5MWbz4wxX;
 Mon,  4 Mar 2024 23:29:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ0D49HTz4wqN;
 Mon,  4 Mar 2024 23:29:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 03/26] migration: Always report an error in
 block_save_setup()
Date: Mon,  4 Mar 2024 13:28:21 +0100
Message-ID: <20240304122844.1888308-4-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This will prepare ground for futur changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
block_save_setup() always sets a new error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/block.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..06f5857cf049df3261d2cf1d7c3607ab92350ac6 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -367,7 +367,7 @@ static void unset_dirty_tracking(void)
     }
 }
 
-static int init_blk_migration(QEMUFile *f)
+static int init_blk_migration(QEMUFile *f, Error **errp)
 {
     BlockDriverState *bs;
     BlkMigDevState *bmds;
@@ -378,7 +378,6 @@ static int init_blk_migration(QEMUFile *f)
         BlkMigDevState *bmds;
         BlockDriverState *bs;
     } *bmds_bs;
-    Error *local_err = NULL;
     int ret;
 
     GRAPH_RDLOCK_GUARD_MAINLOOP();
@@ -439,9 +438,8 @@ static int init_blk_migration(QEMUFile *f)
         bs = bmds_bs[i].bs;
 
         if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, &local_err);
+            ret = blk_insert_bs(bmds->blk, bs, errp);
             if (ret < 0) {
-                error_report_err(local_err);
                 goto out;
             }
 
@@ -711,6 +709,7 @@ static void block_migration_cleanup(void *opaque)
 static int block_save_setup(QEMUFile *f, void *opaque)
 {
     int ret;
+    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -718,18 +717,27 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     warn_report("block migration is deprecated;"
                 " use blockdev-mirror with NBD instead");
 
-    ret = init_blk_migration(f);
+    ret = init_blk_migration(f, &local_err);
     if (ret < 0) {
+        error_report_err(local_err);
         return ret;
     }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
     if (ret) {
+        error_setg_errno(&local_err, -ret,
+                         "Failed to start block dirty tracking");
+        error_report_err(local_err);
         return ret;
     }
 
     ret = flush_blks(f);
+    if (ret) {
+        error_setg_errno(&local_err, -ret, "Flushing block failed");
+        error_report_err(local_err);
+        return ret;
+    }
     blk_mig_reset_dirty_cursor();
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
 
-- 
2.44.0


