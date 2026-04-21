Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CE8F8FA9D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDiE-0001SU-C3; Tue, 21 Apr 2026 12:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDi3-0001PT-Nd
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDhz-0000In-S6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776787938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhqC91BLULK2bubCupahOYep/yxmCAr4UDM1WsqQ1NI=;
 b=Ak03Jnnz2H0HfUHsuyHeepkQkN0noJe6qEh6AB9mh8iPgCgBjHoktho56OkDaVz2nqGG2t
 tukukMxIN2VNhBLAK7w/u0gkwTMQiMrSu7Ll4eMVmHWlMTMAMeWy/iK9Gy0l2WJDCeJ30d
 cAb75nqLgLbTmEIVPhOjGoQ2/eb8rlU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-xx__dSBGOTqP3JBQmVcE7Q-1; Tue,
 21 Apr 2026 12:12:09 -0400
X-MC-Unique: xx__dSBGOTqP3JBQmVcE7Q-1
X-Mimecast-MFC-AGG-ID: xx__dSBGOTqP3JBQmVcE7Q_1776787928
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63DBA19560B7; Tue, 21 Apr 2026 16:12:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9651D1800660; Tue, 21 Apr 2026 16:12:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 3/7] block: Add flags parameter to blk_*_pdiscard()
Date: Tue, 21 Apr 2026 18:11:28 +0200
Message-ID: <20260421161132.99878-4-kwolf@redhat.com>
In-Reply-To: <20260421161132.99878-1-kwolf@redhat.com>
References: <20260421161132.99878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All existing callers pass 0, but we need a way to pass BDRV_REQ_NO_QUEUE
for discard requests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/block-backend-io.h |  4 ++--
 block/block-backend.c             | 11 ++++++-----
 block/export/virtio-blk-handler.c |  2 +-
 block/mirror.c                    |  4 ++--
 nbd/server.c                      |  2 +-
 qemu-io-cmds.c                    |  2 +-
 tests/unit/test-block-iothread.c  |  4 ++--
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index 0248c1c36e2..fd84723d9d0 100644
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
diff --git a/block/block-backend.c b/block/block-backend.c
index ee00440e28d..37ba7e9fc40 100644
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
index 3dd6c43af1a..eaa6fc19067 100644
--- a/block/export/virtio-blk-handler.c
+++ b/block/export/virtio-blk-handler.c
@@ -122,7 +122,7 @@ virtio_blk_discard_write_zeroes(VirtioBlkHandler *handler, struct iovec *iov,
         }
 
         if (blk_co_pdiscard(blk, sector << VIRTIO_BLK_SECTOR_BITS,
-                            bytes) == 0) {
+                            bytes, 0) == 0) {
             return VIRTIO_BLK_S_OK;
         }
     }
diff --git a/block/mirror.c b/block/mirror.c
index 2fcded9e93d..089856f4a84 100644
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
diff --git a/nbd/server.c b/nbd/server.c
index 620097c58ca..78ec9844097 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2990,7 +2990,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "flush failed", errp);
 
     case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->common.blk, request->from, request->len);
+        ret = blk_co_pdiscard(exp->common.blk, request->from, request->len, 0);
         if (ret >= 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->common.blk);
         }
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 13e03301624..f6d077908f2 100644
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
index e26b3be5939..5273ff235a2 100644
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
2.53.0


