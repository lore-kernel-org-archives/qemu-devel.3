Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC2CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSciw-0000sV-6j; Thu, 28 May 2026 11:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wScim-0000rm-8f
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:32:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wScii-0006LJ-Ng
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:32:32 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64SFWI7F046754
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 May 2026 00:32:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wBABkHpijSR7Gev1EY2/yDurjQzcAgfcb0WnlYP5ncY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779982338; v=1;
 b=QeemPkwSNqySFITDU1bAJY66I8+75t44Hd7e3h0nnShX01OCNyzpCT69m95TN3mT
 baM5WtVzAHYIK1LwfIyCh01ioY0VadQiVN0VHN6H6bAGmIzzHcM6PL+z8QwndjHX
 d40T810LBjn4v7GCN/BdUptOWpxN/QbEdU1/GBut02wTg3pcqd/apch2J+t4MrxQ
 IS6jjbE6aU6ULo6Rj5y7eFMiDUqAQ1siwL8n0Pn52DHtAuVCtOYfGdkGxQu/Fn0O
 h1Cek6pAPVYhCtrxJqXmCrCZMJOgSsTR8wrHX2l0FYlR79H7RutwOSR+Px4qsW9p
 4YGKP1InunnD13sPCdly6A==
Message-ID: <b4f87ec7-0406-430e-b645-0539a5e083be@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 29 May 2026 00:32:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Synchronize ram_list accesses
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
 <ahYSO98JgdYJrP2e@x1.local>
 <8d81e622-1397-4579-bbe5-50ee174a3272@rsg.ci.i.u-tokyo.ac.jp>
 <ahhcvqnOWEoYmCJF@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ahhcvqnOWEoYmCJF@x1.local>
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



On 2026/05/29 0:18, Peter Xu wrote:
> On Wed, May 27, 2026 at 04:54:42PM +0900, Akihiko Odaki wrote:
>> On 2026/05/27 6:35, Peter Xu wrote:
>>> On Sat, May 23, 2026 at 09:38:28PM +0900, Akihiko Odaki wrote:
>>>> Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
>>>> access to ram_list [1]. Ensure the concurrent accesses to ram_list are
>>>> properly synchronized with atomic accesses, mutexes, or RCU.
>>>>
>>>> First, the plain assignments of ram_list.mru_block are replaced with
>>>> qatomic_set(). A comment in qemu_get_ram_block() explains why the
>>>> ordering requirement is relaxed, but it still needs to be atomically
>>>> accessed. include/qemu/atomic.h says:
>>>>
>>>>> The C11 memory model says that variables that are accessed from
>>>>> different threads should at least be done with __ATOMIC_RELAXED
>>>>> primitives or the result is undefined. Generally this has little to
>>>>> no effect on the generated code but not using the atomic primitives
>>>>> will get flagged by sanitizers as a violation.
>>>>
>>>> Second, ram_list.version accesses are replaced with atomic operations
>>>> or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
>>>> has tighter ordering requirements for one of its goals: ensuring that
>>>> the reader-held rs->last_seen_block value is invalidated whenever a RAM
>>>> block is reclaimed between two RCU reader critical sections. Below are
>>>> steps a reader and an updater follow:
>>>>
>>>> Reader:
>>>>
>>>> R-1. Enter the first RCU read-side critical section:
>>>> R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
>>>> R-1-2. rs->last_seen_block = an element of ram_list.blocks
>>>> R-2. Enter the second RCU read-side critical section:
>>>> R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
>>>> R-2-2.     rs->last_seen_block = NULL
>>>>
>>>> Updater:
>>>>
>>>> W-1. Enter a ram_list.mutex critical section
>>>> W-1-1. Update ram_list.blocks
>>>> W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
>>>> W-2. Enter another ram_list.mutex critical section
>>>> W-2-1. QLIST_REMOVE_RCU(block, next)
>>>> W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
>>>> W-2-3. call_rcu(block, reclaim_ramblock, rcu)
>>>>
>>>> W-1-2 represents the write observed by R-1-1.
>>>>
>>>> ram_list.version is read non-atomically on the update side because the
>>>> update side is serialized with ram_list.mutex. The other ram_list
>>>> accesses in these steps are reasoned about in two cases.
>>>>
>>>> When the grace period of W-2-3 contains R-2:
>>>>       qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
>>>>       enforce the following ordering:
>>>>           W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
>>>>       The value of ram_list.blocks stored by W-1-1 or a newer value that
>>>>       was loaded by R-1-2 is still valid because of the grace period.
>>>>
>>>> When the grace period of W-2-3 ends before R-2:
>>>>       call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
>>>>       the following ordering:
>>>>           W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
>>>>       The value of ram_list.version stored by W-2-2 or a newer value that
>>>>       was loaded by R-2-1 differs from rs->last_version and the reader
>>>>       invalidates rs->last_seen_block.
>>>>
>>>> Together, these steps ensure that rs->last_seen_block is invalidated
>>>> whenever necessary. With added atomic operations, pre-existing memory
>>>> barriers are no longer necessary and are removed.
>>>>
>>>> Any other ram_list accesses are already properly synchronized.
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>> Above link [1] also mentioned about a hang.  Just to double check: we're
>>> only trying to silent the TSAN warning (which is a false positive), right?
>>
>> The hang is irrelevant and this is indeed to address the TSAN warning,
>> though I'm a bit reluctant to call it false positive because, strictly
>> speaking, the code actually relies on undefined behavior.
>>
>>>
>>>> ---
>>>>    migration/ram.c  | 10 +++++-----
>>>>    system/physmem.c | 16 +++++++---------
>>>>    2 files changed, 12 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index fc38ffbf8af1..6da24d725861 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -2495,7 +2495,10 @@ static void ram_state_reset(RAMState *rs)
>>>>        rs->last_seen_block = NULL;
>>>>        rs->last_page = 0;
>>>> -    rs->last_version = ram_list.version;
>>>> +
>>>> +    /* Read version before ram_list.blocks */
>>>> +    rs->last_version = qatomic_load_acquire(&ram_list.version);
>>>> +
>>>>        rs->xbzrle_started = false;
>>>>        ram_page_hint_reset(&rs->page_hint);
>>>> @@ -3270,13 +3273,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>>>         */
>>>>        WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
>>>>            WITH_RCU_READ_LOCK_GUARD() {
>>>> -            if (ram_list.version != rs->last_version) {
>>>> +            if (qatomic_read(&ram_list.version) != rs->last_version) {
>>>>                    ram_state_reset(rs);
>>>>                }
>>>
>>> Not directly relevant to this patch, but I never thought into why this few
>>> lines are needed at all, and then I found I don't have an answer..
>>>
>>> Here, ram_list version change should only happen during ramblock
>>> add/remove.  I can think of a few special cases:
>>>
>>> a) device add/remove (e.g. dimms) causing new / removing ramblocks, should
>>>      never happen as qdev code fails any device add/remove attempt during
>>>      migration (qdev_device_add_from_qdict, qdev_unplug)
>>>
>>> b) virtio-mem, which only manages one memory backend, hence one ramblock,
>>>      no add/remove
>>>
>>> c) virtio-gpu, will do random add/remove with memory_region_init_ram_ptr()
>>>      which means ramblocks are not migratable
>>>
>>> PS: I recall we have other special cases like ROM sizes can change on dest
>>> QEMU, but it's about used_length, not about version boosts, so doesn't
>>> matter here.
>>>
>>> Both a) and b) should make sure no change on version, c) will change
>>> version, but in a case where the ramblock is destined to be not migratable,
>>> hence not visible to migration core.
>>>
>>> The patch itself looks all fine, but I'm just wondering if we should just
>>> remove this check completely or even try to somehow trap it from happening
>>> (if we can rule out things like virtio-gpu): if something really changed,
>>> it'll be a serious problem because we sync ramblock list already during
>>> ram_save_setup.
>>
>> There is another edge case: a ram_list.blocks change may be propagated to
>> the thread calling ram_save_setup() and ram_save_iterate() at different
>> timing. We are only ensuring that ram_list.blocks changes invalidating old
>> blocks are delivered with WITH_RCU_READ_LOCK_GUARD().
>>
>> So I think there is a theoretical race condition that breaks migration,
>> though triggering it in practice may not be realistic.
> 
> Could you elaborate more on the theoretical race mentioned?
> 
> My comment above was trying to say there should have no such happening, the
> virtio-gpu boosting the version seems to be an accident to me because
> migration doesn't need that (because virtio-gpu ramblocks are not
> migratable anyway).

