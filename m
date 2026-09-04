Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031B3C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Wca-0000nZ-OB; Fri, 04 Sep 2026 12:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcY-0000hH-Rm; Fri, 04 Sep 2026 12:18:30 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcX-0001Pu-5M; Fri, 04 Sep 2026 12:18:30 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED29F40E17;
 Fri,  4 Sep 2026 16:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B111F00A3D;
 Fri,  4 Sep 2026 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788538707;
 bh=PiicBwAq72HkDdAnMPdGC8GyvXZY0yDIQ/2KjOjW5YA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HLANPp/R/3dv1nI9R3NGaIo9T17dThlUnlwMMURUExc8pk0FNYnx+q52jx2JCqbsI
 ua7ObrQ9Op9I6Fb82Tjv5qIF2b9frE59nOSSTQICM8ALKjLB1zRM43hPpiocLmAaqE
 /EfCuaCFpaEBpfzifLNevJ0J3GMaugBwGyuJRI2a7ifczip0p0M3BnIkiBlp9lGESY
 uNhhshHQlWN+EUI4ONryHh3jB5VExY6ZAChTv7kz+qZy0OyE/yii6gPmr4fuYC/hKn
 gTEw/5K2n6M8Lcl01IQ93rQVAbqSOsT5ZG8lcicMz+7mHg8rRmrHG53FB2O+iwayjI
 LyLV1vCBVtswA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] block: reject zone appends that are not a multiple
 of the sector size
Date: Fri,  4 Sep 2026 18:17:55 +0200
Message-ID: <20260904161801.1568841-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904161801.1568841-1-cassel@kernel.org>
References: <20260904161801.1568841-1-cassel@kernel.org>
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
index 497247b684..b59c7fdf3e 100644
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


