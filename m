Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2703D64062
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 06:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVlJy-0008Sp-06; Wed, 17 Dec 2025 01:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vVlJw-0008SY-KR
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:47:36 -0500
Received: from sg-1-100.ptr.blmpb.com ([118.26.132.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vVlJe-00006i-Lx
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765954023; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qFnIj5kqyyonbQEMANvUGU7U4GDQh8qV/4lH5F61gyM=;
 b=CwO5FV7U7Bnz2WJbYyQtcHjrWjOHBRIGRlL0CJvRhGaQ0URQQiw5oQ7f6aTqPxy1tKAU9C
 3DcrCBRawUousaD0ggRUJMS4qt7Z8S+S39nzYDzAvy2Vt+QvCfwLlIc68NBSVOtd/MDK/f
 9nUhh3Y7mayx5DORhL61ICzMR4qSm60slw7J3WB/V9V9DP8iWduRLrcA2FBGqkbejvh6UP
 E6o2Lkrd0CbYmtQmzq8C+A93wThXW57lZ353kU5xI9VsswqFwzAqOfuPGFv1TeXq7x7pEd
 WRGtRkt+B2Wb7T+JRVIViGizyKyj3T7uC0YnRPfaT3nb67btWSThbdOhRsTSKg==
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <29bc82b4-99c3-4275-b4a8-cfc400f0e44d@bytedance.com>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
 <877bum36ed.fsf@suse.de> <aUGIPj1JNpd8HZ-V@x1.local>
Cc: <qemu-devel@nongnu.org>, "Fabiano Rosas" <farosas@suse.de>, 
 <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <david@kernel.org>, <philmd@linaro.org>
Date: Wed, 17 Dec 2025 14:46:58 +0800
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Peter Xu" <peterx@redhat.com>
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2694251e5+627d78+nongnu.org+xuchuangxclwt@bytedance.com>
In-Reply-To: <aUGIPj1JNpd8HZ-V@x1.local>
Received-SPF: pass client-ip=118.26.132.100;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-100.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/12/2025 00:26, Peter Xu wrote:
> On Tue, Dec 16, 2025 at 10:25:46AM -0300, Fabiano Rosas wrote:
>> "Chuang Xu" <xuchuangxclwt@bytedance.com> writes:
>>
>>> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
>>>
>>> In our long-term experience in Bytedance, we've found that under
>>> the same load, live migration of larger VMs with more devices is
>>> often more difficult to converge (requiring a larger downtime limit).
>>>
>>> Through some testing and calculations, we conclude that bitmap sync time
>>> affects the calculation of live migration bandwidth.
> Side note:
>
> I forgot to mention when replying to the old versions, but we introduced
> avail-switchover-bandwidth to partially remedy this problem when we hit it
> before - which may or may not be exactly the same reason here on unaligned
> syncs as we didn't further investigate (we have VFIO-PCI devices when
> testing), but the whole logic should be similar that bw was calculated too
> small.
In bytedance, we also migrate vms with vfio devices, which also suffer from
the issue of long vfio bitmap sync time for large vm.
>
> So even if with this patch optimizing sync, bw is always not as accurate.
> I wonder if we can still fix it somehow, e.g. I wonder if 100ms is too
> short a period to take samples, or at least we should be able to remember
> more samples so the reported bw (even if we keep sampling per 100ms) will
> cover longer period.
>
> Feel free to share your thoughts if you have any.
>
FYI:
Initially, when I encountered the problem of large vm migration hard to 
converge,
I tried subtracting the bitmap sync time from the bandwidth calculation,
which alleviated the problem somewhat. However, through formula calculation,
I found that this did not completely solve the problem. Therefore, I 
decided to
conduct specific analysis for specific scenario to minimize the bitmap 
sync time
as much as possible.
>>> When the addresses processed are not aligned, a large number of
>>> clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
>>> 2048 clear_dirty ioctls from two different memory_listener),
>>> which increases the time required for bitmap_sync and makes it
>>> more difficult for dirty pages to converge.
>>>
>>> For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
>>> 16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
>>> (tested with 10GBps dirty rate, the sync time increases as the dirty
>>> page rate increases), Here are each part of the sync time:
>>>
>>> - sync from kvm to ram_list: 2.5ms
>>> - vhost_log_sync:3ms
>>> - sync aligned memory from ram_list to RAMBlock: 5ms
>>> - sync misaligned memory from ram_list to RAMBlock: 61ms
>>>
>>> Attempt to merge those fragmented clear_dirty ioctls, then syncing
>>> misaligned memory from ram_list to RAMBlock takes only about 1ms,
>>> and the total sync time is only *12ms*.
>>>
>>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>>> ---
>>>   accel/tcg/cputlb.c       |  5 ++--
>>>   include/system/physmem.h |  7 +++---
>>>   migration/ram.c          | 17 ++++----------
>>>   system/memory.c          |  2 +-
>>>   system/physmem.c         | 49 ++++++++++++++++++++++++++++------------
>>>   5 files changed, 47 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>>> index fd1606c856..c8827c8b0d 100644
>>> --- a/accel/tcg/cputlb.c
>>> +++ b/accel/tcg/cputlb.c
>>> @@ -857,8 +857,9 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>>>   void tlb_protect_code(ram_addr_t ram_addr)
>>>   {
>>>       physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
>>> -                                             TARGET_PAGE_SIZE,
>>> -                                             DIRTY_MEMORY_CODE);
>>> +                                         TARGET_PAGE_SIZE,
>>> +                                         DIRTY_MEMORY_CODE,
>>> +                                         NULL);
>>>   }
>>>   
>>>   /* update the TLB so that writes in physical page 'phys_addr' are no longer
>>> diff --git a/include/system/physmem.h b/include/system/physmem.h
>>> index 879f6eae38..8eeace9d1f 100644
>>> --- a/include/system/physmem.h
>>> +++ b/include/system/physmem.h
>>> @@ -39,9 +39,10 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>>   
>>>   void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
>>>   
>>> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>>> -                                          ram_addr_t length,
>>> -                                          unsigned client);
>>> +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
>>> +                                              ram_addr_t length,
>>> +                                              unsigned client,
>>> +                                              unsigned long *dest);
>>>   
>>>   DirtyBitmapSnapshot *
>>>   physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 29f016cb25..a03c9874a2 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -942,7 +942,6 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>>                                                     ram_addr_t start,
>>>                                                     ram_addr_t length)
>>>   {
>>> -    ram_addr_t addr;
>>>       unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>>>       uint64_t num_dirty = 0;
>>>       unsigned long *dest = rb->bmap;
>>> @@ -996,17 +995,11 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>>       } else {
>>>           ram_addr_t offset = rb->offset;
>>>   
>>> -        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>>> -            if (physical_memory_test_and_clear_dirty(
>>> -                        start + addr + offset,
>>> -                        TARGET_PAGE_SIZE,
>>> -                        DIRTY_MEMORY_MIGRATION)) {
>>> -                long k = (start + addr) >> TARGET_PAGE_BITS;
>>> -                if (!test_and_set_bit(k, dest)) {
>>> -                    num_dirty++;
>>> -                }
>>> -            }
>>> -        }
>>> +        num_dirty = physical_memory_test_and_clear_dirty(
>>> +                        start + offset,
>>> +                        length,
>>> +                        DIRTY_MEMORY_MIGRATION,
>>> +                        dest);
>>>       }
>>>   
>>>       return num_dirty;
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 8b84661ae3..666364392d 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>>>   {
>>>       assert(mr->ram_block);
>>>       physical_memory_test_and_clear_dirty(
>>> -        memory_region_get_ram_addr(mr) + addr, size, client);
>>> +        memory_region_get_ram_addr(mr) + addr, size, client, NULL);
>>>   }
>>>   
>>>   int memory_region_get_fd(MemoryRegion *mr)
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index c9869e4049..f8b660dafe 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -1089,19 +1089,31 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
>>>       }
>>>   }
>>>   
>>> -/* Note: start and end must be within the same ram block.  */
>>> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>>> +/*
>>> + * Note: start and end must be within the same ram block.
>>> + *
>>> + * @dest usage:
>> I'm not sure if it's just me, but I find this "dest" term quite
>> confusing. "bmap" might be more straight-forward.
>>
>>> + * - When @dest is provided, set bits for newly discovered dirty pages
>>> + *   only if the bit wasn't already set in dest, and count those pages
>>> + *   in num_dirty.
>> Am I misreading the code? I don't see this "set ... only if the bit
>> wasn't already set" part. What I see is: "set bits, but only count those
>> pages if the bit wasn't already set".
> Agrees on both points.. one more thing to mention below.
This will be fixed in next version.
>>> + * - When @dest is NULL, count all dirty pages in the range
>>> + *
>>> + * @return:
>>> + * - Number of dirty guest pages found within [start, start + length).
>>> + */
>>> +uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
>>>                                                 ram_addr_t length,
>>> -                                              unsigned client)
>>> +                                              unsigned client,
>>> +                                              unsigned long *dest)
>>>   {
>>>       DirtyMemoryBlocks *blocks;
>>>       unsigned long end, page, start_page;
>>> -    bool dirty = false;
>>> +    uint64_t num_dirty = 0;
>>>       RAMBlock *ramblock;
>>>       uint64_t mr_offset, mr_size;
>>>   
>>>       if (length == 0) {
>>> -        return false;
>>> +        return 0;
>>>       }
>>>   
>>>       end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
>>> @@ -1118,12 +1130,19 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>>>           while (page < end) {
>>>               unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
>>>               unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
>>> -            unsigned long num = MIN(end - page,
>>> -                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
>>>   
>>> -            dirty |= bitmap_test_and_clear_atomic(blocks->blocks[idx],
>>> -                                                  offset, num);
>>> -            page += num;
>>> +            if (bitmap_test_and_clear_atomic(blocks->blocks[idx], offset, 1)) {
>>> +                if (dest) {
>>> +                    unsigned long k = page - (ramblock->offset >> TARGET_PAGE_BITS);
>>> +                    if (!test_and_set_bit(k, dest)) {
>>> +                        num_dirty++;
>>> +                    }
>>> +                } else {
>>> +                    num_dirty++;
>>> +                }
>>> +            }
>>> +
>>> +            page++;
> Sorry I could have mentioned this in the previous version: IMHO it'll still
> be nice to keep the one atomic operations for !dest/!bmap case over "num".
> There's no reason we need to introduce even any slightest regression in
> those paths.
>
> Thanks,

bitmap_test_and_clear_atomic returns bool, not the number of bits cleared.
So for !bmap case we can only return whether there is dirty, not the number
of dirty, and this might be a bit confusing.

>>>           }
>>>   
>>>           mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
>>> @@ -1131,18 +1150,18 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
>>>           memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
>>>       }
>>>   
>>> -    if (dirty) {
>>> +    if (num_dirty) {
>>>           physical_memory_dirty_bits_cleared(start, length);
>>>       }
>>>   
>>> -    return dirty;
>>> +    return num_dirty;
>>>   }
>>>   
>>>   static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
>>>   {
>>> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
>>> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
>>> -    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
>>> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, NULL);
>>> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, NULL);
>>> +    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, NULL);
>>>   }
>>>   
>>>   DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty

