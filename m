Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD426C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNES-00046o-ML; Tue, 04 Mar 2025 03:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpNEM-0003yX-4F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:02:25 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpNEJ-0003mV-Ju
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:02:21 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 296B7233B4;
 Tue,  4 Mar 2025 11:02:16 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] block/snapshot: fix *errp handling in bdrv_snapshot_goto
Date: Tue,  4 Mar 2025 11:01:51 +0300
Message-ID: <20250304080213.36099-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

If bdrv_snapshot_goto() returns an error, it is not handled immediately,
allowing *errp to be reassigned when qcow_open() fails, which triggers
assert(*errp == NULL) in util/error.c: void error_setv().

This patch ensures that errors from bdrv_snapshot_goto() are handled
immediately after the call, preventing *errp from being modified twice
and avoiding unnecessary assertion failures.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2851
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/snapshot.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 9c44780e96..d1b5a8d33d 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -296,14 +296,20 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bdrv_graph_wrunlock();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
+        if (ret < 0) {
+            bdrv_unref(fallback_bs);
+            bs->drv = NULL;
+            /* A bdrv_snapshot_goto() error takes precedence */
+            error_propagate(errp, local_err);
+            return ret;
+        }
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         qobject_unref(options);
         if (open_ret < 0) {
             bdrv_unref(fallback_bs);
             bs->drv = NULL;
-            /* A bdrv_snapshot_goto() error takes precedence */
             error_propagate(errp, local_err);
-            return ret < 0 ? ret : open_ret;
+            return open_ret;
         }
 
         /*
-- 
2.42.2


