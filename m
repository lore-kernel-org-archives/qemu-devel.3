Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDEACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 02:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHYN2-0002VE-Dz; Fri, 07 Nov 2025 21:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHYN0-0002Um-6h
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 21:08:02 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHYMw-0002Sq-40
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 21:08:01 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A827l8E028162
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 8 Nov 2025 11:07:47 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ItFclBnt2vKWiKeWO4aqQU0k9WyuVB0xzjpV0PiOeSM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762567667; v=1;
 b=afESkhrgqxQCfwQTX1f/wAIA8WuG3tN0KpNofj9WAkC5f3Ytfsk0iWxh79WJfj3S
 AFvXAgp4jyQc01BHze5qUuuE02kZPIpAjjqEowOXjMmvhGFF1wEz4Jbx6+mzWCtq
 N5qvAujbUha8g4bHGV2766NrsK5miiMQUUOui4xu2drReG4oCJgjcplM4l4eLokg
 yyvExmF6l29NucZAeQ1BtDKklcqgY/WZ1LPyNPzRjp9rzbMJk6bc+FjCben7Vvud
 hidokOcTydZVOCI1sRGcBqBaZAyiuv+/IdnucSUfiNoUGM5fpF4i7S5uXPxu7vdO
 KFZwE7LErnSLGX0KxthBAQ==
Message-ID: <e7cb25c1-d43d-4729-8b43-6adcc343149b@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 8 Nov 2025 11:07:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Make FlatView root references weak
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
 <aQzf4F6RgkzYWkeM@x1.local>
 <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
 <aQ4g_UsDhTBYiQSZ@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aQ4g_UsDhTBYiQSZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/08 1:40, Peter Xu wrote:
> On Fri, Nov 07, 2025 at 11:16:56AM +0900, Akihiko Odaki wrote:
>> On 2025/11/07 2:50, Peter Xu wrote:
>>> On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
>>>> Generally speaking, we will not necessarily "always" get an issue report
>>>> when things went wrong with memory management. A bug in memory management
>>>> may not cause an immediate crash but corrupt the memory state which you will
>>>> find only later. The end result of memory corruption may look random and
>>>> result in a hard-to-debug issue report. A user may not even bother writing
>>>> an issue report at all; this is especially true for this kind of corner
>>>> cases that rarely happen.
>>>>
>>>> There should have been no such a hazard of memory corruption if the code did
>>>> exactly what the documentation said in the first place. The consistency of
>>>> the code and the documentation is essential, especially for this kind of
>>>> complex and fundamental code.
>>>
>>> Do you have encountered such case before?
>>>
>>> I wasn't expecting that, because what you were saying looks more like what
>>> Linux kernel would have a bug in mm.  QEMU is still special as it has the
>>> default unassigned MR trapping everything by default, meanwhile normally
>>> what is moving is MMIO / alias regions rather than real ramblocks.  It
>>> means when things go wrong we have much higher chance to trap them
>>> properly.
>>
>> When I said "memory management" I meant the methods we use to allocate and
>> free memory (the Linux equivalents would be kmalloc()/free()/kref), not the
>> MM tracking or unassigned MR trapping behavior you mentioned. The unassigned
>> MR trap and MMIO/alias movement are a separate concern and don’t change the
>> underlying risk.
>>
>> Concrete example: imagine an alias is allocated with g_new() and freed
>> immediately after object_unparent(). If that alias accidentally becomes the
>> FlatView root, destroying the FlatView later will call memory_region_unref()
>> and produce a use-after-free. We cannot predict what memory_region_unref()
>> will read or write in that scenario — the result can be arbitrary memory
>> corruption that surfaces much later as a hard-to-debug, intermittent
>> problem. Users often won’t file an issue for these rare corner cases.
> 
> OK I see what you meant now.  Yes it's a valid concern.
> 
>>
>>>
>>> I also confess though that I'm pretty conservative on fixing things with
>>> hypothetical issues.  In general, I prefer fixing things with explicit
>>> problems, so we know how to measure and justify a fix (depending on how
>>> aggressive the fix is and how much maintanence burden it will bring to
>>> QEMU).  Without a real problem, it's harder to quantify that even if such
>>> evaluation will also normally be subjective too.
>>
>> Regarding your preference to fix only explicit problems: I understand the
>> conservatism, but here are the facts we need to weigh:
>>
>> - The documentation claims we may free aliases because
>>    memory_region_ref() is never called, yet there is code that does call
>>    memory_region_ref().
>> - The patch adds code to align behavior with the documentation.
>>
>> The significance of both potential impacts (the behavioral divergence for
>> devices other than pci-bridge, and the added complexity needed for
>> consistency) may be subjective and hypothetical, but that applies equally to
>> both sides.
>>
>> In this case, the long-term reliability and maintainability of QEMU depend
>> on having the code behave as documented. Correctness should take precedence
>> over simplicity.
> 
> Fair enough.
> 
> Let's then still try to see whether we can brainstorm something that can
> still at least avoid the "let's clear a remote pointer in a finalize(),
> because it looks safe" approach.. I'm not sure if I'm the only one that
> feels nervous with it.
> 
> Fundamentally, if you can remotely clear a pointer, it means it's not used
> at all. In practise, that's correct because as I also discussed before I
> don't think RCU readers use flatview->root at all.  It was almost only
> because we have some very light references on flatview->root.  The major
> "hidden" reference is actually the key in flat_views hash, however I don't
> think it will have any stale root MR VA as key, as long as after a proper
> commit() completes.

