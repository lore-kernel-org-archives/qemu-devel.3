Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415CFC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFJ-0008HI-H3; Tue, 20 May 2025 06:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEu-0006uq-Q7; Tue, 20 May 2025 06:30:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-00051d-CM; Tue, 20 May 2025 06:30:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 562CA43B41;
 Tue, 20 May 2025 12:30:19 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 06/24] block: mark change_aio_ctx() callback and instances
 as GRAPH_RDLOCK(_PTR)
Date: Tue, 20 May 2025 12:29:54 +0200
Message-Id: <20250520103012.424311-7-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

This is a small step in preparation to mark bdrv_drained_begin() as
GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the
drain out of bdrv_change_aio_context() and marking that function as
GRAPH_RDLOCK.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v2.

Checkpatch seems to report a false positive here, but it's the same
for other callbacks in that header file:

ERROR: space prohibited between function name and open parenthesis '('
#86: FILE: include/block/block_int-common.h:986:
+    bool GRAPH_RDLOCK_PTR (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,


 block.c                          | 7 ++++---
 block/block-backend.c            | 6 +++---
 blockjob.c                       | 6 +++---
 include/block/block_int-common.h | 6 +++---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 7207978e53..01144c895e 100644
--- a/block.c
+++ b/block.c
@@ -1226,9 +1226,10 @@ static int bdrv_child_cb_inactivate(BdrvChild *child)
     return 0;
 }
 
-static bool bdrv_child_cb_change_aio_ctx(BdrvChild *child, AioContext *ctx,
-                                         GHashTable *visited, Transaction *tran,
-                                         Error **errp)
+static bool GRAPH_RDLOCK
+bdrv_child_cb_change_aio_ctx(BdrvChild *child, AioContext *ctx,
+                             GHashTable *visited, Transaction *tran,
+                             Error **errp)
 {
     BlockDriverState *bs = child->opaque;
     return bdrv_change_aio_context(bs, ctx, visited, tran, errp);
diff --git a/block/block-backend.c b/block/block-backend.c
index a402db13f2..6a6949edeb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -136,9 +136,9 @@ static void blk_root_drained_end(BdrvChild *child);
 static void blk_root_change_media(BdrvChild *child, bool load);
 static void blk_root_resize(BdrvChild *child);
 
-static bool blk_root_change_aio_ctx(BdrvChild *child, AioContext *ctx,
-                                    GHashTable *visited, Transaction *tran,
-                                    Error **errp);
+static bool GRAPH_RDLOCK
+blk_root_change_aio_ctx(BdrvChild *child, AioContext *ctx, GHashTable *visited,
+                        Transaction *tran, Error **errp);
 
 static char *blk_root_get_parent_desc(BdrvChild *child)
 {
diff --git a/blockjob.c b/blockjob.c
index 32007f31a9..34185d7715 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -144,9 +144,9 @@ static TransactionActionDrv change_child_job_context = {
     .clean = g_free,
 };
 
-static bool child_job_change_aio_ctx(BdrvChild *c, AioContext *ctx,
-                                     GHashTable *visited, Transaction *tran,
-                                     Error **errp)
+static bool GRAPH_RDLOCK
+child_job_change_aio_ctx(BdrvChild *c, AioContext *ctx, GHashTable *visited,
+                         Transaction *tran, Error **errp)
 {
     BlockJob *job = c->opaque;
     BdrvStateChildJobContext *s;
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 2982dd3118..37466c7841 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -983,9 +983,9 @@ struct BdrvChildClass {
                            bool backing_mask_protocol,
                            Error **errp);
 
-    bool (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,
-                           GHashTable *visited, Transaction *tran,
-                           Error **errp);
+    bool GRAPH_RDLOCK_PTR (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,
+                                            GHashTable *visited,
+                                            Transaction *tran, Error **errp);
 
     /*
      * I/O API functions. These functions are thread-safe.
-- 
2.39.5



