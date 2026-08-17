Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D27BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvy7J-0005h5-8e; Mon, 17 Aug 2026 10:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1wvy7G-0005gn-U5; Mon, 17 Aug 2026 10:15:07 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1wvy7E-0000jU-W2; Mon, 17 Aug 2026 10:15:06 -0400
Received: from boringlust.malta.altlinux.ru (unknown [217.177.47.51])
 (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 6A0732337E;
 Mon, 17 Aug 2026 17:14:58 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	fam@euphon.net
Cc: qemu-devel@nongnu.org,
	sdl.qemu@linuxtesting.org
Subject: [PATCH] block/vmdk: prevent division by zero with zero cluster sectors
Date: Mon, 17 Aug 2026 17:14:56 +0300
Message-ID: <20260817141456.59418-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

A zero cluster_sectors value passes the existing upper-bound check
and later causes a division-by-zero in get_cluster_offset().

UBSan reports:

../block/vmdk.c:1608:30: runtime error: division by zero
    #0 0x5562d3b3b63b in get_cluster_offset ../block/vmdk.c:1608
    #1 0x5562d3db9aa7 in vmdk_co_block_status ../block/vmdk.c:1796
    #2 0x5562d3c48bb3 in bdrv_co_do_block_status ../block/io.c:2494
    #3 0x5562d3c55a3d in bdrv_co_common_block_status_above ../block/io.c:2672
    #4 0x5562d3c5630e in bdrv_co_block_status_above ../block/io.c:2752
    #5 0x5562d3ec5a3d in bdrv_co_block_status_above_entry block/block-gen.c:386
    #6 0x5562d40ab573 in coroutine_trampoline ../util/coroutine-ucontext.c:175

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c8..7a7935b25a 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -537,7 +537,7 @@ static int vmdk_add_extent(BlockDriverState *bs,
     BDRVVmdkState *s = bs->opaque;
     int64_t nb_sectors;
 
-    if (cluster_sectors > 0x200000) {
+    if (cluster_sectors == 0 || cluster_sectors > 0x200000) {
         /* 0x200000 * 512Bytes = 1GB for one cluster is unrealistic */
         error_setg(errp, "Invalid granularity, image may be corrupt");
         return -EFBIG;
-- 
2.50.1


