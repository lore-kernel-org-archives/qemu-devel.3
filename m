Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYa-0008GU-4x; Mon, 29 Apr 2024 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYV-0008D9-K5; Mon, 29 Apr 2024 07:52:24 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYQ-0001oB-A9; Mon, 29 Apr 2024 07:52:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9B14960C24;
 Mon, 29 Apr 2024 14:52:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-87SfCP6k; Mon, 29 Apr 2024 14:52:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391533;
 bh=M9bTcVoVVYx1vTw25y9U4yg7TuT7NkouXUR1hv8vs2M=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e76JOpLTsC6G/AsTJGKb5fciJVVT8WpQ/bKbepJp6ve0lNFWf3kzT3Kc5R2qg50ZH
 R+uU5EqtI92aAUQPN3j0nqZio2aCHx1bg08szwfb+1NeFJezh07/pPpmdH+EmZxgaQ
 v04Fq5mynojGtA5cbMEFWcZDDX/IULJry6TKO8TI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 3/6] block/copy-before-write: support unligned snapshot-discard
Date: Mon, 29 Apr 2024 14:51:54 +0300
Message-Id: <20240429115157.2260885-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

First thing that crashes on unligned access here is
bdrv_reset_dirty_bitmap(). Correct way is to align-down the
snapshot-discard request.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240313152822.626493-3-vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/copy-before-write.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 3e3af30c08..6d89af0b29 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -325,14 +325,24 @@ static int coroutine_fn GRAPH_RDLOCK
 cbw_co_pdiscard_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BDRVCopyBeforeWriteState *s = bs->opaque;
+    uint32_t cluster_size = block_copy_cluster_size(s->bcs);
+    int64_t aligned_offset = QEMU_ALIGN_UP(offset, cluster_size);
+    int64_t aligned_end = QEMU_ALIGN_DOWN(offset + bytes, cluster_size);
+    int64_t aligned_bytes;
+
+    if (aligned_end <= aligned_offset) {
+        return 0;
+    }
+    aligned_bytes = aligned_end - aligned_offset;
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
-        bdrv_reset_dirty_bitmap(s->access_bitmap, offset, bytes);
+        bdrv_reset_dirty_bitmap(s->access_bitmap, aligned_offset,
+                                aligned_bytes);
     }
 
-    block_copy_reset(s->bcs, offset, bytes);
+    block_copy_reset(s->bcs, aligned_offset, aligned_bytes);
 
-    return bdrv_co_pdiscard(s->target, offset, bytes);
+    return bdrv_co_pdiscard(s->target, aligned_offset, aligned_bytes);
 }
 
 static void GRAPH_RDLOCK cbw_refresh_filename(BlockDriverState *bs)
-- 
2.34.1


