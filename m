Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHAT-0004AW-18; Wed, 10 Jun 2026 07:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXHAJ-00049s-S3
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:32:13 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXHAG-000826-OI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:32:11 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65ABViBS026848
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 10 Jun 2026 20:31:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=FAoOcSvRYN2kQuQkL4o0pAxU0TiG/7SbK4b0rii4Sno=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781091105; v=1;
 b=rGV06O5LudMYBwdSZW/Cnkqed9MxmhEiMTHrlP1zTy5wB7ycnan95OUj9RDMQnYy
 QatpnF7GJFeMBCnffVUxTzvAFR5bWKpMZPx90VK4MAOqGfbztMbBrPoJ7cWK+rWG
 1gKynYXuftihADMBFmAHydy92f2OrxmL9P1eaiwvFp2IdwIlr+lMO76savlzoxed
 rkfkUjjgSiV8vErewbmmGUEXmOtqYo4JWfpsR0TiLQHLYBD8R+7rKzsm9kmkh+q7
 wgISdFYm2VzTkMQcObW/XQbYZapEhpRSXp7V0dHAIQGtneSPK1iHj5s7W3ZgEPin
 Y2HmdHntj0L4agjozacGKw==
Message-ID: <fb963da2-2369-41d4-a510-cfd470a4054f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 10 Jun 2026 20:31:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memory/ramblock: Fix clear of mru_block on possible
 race condition
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260604133429.1268084-1-peterx@redhat.com>
 <c189e708-f9ac-4ed1-ad93-04d8916afac3@redhat.com> <aicUjHfCBdXEczsN@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aicUjHfCBdXEczsN@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/06/09 4:14, Peter Xu wrote:
> On Mon, Jun 08, 2026 at 06:05:34PM +0200, Paolo Bonzini wrote:
>> On 6/4/26 15:34, Peter Xu wrote:
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
>>
>> There is a version field in RAMList.  Maybe we need mru_version too?
>>
>> - reader A reads version before starting the list walk, then writes
>> mru_version and mru_block
>>
>> - writers update version and do not even have to clear mru_block
>>
>> - new readers ignore mru_block if mru_version != version
>>
>> This works, but there is a snag:
>>
>>      reader A (MRU parts elided, assuming a miss)
>>      --------------------------------------------
>>      load_acquire version // load version before walking list
>>      walk list
>>      ...
>>
>>              writer B
>>              -----------------------
>>              // like seqcount_write_begin
>>              store version++
>>              smp_wmb();
>>              // ----
>>              QLIST_REMOVE_RCU
>>              store release version++  // like seqcount_write_end
>>
>>      // these two must be atomic!
>>      store release mru_version = version & ~1, mru_block = block
>>
>>      reader C (MRU parts shown)
>>      --------------------
>>      load_acquire mru_version    // like seqcount_read_begin
>>      load mru_block
>>      // like seqcount_read_retry
>>      smp_rmb()
>>      load_acquire version
>>      // ----
>>      if block == NULL || version != mru_version || block mismatch
>>        walk list
>>
>> In other words, the seqcount retry check compares the current version of the
>> list against the one *stored by the previous reader*.
>>
>> The snag is that torn writes of the (version, block) pair are a problem, so
>> the store of mru_version and mru_block must be atomic and that requires
>> CONFIG_ATOMIC128.  Maybe avoid MRU altogether if it's not available, and if
>> it is use qatomic_read__nocheck/qatomic_set__nocheck?
> 
> Indeed looks like having mru_version is another possible solution, but I
> also don't see how we can avoid using 128b atomic..  Besides, the logic
> seems to be slightly involved: I tried to write another patch with
> QemuSeqLock which seems cleaner, and I've attached it at the end.. only
> pesudo code and I left a comment for the atomic 128b update.
> 
> NOTE: in that patch I also removed version update for adding new ramblocks
> because IIUC we don't need it.  If anyone thinks that's a good idea that
> can be done separately.. but it shouldn't matter a lot with current master.
> 
> Shall we just stick with the RCU nested free approach?  Personally I think
> it's still straightforward and less overhead (no penalty on reader at all).

