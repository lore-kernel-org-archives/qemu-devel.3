Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A55D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhoZ-00054v-31; Wed, 03 Dec 2025 03:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhoW-0004ww-If; Wed, 03 Dec 2025 03:02:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhoU-00077A-CP; Wed, 03 Dec 2025 03:02:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1A57317077B;
 Wed, 03 Dec 2025 10:59:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DBE5432B4A2;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 110/116] block/io_uring: avoid potentially getting
 stuck after resubmit at the end of ioq_submit()
Date: Wed,  3 Dec 2025 10:59:30 +0300
Message-ID: <20251203075939.2366131-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Note that this issue seems already fixed as a consequence of the large
io_uring rework with 047dabef97 ("block/io_uring: use aio_add_sqe()")
in current master, so this is purely for QEMU stable branches.

At the end of ioq_submit(), there is an opportunistic call to
luring_process_completions(). This is the single caller of
luring_process_completions() that doesn't use the
luring_process_completions_and_submit() wrapper.

Other callers use the wrapper, because luring_process_completions()
might require a subsequent call to ioq_submit() after resubmitting a
request. As noted for luring_resubmit():

> Resubmit a request by appending it to submit_queue.  The caller must ensure
> that ioq_submit() is called later so that submit_queue requests are started.

So the caller at the end of ioq_submit() violates the contract and can
in fact be problematic if no other requests come in later. In such a
case, the request intended to be resubmitted will never be actually be
submitted via io_uring_submit().

A reproducer exposing this issue is [0], which is based on user
reports from [1]. Another reproducer is iotest 109 with '-i io_uring'.

I had the most success to trigger the issue with [0] when using a
BTRFS RAID 1 storage. With tmpfs, it can take quite a few iterations,
but also triggers eventually on my machine. With iotest 109 with '-i
io_uring' the issue triggers reliably on my ext4 file system.

Have ioq_submit() submit any resubmitted requests after calling
luring_process_completions(). The return value from io_uring_submit()
is checked to be non-negative before the opportunistic processing of
completions and going for the new resubmit logic, to ensure that a
failure of io_uring_submit() is not missed. Also note that the return
value already was not necessarily the total number of submissions,
since the loop might've been iterated more than once even before the
current change.

Only trigger the resubmission logic if it is actually necessary to
avoid changing behavior more than necessary. For example iotest 109
would produce more 'mirror ready' events if always resubmitting after
luring_process_completions() at the end of ioq_submit().

Note iotest 109 still does not pass as is when run with '-i io_uring',
because of two offset values for BLOCK_JOB_COMPLETED events being zero
instead of non-zero as in the expected output. Note that the two
affected test cases are expected failures and still fail, so they just
fail "faster". The test cases are actually not triggering the resubmit
logic, so the reason seems to be different ordering of requests and
completions of the current aio=io_uring implementation versus
aio=threads.

[0]:

> #!/bin/bash -e
> #file=/mnt/btrfs/disk.raw
> file=/tmp/disk.raw
> filesize=256
> readsize=512
> rm -f $file
> truncate -s $filesize $file
> ./qemu-system-x86_64 --trace '*uring*' --qmp stdio \
> --blockdev raw,node-name=node0,file.driver=file,file.cache.direct=off,file.filename=$file,file.aio=io_uring \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "human-monitor-command", "arguments": { "command-line": "qemu-io node0 \"read 0 $readsize \"" }}
> {"execute": "quit"}
> EOF

[1]: https://forum.proxmox.com/threads/170045/

Cc: qemu-stable@nongnu.org
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io_uring.c b/block/io_uring.c
index dd4f304910..5dbafc8f7b 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -120,11 +120,14 @@ static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
  * event loop.  When there are no events left  to complete the BH is being
  * canceled.
  *
+ * Returns whether ioq_submit() must be called again afterwards since requests
+ * were resubmitted via luring_resubmit().
  */
-static void luring_process_completions(LuringState *s)
+static bool luring_process_completions(LuringState *s)
 {
     struct io_uring_cqe *cqes;
     int total_bytes;
+    bool resubmit = false;
 
     defer_call_begin();
 
@@ -182,6 +185,7 @@ static void luring_process_completions(LuringState *s)
              */
             if (ret == -EINTR || ret == -EAGAIN) {
                 luring_resubmit(s, luringcb);
+                resubmit = true;
                 continue;
             }
         } else if (!luringcb->qiov) {
@@ -194,6 +198,7 @@ static void luring_process_completions(LuringState *s)
             if (luringcb->is_read) {
                 if (ret > 0) {
                     luring_resubmit_short_read(s, luringcb, ret);
+                    resubmit = true;
                     continue;
                 } else {
                     /* Pad with zeroes */
@@ -224,6 +229,8 @@ end:
     qemu_bh_cancel(s->completion_bh);
 
     defer_call_end();
+
+    return resubmit;
 }
 
 static int ioq_submit(LuringState *s)
@@ -231,6 +238,7 @@ static int ioq_submit(LuringState *s)
     int ret = 0;
     LuringAIOCB *luringcb, *luringcb_next;
 
+resubmit:
     while (s->io_q.in_queue > 0) {
         /*
          * Try to fetch sqes from the ring for requests waiting in
@@ -260,12 +268,14 @@ static int ioq_submit(LuringState *s)
     }
     s->io_q.blocked = (s->io_q.in_queue > 0);
 
-    if (s->io_q.in_flight) {
+    if (ret >= 0 && s->io_q.in_flight) {
         /*
          * We can try to complete something just right away if there are
          * still requests in-flight.
          */
-        luring_process_completions(s);
+        if (luring_process_completions(s)) {
+            goto resubmit;
+        }
     }
     return ret;
 }
-- 
2.47.3


