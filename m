Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72555F513F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMUc-0004GR-AR; Thu, 05 Mar 2026 23:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vyMUY-0004Ft-6Y; Thu, 05 Mar 2026 23:08:47 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1vyMUW-0000eg-1U; Thu, 05 Mar 2026 23:08:45 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx36tGU6ppYwoYAA--.12804S3;
 Fri, 06 Mar 2026 12:08:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxXcJBU6pp6kFPAA--.16843S3;
 Fri, 06 Mar 2026 12:08:35 +0800 (CST)
Subject: Re: [PATCH 1/2] target/loongarch: Preserve PTE permission bits in
 LDDIR/LDPTE
To: "Andrew S. Rightenburg" <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, qemu-stable@nongnu.org
References: <20260305135403.831693-1-andrew@rail5.org>
 <20260305135403.831693-2-andrew@rail5.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <cf6c2571-129d-84a7-1684-2446e3daca62@loongson.cn>
Date: Fri, 6 Mar 2026 12:05:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260305135403.831693-2-andrew@rail5.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxXcJBU6pp6kFPAA--.16843S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr43ZrW7tF43Jry3Jr1DJwc_yoWrZw4DpF
 WfCr13CF4rKrZrA3Z3u3WqgFyrZws7Cw1rXF4IkrySy3y5Jr1ku3yUt39xtF48JwsxZw45
 ZrsrZa1Dua4xZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.337,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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



On 2026/3/5 下午9:54, Andrew S. Rightenburg via qemu development wrote:
> From: rail5 <andrew@rail5.org>
> 
> The LDDIR/LDPTE helpers load a page table entry (or huge page entry)
> from guest memory and currently apply the PALEN mask to the whole
> 64-bit value.
> 
> That mask is intended to constrain the physical address bits, but masking
> the full entry also clears permission bits in the upper part of the PTE,
> including NX (bit 62). As a result, LoongArch TCG can incorrectly allow
> instruction fetches from NX mappings when translation is driven through
> these helpers.
Good catch.
yeap, it is actually one problem, the upper HW PTE bits are lost.

> 
> Mask only the PPN/address field and preserve the rest of the PTE.
> 
> This was reported as a bug at:
> https://gitlab.com/qemu-project/qemu/-/issues/3319
> 
> Fixes: 56599a705f2 ("target/loongarch: Introduce loongarch_palen_mask()")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
> ---
>   target/loongarch/tcg/tlb_helper.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index c1dc77a8f8..8747fa2a0f 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -686,6 +686,24 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       cpu_loop_exit_restore(cs, retaddr);
>   }
>   
> +static inline uint64_t loongarch_mask_pte_ppn(CPULoongArchState *env,
> +                                              uint64_t pte)
> +{
> +    uint64_t palen_mask = loongarch_palen_mask(env);
> +
> +    if (is_la64(env)) {
> +        uint64_t ppn_bits = pte & MAKE_64BIT_MASK(12, 36);
> +        uint64_t ppn_masked = ppn_bits & palen_mask;
> +
> +        return (pte & ~MAKE_64BIT_MASK(12, 36)) | ppn_masked;
value 36 is hard-code, also I think software PTE bit should be cleared.
how about add HW PTE mask element in structure CPULoongArchState?

> +    } else {
> +        uint64_t ppn_bits = pte & MAKE_64BIT_MASK(8, 24);
> +        uint64_t ppn_masked = ppn_bits & palen_mask;
> +
> +        return (pte & ~MAKE_64BIT_MASK(8, 24)) | ppn_masked;
> +    }
> +}
> +
>   target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>                             uint32_t level, uint32_t mem_idx)
>   {
> @@ -721,7 +739,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       get_dir_base_width(env, &dir_base, &dir_width, level);
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>       phys = base | index << 3;
> -    return ldq_le_phys(cs->as, phys) & palen_mask;
> +    return loongarch_mask_pte_ppn(env, ldq_le_phys(cs->as, phys));
I think that it is not needed with lddir() API, lddir returns physical 
address of page table without PTE permission. only helper_ldpte() need 
modification.

Regards
Bibo Mao

>   }
>   
>   void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
> @@ -729,6 +747,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>   {
>       CPUState *cs = env_cpu(env);
>       hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
> +    uint64_t pte_raw;
>       uint64_t badv;
>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> @@ -744,7 +763,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>        * and the other is the huge page entry,
>        * whose bit 6 should be 1.
>        */
> -    base = base & palen_mask;
>       if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>           /*
>            * Gets the huge page level and Gets huge page size.
> @@ -768,7 +786,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>            * when loaded into the tlb,
>            * so the tlb page size needs to be divided by 2.
>            */
> -        tmp0 = base;
> +        tmp0 = loongarch_mask_pte_ppn(env, base);
>           if (odd) {
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
>           }
> @@ -780,12 +798,15 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
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
> +        tmp0 = loongarch_mask_pte_ppn(env, pte_raw);
>           ps = ptbase;
>       }
>   
> 


