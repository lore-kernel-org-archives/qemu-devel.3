Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A456CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXnd-0007Yb-GN; Fri, 22 May 2026 17:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXnb-0007Ia-3X; Fri, 22 May 2026 17:52:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXnZ-0004pR-2a; Fri, 22 May 2026 17:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=mjCVHlbBqsBhNHaMV81ofn1gao8FpAyUFLppKRHX0sM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tLIq2jXh1D7SZgmuLwkyVLUBmirEHAAc7V+JO/Bnsz1SiFIC30EX2W7rB0ZoaLf7n
 hORymK1myai0bSLg5N7NU6am3R2HAjIwRlqyM7opXFgoOJurBHWUbYPQD3U3y6pjn+
 GohoaLuKBYrGi83Q3i8njJ7UVIy76L7DvnbDYT7qX8/6JzPrA12QGO4Xhrl9gZOsZU
 PDQ1ZJc0Z8P//9ytMxc6i3QFOknFncUPIvi0/ZDFHE2w4uwvk8HSeyHmiKXc2hIEOv
 KcyV+s+Csoo4z22NKisildmVqWfwHzMfPV94HTmUhxTtEJycW4lcKgPwsgS5dcPGpA
 1E5vaC43mfXkA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 902931AFB80;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B98C73B71CF;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 138/149] block: Add flags parameter to blk_*_pdiscard()
Date: Sat, 23 May 2026 00:49:10 +0300
Message-ID: <20260522214923.807017-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

All existing callers pass 0, but we need a way to pass BDRV_REQ_NO_QUEUE
for discard requests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 53074ba0330ae8831abbae2521c012e1d9072ed3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index b8d877c4e7..850f2ecec2 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1803,12 +1803,13 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
+blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
+                   BdrvRequestFlags flags)
 {
     int ret;
     IO_CODE();
 
-    blk_wait_while_drained(blk, 0);
+    blk_wait_while_drained(blk, flags);
     GRAPH_RDLOCK_GUARD();
 
     ret = blk_check_byte_request(blk, offset, bytes);
@@ -1824,7 +1825,7 @@ static void coroutine_fn blk_aio_pdiscard_entry(void *opaque)
     BlkAioEmAIOCB *acb = opaque;
     BlkRwCo *rwco = &acb->rwco;
 
-    rwco->ret = blk_co_do_pdiscard(rwco->blk, rwco->offset, acb->bytes);
+    rwco->ret = blk_co_do_pdiscard(rwco->blk, rwco->offset, acb->bytes, 0);
     blk_aio_complete(acb);
 }
 
@@ -1838,13 +1839,13 @@ BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
 }
 
 int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
-                                 int64_t bytes)
+                                 int64_t bytes, BdrvRequestFlags flags)
 {
     int ret;
     IO_OR_GS_CODE();
 
     blk_inc_in_flight(blk);
-    ret = blk_co_do_pdiscard(blk, offset, bytes);
+    ret = blk_co_do_pdiscard(blk, offset, bytes, flags);
     blk_dec_in_flight(blk);
 
     return ret;
diff --git a/block/export/virtio-blk-handler.c b/block/export/virtio-blk-handler.c
index bc1cec6757..b82baae553 100644
--- a/block/export/virtio-blk-handler.c
+++ b/block/export/virtio-blk-handler.c
@@ -121,7 +121,7 @@ virtio_blk_discard_write_zeroes(VirtioBlkHandler *handler, struct iovec *iov,
         }
 
         if (blk_co_pdiscard(blk, sector << VIRTIO_BLK_SECTOR_BITS,
-                            bytes) == 0) {
+                            bytes, 0) == 0) {
             return VIRTIO_BLK_S_OK;
         }
     }
diff --git a/block/mirror.c b/block/mirror.c
index 2fcded9e93..089856f4a8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -454,7 +454,7 @@ static void coroutine_fn mirror_co_discard(void *opaque)
     *op->bytes_handled = op->bytes;
     op->is_in_flight = true;
 
-    ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes);
+    ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes, 0);
     mirror_write_complete(op, ret);
 }
 
@@ -1532,7 +1532,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                          zero_bitmap_end - zero_bitmap_offset);
         }
         assert(!qiov);
-        ret = blk_co_pdiscard(job->target, offset, bytes);
+        ret = blk_co_pdiscard(job->target, offset, bytes, 0);
         break;
 
     default:
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index 0248c1c36e..fd84723d9d 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -218,9 +218,9 @@ int co_wrapper_mixed blk_zone_append(BlockBackend *blk, int64_t *offset,
                                          BdrvRequestFlags flags);
 
 int co_wrapper_mixed blk_pdiscard(BlockBackend *blk, int64_t offset,
-                                  int64_t bytes);
+                                  int64_t bytes, BdrvRequestFlags flags);
 int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
-                                 int64_t bytes);
+                                 int64_t bytes, BdrvRequestFlags flags);
 
 int co_wrapper_mixed blk_flush(BlockBackend *blk);
 int coroutine_fn blk_co_flush(BlockBackend *blk);
diff --git a/nbd/server.c b/nbd/server.c
index acec0487a8..bd103a8840 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2984,7 +2984,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "flush failed", errp);
 
     case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->common.blk, request->from, request->len);
+        ret = blk_co_pdiscard(exp->common.blk, request->from, request->len, 0);
         if (ret >= 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->common.blk);
         }
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 13e0330162..f6d077908f 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2201,7 +2201,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
     }
 
     clock_gettime(CLOCK_MONOTONIC, &t1);
-    ret = blk_pdiscard(blk, offset, bytes);
+    ret = blk_pdiscard(blk, offset, bytes, 0);
     clock_gettime(CLOCK_MONOTONIC, &t2);
 
     if (ret < 0) {
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index e26b3be593..5273ff235a 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -270,11 +270,11 @@ static void test_sync_op_blk_pdiscard(BlockBackend *blk)
     int ret;
 
     /* Early success: UNMAP not supported */
-    ret = blk_pdiscard(blk, 0, 512);
+    ret = blk_pdiscard(blk, 0, 512, 0);
     g_assert_cmpint(ret, ==, 0);
 
     /* Early error: Negative offset */
-    ret = blk_pdiscard(blk, -2, 512);
+    ret = blk_pdiscard(blk, -2, 512, 0);
     g_assert_cmpint(ret, ==, -EIO);
 }
 
-- 
2.47.3


