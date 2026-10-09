Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C73CA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEzB9-0007Zh-RE; Thu, 08 Oct 2026 21:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEzAg-0007Xb-CE; Thu, 08 Oct 2026 21:13:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEzAc-0005P0-7K; Thu, 08 Oct 2026 21:13:13 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6991Cq3v017528
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 9 Oct 2026 10:12:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yYC7U4/5sEJYEOyGZnIGJCKH78Xz8OYBId1N0tgRg0M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791508373; v=1;
 b=hxIm1w8AsUbvlbSDCNV4YN1dN/f4nR+LDnatkOvL1chJshzsAjlSf7HuJNnZnJl4
 T37z7Qpc7vArHBNTXCA/xXquz3sWngfs08cDsa70sdnlCnREVWx3u5bigwT0Z1MI
 oNcmwIH1oKabS/6j2xqlcf+LfU5KDH27HBv9leSw2CwHEETseASsXHFpELiCJTJq
 BnzWVc3dqEJGFyY5JhwD5UZxITtEmtMrpDK0GtqAplz0C9Mmj7BsU04wOCKDH5AU
 mA9MFxt4gW2KHWgfSEBLgXzNZfZZE3+ZdDb5UdZSW3Rw/qbnpoFnNexXmWPdsyeX
 rBYLlZJXdQPD78U6qcdukQ==
Message-ID: <4ea751ed-cc7b-46cd-b8a5-95e3345e25a6@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 9 Oct 2026 10:12:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
 <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
 <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
 <6f694401-3cc9-4c76-aa2d-3625773823c7@oss.qualcomm.com>
 <be98c53b-d01f-4beb-8915-cc73f22e839a@rsg.ci.i.u-tokyo.ac.jp>
 <8460c0a8-f68c-403f-bc6f-0477430c31de@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8460c0a8-f68c-403f-bc6f-0477430c31de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/10/09 8:38, Philippe Mathieu-Daudé wrote:
