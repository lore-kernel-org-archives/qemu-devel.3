Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F51C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFA-0007ZG-V8; Tue, 20 May 2025 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEu-0006un-Py; Tue, 20 May 2025 06:30:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-00051o-Ou; Tue, 20 May 2025 06:30:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0F16543B73;
 Tue, 20 May 2025 12:30:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 11/24] block: move drain outside of
 bdrv_set_backing_hd_drained()
Date: Tue, 20 May 2025 12:29:59 +0200
Message-Id: <20250520103012.424311-12-f.ebner@proxmox.com>
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The function bdrv_set_backing_hd_drained() holds the graph lock, so it
is not allowed to drain. It is called by:
1. bdrv_set_backing_hd(), where a drained section is introduced,
   replacing the previously present bs-specific drains.
2. stream_prepare(), where a drained section is introduced replacing
   the previously present bs-specific drains.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Split up into smaller pieces, flesh out commit messages.

 block.c        | 6 ++----
 block/stream.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 702a51ff4b..f323588d15 100644
--- a/block.c
+++ b/block.c
@@ -3569,7 +3569,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
         assert(bs->backing->bs->quiesce_counter > 0);
     }
 
-    bdrv_drain_all_begin();
     ret = bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
     if (ret < 0) {
         goto out;
@@ -3578,7 +3577,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
     tran_finalize(tran, ret);
-    bdrv_drain_all_end();
     return ret;
 }
 
@@ -3594,11 +3592,11 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_ref(drain_bs);
-    bdrv_drained_begin(drain_bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
     bdrv_graph_wrunlock();
-    bdrv_drained_end(drain_bs);
+    bdrv_drain_all_end();
     bdrv_unref(drain_bs);
 
     return ret;
diff --git a/block/stream.c b/block/stream.c
index 999d9e56d4..6ba49cffd3 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -80,11 +80,10 @@ static int stream_prepare(Job *job)
      * may end up working with the wrong base node (or it might even have gone
      * away by the time we want to use it).
      */
-    bdrv_drained_begin(unfiltered_bs);
     if (unfiltered_bs_cow) {
         bdrv_ref(unfiltered_bs_cow);
-        bdrv_drained_begin(unfiltered_bs_cow);
     }
+    bdrv_drain_all_begin();
 
     bdrv_graph_rdlock_main_loop();
     base = bdrv_filter_or_cow_bs(s->above_base);
@@ -123,11 +122,10 @@ static int stream_prepare(Job *job)
     }
 
 out:
+    bdrv_drain_all_end();
     if (unfiltered_bs_cow) {
-        bdrv_drained_end(unfiltered_bs_cow);
         bdrv_unref(unfiltered_bs_cow);
     }
-    bdrv_drained_end(unfiltered_bs);
     return ret;
 }
 
-- 
2.39.5



