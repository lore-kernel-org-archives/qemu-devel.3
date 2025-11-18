Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B594CF2562
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 22:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLUPH-000780-UI; Tue, 18 Nov 2025 17:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLUPG-00077C-6a
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLUPE-0007w7-FQ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763505755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eyUUCD+Xa71zcld5+YQGwhGVX/Bdhb9veA4x2A2Bzcg=;
 b=PC/zOTTcfB/U4smugRed0i3s6jbAkwcrKP6zuWpECpzSWlK9nri7w9GCecqY7WOa8JzRZ1
 CWtg+5kwSEwyVxoDXSBYMFIm3WeavJiacus9pJyo/dVMo21UsfhyWG++eTvf1hVPfEpwf2
 ZJiPPhOaWBAgj68LijWJTrb+lViLmbA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-g_frS83xMcOH4xR4jKlhkg-1; Tue,
 18 Nov 2025 17:42:31 -0500
X-MC-Unique: g_frS83xMcOH4xR4jKlhkg-1
X-Mimecast-MFC-AGG-ID: g_frS83xMcOH4xR4jKlhkg_1763505750
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D1C91800358; Tue, 18 Nov 2025 22:42:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2E30180049F; Tue, 18 Nov 2025 22:42:26 +0000 (UTC)
Date: Tue, 18 Nov 2025 23:42:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: andrey.drobyshev@virtuozzo.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, f.ebner@proxmox.com,
 hreitz@redhat.com, den@virtuozzo.com
Subject: Re: [BUG] Block graph assertion failure on blockdev-add
Message-ID: <aRz2UN6kF93fbj3b@redhat.com>
References: <20251112164108.506976-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112164108.506976-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 12.11.2025 um 17:41 hat andrey.drobyshev@virtuozzo.com geschrieben:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Hi all,
> 
> There's a bug in block layer which leads to an assertion failure and crash.
> The reproduce is flaky, which suggests there's a race involved.  Here's how
> it's reproduced:
> 
> 1. Run QEMU with 2 disks: one system (with actual guest) and one empty; attach
> them to an iothread;
> 2. In the guest, format the empty disk and start sequential IO on it;
> 3. At the host, start growing a chain of snapshots upon the empty image.
> 
> Here're the scripts:
> [...]
> So draining doesn't work as expected: in-flight requests are supposed to be
> polled right before calling bdrv_drain_assert_idle(), but there's new IO
> arriving:
> 
> void coroutine_mixed_fn bdrv_drain_all_begin(void)
> {
> ...
>     bdrv_drain_all_begin_nopoll();
> 
>     /* Now poll the in-flight requests */
>     AIO_WAIT_WHILE_UNLOCKED(NULL, bdrv_drain_all_poll());   <---------
> 
>     while ((bs = bdrv_next_all_states(bs))) {
>         bdrv_drain_assert_idle(bs);
>     }
> }

Took me a bit, but I can reproduce the problem. Yes, "new" I/O arrives
between AIO_WAIT_WHILE_UNLOCKED() and the assertion, which means that
drain itself doesn't work correctly.

After some debugging, I ended up adding some new assertions that would
trigger when the new I/O is added during this period, and what I caught
is this (same in multiple runs):

(gdb) qemu bt
#0  __GI_abort () at abort.c:95
#1  0x00007f99cb823639 in __assert_fail_base (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:118
#2  0x00007f99cb8340af in __assert_fail (assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:127
#3  0x0000557c2a0d64c6 in blk_wait_while_drained (blk=0x557c69d18020) at ../block/block-backend.c:1325
#4  0x0000557c2a0d5069 in blk_co_do_pwritev_part (blk=0x1, offset=140292968848728, bytes=0, qiov=0x7f99b4004568, qiov_offset=qiov_offset@entry=0, flags=3416308576)
    at ../block/block-backend.c:1417
#5  0x0000557c2a0d55ae in blk_aio_write_entry (opaque=0x7f99b4002020) at ../block/block-backend.c:1635
#6  0x0000557c2a30a376 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
#7  0x00007f99cb856f70 in ??? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66
#8  0x00007f99c35f0260 in ??? ()
#9  0x0000000000000000 in ??? ()
[Thread 0x7f98a94fc6c0 (LWP 321021) exited]
[Thread 0x7f99c2dfd6c0 (LWP 320958) exited]
Coroutine at 0x7f99c35fe588:
#0  qemu_coroutine_switch (from_=from_@entry=0x7f99c35fe588, to_=to_@entry=0x7f99b40051f0, action=action@entry=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:322
#1  0x0000557c2a3089e8 in qemu_aio_coroutine_enter (ctx=ctx@entry=0x557c68d5cae0, co=<optimized out>) at ../util/qemu-coroutine.c:293
#2  0x0000557c2a3071f7 in co_schedule_bh_cb (opaque=0x557c68d5cae0) at ../util/async.c:547
#3  0x0000557c2a306b79 in aio_bh_call (bh=0x557c68d822d0) at ../util/async.c:172
#4  aio_bh_poll (ctx=ctx@entry=0x557c68d5cae0) at ../util/async.c:219
#5  0x0000557c2a2ee9e5 in aio_poll (ctx=0x557c68d5cae0, blocking=<optimized out>) at ../util/aio-posix.c:719
#6  0x0000557c2a0ac032 in iothread_run (opaque=opaque@entry=0x557c68d810a0) at ../iothread.c:63
#7  0x0000557c2a2f2aee in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:393
#8  0x00007f99cb893f54 in start_thread (arg=<optimized out>) at pthread_create.c:448
#9  0x00007f99cb91732c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

This suggests that the following happens:

1. Drain section starts

2. A new request still arrives at the BlockBackend from the iothread and
   is queued in blk_wait_while_drained(). This alone is already
   interesting because we thought that the BlockBackend queuing was only
   necessary for IDE and friends, not for virtio-blk. Probably only true
   in the main thread.

3. Drain section ends, blk_root_drained_end() calls qemu_co_enter_next()
   and that is effectively aio_co_wake(). As the request coroutine is in
   the iothread and blk_root_drained_end() in the main thread, the
   coroutine is only scheduled in its AioContext, but doesn't run yet.

4. Another drain section starts
4a. bdrv_drain_all_begin_nopoll()
4b. AIO_WAIT_WHILE_UNLOCKED(NULL, bdrv_drain_all_poll());

5. The iothread processes its BH list and reenters the queued request,
   which increases blk->in_flight and bs->in_flight and runs the actual
   request even though we're drained again. Oops.

4c. bdrv_drain_assert_idle() fails

After a simple s/if/while/ in blk_wait_while_drained(), I can't
reproduce the bug any more. I don't think it's a fully correct fix
because blk->in_flight is still increased for a short time and that
could in theory still trigger the assertion. It's just that the window
is now much smaller because the request doesn't actually execute but is
requeued right away.

I need to think a bit more about the right synchronisation tomorrow.

> I've bisected the issue, and it seems to be introduced by Fiona's series [0]
> for fixing a deadlock.  Namely, before the commit b13f546545 ("block: move
> drain outside of bdrv_root_unref_child()") my reproducer above produces a
> deadlock similar to what we had in [1].  And after commit b13f546545 is
> applied, we get the crash.
> 
> Attached is a naive fix which simply eliminates global draining (i.e. draining
> of all the block graph) in problematic codepaths.  While global draining might
> indeed be redundant there, the real problem, i.e. the race, still remains.

Yes, we don't want to just paper over the bug.

Kevin


