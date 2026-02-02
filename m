Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB578E7FDC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmztZ-0000Sn-PY; Mon, 02 Feb 2026 14:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztT-0000Oy-F3; Mon, 02 Feb 2026 14:47:31 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztQ-0003FW-IV; Mon, 02 Feb 2026 14:47:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B83A18509F;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2C81D35B281;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 13/69] Revert "nvme: Fix coroutine waking"
Date: Mon,  2 Feb 2026 22:45:36 +0300
Message-ID: <20260202194638.939438-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.
(this is commit 361bd4a6c8ca57f48dd5a9e590d2c69a87e7dda1 in 10.0.7)

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
(cherry picked from commit b002acacc1d72521351501fa0af81d146106c9ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nvme.c b/block/nvme.c
index bef515e903..5bf6480af7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1195,36 +1195,26 @@ fail:
 
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
@@ -1248,7 +1238,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1265,7 +1255,9 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1361,7 +1353,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1369,7 +1361,9 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    if (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1410,7 +1404,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1430,7 +1424,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1458,7 +1454,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1503,7 +1499,9 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
-- 
2.47.3


