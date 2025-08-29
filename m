Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A891CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN2f-0001Pe-91; Sat, 30 Aug 2025 10:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1urnr8-0003Mv-Ee
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:24:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1urnqk-0005uL-OT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:24:21 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxM9A4AbFo6WkEAA--.8931S3;
 Fri, 29 Aug 2025 09:24:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxvsE1AbFoXadvAA--.44266S3;
 Fri, 29 Aug 2025 09:24:07 +0800 (CST)
Subject: Re: [PATCH v4 03/19] target/loongarch: Set page size in TLB entry
 with STLB
To: Bibo Mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c23dea45-19c6-cd58-3fb0-617108ca73f2@loongson.cn>
Date: Fri, 29 Aug 2025 09:27:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250730030202.3425934-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxvsE1AbFoXadvAA--.44266S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF17Jw13WF1DKr1UuFyfuFX_yoWrWr4rpF
 W7Gw4DtFyqkrWkAF13tw4DKr1UZw4UCws7Xrs7GryF9Fn7Jrn7XFWDKwnIkry0q3y3AF47
 AF4kAryUuF13XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.357,
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

在 2025/7/30 上午11:01, Bibo Mao 写道:
> With VTLB different TLB entry may have different page size, and
> page size is set in PS field of TLB entry. However with STLB, all
> the TLB entries have the same page size, page size comes from register
> CSR_STLBPS, PS field of TLB entry is not used.
>
> Here PS field of TLB entry is used with all TLB entries, even with
> STLB. It is convenient with TLB maintainance operation.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 41 ++++++++-----------------------
>   1 file changed, 10 insertions(+), 31 deletions(-)
     Reviewed-by: Song Gao <gaosong@loongson.cn>
     Tested-by: Song Gao <gaosong@loongson.cn>


Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 8872593ff0..3ea0e153b1 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -110,11 +110,8 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>       if (!tlb_e) {
>           return;
>       }
> -    if (index >= LOONGARCH_STLB) {
> -        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> -    } else {
> -        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -    }
> +
> +    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
>       mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
>   
> @@ -173,11 +170,8 @@ static void fill_tlb_entry(CPULoongArchState *env, int index)
>           lo1 = env->CSR_TLBELO1;
>       }
>   
> -    /* Only MTLB has the ps fields */
> -    if (index >= LOONGARCH_STLB) {
> -        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
> -    }
> -
> +    /* Store page size in field PS */
> +    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
>       csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> @@ -283,12 +277,7 @@ void helper_tlbrd(CPULoongArchState *env)
>   
>       index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
>       tlb = &env->tlb[index];
> -
> -    if (index >= LOONGARCH_STLB) {
> -        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> -    } else {
> -        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -    }
> +    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>   
>       if (!tlb_e) {
> @@ -476,11 +465,8 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>           if (!tlb_e) {
>               continue;
>           }
> -        if (i >= LOONGARCH_STLB) {
> -            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> -        } else {
> -            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -        }
> +
> +        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>           tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>           vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>           compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
> @@ -509,11 +495,8 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>           if (!tlb_e) {
>               continue;
>           }
> -        if (i >= LOONGARCH_STLB) {
> -            tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> -        } else {
> -            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -        }
> +
> +        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>           tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>           vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>           compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
> @@ -673,11 +656,7 @@ static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>       uint64_t tlb_entry, tlb_ppn;
>       uint8_t tlb_ps, n, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
>   
> -    if (index >= LOONGARCH_STLB) {
> -        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> -    } else {
> -        tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -    }
> +    tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       n = (address >> tlb_ps) & 0x1;/* Odd or even */
>   
>       tlb_entry = n ? tlb->tlb_entry1 : tlb->tlb_entry0;


