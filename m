Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF3BC27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 03:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJPb8-00006C-TB; Mon, 17 Jun 2024 23:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJPb4-00005Y-1G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 23:33:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJPb0-0005mQ-To
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 23:33:25 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxW+r9_3Bmu8wHAA--.31456S3;
 Tue, 18 Jun 2024 11:33:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08T6_3BmsscmAA--.17714S3; 
 Tue, 18 Jun 2024 11:33:16 +0800 (CST)
Subject: Re: [PATCH 18/18] tcg/loongarch64: Enable v256 with LASX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-19-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <21971ec6-751c-7353-3697-8a1f2f9371d1@loongson.cn>
Date: Tue, 18 Jun 2024 11:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx08T6_3BmsscmAA--.17714S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWDKr1fGw48ZFW7XrWxKrX_yoW8ury8p3
 s7Awn8JrW0vFZ7CrW3G3WUXr1kJrnxu3Wj9F1xGws3CwsIyryUXr18tay7XFyI93W8uFWa
 va4v9w1SvF4qkagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
 WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.388, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/5/28 ÉÏÎç5:19, Richard Henderson Ð´µÀ:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   tcg/loongarch64/tcg-target.c.inc | 11 ++++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
> index 990bad1d51..58bd7d258e 100644
> --- a/tcg/loongarch64/tcg-target.h
> +++ b/tcg/loongarch64/tcg-target.h
> @@ -173,7 +173,7 @@ typedef enum {
>   
>   #define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
>   #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
> -#define TCG_TARGET_HAS_v256             0
> +#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
>   
>   #define TCG_TARGET_HAS_not_vec          1
>   #define TCG_TARGET_HAS_neg_vec          1
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index e2b5aad5e3..0b41b807e3 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -2484,9 +2484,14 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
>   
> -    if (cpuinfo & CPUINFO_LSX) {
> -        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> -        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +    if (cpuinfo & (CPUINFO_LSX | CPUINFO_LASX)) {
> +        if (cpuinfo & CPUINFO_LSX) {
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +        }
> +        if (cpuinfo & CPUINFO_LASX) {
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
> +        }
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V26);


