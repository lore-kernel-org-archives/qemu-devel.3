Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4CAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 01:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQuq-0000dB-Sv; Mon, 30 Dec 2024 20:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tSQuo-0000cv-MU
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:19:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tSQui-0008QA-MI
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:19:22 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxPuONRnNn1hVcAA--.48950S3;
 Tue, 31 Dec 2024 09:19:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxfcWMRnNnqLAOAA--.7324S3;
 Tue, 31 Dec 2024 09:19:08 +0800 (CST)
Subject: Re: [PATCH] feat: add loongarch page table walker support for
 debugger memory access
From: bibo mao <maobibo@loongson.cn>
To: Miao Hao <haomiao23s@ict.ac.cn>
Cc: qemu-devel@nongnu.org, "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 gaosong@loongson.cn
References: <20241219032455.28608-1-haomiao23s@ict.ac.cn>
 <b041dacf-df2f-f25f-33c5-a53ad9cc2059@loongson.cn>
 <b3f8f34b-4477-4396-a3a9-ef38209c87c3@ict.ac.cn>
 <d318dcd2-652d-9af1-2119-79d557d8284b@loongson.cn>
Message-ID: <cfca281e-371e-af35-a909-a03b91a48c0f@loongson.cn>
Date: Tue, 31 Dec 2024 09:18:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d318dcd2-652d-9af1-2119-79d557d8284b@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcWMRnNnqLAOAA--.7324S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJr4xCF1Uuw4kZw1rJFWDGFX_yoWkJr43pr
 1kJFWUJry5Jrn5Jr1jgw1UJFyqyr1UJw1DXr18XFyUAr47Xr12gr1UXr1qgr18Jr48Jw1U
 Xr1UJr17Zr15JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU1QVy3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.668,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2024/12/31 上午9:09, bibo mao wrote:
