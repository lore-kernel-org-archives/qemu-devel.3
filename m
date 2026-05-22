Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9988BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXos-0001dr-5i; Fri, 22 May 2026 17:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo9-0000Qo-Tx; Fri, 22 May 2026 17:53:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo8-0005Cd-5l; Fri, 22 May 2026 17:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=s2b6KIjZ9zS3GX+ilug1RJYQGimyhkHV/+2cFdfi+tw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p2V44etnyT6VP+NDaBECU//Xg4EMX4ySV7PIMQ0fiEcdQa6mvy6aS3sdClJ0Cq4Uj
 +M68XGt6pJWCwA6wFvV9g2r5stzLsUEnB+waIKeLRT5f+q62I00lwXgoWBNYZtLxb/
 R53VpIdzgbucWHSp9d1d4buR/swdQ4For7VMK/8UuZt+8SiL1JMf76PRGdOFlSVF5T
 j/ebnrwTr3zWju9iyK65oD060KTj0WfzfxUR5p2DXmktsBT7r73kbiHwjupx8oZWqe
 ZkozqKoC1IrXeDBGrmtJuaCSEHRpW3vJmo2b/OAPm3AelXDGbgxN0IZafan3FA+aYi
 vo47CdctBMB8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ECEDF1AFB87;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 204CE3B71D6;
 Sat, 23 May 2026 00:49:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 145/149] commit: Drain nodes across all of
 bdrv_commit()
Date: Sat, 23 May 2026 00:49:17 +0300
Message-ID: <20260522214923.807017-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kevin Wolf <kwolf@redhat.com>

The whole implementation of bdrv_commit() is only correct if no new
writes come in while it's running: It has only a single loop checking
the allocation status for each block and finally calls bdrv_make_empty()
without checking if that throws away any new changes.

We already have to drain while taking the graph write lock. Just extend
the drained section to all of bdrv_commit() to make sure that we don't
get any inconsistencies.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-2-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f0d9ccd46cf8fc576ab7d514f10f766546cdbc14)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/commit.c b/block/commit.c
index 0d9e1a16d7..c5e3ef03a2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -518,6 +518,7 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
 
+    bdrv_drain_all_begin();
     bdrv_graph_rdlock_main_loop();
 
     backing_file_bs = bdrv_cow_bs(bs);
@@ -549,6 +550,10 @@ int bdrv_commit(BlockDriverState *bs)
                   BLK_PERM_ALL);
     backing = blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
+    /* We drained all nodes, but still make requests through BlockBackends */
+    blk_set_disable_request_queuing(src, true);
+    blk_set_disable_request_queuing(backing, true);
+
     ret = blk_insert_bs(src, bs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -565,7 +570,7 @@ int bdrv_commit(BlockDriverState *bs)
 
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
     bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
     bdrv_graph_wrunlock();
@@ -647,7 +652,7 @@ ro_cleanup:
     blk_unref(backing);
 
     bdrv_graph_rdunlock_main_loop();
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
         bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
@@ -663,6 +668,7 @@ ro_cleanup:
 
 out:
     bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 
     return ret;
 }
-- 
2.47.3


