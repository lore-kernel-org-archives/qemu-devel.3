Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BA5C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 07:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toHT6-0001CZ-4M; Sat, 01 Mar 2025 02:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1toHT2-0001CN-9E
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:41:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1toHSx-0005lg-RP
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:40:59 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxNHABusJnnOSGAA--.34194S3;
 Sat, 01 Mar 2025 15:40:49 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzMT+ucJnykEvAA--.42630S3;
 Sat, 01 Mar 2025 15:40:48 +0800 (CST)
Subject: Re: [PATCH v5 2/2] target/loongarch: check tlb_ps
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn,
 wangliupu@loongson.cn
References: <20250228090659.2434568-1-gaosong@loongson.cn>
 <20250228090659.2434568-3-gaosong@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <f47a50ad-3635-3b61-1401-d9791a06594c@loongson.cn>
Date: Sat, 1 Mar 2025 15:40:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250228090659.2434568-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMT+ucJnykEvAA--.42630S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3KFyxAw47Xr1DZrWUKF48AFc_yoWDZr13pF
 W7CrZFkFWUGrWkA3Wft3WYkw1DZw48Gws2va1fK34FkrsxXr97XFWvg3sF9F1kJw45CF4x
 ZF1qvryUZFW3XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.651,
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



On 2025/2/28 下午5:06, Song Gao wrote:
> For LoongArch th min tlb_ps is 12(4KB), for TLB code,
> the tlb_ps may be 0,this may case UndefinedBehavior
> Add a check-tlb_ps fuction to check tlb_ps,
> to make sure the tlb_ps is avalablie. we check tlb_ps
> when get the tlb_ps from tlb->misc or CSR bits.
> 1. cpu reset
>     set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits a default value
>     from CSR_PRCFG2;
> 2. tlb instructions.
>     some tlb instructions get  the tlb_ps from tlb->misc but the
>     value may  has been initialized to 0. we need just check the tlb_ps
>     skip the function and write a guest log.
> 3. csrwr instructions.
>     to make sure CSR_PWCL.PTBASE and CSR_STLBPS.PS bits are avalable,
>     cheke theses bits and set a default value from CSR_PRCFG2.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c                        | 10 ++--
>   target/loongarch/cpu_helper.c                 |  8 +++-
>   target/loongarch/helper.h                     |  1 +
>   target/loongarch/internals.h                  |  2 +
>   target/loongarch/tcg/csr_helper.c             | 30 +++++++++++-
>   .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
>   target/loongarch/tcg/tlb_helper.c             | 46 ++++++++++++++++++-
>   7 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e91f4a5239..162a227d52 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -585,13 +585,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>        */
>       env->CSR_PGDH = 0;
>       env->CSR_PGDL = 0;
> -    env->CSR_PWCL = 0;
>       env->CSR_PWCH = 0;
> -    env->CSR_STLBPS = 0;
>       env->CSR_EENTRY = 0;
>       env->CSR_TLBRENTRY = 0;
>       env->CSR_MERRENTRY = 0;
> -
> +    /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
> +    if (env->CSR_PRCFG2 == 0) {
> +        env->CSR_PRCFG2 =0x3fffff000;
> +    }
> +    int tlb_ps = clz32(env->CSR_PRCFG2);
Could you please put variable declaration "int tlb_ps" to header of 
function?

