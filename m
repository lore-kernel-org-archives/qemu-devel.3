Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AAAC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyDy-0001EV-L6; Tue, 25 Aug 2026 16:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDr-0001Ad-Vy; Tue, 25 Aug 2026 16:58:20 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDp-0003EF-4l; Tue, 25 Aug 2026 16:58:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E250041889;
 Tue, 25 Aug 2026 20:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958D1F000E9;
 Tue, 25 Aug 2026 20:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691495;
 bh=ALKx1sZjhdbOJdc+aaF6o0PlVsXA7hiwS+FdiSVtflM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eDoWRj+4rjJZsllHQCHwlXrPx/n0uF+e1XuAetFC3Bmi/Z501/XY735NnNOmZgMCB
 SezqVV7YSyd1Dq3srEdR/0blW73eo9/L323/DGDmfGqYOuaIfyisG4zujlbwXnvXjq
 R4LTBRu2/d879FGIALAh2CYxK/YMKJeTRPMFgNAK5tirDXOxvRLh+PN3htXYgVAL26
 4qVas04YB9EcvvlLGZrjUT3+6CBv7JdLiAXt3jDBOJhgLqp9PUC9NDk8G6drlTzYrc
 bi8dwVGvMXPFE0pQOPMN0O5CTkYyvl6rt4v5O89HJRfNe8xnGbELC9sAYAY0Ru8tpV
 ysxecSXe/ASzg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 07/12] block: reject zone appends that are not a multiple of
 the sector size
Date: Tue, 25 Aug 2026 22:57:42 +0200
Message-ID: <20260825205748.679968-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825205748.679968-1-cassel@kernel.org>
References: <20260825205748.679968-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zone write pointers are tracked and reported in units of
BDRV_SECTOR_SIZE, so an append whose data size is not a multiple of it
would leave a write pointer that cannot be represented, neither in a
BlockZoneDescriptor nor in the virtio and NVMe zone reports derived from
one.

Nothing states that invariant. file-posix, the only driver that carries
out an append itself, does enforce it, but only as a side effect of
checking each iovec against BlockLimits.write_granularity, which is never
smaller than the sector size. That conflates two constraints: the sector
granularity holds for every driver, whereas write_granularity describes a
coarser requirement of the medium below a driver, and only a driver that
has such a medium should express it.

Check the invariant once in bdrv_co_zone_append(), so that it no longer
rests on a driver that happens to have a granularity of its own to
report.

This is a lower bound, not the alignment that a guest has to observe. The
block layer cannot know that one, because it also depends on the logical
block size the device is configured with, which is a property of the
frontend. The alignment that applies to a guest is the larger of the two,
and it is the frontend that reports it, that validates requests against
it, and that has to refuse a device whose write pointers do not satisfy
it.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/io.c b/block/io.c
index a916b236c3..705dc73d76 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3350,6 +3350,16 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
         return ret;
     }
 
+    /*
+     * Zone write pointers are kept and reported in units of BDRV_SECTOR_SIZE,
+     * so an append that would leave a write pointer at a finer granularity
+     * cannot be represented. Drivers may impose a coarser granularity of their
+     * own, see BlockLimits.write_granularity.
+     */
+    if (!QEMU_IS_ALIGNED(qiov->size, BDRV_SECTOR_SIZE)) {
+        return -EINVAL;
+    }
+
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
         co.ret = -ENOTSUP;
-- 
2.55.0


