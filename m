Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B11DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8nm-0004sZ-6j; Fri, 10 Jul 2026 06:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wi8nj-0004rM-Pm; Fri, 10 Jul 2026 06:49:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wi8ng-00007R-Bw; Fri, 10 Jul 2026 06:49:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66AAmrCG016368
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Jul 2026 19:48:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NhzxIKMUh+ygvJz4y8qpQ0iUTP1E+GWE8TMxC+ExSnY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1783680534; v=1;
 b=XIs+b6WoGUzEJp1lR82Rw9DSUiJoZlUYCnZVYNQTWy8ABVdZcbLpuAOFjtvaFFe/
 MZh2ogQ5Tr82PgrsUFfJ+/fVubZED2/oCjrjdCA7OHGpKTM1w/H9G7MHty2G0HLR
 ItjgTAoQi1dHcIHJZttZorTVgEL2JpPrP06kmNk9G1n7+HoCo5JhSOgpFJYkLm4k
 QXGkS8jsfOiVCKlKRKlYCcNcr5AHrrcTsL89lT3ZFlq2XvWlV/KSNqKj9UJyXdI+
 B3IP8m3777w66G8kgkBuqsM6C9b+9Fxy7qRwM9TIZMiB9yT/bKQSHUmphWkPclhY
 gJ1otF5fDZa6fQYzGHgx6Q==
Message-ID: <f1024475-b1e1-4c79-8ffa-74a59075b10c@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Jul 2026 19:48:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Collingbourne <pcc@google.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20251103101034.59039-1-philmd@linaro.org>
 <20251103101034.59039-2-philmd@linaro.org>
 <7ba7afe0-1e89-480e-92f1-6a1682b56baf@oss.qualcomm.com>
 <8d0539a6-65aa-47d1-8885-daa3fa20fbe6@rsg.ci.i.u-tokyo.ac.jp>
 <ef853a76-c96f-44e1-ba6e-474d87a75518@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ef853a76-c96f-44e1-ba6e-474d87a75518@oss.qualcomm.com>
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

On 2026/07/09 23:36, Philippe Mathieu-Daudé wrote:
> On 9/7/26 07:07, Akihiko Odaki wrote:
>> On 2026/07/09 7:13, Philippe Mathieu-Daudé wrote:
>>> On 3/11/25 11:10, Philippe Mathieu-Daudé wrote:
>>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   include/system/hvf_int.h |  3 +++
>>>>   accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
>>>>   accel/hvf/trace-events   |  1 +
>>>>   3 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>>>> index 3d2be4092ef..5a57691885f 100644
>>>> --- a/include/system/hvf_int.h
>>>> +++ b/include/system/hvf_int.h
>>>> @@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
>>>>   /* Must be called by the owning thread */
>>>>   void hvf_arch_update_guest_debug(CPUState *cpu);
>>>> +void hvf_protect_clean_range(hwaddr addr, size_t size);
>>>> +void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
>>>> +
>>>>   struct hvf_sw_breakpoint {
>>>>       vaddr pc;
>>>>       vaddr saved_insn;
>>>> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>>>> index 0a4b498e836..e13abddbd9c 100644
>>>> --- a/accel/hvf/hvf-all.c
>>>> +++ b/accel/hvf/hvf-all.c
>>>> @@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const 
>>>> char *file, unsigned int line,
>>>>       abort();
>>>>   }
>>>> +static void do_hv_vm_protect(hwaddr start, size_t size,
>>>> +                             hv_memory_flags_t flags)
>>>> +{
>>>> +    hv_return_t ret;
>>>> +
>>>> +    trace_hvf_vm_protect(start, size, flags,
>>>> +                         flags & HV_MEMORY_READ  ? 'R' : '-',
>>>> +                         flags & HV_MEMORY_WRITE ? 'W' : '-',
>>>> +                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
>>>> +
>>>> +    ret = hv_vm_protect(start, size, flags);
>>>> +    assert_hvf_ok(ret);
>>>
>>> Maybe this assertion is a bit aggressive toward users, since while
>>> we know the host limits, we don't know what the guest wants to do.
>>>
>>> I got:
>>>
>>> qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at ../../ 
>>> accel/ hvf/hvf-all.c:77)
>>>
>>> Running with '-trace hvf_vm_map':
>>>
>>> hvf_vm_map paddr:0x0000000010000000 size:0x00020000 vaddr:0x104514000 
>>> flags:0x07/RWX
>>> hvf_vm_map paddr:0x0000000000000000 size:0x00020000 vaddr:0x104890000 
>>> flags:0x07/RWX
>>> hvf_vm_map paddr:0x0000000400000000 size:0x80000000 vaddr:0x380000000 
>>> flags:0x07/RWX
>>> hvf_vm_map paddr:0x0000000030bc0000 size:0x00040000 vaddr:0x1048b4000 
>>> flags:0x07/RWX
>>> hvf_vm_map paddr:0x0000000050bc0000 size:0x00040000 vaddr:0x1048f8000 
>>> flags:0x07/RWX
>>> hvf_vm_protect paddr:0x0000000430000000 size:0x00004000 flags:0x05/R-X
>>> hvf_vm_protect paddr:0x0000000030000000 size:0x00004000 flags:0x05/R-X
>>> qemu-system-aarch64: Error: ret = HV_ERROR (0xfae94001, at ../../ 
>>> accel/ hvf/hvf-all.c:77)
>>>
>>> Should we propagate the error to upper layer?
>>>
>>> Are there cases we can safely ignore?
>> I don't think this should be propagated to the guest. In this case the 
>> failing hv_vm_protect() is for a GPA that was not mapped into HVF in 
>> the first place.
>>
>> The memory listener currently calls hvf_log_start() for every dirty- 
>> log section, but hvf_set_phys_mem() intentionally skips some sections, 
>> for example writable non-RAM regions where we want every access to 
>> trap. KVM handles the equivalent case by looking up the matching slot 
>> and returning if there is none.
>>
>> So I think we should only ignore/skip protect for ranges that we know 
>> do not have an HVF mapping. We should not ignore arbitrary 
>> hv_vm_protect() failures for mapped RAM, because then dirty logging 
>> can miss writes or keep faulting forever.
>>
>> A fix probably needs factoring the same mappable section test used by 
>> hvf_set_phys_mem() and using it in log_start, log_stop and log_clear.
> 
> Indeed, I am having a log_clear -> DIRTY_MEMORY_CODE call on a ROMD
> device. In commit d1f4ba9d94c ("accel/hvf: Simplify hvf_set_phys_mem")
> we removed this check:
> 
>       bool writable = !area->readonly && !area->rom_device;
>       ...
> -    if (area->readonly ||
> -        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
> -        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
> -    } else {
> -        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
> -    }
> +    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? 
> HV_MEMORY_WRITE : 0);

