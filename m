Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUdtq-0000eX-Gr; Wed, 03 Jun 2026 01:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wUdtf-0000dX-Eo
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 01:12:08 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wUdtc-0001Tk-5D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 01:12:07 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6535Biv9056367
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 3 Jun 2026 14:11:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9YwXyKyWX/ta9EjexXPbQtyK8GzrXoB0Ia66M95GUtM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1780463505; v=1;
 b=mdJ5knALreOK45OFFVk2LfYrq1ZOnC93MsK2kxlCf21Tk1z7KxNnt8xhrdfp2kto
 MujGxdloethNVVWdbSKvLOsGWvDiqEOUV0X7YLZzOaaeF8BN8+r3rMXaU5CWhQl7
 /1gvdHXjAeeGbuCFH4Pbqd7YY7cDG+mevA42RKf7uH1FSDmuu1rCPeyrHfd3QKoP
 PO59ZU/HwRtoiAg8FFNAX+f0hIs1XCEQFZiCfk2MlDEuUWe+Pzb7nIb06KTURHz2
 EEc4zNyBrFvolWoF24M4Hhm1WHDdLTFj+HQ3RI5JN0UrKnvDQIUBC2gFOCrQm8xR
 GRoKu3gMrstI7ZLd+8qpCQ==
Message-ID: <622da0a8-8101-4816-bf20-b5c3c9547a5f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 3 Jun 2026 14:11:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260601205900.1067714-1-peterx@redhat.com>
 <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
 <ah80T6aIns82fspH@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ah80T6aIns82fspH@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/03 4:51, Peter Xu wrote:
