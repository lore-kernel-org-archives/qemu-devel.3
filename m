Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E3CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX4e-00086N-Hp; Mon, 25 May 2026 11:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRX4V-0007jM-Eu
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRX4T-0000nJ-Nh
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPP+lt/TkLLenlDA2KNeaCoQ0OMjXfgwfsa3IFnTB70=;
 b=ZsomFbWSTMlhlukrQUVK018TSdFA4ue2syL5k2ZjqZuQ+cE/iAlb8L8SBHCYoMpXgBKEJg
 4ruoZm4rb9fzaHeD7P55d9ySQzUagaT4Gow12IrD2evMNk0ODYb7XfiADl59ztBxx9cP83
 aBDbsr5GM8TXdubO+rygddt7usoFzBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-9MvoqoziMr2p3RGbA1cboQ-1; Mon,
 25 May 2026 11:18:18 -0400
X-MC-Unique: 9MvoqoziMr2p3RGbA1cboQ-1
X-Mimecast-MFC-AGG-ID: 9MvoqoziMr2p3RGbA1cboQ_1779722297
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B35C19560BB; Mon, 25 May 2026 15:18:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA1F91686; Mon, 25 May 2026 15:18:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/1] block/linux-aio: bound ioq_submit() recursion depth
Date: Mon, 25 May 2026 11:18:11 -0400
Message-ID: <20260525151811.1643855-2-stefanha@redhat.com>
In-Reply-To: <20260525151811.1643855-1-stefanha@redhat.com>
References: <20260525151811.1643855-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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
---
 block/linux-aio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

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
2.54.0


