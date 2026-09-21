Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D64C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2F-00039J-SV; Mon, 21 Sep 2026 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f11-000229-54; Mon, 21 Sep 2026 10:29:07 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0z-0000Fu-Fq; Mon, 21 Sep 2026 10:29:06 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A42E1411D4;
 Mon, 21 Sep 2026 14:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C71F000FF;
 Mon, 21 Sep 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000943;
 bh=kO8IHCng71x3mgW5KJPsYGi6K2oavSzDgmdvQLPLOrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h+B9+lLlIxMqmAaWsOe6S2DRJ2cLJsweDccWJ8WAw6lDYbK366LY6hAsU51bsHTE9
 v3hx6C7bx7FJTHyIaVhld6JO0Ugltf1N7PWkbPi4osS36fazBOZs7+f5e36bN/UieP
 RsEKv1ZLjJMP145GXKsAX11z45Fu0Vv5ZogEI713iijwhKzL1d7sVD/e0Zg/FyOLZe
 +j40aa4FWjxMqcnSD+xNGEVdyBlhAo/7w+Dk9GbeflkRvhXzUW/ni3yW/ni7bi07Pt
 cxcFa/+nz0dIMGvg06+7n+6UE0gXjxV9joyaFb713JWQIqwkTtZYpyWCEtwF5O4cxW
 APXAiKS+sFjFg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 10/15] file-posix: remove the zone append write granularity
 check
Date: Mon, 21 Sep 2026 16:28:12 +0200
Message-ID: <20260921142819.2916043-11-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
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

The check rejects a zone append whose individual iovec lengths are not
multiples of the zone write granularity. That is stricter than the
constraint it is meant to enforce, which applies to the size of the
request as a whole. A request whose total is properly aligned but which
is split across, say, a 512 byte and a 3584 byte iovec is refused here,
even though the iovec boundaries do not survive into the scatter gather
list that reaches the device.

Nor is the driver the right place to enforce it. The granularity that
holds for every backend is the sector granularity, which is now checked
once in bdrv_co_zone_append(). The coarser granularity that a guest has
to observe depends on the logical block size that the device was
configured with, so only a frontend can know it, and a frontend both
reports it to its guest and validates requests against it.

Drop the check. BlockLimits.write_granularity is then set in one place,
by this driver from the zone_write_granularity queue attribute, and read
in one place, where a device whose granularity the configured block sizes
cannot express is refused.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 00323f7a9f..c1ac49d23d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3593,8 +3593,6 @@ raw_co_zone_append(BlockDriverState *bs,
                    BdrvRequestFlags flags) {
     assert(flags == 0);
     int64_t zone_size_mask = bs->bl.zone_size - 1;
-    int64_t iov_len = 0;
-    int64_t len = 0;
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
@@ -3602,20 +3600,8 @@ raw_co_zone_append(BlockDriverState *bs,
         return -EINVAL;
     }
 
-    int64_t wg = bs->bl.write_granularity;
-    int64_t wg_mask = wg - 1;
-    for (int i = 0; i < qiov->niov; i++) {
-        iov_len = qiov->iov[i].iov_len;
-        if (iov_len & wg_mask) {
-            error_report("len of IOVector[%d] %" PRId64 " is not aligned to "
-                         "block size %" PRId64 "", i, iov_len, wg);
-            return -EINVAL;
-        }
-        len += iov_len;
-    }
-
     trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
-    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND, 0);
+    return raw_co_prw(bs, offset, qiov->size, qiov, QEMU_AIO_ZONE_APPEND, 0);
 }
 #endif
 
-- 
2.55.0