For example, a device may be removed before migration, but the removal 
of the block from ram_list.blocks and the increment of ram_list.version 
may not be observed by the thread calling ram_save_setup(); RCU only 
guarantees that these writes will be visible in read-side critical 
sections *after* the grace period ends, which can be after the 
ram_save_setup() call and before following ram_save_iterate() calls.

Regards,
Akihiko Odaki

> 
> While looking at this once more, I found that I'm lost why mru_block is
> race free..
> 
> The problem is mru_block is written by the RCU readers, then... see whether
> this race can happen (even with this patch):
> 
>    Reader A                              Writer
>    --------                              ------
>    rcu_read_lock()
>    walk list, find block X
>                                          QLIST_REMOVE_RCU(X)
>                                          qatomic_set(&mru_block, NULL)
>                                          call_rcu(X, reclaim_ramblock)
>    qatomic_set(&mru_block, X)  <----------- overwrites NULL
>    rcu_read_unlock()
>                                          grace period ends, X freed
> 
>    Reader C
>    --------
>    rcu_read_lock()
>    qatomic_rcu_read(&mru_block) -> X
>    Read X's block->offset ...  <----------- UAF
> 
> One thing I can think of so far is this (pesudo code only, ignoring atomic
> ops for now):
> 
> qemu_ram_free():
>      qemu_mutex_lock_ramlist();
>      ...
>      QLIST_REMOVE_RCU(block, next);
>      /*
>       * 1st attempt to reset it, note: concurrent reader may set it again,
>       * even to the ramblock being freed.
>       */
>      ram_list.mru_block = NULL;
>      ram_list.version++;
>      /*
>       * Only to make sure whoever might be using this ramblock being
>       * removed to finish using it.
>       */
>      call_rcu(block, rcu_noop_fn, rcu);
>      drain_call_rcu();
>      /*
>       * 2nd attempt to clear it: after call_rcu() we make sure nobody yet
>       * has access to the ramblock being removed, hence this clear makes
>       * sure it won't get set again by anyone to the removed ramblock.
>       */
>      ram_list.mru_block = NULL;
>      call_rcu(block, reclaim_ramblock, rcu);
>      qemu_mutex_unlock_ramlist();
> 
> But it looks a bit ugly.  Thoughts?
> 
> Thanks,
> 