> On 8/10/26 07:52, Akihiko Odaki wrote:
>> On 2026/10/08 7:05, Philippe Mathieu-Daudé wrote:
>>> On 7/10/26 21:50, Philippe Mathieu-DaudÃ© wrote:
>>>> On 2026-10-07 16:50, Akihiko Odaki wrote:
>>>>> On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
>>>>>> From: Mark Burton <mburton@qti.qualcomm.com>
>>>>>>
>>>>>> Dirty-page logging handles a RAM write fault by marking the page 
>>>>>> dirty,
>>>>>> restoring write permission, and retrying the guest instruction.
>>>>>>
>>>>>> The handler also retried when the resolved RAM region had no 
>>>>>> dirty-log
>>>>>> client.  This path neither restores permission nor advances the 
>>>>>> PC, so
>>>>>> the instruction can repeatedly exit to QEMU.
>>>>>>
>>>>>> Retry only after marking the page dirty and restoring write 
>>>>>> permission.
>>>>>> Otherwise, use the existing emulation path to complete the access and
>>>>>> advance the guest PC.
>>>>>
>>>>> I can identify three cases of RAM write faults. The existing code
>>>>> handles all three, but this patch breaks the third:
>>>>>
>>>>> 1. The RAM is read-only. assert(!mr->readonly) trips in this case.
>>>>>
>>>>> 2. Dirty logging is enabled. The vCPU marks the page dirty, restores
>>>>>     write permission, and retries the write.
>>>>>
>>>>> 3. Dirty logging is enabled when the fault occurs, but another thread
>>>>>     disables it before the vCPU acquires the BQL. The vCPU then 
>>>>> observes
>>>>>     a zero dirty-log mask. The write still needs to be retried because
>>>>>     write permission has already been restored. The existing code does
>>>>>     this correctly, but this patch falls through to emulation instead.
>>>>>
>>>>> This patch is useful only if there is another case that the existing
>>>>> code does not handle correctly. Please describe that case and preserve
>>>>> the retry behavior in case 3.
>>>> Thanks for the deep review.
>>>>
>>>> The reporter said:
>>>>
>>>>    We reproduced is a level-2 translation fault, DFSC 0x06, on a
>>>>    dynamic DMI RAM leaf that has no corresponding HVF mapping.
>>>>    address_space_translate() resolves the leaf as RAM, but the 
>>>> dirty-log
>>>>    mask is zero, no page is marked or unprotected, and the 
>>>> unconditional
>>>>    retry makes no progress.
>>>>
>>>> That would be another case:
>>>>
>>>>    4. FlatView says RAM, but HVF has no mapping (nothing has changed
>>>>       to make retry succeed).
>>>>
>>>> So to prevent retrying a known translation miss that cannot make any
>>>> progress checking DFSC could be sufficient:
> 
> (also reproduced DFSC 0x07, but now irrelevant).
> 
>> Checking DFSC specifically for a translation fault feels arbitrary. 
>> The broader lesson from case 3 is that the faulting condition can be 
>> resolved concurrently before acquiring the BQL. That same race window 
>> applies to case 4. Instead of matching on DFSC, we should re-check 
>> whether the faulting condition persists after acquiring the BQL.
> 
> I don't have direct contact with the reporter, so guessed from the
> "dynamic DMI RAM" report which misguided me (no clue what is DMI btw).
> 
>>
>> Filtering out s1ptw also seems extraneous. If the page-table memory 
>> requires dirty logging, we should handle dirty-page tracking for it 
>> rather than skipping it with an additional guard.
> 
> Done (IIUC) as a separate patch.
> 
>>> However I had to do this change in hvf_set_phys_mem():
>>>
>>> -- >8 --
>>> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>>> index 8bd9154a50b..7b34a5f586d 100644
>>> --- a/accel/hvf/hvf-all.c
>>> +++ b/accel/hvf/hvf-all.c
>>> @@ -113,8 +113,14 @@ static void hvf_set_phys_mem(MemoryRegionSection 
>>> *section, bool add)
>>>
>>>       if (!QEMU_IS_ALIGNED(size, page_size) ||
>>>           !QEMU_IS_ALIGNED(gpa, page_size)) {
>>> -        /* Not page aligned, so we can not map as RAM */
>>> -        add = false;
>>> +        return;
>>>       }
> 
>>> hvf_vm_unmap paddr:0x0000000010001000 size:0x00001000
>>> qemu-system-aarch64: Error: ret = HV_BAD_ARGUMENT (0xfae94003, 
>>> at ../../ accel/hvf/hvf-all.c:123)
>>> Abort trap: 6
> 
>> The change to hvf_set_phys_mem() fixes error handling for misaligned
>> memory mappings and is worth submitting as a separate patch.
> 
> Yep, done.
> 
>> This also implies case 4 isn't fully understood yet. Ideally, whenever 
>> FlatView resolves a region as RAM, HVF should have a mapping for it. A 
>> host-page-misaligned region is one scenario where HVF cannot create a 
>> mapping, but that previously triggered an assert (HV_BAD_ARGUMENT), 
>> ruling it out as the reporter's original root cause.
>>
>> Please investigate why case 4 occurs and whether HVF can map the RAM
>> directly. If emulation is required, we should check for the specific
>> condition that requires it rather than treating a translation fault
>> alone as sufficient.
>>
>> Please investigate why case 4 occurs in practice and consider adding a 
>> missing mapping rather than relying on emulation. If emulation is 
>> genuinely required, we should check for that specific condition rather 
>> than assuming it for a translation fault.
> Per the report QEMU v10.2.0 works and v11.0.0 doesn't. From there it was
> easy to test up to the 6d0a5a44560..58bc47fd1c6 range. Testing commits
> d1f4ba9d94c and 7d7654a643f was painful due to the amount of changes but
> in the end bisection pointed at commit 58bc47fd1c6.

The bisection explains why the trapped RAM write stopped making
progress, but not why the RAM lacked an HVF mapping.

> 
> I followed your "Instead of matching on DFSC, we should re-check whether
> the faulting condition persists after acquiring the BQL" suggestion,
> since DFSC is only an indirect indication of a missing HVF mapping.
> 
> We are already with the BQL but now we assert it. Add added mapping
> tracking in hvf_set_phys_mem() using an IntervalTree so can check that
> back in the dabort handler before emulating. I am not checking vs
> FlatView because I don't understand yet if this is necessary. Also I
> need to implement the begin/commit MemoryListener handlers so the
> hvf_set_phys_mem() is protected, but I might leave that as TODO and
> post a v2. Testing is hard.

Before changing the fault handler, I think we still need to identify why 
hvf_set_phys_mem() did not install the mapping, or why it was 
subsequently removed. That should tell us whether the mapping needs 
fixing or whether there is a specific condition that requires emulation.

Regards,
Akihiko Odaki

