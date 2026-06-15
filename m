Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7BCCD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ1Ob-0006f2-CW; Mon, 15 Jun 2026 03:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wZ1OR-0006dz-Sw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:05:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wZ1OK-0007g4-Jl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:05:58 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxt3hBpC9qpDwUAA--.28396S3;
 Mon, 15 Jun 2026 15:05:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx_8I7pC9qWt6mAA--.54014S3;
 Mon, 15 Jun 2026 15:05:31 +0800 (CST)
Subject: Re: [PATCH 4/4] target/loongarch: virtualize guest TLB and address
 translation
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1779171125.git.prcups@krgm.moe>
 <1483c382ada81ec19e0bd29bf8817afda75af9bf.1779171126.git.prcups@krgm.moe>
 <bc615ae4-a341-57e0-6c93-ecd435b53395@loongson.cn>
 <RLg9LkP-QVeHDXdSdPkguw@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <99180a62-6703-93d1-0824-4951f8726f3d@loongson.cn>
Date: Mon, 15 Jun 2026 15:02:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <RLg9LkP-QVeHDXdSdPkguw@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8I7pC9qWt6mAA--.54014S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWDXFy8Gw43ury8Wr1kWF47Jrc_yoWxCr15Ko
 WrGF4fJw17Gr1YqFyDu3sIqay7JrykAw4kCFZ2vw43Wayrt34jkrWrJ395Aa17GF1kWF48
 G3W7J3WFvFW3Zr13l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
 17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 2DUUUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi SignKirigami,

The patch is merged which merges CSR registers into structure 
CPUSysState. I think that you can rebase your patches on it.

Regards
Bibo Mao