DIRTY_MEMORY_CODE is TCG-only, so it does not enable logging under HVF. 
physical_memory_test_and_clear_dirty() may still be called for that 
bitmap, but memory_region_clear_dirty_bitmap() calls log_clear() 
whenever any client is logging the region.

The other clients are DIRTY_MEMORY_VGA and DIRTY_MEMORY_MIGRATION. 
DIRTY_MEMORY_VGA is enabled per region by memory_region_set_log(), which 
is not used for ROMD regions. Under HVF, DIRTY_MEMORY_MIGRATION can be 
enabled by RAM migration or calc-dirty-rate in dirty-bitmap mode. If 
neither was active, the region was probably not in ROMD mode.

The change in commit d1f4ba9d94c ("accel/hvf: Simplify 
hvf_set_phys_mem") only simplified permissions for mapped sections; it 
did not remove hvf_set_phys_mem()'s mapping checks.

> 
> Maybe we should use back one of this helpers instead of accessing
> MemoryRegion internal fields?
> 
> 1473 static inline bool memory_region_is_romd(const MemoryRegion *mr)
> 1474 {
> 1475     return mr->rom_device && mr->romd_mode;
> 1476 }
> 
> 1716 static inline bool memory_region_is_rom(const MemoryRegion *mr)
> 1717 {
> 1718     return mr->ram && mr->readonly;
> 1719 }
> 
> 2697 static inline bool memory_access_is_direct(const MemoryRegion *mr,
> 2698                                            bool is_write, 
> MemTxAttrs attrs)
> 2699 {
> 2700     if (!memory_region_supports_direct_access(mr)) {
> 2701         return false;
> 2702     }
> 2703     /* Debug access can write to ROM. */
> 2704     if (is_write && !attrs.debug) {
> 2705         return !mr->readonly && !mr->rom_device;
> 2706     }
> 2707     return true;
> 2708 }
> 

For the dirty-log callbacks, none of these helpers alone captures the 
complete mapping condition, including alignment. I think we should 
factor the mappability check out of hvf_set_phys_mem() and reuse it in 
hvf_log_start(), hvf_log_stop(), and hvf_log_clear().

Regards,
Akihiko Odaki

