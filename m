Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF28C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pc-0004ao-Ns; Fri, 30 May 2025 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pa-0004VH-ES; Fri, 30 May 2025 11:12:46 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PX-0002M3-A7; Fri, 30 May 2025 11:12:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D17D044AAC;
 Fri, 30 May 2025 17:11:48 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 34/48] block: mark bdrv_reopen_queue() and
 bdrv_reopen_multiple() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:11 +0200
Message-Id: <20250530151125.955508-35-f.ebner@proxmox.com>
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

The function bdrv_reopen_queue() can call bdrv_drain_all_begin(),
which must be called with the graph unlocked.

The function bdrv_reopen_multiple() calls bdrv_reopen_prepare() which
must be called with the graph unlocked.

To mark bdrv_reopen_queue() as GRAPH_UNLOCKED, it is necessary to make
the locked section in reopen_backing_file() shorter.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/replication.c                | 3 ++-
 include/block/block-global-state.h | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 83978b61f5..3a431e908c 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -364,14 +364,15 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     BlockReopenQueue *reopen_queue = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    bdrv_graph_rdlock_main_loop();
     /*
      * s->hidden_disk and s->secondary_disk may not be set yet, as they will
      * only be set after the children are writable.
      */
     hidden_disk = bs->file->bs->backing;
     secondary_disk = hidden_disk->bs->backing;
+    bdrv_graph_rdunlock_main_loop();
 
     if (writable) {
         s->orig_hidden_read_only = bdrv_is_read_only(hidden_disk->bs);
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index bcbb624a7b..f25c65c1b4 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -121,11 +121,12 @@ BlockDriverState *bdrv_new_open_driver_opts(BlockDriver *drv,
                                             Error **errp);
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
-BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
-                                    BlockDriverState *bs, QDict *options,
-                                    bool keep_old_opts);
+BlockReopenQueue * GRAPH_UNLOCKED
+bdrv_reopen_queue(BlockReopenQueue *bs_queue, BlockDriverState *bs,
+                  QDict *options, bool keep_old_opts);
 void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue);
-int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
+int GRAPH_UNLOCKED
+bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen(BlockDriverState *bs, QDict *opts, bool keep_old_opts,
                 Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
-- 
2.39.5



