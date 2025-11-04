Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EFCCCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6nz-0006yr-4o; Mon, 03 Nov 2025 21:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6nx-0006yc-E3
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6nv-0003uf-Ni
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0oFHTWnYvTpTuorWMlOYX+CfxVfYYLPx7SRGFBc8MRQ=;
 b=FtWIu86acJ2kiviKWZ1/b6kBwta+oxDT6z9F6b75FiTndM2PrWW7w4XO2QbHt3vIwJVMUK
 ngnzwLwk6eJF2CXoO+rQAErqb6opiTk+FeefxDRWUbJ39rYkEabB1RLVPegZXN8a+APo8Z
 WDwmFMeTtENTa8n33hkPz54Zo9e9PI8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-1ayQDKlDP5m2roXM0NQamg-1; Mon,
 03 Nov 2025 21:29:47 -0500
X-MC-Unique: 1ayQDKlDP5m2roXM0NQamg-1
X-Mimecast-MFC-AGG-ID: 1ayQDKlDP5m2roXM0NQamg_1762223386
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C05711956053; Tue,  4 Nov 2025 02:29:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBE5719560A2; Tue,  4 Nov 2025 02:29:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 03/15] aio-posix: fix spurious return from ->wait() due to
 signals
Date: Mon,  3 Nov 2025 21:29:21 -0500
Message-ID: <20251104022933.618123-4-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

io_uring_enter(2) only returns -EINTR in some cases when interrupted by
a signal. Therefore the while loop in fdmon_io_uring_wait() is
incomplete and can lead to a spurious early return.

Handle the case when a signal interrupts io_uring_enter(2) but the
syscall returns the number of SQEs submitted (that takes priority over
-EINTR).

This patch probably makes little difference for QEMU, but the test suite
relies on the exact pattern of aio_poll() return values, so it's best to
hide this io_uring syscall interface quirk.

Here is the strace of test-aio receiving 3 SIGCONT signals after this
fix has been applied. Notice how the io_uring_enter(2) return value is 1
the first time because an SQE was submitted, but -EINTR the other times:

  eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK) = 9
  io_uring_enter(7, 1, 0, 0, NULL, 8) = 1
  clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, 0x7ffe38a46240) = 0
  io_uring_enter(7, 1, 1, IORING_ENTER_GETEVENTS, NULL, 8) = 1
  --- SIGCONT {si_signo=SIGCONT, si_code=SI_USER, si_pid=596096, si_uid=1000} ---
  io_uring_enter(7, 0, 1, IORING_ENTER_GETEVENTS, NULL, 8) = -1 EINTR (Interrupted system call)
  --- SIGCONT {si_signo=SIGCONT, si_code=SI_USER, si_pid=596096, si_uid=1000} ---
  io_uring_enter(7, 0, 1, IORING_ENTER_GETEVENTS, NULL, 8 <unfinished ...>
  <... io_uring_enter resumed>) = -1 EINTR (Interrupted system call)
  --- SIGCONT {si_signo=SIGCONT, si_code=SI_USER, si_pid=596096, si_uid=1000} ---
  io_uring_enter(7, 0, 1, IORING_ENTER_GETEVENTS, NULL, 8 <unfinished ...>
  <... io_uring_enter resumed>) = 0

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b64ce42513..3d8638b0e5 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -299,9 +299,16 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
 
     fill_sq_ring(ctx);
 
+    /*
+     * Loop to handle signals in both cases:
+     * 1. If no SQEs were submitted, then -EINTR is returned.
+     * 2. If SQEs were submitted then the number of SQEs submitted is returned
+     *    rather than -EINTR.
+     */
     do {
         ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
-    } while (ret == -EINTR);
+    } while (ret == -EINTR ||
+             (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)));
 
     assert(ret >= 0);
 
-- 
2.51.1


