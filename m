Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8CEC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQe-0008HL-1p; Wed, 06 Mar 2024 08:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQc-0008H4-Co
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:26 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQX-0005CL-8n
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMp5j2vz4wyR;
 Thu,  7 Mar 2024 00:35:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMl2GvQz4wcF;
 Thu,  7 Mar 2024 00:35:15 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v4 07/25] migration: Always report an error in
 block_save_setup()
Date: Wed,  6 Mar 2024 14:34:22 +0100
Message-ID: <20240306133441.2351700-8-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
block_save_setup() always sets a new error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Added an error when bdrv_nb_sectors() returns a negative value
 
 migration/block.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..aa65ec718c2875ad9d1c40c971035f14d8086a6e 100644
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
@@ -404,6 +403,10 @@ static int init_blk_migration(QEMUFile *f)
         sectors = bdrv_nb_sectors(bs);
         if (sectors <= 0) {
             ret = sectors;
+            if (ret < 0) {
+                error_setg(errp, "Error getting length of block device %s",
+                           bdrv_get_device_name(bs));
+            }
             bdrv_next_cleanup(&it);
             goto out;
         }
@@ -439,9 +442,8 @@ static int init_blk_migration(QEMUFile *f)
         bs = bmds_bs[i].bs;
 
         if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, &local_err);
+            ret = blk_insert_bs(bmds->blk, bs, errp);
             if (ret < 0) {
-                error_report_err(local_err);
                 goto out;
             }
 
@@ -711,6 +713,7 @@ static void block_migration_cleanup(void *opaque)
 static int block_save_setup(QEMUFile *f, void *opaque)
 {
     int ret;
+    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -718,18 +721,27 @@ static int block_save_setup(QEMUFile *f, void *opaque)
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


