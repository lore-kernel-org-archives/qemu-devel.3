Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D48F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGeO-00055A-Iw; Thu, 05 Mar 2026 16:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vyGeM-000547-6G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:54:30 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vyGeJ-00084v-14
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=mPtql+p7cW1GKLrShZf6knHoro5wiefz0tbr0ca9kKU=; b=AnwT9K561pdaFV38
 LDHS6RTGWERHyiDWhUIyolD0UynBMTv4PJsXywy5cISmWJmRJYSXJzwc7YjVdTM53XeSbRQTa0Ji+
 TlwmW7dWy17D64SSG4b3w/QKeWm857vDhaxe3NPVXi3QXPi76Ox1Notg1eQcLlBnZ1EhXWlcA3wFW
 pAqh/tIcCQfVgTkw3+JG9dlFSx9KsF46fwkgqS4GhjwEbtnDEDx5CiNH9VxBU0i/i/ZaVVRfZoSmL
 CfKvcCYppYhEmBPU1qy5ReG6u6u3InLFJsjCbXM27wBY78wFFRfm08Xb0E38W99aqnOP5YbiYDvST
 dG0F+WaAkLr6cUkN7g==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vyGeE-00000007XJ9-1Oq9;
 Thu, 05 Mar 2026 21:54:22 +0000
Date: Thu, 5 Mar 2026 21:54:22 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: COLO concurrency issues
Message-ID: <aan7jsTOaFiNfpkp@gallifrey>
References: <87ms1cn8n6.fsf@suse.de> <20260219143620.GC817358@fedora>
 <aZfBNug85Xn_j4o_@gallifrey> <874imu2brz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <874imu2brz.fsf@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 21:53:56 up 129 days, 21:30,  2 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Fabiano Rosas (farosas@suse.de) wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> >> On Fri, Feb 13, 2026 at 09:13:49AM -0300, Fabiano Rosas wrote:
