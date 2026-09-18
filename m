Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B0FC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7cQe-0005m0-T5; Fri, 18 Sep 2026 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPW-0004fl-LF; Fri, 18 Sep 2026 13:30:09 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPU-0000JH-V2; Fri, 18 Sep 2026 13:30:06 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA64A60A55;
 Fri, 18 Sep 2026 17:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A431F000FF;
 Fri, 18 Sep 2026 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789752602;
 bh=ds0Q2Se8M1KwbjEypJ2cbUozvN0mlOq1Y9vIemv3l5k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FuBW3TuvyBdddPv+ZIthUR+9+CwXfcdw0DrouUyxYRSMiCEmgBXu/jKaSpZjDx04U
 caC9dZM81w+KIG3w4rsCyLl309OEtvsHv1KXfq4g7Ik/sMPyYFEIaPBI5fpwLHSk2N
 mTAHHnbFPxhwqKLg66ZO/sRIj31kltEQNoBIWc66Ff1yYyo/Uh7UDRFjKBfj6t/5Sz
 DvgmjTdsirSQzX4TMHkX9ni+W0+Vnir5/h91J9AzGvr5iXhuISEFrz8uftHt/fsKYe
 ZTQYGj9DT+k1AMAygVRIv3oE6TRZAD4+NdNQA98vI/avgCCrqLYsCRCS6mulRcg+Zy
 f+ZN2Yb8XszZw==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 10/15] file-posix: remove the zone append write granularity
 check
Date: Fri, 18 Sep 2026 19:29:18 +0200
Message-ID: <20260918172925.2640888-11-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918172925.2640888-1-cassel@kernel.org>
References: <20260918172925.2640888-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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