> +    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
> +    env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
>       for (n = 0; n < 4; n++) {
>           env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
>           env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV1, 0);
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 930466ca48..a81a610a1d 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -117,7 +117,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>                   *index = i * 256 + stlb_idx;
>                   return true;
>               }
> -        }
> +        } else {
> +	    continue;
> +	}
There is tab key in the line.
It it unnecessary to add else sentence, since it is the end of loop already.
>       }
>   
>       /* Search MTLB */
> @@ -136,7 +138,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>                   *index = i;
>                   return true;
>               }
> -        }
> +        } else {
> +	    continue;
> +	}
Ditto
>       }
>       return false;
>   }
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index 943517b5f2..1d5cb0198c 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -100,6 +100,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   DEF_HELPER_1(csrrd_pgd, i64, env)
>   DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
> +DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 7b254c5f49..1cd959a766 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -43,6 +43,8 @@ enum {
>       TLBRET_PE = 7,
>   };
>   
> +bool check_ps(CPULoongArchState *ent, int ps);
> +
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 6c95be9910..1c8a234b16 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -17,6 +17,27 @@
>   #include "hw/irq.h"
>   #include "cpu-csr.h"
>   
> +
> +
> +target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->CSR_STLBPS;
> +    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
> +
> +    /*
> +     * The real hardware only supports the min tlb_ps is 12
> +     * tlb_ps=0 may cause undefined-behavior.
> +     */
> +    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> +    if (!check_ps(env, tlb_ps)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Attempted set ps %d\n",tlb_ps);
> +        val = FIELD_DP64(val, CSR_STLBPS, PS, default_ps);
> +    }
> +    env->CSR_STLBPS = val;
> +    return old_v;
> +}
> +
>   target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>   {
>       int64_t v;
> @@ -99,19 +120,26 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>   
>   target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>   {
> -    int shift;
> +    int shift, ptbase;
>       int64_t old_v = env->CSR_PWCL;
> +    uint8_t default_ps = ctz32(env->CSR_PRCFG2);
>   
>       /*
>        * The real hardware only supports 64bit PTE width now, 128bit or others
>        * treated as illegal.
>        */
>       shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
> +    ptbase = FIELD_EX64(val, CSR_PWCL, PTBASE);
>       if (shift) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "Attempted set pte width with %d bit\n", 64 << shift);
>           val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
>       }
> +    if (!check_ps(env, ptbase)) {
> +         qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Attrmpted set ptbase 2^%d\n", ptbase);
> +         val = FIELD_DP64(val, CSR_PWCL, PTBASE, default_ps);
> +    }
>   
>       env->CSR_PWCL = val;
>       return old_v;
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 3afa23af79..ecbfe23b63 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -74,6 +74,7 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>   
>   void loongarch_csr_translate_init(void)
>   {
> +    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr_stlbps);
>       SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
>       SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
>       SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 1c603b2903..27f0653a5a 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -18,6 +18,14 @@
>   #include "exec/log.h"
>   #include "cpu-csr.h"
>   
> +bool check_ps(CPULoongArchState *env, int tlb_ps)
> +{
> +     if(tlb_ps > 64){
Space key is missing here.
> +         return false;
> +     }
> +     return BIT_ULL(tlb_ps) && (env->CSR_PRCFG2);
Is it BIT_ULL(tlb_ps) & (env->CSR_PRCFG2) rather than && ?
> +}
> +
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>                                  uint64_t *dir_width, target_ulong level)
>   {
> @@ -123,12 +131,21 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>       uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
>       uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
>       uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> +    uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
> +
> +    if (!tlb_e){
> +        return;
> +    }
>   
>       if (index >= LOONGARCH_STLB) {
>           tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       } else {
>           tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
>       }
> +    if (!check_ps(env,tlb_ps)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
> +        return;
> +    }
>       pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
>       mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
>   
> @@ -187,8 +204,10 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
>           lo1 = env->CSR_TLBELO1;
>       }
>   
> -    if (csr_ps == 0) {
> -        qemu_log_mask(CPU_LOG_MMU, "page size is 0\n");
> +    /*check csr_ps */
> +    if (!check_ps(env, csr_ps)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "csr_ps %d is illegal\n", csr_ps);
> +        return;
>       }
>   
>       /* Only MTLB has the ps fields */
> @@ -249,6 +268,10 @@ void helper_tlbrd(CPULoongArchState *env)
>       }
>       tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>   
> +    if (!check_ps(env, tlb_ps)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
> +        return;
> +    }
Why add check_ps() here? I think it should be added only in TLB adding, 
not necessary in tlb invalid and search funciton.

>       if (!tlb_e) {
>           /* Invalid TLB entry */
>           env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
> @@ -298,7 +321,16 @@ void helper_tlbfill(CPULoongArchState *env)
>           pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
>       }
>   
> +    if (!check_ps(env, pagesize)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "pagesize %d is illegal\n", pagesize);
> +        return;
> +    }
> +
>       stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> +    if (!check_ps(env, stlb_ps)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "stlb_ps %d is illegal\n", stlb_ps);
> +        return;
> +    }
>   
>       if (pagesize == stlb_ps) {
>           /* Only write into STLB bits [47:13] */
> @@ -437,6 +469,10 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>           } else {
>               tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
>           }
> +        if (!check_ps(env, tlb_ps)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
> +            return;
> +        }
Do we need adding check_ps() in function helper_invtlb_page_asid()?
Since CSR_STLBPS cannot be changed dynamically when mmu is on.

Regards
Bibo Mao

>           tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>           vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>           compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
> @@ -470,6 +506,12 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>           } else {
>               tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
>           }
> +        if (!check_ps(env, tlb_ps)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "tlb_ps %d is illegal\n", tlb_ps);
> +            return;
> +        }
> +
> +
>           tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>           vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>           compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
> 