I agree. I think the RCU nested free approach unless there is an 
advantage of having mru_version I missed.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> ===8<===
> 
>  From a04e925f5b9c82b07a38f801b73095cd3a71e91b Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 8 Jun 2026 14:45:01 -0400
> Subject: [PATCH] fix mru_block
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/system/ramlist.h |  9 +++++-
>   migration/ram.c          | 11 ++++---
>   system/physmem.c         | 63 +++++++++++++++++++++++++---------------
>   3 files changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/include/system/ramlist.h b/include/system/ramlist.h
> index c7f388f487..b2b4403e13 100644
> --- a/include/system/ramlist.h
> +++ b/include/system/ramlist.h
> @@ -5,6 +5,7 @@
>   #include "qemu/thread.h"
>   #include "qemu/rcu.h"
>   #include "qemu/rcu_queue.h"
> +#include "qemu/seqlock.h"
>   #include "system/ram_addr.h"
>   
>   typedef struct RAMBlockNotifier RAMBlockNotifier;
> @@ -42,12 +43,18 @@ typedef struct {
>   
>   typedef struct RAMList {
>       QemuMutex mutex;
> +    /* Version of the ram_list that found mru_block, must be an even number */
> +    unsigned mru_version;
>       RAMBlock *mru_block;
>       /* RCU-enabled, writes protected by the ramlist lock. */
>       QLIST_HEAD(, RAMBlock) blocks;
>       DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
>       unsigned int num_dirty_blocks;
> -    uint32_t version;
> +    /*
> +     * Version of the ram_list.  NOTE: currently we only boost this when
> +     * ramblocks are removed.
> +     */
> +    QemuSeqLock version;
>       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>   } RAMList;
>   extern RAMList ram_list;
> diff --git a/migration/ram.c b/migration/ram.c
> index 6da24d7258..14bce73f75 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -380,7 +380,7 @@ struct RAMState {
>       /* Last dirty target page we have sent */
>       ram_addr_t last_page;
>       /* last ram version we have seen */
> -    uint32_t last_version;
> +    unsigned last_version;
>       /* How many times we have dirty too many pages */
>       int dirty_rate_high_cnt;
>       /* these variables are used for bitmap sync */
> @@ -2487,6 +2487,7 @@ static void ram_page_hint_reset(PageLocationHint *hint)
>   
>   static void ram_state_reset(RAMState *rs)
>   {
> +    unsigned version;
>       int i;
>   
>       for (i = 0; i < RAM_CHANNEL_MAX; i++) {
> @@ -2497,10 +2498,12 @@ static void ram_state_reset(RAMState *rs)
>       rs->last_page = 0;
>   
>       /* Read version before ram_list.blocks */
> -    rs->last_version = qatomic_load_acquire(&ram_list.version);
> +    do {
> +        version = seqlock_read_begin(&ram_list.version);
> +    } while (seqlock_read_retry(&ram_list.version, version));
>   
> +    rs->last_version = version;
>       rs->xbzrle_started = false;
> -
>       ram_page_hint_reset(&rs->page_hint);
>   }
>   
> @@ -3273,7 +3276,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>        */
>       WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
>           WITH_RCU_READ_LOCK_GUARD() {
> -            if (qatomic_read(&ram_list.version) != rs->last_version) {
> +            if (seqlock_read_retry(&ram_list.version, rs->last_version)) {
>                   ram_state_reset(rs);
>               }
>   
> diff --git a/system/physmem.c b/system/physmem.c
> index 9e1ac13e82..1960dc64a7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -821,11 +821,29 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>   static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
>   {
>       RAMBlock *block;
> +    unsigned version = ram_list.mru_version;
>   
>       block = qatomic_rcu_read(&ram_list.mru_block);
> -    if (block && addr - block->offset < block->max_length) {
> +    /*
> +     * Don't use MRU one if ramblock might be removed or being removed.
> +     * While if we see the version hasn't incremented it means even if
> +     * there's a concurrent writer it needs to wait for this rcu reader to
> +     * finish using the ramblock, hence it's still safe.
> +     *
> +     * Also due to above, we must check seqlock_read_retry() first before
> +     * de-referencing block pointer here to make sure it's still not freed.
> +     */
> +    if (!seqlock_read_retry(&ram_list.version, version) &&
> +        block && addr - block->offset < block->max_length) {
>           return block;
>       }
> +
> +    /*
> +     * Read the current ram_list version. This is only needed for updating
> +     * mru_block; it's always safe to walk ram_list under RCU read lock.
> +     */
> +    version = seqlock_read_begin(&ram_list.version);
> +
>       RAMBLOCK_FOREACH(block) {
>           if (addr - block->offset < block->max_length) {
>               goto found;
> @@ -836,23 +854,10 @@ static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
>       abort();
>   
>   found:
> -    /* It is safe to write mru_block outside the BQL.  This
> -     * is what happens:
> -     *
> -     *     qatomic_set(&mru_block, xxx)
> -     *     rcu_read_unlock()
> -     *                                        xxx removed from list
> -     *                  rcu_read_lock()
> -     *                  read mru_block
> -     *                                        qatomic_set(&mru_block, NULL);
> -     *                                        call_rcu(reclaim_ramblock, xxx);
> -     *                  rcu_read_unlock()
> -     *
> -     * qatomic_rcu_set is not needed here.  The block was already published
> -     * when it was placed into the list.  Here we're just making an extra
> -     * copy of the pointer.
> -     */
> -    qatomic_set(&ram_list.mru_block, block);
> +    /* Only update mru_block if no ramblock is removed or being removed */
> +    if (!seqlock_read_retry(&ram_list.version, version)) {
> +        // atomic set both ram_list.mru_version/mru_block...
> +    }
>       return block;
>   }
>   
> @@ -2260,10 +2265,12 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       } else { /* list is empty */
>           QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
>       }
> -    qatomic_set(&ram_list.mru_block, NULL);
>   
> -    /* Write list before version */
> -    qatomic_store_release(&ram_list.version, ram_list.version + 1);
> +    /*
> +     * NOTE: we don't update ram_list.version when adding new ramblocks,
> +     * because the version is currently only used to invalidate cached
> +     * pointers to removed ramblocks.  No user cares about additions.
> +     */
>       qemu_mutex_unlock_ramlist();
>   
>       physical_memory_set_dirty_range(new_block->offset,
> @@ -2603,15 +2610,23 @@ void qemu_ram_free(RAMBlock *block)
>                                   block->max_length);
>       }
>   
> +    /*
> +     * We can use seqlock_write_[un]lock(), however stick with the helpers
> +     * when they're available to make it easier to track writers.
> +     */
>       qemu_mutex_lock_ramlist();
> +    seqlock_write_begin(&ram_list.version);
> +
>       name = cpr_name(block->mr);
>       cpr_delete_fd(name, 0);
>       QLIST_REMOVE_RCU(block, next);
> +    /* while version is odd, nobody will be updating this.. */
>       qatomic_set(&ram_list.mru_block, NULL);
> -    /* Write list before version */
> -    qatomic_store_release(&ram_list.version, ram_list.version + 1);
> -    call_rcu(block, reclaim_ramblock, rcu);
> +
> +    seqlock_write_end(&ram_list.version);
>       qemu_mutex_unlock_ramlist();
> +
> +    call_rcu(block, reclaim_ramblock, rcu);
>   }
>   
>   #ifndef _WIN32


