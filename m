Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBADC531F7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 02:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtFst-0002ue-HX; Thu, 19 Feb 2026 21:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vtFsr-0002uV-WB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 21:04:46 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vtFso-00051p-Sr
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 21:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=cDcZHz3LojKpynFonONGOYDcQS9gnApYUIzMiAQIsYI=; b=iqD14VfqMGFzX2cR
 QHmi+aVuwup78kyBed3F/BlPDmfWZvvCZCLFRFrzAwljqy8oOMDYdnm1JQauBVfGU2BqkzUuE7TbD
 UV2mFoGX1nWJweU9UuD5JTdqszpDPpbAT6AX7yke1nbbP2xB6k2rir2gy8HDj3cW9HZS2HKrNtLZG
 VzkDifoYyDVIAsz0a3yWPoCxFQe5vBsFgm7rPwqJYCG0h/IxtXVC3zehGUjgRGk5QIBsYGHreTEf4
 wTBkxrOwmFRk5rKo/T8E8Ygir7I3WLhxINEbBUrx+Av4Iu/dcWNQroce8cWIhnKwu0H8Hs5DEr/3M
 t4BY3Pguu2WNwdxCtQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vtFsk-00000004PZJ-1Q0j;
 Fri, 20 Feb 2026 02:04:38 +0000
Date: Fri, 20 Feb 2026 02:04:38 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: COLO concurrency issues
Message-ID: <aZfBNug85Xn_j4o_@gallifrey>
References: <87ms1cn8n6.fsf@suse.de>
 <20260219143620.GC817358@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260219143620.GC817358@fedora>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 02:03:17 up 116 days,  1:39,  2 users,  load average: 0.00, 0.00,
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

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Fri, Feb 13, 2026 at 09:13:49AM -0300, Fabiano Rosas wrote:
> > Hi, I've been following the qemu-colo.rst steps to test COLO and
> > encountered a couple of issues. Unfortunately, I don't have cycles to
> > investigate further. Happens with QEMU master (also tested some versions
> > back until the COLO fix 0b5bf4ea76).
> > 
> > 1) Deadlock at fdmon_io_uring_wait:
> > 
> > (steps from qemu-colo.rst)
> > - Secondary Failover
> > - Secondary resume replication
> > - Start the new Secondary
> > - Sync
> > - Wait until disk is synced, then:
> > 
> >     {"execute": "stop"}
> >     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
> > 
> > The above results in the old secondary hanging indefinitely at:
> > 
> >     do {
> >         ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> >     } while (ret == -EINTR);
> > 
> > (gdb) bt                                                                                                                                                                      
> > #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> > #1  0x00007f5519e0204e in ??? () at //usr/lib64/liburing.so.2
> > #2  0x00007f5519e01b00 in ??? () at //usr/lib64/liburing.so.2
> > #3  0x0000563c2dc06cc9 in fdmon_io_uring_wait (ctx=0x563c30411b00, ready_list=0x7ffd0bad8f58, timeout=575708467831) at ../util/fdmon-io_uring.c:416
> > #4  0x0000563c2dc00976 in aio_poll (ctx=0x563c30411b00, blocking=true) at ../util/aio-posix.c:699
> > #5  0x0000563c2daa01c6 in bdrv_drain_all_begin () at ../block/io.c:529
> > #6  0x0000563c2daa03d8 in bdrv_drain_all () at ../block/io.c:574
> > #7  0x0000563c2d764aae in do_vm_stop (state=RUN_STATE_PAUSED, send_stop=true) at ../system/cpus.c:312
> > #8  0x0000563c2d765964 in vm_stop (state=RUN_STATE_PAUSED) at ../system/cpus.c:754
> > #9  0x0000563c2d7f3378 in qmp_stop (errp=0x7ffd0bad9080) at ../monitor/qmp-cmds.c:62
> > #10 0x0000563c2dba7a72 in qmp_marshal_stop (args=0x563c306ac070, ret=0x7f5518dffda8, errp=0x7f5518dffda0) at qapi/qapi-commands-misc.c:197
> > #11 0x0000563c2dbf1316 in do_qmp_dispatch_bh (opaque=0x7f5518dffe40) at ../qapi/qmp-dispatch.c:128
> > #12 0x0000563c2dc1de48 in aio_bh_call (bh=0x563c3040fef0) at ../util/async.c:173
> > #13 0x0000563c2dc1df64 in aio_bh_poll (ctx=0x563c3040c070) at ../util/async.c:220
> > #14 0x0000563c2dbffff0 in aio_dispatch (ctx=0x563c3040c070) at ../util/aio-posix.c:389
> > #15 0x0000563c2dc1e3cd in aio_ctx_dispatch (source=0x563c3040c070, callback=0x0, user_data=0x0) at ../util/async.c:365
> > #16 0x00007f551b114f4c in g_main_dispatch (context=0x563c304120f0) at ../glib/gmain.c:3476
> > #17 g_main_context_dispatch_unlocked (context=context@entry=0x563c304120f0) at ../glib/gmain.c:4284
> > #18 0x00007f551b1170c9 in g_main_context_dispatch (context=0x563c304120f0) at ../glib/gmain.c:4272
> > #19 0x0000563c2dc1fa0b in glib_pollfds_poll () at ../util/main-loop.c:290
> > #20 0x0000563c2dc1fa85 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> > #21 0x0000563c2dc1fb8a in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> > #22 0x0000563c2d78eb60 in qemu_main_loop () at ../system/runstate.c:903
> > #23 0x0000563c2db412fc in qemu_default_main (opaque=0x0) at ../system/main.c:50
> > #24 0x0000563c2db413ab in main (argc=40, argv=0x7ffd0bad94d8) at ../system/main.c:93
> 
> Two ideas on how to debug further:
> 
> 1. Attach to the hung QEMU process with a debugger and inspect the
> block_backends global variable (see block/block-backends.c). The
> question is why bdrv_drain_all_begin() is not making progress. There are
> probably in-flight requests that can be observed in the
> BlockDriverState->tracked_requests list. Also check the BlockDriverState
> and BlockBackend in_flight fields. This will let you identify which
> block device is causing the hang and what it's doing during the hang.

(I've not looked at this for ages)
I'd guess it's probably the network block sync; the fun part of this test
is it's where the secondary is being restarted after a failure; so is
this blocking on the old sync connection or the new one?
And if it's blocking on the new one, then is that because the secondary
is blocked?

Dave

> 2. Try disabling io_uring on the host via `sudo sysctl
> kernel.io_uring_disabled=2` and then run QEMU again. If this is an issue
> with QEMU's recently-enabled io_uring event loop, then there will be no
> hang with io_uring disabled.
> 
> Stefan


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

