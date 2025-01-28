Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ADDC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 12:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tckeZ-0004BD-UT; Tue, 28 Jan 2025 07:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tckeX-00049w-Sy; Tue, 28 Jan 2025 07:25:13 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tckeV-0000u8-EF; Tue, 28 Jan 2025 07:25:13 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 97E1A45BE3;
 Tue, 28 Jan 2025 13:25:00 +0100 (CET)
Message-ID: <2049cdd3-db99-4a96-9480-b7ccbf5f5bc0@proxmox.com>
Date: Tue, 28 Jan 2025 13:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 qemu-block@nongnu.org
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
 <81befe6a-49fb-47bb-88fc-3fde73bb7c8c@proxmox.com>
 <Z4krRmzb3upAkUSI@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <Z4krRmzb3upAkUSI@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 16.01.25 um 16:52 schrieb Kevin Wolf:
> Am 10.01.2025 um 17:37 hat Fiona Ebner geschrieben:
>> Am 09.01.25 um 11:47 schrieb Kevin Wolf:
>>> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
>>>> Setting blk->root is a graph change operation and thus needs to be
>>>> protected by the block graph write lock in blk_remove_bs(). The
>>>> assignment to blk->root in blk_insert_bs() is already protected by
>>>> the block graph write lock.
>>>
>>> Hm, if that's the case, then we should also enforce this in the
>>> declaration of BlockBackend:
>>>
>>>     BdrvChild * GRAPH_RDLOCK_PTR root;
>>>
>>> However, this results in more compiler failures that we need to fix. You
>>> caught the only remaining writer, but the lock is only fully effective
>>> if all readers take it, too.
>>
>> I started giving this a try, but quickly ran into some issues/questions:
>>
>> 1. For global state code, is it preferred to use
>> GRAPH_RDLOCK_GUARD_MAINLOOP() to cover the whole function or better to
>> use bdrv_graph_rd(un)lock_main_loop() to keep the locked section as
>> small as necessary? I feel like the former can be more readable, e.g. in
>> blk_insert_bs(), blk_new_open(), where blk->root is used in conditionals.
> 
> Yes, I think we generally use GRAPH_RDLOCK_GUARD_MAINLOOP() if there is
> no read not to (e.g. if you need to take a writer lock in another part
> of the same function). It's essentially only an assertion anyway, so it
> doesn't even actually hold a real lock for longer than necessary.

Okay, thanks!

>> 2. In particular, protecting blk->root means that blk_bs() needs to have
>> the read lock. In fact, blk_bs() is reading blk->root twice in a row, so
>> it seems like it could suffer from a potential NULL pointer dereference
>> (or I guess after compiler optimization a potential use-after-free)?
>>
>> Since blk_bs() is IO_CODE() and not a coroutine, I tried to mark it
>> GRAPH_RDLOCK and move on to the callers.
> 
> It looks like blk_bs() is tricky in general... blk_bs() is used in
> iothreads in devices. Not sure how easy it would be to trigger a bug
> there, but from the locking alone, it seems entirely possible to have
> the device iothread race with the main thread changing the root node.
> 
>> However, one caller is blk_nb_sectors() which itself is called by
>> blk_get_geometry(). Both of these are manually-written coroutine wrappers:
>>
>>> commit 81f730d4d0e8af9c0211c3fedf406df0046341a9
>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>> Date:   Fri Apr 7 17:33:03 2023 +0200
>>>
>>>     block, block-backend: write some hot coroutine wrappers by hand
>>>     
>>>     The introduction of the graph lock is causing blk_get_geometry, a hot function
>>>     used in the I/O path, to create a coroutine.  However, the only part that really
>>>     needs to run in coroutine context is the call to bdrv_co_refresh_total_sectors,
>>>     which in turn only happens in the rare case of host CD-ROM devices.
>>>     
>>>     So, write by hand the three wrappers on the path from blk_co_get_geometry to
>>>     bdrv_co_refresh_total_sectors, so that the coroutine wrapper is only created
>>>     if bdrv_nb_sectors actually calls bdrv_refresh_total_sectors.
>>
>> Both the blk_bs() and blk_nb_sectors() functions are IO_CODE(), but not
>> coroutines, and callers of blk_get_geometry are already in the device
>> code. I'm not sure how to proceed here, happy to hear suggestions :)
> 
> Being in device code is not necessarily a problem, we could be doing
> stuff already there if we wanted.
> 
> The important question is, what would be the right behaviour? Can any of
> the calls run while the writer lock is held?
> 
> If not, we can probably assert that and just take a reader lock
> (bdrv_graph_co_rdlock() has to run in coroutine context only because it
> might have to wait for a writer - if we know that there is none, we
> could do it outside of a coroutine).
> 
> But if yes, then we either have a real bug that needs to be solved or
> the protection is provided by something other than the graph lock. Maybe
> the answer is that because of how devices access the field, the graph
> lock isn't the right mechanism for protecting BlockBackend.root and we
> should rely on draining instead?
> 
> We already try to do this:
> 
>     blk_drain(blk);
>     root = blk->root;
>     blk->root = NULL;
> 
> It would make more sense for this to be a drained_begin/end section that
> quiesces devices while we're changing the root node, otherwise we can
> get new requests before blk_drain() returns.

Good idea!

> Do you know if the I/O request dereferencing a NULL pointer came from a
> device? (The stack trace in your commit message is shortened too much to
> tell me a lot, and the link to your forum doesn't allow me to view the
> logs without registering an account. Please include more information in
> the commit message in v2.)

