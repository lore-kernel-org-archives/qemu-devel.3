Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31017E77197
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 02:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVLe0-0004h7-Aq; Tue, 07 Jan 2025 21:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tVLdx-0004gw-4n
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:18:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tVLdu-0007mb-0c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:18:00 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxieFQ4H1nkr1fAA--.60530S3;
 Wed, 08 Jan 2025 10:17:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxXMVN4H1nywcZAA--.40551S3;
 Wed, 08 Jan 2025 10:17:51 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Only support 64bit pte width
From: bibo mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, Miao Hao <haomiao23s@ict.ac.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241231100718.2314306-1-maobibo@loongson.cn>
Message-ID: <144e2399-7fcb-5750-49e8-0344b766dee5@loongson.cn>
Date: Wed, 8 Jan 2025 10:18:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241231100718.2314306-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxXMVN4H1nywcZAA--.40551S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr43trWUCw4rKrWrKFyrXwc_yoW7Wr4fpF
 WxC39akFWUtFZ2y3Z3Wa4agr15Xw4jkw4Iqa1Iyry8AwsxJrykXr48tr9xKF1DJw43Xr4F
 v3Z2vry8ZayxX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
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
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.594,
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



On 2024/12/31 下午6:07, Bibo Mao wrote:
> With manual pte width can be 64bit, 128bit or more. Instead real
> hardware only supports 64bit pte width. For 12bit pte, there is
> no detail definition for all 128bit from manual.
> 
> Here only 64bit pte width is supported for simplicity, will add
> this in later if real hw support it and there is definition for
> all the bits from manual.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/helper.h                     |  1 +
>   target/loongarch/tcg/csr_helper.c             | 21 +++++++++++++++++++
>   .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>   target/loongarch/tcg/tlb_helper.c             | 17 +++------------
>   4 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index b3b64a0215..943517b5f2 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -104,6 +104,7 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> +DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_h, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_w, i64, env, tl)
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 15f94caefa..5d43b4f2cb 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "cpu.h"
>   #include "internals.h"
> @@ -95,3 +96,23 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>       }
>       return old_v;
>   }
> +
> +target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
> +{
> +    int shift;
> +    int64_t old_v = env->CSR_PWCL;
> +
> +    /*
> +     * The real ardware only supports 64bit PTE width now, 128bit or others
Typo ardware  --> hardware

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

Regards
Bibo Mao
> +     * treated as illegal.
> +     */
> +    shift = FIELD_EX64(val, CSR_PWCL, PTEWIDTH);
> +    if (shift) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Attempted set pte width with %d bit\n", 64 << shift);
> +        val = FIELD_DP64(val, CSR_PWCL, PTEWIDTH, 0);
> +    }
> +
> +    env->CSR_PWCL = val;
> +    return old_v;
> +}
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 7e4ec93edb..30f9b83fb2 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -95,7 +95,7 @@ static const CSRInfo csr_info[] = {
>       CSR_OFF(PGDL),
>       CSR_OFF(PGDH),
>       CSR_OFF_FUNCS(PGD, CSRFL_READONLY, gen_helper_csrrd_pgd, NULL),
> -    CSR_OFF(PWCL),
> +    CSR_OFF_FUNCS(PWCL, 0, NULL, gen_helper_csrwr_pwcl),
>       CSR_OFF(PWCH),
>       CSR_OFF(STLBPS),
>       CSR_OFF(RVACFG),
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 97f38fc391..8c61fe728c 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -512,7 +512,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>   {
>       CPUState *cs = env_cpu(env);
>       target_ulong badvaddr, index, phys, ret;
> -    int shift;
>       uint64_t dir_base, dir_width;
>   
>       if (unlikely((level == 0) || (level > 4))) {
> @@ -537,14 +536,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>   
>       badvaddr = env->CSR_TLBRBADV;
>       base = base & TARGET_PHYS_MASK;
> -
> -    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> -    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> -    shift = (shift + 1) * 3;
> -
>       get_dir_base_width(env, &dir_base, &dir_width, level);
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
> -    phys = base | index << shift;
> +    phys = base | index << 3;
>       ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
>       return ret;
>   }
> @@ -554,7 +548,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>   {
>       CPUState *cs = env_cpu(env);
>       target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
> -    int shift;
>       uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
>       uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
>       uint64_t dir_base, dir_width;
> @@ -595,16 +588,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
>           }
>       } else {
> -        /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> -        shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> -        shift = (shift + 1) * 3;
>           badv = env->CSR_TLBRBADV;
>   
>           ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
>           ptindex = ptindex & ~0x1;   /* clear bit 0 */
> -        ptoffset0 = ptindex << shift;
> -        ptoffset1 = (ptindex + 1) << shift;
> -
> +        ptoffset0 = ptindex << 3;
> +        ptoffset1 = (ptindex + 1) << 3;
>           phys = base | (odd ? ptoffset1 : ptoffset0);
>           tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
>           ps = ptbase;
> 
> base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
> 


