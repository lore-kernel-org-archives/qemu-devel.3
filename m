Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFDDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXmI-00006C-TF; Mon, 26 May 2025 09:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXm8-0008TI-63; Mon, 26 May 2025 09:21:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXm4-0000Hk-26; Mon, 26 May 2025 09:21:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D92E944572;
 Mon, 26 May 2025 15:21:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v3 05/24] block: mark bdrv_parent_change_aio_context()
 GRAPH_RDLOCK
Date: Mon, 26 May 2025 15:21:21 +0200
Message-Id: <20250526132140.1641377-6-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526132140.1641377-1-f.ebner@proxmox.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
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

This is a small step in preparation to mark bdrv_drained_begin() as
GRAPH_UNLOCKED. More concretely, it allows marking the
change_aio_ctx() callback GRAPH_RDLOCK_PTR, which is the next step.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---

No changes in v3.

 block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index fa55dfba68..7207978e53 100644
--- a/block.c
+++ b/block.c
@@ -7575,10 +7575,10 @@ typedef struct BdrvStateSetAioContext {
     BlockDriverState *bs;
 } BdrvStateSetAioContext;
 
-static bool bdrv_parent_change_aio_context(BdrvChild *c, AioContext *ctx,
-                                           GHashTable *visited,
-                                           Transaction *tran,
-                                           Error **errp)
+static bool GRAPH_RDLOCK
+bdrv_parent_change_aio_context(BdrvChild *c, AioContext *ctx,
+                               GHashTable *visited, Transaction *tran,
+                               Error **errp)
 {
     GLOBAL_STATE_CODE();
     if (g_hash_table_contains(visited, c)) {
-- 
2.39.5



