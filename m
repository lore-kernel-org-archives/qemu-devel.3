Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CD7CEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP7b-00018b-OF; Tue, 18 Nov 2025 12:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7O-0000kJ-Td
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7N-0004sE-1Z
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvlBWOnuqC341AWylfcP0hxrPj6wPkTp3K7xJ0YBJ34=;
 b=Ev9847snuo8Toizh13yWOQ1WSM6Vh9sycAHMQ+6pafk1CXutKRIukp9vUNXMMhZzgsNJMm
 kHVDo9qWrb39lo5XHmOqnPneJXCqayZRgtEQzD9acH3h9VEDMftUZYIONYanRh3P/jNms+
 1eu/upLrhWM8bCa1A8QHnqcTAqocaY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-JzQyx6DdPSCTem-OHAeLIQ-1; Tue,
 18 Nov 2025 12:03:46 -0500
X-MC-Unique: JzQyx6DdPSCTem-OHAeLIQ-1
X-Mimecast-MFC-AGG-ID: JzQyx6DdPSCTem-OHAeLIQ_1763485425
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 101C3195608D; Tue, 18 Nov 2025 17:03:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CD86300A88D; Tue, 18 Nov 2025 17:03:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/19] win32-aio: Run CB in original context
Date: Tue, 18 Nov 2025 18:02:56 +0100
Message-ID: <20251118170256.272087-20-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hanna Czenczek <hreitz@redhat.com>

AIO callbacks must be called in the originally calling AioContext,
regardless of the BDS’s “main” AioContext.

Note: I tried to test this (under wine), but failed.  Whenever I tried
to use multiqueue or even just an I/O thread for a virtio-blk (or
virtio-scsi) device, I/O stalled, both with and without this patch.

For what it’s worth, when not using an I/O thread, I/O continued to work
with this patch.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-20-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/win32-aio.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/win32-aio.c b/block/win32-aio.c
index 6327861e1d..f0689f3ee9 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -48,48 +48,62 @@ struct QEMUWin32AIOState {
 typedef struct QEMUWin32AIOCB {
     BlockAIOCB common;
     struct QEMUWin32AIOState *ctx;
+    AioContext *req_ctx;
     int nbytes;
     OVERLAPPED ov;
     QEMUIOVector *qiov;
     void *buf;
     bool is_read;
     bool is_linear;
+    int ret;
 } QEMUWin32AIOCB;
 
+static void win32_aio_completion_cb_bh(void *opaque)
+{
+    QEMUWin32AIOCB *waiocb = opaque;
+
+    waiocb->common.cb(waiocb->common.opaque, waiocb->ret);
+    aio_context_unref(waiocb->req_ctx);
+    qemu_aio_unref(waiocb);
+}
+
 /*
  * Completes an AIO request (calls the callback and frees the ACB).
  */
 static void win32_aio_process_completion(QEMUWin32AIOState *s,
     QEMUWin32AIOCB *waiocb, DWORD count)
 {
-    int ret;
     s->count--;
 
     if (waiocb->ov.Internal != 0) {
-        ret = -EIO;
+        waiocb->ret = -EIO;
     } else {
-        ret = 0;
+        waiocb->ret = 0;
         if (count < waiocb->nbytes) {
             /* Short reads mean EOF, pad with zeros. */
             if (waiocb->is_read) {
                 qemu_iovec_memset(waiocb->qiov, count, 0,
                     waiocb->qiov->size - count);
             } else {
-                ret = -EINVAL;
+                waiocb->ret = -EINVAL;
             }
        }
     }
 
     if (!waiocb->is_linear) {
-        if (ret == 0 && waiocb->is_read) {
+        if (waiocb->ret == 0 && waiocb->is_read) {
             QEMUIOVector *qiov = waiocb->qiov;
             iov_from_buf(qiov->iov, qiov->niov, 0, waiocb->buf, qiov->size);
         }
         qemu_vfree(waiocb->buf);
     }
 
-    waiocb->common.cb(waiocb->common.opaque, ret);
-    qemu_aio_unref(waiocb);
+    if (waiocb->req_ctx == s->aio_ctx) {
+        win32_aio_completion_cb_bh(waiocb);
+    } else {
+        aio_bh_schedule_oneshot(waiocb->req_ctx, win32_aio_completion_cb_bh,
+                                waiocb);
+    }
 }
 
 static void win32_aio_completion_cb(EventNotifier *e)
@@ -120,10 +134,13 @@ BlockAIOCB *win32_aio_submit(BlockDriverState *bs,
     DWORD rc;
 
     waiocb = qemu_aio_get(&win32_aiocb_info, bs, cb, opaque);
+    waiocb->req_ctx = qemu_get_current_aio_context();
     waiocb->nbytes = bytes;
     waiocb->qiov = qiov;
     waiocb->is_read = (type == QEMU_AIO_READ);
 
+    aio_context_ref(waiocb->req_ctx);
+
     if (qiov->niov > 1) {
         waiocb->buf = qemu_try_blockalign(bs, qiov->size);
         if (waiocb->buf == NULL) {
-- 
2.51.1


