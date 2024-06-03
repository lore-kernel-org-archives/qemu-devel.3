Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E1C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8VM-0000Wi-Tx; Mon, 03 Jun 2024 10:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sE8VH-0000TZ-PJ; Mon, 03 Jun 2024 10:17:39 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sE8VE-0002HG-Pf; Mon, 03 Jun 2024 10:17:39 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C984144BDA;
 Mon,  3 Jun 2024 16:17:22 +0200 (CEST)
Message-ID: <bf1537a6-0597-4e82-8b42-32364a6246a3@proxmox.com>
Date: Mon, 3 Jun 2024 16:17:21 +0200
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
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZgLDEdmI0rBcJcGh@redhat.com>
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

Hi Kevin,

Am 26.03.24 um 13:44 schrieb Kevin Wolf:
> Am 22.03.2024 um 10:50 hat Fiona Ebner geschrieben:
>> The old_bs variable in bdrv_next() is currently determined by looking
>> at the old block backend. However, if the block graph changes before
>> the next bdrv_next() call, it might be that the associated BDS is not
>> the same that was referenced previously. In that case, the wrong BDS
>> is unreferenced, leading to an assertion failure later:
>>
>>> bdrv_unref: Assertion `bs->refcnt > 0' failed.
> 
> Your change makes sense, but in theory it shouldn't make a difference.
> The real bug is in the caller, you can't allow graph modifications while
> iterating the list of nodes. Even if it doesn't crash (like after your
> patch), you don't have any guarantee that you will have seen every node
> that exists that the end - and maybe not even that you don't get the
> same node twice.
> 
>> In particular, this can happen in the context of bdrv_flush_all(),
>> when polling for bdrv_co_flush() in the generated co-wrapper leads to
>> a graph change (for example with a stream block job [0]).
> 
> The whole locking around this case is a bit tricky and would deserve
> some cleanup.
> 
> The basic rule for bdrv_next() callers is that they need to hold the
> graph reader lock as long as they are iterating the graph, otherwise
> it's not safe. This implies that the ref/unref pairs in it should never
> make a difference either - which is important, because at least
> releasing the last reference is forbidden while holding the graph lock.
> I intended to remove the ref/unref for bdrv_next(), but I didn't because
> I realised that the callers need to be audited first that they really
> obey the rules. You found one that would be problematic.
> 
> The thing that bdrv_flush_all() gets wrong is that it promises to follow
> the graph lock rules with GRAPH_RDLOCK_GUARD_MAINLOOP(), but then calls
> something that polls. The compiler can't catch this because bdrv_flush()
> is a co_wrapper_mixed_bdrv_rdlock. The behaviour for these functions is:
> 
> - If called outside of coroutine context, they are GRAPH_UNLOCKED
> - If called in coroutine context, they are GRAPH_RDLOCK
> 
> We should probably try harder to get rid of the mixed functions, because
> a synchronous co_wrapper_bdrv_rdlock could actually be marked
> GRAPH_UNLOCKED in the code and then the compiler could catch this case.
> 
> The fix for bdrv_flush_all() is probably to make it bdrv_co_flush_all()
> with a coroutine wrapper so that the graph lock is held for the whole
> function. Then calling bdrv_co_flush() while iterating the list is safe
> and doesn't allow concurrent graph modifications.

I attempted this now, but ran into two issues:

The first is that I had to add support for a function without arguments
to the block-coroutine-wrapper.py script. I can send this as an RFC in
any case if desired.

The second is that iotest 255 ran into an assertion failure upon QMP 'quit':

> ../block/graph-lock.c:113: bdrv_graph_wrlock: Assertion `!qemu_in_coroutine()' failed.

Looking at the backtrace:

> #5  0x0000762a90cc3eb2 in __GI___assert_fail
>     (assertion=0x5afb07991e7d "!qemu_in_coroutine()", file=0x5afb07991e00 "../block/graph-lock.c", line=113, function=0x5afb07991f20 <__PRETTY_FUNCTION__.4> "bdrv_graph_wrlock")
>     at ./assert/assert.c:101
> #6  0x00005afb07585311 in bdrv_graph_wrlock () at ../block/graph-lock.c:113
> #7  0x00005afb07573a36 in blk_remove_bs (blk=0x5afb0af99420) at ../block/block-backend.c:901
> #8  0x00005afb075729a7 in blk_delete (blk=0x5afb0af99420) at ../block/block-backend.c:487
> #9  0x00005afb07572d88 in blk_unref (blk=0x5afb0af99420) at ../block/block-backend.c:547
> #10 0x00005afb07572fe8 in bdrv_next (it=0x762a852fef00) at ../block/block-backend.c:618
> #11 0x00005afb0758cd65 in bdrv_co_flush_all () at ../block/io.c:2347
> #12 0x00005afb0753ba37 in bdrv_co_flush_all_entry (opaque=0x7ffff12c6050) at block/block-gen.c:1391
> #13 0x00005afb0773bf41 in coroutine_trampoline (i0=168365184, i1=23291)

So I guess calling bdrv_next() is not safe from a coroutine, because the
function doing the iteration could end up being the last thing to have a
reference for the BB.

Best Regards,
Fiona


