Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BF6C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78X3-000270-Pp; Tue, 22 Apr 2025 03:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u78X1-00025B-2F
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:59:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u78Wx-0007CY-UW
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:59:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axz3M+TAdox+LDAA--.61413S3;
 Tue, 22 Apr 2025 15:58:54 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8U6TAdooaSPAA--.31579S3;
 Tue, 22 Apr 2025 15:58:52 +0800 (CST)
Subject: Re: [PATCH v3 6/9] target/loongarch: Define function
 loongarch_get_addr_from_tlb() non-static
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250422025742.2693096-1-maobibo@loongson.cn>
 <20250422025742.2693096-7-maobibo@loongson.cn>
 <e86b1efe-514c-4757-9a7d-477c27803c95@linaro.org>
 <b73e6439-2435-f064-2f07-24b10b9dd2a1@loongson.cn>
 <7cf5d9df-2b09-4ec6-88f5-abf219fa8a80@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <c82abd30-72db-ba38-30eb-4a44950393ff@loongson.cn>
Date: Tue, 22 Apr 2025 15:57:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7cf5d9df-2b09-4ec6-88f5-abf219fa8a80@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8U6TAdooaSPAA--.31579S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy7WFWfuFWfXF48Aw45twc_yoW7tr4Dpr
 y8AFyUJryUJr95Jr1jq345XFyDtr1UJw1UXr1UJFy8Cr4UJr1jqF18Xr1qgF18Jw48Jr1j
 qr1UJF1UuF1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU1wL05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.981,
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



On 2025/4/22 下午3:46, Philippe Mathieu-Daudé wrote:
> On 22/4/25 09:39, bibo mao wrote:
>>
>>
>> On 2025/4/22 下午3:18, Philippe Mathieu-Daudé wrote:
>>> On 22/4/25 04:57, Bibo Mao wrote:
>>>> Define function loongarch_get_addr_from_tlb() non-static, and add its
>>>> definition in header file tcg/tcg_loongarch.h
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>   target/loongarch/cpu_helper.c        | 10 ++--------
>>>>   target/loongarch/tcg/tcg_loongarch.h | 16 ++++++++++++++++
>>>>   2 files changed, 18 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/ 
>>>> cpu_helper.c
>>>> index 5db64a45cc..7636b2c265 100644
>>>> --- a/target/loongarch/cpu_helper.c
>>>> +++ b/target/loongarch/cpu_helper.c
>>>> @@ -11,6 +11,7 @@
>>>>   #include "cpu.h"
>>>>   #include "internals.h"
>>>>   #include "cpu-csr.h"
>>>> +#include "tcg/tcg_loongarch.h"
>>>>   #ifdef CONFIG_TCG
>>>>   static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr 
>>>> *physical,
>>>> @@ -142,7 +143,7 @@ bool loongarch_tlb_search(CPULoongArchState 
>>>> *env, target_ulong vaddr,
>>>>       return false;
>>>>   }
>>>> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, 
>>>> hwaddr *physical,
>>>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>>>> *physical,
>>>>                                          int *prot, target_ulong 
>>>> address,
>>>>                                          MMUAccessType access_type, 
>>>> int mmu_idx)
>>>>   {
>>>> @@ -156,13 +157,6 @@ static int 
>>>> loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
>>>>       return TLBRET_NOMATCH;
>>>>   }
>>>> -#else
>>>> -static int loongarch_get_addr_from_tlb(CPULoongArchState *env, 
>>>> hwaddr *physical,
>>>> -                                       int *prot, target_ulong 
>>>> address,
>>>> -                                       MMUAccessType access_type, 
>>>> int mmu_idx)
>>>> -{
>>>> -    return TLBRET_NOMATCH;
>>>> -}
>>>>   #endif
>>>>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>>> diff --git a/target/loongarch/tcg/tcg_loongarch.h 
>>>> b/target/loongarch/ tcg/tcg_loongarch.h
>>>> index da2539e995..69a93bfc3e 100644
>>>> --- a/target/loongarch/tcg/tcg_loongarch.h
>>>> +++ b/target/loongarch/tcg/tcg_loongarch.h
>>>> @@ -6,7 +6,23 @@
>>>>    */
>>>>   #ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
>>>>   #define TARGET_LOONGARCH_TCG_LOONGARCH_H
>>>> +#include "cpu.h"
>>>>   void loongarch_csr_translate_init(void);
>>>> +#ifdef CONFIG_TCG
>>>> +int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr 
>>>> *physical,
>>>> +                                int *prot, target_ulong address,
>>>> +                                MMUAccessType access_type, int 
>>>> mmu_idx);
>>>> +#else
>>>> +static inline int loongarch_get_addr_from_tlb(CPULoongArchState *env,
>>>> +                                              hwaddr *physical,
>>>> +                                              int *prot, 
>>>> target_ulong address,
>>>> +                                              MMUAccessType 
>>>> access_type,
>>>> +                                              int mmu_idx)
>>>> +{
>>>> +    return TLBRET_NOMATCH;
>>>
>>> CONFIG_TCG should always be defined when including tcg/tcg_loongarch.h.
>>
>> If so, there will be no stub function declaration with 
>> loongarch_get_addr_from_tlb(). *#ifdef CONFIG_TCG* needs be added in c 
>> files such as:
>>
>> static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                   int *prot, target_ulong address,
>>                                   MMUAccessType access_type, int mmu_idx,
>>                                   int is_debug)
>> {
>>      int ret;
>>
>> *#ifdef CONFIG_TCG*
>>      if (!kvm_enabled()) {
> 
> Maybe what we want here is:
> 
>        if (tcg_enabled()) {
yeap, it works with --enable-debug --disable-tcg option.

I had thought that loongarch_get_addr_from_tlb should be defined if this 
file is compiled with -O0 option. It is skipped even with -O0 option.
     if  (0) {
         ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
                                           access_type, mmu_idx);
     }

And thanks for your guidance.

Regards
Bibo Mao
> 
> ?
> 
>>          ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
>>                                            access_type, mmu_idx);
>>          if (ret != TLBRET_NOMATCH) {
>>              return ret;
>>          }
>>      }
>> *#endif*
>>
>> My original thought is to add stub function and remove *#ifdef 
>> CONFIG_TCG* in c file.
>>
>> Regards
>> Bibo Mao
>>
>>>
>>>> +}
>>>> +#endif
>>>> +
>>>>   #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
>>>
>>


