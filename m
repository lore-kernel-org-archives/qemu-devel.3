Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067CCC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qtK-0000Vh-Kg; Wed, 02 Sep 2026 15:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtI-0000UN-1d; Wed, 02 Sep 2026 15:45:00 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtG-00061c-Ce; Wed, 02 Sep 2026 15:44:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 144ED43CA7;
 Wed,  2 Sep 2026 19:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F81F000E9;
 Wed,  2 Sep 2026 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378297;
 bh=wyZPqLbbh9rym5im2traSqQISjkSVit9l7lAXdX6ud4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j0fZdoiL/Dlg+2joMc08mrnOaqwRiKR3EwnvOrnN2Ui/AtCPNSDRn7PGTIVuxBGY8
 4a5VOv25kuqqSCaXL+vZOONcCkfHeVJMJRY2J5UJvnJaCWBxgl3i5Mw5dr5QCAVqz4
 vi+EE+TeRzlmvfelu+weKcevNgvZDQweUy4bI/1gXe0aHqbimZXCpqfXt3q1f/e5ta
 ARR8jfMTtg7uMTag6SQ0aNzKjXYo/NqQZkpJNGMfLXmAis8bvzDRVMdoDrqjBOssAQ
 WWHM+kLcC6n3ODO3Ipkx/rP4cNYYZb+XBTIv0kHvUHzL1JxOFlTeLcT1iaBdyumMCs
 cdjxt8MlKG3Sw==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] block: reject zone appends that are not a multiple
 of the sector size
Date: Wed,  2 Sep 2026 21:44:17 +0200
Message-ID: <20260902194423.759355-7-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194423.759355-1-cassel@kernel.org>
References: <20260902194423.759355-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