On 2026/5/26 下午12:58, SignKirigami wrote:
> 在 2026年5月22日星期五 中国标准时间 10:43:10，Bibo Mao 写道：
>>
>> On 2026/5/19 下午2:30, SignKirigami wrote:
>>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
>>> ---
>>>    target/loongarch/cpu-mmu.h                    |  37 +-
>>>    target/loongarch/cpu_helper.c                 | 119 ++--
>>>    target/loongarch/disas.c                      |   6 +
>>>    target/loongarch/insns.decode                 |   6 +
>>>    target/loongarch/tcg/helper.h                 |  17 +-
>>>    .../tcg/insn_trans/trans_privileged.c.inc     | 128 +++-
>>>    target/loongarch/tcg/tcg_loongarch.h          |   6 +-
>>>    target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
>>>    8 files changed, 694 insertions(+), 254 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
>>> index 2d7ebb2d72..31093641ff 100644
>>> --- a/target/loongarch/cpu-mmu.h
>>> +++ b/target/loongarch/cpu-mmu.h
>>> @@ -17,6 +17,14 @@ typedef enum TLBRet {
>>>        TLBRET_RI,
>>>        TLBRET_XI,
>>>        TLBRET_PE,
>>> +    TLBRET_HOST_MATCH,
>>> +    TLBRET_HOST_BADADDR,
>>> +    TLBRET_HOST_NOMATCH,
>>> +    TLBRET_HOST_INVALID,
>>> +    TLBRET_HOST_DIRTY,
>>> +    TLBRET_HOST_RI,
>>> +    TLBRET_HOST_XI,
>>> +    TLBRET_HOST_PE,
>>>    } TLBRet;
>>>    
>>>    typedef struct MMUContext {
>>> @@ -30,16 +38,17 @@ typedef struct MMUContext {
>>>        uint64_t      pte_buddy[2];
>>>    } MMUContext;
>>>    
>>> -static inline bool cpu_has_ptw(CPULoongArchState *env)
>>> +static inline bool cpu_has_ptw(CPULoongArchState *env, bool guest)
>>>    {
>>> -    return !!FIELD_EX64(env->CSR_PWCH, CSR_PWCH, HPTW_EN);
>>> +    return !!FIELD_EX64(GET_CSR_IF(guest, PWCH), CSR_PWCH, HPTW_EN);
>>>    }
>>>    
>>> -static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
>>> +static inline bool pte_present(CPULoongArchState *env, uint64_t entry,
>>> +                               bool guest)
>>>    {
>>>        uint8_t present;
>>>    
>>> -    if (cpu_has_ptw(env)) {
>>> +    if (cpu_has_ptw(env, guest)) {
>>>            present = FIELD_EX64(entry, TLBENTRY, P);
>>>        } else {
>>>            present = FIELD_EX64(entry, TLBENTRY, V);
>>> @@ -48,11 +57,11 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
>>>        return !!present;
>>>    }
>>>    
>>> -static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
>>> +static inline bool pte_write(CPULoongArchState *env, uint64_t entry, bool guest)
>>>    {
>>>        uint8_t writable;
>>>    
>>> -    if (cpu_has_ptw(env)) {
>>> +    if (cpu_has_ptw(env, guest)) {
>>>            writable = FIELD_EX64(entry, TLBENTRY, W);
>>>        } else {
>>>            writable = FIELD_EX64(entry, TLBENTRY, D);
>>> @@ -89,14 +98,22 @@ static inline bool pte_dirty(uint64_t entry)
>>>    
>>>    bool check_ps(CPULoongArchState *ent, uint8_t ps);
>>>    TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>>> -                           MMUAccessType access_type, int mmu_idx);
>>> +                           MMUAccessType access_type, int mmu_idx, bool guest);
>>>    TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>>>                                MMUAccessType access_type, int mmu_idx,
>>> -                            int is_debug);
>>> +                            int is_debug, uintptr_t retaddr);
>>>    TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>>> -                     int access_type, int mmu_idx, int debug);
>>> +                     int access_type, int mmu_idx, int debug, bool guest,
>>> +                     uintptr_t retaddr);
>>> +hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
>>> +                                  uintptr_t retaddr);
>>> +TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
>>> +                                  MMUAccessType access_type, uintptr_t retaddr);
>>> +TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
>>> +                             MMUAccessType access_type, int mmu_idx,
>>> +                             int is_debug, bool guest, uintptr_t retaddr);
>>>    void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>> -                        uint64_t *dir_width, unsigned int level);
>>> +                        uint64_t *dir_width, unsigned int level, bool guest);
>>>    hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>>>    uint64_t loongarch_palen_mask(CPULoongArchState *env);
>>>    
>>> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
>>> index eb9684a4a1..bad6062ac9 100644
>>> --- a/target/loongarch/cpu_helper.c
>>> +++ b/target/loongarch/cpu_helper.c
>>> @@ -17,46 +17,56 @@
>>>    #include "cpu-mmu.h"
>>>    #include "tcg/tcg_loongarch.h"
>>>    
>>> -void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>> -                        uint64_t *dir_width, unsigned int level)
>>> +static void get_dir_base_width_csr(CPULoongArchState *env, uint64_t *dir_base,
>>> +                                   uint64_t *dir_width, unsigned int level,
>>> +                                   bool guest)
>>>    {
>>> +    uint64_t pwcl = GET_CSR_IF(guest, PWCL);
>>> +    uint64_t pwch = GET_CSR_IF(guest, PWCH);
>>> +
>>>        switch (level) {
>>>        case 1:
>>> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
>>> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
>>> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, DIR1_BASE);
>>> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, DIR1_WIDTH);
>>>            break;
>>>        case 2:
>>> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
>>> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
>>> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, DIR2_BASE);
>>> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, DIR2_WIDTH);
>>>            break;
>>>        case 3:
>>> -        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
>>> -        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
>>> +        *dir_base = FIELD_EX64(pwch, CSR_PWCH, DIR3_BASE);
>>> +        *dir_width = FIELD_EX64(pwch, CSR_PWCH, DIR3_WIDTH);
>>>            break;
>>>        case 4:
>>> -        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
>>> -        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
>>> +        *dir_base = FIELD_EX64(pwch, CSR_PWCH, DIR4_BASE);
>>> +        *dir_width = FIELD_EX64(pwch, CSR_PWCH, DIR4_WIDTH);
>>>            break;
>>>        default:
>>>            /* level may be zero for ldpte */
>>> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>>> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
>>> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, PTBASE);
>>> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, PTWIDTH);
>>>            break;
>>>        }
>>>    }
>>>    
>>> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>> +                        uint64_t *dir_width, unsigned int level, bool guest)
>>> +{
>>> +    get_dir_base_width_csr(env, dir_base, dir_width, level, guest);
>>> +}
>>> +
>>>    TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>>> -                           MMUAccessType access_type, int mmu_idx)
>>> +                           MMUAccessType access_type, int mmu_idx, bool guest)
>>>    {
>>> -    uint64_t plv = mmu_idx;
>>> +    uint64_t plv = mmu_idx_to_plv(mmu_idx);
>>>        uint64_t tlb_entry, tlb_ppn;
>>>        uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
>>>        bool tlb_v, tlb_d;
>>>    
>>>        tlb_entry = context->pte;
>>>        tlb_ps = context->ps;
>>> -    tlb_v = pte_present(env, tlb_entry);
>>> -    tlb_d = pte_write(env, tlb_entry);
>>> +    tlb_v = pte_present(env, tlb_entry, guest);
>>> +    tlb_d = pte_write(env, tlb_entry, guest);
>>>        tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
>>>        if (is_la64(env)) {
>>>            tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
>>> @@ -98,7 +108,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>>>        context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
>>>                            (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
>>>        context->prot = PAGE_READ;
>>> -    context->mmu_index = tlb_plv;
>>> +    context->mmu_index = mmu_idx;
>>>        if (tlb_d) {
>>>            context->prot |= PAGE_WRITE;
>>>        }
>>> @@ -144,7 +154,8 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
>>>    }
>>>    
>>>    TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>>> -                     int access_type, int mmu_idx, int debug)
>>> +                     int access_type, int mmu_idx, int debug, bool guest,
>>> +                     uintptr_t retaddr)
>>>    {
>>>        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>>>        CPUState *cs = env_cpu(env);
>>> @@ -160,14 +171,14 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>>>    
>>>        address = context->addr;
>>>        if ((address >> 63) & 0x1) {
>>> -        base = env->CSR_PGDH;
>>> +        base = GET_CSR_IF(guest, PGDH);
>>>        } else {
>>> -        base = env->CSR_PGDL;
>>> +        base = GET_CSR_IF(guest, PGDL);
>>>        }
>>>        base &= palen_mask;
>>>    
>>>        for (level = 4; level >= 0; level--) {
>>> -        get_dir_base_width(env, &dir_base, &dir_width, level);
>>> +        get_dir_base_width(env, &dir_base, &dir_width, level, guest);
>>>    
>>>            if (dir_width == 0) {
>>>                continue;
>>> @@ -176,7 +187,10 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>>>            /* get next level page directory */
>>>            index = (address >> dir_base) & ((1 << dir_width) - 1);
>>>            phys = base | index << 3;
>>> -        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
>>> +        base = address_space_ldq_le(
>>> +            cs->as,
>>> +            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
>>> +            attrs, NULL);
>>>            if (level) {
>>>                if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>>>                    /* base is a huge pte */
>>> @@ -205,19 +219,22 @@ restart:
>>>            context->pte_buddy[index] = base;
>>>            context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
>>>            base += (BIT_ULL(dir_base) & address);
>>> -    } else if (cpu_has_ptw(env)) {
>>> +    } else if (cpu_has_ptw(env, guest)) {
>>>            uint64_t val;
>>>    
>>>            index &= 1;
>>>            context->pte_buddy[index] = base;
>>> -        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
>>> -                                   attrs, NULL);
>>> +        val = address_space_ldq_le(
>>> +            cs->as,
>>> +            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys) +
>>> +                8 * (1 - 2 * index),
>>> +            attrs, NULL);
>>>            context->pte_buddy[1 - index] = val;
>>>        }
>>>    
>>>        context->ps = dir_base;
>>>        context->pte = base;
>>> -    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
>>> +    ret = loongarch_check_pte(env, context, access_type, mmu_idx, guest);
>>>        if (debug) {
>>>            return ret;
>>>        }
>>> @@ -228,7 +245,7 @@ restart:
>>>         * Need atomic compchxg operation with pte update, other vCPUs may
>>>         * update pte at the same time.
>>>         */
>>> -    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
>>> +    if (ret == TLBRET_MATCH && cpu_has_ptw(env, guest)) {
>>>            if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
>>>                return ret;
>>>            }
>>> @@ -241,10 +258,15 @@ restart:
>>>            if (access_type == MMU_DATA_STORE) {
>>>                base = pte_mkdirty(base);
>>>            }
>>> -        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
>>> +        ret1 = loongarch_cmpxchg_phys(
>>> +            cs, (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
>>> +            pte, base);
>>>            /* PTE updated by other CPU, reload PTE entry */
>>>            if (ret1 == MEMTX_DECODE_ERROR) {
>>> -            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
>>> +            base = address_space_ldq_le(
>>> +                cs->as,
>>> +                (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
>>> +                attrs, NULL);
>>>                goto restart;
>>>            }
>>>    
>>> @@ -270,15 +292,15 @@ restart:
>>>        return ret;
>>>    }
>>>    
>>> -static TLBRet loongarch_map_address(CPULoongArchState *env,
>>> -                                    MMUContext *context,
>>> -                                    MMUAccessType access_type, int mmu_idx,
>>> -                                    int is_debug)
>>> +TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
>>> +                             MMUAccessType access_type, int mmu_idx,
>>> +                             int is_debug, bool guest, uintptr_t retaddr)
>>>    {
>>>        TLBRet ret;
>>>    
>>>        if (tcg_enabled()) {
>>> -        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx);
>>> +        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx,
>>> +                                          guest);
>>>            if (ret != TLBRET_NOMATCH) {
>>>                return ret;
>>>            }
>>> @@ -290,7 +312,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
>>>             * legal mapping, even if the mapping is not yet in TLB. return 0 if
>>>             * there is a valid map, else none zero.
>>>             */
>>> -        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
>>> +        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
>>> +                             guest, retaddr);
>>>        }
>>>    
>>>        return TLBRET_NOMATCH;
>>> @@ -309,14 +332,14 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
>>>    
>>>    TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>>>                                MMUAccessType access_type, int mmu_idx,
>>> -                            int is_debug)
>>> +                            int is_debug, uintptr_t retaddr)
>>>    {
>>> -    int user_mode = mmu_idx == MMU_USER_IDX;
>>> -    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
>>> +    int user_mode = mmu_idx_to_plv(mmu_idx) == MMU_USER_IDX;
>>> +    int kernel_mode = mmu_idx_to_plv(mmu_idx) == MMU_KERNEL_IDX;
>>>        uint32_t plv, base_c, base_v;
>>>        int64_t addr_high;
>>> -    uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
>>> -    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
>>> +    uint8_t da = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, DA);
>>> +    uint8_t pg = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PG);
>>>        vaddr address;
>>>    
>>>        /* Check PG and DA */
>>> @@ -337,12 +360,15 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>>>        /* Check direct map window */
>>>        for (int i = 0; i < 4; i++) {
>>>            if (is_la64(env)) {
>>> -            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
>>> +            base_c =
>>> +                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_64, VSEG);
>>>            } else {
>>> -            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
>>> +            base_c =
>>> +                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_32, VSEG);
>>>            }
>>> -        if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
>>> -            context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
>>> +        if ((plv & GET_CSR_IF(env->guest, DMW[i])) && (base_c == base_v)) {
>>> +            context->physical =
>>> +                dmw_va2pa(env, address, GET_CSR_IF(env->guest, DMW[i]));
>>>                context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>                context->mmu_index = MMU_DA_IDX;
>>>                return TLBRET_MATCH;
>>> @@ -356,7 +382,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>>>        }
>>>    
>>>        /* Mapped address */
>>> -    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
>>> +    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug,
>>> +                                 env->guest, retaddr);
>>>    }
>>>    
>>>    hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>>> @@ -366,7 +393,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>>>    
>>>        context.addr = addr;
>>>        if (get_physical_address(env, &context, MMU_DATA_LOAD,
>>> -                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
>>> +                             cpu_mmu_index(cs, false), 1, 0) != TLBRET_MATCH) {
>>>            return -1;
>>>        }
>>>        return context.physical;
>>> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
>>> index cae416266b..b282da6ea6 100644
>>> --- a/target/loongarch/disas.c
>>> +++ b/target/loongarch/disas.c
>>> @@ -701,6 +701,12 @@ INSN(invtlb,       i_rr)
>>>    INSN(gcsrrd,       r_csr)
>>>    INSN(gcsrwr,       r_csr)
>>>    INSN(gcsrxchg,     rr_csr)
>>> +INSN(gtlbclr,      empty)
>>> +INSN(gtlbflush,    empty)
>>> +INSN(gtlbsrch,     empty)
>>> +INSN(gtlbrd,       empty)
>>> +INSN(gtlbwr,       empty)
>>> +INSN(gtlbfill,     empty)
>>>    INSN(hvcl,         i)
>>>    INSN(cacop,        cop_r_i)
>>>    INSN(lddir,        rr_i)
>>> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
>>> index 2ade384081..b19c40b423 100644
>>> --- a/target/loongarch/insns.decode
>>> +++ b/target/loongarch/insns.decode
>>> @@ -502,6 +502,12 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>>>      gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
>>>    }
>>>    
>>> +gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
>>> +gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
>>> +gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
>>> +gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
>>> +gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
>>> +gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
>>>    hvcl             0000 0000 0010 1011 1 ...............    @i15
>>>    
>>>    iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
>>> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
>>> index 69f6cb352a..648328a7ef 100644
>>> --- a/target/loongarch/tcg/helper.h
>>> +++ b/target/loongarch/tcg/helper.h
>>> @@ -133,11 +133,18 @@ DEF_HELPER_1(tlbsrch, void, env)
>>>    DEF_HELPER_1(tlbrd, void, env)
>>>    DEF_HELPER_1(tlbclr, void, env)
>>>    DEF_HELPER_1(tlbflush, void, env)
>>> -DEF_HELPER_1(invtlb_all, void, env)
>>> -DEF_HELPER_2(invtlb_all_g, void, env, i32)
>>> -DEF_HELPER_2(invtlb_all_asid, void, env, tl)
>>> -DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
>>> -DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
>>> +DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
>>> +DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
>>> +DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
>>> +DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
>>> +DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
>>> +
>>> +DEF_HELPER_1(gtlbwr, void, env)
>>> +DEF_HELPER_1(gtlbfill, void, env)
>>> +DEF_HELPER_1(gtlbsrch, void, env)
>>> +DEF_HELPER_1(gtlbrd, void, env)
>>> +DEF_HELPER_1(gtlbclr, void, env)
>>> +DEF_HELPER_1(gtlbflush, void, env)
>>>    
>>>    DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
>>>    DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
>>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>> index 0cb629e5d7..19b02e6a78 100644
>>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>>> @@ -42,6 +42,12 @@ GEN_FALSE_TRANS(idle)
>>>    GEN_FALSE_TRANS(gcsrrd)
>>>    GEN_FALSE_TRANS(gcsrwr)
>>>    GEN_FALSE_TRANS(gcsrxchg)
>>> +GEN_FALSE_TRANS(gtlbclr)
>>> +GEN_FALSE_TRANS(gtlbflush)
>>> +GEN_FALSE_TRANS(gtlbsrch)
>>> +GEN_FALSE_TRANS(gtlbrd)
>>> +GEN_FALSE_TRANS(gtlbwr)
>>> +GEN_FALSE_TRANS(gtlbfill)
>>>    GEN_FALSE_TRANS(hvcl)
>>>    
>>>    #else
>>> @@ -305,7 +311,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
>>>    
>>>    static void check_mmu_idx(DisasContext *ctx)
>>>    {
>>> -    if (ctx->mem_idx != MMU_DA_IDX) {
>>> +    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
>>>            tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>>>            ctx->base.is_jmp = DISAS_EXIT;
>>>        }
>>> @@ -378,25 +384,61 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>>>            return false;
>>>        }
>>>    
>>> +    if (!avail_LVZ(ctx) && a->imm > 0x6) {
>>> +        return false;
>>> +    }
>>> +
>>> +    //TODO: futher refinement of op 0x9 and 0x10-0x16
>>>        switch (a->imm) {
>>> -    case 0:
>>> -    case 1:
>>> -        gen_helper_invtlb_all(tcg_env);
>>> +    case 0x0:
>>> +    case 0x1:
>>> +        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(a->imm),
>>> +                              tcg_constant_i32(0));
>>> +        break;
>>> +    case 0x2:
>>> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
>>> +                                tcg_constant_i32(0));
>>> +        break;
>>> +    case 0x3:
>>> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
>>> +                                tcg_constant_i32(0));
>>> +        break;
>>> +    case 0x4:
>>> +        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(0));
>>> +        break;
>>> +    case 0x5:
>>> +        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(0));
>>>            break;
>>> -    case 2:
>>> -        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(1));
>>> +    case 0x6:
>>> +        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32(0));
>>>            break;
>>> -    case 3:
>>> -        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(0));
>>> +    case 0x9:
>>> +    case 0x10:
>>> +    case 0x11:
>>> +    case 0x12:
>>> +    case 0x13:
>>> +    case 0x14:
>>> +    case 0x15:
>>> +    case 0x16:
>>> +        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
>>> +                              tcg_constant_i32(0));
>>>            break;
>>> -    case 4:
>>> -        gen_helper_invtlb_all_asid(tcg_env, rj);
>>> +    case 0xa:
>>> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
>>> +                                tcg_constant_i32(1));
>>>            break;
>>> -    case 5:
>>> -        gen_helper_invtlb_page_asid(tcg_env, rj, rk);
>>> +    case 0xb:
>>> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
>>> +                                tcg_constant_i32(1));
>>>            break;
>>> -    case 6:
>>> -        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk);
>>> +    case 0xc:
>>> +        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
>>> +        break;
>>> +    case 0xd:
>>> +        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
>>> +        break;
>>> +    case 0xe:
>>> +        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32(1));
>>>            break;
>>>        default:
>>>            return false;
>>> @@ -613,6 +655,64 @@ static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
>>>        return true;
>>>    }
>>>    
>>> +static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbsrch(tcg_env);
>>> +    return true;
>>> +}
>>> +
>>> +static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbrd(tcg_env);
>>> +    return true;
>>> +}
>>> +
>>> +static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbwr(tcg_env);
>>> +    check_mmu_idx(ctx);
>>> +    return true;
>>> +}
>>> +
>>> +static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbfill(tcg_env);
>>> +    check_mmu_idx(ctx);
>>> +    return true;
>>> +}
>>> +
>>> +static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbclr(tcg_env);
>>> +    check_mmu_idx(ctx);
>>> +    return true;
>>> +}
>>> +
>>> +static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
>>> +{
>>> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
>>> +        return false;
>>> +    }
>>> +    gen_helper_gtlbflush(tcg_env);
>>> +    check_mmu_idx(ctx);
>>> +    return true;
>>> +}
>>> +
>>>    static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
>>>    {
>>>        if (!avail_LVZ(ctx)) {
>>> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
>>> index 7fb627f2d6..ceba1e4062 100644
>>> --- a/target/loongarch/tcg/tcg_loongarch.h
>>> +++ b/target/loongarch/tcg/tcg_loongarch.h
>>> @@ -16,8 +16,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>>                                MMUAccessType access_type, int mmu_idx,
>>>                                bool probe, uintptr_t retaddr);
>>>    
>>> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
>>> -                                   MMUContext *context,
>>> -                                   MMUAccessType access_type, int mmu_idx);
>>> +TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *context,
>>> +                                   MMUAccessType access_type, int mmu_idx,
>>> +                                   bool guest);
>>>    
>>>    #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
>>> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
>>> index 892e0eb473..fec0aeeb57 100644
>>> --- a/target/loongarch/tcg/tlb_helper.c
>>> +++ b/target/loongarch/tcg/tlb_helper.c
>>> @@ -34,6 +34,13 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
>>>        return !global && tlb_asid == asid;
>>>    }
>>>    
>>> +static inline bool tlb_entry_matches_gid(LoongArchTLB *tlb, uint8_t gid)
>>> +{
>>> +    uint8_t entry_gid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID);
>>> +
>>> +    return entry_gid == gid;
>>> +}
>>> +
>>>    bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
>>>    {
>>>        if (tlb_ps >= 64) {
>>> @@ -46,14 +53,22 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>>>                                    MMUAccessType access_type, TLBRet tlb_error)
>>>    {
>>>        CPUState *cs = env_cpu(env);
>>> +    bool real_guest;
>>> +
>>> +    if (env->guest && tlb_error > TLBRET_HOST_MATCH) {
>>> +        trigger_vm_exit(env);
>>> +    }
>>> +    real_guest = !env->vm_exit && env->guest;
>>>    
>>>        switch (tlb_error) {
>>>        default:
>>>        case TLBRET_BADADDR:
>>> +    case TLBRET_HOST_BADADDR:
>>>            cs->exception_index = access_type == MMU_INST_FETCH
>>>                                  ? EXCCODE_ADEF : EXCCODE_ADEM;
>>>            break;
>>>        case TLBRET_NOMATCH:
>>> +    case TLBRET_HOST_NOMATCH:
>>>            /* No TLB match for a mapped address */
>>>            if (access_type == MMU_DATA_LOAD) {
>>>                cs->exception_index = EXCCODE_PIL;
>>> @@ -62,9 +77,12 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>>>            } else if (access_type == MMU_INST_FETCH) {
>>>                cs->exception_index = EXCCODE_PIF;
>>>            }
>>> -        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
>>> +        SET_CSR_IF(real_guest, TLBRERA,
>>> +                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA,
>>> +                              ISTLBR, 1));
>>>            break;
>>>        case TLBRET_INVALID:
>>> +    case TLBRET_HOST_INVALID:
>>>            /* TLB match with no valid bit */
>>>            if (access_type == MMU_DATA_LOAD) {
>>>                cs->exception_index = EXCCODE_PIL;
>>> @@ -75,46 +93,58 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>>>            }
>>>            break;
>>>        case TLBRET_DIRTY:
>>> +    case TLBRET_HOST_DIRTY:
>>>            /* TLB match but 'D' bit is cleared */
>>>            cs->exception_index = EXCCODE_PME;
>>>            break;
>>>        case TLBRET_XI:
>>> +    case TLBRET_HOST_XI:
>>>            /* Execute-Inhibit Exception */
>>>            cs->exception_index = EXCCODE_PNX;
>>>            break;
>>>        case TLBRET_RI:
>>> +    case TLBRET_HOST_RI:
>>>            /* Read-Inhibit Exception */
>>>            cs->exception_index = EXCCODE_PNR;
>>>            break;
>>>        case TLBRET_PE:
>>> +    case TLBRET_HOST_PE:
>>>            /* Privileged Exception */
>>>            cs->exception_index = EXCCODE_PPI;
>>>            break;
>>>        }
>>>    
>>> -    if (tlb_error == TLBRET_NOMATCH) {
>>> -        env->CSR_TLBRBADV = address;
>>> +    if (tlb_error == TLBRET_NOMATCH || tlb_error == TLBRET_HOST_NOMATCH) {
>>> +        SET_CSR_IF(real_guest, TLBRBADV, address);
>>>            if (is_la64(env)) {
>>> -            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
>>> -                                        VPPN, extract64(address, 13, 35));
>>> +            SET_CSR_IF(real_guest, TLBREHI,
>>> +                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
>>> +                                  CSR_TLBREHI_64, VPPN,
>>> +                                  extract64(address, 13, 35)));
>>>            } else {
>>> -            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
>>> -                                        VPPN, extract64(address, 13, 19));
>>> +            SET_CSR_IF(real_guest, TLBREHI,
>>> +                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
>>> +                                  CSR_TLBREHI_32, VPPN,
>>> +                                  extract64(address, 13, 19)));
>>>            }
>>>        } else {
>>>            if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
>>> -            env->CSR_BADV = address;
>>> +            SET_CSR_IF(real_guest, BADV, address);
>>>            }
>>> -        env->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
>>> -   }
>>> +        SET_CSR_IF(real_guest, TLBEHI, address & (TARGET_PAGE_MASK << 1));
>>> +    }
>>>    }
>>>    
>>> -static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>>> +static void invalidate_tlb_entry(CPULoongArchState *env, int index, bool guest)
>>>    {
>>>        target_ulong addr, mask, pagesize;
>>>        uint8_t tlb_ps;
>>> -    LoongArchTLB *tlb = &env->tlb[index];
>>> -    int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
>>> +    LoongArchTLB *tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>>> +    int idxmap =
>>> +        guest ? (BIT(MMU_GUEST_IDX) | BIT(MMU_GUEST_IDX + 1) |
>>> +                 BIT(MMU_GUEST_IDX + 2) | BIT(MMU_GUEST_IDX + 3) |
>>> +                 BIT(MMU_GUEST_DA_IDX)) :
>>> +                (BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX) | BIT(MMU_DA_IDX));
>>>        uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>>>        bool tlb_v;
>>>    
>>> @@ -124,27 +154,27 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>>>        addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
>>>        addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
>>>    
>>> -    tlb_v = pte_present(env, tlb->tlb_entry0);
>>> +    tlb_v = pte_present(env, tlb->tlb_entry0, guest);
>>>        if (tlb_v) {
>>>            tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
>>>                                      idxmap, TARGET_LONG_BITS);
>>>        }
>>>    
>>> -    tlb_v = pte_present(env, tlb->tlb_entry1);
>>> +    tlb_v = pte_present(env, tlb->tlb_entry1, guest);
>>>        if (tlb_v) {
>>>            tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
>>>                                      idxmap, TARGET_LONG_BITS);
>>>        }
>>>    }
>>>    
>>> -static void invalidate_tlb(CPULoongArchState *env, int index)
>>> +static void invalidate_tlb(CPULoongArchState *env, int index, bool guest)
>>>    {
>>>        LoongArchTLB *tlb;
>>>        uint16_t csr_asid, tlb_asid, tlb_g;
>>>        uint8_t tlb_e;
>>>    
>>> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>>> -    tlb = &env->tlb[index];
>>> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>>> +    tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>>>        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>        if (!tlb_e) {
>>>            return;
>>> @@ -157,33 +187,38 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
>>>        if (tlb_g == 0 && tlb_asid != csr_asid) {
>>>            return;
>>>        }
>>> -    invalidate_tlb_entry(env, index);
>>> +    invalidate_tlb_entry(env, index, guest);
>>>    }
>>>    
>>>    /* Prepare tlb entry information in software PTW mode */
>>> -static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
>>> +static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
>>> +                                 bool guest)
>>>    {
>>>        uint64_t lo0, lo1, csr_vppn;
>>>        uint8_t csr_ps;
>>>    
>>> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>> -        csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
>>> +    if (FIELD_EX64(GET_CSR_IF(guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
>>> +        csr_ps = FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI, PS);
>>>            if (is_la64(env)) {
>>> -            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
>>> +            csr_vppn =
>>> +                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_64, VPPN);
>>>            } else {
>>> -            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
>>> +            csr_vppn =
>>> +                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_32, VPPN);
>>>            }
>>> -        lo0 = env->CSR_TLBRELO0;
>>> -        lo1 = env->CSR_TLBRELO1;
>>> +        lo0 = GET_CSR_IF(guest, TLBRELO0);
>>> +        lo1 = GET_CSR_IF(guest, TLBRELO1);
>>>        } else {
>>> -        csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
>>> +        csr_ps = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS);
>>>            if (is_la64(env)) {
>>> -            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
>>> +            csr_vppn =
>>> +                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_64, VPPN);
>>>            } else {
>>> -            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
>>> +            csr_vppn =
>>> +                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_32, VPPN);
>>>            }
>>> -        lo0 = env->CSR_TLBELO0;
>>> -        lo1 = env->CSR_TLBELO1;
>>> +        lo0 = GET_CSR_IF(guest, TLBELO0);
>>> +        lo1 = GET_CSR_IF(guest, TLBELO1);
>>>        }
>>>    
>>>        context->ps = csr_ps;
>>> @@ -193,7 +228,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
>>>    }
>>>    
>>>    static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
>>> -                           MMUContext *context)
>>> +                           MMUContext *context, bool guest)
>>>    {
>>>        uint64_t lo0, lo1, csr_vppn;
>>>        uint16_t csr_asid;
>>> @@ -208,8 +243,9 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
>>>        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
>>>        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
>>>        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
>>> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>>> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>>>        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
>>> +    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_tgid(env));
>>>    
>>>        tlb->tlb_entry0 = lo0;
>>>        tlb->tlb_entry1 = lo1;
>>> @@ -233,7 +269,8 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
>>>     */
>>>    static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>                                                 vaddr vaddr, int csr_asid,
>>> -                                             tlb_match func)
>>> +                                             tlb_match func, bool guest,
>>> +                                             uint8_t gid)
>>>    {
>>>        LoongArchTLB *tlb;
>>>        uint16_t tlb_asid, stlb_idx;
>>> @@ -242,14 +279,15 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>        int i, compare_shift;
>>>        uint64_t vpn, tlb_vppn;
>>>    
>>> -    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
>>> +    stlb_ps = FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
>>>        vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
>>>        stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
>>>        compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
>>>    
>>>        /* Search STLB */
>>>        for (i = 0; i < 8; ++i) {
>>> -        tlb = &env->tlb[i * 256 + stlb_idx];
>>> +        tlb = guest ? &env->gtlb[i * 256 + stlb_idx] :
>>> +                      &env->tlb[i * 256 + stlb_idx];
>>>            tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>            if (tlb_e) {
>>>                tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>>> @@ -257,6 +295,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>                tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>>    
>>>                if (func(tlb_g, csr_asid, tlb_asid) &&
>>> +                tlb_entry_matches_gid(tlb, gid) &&
>>>                    (vpn == (tlb_vppn >> compare_shift))) {
>>>                    return tlb;
>>>                }
>>> @@ -265,7 +304,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>    
>>>        /* Search MTLB */
>>>        for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
>>> -        tlb = &env->tlb[i];
>>> +        tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>>>            tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>            if (tlb_e) {
>>>                tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>>> @@ -275,6 +314,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>                compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
>>>                vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>>>                if (func(tlb_g, csr_asid, tlb_asid) &&
>>> +                tlb_entry_matches_gid(tlb, gid) &&
>>>                    (vpn == (tlb_vppn >> compare_shift))) {
>>>                    return tlb;
>>>                }
>>> @@ -284,17 +324,17 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>>>    }
>>>    
>>>    static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
>>> -                                 int *index)
>>> +                                 int *index, bool guest, uint8_t gid)
>>>    {
>>>        int csr_asid;
>>>        tlb_match func;
>>>        LoongArchTLB *tlb;
>>>    
>>>        func = tlb_match_any;
>>> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>>> -    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
>>> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>>> +    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func, guest, gid);
>>>        if (tlb) {
>>> -        *index = tlb - env->tlb;
>>> +        *index = guest ? (tlb - env->gtlb) : (tlb - env->tlb);
>>>            return true;
>>>        }
>>>    
>>> @@ -304,66 +344,112 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
>>>    void helper_tlbsrch(CPULoongArchState *env)
>>>    {
>>>        int index, match;
>>> +    vaddr search_ehi;
>>>    
>>> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>> -        match = loongarch_tlb_search(env, env->CSR_TLBREHI, &index);
>>> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
>>> +        search_ehi = GET_CSR_IF(env->guest, TLBREHI);
>>>        } else {
>>> -        match = loongarch_tlb_search(env, env->CSR_TLBEHI, &index);
>>> +        search_ehi = GET_CSR_IF(env->guest, TLBEHI);
>>>        }
>>>    
>>> +    match = loongarch_tlb_search(env, search_ehi, &index, env->guest,
>>> +                                 get_tgid(env));
>>> +
>>>        if (match) {
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX, index);
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
>>> +        SET_CSR_IF(env->guest, TLBIDX,
>>> +                   FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, INDEX,
>>> +                              index));
>>> +        SET_CSR_IF(
>>> +            env->guest, TLBIDX,
>>> +            FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, 0));
>>>            return;
>>>        }
>>>    
>>> -    env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
>>> +    SET_CSR_IF(env->guest, TLBIDX,
>>> +               FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, 1));
>>>    }
>>>    
>>> -void helper_tlbrd(CPULoongArchState *env)
>>> +static void read_tlb(CPULoongArchState *env, bool guest)
>>>    {
>>>        LoongArchTLB *tlb;
>>>        int index;
>>>        uint8_t tlb_ps, tlb_e;
>>>    
>>> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>>> -    tlb = &env->tlb[index];
>>> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
>>> +    tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>>>        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>>>        tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>    
>>>        if (!tlb_e) {
>>>            /* Invalid TLB entry */
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
>>> -        env->CSR_ASID  = FIELD_DP64(env->CSR_ASID, CSR_ASID, ASID, 0);
>>> -        env->CSR_TLBEHI = 0;
>>> -        env->CSR_TLBELO0 = 0;
>>> -        env->CSR_TLBELO1 = 0;
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS, 0);
>>> +        SET_CSR_IF(guest, TLBIDX,
>>> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 1));
>>> +        SET_CSR_IF(guest, ASID,
>>> +                   FIELD_DP64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID, 0));
>>> +        SET_CSR_IF(guest, TLBEHI, 0);
>>> +        SET_CSR_IF(guest, TLBELO0, 0);
>>> +        SET_CSR_IF(guest, TLBELO1, 0);
>>> +        SET_CSR_IF(guest, TLBIDX,
>>> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS, 0));
>>>        } else {
>>>            /* Valid TLB entry */
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
>>> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX,
>>> -                                     PS, (tlb_ps & 0x3f));
>>> -        env->CSR_TLBEHI = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
>>> -                                     R_TLB_MISC_VPPN_SHIFT;
>>> -        env->CSR_TLBELO0 = tlb->tlb_entry0;
>>> -        env->CSR_TLBELO1 = tlb->tlb_entry1;
>>> +        SET_CSR_IF(guest, TLBIDX,
>>> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 0));
>>> +        SET_CSR_IF(guest, TLBIDX,
>>> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS,
>>> +                              tlb_ps & 0x3f));
>>> +        SET_CSR_IF(guest, TLBEHI,
>>> +                   FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN)
>>> +                       << R_TLB_MISC_VPPN_SHIFT);
>>> +        SET_CSR_IF(guest, TLBELO0, tlb->tlb_entry0);
>>> +        SET_CSR_IF(guest, TLBELO1, tlb->tlb_entry1);
>>> +    }
>>> +}
>>> +
>>> +void helper_tlbrd(CPULoongArchState *env)
>>> +{
>>> +    read_tlb(env, env->guest);
>>> +}
>>> +
>>> +void helper_gtlbsrch(CPULoongArchState *env)
>>> +{
>>> +    int index, match;
>>> +    vaddr search_ehi;
>>> +
>>> +    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>> +        search_ehi = env->GCSR_TLBREHI;
>>> +    } else {
>>> +        search_ehi = env->GCSR_TLBEHI;
>>> +    }
>>> +
>>> +    match = loongarch_tlb_search(env, search_ehi, &index, true, get_tgid(env));
>>> +    if (match) {
>>> +        env->GCSR_TLBIDX =
>>> +            FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX, index);
>>> +        env->GCSR_TLBIDX = FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, 0);
>>> +        return;
>>>        }
>>> +    env->GCSR_TLBIDX = FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, 1);
>>> +}
>>> +
>>> +void helper_gtlbrd(CPULoongArchState *env)
>>> +{
>>> +    read_tlb(env, true);
>>>    }
>>>    
>>>    static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
>>> -                             int index)
>>> +                             int index, bool guest)
>>>    {
>>>        LoongArchTLB *old, new = {};
>>>        bool skip_inv = false, tlb_v0, tlb_v1;
>>>    
>>> -    old = env->tlb + index;
>>> -    fill_tlb_entry(env, &new, context);
>>> +    old = guest ? env->gtlb + index : env->tlb + index;
>>> +    fill_tlb_entry(env, &new, context, guest);
>>>        /* Check whether ASID/VPPN is the same */
>>>        if (old->tlb_misc == new.tlb_misc) {
>>>            /* Check whether both even/odd pages is the same or invalid */
>>> -        tlb_v0 = pte_present(env, old->tlb_entry0);
>>> -        tlb_v1 = pte_present(env, old->tlb_entry1);
>>> +        tlb_v0 = pte_present(env, old->tlb_entry0, guest);
>>> +        tlb_v1 = pte_present(env, old->tlb_entry1, guest);
>>>            if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
>>>                (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
>>>                skip_inv = true;
>>> @@ -372,7 +458,7 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
>>>    
>>>        /* flush tlb before updating the entry */
>>>        if (!skip_inv) {
>>> -        invalidate_tlb(env, index);
>>> +        invalidate_tlb(env, index, guest);
>>>        }
>>>    
>>>        *old = new;
>>> @@ -380,20 +466,34 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
>>>    
>>>    void helper_tlbwr(CPULoongArchState *env)
>>>    {
>>> -    int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>>> +    int index = FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, INDEX);
>>> +    MMUContext context;
>>> +
>>> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE)) {
>>> +        invalidate_tlb(env, index, env->guest);
>>> +        return;
>>> +    }
>>> +
>>> +    sptw_prepare_context(env, &context, env->guest);
>>> +    update_tlb_index(env, &context, index, env->guest);
>>> +}
>>> +
>>> +void helper_gtlbwr(CPULoongArchState *env)
>>> +{
>>> +    int index = FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX);
>>>        MMUContext context;
>>>    
>>> -    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
>>> -        invalidate_tlb(env, index);
>>> +    if (FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, NE)) {
>>> +        invalidate_tlb(env, index, true);
>>>            return;
>>>        }
>>>    
>>> -    sptw_prepare_context(env, &context);
>>> -    update_tlb_index(env, &context, index);
>>> +    sptw_prepare_context(env, &context, true);
>>> +    update_tlb_index(env, &context, index, true);
>>>    }
>>>    
>>>    static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>>> -                                int pagesize)
>>> +                                int pagesize, bool guest)
>>>    {
>>>        uint64_t address;
>>>        int index, set, i, stlb_idx;
>>> @@ -402,15 +502,16 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>>>        uint8_t tlb_e, tlb_g;
>>>    
>>>        /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
>>> -    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
>>> -    asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>>> +    stlb_ps = FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
>>> +    asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>>>        if (pagesize == stlb_ps) {
>>>            /* Only write into STLB bits [47:13] */
>>>            address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
>>>            set = -1;
>>>            stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
>>>            for (i = 0; i < 8; ++i) {
>>> -            tlb = &env->tlb[i * 256 + stlb_idx];
>>> +            tlb = guest ? &env->gtlb[i * 256 + stlb_idx] :
>>> +                          &env->tlb[i * 256 + stlb_idx];
>>>                tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>                if (!tlb_e) {
>>>                    set = i;
>>> @@ -419,7 +520,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>>>    
>>>                tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>>>                tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>> -            if (tlb_g == 0 && asid != tlb_asid) {
>>> +            if (tlb_g == 0 && asid != tlb_asid &&
>>> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>>>                    set = i;
>>>                }
>>>            }
>>> @@ -433,7 +535,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>>>            /* Only write into MTLB */
>>>            index = -1;
>>>            for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
>>> -            tlb = &env->tlb[i];
>>> +            tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>>>                tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>>>    
>>>                if (!tlb_e) {
>>> @@ -443,7 +545,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>>>    
>>>                tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>>>                tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>> -            if (tlb_g == 0 && asid != tlb_asid) {
>>> +            if (tlb_g == 0 && asid != tlb_asid &&
>>> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>>>                    index = i;
>>>                }
>>>            }
>>> @@ -462,48 +565,70 @@ void helper_tlbfill(CPULoongArchState *env)
>>>        int index, pagesize;
>>>        MMUContext context;
>>>    
>>> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>> -        entryhi = env->CSR_TLBREHI;
>>> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
>>> +        entryhi = GET_CSR_IF(env->guest, TLBREHI);
>>>            /* Validity of pagesize is checked in helper_ldpte() */
>>> -        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
>>> +        pagesize = FIELD_EX64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBREHI, PS);
>>>        } else {
>>> -        entryhi = env->CSR_TLBEHI;
>>> +        entryhi = GET_CSR_IF(env->guest, TLBEHI);
>>>            /* Validity of pagesize is checked in helper_tlbrd() */
>>> -        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
>>> +        pagesize = FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, PS);
>>>        }
>>>    
>>> -    sptw_prepare_context(env, &context);
>>> -    index = get_tlb_random_index(env, entryhi, pagesize);
>>> -    invalidate_tlb(env, index);
>>> -    fill_tlb_entry(env, env->tlb + index, &context);
>>> +    sptw_prepare_context(env, &context, env->guest);
>>> +    index = get_tlb_random_index(env, entryhi, pagesize, env->guest);
>>> +    invalidate_tlb(env, index, env->guest);
>>> +    fill_tlb_entry(env, env->guest ? env->gtlb + index : env->tlb + index,
>>> +                   &context, env->guest);
>>>    }
>>>    
>>> -void helper_tlbclr(CPULoongArchState *env)
>>> +void helper_gtlbfill(CPULoongArchState *env)
>>> +{
>>> +    vaddr entryhi;
>>> +    int index, pagesize;
>>> +    MMUContext context;
>>> +
>>> +    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
>>> +        entryhi = env->GCSR_TLBREHI;
>>> +        pagesize = FIELD_EX64(env->GCSR_TLBREHI, CSR_TLBREHI, PS);
>>> +    } else {
>>> +        entryhi = env->GCSR_TLBEHI;
>>> +        pagesize = FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, PS);
>>> +    }
>>> +
>>> +    sptw_prepare_context(env, &context, true);
>>> +    index = get_tlb_random_index(env, entryhi, pagesize, true);
>>> +    invalidate_tlb(env, index, true);
>>> +    fill_tlb_entry(env, env->gtlb + index, &context, true);
>>> +}
>>> +
>>> +static void clear_tlb_by_index(CPULoongArchState *env, bool guest)
>>>    {
>>>        LoongArchTLB *tlb;
>>>        int i, index;
>>>        uint16_t csr_asid, tlb_asid, tlb_g;
>>>    
>>> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>>> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>>> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>>> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
>>>    
>>>        if (index < LOONGARCH_STLB) {
>>> -        /* STLB. One line per operation */
>>>            for (i = 0; i < 8; i++) {
>>> -            tlb = &env->tlb[i * 256 + (index % 256)];
>>> +            tlb = guest ? &env->gtlb[i * 256 + (index % 256)] :
>>> +                          &env->tlb[i * 256 + (index % 256)];
>>>                tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>>>                tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>> -            if (!tlb_g && tlb_asid == csr_asid) {
>>> +            if (!tlb_g && tlb_asid == csr_asid &&
>>> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>>>                    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>                }
>>>            }
>>>        } else if (index < LOONGARCH_TLB_MAX) {
>>> -        /* All MTLB entries */
>>>            for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
>>> -            tlb = &env->tlb[i];
>>> +            tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>>>                tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>>>                tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>> -            if (!tlb_g && tlb_asid == csr_asid) {
>>> +            if (!tlb_g && tlb_asid == csr_asid &&
>>> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>>>                    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>                }
>>>            }
>>> @@ -512,62 +637,116 @@ void helper_tlbclr(CPULoongArchState *env)
>>>        tlb_flush(env_cpu(env));
>>>    }
>>>    
>>> -void helper_tlbflush(CPULoongArchState *env)
>>> +void helper_tlbclr(CPULoongArchState *env)
>>> +{
>>> +    clear_tlb_by_index(env, env->guest);
>>> +}
>>> +
>>> +void helper_gtlbclr(CPULoongArchState *env)
>>> +{
>>> +    clear_tlb_by_index(env, true);
>>> +}
>>> +
>>> +static void flush_tlb_by_index(CPULoongArchState *env, bool guest)
>>>    {
>>>        int i, index;
>>>    
>>> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>>> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
>>>    
>>>        if (index < LOONGARCH_STLB) {
>>> -        /* STLB. One line per operation */
>>>            for (i = 0; i < 8; i++) {
>>>                int s_idx = i * 256 + (index % 256);
>>> -            env->tlb[s_idx].tlb_misc = FIELD_DP64(env->tlb[s_idx].tlb_misc,
>>> -                                                  TLB_MISC, E, 0);
>>> +            LoongArchTLB *tlb = guest ? &env->gtlb[s_idx] : &env->tlb[s_idx];
>>> +
>>> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>            }
>>>        } else if (index < LOONGARCH_TLB_MAX) {
>>> -        /* All MTLB entries */
>>>            for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
>>> -            env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
>>> -                                              TLB_MISC, E, 0);
>>> +            LoongArchTLB *tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>>> +
>>> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>            }
>>>        }
>>>    
>>>        tlb_flush(env_cpu(env));
>>>    }
>>>    
>>> -void helper_invtlb_all(CPULoongArchState *env)
>>> +void helper_tlbflush(CPULoongArchState *env)
>>> +{
>>> +    flush_tlb_by_index(env, env->guest);
>>> +}
>>> +
>>> +void helper_gtlbflush(CPULoongArchState *env)
>>> +{
>>> +    flush_tlb_by_index(env, true);
>>> +}
>>> +
>>> +void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
>>> +                       uint32_t to_guest)
>>>    {
>>> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
>>> +
>>> +    if (to_guest && env->guest) {
>>> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
>>> +    }
>>> +
>>> +    to_guest |= env->guest;
>>> +
>>>        for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>>> -        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
>>> -                                          TLB_MISC, E, 0);
>>> +        LoongArchTLB *tlb = &env->tlb[i];
>>> +        LoongArchTLB *gtlb = &env->gtlb[i];
>>> +
>>> +        if (!to_guest && (op == 0 || tlb_entry_matches_gid(tlb, 0))) {
>>> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>> +        }
>>> +        if ((!to_guest && op == 0) ||
>>> +            (to_guest && tlb_entry_matches_gid(gtlb, gid))) {
>>> +            gtlb->tlb_misc = FIELD_DP64(gtlb->tlb_misc, TLB_MISC, E, 0);
>>> +        }
>>>        }
>>>        tlb_flush(env_cpu(env));
>>>    }
>>>    
>>> -void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
>>> +void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
>>> +                         uint32_t to_guest)
>>>    {
>>> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
>>> +
>>> +    if (to_guest && env->guest) {
>>> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
>>> +    }
>>> +
>>> +    to_guest |= env->guest;
>>> +
>>>        for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>>> -        LoongArchTLB *tlb = &env->tlb[i];
>>> +        LoongArchTLB *tlb = to_guest ? &env->gtlb[i] : &env->tlb[i];
>>>            uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>>    
>>> -        if (tlb_g == g) {
>>> +        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
>>>                tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>            }
>>>        }
>>>        tlb_flush(env_cpu(env));
>>>    }
>>>    
>>> -void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
>>> +void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
>>> +                            uint32_t to_guest)
>>>    {
>>>        uint16_t asid = info & R_CSR_ASID_ASID_MASK;
>>> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>>> +
>>> +    if (to_guest && env->guest) {
>>> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
>>> +    }
>>> +
>>> +    to_guest |= env->guest;
>>>    
>>>        for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>>> -        LoongArchTLB *tlb = &env->tlb[i];
>>> +        LoongArchTLB *tlb = to_guest ? &env->gtlb[i] : &env->tlb[i];
>>>            uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>>>            uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>>>    
>>> -        if (!tlb_g && (tlb_asid == asid)) {
>>> +        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
>>>                tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>>>            }
>>>        }
>>> @@ -575,66 +754,82 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
>>>    }
>>>    
>>>    void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>>> -                             target_ulong addr)
>>> +                             target_ulong addr, uint32_t to_guest)
>>>    {
>>> -    int asid = info & 0x3ff;
>>> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
>>> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>>>        LoongArchTLB *tlb;
>>> -    tlb_match func;
>>> +    int index;
>>> +
>>> +    if (to_guest && env->guest) {
>>> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
>>> +    }
>>> +    to_guest |= env->guest;
>>>    
>>> -    func = tlb_match_asid;
>>> -    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
>>> +    tlb =
>>> +        loongarch_tlb_search_cb(env, addr, asid, tlb_match_asid, to_guest, gid);
>>>        if (tlb) {
>>> -        invalidate_tlb(env, tlb - env->tlb);
>>> +        index = to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
>>> +        invalidate_tlb(env, index, to_guest);
>>>        }
>>>    }
>>>    
>>> -void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>>> -                                  target_ulong info, target_ulong addr)
>>> +void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
>>> +                                  target_ulong addr, uint32_t to_guest)
>>>    {
>>> -    int asid = info & 0x3ff;
>>> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
>>> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>>>        LoongArchTLB *tlb;
>>> -    tlb_match func;
>>> +    int index;
>>>    
>>> -    func = tlb_match_any;
>>> -    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
>>> +    if (to_guest && env->guest) {
>>> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
>>> +    }
>>> +
>>> +    to_guest |= env->guest;
>>> +
>>> +    tlb =
>>> +        loongarch_tlb_search_cb(env, addr, asid, tlb_match_any, to_guest, gid);
>>>        if (tlb) {
>>> -        invalidate_tlb(env, tlb - env->tlb);
>>> +        index = to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
>>> +        invalidate_tlb(env, index, to_guest);
>>>        }
>>>    }
>>>    
>>> -static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
>>> +static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
>>> +                           bool guest)
>>>    {
>>>        int index;
>>>    
>>>        index = context->tlb_index;
>>>        if (index < 0) {
>>> -        index = get_tlb_random_index(env, context->addr, context->ps);
>>> +        index = get_tlb_random_index(env, context->addr, context->ps, guest);
>>>        }
>>>    
>>> -    update_tlb_index(env, context, index);
>>> +    update_tlb_index(env, context, index, guest);
>>>    }
>>>    
>>> -bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>> -                            MMUAccessType access_type, int mmu_idx,
>>> -                            bool probe, uintptr_t retaddr)
>>> +TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
>>> +                                  MMUAccessType access_type, uintptr_t retaddr)
>>>    {
>>> -    CPULoongArchState *env = cpu_env(cs);
>>> -    hwaddr physical;
>>> -    int prot;
>>> -    MMUContext context;
>>>        TLBRet ret;
>>> +    ret = loongarch_map_address(env, context, access_type, MMU_KERNEL_IDX,
>>> +                                false, false, retaddr);
>>> +    return TLBRET_HOST_MATCH + ret;
>>> +}
>>>    
>>> -    /* Data access */
>>> -    context.addr = address;
>>> -    context.tlb_index = -1;
>>> -    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
>>> -    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
>>> -        && cpu_has_ptw(env)) {
>>> +static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
>>> +                              MMUAccessType access_type, int mmu_index,
>>> +                              TLBRet *status, bool guest, uintptr_t retaddr)
>>> +{
>>> +    if ((*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) &&
>>> +        context->mmu_index != MMU_DA_IDX &&
>>> +        context->mmu_index != MMU_GUEST_DA_IDX && cpu_has_ptw(env, guest)) {
>>>            bool need_update = true;
>>>    
>>> -        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
>>> +        if (access_type == MMU_DATA_STORE && pte_dirty(context->pte)) {
>>>                need_update = false;
>>> -        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
>>> +        } else if (access_type != MMU_DATA_STORE && pte_access(context->pte)) {
>>>                need_update = false;
>>>    
>>>                /*
>>> @@ -649,31 +844,77 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>>    
>>>            if (need_update) {
>>>                /* Need update bit A/D in PTE entry, take PTW again */
>>> -            ret = TLBRET_NOMATCH;
>>> +            *status =
>>> +                (env->guest && !guest) ? TLBRET_HOST_NOMATCH : TLBRET_NOMATCH;
>>>            }
>>>        }
>>>    
>>> -    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
>>> +    if (*status != TLBRET_MATCH && *status != TLBRET_HOST_MATCH &&
>>> +        cpu_has_ptw(env, guest)) {
>>>            /* Take HW PTW if TLB missed or bit P is zero */
>>> -        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
>>> -            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
>>> -            if (ret == TLBRET_MATCH) {
>>> -                ptw_update_tlb(env, &context);
>>> +        if (*status == TLBRET_NOMATCH || *status == TLBRET_INVALID ||
>>> +            *status == TLBRET_HOST_NOMATCH || *status == TLBRET_HOST_INVALID) {
>>> +            *status =
>>> +                ((env->guest && !guest) ? TLBRET_HOST_MATCH : TLBRET_MATCH) +
>>> +                loongarch_ptw(env, context, access_type, mmu_index, 0, guest,
>>> +                              retaddr);
>>> +            if (*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) {
>>> +                ptw_update_tlb(env, context, guest);
>>>                }
>>> -        } else if (context.tlb_index >= 0) {
>>> -            invalidate_tlb(env, context.tlb_index);
>>> +        } else if (context->tlb_index >= 0) {
>>> +            invalidate_tlb(env, context->tlb_index, guest);
>>>            }
>>>        }
>>> +}
>>> +
>>> +bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>> +                            MMUAccessType access_type, int mmu_idx, bool probe,
>>> +                            uintptr_t retaddr)
>>> +{
>>> +    CPULoongArchState *env = cpu_env(cs);
>>> +    MMUContext host_context;
>>> +    hwaddr physical;
>>> +    int prot, host_prot;
>>> +    MMUContext context;
>>> +    TLBRet ret;
>>> +
>>> +    /* Data access */
>>> +    context.addr = address;
>>> +    context.tlb_index = -1;
>>> +    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
>>> +    loongarch_try_ptw(env, &context, access_type, mmu_idx, &ret, env->guest,
>>> +                      retaddr);
>>>    
>>>        if (ret == TLBRET_MATCH) {
>>>            physical = context.physical;
>>>            prot = context.prot;
>>> +        if (env->guest) {
>>> +            host_context.addr = physical;
>>> +            host_context.tlb_index = -1;
>>> +            ret = loongarch_map_host_address(env, &host_context, access_type,
>>> +                                             retaddr);
>>> +            loongarch_try_ptw(env, &host_context, access_type, MMU_KERNEL_IDX,
>>> +                              &ret, false, retaddr);
>>> +            if (ret != TLBRET_HOST_MATCH) {
>>> +                if (probe) {
>>> +                    return false;
>>> +                }
>>> +                raise_mmu_exception(env, physical, access_type, ret);
>>> +                cpu_loop_exit_restore(cs, retaddr);
>>> +                return false;
>>> +            }
>>> +            physical = host_context.physical;
>>> +            host_prot = host_context.prot;
>>> +            prot &= host_prot;
>>> +        }
>>>            tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>                         physical & TARGET_PAGE_MASK, prot,
>>>                         mmu_idx, TARGET_PAGE_SIZE);
>>>            qemu_log_mask(CPU_LOG_MMU,
>>>                          "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
>>> -                      " prot %d\n", __func__, address, physical, prot);
>>> +                      " prot %d guest %d\n",
>>> +                      __func__, address, physical, prot,
>>> +                      is_guest_mmu_idx(mmu_idx));
>>>            return true;
>>>        } else {
>>>            qemu_log_mask(CPU_LOG_MMU,
>>> @@ -702,6 +943,31 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
>>>        return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
>>>    }
>>>    
>>> +hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
>>> +                                  uintptr_t retaddr)
>>> +{
>>> +    MMUContext host_context;
>>> +    TLBRet ret;
>>> +
>>> +    if (!env->guest) {
>>> +        return gpa;
>>> +    }
>>> +
>>> +    host_context.addr = gpa;
>>> +    host_context.tlb_index = -1;
>>> +    ret =
>>> +        loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD, retaddr);
>>> +    loongarch_try_ptw(env, &host_context, MMU_DATA_LOAD, MMU_KERNEL_IDX, &ret,
>>> +                      false, retaddr);
>>> +
>>> +    if (ret != TLBRET_HOST_MATCH) {
>>> +        raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
>>> +        cpu_loop_exit_restore(env_cpu(env), retaddr);
>>> +    }
>>> +
>>> +    return host_context.physical;
>>> +}
>>> +
>>>    target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>>>                              uint32_t level, uint32_t mem_idx)
>>>    {
>>> @@ -732,12 +998,15 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>>>            }
>>>        }
>>>    
>>> -    badvaddr = env->CSR_TLBRBADV;
>>> +    badvaddr = GET_CSR_IF(env->guest, TLBRBADV);
>>>        base = base & palen_mask;
>>> -    get_dir_base_width(env, &dir_base, &dir_width, level);
>>> +    get_dir_base_width(env, &dir_base, &dir_width, level, env->guest);
>>>        index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>>>        phys = base | index << 3;
>>> -    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
>>> +    val = address_space_ldq_le(
>>> +        cs->as,
>>> +        (env->guest ? loongarch_get_host_address(env, phys, GETPC()) : phys),
>>> +        MEMTXATTRS_UNSPECIFIED, NULL);
>> QEMU TLB is skipped with function loongarch_get_host_address(), I think
>> it should be used. Can it be changed something like this?
>> if (!env->guest) {
>>       val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
>> } else {
>>       val = cpu_ldq_data_ra(env, phys, GETPC());
>> }
>>
>> the same with ldpte().
>>
>> Regards
>> Bibo Mao
> phys is a GPA when in guest mode, loongarch_get_host_address finds the
> corresponding HPA and directly visits it. Does the mapped HPA have any
> difference in visiting method from phys in host mode?
> Regards
> SignKirigami
> 
>>>    
>>>        return val & palen_mask;
>>>    }
>>> @@ -749,8 +1018,10 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>        hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
>>>        uint64_t pte_raw;
>>>        uint64_t badv;
>>> -    uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>>> -    uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
>>> +    uint64_t ptbase =
>>> +        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTBASE);
>>> +    uint64_t ptwidth =
>>> +        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTWIDTH);
>>>        uint64_t palen_mask = loongarch_palen_mask(env);
>>>        uint64_t dir_base, dir_width;
>>>        uint8_t  ps;
>>> @@ -771,7 +1042,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>             * Move HGLOBAL bit to GLOBAL bit.
>>>             */
>>>            get_dir_base_width(env, &dir_base, &dir_width,
>>> -                           FIELD_EX64(base, TLBENTRY, LEVEL));
>>> +                           FIELD_EX64(base, TLBENTRY, LEVEL), env->guest);
>>>    
>>>            base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>>>            base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
>>> @@ -796,7 +1067,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>                return;
>>>            }
>>>        } else {
>>> -        badv = env->CSR_TLBRBADV;
>>> +        badv = GET_CSR_IF(env->guest, TLBRBADV);
>>>    
>>>            base = base & palen_mask;
>>>    
>>> @@ -805,26 +1076,31 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>>>            ptoffset0 = ptindex << 3;
>>>            ptoffset1 = (ptindex + 1) << 3;
>>>            phys = base | (odd ? ptoffset1 : ptoffset0);
>>> -        pte_raw = address_space_ldq_le(cs->as, phys,
>>> -                                       MEMTXATTRS_UNSPECIFIED, NULL);
>>> +        pte_raw = address_space_ldq_le(
>>> +            cs->as,
>>> +            (env->guest ? loongarch_get_host_address(env, phys, GETPC()) :
>>> +                          phys),
>>> +            MEMTXATTRS_UNSPECIFIED, NULL);
>>>            tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
>>>            ps = ptbase;
>>>        }
>>>    
>>>        if (odd) {
>>> -        env->CSR_TLBRELO1 = tmp0;
>>> +        SET_CSR_IF(env->guest, TLBRELO1, tmp0);
>>>        } else {
>>> -        env->CSR_TLBRELO0 = tmp0;
>>> +        SET_CSR_IF(env->guest, TLBRELO0, tmp0);
>>>        }
>>> -    env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
>>> +    SET_CSR_IF(
>>> +        env->guest, TLBREHI,
>>> +        FIELD_DP64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBREHI, PS, ps));
>>>    }
>>>    
>>>    static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
>>>                                          MMUContext *context,
>>>                                          MMUAccessType access_type, int index,
>>> -                                      int mmu_idx)
>>> +                                      int mmu_idx, bool guest)
>>>    {
>>> -    LoongArchTLB *tlb = &env->tlb[index];
>>> +    LoongArchTLB *tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>>>        uint8_t tlb_ps, n;
>>>    
>>>        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>>> @@ -832,19 +1108,20 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
>>>        context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
>>>        context->ps = tlb_ps;
>>>        context->tlb_index = index;
>>> -    return loongarch_check_pte(env, context, access_type, mmu_idx);
>>> +    return loongarch_check_pte(env, context, access_type, mmu_idx, guest);
>>>    }
>>>    
>>> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
>>> -                                   MMUContext *context,
>>> -                                   MMUAccessType access_type, int mmu_idx)
>>> +TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *context,
>>> +                                   MMUAccessType access_type, int mmu_idx,
>>> +                                   bool guest)
>>>    {
>>>        int index, match;
>>>    
>>> -    match = loongarch_tlb_search(env, context->addr, &index);
>>> +    match =
>>> +        loongarch_tlb_search(env, context->addr, &index, guest, get_tgid(env));
>>>        if (match) {
>>>            return loongarch_map_tlb_entry(env, context, access_type, index,
>>> -                                       mmu_idx);
>>> +                                       mmu_idx, guest);
>>>        }
>>>    
>>>        return TLBRET_NOMATCH;
>>>
>>
>>
> 
> 
> 


