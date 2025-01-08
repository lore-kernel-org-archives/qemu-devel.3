Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26EAE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVSz-0004ZC-40; Wed, 08 Jan 2025 07:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tVVSo-0004XY-0C; Wed, 08 Jan 2025 07:47:10 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tVVSl-0002qq-MT; Wed, 08 Jan 2025 07:47:09 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 070DA48F53;
 Wed,  8 Jan 2025 13:46:55 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: [PATCH] block-backend: protect setting block root to NULL with block
 graph write lock
Date: Wed,  8 Jan 2025 13:46:49 +0100
Message-Id: <20250108124649.333668-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
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

Setting blk->root is a graph change operation and thus needs to be
protected by the block graph write lock in blk_remove_bs(). The
assignment to blk->root in blk_insert_bs() is already protected by
the block graph write lock.

In particular, the graph read lock in blk_co_do_flush() could
previously not ensure that blk_bs(blk) would always return the same
value during the locked section, which could lead to a segfault [0] in
combination with migration [1].

From the user-provided backtraces in the forum thread [1], it seems
like blk_co_do_flush() managed to get past the
blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
non-NULL value during the check, but then, when calling
bdrv_co_flush(), blk_bs(blk) returned NULL.

[0]:

> 0  bdrv_primary_child (bs=bs@entry=0x0) at ../block.c:8287
> 1  bdrv_co_flush (bs=0x0) at ../block/io.c:2948
> 2  bdrv_co_flush_entry (opaque=0x7a610affae90) at block/block-gen.c:901

[1]: https://forum.proxmox.com/threads/158072

Cc: qemu-stable@nongnu.org
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/block-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index c93a7525ad..9678615318 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
      */
     blk_drain(blk);
     root = blk->root;
-    blk->root = NULL;
 
     bdrv_graph_wrlock();
+    blk->root = NULL;
     bdrv_root_unref_child(root);
     bdrv_graph_wrunlock();
 }
-- 
2.39.5



