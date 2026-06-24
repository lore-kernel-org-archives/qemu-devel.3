Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F7CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNlL-0003Mz-30; Wed, 24 Jun 2026 09:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNlJ-0003Lp-G2; Wed, 24 Jun 2026 09:35:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNlH-0000n1-OA; Wed, 24 Jun 2026 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=Y5IXrWGf9fd6lqmrWDpBY6sNZwdv47Q9g5caZWHM55s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UH9x9jN6YdejMFSpB3kVpl4R7FlI4fh8Rb+/OMWQYleK5oDtpXx+Nuwm5aDQY8r48
 ZHFvQGCbRczcNyR5loT/mTzr/k5C+Y7/6c1wv5NtVHNRkXcVzByxeb8qlhlRA7OrUb
 fq4HJ5L3kGfjwErKBuEIqCOCtINeHHpkmtGeS4EuuoHgOri9a+uRi3hpFpw0ZyYrey
 4el/XcHQl24bKCUMPguvf1WeAOQSejls0sMSj/VTCVKdGQSQF03ISEIctKCN9vZeVP
 uIeZaAQcpXDibfKbL93qUKAJ/VD8CCKAgqv37O60xi1l0hTTYS5nOPJTdfwqba8q4L
 tTbHn/gouPDHQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5F101BA9CC;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E1093DEA1B;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 026/107] block/linux-aio: bound ioq_submit() recursion
 depth
Date: Wed, 24 Jun 2026 16:30:31 +0300
Message-ID: <20260624133301.403266-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

qemu_laio_process_completions() wraps its body in defer_call_begin /
defer_call_end. Inside the section, completion callbacks wake coroutines
that queue new aiocbs; laio_do_submit() defers laio_deferred_fn. At the
bottom of qemu_laio_process_completions() the defer_call_end() fires
laio_deferred_fn, which calls ioq_submit(), closing the cycle:

  ioq_submit
    -> io_submit(2)                           // some sync completions
    -> qemu_laio_process_completions          // defer_call_begin
         -> aio_co_wake                       // resumes coroutine
              -> laio_do_submit
                   -> defer_call(laio_deferred_fn, s)   // enqueued
         -> defer_call_end                    // nesting drops to 0
              -> laio_deferred_fn
                   -> ioq_submit              // +1 stack frame, loop

When io_submit(2) returns asynchronously (O_DIRECT) the cycle
terminates in one extra frame: the fresh aiocb is still in flight, no
completion is drained, no coroutine wakes, no new submission queues.
When submissions complete synchronously (non-O_DIRECT, or per-descriptor
drivers such as vmdk) each level enqueues more work for the next
defer_call_end() to drain, so recursion grows without bound and QEMU
crashes with SIGSEGV on the thread guard page.

The cycle was closed by two performance commits, each correct in
isolation:

  076682885d ("block/linux-aio: convert to blk_io_plug_call() API")
    -- introduced laio_deferred_fn and wired
       laio_do_submit -> defer_call(laio_deferred_fn, s).

  84d61e5f36 ("virtio: use defer_call() in virtio_irqfd_notify()")
    -- added defer_call_begin/end around qemu_laio_process_completions
       so virtio-irqfd notifications batch across a completion pass.

The supported aio=native + cache=none pairing keeps submissions
asynchronous, so the cycle stays bounded; nothing in the code enforces
that contract. Observed in production as a SIGSEGV during a backup job
configured with --cached + aio=native; reproducible on upstream with
qemu-io against vmdk.

Cap ioq_submit() recursion with a counter on LaioQueue, which is only
accessed from the AioContext home thread. On overflow, return without
submitting. The pending work is drained by s->completion_bh, which
qemu_laio_process_completions() has already scheduled on entry -- no
work is lost; one event-loop round-trip of latency is paid only when
the bound is hit, which cannot happen on a supported configuration.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260520142503.251959-2-den@openvz.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 6864bec553b2e37699739615e604fc3c7bae0e1d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 0a7424fbb3..5aaf2e8514 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -36,6 +36,19 @@
 /* Maximum number of requests in a batch. (default value) */
 #define DEFAULT_MAX_BATCH 32
 
+/*
+ * Bound on how deep ioq_submit() may recurse on a single LaioQueue via the
+ * ioq_submit -> qemu_laio_process_completions -> defer_call_end ->
+ * laio_deferred_fn -> ioq_submit cycle. The cycle terminates naturally
+ * when io_submit(2) returns asynchronously (O_DIRECT), but can grow
+ * without bound when submissions complete synchronously. On overflow
+ * the caller returns without submitting; the outermost
+ * qemu_laio_process_completions() has already scheduled s->completion_bh
+ * (via qemu_bh_schedule() at the top of that function), which resumes
+ * submission from the next event-loop dispatch.
+ */
+#define IOQ_SUBMIT_MAX_DEPTH 8
+
 struct qemu_laiocb {
     Coroutine *co;
     LinuxAioState *ctx;
@@ -61,6 +74,7 @@ typedef struct {
     unsigned int in_queue;
     unsigned int in_flight;
     bool blocked;
+    unsigned int submit_depth;
     QSIMPLEQ_HEAD(, qemu_laiocb) pending;
 } LaioQueue;
 
@@ -331,6 +345,7 @@ static void ioq_init(LaioQueue *io_q)
     io_q->in_queue = 0;
     io_q->in_flight = 0;
     io_q->blocked = false;
+    io_q->submit_depth = 0;
 }
 
 static void ioq_submit(LinuxAioState *s)
@@ -340,6 +355,11 @@ static void ioq_submit(LinuxAioState *s)
     QEMU_UNINITIALIZED struct iocb *iocbs[MAX_EVENTS];
     QSIMPLEQ_HEAD(, qemu_laiocb) completed;
 
+    if (s->io_q.submit_depth >= IOQ_SUBMIT_MAX_DEPTH) {
+        return;
+    }
+    s->io_q.submit_depth++;
+
     do {
         if (s->io_q.in_flight >= MAX_EVENTS) {
             break;
@@ -385,6 +405,8 @@ static void ioq_submit(LinuxAioState *s)
          * pended requests will be submitted from there.
          */
     }
+
+    s->io_q.submit_depth--;
 }
 
 static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
-- 
2.47.3


