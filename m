Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E72EA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPJQ-0001Mz-Qb; Sun, 08 Mar 2026 21:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vzPJL-0001MC-VP; Sun, 08 Mar 2026 21:21:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1vzPJI-0006RF-UP; Sun, 08 Mar 2026 21:21:31 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx08CLIK5pacMYAA--.14620S3;
 Mon, 09 Mar 2026 09:21:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxzsKGIK5pkfpQAA--.22829S3;
 Mon, 09 Mar 2026 09:21:12 +0800 (CST)
Subject: Re: [PATCH v2 1/2] target/loongarch: Preserve PTE permission bits in
 LDPTE
To: "Andrew S. Rightenburg" <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, qemu-stable@nongnu.org
References: <20260306073355.899858-1-andrew@rail5.org>
 <20260306073355.899858-2-andrew@rail5.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ca0c1c76-2448-7bc8-7819-7cd660ba4e0f@loongson.cn>
Date: Mon, 9 Mar 2026 09:18:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260306073355.899858-2-andrew@rail5.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxzsKGIK5pkfpQAA--.22829S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF4xuw13XF15Cr4fCFy8WFX_yoW7ArWfpr
 Z7Cr4ayF48trZrJas3u3WYqrn8Xr1fGw4Iqa1SkryFk3y3Jr18ur4kt39FqF48Jw45Gw40
 vF45Zr4UuF47X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.101,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



On 2026/3/6 下午3:33, Andrew S. Rightenburg via qemu development wrote:
> From: rail5 <andrew@rail5.org>
> 
> The LDPTE helper loads a page table entry (or huge page entry) from guest
> memory and currently applies the PALEN mask to the whole 64-bit value.
> 
> That mask is intended to constrain the physical address bits, but masking
> the full entry also clears upper permission bits in the PTE, including NX
> (bit 62). As a result, LoongArch TCG can incorrectly allow instruction
> fetches from NX mappings when translation is driven through software
> page-walk.
> 
> Fix this by masking only the PPN/address field with PALEN while preserving
> permission bits, and by clearing any non-architectural (software) bits
> using a hardware PTE mask. LDDIR is unchanged since it returns the base
> address of the next page table level.
> 
> Reported at: https://gitlab.com/qemu-project/qemu/-/issues/3319
> 
> Fixes: 56599a705f2 ("target/loongarch: Introduce loongarch_palen_mask()")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
> ---
>   target/loongarch/cpu.c            | 11 +++++++++++
>   target/loongarch/cpu.h            |  1 +
>   target/loongarch/tcg/tlb_helper.c | 25 ++++++++++++++++++++++---
>   3 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 8e8b10505d..e22568c84a 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -596,6 +596,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   
>   #ifdef CONFIG_TCG
>       env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
> +
> +    if (is_la64(env)) {
> +        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
> +                           R_TLBENTRY_64_PPN_MASK |
> +                           R_TLBENTRY_64_NR_MASK |
> +                           R_TLBENTRY_64_NX_MASK |
> +                           R_TLBENTRY_64_RPLV_MASK;
> +    } else {
> +        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
> +                           R_TLBENTRY_32_PPN_MASK;
> +    }
>   #endif
>       env->fcsr0 = 0x0;
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index d2dfdc8520..4d333806ed 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -406,6 +406,7 @@ typedef struct CPUArchState {
>       uint64_t llval;
>       uint64_t llval_high; /* For 128-bit atomic SC.Q */
>       uint64_t llbit_scq; /* Potential LL.D+LD.D+SC.Q sequence in effect */
> +    uint64_t hw_pte_mask; /* Mask of architecturally-defined (hardware) PTE bits. */
>   #endif
>   #ifndef CONFIG_USER_ONLY
>   #ifdef CONFIG_TCG
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index c1dc77a8f8..6581b3b898 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -686,6 +686,21 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       cpu_loop_exit_restore(cs, retaddr);
>   }
>   
> +static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
> +                                                 uint64_t pte)
> +{
> +    uint64_t palen_mask = loongarch_palen_mask(env);
> +    uint64_t ppn_mask = is_la64(env) ? R_TLBENTRY_64_PPN_MASK : R_TLBENTRY_32_PPN_MASK;
> +
> +    /*
> +     * Keep only architecturally-defined PTE bits. Guests may use some
> +     * otherwise-unused bits for software purposes.
> +     */
> +    pte &= env->hw_pte_mask;
> +
> +    return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
> +}
> +
>   target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>                             uint32_t level, uint32_t mem_idx)
>   {
> @@ -729,6 +744,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>   {
>       CPUState *cs = env_cpu(env);
>       hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
> +    uint64_t pte_raw;
>       uint64_t badv;
>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> @@ -744,7 +760,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>        * and the other is the huge page entry,
>        * whose bit 6 should be 1.
>        */
> -    base = base & palen_mask;
>       if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>           /*
>            * Gets the huge page level and Gets huge page size.
> @@ -768,10 +783,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>            * when loaded into the tlb,
>            * so the tlb page size needs to be divided by 2.
>            */
> -        tmp0 = base;
> +        tmp0 = loongarch_sanitize_hw_pte(env, base);
>           if (odd) {
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
>           }
> +        tmp0 = loongarch_sanitize_hw_pte(env, tmp0);
Hi Andrew,

I think that duplicated calling with loongarch_sanitize_hw_pte() is 
unnecessary, the other looks good to me.

Thanks for doing this.
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>   
>           if (!check_ps(env, ps)) {
>               qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %d\n", ps);
> @@ -780,12 +796,15 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       } else {
>           badv = env->CSR_TLBRBADV;
>   
> +        base = base & palen_mask;
> +
>           ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
>           ptindex = ptindex & ~0x1;   /* clear bit 0 */
>           ptoffset0 = ptindex << 3;
>           ptoffset1 = (ptindex + 1) << 3;
>           phys = base | (odd ? ptoffset1 : ptoffset0);
> -        tmp0 = ldq_le_phys(cs->as, phys) & palen_mask;
> +        pte_raw = ldq_le_phys(cs->as, phys);
> +        tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
>           ps = ptbase;
>       }
>   
> 


