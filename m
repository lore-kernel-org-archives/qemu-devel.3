Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8C7C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f1s-0002Qj-9h; Mon, 21 Sep 2026 10:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0v-0001xv-Ci; Mon, 21 Sep 2026 10:29:05 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0t-00009g-Ox; Mon, 21 Sep 2026 10:29:01 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6103600D1;
 Mon, 21 Sep 2026 14:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DBE1F000FF;
 Mon, 21 Sep 2026 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000938;
 bh=K/E7mfkyMsocMU2GeW0n4nAwhy2Ey6wmw7TpzmiJTl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GoptpolYDnux9B6aLDHVS3i21VZgVzq8P1se4medbHluDatBkPzedepcWpsNkJhrj
 Cmup3wxE9dCM6G/LPRi172/WC5zirrE34UDwBa1ZbAAhLvIpaPhxL1BzZJ4jqoY/HD
 y2w0yUL7vWpAJ9ZI0YfCrsxo6kx45ye9zBvPI0dbZ8na7Bb9Q/EcU2MZyyLcTYHjNq
 p47mA0kl2RApWyOnELihVidEC2JWoIWVihePABr3re9Sd5S+iU4WN2/7TngVk4kmX9
 C4DQCrGLiCV0Rady6QUtnk5SRmcQm8TbQuDKXCPO+IOyrIEcnWM7q+YqLeiiK9hUZv
 gR7W9uClzB74w==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 08/15] block: reject zone appends that are not a multiple
 of the sector size
Date: Mon, 21 Sep 2026 16:28:10 +0200
Message-ID: <20260921142819.2916043-9-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/io.c b/block/io.c
index da61e641ac..b9d0b3fd7b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3355,6 +3355,16 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
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


