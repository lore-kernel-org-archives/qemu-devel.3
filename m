Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8462BEA4FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWoI-0004JI-2X; Mon, 23 Feb 2026 09:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWny-0004Ae-Lw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vuWnw-0005XX-0U
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 09:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771856454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AdKr8cSC/9b0AmvQPZSkr7dfkA/wuBIVQpTyoyx7PE=;
 b=J/Sk6JdouSCrwUYNxMMszx65ZDYSl4fjhSm7IT6BoUM7kN6CJUYooBe0diSqvHnBTrn8xI
 ySkgI1W57XwtfA721ux9ZuYkaq9rJR3xftHJeiV+zp8dICr86wg/bZQFA49SAmmChd7z2B
 KgKUfnvq6Zr9Z7N5Wo/MOmQtwQmbdIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-NTerMvO0MsSrwBn1NkL0uQ-1; Mon,
 23 Feb 2026 09:20:50 -0500
X-MC-Unique: NTerMvO0MsSrwBn1NkL0uQ-1
X-Mimecast-MFC-AGG-ID: NTerMvO0MsSrwBn1NkL0uQ_1771856449
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFAC71956055; Mon, 23 Feb 2026 14:20:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68B641955F22; Mon, 23 Feb 2026 14:20:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 1/2] aio-posix: notify main loop when SQEs are queued
Date: Mon, 23 Feb 2026 09:20:30 -0500
Message-ID: <20260223142031.1397832-2-stefanha@redhat.com>
In-Reply-To: <20260223142031.1397832-1-stefanha@redhat.com>
References: <20260223142031.1397832-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jens Axboe <axboe@kernel.dk>

When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
block I/O coroutine inline on the vCPU thread because
qemu_get_current_aio_context() returns the main AioContext when BQL is
held. The coroutine calls luring_co_submit() which queues an SQE via
fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
in gsource_prepare() on the main loop thread.

Since the coroutine ran inline (not via aio_co_schedule()), no BH is
scheduled and aio_notify() is never called. The main loop remains asleep
in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted until
the next timer fires.

Fix this by calling aio_notify() after queuing the SQE. This wakes the
main loop via the eventfd so it can run gsource_prepare() and submit the
pending SQE promptly.

This is a generic fix that benefits all devices using aio=io_uring.
Without it, AHCI/SATA devices see MUCH worse I/O latency since they use
MMIO (not ioeventfd like virtio) and have no other mechanism to wake the
main loop after queuing block I/O.

This is usually a bit hard to detect, as it also relies on the ppoll
loop not waking up for other activity, and micro benchmarks tend not to
see it because they don't have any real processing time. With a
synthetic test case that has a few usleep() to simulate processing of
read data, it's very noticeable. The below example reads 128MB with
O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay before
each batch submit, and a 1ms delay after processing each completion.
Running it on /dev/sda yields:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in   25.76 secs	  fish           external
   usr time    6.19 millis  783.00 micros    5.41 millis
   sys time   12.43 millis  642.00 micros   11.79 millis

while on a virtio-blk or NVMe device we get:

time sudo ./iotest /dev/vdb

________________________________________________________
Executed in    1.25 secs      fish           external
   usr time    1.40 millis    0.30 millis    1.10 millis
   sys time   17.61 millis    1.43 millis   16.18 millis

time sudo ./iotest /dev/nvme0n1

________________________________________________________
Executed in    1.26 secs      fish           external
   usr time    6.11 millis    0.52 millis    5.59 millis
   sys time   13.94 millis    1.50 millis   12.43 millis

where the latter are consistent. If we run the same test but keep the
socket for the ssh connection active by having activity there, then
the sda test looks as follows:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in    1.23 secs      fish           external
   usr time    2.70 millis   39.00 micros    2.66 millis
   sys time    4.97 millis  977.00 micros    3.99 millis

as now the ppoll loop is woken all the time anyway.

After this fix, on an idle system:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in    1.30 secs      fish           external
   usr time    2.14 millis    0.14 millis    2.00 millis
   sys time   16.93 millis    1.16 millis   15.76 millis

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Message-Id: <07d701b9-3039-4f9b-99a2-abeae51146a5@kernel.dk>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
[Generalize the comment since this applies to all vCPU thread activity,
not just coroutines, as suggested by Kevin Wolf <kwolf@redhat.com>.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index e24b955fd9..488d964611 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -23,6 +23,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
+#include "system/iothread.h"
 #include "trace.h"
 #include "aio-posix.h"
 
@@ -813,5 +814,13 @@ void aio_add_sqe(void (*prep_sqe)(struct io_uring_sqe *sqe, void *opaque),
 {
     AioContext *ctx = qemu_get_current_aio_context();
     ctx->fdmon_ops->add_sqe(ctx, prep_sqe, opaque, cqe_handler);
+
+    /*
+     * Wake the main loop if it is sleeping in ppoll().  When a vCPU thread
+     * queues SQEs, the actual io_uring_submit() only happens in
+     * gsource_prepare() in the main loop thread.  Without this notify, the
+     * main loop thread's ppoll() can sleep up to 499ms before submitting.
+     */
+    aio_notify(ctx);
 }
 #endif /* CONFIG_LINUX_IO_URING */
-- 
2.53.0


