Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC00C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEP3l-0007ZQ-7M; Tue, 04 Jun 2024 03:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEP3j-0007Yd-9M; Tue, 04 Jun 2024 03:58:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEP3h-00040V-4f; Tue, 04 Jun 2024 03:58:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4FA77429C6;
 Tue,  4 Jun 2024 09:58:13 +0200 (CEST)
Message-ID: <5e3a6579-d8be-4907-9b24-26ce467a74eb@proxmox.com>
Date: Tue, 4 Jun 2024 09:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] block-backend: fix edge case in bdrv_next() where
 BDS associated to BB changes
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-3-f.ebner@proxmox.com> <ZgLDEdmI0rBcJcGh@redhat.com>
 <bf1537a6-0597-4e82-8b42-32364a6246a3@proxmox.com>
 <Zl3tcRie6y3wEpsP@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <Zl3tcRie6y3wEpsP@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 03.06.24 um 18:21 schrieb Kevin Wolf:
> Am 03.06.2024 um 16:17 hat Fiona Ebner geschrieben:
>> Am 26.03.24 um 13:44 schrieb Kevin Wolf:
>>>
>>> The fix for bdrv_flush_all() is probably to make it bdrv_co_flush_all()
>>> with a coroutine wrapper so that the graph lock is held for the whole
>>> function. Then calling bdrv_co_flush() while iterating the list is safe
>>> and doesn't allow concurrent graph modifications.
>>
>> The second is that iotest 255 ran into an assertion failure upon QMP 'quit':
>>
>>> ../block/graph-lock.c:113: bdrv_graph_wrlock: Assertion `!qemu_in_coroutine()' failed.
>>
>> Looking at the backtrace:
>>
>>> #5  0x0000762a90cc3eb2 in __GI___assert_fail
>>>     (assertion=0x5afb07991e7d "!qemu_in_coroutine()", file=0x5afb07991e00 "../block/graph-lock.c", line=113, function=0x5afb07991f20 <__PRETTY_FUNCTION__.4> "bdrv_graph_wrlock")
>>>     at ./assert/assert.c:101
>>> #6  0x00005afb07585311 in bdrv_graph_wrlock () at ../block/graph-lock.c:113
>>> #7  0x00005afb07573a36 in blk_remove_bs (blk=0x5afb0af99420) at ../block/block-backend.c:901
>>> #8  0x00005afb075729a7 in blk_delete (blk=0x5afb0af99420) at ../block/block-backend.c:487
>>> #9  0x00005afb07572d88 in blk_unref (blk=0x5afb0af99420) at ../block/block-backend.c:547
>>> #10 0x00005afb07572fe8 in bdrv_next (it=0x762a852fef00) at ../block/block-backend.c:618
>>> #11 0x00005afb0758cd65 in bdrv_co_flush_all () at ../block/io.c:2347
>>> #12 0x00005afb0753ba37 in bdrv_co_flush_all_entry (opaque=0x7ffff12c6050) at block/block-gen.c:1391
>>> #13 0x00005afb0773bf41 in coroutine_trampoline (i0=168365184, i1=23291)
>>
>> So I guess calling bdrv_next() is not safe from a coroutine, because
>> the function doing the iteration could end up being the last thing to
>> have a reference for the BB.
> 
> Does your bdrv_co_flush_all() take the graph (reader) lock? If so, this
> is surprising, because while we hold the graph lock, no reference should
> be able to go away - you need the writer lock for that and you won't get
> it as long as bdrv_co_flush_all() locks the graph. So whatever had a
> reference before the bdrv_next() loop must still have it now. Do you
> know where it gets dropped?
> 

AFAICT, yes, it does hold the graph reader lock. The generated code is:

> static void coroutine_fn bdrv_co_flush_all_entry(void *opaque)
> {
>     BdrvFlushAll *s = opaque;
> 
>     bdrv_graph_co_rdlock();
>     s->ret = bdrv_co_flush_all();
>     bdrv_graph_co_rdunlock();
>     s->poll_state.in_progress = false;
> 
>     aio_wait_kick();
> }

Apparently when the mirror job is aborted/exits, which can happen during
the polling for bdrv_co_flush_all_entry(), a reference can go away
without the write lock (at least my breakpoints didn't trigger) being held:

> #0  blk_unref (blk=0x5cdefe943d20) at ../block/block-backend.c:537
> #1  0x00005cdefb26697e in mirror_exit_common (job=0x5cdefeb53000) at ../block/mirror.c:710
> #2  0x00005cdefb263575 in mirror_abort (job=0x5cdefeb53000) at ../block/mirror.c:823
> #3  0x00005cdefb2248a6 in job_abort (job=0x5cdefeb53000) at ../job.c:825
> #4  0x00005cdefb2245f2 in job_finalize_single_locked (job=0x5cdefeb53000) at ../job.c:855
> #5  0x00005cdefb223852 in job_completed_txn_abort_locked (job=0x5cdefeb53000) at ../job.c:958
> #6  0x00005cdefb223714 in job_completed_locked (job=0x5cdefeb53000) at ../job.c:1065
> #7  0x00005cdefb224a8b in job_exit (opaque=0x5cdefeb53000) at ../job.c:1088
> #8  0x00005cdefb4134fc in aio_bh_call (bh=0x5cdefe7487c0) at ../util/async.c:171
> #9  0x00005cdefb4136ce in aio_bh_poll (ctx=0x5cdefd9cd750) at ../util/async.c:218
> #10 0x00005cdefb3efdfd in aio_poll (ctx=0x5cdefd9cd750, blocking=true) at ../util/aio-posix.c:722
> #11 0x00005cdefb20435e in bdrv_poll_co (s=0x7ffe491621d8) at ../block/block-gen.h:43
> #12 0x00005cdefb206a33 in bdrv_flush_all () at block/block-gen.c:1410
> #13 0x00005cdefae5c8ed in do_vm_stop (state=RUN_STATE_SHUTDOWN, send_stop=false)
>     at ../system/cpus.c:297
> #14 0x00005cdefae5c850 in vm_shutdown () at ../system/cpus.c:308
> #15 0x00005cdefae6d892 in qemu_cleanup (status=0) at ../system/runstate.c:871
> #16 0x00005cdefb1a7e78 in qemu_default_main () at ../system/main.c:38
> #17 0x00005cdefb1a7eb8 in main (argc=34, argv=0x7ffe491623a8) at ../system/main.c:48

Looking at the code in mirror_exit_common(), it doesn't seem to acquire
a write lock:

>     bdrv_graph_rdunlock_main_loop();
> 
>     /*
>      * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
>      * inserting target_bs at s->to_replace, where we might not be able to get
>      * these permissions.
>      */
>     blk_unref(s->target);
>     s->target = NULL;

The write lock is taken in blk_remove_bs() when the refcount drops to 0
and the BB is actually removed:

>     bdrv_graph_wrlock();
>     bdrv_root_unref_child(root);
>     bdrv_graph_wrunlock();

Best Regards,
Fiona


