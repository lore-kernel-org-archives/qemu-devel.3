Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E60C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmplg-000289-1y; Wed, 20 Mar 2024 02:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpld-00026f-5W
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplb-0001RQ-LI
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWgZMSPapRs80HzAlE2Bm1sGCHTu++5Q66lqfwh4cSg=;
 b=cUHvuRBdlDsB74Nm0qug1M5oNXMnWpshn3gSJmyw1nK1RBfGHy8HPXufM8Mu/fyPJLe8XU
 uUYNEqeG1shZPlByJXcZ7qUWHI5QYT7iX/4q8bWgbck7w0TgOl5btK55BgXvXNEobGumZC
 9/nnboNdXAHnVa89wsGLo6MWsY1sO20=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Fx9759M7PUq7jEJtS8li6w-1; Wed,
 20 Mar 2024 02:49:34 -0400
X-MC-Unique: Fx9759M7PUq7jEJtS8li6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E56503CBDF61;
 Wed, 20 Mar 2024 06:49:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FB481C060A6;
 Wed, 20 Mar 2024 06:49:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH for-9.1 v5 03/14] migration: Always report an error in
 block_save_setup()
Date: Wed, 20 Mar 2024 07:48:59 +0100
Message-ID: <20240320064911.545001-4-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
block_save_setup() always sets a new error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v5:

 - Rebased on 2e128776dc56 ("migration: Skip only empty block devices")

 migration/block.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 2b9054889ad2ba739828594c50cf047703757e96..f8a11beb37dac3df5c2cc654db6440509d1181ea 100644
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
@@ -406,6 +405,8 @@ static int init_blk_migration(QEMUFile *f)
             continue;
         }
         if (sectors < 0) {
+            error_setg(errp, "Error getting length of block device %s",
+                       bdrv_get_device_name(bs));
             ret = sectors;
             bdrv_next_cleanup(&it);
             goto out;
@@ -442,9 +443,8 @@ static int init_blk_migration(QEMUFile *f)
         bs = bmds_bs[i].bs;
 
         if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, &local_err);
+            ret = blk_insert_bs(bmds->blk, bs, errp);
             if (ret < 0) {
-                error_report_err(local_err);
                 goto out;
             }
 
@@ -714,6 +714,7 @@ static void block_migration_cleanup(void *opaque)
 static int block_save_setup(QEMUFile *f, void *opaque)
 {
     int ret;
+    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -721,18 +722,27 @@ static int block_save_setup(QEMUFile *f, void *opaque)
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


