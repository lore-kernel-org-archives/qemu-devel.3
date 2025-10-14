Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D7DCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b3b-00029R-91; Tue, 14 Oct 2025 05:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v8b3Y-00029E-K7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:10:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v8b3V-00017w-B9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:10:56 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bxnr+YE+5oXfMVAA--.45444S3;
 Tue, 14 Oct 2025 17:10:48 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxXMGVE+5o5U_hAA--.51312S3;
 Tue, 14 Oct 2025 17:10:48 +0800 (CST)
Subject: Re: [PATCH 1/2] target/loongarch: Add missing TLB flush with
 different asid
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251009025932.2990219-1-maobibo@loongson.cn>
 <20251009025932.2990219-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <cf157e3d-9d06-6efe-806c-a49aa72b894c@loongson.cn>
Date: Tue, 14 Oct 2025 17:10:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251009025932.2990219-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxXMGVE+5o5U_hAA--.51312S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF18ur1UAF4kGw4DWrykWFX_yoW8ZF43pr
 W7C34ktF9rCrW8AF4ft3yFgr17Z3y8Cws7XrsxGryrXrn3Jrn7WFWktws0krW0y3W3AF47
 ZF40yry8uFy3XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.658, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2025/10/9 ÉÏÎç10:59, Bibo Mao Ð´µÀ:
> If asid is changed in function helper_csrwr_asid(), qemu TLB is flushed,
> however loongArch TLB is still valid. So loongArch TLB need be invalidated
> in function invalidate_tlb() with different asid and bit effective need
> be cleared.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
Signed-off-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 8cfce48a29..f8fada5b9a 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -117,13 +117,7 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>       uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
>       uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
>       uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> -    uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>   
> -    if (!tlb_e) {
> -        return;
> -    }
> -
> -    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>       tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       pagesize = MAKE_64BIT_MASK(tlb_ps, 1);
>       mask = MAKE_64BIT_MASK(0, tlb_ps + 1);
> @@ -145,11 +139,19 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
>   {
>       LoongArchTLB *tlb;
>       uint16_t csr_asid, tlb_asid, tlb_g;
> +    uint8_t tlb_e;
>   
>       csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
>       tlb = &env->tlb[index];
> +    tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
> +    if (!tlb_e) {
> +        return;
> +    }
> +
> +    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>       tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>       tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> +    /* QEMU TLB is flushed when asid is changed */
>       if (tlb_g == 0 && tlb_asid != csr_asid) {
>           return;
>       }


