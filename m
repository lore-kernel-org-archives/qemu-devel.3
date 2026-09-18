Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A910C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7cR0-00069y-KI; Fri, 18 Sep 2026 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPj-0004qg-5L; Fri, 18 Sep 2026 13:30:19 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPg-0000Ww-5T; Fri, 18 Sep 2026 13:30:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CABD6053D;
 Fri, 18 Sep 2026 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00B31F000FF;
 Fri, 18 Sep 2026 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789752614;
 bh=wkePXI2ZAhs57urNC3Xrzyj8N64ULkLTlQbeBh3xUWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CVzQrGourI1q4QpFbSes7/dYfTMPKYo7gTMSfl3V+pucUJZZMVnfKfSSybkK5fzJw
 t1rSKRQ3xrpzwtwo6cMc5GsNyGAnevTu3UJ4BwT5f+5yoPvJJ9EShCjiPZVZfOR40I
 4Xr2ymvLUY53KNWxxsIYPUKcPBG0tNes/RokfJGXh08XdApA6Tv+XZJFnVJFG2S0bP
 gy2ODR1/9fEL6rv2L45/yBKnmBQblIkUa2mdnl9QAHqYNNtigBxE8Uo+ds3bGFMDA+
 BT9OzygS1vkYZRqna5/I/LKigOd3KRX7VnRvjRIb2gqwwiihSVHn1n0zI0Ib8QYqpN
 E2y8llc2ePUJA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 15/15] block: do not use CoroutineIOCompletion to hold a
 return value
Date: Fri, 18 Sep 2026 19:29:23 +0200
Message-ID: <20260918172925.2640888-16-cassel@kernel.org>
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

bdrv_co_zone_report(), bdrv_co_zone_mgmt() and bdrv_co_zone_append() each
declare a CoroutineIOCompletion in order to use its ret field, and never
touch the coroutine field that the rest of the structure exists for.

That structure is for a request which completes through
bdrv_co_io_em_complete(), where the callback has to store the result
somewhere and wake the coroutine that is waiting for it. These three call
into the driver directly and are already running in the coroutine that
wants the result, so there is nothing to wake and nowhere else for the
value to live.

Use a plain int. bdrv_co_zone_append() already has one.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/io.c b/block/io.c
index a4fb56f799..c62c3764d3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3303,40 +3303,36 @@ int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t offset,
                         BlockZoneDescriptor *zones)
 {
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
+    int ret;
     IO_CODE();
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_report || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_report(bs, offset, nr_zones, zones);
+    ret = drv->bdrv_co_zone_report(bs, offset, nr_zones, zones);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 int coroutine_fn bdrv_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
         int64_t offset, int64_t len)
 {
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
+    int ret;
     IO_CODE();
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_mgmt || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_mgmt(bs, op, offset, len);
+    ret = drv->bdrv_co_zone_mgmt(bs, op, offset, len);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
@@ -3345,9 +3341,6 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
 {
     int ret;
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
     IO_CODE();
 
     ret = bdrv_check_qiov_request(*offset, qiov->size, qiov, 0, NULL);
@@ -3379,13 +3372,13 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_append(bs, offset, qiov, flags);
+    ret = drv->bdrv_co_zone_append(bs, offset, qiov, flags);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
-- 
2.55.0