> >> > Hi, I've been following the qemu-colo.rst steps to test COLO and
> >> > encountered a couple of issues. Unfortunately, I don't have cycles to
> >> > investigate further. Happens with QEMU master (also tested some versions
> >> > back until the COLO fix 0b5bf4ea76).
> >> > 
> >> > 1) Deadlock at fdmon_io_uring_wait:
> >> > 
> >> > (steps from qemu-colo.rst)
> >> > - Secondary Failover
> >> > - Secondary resume replication
> >> > - Start the new Secondary
> >> > - Sync
> >> > - Wait until disk is synced, then:
> >> > 
> >> >     {"execute": "stop"}
> >> >     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
> >> > 
> >> > The above results in the old secondary hanging indefinitely at:
> >> > 
> >> >     do {
> >> >         ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> >> >     } while (ret == -EINTR);
> >> > 
> >> > (gdb) bt                                                                                                                                                                      
> >> > #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> >> > #1  0x00007f5519e0204e in ??? () at //usr/lib64/liburing.so.2
> >> > #2  0x00007f5519e01b00 in ??? () at //usr/lib64/liburing.so.2
> >> > #3  0x0000563c2dc06cc9 in fdmon_io_uring_wait (ctx=0x563c30411b00, ready_list=0x7ffd0bad8f58, timeout=575708467831) at ../util/fdmon-io_uring.c:416
> >> > #4  0x0000563c2dc00976 in aio_poll (ctx=0x563c30411b00, blocking=true) at ../util/aio-posix.c:699
> >> > #5  0x0000563c2daa01c6 in bdrv_drain_all_begin () at ../block/io.c:529
> >> > #6  0x0000563c2daa03d8 in bdrv_drain_all () at ../block/io.c:574
> >> > #7  0x0000563c2d764aae in do_vm_stop (state=RUN_STATE_PAUSED, send_stop=true) at ../system/cpus.c:312
> >> > #8  0x0000563c2d765964 in vm_stop (state=RUN_STATE_PAUSED) at ../system/cpus.c:754
> >> > #9  0x0000563c2d7f3378 in qmp_stop (errp=0x7ffd0bad9080) at ../monitor/qmp-cmds.c:62
> >> > #10 0x0000563c2dba7a72 in qmp_marshal_stop (args=0x563c306ac070, ret=0x7f5518dffda8, errp=0x7f5518dffda0) at qapi/qapi-commands-misc.c:197
> >> > #11 0x0000563c2dbf1316 in do_qmp_dispatch_bh (opaque=0x7f5518dffe40) at ../qapi/qmp-dispatch.c:128
> >> > #12 0x0000563c2dc1de48 in aio_bh_call (bh=0x563c3040fef0) at ../util/async.c:173
> >> > #13 0x0000563c2dc1df64 in aio_bh_poll (ctx=0x563c3040c070) at ../util/async.c:220
> >> > #14 0x0000563c2dbffff0 in aio_dispatch (ctx=0x563c3040c070) at ../util/aio-posix.c:389
> >> > #15 0x0000563c2dc1e3cd in aio_ctx_dispatch (source=0x563c3040c070, callback=0x0, user_data=0x0) at ../util/async.c:365
> >> > #16 0x00007f551b114f4c in g_main_dispatch (context=0x563c304120f0) at ../glib/gmain.c:3476
> >> > #17 g_main_context_dispatch_unlocked (context=context@entry=0x563c304120f0) at ../glib/gmain.c:4284
> >> > #18 0x00007f551b1170c9 in g_main_context_dispatch (context=0x563c304120f0) at ../glib/gmain.c:4272
> >> > #19 0x0000563c2dc1fa0b in glib_pollfds_poll () at ../util/main-loop.c:290
> >> > #20 0x0000563c2dc1fa85 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> >> > #21 0x0000563c2dc1fb8a in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> >> > #22 0x0000563c2d78eb60 in qemu_main_loop () at ../system/runstate.c:903
> >> > #23 0x0000563c2db412fc in qemu_default_main (opaque=0x0) at ../system/main.c:50
> >> > #24 0x0000563c2db413ab in main (argc=40, argv=0x7ffd0bad94d8) at ../system/main.c:93
> >> 
> >> Two ideas on how to debug further:
> >> 
> >> 1. Attach to the hung QEMU process with a debugger and inspect the
> >> block_backends global variable (see block/block-backends.c). The
> >> question is why bdrv_drain_all_begin() is not making progress. There are
> >> probably in-flight requests that can be observed in the
> >> BlockDriverState->tracked_requests list. Also check the BlockDriverState
> >> and BlockBackend in_flight fields. This will let you identify which
> >> block device is causing the hang and what it's doing during the hang.
> >
> > (I've not looked at this for ages)
> > I'd guess it's probably the network block sync; the fun part of this test
> > is it's where the secondary is being restarted after a failure; so is
> > this blocking on the old sync connection or the new one?
> > And if it's blocking on the new one, then is that because the secondary
> > is blocked?
> >
> > Dave
> >
> >> 2. Try disabling io_uring on the host via `sudo sysctl
> >> kernel.io_uring_disabled=2` and then run QEMU again. If this is an issue
> >> with QEMU's recently-enabled io_uring event loop, then there will be no
> >> hang with io_uring disabled.
> >> 
> >> Stefan
> 
> +CC Vladimir and Eric
> 
> Hi, thanks all for the advice. I managed to get a bit further with
> this. Answering your questions:
> 
> Lukas:
> - the minimal test you provided in this thread works fine.
> 
> Stefan:
> - it's NBD that appears to be stuck, more on this below.
> - disabling io_uring has no effect on the bug.
> 
> David:
> - The hang is caused by the sync on the old secondary.

Can you/have you done a 'yank' on it?

Dave

> 
> The issue is that the NBD client gets stuck at nbd_read_eof() after the
> channel returns -EAGAIN. The coroutine yields and there's nothing to
> wake it up again.
> 
> The setup is:
> 
> --> { 'execute': 'drive-mirror', 'arguments':\
>         { 'device': 'colo-disk0', 'job-id': 'resync', \
>           'target': 'nbd://127.0.0.1:9999/parent0', \
>           'mode': 'existing', 'format': 'raw', 'sync': 'full'} }"
> 
> <-- {"timestamp": {"seconds": 1772743169, "microseconds": 699207}, "event":
>     "BLOCK_JOB_READY", "data": {"device": "resync", "len": 10737418240,
>     "offset": 10737418240, "speed": 0, "type": "mirror"}}
> 
> --> { 'execute': 'stop' }"
>     { 'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync' } }"
> 
> -- mirror job drains successfully and exits --
> -- nbd_receive_reply hangs --
> 
> Here's the backtrace and the coroutine stack further down:
> 
> QEMU master@3fb456e9a0
> 
> #3  0x0000558000cf3b35 in fdmon_io_uring_wait (ctx=0x55801ef40860, ready_list=0x7fff9dde38d8, timeout=560311008686) at ../util/fdmon-io_uring.c:427
> #4  0x0000558000ced7e2 in aio_poll (ctx=0x55801ef40860, blocking=true) at ../util/aio-posix.c:700
> #5  0x0000558000c08f1b in bdrv_poll_co (s=0x7fff9dde3970) at /home/fabiano/kvm/qemu/block/block-gen.h:43
> #6  0x0000558000c0a886 in bdrv_flush (bs=0x55801fcd13b0) at block/block-gen.c:923
> #7  0x0000558000b4b055 in bdrv_close (bs=0x55801fcd13b0) at ../block.c:5170
> #8  0x0000558000b4beae in bdrv_delete (bs=0x55801fcd13b0) at ../block.c:5564
> #9  0x0000558000b4f115 in bdrv_unref (bs=0x55801fcd13b0) at ../block.c:7170
> #10 0x0000558000b4f13a in bdrv_schedule_unref_bh (opaque=0x55801fcd13b0) at ../block.c:7178
> #11 0x0000558000d0ac39 in aio_bh_call (bh=0x55801ee828c0) at ../util/async.c:173
> #12 0x0000558000d0ad55 in aio_bh_poll (ctx=0x55801ef40860) at ../util/async.c:220
> #13 0x0000558000b7e55c in bdrv_graph_wrunlock () at ../block/graph-lock.c:198
> #14 0x0000558000b4b14f in bdrv_close (bs=0x55801faf2010) at ../block.c:5188
> #15 0x0000558000b4beae in bdrv_delete (bs=0x55801faf2010) at ../block.c:5564
> #16 0x0000558000b4f115 in bdrv_unref (bs=0x55801faf2010) at ../block.c:7170
> #17 0x0000558000b8ad33 in mirror_exit_common (job=0x55801fc84350) at ../block/mirror.c:850
> #18 0x0000558000b8adc4 in mirror_abort (job=0x55801fc84350) at ../block/mirror.c:870
> #19 0x0000558000b563b5 in job_abort (job=0x55801fc84350) at ../job.c:831
> #20 0x0000558000b5648e in job_finalize_single_locked (job=0x55801fc84350) at ../job.c:861
> #21 0x0000558000b56765 in job_completed_txn_abort_locked (job=0x55801fc84350) at ../job.c:964
> #22 0x0000558000b56b79 in job_completed_locked (job=0x55801fc84350) at ../job.c:1071
> #23 0x0000558000b56c2e in job_exit (opaque=0x55801fc84350) at ../job.c:1094
> #24 0x0000558000d0ac39 in aio_bh_call (bh=0x55801f2a40e0) at ../util/async.c:173
> #25 0x0000558000d0ad55 in aio_bh_poll (ctx=0x55801ef40860) at ../util/async.c:220
> #26 0x0000558000cece5c in aio_dispatch (ctx=0x55801ef40860) at ../util/aio-posix.c:390
> #27 0x0000558000d0b1be in aio_ctx_dispatch (source=0x55801ef40860, callback=0x0, user_data=0x0) at ../util/async.c:365
> #28 0x00007f001bd14f4c in g_main_dispatch (context=0x55801ef40df0) at ../glib/gmain.c:3476
> #29 g_main_context_dispatch_unlocked (context=context@entry=0x55801ef40df0) at ../glib/gmain.c:4284
> #30 0x00007f001bd170c9 in g_main_context_dispatch (context=0x55801ef40df0) at ../glib/gmain.c:4272
> #31 0x0000558000d0c7fc in glib_pollfds_poll () at ../util/main-loop.c:290
> #32 0x0000558000d0c876 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> #33 0x0000558000d0c97b in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #34 0x000055800086bbb5 in qemu_main_loop () at ../system/runstate.c:943
> #35 0x0000558000c2da7e in qemu_default_main (opaque=0x0) at ../system/main.c:50
> #36 0x0000558000c2db2d in main (argc=45, argv=0x7fff9dde41c8) at ../system/main.c:93
> 
> p co_tls_bql_locked 
> true
> 
> p co_tls_current 
> (Coroutine *) 0x7f001b81fdd0  // the thread leader ucontext
> 
> p/x *(BdrvFlush *)0x7fff9dde3970
> {poll_state = {ctx = 0x55801ef40860, in_progress = 0x1, co = 0x55801f205e00}, ret = 0x0, bs = 0x55801fcd13b0}
> 
> (gdb) qemu coroutine 0x000055801f205e00
> #0  0x0000558000d0f0c6 in qemu_coroutine_switch (from_=0x55801f205e00, to_=0x7f001b81fdd0, action=COROUTINE_YIELD) at ../util/coroutine-ucontext.c:321
> #1  0x0000558000d0d743 in qemu_coroutine_yield () at ../util/qemu-coroutine.c:339
> #2  0x0000558000b11f3d in qio_channel_yield (ioc=0x7eff9c000b70, condition=G_IO_IN) at ../io/channel.c:714
> #3  0x0000558000b6241c in nbd_read_eof (bs=0x55801fcd13b0, ioc=0x7eff9c000b70, buffer=0x55801fd02d40, size=4, errp=0x7f0016375d28) at ../nbd/client.c:1502
> #4  0x0000558000b624e8 in nbd_receive_reply (bs=0x55801fcd13b0, ioc=0x7eff9c000b70, reply=0x55801fd02d40, mode=NBD_MODE_EXTENDED, errp=0x7f0016375d28)
>     at ../nbd/client.c:1541
> #5  0x0000558000b8f990 in nbd_receive_replies (s=0x55801fd02aa0, cookie=1, errp=0x7f0016375d28) at ../block/nbd.c:463
> #6  0x0000558000b909a7 in nbd_co_do_receive_one_chunk
>     (s=0x55801fd02aa0, cookie=1, only_structured=false, request_ret=0x7f0016375d20, qiov=0x0, payload=0x0, errp=0x7f0016375d28) at ../block/nbd.c:867
> #7  0x0000558000b90d77 in nbd_co_receive_one_chunk
>     (s=0x55801fd02aa0, cookie=1, only_structured=false, request_ret=0x7f0016375d20, qiov=0x0, reply=0x7f0016375d40, payload=0x0, errp=0x7f0016375d28) at ../block/nbd.c:948
> #8  0x0000558000b90f87 in nbd_reply_chunk_iter_receive (s=0x55801fd02aa0, iter=0x7f0016375da0, cookie=1, qiov=0x0, reply=0x7f0016375d40, payload=0x0) at ../block/nbd.c:1031
> #9  0x0000558000b9116d in nbd_co_receive_return_code (s=0x55801fd02aa0, cookie=1, request_ret=0x7f0016375df0, errp=0x7f0016375df8) at ../block/nbd.c:1078
> #10 0x0000558000b91897 in nbd_co_request (bs=0x55801fcd13b0, request=0x7f0016375e50, write_qiov=0x0) at ../block/nbd.c:1229
> #11 0x0000558000b91fc3 in nbd_client_co_flush (bs=0x55801fcd13b0) at ../block/nbd.c:1377
> #12 0x0000558000b862cc in bdrv_co_flush (bs=0x55801fcd13b0) at ../block/io.c:3058
> #13 0x0000558000c0a7d1 in bdrv_co_flush_entry (opaque=0x7fff9dde3970) at block/block-gen.c:901
> #14 0x0000558000d0edf8 in coroutine_trampoline (i0=522214912, i1=21888)
> at ../util/coroutine-ucontext.c:175
> 
> p ((BDRVNBDState *)0x55801fd02aa0)->state
> NBD_CLIENT_CONNECTED
> 
> What would normally wake up the coroutine? I don't see exactly what
> changes with the job exiting that stops waking it up. During the sync it
> yields and resumes many times without issue.
> 
> I see that server.c has nbd_wake_read_bh() which seems to solve the same
> problem on the server side, maybe we need something similar for the
> client?
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

