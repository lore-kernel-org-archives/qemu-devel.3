Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEX8M-0008Qf-Ro; Thu, 30 Oct 2025 14:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEX8H-0008Q1-TQ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEX85-0008RL-MB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761847925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=906m17tjiDU0GS+f+Q6+Spva9ZS+Vblfudxgihk5llY=;
 b=LZzbGhpRMb0keoEfhXVeGybtkig8OhPg0i9KX2p1QLYU9fcwqXKZB/nagGJS9Jdut3sNyo
 H61lWSFkL1NIjeN9PMHY4XQucaRetJL+hLomnhIB113DgObAj6ZdX83vj2mx432IobJHg7
 6E7uFgvQ0bF5riQzkW9qTzlgLX1HNuE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-6dLUOzaUMr6Q6O_U2_BsQw-1; Thu,
 30 Oct 2025 14:12:01 -0400
X-MC-Unique: 6dLUOzaUMr6Q6O_U2_BsQw-1
X-Mimecast-MFC-AGG-ID: 6dLUOzaUMr6Q6O_U2_BsQw_1761847920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA2E819560AA; Thu, 30 Oct 2025 18:11:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E99930001A1; Thu, 30 Oct 2025 18:11:56 +0000 (UTC)
Date: Thu, 30 Oct 2025 19:11:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, hibriansong@gmail.com,
 eblake@redhat.com, qemu-block@nongnu.org
Subject: Re: [RESEND PATCH v5 00/13] aio: add the aio_add_sqe() io_uring API
Message-ID: <aQOqau-bpiJiNVHI@redhat.com>
References: <20251030152150.470170-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030152150.470170-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 30.10.2025 um 16:21 hat Stefan Hajnoczi geschrieben:
> v5:
> - Explain how fdmon-io_uring.c differs from other fdmon implementations
>   in commit message [Kevin]
> - Move test-nested-aio-poll aio_get_g_source() removal into commit that touches test case [Kevin]
> - Avoid g_source_add_poll() use-after-free in fdmon_poll_update() [Kevin]
> - Avoid duplication in fdmon_epoll_gsource_dispatch(), use fdmon_epoll_wait() [Kevin]
> - Drop unnecessary revents checks in fdmon_poll_gsource_dispatch() [Kevin]
> - Mention in commit message that fdmon-io_uring.c is the new default [Kevin]
> - Add comments explaining how to clean up resources in error paths [Kevin]
> - Indicate error in return value from function with Error *errp arg [Kevin]
> - Add patch to unindent fdmon_io_uring_destroy() [Kevin]
> - Add patch to introduce FDMonOps->dispatch() callback [Kevin]
> - Drop patch with hacky BH optimization for fdmon-io_uring.c [Kevin]
> - Replace cqe_handler_bh with FDMonOps->dispatch() [Kevin]
> - Rename AioHandler->cqe_handler field to ->internal_cqe_handler [Kevin]
> - Consolidate fdmon-io_uring.c trace-events changes into this commit
> - Reduce #ifdef HAVE_IO_URING_PREP_WRITEV2 code duplication [Kevin]

The changes look good to me.

However, the test cases are still failing. I just tried to see where
test-aio is stuck, and while I looked for a backtrace first, I noticed
that just attaching gdb to the process and immediately detaching again
makes the test unstuck. Very strange.

This is the backtrace, maybe a bit unsurpring:

(gdb) bt
#0  0x00007ffff7e6fec6 in __io_uring_submit () from /lib64/liburing.so.2
#1  0x00005555556f4394 in fdmon_io_uring_wait (ctx=0x555556409950, ready_list=0x7fffffffcda0, timeout=749993088) at ../util/fdmon-io_uring.c:410
#2  0x00005555556ed29f in aio_poll (ctx=0x555556409950, blocking=true) at ../util/aio-posix.c:699
#3  0x0000555555681547 in test_timer_schedule () at ../tests/unit/test-aio.c:413
#4  0x00007ffff6f30e7e in test_case_run (tc=0x55555640d340, test_run_name=0x55555640de10 "/aio/timer/schedule", path=<optimized out>) at ../glib/gtestutils.c:3115
#5  g_test_run_suite_internal (suite=suite@entry=0x5555558696d0, path=path@entry=0x0) at ../glib/gtestutils.c:3210
#6  0x00007ffff6f30df3 in g_test_run_suite_internal (suite=suite@entry=0x555555867480, path=path@entry=0x0) at ../glib/gtestutils.c:3229
#7  0x00007ffff6f30df3 in g_test_run_suite_internal (suite=suite@entry=0x555555867720, path=path@entry=0x0) at ../glib/gtestutils.c:3229
#8  0x00007ffff6f313aa in g_test_run_suite (suite=suite@entry=0x555555867720) at ../glib/gtestutils.c:3310
#9  0x00007ffff6f31440 in g_test_run () at ../glib/gtestutils.c:2379
#10 g_test_run () at ../glib/gtestutils.c:2366
#11 0x000055555567e204 in main (argc=1, argv=0x7fffffffd488) at ../tests/unit/test-aio.c:872

And running it under strace shows that we're indeed hanging in the
syscall:

write(1, "# Start of timer tests\n", 23) = 23
eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK)   = 9
io_uring_enter(7, 1, 0, 0, NULL, 8)     = 1
clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, 0x7ffc239bec80) = 0
io_uring_enter(7, 1, 1, IORING_ENTER_GETEVENTS, NULL, 8

Of course, if I start the test without strace and then attach strace to
the running process, that gets it unstuck like attaching gdb (not very
surprising, I guess, it's both just ptrace).

Finally I tried Ctrl-C while having strace logging to a file, and now
the io_uring_enter() returns 1 (rather than EINTR or 0 or whatever):

io_uring_enter(7, 1, 1, IORING_ENTER_GETEVENTS, NULL, 8) = 1
--- SIGINT {si_signo=SIGINT, si_code=SI_KERNEL} ---
+++ killed by SIGINT +++

Not sure what to make of this.

I think you already said you run the same kernel version, but just to be
sure, I'm running 6.17.5-200.fc42.x86_64.

Kevin


