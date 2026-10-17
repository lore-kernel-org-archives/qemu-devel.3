Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF6CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9eQ-0006fq-Ma; Sat, 17 Oct 2026 15:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9d2-0005Jn-9T; Sat, 17 Oct 2026 14:59:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9d0-0003zS-D5; Sat, 17 Oct 2026 14:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263410; bh=Dg8HAUdamYBN061rFx5Tmq0LNxTmZA2/5JFRg3UBEok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CfB8BImLU524ZNZNjjAYwSLlqBPLMIEhtHwoZHHvt9Me9PYvHj4fyrDEWvhKhs5/6
 pFf21yWz2DgQm+e0Y+VCLERankAtUG6dFfgAKSz24nCH3wVV7iv12Ox+8S46Ih1ygx
 znEy+ZaTdKKuViZ/CRt1r3jFS6rW2t3NPqYimSutHrrrpjifX+vUJDKhxmJre+1BRI
 qGPlU4FZvq48pi9WvttYkAKv6VMRr2kWmLcZsOadvy/O8sU8EclILbT6u7NOHA9LFs
 ur0VJAWcPtdOSzWLRbuFd/SPobeURgrDO1uqV5N4tW87W5IQiENgdEM/ZThc4/sz9y
 MFogFKzq2rVhA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 55C271DE6CC;
 Sat, 17 Oct 2026 21:56:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3CBFB443395;
 Sat, 17 Oct 2026 21:56:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 42/63] block: Remove now redundant
 bdrv_wait_serialising_requests() calls
Date: Sat, 17 Oct 2026 21:54:58 +0300
Message-ID: <20261017185528.722197-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

All callers of bdrv_wait_serialising_requests() (as opposed to
bdrv_wait_serialising_requests_locked()) are just duplicating the check
that tracked_request_begin() already performs now. After removing them,
bdrv_wait_serialising_requests() has no callers left and can go as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261002132135.93345-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit cf4f672c11d663f87462cfd99a92124b30804e99)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index ae28a0ada1..6ffbe26d4c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -806,20 +806,6 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-static void coroutine_fn
-bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
-{
-    BlockDriverState *bs = self->bs;
-
-    if (!qatomic_read(&bs->serialising_in_flight)) {
-        return;
-    }
-
-    qemu_mutex_lock(&bs->reqs_lock);
-    bdrv_wait_serialising_requests_locked(self);
-    qemu_mutex_unlock(&bs->reqs_lock);
-}
-
 void coroutine_fn bdrv_make_request_serialising(BdrvTrackedRequest *req,
                                                 uint64_t align)
 {
@@ -1387,8 +1373,6 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
         bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
-    } else {
-        bdrv_wait_serialising_requests(req);
     }
 
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -2025,8 +2009,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
         }
 
         bdrv_wait_serialising_requests_locked(req);
-    } else {
-        bdrv_wait_serialising_requests(req);
     }
 
     assert(req->overlap_offset <= offset);
@@ -3476,7 +3458,6 @@ static int coroutine_fn GRAPH_RDLOCK bdrv_co_copy_range_internal(
 
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
-        bdrv_wait_serialising_requests(&req);
 
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
-- 
2.47.3


