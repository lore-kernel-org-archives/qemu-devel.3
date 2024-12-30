Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35459E77194
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 07:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS9q6-0004cX-SD; Mon, 30 Dec 2024 02:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tS9q4-0004bk-8T
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:05:20 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tS9q0-0003FT-RL
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 02:05:19 -0500
Received: from [10.170.133.143] (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAX_zEWRnJnoiG+BA--.26416S2;
 Mon, 30 Dec 2024 15:04:58 +0800 (CST)
Message-ID: <b3f8f34b-4477-4396-a3a9-ef38209c87c3@ict.ac.cn>
Date: Mon, 30 Dec 2024 15:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] feat: add loongarch page table walker support for
 debugger memory access
To: bibo mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, "lixianglai@loongson.cn" <lixianglai@loongson.cn>, 
 gaosong@loongson.cn
References: <20241219032455.28608-1-haomiao23s@ict.ac.cn>
 <b041dacf-df2f-f25f-33c5-a53ad9cc2059@loongson.cn>
Content-Language: en-US
From: Miao Hao <haomiao23s@ict.ac.cn>
In-Reply-To: <b041dacf-df2f-f25f-33c5-a53ad9cc2059@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAX_zEWRnJnoiG+BA--.26416S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF18Zr15Ww4DKw1kKr48JFb_yoWfKF18pr
 1kJrWUJryUJrn5Jr1UJr1UJFyUAr1UJ3WDXr18XFyUAr47Xr1jqr1UXr1qgr1UJr48Jw1U
 Jr1UXr1UZr1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW8CwCF04k20xvY
 0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8CeH3UUUUU==
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: 5kdrzx1drsj2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.81; envelope-from=haomiao23s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bibo,

Thanks for your review. I apologize for my late respond due to some 
personal reasons.