"As long as after a proper commit() completes" is what we are trying to 
avoid. Think of the following sequence:

memory_region_transaction_begin()
object_unparent(mr)
g_free(mr)
mr = g_new0(MemoryRegion, 1) // reuse the storage for another MR
address_space_init(as, mr, "as")
memory_region_transaction_commit()

address_space_init() will use the value keyed with the dangling pointer 
in flat_views.

Removing a dangling reference is safer than leaving it. Some code that 
assumes the reference will not be gone may get surprised and cause a 
NULL dereference, but that almost always result in SIGSEGV instead of 
memory corruptions. Such segfault is as easy to debug as SIGABRT 
triggered by assertions.

> 
> In short, I want to discuss with you on whether we can completely remove
> the flatview->root reference, instead of resetting it in finalize().
> 
> Since that'll need to be justified, I prepared some sample patches myself.
> It survives all my smoke tests.  Once again, please treat them as comments
> only.  Would you think that's slightly better?  Attached at the end.
> 
> IMHO removing view->root makes sure nothing will surprise us in the future
> v.s. remote resets.
> 
> Thanks,
> 
> ===8<===
> 
>  From 4b495d935dfb145ed7ff57b3f6e4d6b9cb5ce038 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 7 Nov 2025 10:47:40 -0500
> Subject: [PATCH 1/3] memory: Remove flatview root reference in
>   mtree_print_dispatch()
> 
> This is so far only used to dump an extra "[ROOT]" tag when the termination
> MR is the root MR.  This is so far the only real necessary reference to
> flatview's root.  Remove it.  We lose this tag, but the hope is with the
> MR's name still being available it's still clear on what it represents.
> 
> This paves way for a complete removal of root MR reference on flatviews.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   system/memory-internal.h | 3 +--
>   system/memory.c          | 4 ++--
>   system/physmem.c         | 5 ++---
>   3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/system/memory-internal.h b/system/memory-internal.h
> index 46f758fa7e..c5841a603c 100644
> --- a/system/memory-internal.h
> +++ b/system/memory-internal.h
> @@ -35,8 +35,7 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
>   void address_space_dispatch_compact(AddressSpaceDispatch *d);
>   void address_space_dispatch_free(AddressSpaceDispatch *d);
>   
> -void mtree_print_dispatch(struct AddressSpaceDispatch *d,
> -                          MemoryRegion *root);
> +void mtree_print_dispatch(struct AddressSpaceDispatch *d);
>   
>   /* returns true if end is big endian. */
>   static inline bool devend_big_endian(enum device_endian end)
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae3..0d14e60d26 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3573,8 +3573,8 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>       }
>   
>   #if !defined(CONFIG_USER_ONLY)
> -    if (fvi->dispatch_tree && view->root) {
> -        mtree_print_dispatch(view->dispatch, view->root);
> +    if (fvi->dispatch_tree) {
> +        mtree_print_dispatch(view->dispatch);
>       }
>   #endif
>   
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..26ae6e3acd 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -4257,7 +4257,7 @@ static void mtree_print_phys_entries(int start, int end, int skip, int ptr)
>   #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                              int128_sub((size), int128_one())) : 0)
>   
> -void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
> +void mtree_print_dispatch(AddressSpaceDispatch *d)
>   {
>       int i;
>   
> @@ -4270,13 +4270,12 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
>                                   " [ROM]", " [watch]" };
>   
>           qemu_printf("      #%d @" HWADDR_FMT_plx ".." HWADDR_FMT_plx
> -                    " %s%s%s%s%s",
> +                    " %s%s%s%s",
>               i,
>               s->offset_within_address_space,
>               s->offset_within_address_space + MR_SIZE(s->size),
>               s->mr->name ? s->mr->name : "(noname)",
>               i < ARRAY_SIZE(names) ? names[i] : "",
> -            s->mr == root ? " [ROOT]" : "",
>               s == d->mru_section ? " [MRU]" : "",
>               s->mr->is_iommu ? " [iommu]" : "");
>   


