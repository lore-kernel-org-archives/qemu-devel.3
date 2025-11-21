Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D14CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdf6-0000en-Mm; Fri, 21 Nov 2025 21:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdd6-0007Ta-BD; Fri, 21 Nov 2025 21:45:40 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdbs-00042P-Qe; Fri, 21 Nov 2025 21:45:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C86E16C71C;
 Fri, 21 Nov 2025 16:51:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3EC73219B8;
 Fri, 21 Nov 2025 16:52:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 67/76] nvme: Fix coroutine waking
Date: Fri, 21 Nov 2025 16:51:45 +0300
Message-ID: <20251121135201.1114964-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

nvme wakes the request coroutine via qemu_coroutine_enter() from a BH
scheduled in the BDS AioContext.  This may not be the same context as
the one in which the request originally ran, which would be wrong:
- It could mean we enter the coroutine before it yields,
- We would move the coroutine in to a different context.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (data.ret == -EINPROGRESS)` loop.)

To fix that, use aio_co_wake() to run the coroutine in its home context.
Just like in the preceding iscsi and nfs patches, we can drop the
trivial nvme_rw_cb_bh() and use aio_co_wake() directly.

With this, we can remove NVMeCoData.ctx.

Note the check of data->co == NULL to bypass the BH/yield combination in
case nvme_rw_cb() is called from nvme_submit_command(): We probably want
to keep this fast path for performance reasons, but we have to be quite
careful about it:
- We cannot overload .ret for this, but have to use a dedicated
  .skip_yield field.  Otherwise, if nvme_rw_cb() runs in a different
  thread than the coroutine, it may see .ret set and skip the yield,
  while nvme_rw_cb() will still schedule a BH for waking.   Therefore,
  the signal to skip the yield can only be set in nvme_rw_cb() if waking
  too is skipped, which is independent from communicating the return
  value.
- We can only skip the yield if nvme_rw_cb() actually runs in the
  request coroutine.  Otherwise (specifically if they run in different
  AioContexts), the order between this function’s execution and the
  coroutine yielding (or not yielding) is not reliable.
- There is no point to yielding in a loop; there are no spurious wakes,
  so once we yield, we will only be re-entered once the command is done.
  Replace `while` by `if`.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-9-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nvme.c b/block/nvme.c
index 7ed5f570bc..b8262ebfd9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1176,25 +1176,35 @@ fail:
 
 typedef struct {
     Coroutine *co;
+    bool skip_yield;
     int ret;
-    AioContext *ctx;
 } NVMeCoData;
 
-static void nvme_rw_cb_bh(void *opaque)
-{
-    NVMeCoData *data = opaque;
-    qemu_coroutine_enter(data->co);
-}
-
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
+
     data->ret = ret;
-    if (!data->co) {
-        /* The rw coroutine hasn't yielded, don't try to enter. */
-        return;
+
+    if (data->co == qemu_coroutine_self()) {
+        /*
+         * Fast path: We are inside of the request coroutine (through
+         * nvme_submit_command, nvme_deferred_fn, nvme_process_completion).
+         * We can set data->skip_yield here to keep the coroutine from
+         * yielding, and then we don't need to schedule a BH to wake it.
+         */
+        data->skip_yield = true;
+    } else {
+        /*
+         * Safe to call: The case where we run in the request coroutine is
+         * handled above, so we must be independent of it; and without
+         * skip_yield set, the coroutine will yield.
+         * No need to release NVMeQueuePair.lock (we are called without it
+         * held).  (Note: If we enter the coroutine here, @data will
+         * probably be dangling once aio_co_wake() returns.)
+         */
+        aio_co_wake(data->co);
     }
-    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
@@ -1218,7 +1228,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1235,9 +1245,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1333,7 +1341,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1341,9 +1349,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    if (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1384,7 +1390,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1404,9 +1410,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1434,7 +1438,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1479,9 +1483,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
-- 
2.47.3