On 2024/12/19 17:57, bibo mao wrote:
> Hi Miao,
>
> Thanks for doing this. It is useful to debug VM.
>
> On 2024/12/19 上午11:24, Miao Hao wrote:
>> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
>> ---
>>   target/loongarch/cpu_helper.c     | 104 ++++++++++++++++++++++++++++--
>>   target/loongarch/internals.h      |   4 +-
>>   target/loongarch/tcg/tlb_helper.c |   4 +-
>>   3 files changed, 104 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/loongarch/cpu_helper.c 
>> b/target/loongarch/cpu_helper.c
>> index 580362ac3e..c0828a813d 100644
>> --- a/target/loongarch/cpu_helper.c
>> +++ b/target/loongarch/cpu_helper.c
>> @@ -141,9 +141,95 @@ bool loongarch_tlb_search(CPULoongArchState 
>> *env, target_ulong vaddr,
>>       return false;
>>   }
>>   +static int loongarch_page_table_walker(CPULoongArchState *env, 
>> hwaddr *physical,
>> +                                 int *prot, target_ulong address)
>> +{
>> +    CPUState *cs = env_cpu(env);
>> +    target_ulong index, phys;
>> +    int shift;
>> +    uint64_t dir_base, dir_width;
>> +    uint64_t base;
>> +    int level;
>> +
>> +    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
>> +    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
>> +    shift = (shift + 1) * 3;

the assignment of variable shift and the corresponding comment is 
incorrect here, and details are logged in the v1.03 change log of 
LoongArch specification volume1 
(https://loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf)

     /* 0:64bit, 1:128bit, 2:256bit, 3:512bit */
     shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
     shift = shift + 3;

>> +
>> +    if ((address >> 63) & 0x1) {
>> +        base = env->CSR_PGDH;
>> +    } else {
>> +        base = env->CSR_PGDL;
>> +    }
>> +    base &= TARGET_PHYS_MASK;
>> +
>> +    for (level = 4; level > 0; level--) {
>> +        get_dir_base_width(env, &dir_base, &dir_width, level);
>> +
>> +        if (dir_width != 0) {
> how about check whether it equeal to 0 firstly like this?
>            if (dir_width == 0)
>                continue;
>
It's good to reduce code nesting, I will adopt this suggestion.
>> +            /* get next level page directory */
>> +            index = (address >> dir_base) & ((1 << dir_width) - 1);
>> +            phys = base | index << shift;
> Here will only load first 64bit if shift is not 0, such as 1:128bit, 
> 2:192bit, 3:256bit
>
After fixing the assignment of shift, this issue no longer exists. Shift 
is less than or equal to 6, and index is 6 bit. Thus, index << shift is 
at most 12 bit.

>> +            base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
>> +            if (!FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +                /* mask off page dir permission bits */
>> +                base &= TARGET_PAGE_MASK;
>> +            } else {
>> +                /* base is a huge pte */
>> +                break;
>> +            }
>> +
>> +            if (base == 0) {
> physical adddress 0 is valid and Valid bit will be checked in later. 
> Can we remove this?
the value of base equals to 0 means that the current page directory 
entry does not point to next level page directory, so we return here
>> +                return TLBRET_NOMATCH;
>> +            }
>
>> +        }
>> +    }
>> +
>> +    /* pte */
>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +        /* Huge Page. base is pte */
>> +        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>> +        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
>> +        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
>> +            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
>> +            base = FIELD_DP64(base, TLBENTRY, G, 1);
>> +        }
>> +    } else {
>> +        /* Normal Page. base points to pte */
>> +        get_dir_base_width(env, &dir_base, &dir_width, 0);
>> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
>> +        phys = base | index << shift;
> Ditto, shift may be wider than 64-bit.
>
> Regards
> Bibo Mao

Ditto, shift is less than or equal to 6.


Regards

Miao Hao

>> +        base = ldq_phys(cs->as, phys);
>> +    }
>> +
>> +    /* TODO: check plv and other bits? */
>> +
>> +    /* base is pte, in normal pte format */
>> +    if (!FIELD_EX64(base, TLBENTRY, V)) {
>> +        return TLBRET_NOMATCH;
>> +    }
>> +
>> +    if (!FIELD_EX64(base, TLBENTRY, D)) {
>> +        *prot = PAGE_READ;
>> +    } else {
>> +        *prot = PAGE_READ | PAGE_WRITE;
>> +    }
>> +
>> +    /* get TARGET_PAGE_SIZE aligned physical address */
>> +    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
>> +    /* mask RPLV, NX, NR bits */
>> +    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
>> +    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
>> +    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
>> +    /* mask other attribute bits */
>> +    *physical = base & TARGET_PAGE_MASK;
>> +
>> +    return 0;
>> +}
>> +
>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                    int *prot, target_ulong address,
>> -                                 MMUAccessType access_type, int 
>> mmu_idx)
>> +                                 MMUAccessType access_type, int 
>> mmu_idx,
>> +                                 int is_debug)
>>   {
>>       int index, match;
>>   @@ -151,6 +237,13 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>       if (match) {
>>           return loongarch_map_tlb_entry(env, physical, prot,
>>                                          address, access_type, index, 
>> mmu_idx);
>> +    } else if (is_debug) {
>> +        /*
>> +         * For debugger memory access, we want to do the map when 
>> there is a
>> +         * legal mapping, even if the mapping is not yet in TLB. 
>> return 0 if
>> +         * there is a valid map, else none zero.
>> +         */
>> +        return loongarch_page_table_walker(env, physical, prot, 
>> address);
>>       }
>>         return TLBRET_NOMATCH;
>> @@ -158,7 +251,8 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>   #else
>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                    int *prot, target_ulong address,
>> -                                 MMUAccessType access_type, int 
>> mmu_idx)
>> +                                 MMUAccessType access_type, int 
>> mmu_idx,
>> +                                 int is_debug)
>>   {
>>       return TLBRET_NOMATCH;
>>   }
>> @@ -178,7 +272,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, 
>> target_ulong va,
>>     int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>                            int *prot, target_ulong address,
>> -                         MMUAccessType access_type, int mmu_idx)
>> +                         MMUAccessType access_type, int mmu_idx, int 
>> is_debug)
>>   {
>>       int user_mode = mmu_idx == MMU_USER_IDX;
>>       int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
>> @@ -222,7 +316,7 @@ int get_physical_address(CPULoongArchState *env, 
>> hwaddr *physical,
>>         /* Mapped address */
>>       return loongarch_map_address(env, physical, prot, address,
>> -                                 access_type, mmu_idx);
>> +                                 access_type, mmu_idx, is_debug);
>>   }
>>     hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>> @@ -232,7 +326,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState 
>> *cs, vaddr addr)
>>       int prot;
>>         if (get_physical_address(env, &phys_addr, &prot, addr, 
>> MMU_DATA_LOAD,
>> -                             cpu_mmu_index(cs, false)) != 0) {
>> +                             cpu_mmu_index(cs, false), 1) != 0) {
>>           return -1;
>>       }
>>       return phys_addr;


