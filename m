Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434B0CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 02:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqMYo-0007KV-EC; Sun, 24 Aug 2025 22:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uqMYl-0007KH-7m
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:03:47 -0400
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1uqMYh-0001Oh-S9
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:03:46 -0400
Received: from [192.168.7.202] ([71.202.166.45]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57P23Vah231963
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 19:03:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57P23Vah231963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2025082201; t=1756087412;
 bh=yPoOlBOVaAL1ZgD6bs35ivlUY+AvuVFvjlvbZTTdoPg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=ZJjDYrlTUQFTbIJcm4D6IzS9LLmfCJH0I9yDlfT9XhIAKHuAATxvn0/rj+6YuT7XV
 p1z03kcb+9cXSwoR+ZfRHvqWff+M58D2AI39/unuo8sWwc+ptm+9Iq+dXLa9AGNfqI
 sW/oYSF86hMq88oavpgHaIOZ6ELlaHI17/wcWuLOON2b64qN317+sBSqqf6Edy+8hv
 VjyGucfNYuo1oU2L7qRIxs4o2HPjilkhr6n/JkTiT0yrml79HopCUUWl3tMK6IZdzp
 P+qnLgbPj7nDuhc9tjImhyQT4WBjOTwoNgREcuBGaGpLnA7DRg0E2TzDOh6B/6DdHi
 vR+nR3y/zoIag==
Message-ID: <211ff764-e24f-4afb-81ff-fe0d9a78324e@zytor.com>
Date: Sun, 24 Aug 2025 19:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
 exception
To: qemu-devel@nongnu.org
References: <20250723182211.1299776-1-xin@zytor.com>
 <aKmTtaOlPewxllUZ@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <aKmTtaOlPewxllUZ@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:7c80:54:3::136; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/23/2025 3:11 AM, Zhao Liu wrote:
> On Wed, Jul 23, 2025 at 11:22:11AM -0700, Xin Li (Intel) wrote:
>> Date: Wed, 23 Jul 2025 11:22:11 -0700
>> From: "Xin Li (Intel)" <xin@zytor.com>
>> Subject: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
>>   exception
>> X-Mailer: git-send-email 2.50.1
>>
>> Save/restore the nested flag of an exception during VM save/restore
>> and live migration to ensure a correct event stack level is chosen
>> when a nested exception is injected through FRED event delivery.
>>
>> The event stack level used by FRED event delivery depends on whether
>> the event was a nested exception encountered during delivery of an
>> earlier event, because a nested exception is "regarded" as happening
>> on ring 0.  E.g., when #PF is configured to use stack level 1 in
>> IA32_FRED_STKLVLS MSR:
>>    - nested #PF will be delivered on the stack pointed by IA32_FRED_RSP1
>>      MSR when encountered in ring 3 and ring 0.
>>    - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP0
>>      MSR when encountered in ring 3.
>>    - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP1
>>      MSR when encountered in ring 0.
>>
>> As such Qemu needs to track if an event is a nested event during VM
>> context save/restore and live migration.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>   linux-headers/asm-x86/kvm.h |  4 +++-
>>   linux-headers/linux/kvm.h   |  1 +
>>   target/i386/cpu.c           |  1 +
>>   target/i386/cpu.h           |  1 +
>>   target/i386/kvm/kvm.c       | 35 +++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/kvm_i386.h  |  1 +
>>   target/i386/machine.c       |  1 +
>>   7 files changed, 43 insertions(+), 1 deletion(-)
> 
>> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
>> index 5f83e8850a..7e765b6833 100644
>> --- a/target/i386/kvm/kvm_i386.h
>> +++ b/target/i386/kvm/kvm_i386.h
>> @@ -54,6 +54,7 @@ typedef struct KvmCpuidInfo {
>>   bool kvm_is_vm_type_supported(int type);
>>   bool kvm_has_adjust_clock_stable(void);
>>   bool kvm_has_exception_payload(void);
>> +bool kvm_has_exception_nested_flag(void);
>>   void kvm_synchronize_all_tsc(void);
>>   
>>   void kvm_get_apic_state(DeviceState *d, struct kvm_lapic_state *kapic);
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index dd2dac1d44..a452d2c97e 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -458,6 +458,7 @@ static const VMStateDescription vmstate_exception_info = {
>>           VMSTATE_UINT8(env.exception_injected, X86CPU),
>>           VMSTATE_UINT8(env.exception_has_payload, X86CPU),
>>           VMSTATE_UINT64(env.exception_payload, X86CPU),
>> +        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
> 
> A new field needs to bump up the version of vmstate_exception_info, but
> I'm afraid this will break backward-migration compatibility. So what
> about adding a subsction? For example,
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index a452d2c97e4c..6ce3cb8af6a6 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -433,6 +433,24 @@ static bool steal_time_msr_needed(void *opaque)
>       return cpu->env.steal_time_msr != 0;
>   }
> 
> +static bool exception_nested_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +
> +    return cpu->env.exception_is_nested;
> +}
> +
> +static const VMStateDescription vmstate_exceprtion_nested = {
> +    .name = "cpu/exception_nested",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = exception_nested_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool exception_info_needed(void *opaque)
>   {
>       X86CPU *cpu = opaque;
> @@ -458,8 +476,11 @@ static const VMStateDescription vmstate_exception_info = {
>           VMSTATE_UINT8(env.exception_injected, X86CPU),
>           VMSTATE_UINT8(env.exception_has_payload, X86CPU),
>           VMSTATE_UINT64(env.exception_payload, X86CPU),
> -        VMSTATE_UINT8(env.exception_is_nested, X86CPU),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_exceprtion_nested,
> +        NULL,
>       }
>   };
> 
> ---

Yeah, looks the right way to go.


> In addition, I think it's better to update header files in a seperate
> patch.
> 

Is it a protocol that the Qemu community prefers?

Otherwise, the patch is self-contained, and not big, why break it?

Thanks!
     Xin