> On Tue, Jun 02, 2026 at 01:25:02PM +0900, Akihiko Odaki wrote:
>> On 2026/06/02 5:59, Peter Xu wrote:
>>> The race condition was not reported in any real bug, but I found it while
>>> reviewing some relevant chnages from Akihiko [1].  It's not clear if
>>> there's any way to reproduce it, so far it's only theoretical.  Hence
>>> there's also no Fixes tag attached.  There's also no need to copy stable
>>> until we have a solid reproducer.
>>>
>>> Currently, mru_block might still points to ramblocks that are removed if
>>> below race condition happens:
>>>
>>>     Reader A                              Writer
>>>     --------                              ------
>>>     rcu_read_lock()
>>>     walk list, find block X
>>>                                           QLIST_REMOVE_RCU(X)
>>>                                           qatomic_set(&mru_block, NULL)
>>>                                           call_rcu(X, reclaim_ramblock)
>>>     qatomic_set(&mru_block, X)  <----------- overwrites NULL
>>>     rcu_read_unlock()
>>>                                           grace period ends, X freed
>>>
>>>     Reader C
>>>     --------
>>>     rcu_read_lock()
>>>     qatomic_rcu_read(&mru_block) -> X
>>>     Read X's block->offset ...  <----------- UAF
>>>
>>> To fix it, we can introduce a nested RCU free for reset of the mru_block
>>> field, and only free the ramblock until the 2nd RCU call.
>>>
>>> Since QEMU always: (1) dequeue the RCU node before invoking the
>>> function, (2) reset all fields in rcu_head in the call_rcu1() call, nested
>>> RCU will work all fine like what's used in this patch.
>>>
>>> [1] https://lore.kernel.org/r/5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp
>>>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>
>>> Based-on: <5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>> Since there's no reproducer, I didn't verify the problem as-is.  What I did
>>> is I ran this through some high concurrency "make check -jN" (8 processes
>>> with 4 cores pinned, hence 8*N make-check threads running concurrently on 4
>>> physical cores), I didn't see any regression.
>>> ---
>>>    system/physmem.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 9e1ac13e82..1697568fa7 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -2590,6 +2590,21 @@ static void reclaim_ramblock(RAMBlock *block)
>>>        g_free(block);
>>>    }
>>> +static void reclaim_ramblock_prepare(RAMBlock *block)
>>> +{
>>> +    /*
>>> +     * 1st round rcu free guarantees the last reader that can access this
>>> +     * ramblock is gone.  Reset this field making sure it will never point
> 
> [1]
> 
>>> +     * to the ramblock being freed.
>>
>> Somewhat nitpicking, but I would call this the first grace period rather
>> than “rcu free”. call_rcu() itself does not free anything; it schedules a
>> callback to run after a grace period, which is what matters here.
> 
> Sure, I'll fix the wording.
> 
>>
>>> +     */
>>> +    qatomic_set(&ram_list.mru_block, NULL);
>>> +    /*
>>> +     * Note: this is an intended nested use of rcu_head.  If needed, we can
>>> +     * provide two rcu_heads for ramblock.
>>> +     */
>>> +    call_rcu(block, reclaim_ramblock, rcu);
>>> +}
>>> +
>>>    void qemu_ram_free(RAMBlock *block)
>>>    {
>>>        g_autofree char *name = NULL;
>>> @@ -2607,10 +2622,11 @@ void qemu_ram_free(RAMBlock *block)
>>>        name = cpr_name(block->mr);
>>>        cpr_delete_fd(name, 0);
>>>        QLIST_REMOVE_RCU(block, next);
>>> +    /* First attempt of reset, see reclaim_ramblock_prepare() for the 2nd */
>>>        qatomic_set(&ram_list.mru_block, NULL);
>>
>> I think it would be better to remove this for simplicity.
>>
>> mru_block is cleared later anyway, so this does not affect correctness. The
>> only practical effect is that qemu_get_ram_block() may be slower during the
>> first grace period.
>>
>> Conceptually, it is simpler to describe the two grace periods as serving two
>> distinct purposes, rather than as two attempts to clear mru_block. With the
>> early clear removed, readers do not first need to understand that the first
>> grace period leaves the first clear ineffective; they can instead focus on
>> how it makes the later clear effective.
> 
> It was my intention to keep this, because then it's easier to justify
> "nobody has access to the ramblock being removed".
> 
> If with this line removed here, it means after the first grace period (say,
> reaching reclaim_ramblock_prepare()), RCU readers can still access the
> ramblock, essentially because before reclaim_ramblock_prepare() clearing
> mru_block even if the block is not visible on ram_list it's still visible
> when a cache hit happens.

qemu_get_ram_block() may set mru_block during the grace period. Once 
mru_block is set, RCU readers can still access the ramblock, even if the 
block is no longer visible in ram_list.

When enriching the comment in reclaim_ramblock_prepare(), I think the 
phrase “the last reader that can access this ramblock is gone” could be 
improved. What matters here is that the last reader that could find the 
block in ram_list is gone. The block is no longer visible in ram_list to 
any later reader, and clearing the cache at that point ensures that it 
is no longer visible through an mru_block cache hit either.

Regards,
Akihiko Odaki

> 
> But I agree removal of this line shouldn't involve correctness issues,
> because qemu_get_ram_block() when having a mru_block cache hit, will always
> return the block directly:
> 
> [2]
> 
>      block = qatomic_rcu_read(&ram_list.mru_block);
>      if (block && addr - block->offset < block->max_length) {
>          return block;
>      }
> 
> And it will never reach the "found:" label later to update mru_block again.
> But that's obscure.
> 
> So it's a niche use of it, but keeping this line to reset makes this
> justification slightly easier (corresponds to the comment at [1] above).
> 
> I can also remove this line, but then I'll need to enrich comment
> explaining case [2] above.  We'll also need to be careful on not changing
> that behavior in qemu_get_ram_block().
> 
> Thanks,
> 
>>
>> Regars,
>> Akihiko Odaki
>>
>>>        /* Write list before version */
>>>        qatomic_store_release(&ram_list.version, ram_list.version + 1);
>>> -    call_rcu(block, reclaim_ramblock, rcu);
>>> +    call_rcu(block, reclaim_ramblock_prepare, rcu);
>>>        qemu_mutex_unlock_ramlist();
>>>    }
>>
> 


