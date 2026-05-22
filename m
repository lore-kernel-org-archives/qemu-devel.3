Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D667CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXbR-0003cn-VY; Fri, 22 May 2026 17:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbP-0003Um-Ux; Fri, 22 May 2026 17:40:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbN-0003eh-Fs; Fri, 22 May 2026 17:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485683; bh=2MMfs8x8eWAS6M/2CFqpS90zy2cejQ1Qv11C8unkwlg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L20AgoK4d+mMVsHSW/dksKW1OKAesY8uRGGfKo8rC0G2HdmdhsG+8DRknjCzFYTQB
 4Np4B5nuWtNkUCtjGrqYvZGveWBEXiD3H9G+uaja0dw68Ddws/gDazm0e4uqCrtUOo
 FYqXChIFL9EyexCOSPptKgRKPeGr2d8xCv6qGkRJ739z4+/hqsh8/QEj2lEmbfrQZ8
 6O64CGz5Xgq0ByuvKQvOYHdwEpAv9fKX56/GHCcPV2xpVDJOThnE+prPLm7+gHv7+8
 hBocmgm/YQ9QXpQZYE2h+Lp3NiIix6pCYQ2bt3hSPxBR3seyjmQoAUmU0rWnyZYWpg
 DcnGogh0w9T4g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B5EC21AFB0E;
 Sat, 23 May 2026 00:34:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA8583B718E;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 125/136] block: Add blk_co_start/end_request() and
 BDRV_REQ_NO_QUEUE
Date: Sat, 23 May 2026 00:34:33 +0300
Message-ID: <20260522213446.806182-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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

If a device uses blk_inc/dec_in_flight() in order to build macro
operations that involve multiple requests for the block layer and that
need to be completed as a unit before the BlockBackend can be considered
drained, it sets the stage for a deadlock: When a drain is requested,
the inner request at the BlockBackend level will be queued in
blk_wait_while_drained() and wait until the drained section ends, but at
the same time, drain_begin can only return if the whole macro operation
at the device level has completed.

Introduce a new interface to allow implementing the logic correctly:
Instead of queueing individual requests, blk_co_start_request() calls
blk_wait_while_drained() once at the beginning. The individual requests
must then set BDRV_REQ_NO_QUEUE to avoid being queued and running into
the deadlock; being wrapped in blk_co_start/end_request() makes sure
that drain_begin waits for them and they don't sneak in when the
BlockBackend is supposed to already be quiescent.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 34a67637767d3ed1ac813c44effe827bbfba5996)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 50ccf3663f..11ad178966 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -82,6 +82,7 @@ struct BlockBackend {
     QemuMutex queued_requests_lock; /* protects queued_requests */
     CoQueue queued_requests;
     bool disable_request_queuing; /* atomic */
+    int start_request_count; /* atomic */
 
     VMChangeStateEntry *vmsh;
     bool force_allow_inactivate;
@@ -1306,10 +1307,16 @@ bool blk_in_drain(BlockBackend *blk)
 }
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
-static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
+static void coroutine_fn blk_wait_while_drained(BlockBackend *blk,
+                                                BdrvRequestFlags flags)
 {
     assert(blk->in_flight > 0);
 
+    if (flags & BDRV_REQ_NO_QUEUE) {
+        assert(qatomic_read(&blk->start_request_count));
+        return;
+    }
+
     if (qatomic_read(&blk->quiesce_counter) &&
         !qatomic_read(&blk->disable_request_queuing)) {
         /*
@@ -1335,7 +1342,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     BlockDriverState *bs;
     IO_CODE();
 
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, flags);
     GRAPH_RDLOCK_GUARD();
 
     /* Call blk_bs() only after waiting, the graph may have changed */
@@ -1410,7 +1417,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     BlockDriverState *bs;
     IO_CODE();
 
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, flags);
     GRAPH_RDLOCK_GUARD();
 
     /* Call blk_bs() only after waiting, the graph may have changed */
@@ -1523,6 +1530,19 @@ void blk_dec_in_flight(BlockBackend *blk)
     aio_wait_kick();
 }
 
+void coroutine_fn blk_co_start_request(BlockBackend *blk)
+{
+    blk_inc_in_flight(blk);
+    blk_wait_while_drained(blk, 0);
+    qatomic_inc(&blk->start_request_count);
+}
+
+void blk_end_request(BlockBackend *blk)
+{
+    qatomic_dec(&blk->start_request_count);
+    blk_dec_in_flight(blk);
+}
+
 static void error_callback_bh(void *opaque)
 {
     struct BlockBackendAIOCB *acb = opaque;
@@ -1741,7 +1761,7 @@ blk_co_do_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 {
     IO_CODE();
 
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
 
     if (!blk_co_is_available(blk)) {
@@ -1788,7 +1808,7 @@ blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
     int ret;
     IO_CODE();
 
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
 
     ret = blk_check_byte_request(blk, offset, bytes);
@@ -1834,7 +1854,7 @@ int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
 static int coroutine_fn blk_co_do_flush(BlockBackend *blk)
 {
     IO_CODE();
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
 
     if (!blk_co_is_available(blk)) {
@@ -2009,7 +2029,7 @@ int coroutine_fn blk_co_zone_report(BlockBackend *blk, int64_t offset,
     IO_CODE();
 
     blk_inc_in_flight(blk); /* increase before waiting */
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
     if (!blk_is_available(blk)) {
         blk_dec_in_flight(blk);
@@ -2034,7 +2054,7 @@ int coroutine_fn blk_co_zone_mgmt(BlockBackend *blk, BlockZoneOp op,
     IO_CODE();
 
     blk_inc_in_flight(blk);
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, 0);
     GRAPH_RDLOCK_GUARD();
 
     ret = blk_check_byte_request(blk, offset, len);
@@ -2058,7 +2078,7 @@ int coroutine_fn blk_co_zone_append(BlockBackend *blk, int64_t *offset,
     IO_CODE();
 
     blk_inc_in_flight(blk);
-    blk_wait_while_drained(blk);
+    blk_wait_while_drained(blk, flags);
     GRAPH_RDLOCK_GUARD();
     if (!blk_is_available(blk)) {
         blk_dec_in_flight(blk);
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 0b831ef87b..d4852e944c 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -215,8 +215,17 @@ typedef enum {
      */
     BDRV_REQ_NO_WAIT = 0x400,
 
+    /*
+     * Used between blk_co_start_request() and blk_end_request() to avoid
+     * that the request waits in a drained BlockBackend until the drained
+     * section ends. Waiting would cause a deadlock because drain waits for
+     * blk_end_request() to be called, but the request never completes
+     * because it waits for the drain to end.
+     */
+    BDRV_REQ_NO_QUEUE = 0x800,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x7ff,
+    BDRV_REQ_MASK               = 0xfff,
 } BdrvRequestFlags;
 
 #define BDRV_O_NO_SHARE    0x0001 /* don't share permissions */
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index ba8dfcc7d0..59841e04a8 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -71,6 +71,8 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 
 void blk_inc_in_flight(BlockBackend *blk);
 void blk_dec_in_flight(BlockBackend *blk);
+void coroutine_fn blk_co_start_request(BlockBackend *blk);
+void blk_end_request(BlockBackend *blk);
 
 bool coroutine_fn GRAPH_RDLOCK blk_co_is_inserted(BlockBackend *blk);
 bool co_wrapper_mixed_bdrv_rdlock blk_is_inserted(BlockBackend *blk);
-- 
2.47.3


