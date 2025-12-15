Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6982ED5B17B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVA1L-0005Cg-Pc; Mon, 15 Dec 2025 09:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vVA0j-00057I-W6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:57:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vVA0g-0001Ou-3F
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765810633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUZPUrzztc4iT4E5iH3zeW21tztwJ/78t30LZEzlwQg=;
 b=hJWJk2IdT9z1+hUqHFDOYh5Ofd/A6RhIIiJZwZNsIsMpgmjWr66QVLK2ZRImJ4LlqCCXES
 SAXnhnt5DjFUEhTpHudI5NBPKoXyUclgGlzQCu1e9IG3ckm8zp3jqsVsOl0bfGYuAtBa+E
 Dzjze1dGsXlZ3KSgO1sQl56n54SlrQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-10CZoUeaNoW4Hrnpjh-SLw-1; Mon,
 15 Dec 2025 09:57:10 -0500
X-MC-Unique: 10CZoUeaNoW4Hrnpjh-SLw-1
X-Mimecast-MFC-AGG-ID: 10CZoUeaNoW4Hrnpjh-SLw_1765810628
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D4F11800625; Mon, 15 Dec 2025 14:57:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8D7B1956056; Mon, 15 Dec 2025 14:57:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Subject: [PULL for-10.2 1/1] Revert "nvme: Fix coroutine waking"
Date: Mon, 15 Dec 2025 09:57:03 -0500
Message-ID: <20251215145703.31841-2-stefanha@redhat.com>
In-Reply-To: <20251215145703.31841-1-stefanha@redhat.com>
References: <20251215145703.31841-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.

Said commit changed the replay_bh_schedule_oneshot_event() in
nvme_rw_cb() to aio_co_wake(), allowing the request coroutine to be
entered directly (instead of only being scheduled for later execution).
This can cause the device to become stalled like so:

It is possible that after completion the request coroutine goes on to
submit another request without yielding, e.g. a flush after a write to
emulate FUA.  This will likely cause a nested nvme_process_completion()
call because nvme_rw_cb() itself is called from there.

(After submitting a request, we invoke nvme_process_completion() through
defer_call(); but the fact that nvme_process_completion() ran in the
first place indicates that we are not in a call-deferring section, so
defer_call() will call nvme_process_completion() immediately.)

If this inner nvme_process_completion() loop then processes any
completions, it will write the final completion queue (CQ) head index to
the CQ head doorbell, and subsequently execution will return to the
outer nvme_process_completion() loop.  Even if this loop now finds no
further completions, it still processed at least one completion before,
or it would not have called the nvme_rw_cb() which led to nesting.
Therefore, it will now write the exact same CQ head index value to the
doorbell, which effectively is an unrecoverable error[1].

Therefore, nesting of nvme_process_completion() does not work at this
point.  Reverting said commit removes the nesting (by scheduling the
request coroutine instead of entering it immediately), and so fixes the
stall.

On the downside, reverting said commit breaks multiqueue for nvme, but
better to have single-queue working than neither.  For 11.0, we will
have a solution that makes both work.

A side note: There is a comment in nvme_process_completion() above
qemu_bh_schedule() that claims nesting works, as long as it is done
through the completion_bh.  I am quite sure that is not true, for two
reasons:
- The problem described above, which is even worse when going through
  nvme_process_completion_bh() because that function unconditionally
  writes to the CQ head doorbell,
- nvme_process_completion_bh() never takes q->lock, so
  nvme_process_completion() unlocking it will likely abort.

Given the lack of reports of such aborts, I believe that completion_bh
simply is unused in practice.

[1] See the NVMe Base Specification revision 2.3, page 180, figure 152:
    “Invalid Doorbell Write Value: A host attempted to write an invalid
    doorbell value. Some possible causes of this error are: [...] the
    value written is the same as the previously written doorbell value.”

    To even be notified of this error, we would need to send an
    Asynchronous Event Request to the admin queue (p. 178ff), which we
    don’t do, and then to handle it, we would need to delete and
    recreate the queue (p. 88, section 3.3.1.2 Queue Usage).

Cc: qemu-stable@nongnu.org
Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Tested-by: Lukáš Doktor <ldoktor@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-id: 20251215141540.88915-1-hreitz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 919e14cef9..c3d3b99d1f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1200,36 +1200,26 @@ fail:
 
 typedef struct {
     Coroutine *co;
-    bool skip_yield;
     int ret;
+    AioContext *ctx;
 } NVMeCoData;
 
+static void nvme_rw_cb_bh(void *opaque)
+{
+    NVMeCoData *data = opaque;
+    qemu_coroutine_enter(data->co);
+}
+
 /* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
-
     data->ret = ret;
-
-    if (data->co == qemu_coroutine_self()) {
-        /*
-         * Fast path: We are inside of the request coroutine (through
-         * nvme_submit_command, nvme_deferred_fn, nvme_process_completion).
-         * We can set data->skip_yield here to keep the coroutine from
-         * yielding, and then we don't need to schedule a BH to wake it.
-         */
-        data->skip_yield = true;
-    } else {
-        /*
-         * Safe to call: The case where we run in the request coroutine is
-         * handled above, so we must be independent of it; and without
-         * skip_yield set, the coroutine will yield.
-         * No need to release NVMeQueuePair.lock (we are called without it
-         * held).  (Note: If we enter the coroutine here, @data will
-         * probably be dangling once aio_co_wake() returns.)
-         */
-        aio_co_wake(data->co);
+    if (!data->co) {
+        /* The rw coroutine hasn't yielded, don't try to enter. */
+        return;
     }
+    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
@@ -1253,7 +1243,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1270,7 +1260,9 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1366,7 +1358,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1374,7 +1366,9 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    if (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1415,7 +1409,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1435,7 +1429,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1463,7 +1459,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1508,7 +1504,9 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
-- 
2.52.0


