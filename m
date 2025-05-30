Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB56C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pg-0004my-Nr; Fri, 30 May 2025 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pc-0004ZT-2u; Fri, 30 May 2025 11:12:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PZ-0002NH-0A; Fri, 30 May 2025 11:12:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3ACE2449EE;
 Fri, 30 May 2025 17:11:49 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 46/48] block: mark bdrv_close() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:23 +0200
Message-Id: <20250530151125.955508-47-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The functions blk_log_writes_close(), blkverify_close(),
quorum_close(), vmdk_close() via vmdk_free_extents(), and other
bdrv_close() implementations call bdrv_graph_wrlock_drained(), which
must be called with the graph unlocked. They are reached via the
BlockDriver's bdrv_close() callback and the bdrv_close() wrapper,
which are also marked as GRAPH_UNLOCKED_PTR and GRAPH_UNLOCKED.

Furthermore, the function bdrv_close() also calls bdrv_drained_begin()
and bdrv_graph_wrlock_drained(), so there are additional reasons for
marking it GRAPH_UNLOCKED.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c                          | 2 +-
 include/block/block_int-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 1b9c99dda9..a4b79d70db 100644
--- a/block.c
+++ b/block.c
@@ -5148,7 +5148,7 @@ static void GRAPH_UNLOCKED bdrv_reopen_abort(BDRVReopenState *reopen_state)
 }
 
 
-static void bdrv_close(BlockDriverState *bs)
+static void GRAPH_UNLOCKED bdrv_close(BlockDriverState *bs)
 {
     BdrvAioNotifier *ban, *ban_next;
     BdrvChild *child, *next;
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index e96c6a6a03..034c0634c8 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -248,7 +248,7 @@ struct BlockDriver {
     int GRAPH_UNLOCKED_PTR (*bdrv_open)(
         BlockDriverState *bs, QDict *options, int flags, Error **errp);
 
-    void (*bdrv_close)(BlockDriverState *bs);
+    void GRAPH_UNLOCKED_PTR (*bdrv_close)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create)(
         BlockdevCreateOptions *opts, Error **errp);
-- 
2.39.5



