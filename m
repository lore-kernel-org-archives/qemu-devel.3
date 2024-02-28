Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8EAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKim-0003w5-EW; Wed, 28 Feb 2024 09:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKid-0003qV-9N; Wed, 28 Feb 2024 09:15:38 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKiV-00025u-Gx; Wed, 28 Feb 2024 09:15:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 95B9C60ABE;
 Wed, 28 Feb 2024 17:15:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a522::1:14])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4FaAWa1Of0U0-6itjn2ek; Wed, 28 Feb 2024 17:15:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709129718;
 bh=0QRhm20ZDXUC3wITyTsHMQfUsqreMyRdR1kV2JrpNuQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pKW+CE3ntm5+WKYLsjQE0XlzJYBXVH/HrXnsXGl6NkKg+EQVy4dXNBufseuL8uAls
 cA/n+acscesNEBA8rryOp2uPER8VZchBfeMXiBTPVmGael3ZpXmDosCvHvsj7u8pz6
 cCi4WAsBBhRwo92c+I9BiYaA3Im/XeHDTd8weVSA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com, den@virtuozzo.com, alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 2/5] block/copy-before-write: support unligned
 snapshot-discard
Date: Wed, 28 Feb 2024 17:14:58 +0300
Message-Id: <20240228141501.455989-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228141501.455989-1-vsementsov@yandex-team.ru>
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 block/copy-before-write.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 3919d495d7..6547eda707 100644
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


