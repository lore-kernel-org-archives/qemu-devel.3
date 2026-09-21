Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B557C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2G-0003BJ-JJ; Mon, 21 Sep 2026 10:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0x-0001yU-Uw; Mon, 21 Sep 2026 10:29:05 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0w-0000DH-Eo; Mon, 21 Sep 2026 10:29:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 420B643583;
 Mon, 21 Sep 2026 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EC31F000FF;
 Mon, 21 Sep 2026 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000941;
 bh=QXQW7Tj/vJ/h2pt+4J+vyvcuNjENXHEnBN7dKAAkOdE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E1qXfFPKZdpmZWb71hwmUki4gBAASEXhh7RUnnEV8j+gvI7B5w7now+7AdxS5u6m3
 WByspSSP81JspCxKKZnfDy5b3UuDoZFYZRjEQiSnLO0N13HPukobac/AalAaCKZRYC
 844ZLUHwocVNIvjz+NJVJJLf0MK0dkicv34MbHtj65+v0IHR/HcJbaa7yKy74fELui
 w2Gz24TdfxK6o7gV9QuIKyOykzW/wHp5M59xj5bhtTEjaroJ3Gq7bGwM3naRzb20K2
 cAtCSw0jzCaIQyV4MSxppEFyxLpqkr7HE7V1PQXB29dns8k3iGDHfFT1AdGWcQa23o
 kDi3ALkwe0gHQ==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 09/15] block: reject a zone append that is larger than a
 zone
Date: Mon, 21 Sep 2026 16:28:11 +0200
Message-ID: <20260921142819.2916043-10-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
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

A zone append cannot cross a zone boundary, so a request larger than a
zone can never be carried out.

Nothing rejects one. The block layer does not look at the length at all,
and raw_co_zone_append() writes qiov->size bytes at the write pointer
once it has validated the offset, so the write runs past the end of the
zone: on a disk with 8 MiB zones, an append of 8 MiB plus one block
fills the zone and advances the write pointer of the zone after it.

virtio-blk does compare the length, but against
BlockLimits.max_append_sectors, which is how much the backend takes in
one command and not how large a zone is. For a Linux block device that
value is never larger than a zone, so virtio-blk is protected by what
the backend happens to report rather than by the check it makes.

Check the length in bdrv_co_zone_append(), next to the check that an
append is a multiple of the sector size. Both are conditions of the
operation rather than of a medium, so the block layer is where they hold
for every caller and where no driver has to repeat them.

The exact bound is tighter: a request also has to fit in the part of the
zone that is still writable, which depends on the write pointer and so
stays with the drivers.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/io.c b/block/io.c
index b9d0b3fd7b..d7c403bc08 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3365,6 +3365,18 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
         return -EINVAL;
     }
 
+    /*
+     * An append cannot cross a zone boundary, so one that is larger than a
+     * zone can never be carried out, wherever the write pointer of the zone
+     * is. The exact bound is the part of the zone that is still writable,
+     * which only a driver can check, as only it holds the write pointer.
+     * zone_size is zero when the device is not zoned, which is reported as
+     * unsupported below.
+     */
+    if (bs->bl.zone_size && qiov->size > bs->bl.zone_size) {
+        return -EINVAL;
+    }
+
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
         co.ret = -ENOTSUP;
-- 
2.55.0


