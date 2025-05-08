Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5261C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1wn-00021C-KD; Thu, 08 May 2025 10:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wi-0001xH-F0; Thu, 08 May 2025 10:09:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wg-0008U4-Fp; Thu, 08 May 2025 10:09:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 14EC742C43;
 Thu,  8 May 2025 16:09:42 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 08/11] block: mark bdrv_drained_begin() as GRAPH_UNLOCKED
Date: Thu,  8 May 2025 16:09:33 +0200
Message-Id: <20250508140936.3344485-9-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508140936.3344485-1-f.ebner@proxmox.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
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

bdrv_drained_begin() polls and is not allowed to be called with the
block graph lock held. Mark the function as such.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

This does not catch the issue reported by Andrey, because there
is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
the function bdrv_change_aio_context(). That unlock is of course
ineffective if the exclusive lock is held, but it seems to prevent TSA
from finiding the issue.

The next patch is concerned with that.

 include/block/block-io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index b49e0537dd..34b9f1cbfc 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -429,7 +429,8 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
  *
  * This function can be recursive.
  */
-void bdrv_drained_begin(BlockDriverState *bs);
+void GRAPH_UNLOCKED
+bdrv_drained_begin(BlockDriverState *bs);
 
 /**
  * bdrv_do_drained_begin_quiesce:
-- 
2.39.5



