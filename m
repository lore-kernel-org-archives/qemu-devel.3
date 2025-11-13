Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C8CD4F37
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJMbh-0004Nt-PJ; Wed, 12 Nov 2025 20:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJMbe-0004Mo-UJ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:58:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJMbb-0000Yi-PF
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:58:38 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AD1wMMq035967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 10:58:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Pf6N2SC1fIDckYi8aa+eZzIMkr0XUyVspE0v3FtLl4o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762999102; v=1;
 b=RIKbgnEGdOaPMLG6R/BMmHmt7axZuI9R9UdFZbjuG8QogBgfasFexTjqzw1oJVY1
 yueXfADVKRnDgEU501BcqnVnAHcMPHr+hFvo7YYlsrUQOBsnarxvHZyGAAduUxDW
 dFzjq7HPvvSsbbJSQgR9ygkH+Qw+kIvB+VAAWb0AXLF8kBlut8Ed6MvJ7fioGFsO
 n1onHwP0CrklhoqG5ntjeMR3ZdbduGIt203pFBMsVjsA8DPpV6n3aAzzrUUo2tB4
 JVsI7zqYN/wW6dRgmaym0fxyAFN1YPi/Xgo/ryOI6ykeLLROeyHzhimy+Tc5isZH
 nBLD6RcOxzyvWMA/r2Ihxg==
Message-ID: <40b80ee3-6082-47cf-bbc6-a503cdc07587@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 13 Nov 2025 10:58:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Make FlatView root references weak
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
 <aQzf4F6RgkzYWkeM@x1.local>
 <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
 <aQ4g_UsDhTBYiQSZ@x1.local>
 <e7cb25c1-d43d-4729-8b43-6adcc343149b@rsg.ci.i.u-tokyo.ac.jp>
 <aRUMl0pOXwrMUsKT@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aRUMl0pOXwrMUsKT@x1.local>
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