> 
> 
> On 2024/12/30 下午3:04, Miao Hao wrote:
>> Hi Bibo,
>>
>> Thanks for your review. I apologize for my late respond due to some 
>> personal reasons.
>>
>> On 2024/12/19 17:57, bibo mao wrote:
>>> Hi Miao,
>>>
>>> Thanks for doing this. It is useful to debug VM.
>>>
>>> On 2024/12/19 上午11:24, Miao Hao wrote:
>>>> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
>>>> ---
>>>>   target/loongarch/cpu_helper.c     | 104 
>>>> ++++++++++++++++++++++++++++--
>>>>   target/loongarch/internals.h      |   4 +-
>>>>   target/loongarch/tcg/tlb_helper.c |   4 +-
>>>>   3 files changed, 104 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/target/loongarch/cpu_helper.c 
>>>> b/target/loongarch/cpu_helper.c
>>>> index 580362ac3e..c0828a813d 100644
>>>> --- a/target/loongarch/cpu_helper.c
>>>> +++ b/target/loongarch/cpu_helper.c
>>>> @@ -141,9 +141,95 @@ bool loongarch_tlb_search(CPULoongArchState 
>>>> *env, target_ulong vaddr,
>>>>       return false;
>>>>   }
>>>>   +static int loongarch_page_table_walker(CPULoongArchState *env, 
>>>> hwaddr *physical,
>>>> +                                 int *prot, target_ulong address)
>>>> +{
>>>> +    CPUState *cs = env_cpu(env);
>>>> +    target_ulong index, phys;
>>>> +    int shift;
>>>> +    uint64_t dir_base, dir_width;
>>>> +    uint64_t base;
>>>> +    int level;
>>>> +
>>>> +    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
>>>> +    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>>>> +    shift = (shift + 1) * 3;
>>
>> the assignment of variable shift and the corresponding comment is 
>> incorrect here, and details are logged in the v1.03 change log of 
>> LoongArch specification volume1 
>> (https://loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf) 
>>
>>
>>      /* 0:64bit, 1:128bit, 2:256bit, 3:512bit */
>>      shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>>      shift = shift + 3;
> Ok, I see.
> It seems that this is right, thanks for the detailed explanation.
> 
>>
>>>> +
>>>> +    if ((address >> 63) & 0x1) {
>>>> +        base = env->CSR_PGDH;
>>>> +    } else {
>>>> +        base = env->CSR_PGDL;
>>>> +    }
>>>> +    base &= TARGET_PHYS_MASK;
>>>> +
>>>> +    for (level = 4; level > 0; level--) {
>>>> +        get_dir_base_width(env, &dir_base, &dir_width, level);
>>>> +
>>>> +        if (dir_width != 0) {
>>> how about check whether it equeal to 0 firstly like this?
>>>            if (dir_width == 0)
>>>                continue;
>>>
>> It's good to reduce code nesting, I will adopt this suggestion.
>>>> +            /* get next level page directory */
>>>> +            index = (address >> dir_base) & ((1 << dir_width) - 1);
>>>> +            phys = base | index << shift;
>>> Here will only load first 64bit if shift is not 0, such as 1:128bit, 
>>> 2:192bit, 3:256bit
>>>
>> After fixing the assignment of shift, this issue no longer exists. 
>> Shift is less than or equal to 6, and index is 6 bit. Thus, index << 
>> shift is at most 12 bit.
> Supposing one pte entry is 128bit, value of shift is 4.
>     phys = base | index << shift;  will be the same as
>     phys = base | index * 16;
> however all accessed pte entry is 16 bytes aligned, pte entry with "phys 
> = base | index * 16 + 8" will never be accessed. Is that right?
> 
> I think it should be something like this.
>        index = (address >> dir_base) & ((1 << (dir_width + shift) - 1);
>        phys = base | index << 3;
Sorry, it should be shift - 3.
  index = (address >> dir_base) & (1 << (dir_width + shift - 3) - 1);
  phys = base | index << 3;

> 
> Regards
> Bibo, Mao
>>
>>>> +            base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
>>>> +            if (!FIELD_EX64(base, TLBENTRY, HUGE)) {
>>>> +                /* mask off page dir permission bits */
>>>> +                base &= TARGET_PAGE_MASK;
>>>> +            } else {
>>>> +                /* base is a huge pte */
>>>> +                break;
>>>> +            }
>>>> +
>>>> +            if (base == 0) {
>>> physical adddress 0 is valid and Valid bit will be checked in later. 
>>> Can we remove this?
>> the value of base equals to 0 means that the current page directory 
>> entry does not point to next level page directory, so we return here
>>>> +                return TLBRET_NOMATCH;
>>>> +            }
>>>
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /* pte */
>>>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>>>> +        /* Huge Page. base is pte */
>>>> +        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>>>> +        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
>>>> +        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
>>>> +            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
>>>> +            base = FIELD_DP64(base, TLBENTRY, G, 1);
>>>> +        }
>>>> +    } else {
>>>> +        /* Normal Page. base points to pte */
>>>> +        get_dir_base_width(env, &dir_base, &dir_width, 0);
>>>> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
>>>> +        phys = base | index << shift;
>>> Ditto, shift may be wider than 64-bit.
>>>
>>> Regards
>>> Bibo Mao
>>
>> Ditto, shift is less than or equal to 6.
>>
>>
>> Regards
>>
>> Miao Hao
>>
>>>> +        base = ldq_phys(cs->as, phys);
>>>> +    }
>>>> +
>>>> +    /* TODO: check plv and other bits? */
>>>> +
>>>> +    /* base is pte, in normal pte format */
>>>> +    if (!FIELD_EX64(base, TLBENTRY, V)) {
>>>> +        return TLBRET_NOMATCH;
>>>> +    }
>>>> +
>>>> +    if (!FIELD_EX64(base, TLBENTRY, D)) {
>>>> +        *prot = PAGE_READ;
>>>> +    } else {
>>>> +        *prot = PAGE_READ | PAGE_WRITE;
>>>> +    }
>>>> +
>>>> +    /* get TARGET_PAGE_SIZE aligned physical address */
>>>> +    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
>>>> +    /* mask RPLV, NX, NR bits */
>>>> +    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
>>>> +    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
>>>> +    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
>>>> +    /* mask other attribute bits */
>>>> +    *physical = base & TARGET_PAGE_MASK;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>>>> *physical,
>>>>                                    int *prot, target_ulong address,
>>>> -                                 MMUAccessType access_type, int 
>>>> mmu_idx)
>>>> +                                 MMUAccessType access_type, int 
>>>> mmu_idx,
>>>> +                                 int is_debug)
>>>>   {
>>>>       int index, match;
>>>>   @@ -151,6 +237,13 @@ static int 
>>>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>>>       if (match) {
>>>>           return loongarch_map_tlb_entry(env, physical, prot,
>>>>                                          address, access_type, 
>>>> index, mmu_idx);
>>>> +    } else if (is_debug) {
>>>> +        /*
>>>> +         * For debugger memory access, we want to do the map when 
>>>> there is a
>>>> +         * legal mapping, even if the mapping is not yet in TLB. 
>>>> return 0 if
>>>> +         * there is a valid map, else none zero.
>>>> +         */
>>>> +        return loongarch_page_table_walker(env, physical, prot, 
>>>> address);
>>>>       }
>>>>         return TLBRET_NOMATCH;
>>>> @@ -158,7 +251,8 @@ static int 
>>>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>>>   #else
>>>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>>>> *physical,
>>>>                                    int *prot, target_ulong address,
>>>> -                                 MMUAccessType access_type, int 
>>>> mmu_idx)
>>>> +                                 MMUAccessType access_type, int 
>>>> mmu_idx,
>>>> +                                 int is_debug)
>>>>   {
>>>>       return TLBRET_NOMATCH;
>>>>   }
>>>> @@ -178,7 +272,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, 
>>>> target_ulong va,
>>>>     int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>>>                            int *prot, target_ulong address,
>>>> -                         MMUAccessType access_type, int mmu_idx)
>>>> +                         MMUAccessType access_type, int mmu_idx, 
>>>> int is_debug)
>>>>   {
>>>>       int user_mode = mmu_idx == MMU_USER_IDX;
>>>>       int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
>>>> @@ -222,7 +316,7 @@ int get_physical_address(CPULoongArchState *env, 
>>>> hwaddr *physical,
>>>>         /* Mapped address */
>>>>       return loongarch_map_address(env, physical, prot, address,
>>>> -                                 access_type, mmu_idx);
>>>> +                                 access_type, mmu_idx, is_debug);
>>>>   }
>>>>     hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>>> @@ -232,7 +326,7 @@ hwaddr 
>>>> loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>>>       int prot;
>>>>         if (get_physical_address(env, &phys_addr, &prot, addr, 
>>>> MMU_DATA_LOAD,
>>>> -                             cpu_mmu_index(cs, false)) != 0) {
>>>> +                             cpu_mmu_index(cs, false), 1) != 0) {
>>>>           return -1;
>>>>       }
>>>>       return phys_addr;