Unfortunately, I'm not sure. I've included the GDB script and resulting
log (with our downstream based on QEMU 9.0.2) below. Interestingly, the
problematic call happens in the main thread, while the previous ones
were in the live migration thread or, IIUC, in the IO thread. But it's
the same opaque pointer address as in the calls in the live migration
thread. Another detail to note is that the live migration thread did not
exit yet, but I don't know if that is important.

Best Regards,
Fiona

GDB script:

> handle SIGUSR1 noprint nostop
> handle SIGPIPE noprint nostop
> break bdrv_flush
> break bdrv_co_flush
> commands 1 2
> bt
> c
> end
> c

Log:

> Thread 3 "kvm" hit Breakpoint 2, bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:2947
> 2947    in ../block/io.c
> #0  bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:2947
> #1  0x000061f395266bf7 in blk_co_do_flush (blk=0x61f3aaafd870) at ../block/block-backend.c:1833
> #2  blk_aio_flush_entry (opaque=0x792088035380) at ../block/block-backend.c:1841
> #3  0x000061f3953baf7b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> #4  0x000079209a6a69c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #5  0x0000792096bfa5a0 in ?? ()
> #6  0x0000000000000000 in ?? ()
> 
> Thread 3 "kvm" hit Breakpoint 2, bdrv_co_flush (bs=0x61f3aaaf82e0) at ../block/io.c:2947
> 2947    in ../block/io.c
> #0  bdrv_co_flush (bs=0x61f3aaaf82e0) at ../block/io.c:2947
> #1  0x000061f395274911 in bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:3047
> #2  0x000061f395266bf7 in blk_co_do_flush (blk=0x61f3aaafd870) at ../block/block-backend.c:1833
> #3  blk_aio_flush_entry (opaque=0x792088035380) at ../block/block-backend.c:1841
> #4  0x000061f3953baf7b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> #5  0x000079209a6a69c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #6  0x0000792096bfa5a0 in ?? ()
> #7  0x0000000000000000 in ?? ()
> [New Thread 0x79206b0006c0 (LWP 103520)]
> [Thread 0x79206b0006c0 (LWP 103520) exited]
> [New Thread 0x79206b0006c0 (LWP 103521)]
> [Switching to Thread 0x79206b0006c0 (LWP 103521)]
> 
> Thread 24 "live_migration" hit Breakpoint 1, bdrv_flush (bs=0x61f3aaaf0f80) at block/block-gen.c:909
> #0  bdrv_flush (bs=0x61f3aaaf0f80) at block/block-gen.c:909
> #1  0x000061f395273cfd in bdrv_flush_all () at ../block/io.c:2348
> #2  0x000061f394fc8a9d in do_vm_stop (state=RUN_STATE_FINISH_MIGRATE, send_stop=<optimized out>) at ../system/cpus.c:297
> #3  0x000061f394ff41c9 in migration_stop_vm (s=s@entry=0x61f3aaaf0790, state=state@entry=RUN_STATE_FINISH_MIGRATE) at ../migration/migration.c:202
> #4  0x000061f394ffa88d in migration_completion_precopy (current_active_state=0x79206affaffc, s=0x61f3aaaf0790) at ../migration/migration.c:2732
> #5  migration_completion (s=0x61f3aaaf0790) at ../migration/migration.c:2814
> #6  migration_iteration_run (s=0x61f3aaaf0790) at ../migration/migration.c:3238
> #7  migration_thread (opaque=opaque@entry=0x61f3aaaf0790) at ../migration/migration.c:3490
> #8  0x000061f3953a35c8 in qemu_thread_start (args=0x61f3aacf3560) at ../util/qemu-thread-posix.c:541
> #9  0x000079209a6de1c4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #10 0x000079209a75e85c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 24 "live_migration" hit Breakpoint 2, bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:2947
> #0  bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:2947
> #1  0x000061f395236882 in bdrv_co_flush_entry (opaque=0x79206affae90) at block/block-gen.c:901
> #2  0x000061f3953baf7b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> #3  0x000079209a6a69c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #4  0x000079206affa6b0 in ?? ()
> #5  0x0000000000000000 in ?? ()
> 
> Thread 24 "live_migration" hit Breakpoint 2, bdrv_co_flush (bs=0x61f3aaaf82e0) at ../block/io.c:2947
> 2947    in ../block/io.c
> #0  bdrv_co_flush (bs=0x61f3aaaf82e0) at ../block/io.c:2947
> #1  0x000061f395274911 in bdrv_co_flush (bs=0x61f3aaaf0f80) at ../block/io.c:3047
> #2  0x000061f395236882 in bdrv_co_flush_entry (opaque=0x79206affae90) at block/block-gen.c:901
> #3  0x000061f3953baf7b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> #4  0x000079209a6a69c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #5  0x000079206affa6b0 in ?? ()
> #6  0x0000000000000000 in ?? ()
> [Switching to Thread 0x792097a7d500 (LWP 23325)]
> 
> Thread 1 "kvm" hit Breakpoint 2, bdrv_co_flush (bs=0x0) at ../block/io.c:2947
> 2947    in ../block/io.c
> #0  bdrv_co_flush (bs=0x0) at ../block/io.c:2947
> #1  0x000061f395236882 in bdrv_co_flush_entry (opaque=0x79206affae90) at block/block-gen.c:901
> #2  0x000061f3953baf7b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175
> #3  0x000079209a6a69c0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #4  0x000079206affa6b0 in ?? ()
> #5  0x0000000000000000 in ?? ()
> 
> Thread 1 "kvm" received signal SIGSEGV, Segmentation fault.
> bdrv_primary_child (bs=bs@entry=0x0) at ../block.c:8287
> [Inferior 1 (process 23325) detached]