On 2025/11/13 7:39, Peter Xu wrote:
> On Sat, Nov 08, 2025 at 11:07:46AM +0900, Akihiko Odaki wrote:
>> On 2025/11/08 1:40, Peter Xu wrote:
>>> On Fri, Nov 07, 2025 at 11:16:56AM +0900, Akihiko Odaki wrote:
>>>> On 2025/11/07 2:50, Peter Xu wrote:
>>>>> On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
>>>>>> Generally speaking, we will not necessarily "always" get an issue report
>>>>>> when things went wrong with memory management. A bug in memory management
>>>>>> may not cause an immediate crash but corrupt the memory state which you will
>>>>>> find only later. The end result of memory corruption may look random and
>>>>>> result in a hard-to-debug issue report. A user may not even bother writing
>>>>>> an issue report at all; this is especially true for this kind of corner
>>>>>> cases that rarely happen.
>>>>>>
>>>>>> There should have been no such a hazard of memory corruption if the code did
>>>>>> exactly what the documentation said in the first place. The consistency of
>>>>>> the code and the documentation is essential, especially for this kind of
>>>>>> complex and fundamental code.
>>>>>
>>>>> Do you have encountered such case before?
>>>>>
>>>>> I wasn't expecting that, because what you were saying looks more like what
>>>>> Linux kernel would have a bug in mm.  QEMU is still special as it has the
>>>>> default unassigned MR trapping everything by default, meanwhile normally
>>>>> what is moving is MMIO / alias regions rather than real ramblocks.  It
>>>>> means when things go wrong we have much higher chance to trap them
>>>>> properly.
>>>>
>>>> When I said "memory management" I meant the methods we use to allocate and
>>>> free memory (the Linux equivalents would be kmalloc()/free()/kref), not the
>>>> MM tracking or unassigned MR trapping behavior you mentioned. The unassigned
>>>> MR trap and MMIO/alias movement are a separate concern and don’t change the
>>>> underlying risk.
>>>>
>>>> Concrete example: imagine an alias is allocated with g_new() and freed
>>>> immediately after object_unparent(). If that alias accidentally becomes the
>>>> FlatView root, destroying the FlatView later will call memory_region_unref()
>>>> and produce a use-after-free. We cannot predict what memory_region_unref()
>>>> will read or write in that scenario — the result can be arbitrary memory
>>>> corruption that surfaces much later as a hard-to-debug, intermittent
>>>> problem. Users often won’t file an issue for these rare corner cases.
>>>
>>> OK I see what you meant now.  Yes it's a valid concern.
>>>
>>>>
>>>>>
>>>>> I also confess though that I'm pretty conservative on fixing things with
>>>>> hypothetical issues.  In general, I prefer fixing things with explicit
>>>>> problems, so we know how to measure and justify a fix (depending on how
>>>>> aggressive the fix is and how much maintanence burden it will bring to
>>>>> QEMU).  Without a real problem, it's harder to quantify that even if such
>>>>> evaluation will also normally be subjective too.
>>>>
>>>> Regarding your preference to fix only explicit problems: I understand the
>>>> conservatism, but here are the facts we need to weigh:
>>>>
>>>> - The documentation claims we may free aliases because
>>>>     memory_region_ref() is never called, yet there is code that does call
>>>>     memory_region_ref().
>>>> - The patch adds code to align behavior with the documentation.
>>>>
>>>> The significance of both potential impacts (the behavioral divergence for
>>>> devices other than pci-bridge, and the added complexity needed for
>>>> consistency) may be subjective and hypothetical, but that applies equally to
>>>> both sides.
>>>>
>>>> In this case, the long-term reliability and maintainability of QEMU depend
>>>> on having the code behave as documented. Correctness should take precedence
>>>> over simplicity.
>>>
>>> Fair enough.
>>>
>>> Let's then still try to see whether we can brainstorm something that can
>>> still at least avoid the "let's clear a remote pointer in a finalize(),
>>> because it looks safe" approach.. I'm not sure if I'm the only one that
>>> feels nervous with it.
>>>
>>> Fundamentally, if you can remotely clear a pointer, it means it's not used
>>> at all. In practise, that's correct because as I also discussed before I
>>> don't think RCU readers use flatview->root at all.  It was almost only
>>> because we have some very light references on flatview->root.  The major
>>> "hidden" reference is actually the key in flat_views hash, however I don't
>>> think it will have any stale root MR VA as key, as long as after a proper
>>> commit() completes.
>>
>> "As long as after a proper commit() completes" is what we are trying to
>> avoid. Think of the following sequence:
>>
>> memory_region_transaction_begin()
>> object_unparent(mr)
>> g_free(mr)
>> mr = g_new0(MemoryRegion, 1) // reuse the storage for another MR
>> address_space_init(as, mr, "as")
>> memory_region_transaction_commit()
>>
>> address_space_init() will use the value keyed with the dangling pointer in
>> flat_views.
> 
> I agree with your analysis, however I don't think such use case exists in
> practise..
> 
> I added below and qemu's qtests run all smooth:
> 
>   void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>   {
> +    assert(memory_region_transaction_depth == 0 &&
> +           memory_region_update_pending == false);
>       memory_region_ref(root);
>       as->root = root;
>       as->current_map = NULL;
> 
> We can either keep the assertion (until it'll trigger any time, but I doubt
> it..), or we can also solve this by other ways, I can think of two right
> now:

It is a convoluted way to express that flat_views may lose a valid 
reference of a memory region at some point. This patch explicitly states 
that.

> 
>    (1) Make sure address_space_init() skips the last two steps to update
>        topology and ioeventfds if memory_region_transaction_depth>0.
> 
>    (2) Introduce one more field for MemoryRegion, which is to allocate a
>        globally unique KEY for the flat_views hash, only needed if the MR
>        can be root candidates.
> 
> (2) will need more work, as we may need to have some way to make sure the
> allocator will not generate duplicate KEYs (hence u64 counter may not be
> ideal, as it may provide duplicates when wraps over u64.. even though I
> also don't know if people will hit it at all..).
> 
> So I wonder if we can just keep the solution (0) above, which is to assert
> it.
> 
>>
>> Removing a dangling reference is safer than leaving it. Some code that
>> assumes the reference will not be gone may get surprised and cause a NULL
>> dereference, but that almost always result in SIGSEGV instead of memory
>> corruptions. Such segfault is as easy to debug as SIGABRT triggered by
>> assertions.
> 
> Yes it'll be easier to debug indeed.  However IMHO this is still a bad plan
> to wait for it whenever overlooked.  It'll still be a disaster if a
> customer crashed on the NULL pointer reference somewhere, so IMHO we should
> avoid the first crash from design.
> 
> I confess I also added some assertions above.  However since we don't have
> a huge lot of object_unparent(mr) use cases, we can walk all of them and
> make sure the assertion will never happen.  IMHO it's still slightly better
> than remote pointer resets.

Pointer resetting doesn't even require walking all of object_unparent(), 
so in this sense pointer resetting is better.

Regards,
Akihiko Odaki

