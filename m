Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34225C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 03:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXtxa-0008Rj-8s; Tue, 14 Jan 2025 22:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tXtxX-0008RT-NS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 22:20:47 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tXtxU-0006kV-G3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 22:20:47 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx7eKDKYdndqtjAA--.3042S3;
 Wed, 15 Jan 2025 11:20:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx78d9KYdnshEjAA--.5907S3;
 Wed, 15 Jan 2025 11:20:31 +0800 (CST)
Subject: Re: [PATCH v3] feat: add loongarch page table walker support for
 debugger memory access
To: Miao Hao <haomiao23s@ict.ac.cn>, gaosong@loongson.cn
Cc: qemu-devel@nongnu.org
References: <20250114095444.392579-1-haomiao23s@ict.ac.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <958deda6-d300-fe6c-d683-172f82c0fbc1@loongson.cn>
Date: Wed, 15 Jan 2025 11:20:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250114095444.392579-1-haomiao23s@ict.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx78d9KYdnshEjAA--.5907S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKw4rCw4kGr4xuF1xCr1ruFX_yoWxtr1Upr
 WxCFW3tF48KrWDAas3X34YvFn8ZrsxKw4a9a13KF9YkwsxXryfZFW0g3srJF48Jw4kWw4j
 gan8AF15Ca45XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.301,
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

Applied to loongarch-next with small modification with comments such as:

target/loongarch: Add page table walker support for debugger usage

When dump memory content with gva address, software page table walker is
necessary to get responding gpa address.

Here page table walker is added for debugger usage.

Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>


Regards
Bibo Mao


On 2025/1/14 下午5:54, Miao Hao wrote:
> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
> ---
>    v1 -> v2:
>      1. Addressed review comments.
>      2. Fix the assignment of variable shift.
>    v2 -> v3:
>      1. Remove variable shift.
> 
>   target/loongarch/cpu_helper.c     | 94 +++++++++++++++++++++++++++++--
>   target/loongarch/internals.h      |  4 +-
>   target/loongarch/tcg/tlb_helper.c |  4 +-
>   3 files changed, 94 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 580362ac3e..930466ca48 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -141,9 +141,85 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>       return false;
>   }
>   
> +static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
> +                                 int *prot, target_ulong address)
> +{
> +    CPUState *cs = env_cpu(env);
> +    target_ulong index, phys;
> +    uint64_t dir_base, dir_width;
> +    uint64_t base;
> +    int level;
> +
> +    if ((address >> 63) & 0x1) {
> +        base = env->CSR_PGDH;
> +    } else {
> +        base = env->CSR_PGDL;
> +    }
> +    base &= TARGET_PHYS_MASK;
> +
> +    for (level = 4; level > 0; level--) {
> +        get_dir_base_width(env, &dir_base, &dir_width, level);
> +
> +        if (dir_width == 0) {
> +            continue;
> +        }
> +
> +        /* get next level page directory */
> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
> +        phys = base | index << 3;
> +        base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
> +        if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +            /* base is a huge pte */
> +            break;
> +        }
> +    }
> +
> +    /* pte */
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        /* Huge Page. base is pte */
> +        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
> +        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
> +        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
> +            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
> +            base = FIELD_DP64(base, TLBENTRY, G, 1);
> +        }
> +    } else {
> +        /* Normal Page. base points to pte */
> +        get_dir_base_width(env, &dir_base, &dir_width, 0);
> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
> +        phys = base | index << 3;
> +        base = ldq_phys(cs->as, phys);
> +    }
> +
> +    /* TODO: check plv and other bits? */
> +
> +    /* base is pte, in normal pte format */
> +    if (!FIELD_EX64(base, TLBENTRY, V)) {
> +        return TLBRET_NOMATCH;
> +    }
> +
> +    if (!FIELD_EX64(base, TLBENTRY, D)) {
> +        *prot = PAGE_READ;
> +    } else {
> +        *prot = PAGE_READ | PAGE_WRITE;
> +    }
> +
> +    /* get TARGET_PAGE_SIZE aligned physical address */
> +    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
> +    /* mask RPLV, NX, NR bits */
> +    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
> +    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
> +    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
> +    /* mask other attribute bits */
> +    *physical = base & TARGET_PAGE_MASK;
> +
> +    return 0;
> +}
> +
>   static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>                                    int *prot, target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx)
> +                                 MMUAccessType access_type, int mmu_idx,
> +                                 int is_debug)
>   {
>       int index, match;
>   
> @@ -151,6 +227,13 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>       if (match) {
>           return loongarch_map_tlb_entry(env, physical, prot,
>                                          address, access_type, index, mmu_idx);
> +    } else if (is_debug) {
> +        /*
> +         * For debugger memory access, we want to do the map when there is a
> +         * legal mapping, even if the mapping is not yet in TLB. return 0 if
> +         * there is a valid map, else none zero.
> +         */
> +        return loongarch_page_table_walker(env, physical, prot, address);
>       }
>   
>       return TLBRET_NOMATCH;
> @@ -158,7 +241,8 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>   #else
>   static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>                                    int *prot, target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx)
> +                                 MMUAccessType access_type, int mmu_idx,
> +                                 int is_debug)
>   {
>       return TLBRET_NOMATCH;
>   }
> @@ -178,7 +262,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
>   
>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                            int *prot, target_ulong address,
> -                         MMUAccessType access_type, int mmu_idx)
> +                         MMUAccessType access_type, int mmu_idx, int is_debug)
>   {
>       int user_mode = mmu_idx == MMU_USER_IDX;
>       int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
> @@ -222,7 +306,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>   
>       /* Mapped address */
>       return loongarch_map_address(env, physical, prot, address,
> -                                 access_type, mmu_idx);
> +                                 access_type, mmu_idx, is_debug);
>   }
>   
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> @@ -232,7 +316,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       int prot;
>   
>       if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
> -                             cpu_mmu_index(cs, false)) != 0) {
> +                             cpu_mmu_index(cs, false), 1) != 0) {
>           return -1;
>       }
>       return phys_addr;
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 1a02427627..bc2ca30746 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -56,7 +56,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>                             int *index);
>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                            int *prot, target_ulong address,
> -                         MMUAccessType access_type, int mmu_idx);
> +                         MMUAccessType access_type, int mmu_idx, int is_debug);
> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +                               uint64_t *dir_width, target_ulong level);
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
>   #ifdef CONFIG_TCG
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 97f38fc391..564f336df9 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -18,7 +18,7 @@
>   #include "exec/log.h"
>   #include "cpu-csr.h"
>   
> -static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>                                  uint64_t *dir_width, target_ulong level)
>   {
>       switch (level) {
> @@ -485,7 +485,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>       /* Data access */
>       ret = get_physical_address(env, &physical, &prot, address,
> -                               access_type, mmu_idx);
> +                               access_type, mmu_idx, 0);
>   
>       if (ret == TLBRET_MATCH) {
>           tlb_set_page(cs, address & TARGET_PAGE_MASK,
> 


