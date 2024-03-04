Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36EFC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3lO-0003p0-R2; Mon, 04 Mar 2024 03:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rh3lL-0003l5-23
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:33:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rh3lH-0005EB-O0
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:33:30 -0500
Received: from loongson.cn (unknown [117.67.130.223])
 by gateway (Coremail) with SMTP id _____8CxrutMh+Vl_AAUAA--.50371S3;
 Mon, 04 Mar 2024 16:33:18 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.130.223])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxfs1Mh+VlGqtNAA--.8003S3; 
 Mon, 04 Mar 2024 16:33:16 +0800 (CST)
Subject: Re: [PATCH] Fixed tlb huge page loading issue
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20240228065552.365973-1-lixianglai@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <2f0716bd-27a3-0df5-922e-80d607ba69eb@loongson.cn>
Date: Mon, 4 Mar 2024 16:33:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20240228065552.365973-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxfs1Mh+VlGqtNAA--.8003S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4xXFW5CF4kCr1xZF45XFc_yoW5CrW5pF
 4xCr4xKFW5trZrtasxGayYvr1DXw4Ik3y7Wa1xtryFkw45Xr97XF4kt39IkF15J3y5Zr4x
 ZFnFvryUCa18XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.301,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Title 'target/loongarch: xxxx' ...

Thanks.
Song Gao
在 2024/2/28 14:55, Xianglai Li 写道:
> The lddir and ldpte instruction emulation has
> a problem with the use of large page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu.h            |  1 +
>   target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
>   2 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ec37579fd6..eab3e41c71 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -292,6 +292,7 @@ typedef struct CPUArchState {
>       uint32_t fcsr0_mask;
>   
>       uint32_t cpucfg[21];
> +    uint32_t lddir_ps;
>   
>       uint64_t lladdr; /* LL virtual address compared against SC */
>       uint64_t llval;
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index a08c08b05a..3594c800b3 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -38,6 +38,7 @@ static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
>               cs->exception_index = EXCCODE_PIF;
>           }
>           env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
> +        env->lddir_ps = 0;
>           break;
>       case TLBRET_INVALID:
>           /* TLB match with no valid bit */
> @@ -488,13 +489,6 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>       uint64_t dir_base, dir_width;
>       bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
>   
> -    badvaddr = env->CSR_TLBRBADV;
> -    base = base & TARGET_PHYS_MASK;
> -
> -    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> -    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> -    shift = (shift + 1) * 3;
> -
>       if (huge) {
>           return base;
>       }
> @@ -519,9 +513,18 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>           do_raise_exception(env, EXCCODE_INE, GETPC());
>           return 0;
>       }
> +
> +    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> +    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> +    shift = (shift + 1) * 3;
> +    badvaddr = env->CSR_TLBRBADV;
> +    base = base & TARGET_PHYS_MASK;
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>       phys = base | index << shift;
>       ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
> +    if (ret & BIT_ULL(LOONGARCH_PAGE_HUGE_SHIFT)) {
> +        env->lddir_ps = dir_base;
> +    }
>       return ret;
>   }
>   
> @@ -538,13 +541,13 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       base = base & TARGET_PHYS_MASK;
>   
>       if (huge) {
> -        /* Huge Page. base is paddr */
>           tmp0 = base ^ (1 << LOONGARCH_PAGE_HUGE_SHIFT);
>           /* Move Global bit */
>           tmp0 = ((tmp0 & (1 << LOONGARCH_HGLOBAL_SHIFT))  >>
>                   LOONGARCH_HGLOBAL_SHIFT) << R_TLBENTRY_G_SHIFT |
>                   (tmp0 & (~(1 << LOONGARCH_HGLOBAL_SHIFT)));
> -        ps = ptbase + ptwidth - 1;
> +
> +        ps = env->lddir_ps - 1;
>           if (odd) {
>               tmp0 += MAKE_64BIT_MASK(ps, 1);
>           }


