Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFDEE9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFwd-0002DL-3L; Mon, 29 Dec 2025 11:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwN-00021T-0V; Mon, 29 Dec 2025 11:17:51 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwI-0005OM-HO; Mon, 29 Dec 2025 11:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=DaI7hOh3RGqnTJuV0wMRfdPHrqPRwLR2pUWdXAkbt2k=; b=jSQb4isgM/DF
 /JmQO96JEN5o4gkTlF1dF+U31WWvS+39qezWMa9ALunBWhlxRz9JD9MpYMItI0SURWfkL4p9g+AwJ
 acNY5ElyGaCFXcVhHDYrh9UUxLIGOBlX8tQOXjLjEmxLjamO+WKSFeuxAHpYd2tksOekCttuPBOjb
 o8xTmlOqv2tQcf7HYBHQP+rvwUt9Uab89KpkqsigG+n64dWmmxB72+3SNEtCP2jCJu4TFjfP/E9Kc
 +vBqcZkoMxPdPEnZXSVFTs4pjb483O+iJvkzuhKWJ8R/OvIr6Cp3fBhXy7Qs8aIf80lqVZdvx2FJw
 8VsGp0zCoG+1lEDYY/dmJQ==;
Received: from [10.193.1.107] (helo=dev007.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1vaFvu-00Apz0-2Z;
 Mon, 29 Dec 2025 17:17:33 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/3] block: move bdrv_advance_flush_gen() earlier from
 bdrv_co_write_req_finish
Date: Mon, 29 Dec 2025 19:07:44 +0300
Message-ID: <20251229161740.758800-3-den@openvz.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229161740.758800-1-den@openvz.org>
References: <20251229161740.758800-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This helper is mandatory to be called before bdrv_co_flush(). In the
other case bdrv_co_flush() will be noop. This helper should be called
after actual write is completed for subsequent flush to perform some
work.

Actually this change is important, without it BDRV_REQ_FUA semantics is
broken completely. flush() is not called. This smells like potential
data loss if somebody relies on BDRV_REQ_FUA.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/io.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/block/io.c b/block/io.c
index f39ff862c11..820b41fab12 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1163,8 +1163,11 @@ bdrv_driver_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
     ret = drv->bdrv_co_writev(bs, sector_num, nb_sectors, qiov, flags);
 
 emulate_flags:
-    if (ret == 0 && emulate_fua) {
-        ret = bdrv_co_flush(bs);
+    if (ret == 0) {
+        bdrv_advance_flush_gen(bs);
+        if (emulate_fua) {
+            ret = bdrv_co_flush(bs);
+        }
     }
 
     if (qiov == &local_qiov) {
@@ -2077,8 +2080,11 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     }
 
 fail:
-    if (ret == 0 && need_flush) {
-        ret = bdrv_co_flush(bs);
+    if (ret == 0) {
+        bdrv_advance_flush_gen(bs);
+        if (need_flush) {
+            ret = bdrv_co_flush(bs);
+        }
     }
     qemu_vfree(buf);
     return ret;
@@ -2147,8 +2153,6 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
 
     bdrv_check_request(offset, bytes, &error_abort);
 
-    bdrv_advance_flush_gen(bs);
-
     /*
      * Discard cannot extend the image, but in error handling cases, such as
      * when reverting a qcow2 cluster allocation, the discarded range can pass
@@ -3720,6 +3724,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
     }
     ret = 0;
 out:
+    bdrv_advance_flush_gen(bs);
     bdrv_co_write_req_finish(child, req.offset, req.bytes, &req, ret);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
@@ -3994,6 +4000,7 @@ static int coroutine_fn GRAPH_RDLOCK bdrv_co_copy_range_internal(
                                                       bytes,
                                                       read_flags, write_flags);
         }
+        bdrv_advance_flush_gen(dst->bs);
         bdrv_co_write_req_finish(dst, dst_offset, bytes, &req, ret);
         tracked_request_end(&req);
         bdrv_dec_in_flight(dst->bs);
@@ -4187,6 +4194,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
     } else {
         offset = bs->total_sectors * BDRV_SECTOR_SIZE;
     }
+    bdrv_advance_flush_gen(bs);
     /*
      * It's possible that truncation succeeded but bdrv_refresh_total_sectors
      * failed, but the latter doesn't affect how we should finish the request.
-- 
2.43.5


