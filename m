Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD5FC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PE-0003US-Ov; Fri, 30 May 2025 11:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P9-0003Dr-Rv; Fri, 30 May 2025 11:12:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P7-0002HA-KP; Fri, 30 May 2025 11:12:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0B82B44766;
 Fri, 30 May 2025 17:11:44 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 16/48] block: move drain outside of quorum_del_child()
Date: Fri, 30 May 2025 17:10:53 +0200
Message-Id: <20250530151125.955508-17-f.ebner@proxmox.com>
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

The quorum_del_child() callback runs under the graph lock, so it is
not allowed to drain. It is only called as the .bdrv_del_child()
callback, which is only called in the bdrv_del_child() function, which
also runs under the graph lock.

The bdrv_del_child() function is called by qmp_x_blockdev_change().
A drained section was already introduced there by commit "block: move
drain out of quorum_add_child()".

This finally finishes moving out the drain to places that are not
under the graph lock started in "block: move draining out of
bdrv_change_aio_context() and mark GRAPH_RDLOCK".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v4:
* Document requirement that all nodes need to be drained for
  bdrv_del_child() wrapper and callback.
* Add function comment for bdrv_del_child() callback.

 block.c                          | 2 ++
 block/quorum.c                   | 2 --
 include/block/block_int-common.h | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 15a8ccb822..bfd4340b24 100644
--- a/block.c
+++ b/block.c
@@ -8276,6 +8276,8 @@ void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
 /*
  * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
  * user can take a child offline when it is broken and take a new child online.
+ *
+ * All block nodes must be drained.
  */
 void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 {
diff --git a/block/quorum.c b/block/quorum.c
index 81407a38ee..cc3bc5f4e7 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1147,9 +1147,7 @@ quorum_del_child(BlockDriverState *bs, BdrvChild *child, Error **errp)
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
 
-    bdrv_drain_all_begin();
     bdrv_unref_child(bs, child);
-    bdrv_drain_all_end();
 
     quorum_refresh_flags(bs);
 }
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index f9e742f812..925a3e7353 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -406,6 +406,13 @@ struct BlockDriver {
     void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
         BlockDriverState *parent, BlockDriverState *child, Error **errp);
 
+    /**
+     * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
+     * user can take a child offline when it is broken and take a new child
+     * online.
+     *
+     * All block nodes must be drained.
+     */
     void GRAPH_WRLOCK_PTR (*bdrv_del_child)(
         BlockDriverState *parent, BdrvChild *child, Error **errp);
 
-- 
2.39.5



