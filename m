Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC87EC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PR-00044R-72; Fri, 30 May 2025 11:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PC-0003NT-I1; Fri, 30 May 2025 11:12:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P9-0002IB-2v; Fri, 30 May 2025 11:12:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 985D044B5D;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 25/48] block/mirror: switch to
 bdrv_set_backing_hd_drained() variant
Date: Fri, 30 May 2025 17:11:02 +0200
Message-Id: <20250530151125.955508-26-f.ebner@proxmox.com>
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

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Switch to using the bdrv_set_backing_hd_drained() variant, so that the
drained and locked section can also cover the calls to
bdrv_skip_filters() and bdrv_cow_bs().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 82a6e50cf8..873e95d029 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -761,30 +761,36 @@ static int mirror_exit_common(Job *job)
     bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
+    bdrv_graph_rdunlock_main_loop();
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing;
-        BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
+        BlockDriverState *unfiltered_target;
+
+        bdrv_graph_wrlock_drained();
+        unfiltered_target = bdrv_skip_filters(target_bs);
 
         backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         if (bdrv_cow_bs(unfiltered_target) != backing) {
-            bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
+            bdrv_set_backing_hd_drained(unfiltered_target, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 local_err = NULL;
                 ret = -EPERM;
             }
         }
+        bdrv_graph_wrunlock();
     } else if (!abort && s->backing_mode == MIRROR_OPEN_BACKING_CHAIN) {
+        bdrv_graph_rdlock_main_loop();
         assert(!bdrv_backing_chain_next(target_bs));
         ret = bdrv_open_backing_file(bdrv_skip_filters(target_bs), NULL,
                                      "backing", &local_err);
+        bdrv_graph_rdunlock_main_loop();
         if (ret < 0) {
             error_report_err(local_err);
             local_err = NULL;
         }
     }
-    bdrv_graph_rdunlock_main_loop();
 
     if (s->should_complete && !abort) {
         BlockDriverState *to_replace = s->to_replace ?: src;
-- 
2.39.5



