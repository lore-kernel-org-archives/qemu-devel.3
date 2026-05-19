Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF3CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrD-00082M-H3; Tue, 19 May 2026 13:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr5-0007yL-8w
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr0-0004CG-B9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMT/antuLqZyS5oYFLZbd0Cv7OFEzbG2EjWvbMi6YI4=;
 b=c/yJRTFanzOmjU0U9LFYyxZOUUsgzwxl8y6RVMMNcIeyuJ4hudV6okucCxNsgdknA3Dm4X
 72Y5EWCKAvTscDMFkZ1EmHIPFGhVmzzyWIzartvAmakCtguREYsjS/c1ipNqtAZEsb/jdR
 Qoiwvkd6jrkKrZSsENCTo+PopsxKtm8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-svxVMi4uNMOV_Vt8mxt83Q-1; Tue,
 19 May 2026 13:03:33 -0400
X-MC-Unique: svxVMi4uNMOV_Vt8mxt83Q-1
X-Mimecast-MFC-AGG-ID: svxVMi4uNMOV_Vt8mxt83Q_1779210212
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D0D19560A7; Tue, 19 May 2026 17:03:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A23E81681; Tue, 19 May 2026 17:03:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/18] block: Add blk_co_start/end_request() and
 BDRV_REQ_NO_QUEUE
Date: Tue, 19 May 2026 19:03:01 +0200
Message-ID: <20260519170317.345032-3-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 include/block/block-common.h      | 11 ++++++++-
 include/system/block-backend-io.h |  2 ++
 block/block-backend.c             | 38 +++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index c8c626daeaa..895ea175413 100644
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
index 6d5ac476fc0..0248c1c36e2 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -71,6 +71,8 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 
 void blk_inc_in_flight(BlockBackend *blk);
 void blk_dec_in_flight(BlockBackend *blk);
+void coroutine_fn blk_co_start_request(BlockBackend *blk);
+void blk_end_request(BlockBackend *blk);
 
 bool coroutine_fn GRAPH_RDLOCK blk_co_is_inserted(BlockBackend *blk);
 bool co_wrapper_mixed_bdrv_rdlock blk_is_inserted(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 99446571201..ee00440e28d 100644
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
-- 
2.54.0


