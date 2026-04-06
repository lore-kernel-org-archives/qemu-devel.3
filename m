Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A5FFB5173
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9shc-00018e-1q; Mon, 06 Apr 2026 18:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9shN-00015g-Uo
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:45:42 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9shM-0002wy-4d
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:45:37 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c76cce85bd9so1530667a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775515534; x=1776120334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isU/9rkBR2Zvj85QTV3GjBWwJH0kcHd+ROtIMxoNOPE=;
 b=PkoryWgqlG7MANHKPux08+e9LULNTMrpsEu+B0v805Qmw0BxM7Tg/JSO6FYpgukh3U
 nkKPseT/6fuSQCTdfb7qhkdZSVurksKM0ftwLTAuroQ5RWEBMfvlJ9ZbdVlKKsEvDM3P
 RhTKATNFICDy/dc0Cvp0RrVSKydDAmgBbJpzxBBQE8KFN2Y1WnQ29cGmmhdGXRyJyzgV
 GrrBrQYy5ovdUmLremNneYqOkYeQanQfhKxanEW74OXPk/LRQL5Vj2a3wvujqy2+27K8
 1gCp07bdeK1i5ILbHtDXpQCCXNs/dFCnQ92pBKdHCL6aBKIdkcHXy/1C0D/48aDz+fxb
 VCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775515534; x=1776120334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isU/9rkBR2Zvj85QTV3GjBWwJH0kcHd+ROtIMxoNOPE=;
 b=PQ0p/d+D53g7CHRE95Vp4/2lRPhIUimNogs4nQn5/fp/I0/6+y5StpYe7N3fxBXTP2
 vG9EAJB6iLjk2ROFT+1zzjsuUS2qkOwlarTjW3kWiy8VJAF2aHScQ5U0WNwIFJdmueFf
 yuFvwT1VMA1TrZsEFzJAniAtXsyHa9W3k1SEC+PhFzwRtFBOkd9EaylRCEpkPMTEOx4l
 3vsYxXnhpqYB3dfieYObELsHHBf6A0FPoOztXLbgrULLfsS45oBrSvyKvRDo1MiHY3li
 Wzro9Z3BEoS/1951ETFRn+XwnJq9whoRIqGA29kNImy8VeS/IL4Fwsuvo0x19iCnYoyW
 51Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzqRfL4GV0PMdTSDb/DnUhtQamdfpuWJBwUGWbNix0RNiE6IKv75+R7wHDCCvGdtGtvKZwtPKvdOAV@nongnu.org
X-Gm-Message-State: AOJu0YwPW/g/lkJ/7x2LretW8B+xGgGNW0wxV3v2mV26pEovz3QoeZ2T
 N1zi0croMb+9Ena/f1hjrrP3JMBkNg3+1TqDohRlt/ZiQ8UFwL1aDOBoGIR6M6kjcT4lQXbPB8D
 DakfUPqY=
X-Gm-Gg: AeBDievtqOydC1uvNRfq878VkMfVv7oTpccM0HbsAMDJ92qelKKYi9xRcFoGdVbW1yt
 57vwbuKi1k/8t+zAmQa3KCGIxM1gznHD6XfC6FFv6YEZcKoSv9Z2AVD5ElmSr6fbJg22S/qIsS2
 bStu5y9Zh9VG8RqMVfG4a1tykL2stQ7l7GCH1wScqieD5m7VHWmDIFPhFBXCLMbLDfN23JmopC9
 M7SnREbxQm4i/TnbvSiiimP0AMzNCs8HFM0g1n4HQWCWaV5fTXIeizLK0G6PRTYPjV7B97cYwTk
 +YPPbLTN2YkO0bXaykylyfRWzWZJTp8uA55PswLnWQKGOuTkch/Sk2MJ2A7PlfW8k8YlhNWIRLB
 p4nSQqU4d9xji8sY+A560RJAFJ+L7QLe2RPTWXq8bg2H5QFIbA/xUEYZ7AZwjxZHl4Tc17Tx+4j
 Uifcf1DNcWpOKBwoDRsndNbHS/DvxpUIfhVxdVEzuRUMio45K5SBxC3j3oU3H16DzD0VA=
X-Received: by 2002:a05:6a21:3283:b0:398:8870:b531 with SMTP id
 adf61e73a8af0-39f2edfd270mr14195238637.14.1775515534365; 
 Mon, 06 Apr 2026 15:45:34 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c657e5f3sm12831232a12.23.2026.04.06.15.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:45:34 -0700 (PDT)
Message-ID: <fa336642-d1b7-42e9-955e-440baae09974@linaro.org>
Date: Tue, 7 Apr 2026 08:45:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/20] target/arm/tcg/translate.c: remove TARGET_AARCH64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-20-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> We extract aarch64_translate_code function, and stub it accordingly.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/internals.h         |  2 ++
>   target/arm/tcg/stubs32.c       |  7 +++++++
>   target/arm/tcg/translate-a64.c |  8 ++++++++
>   target/arm/tcg/translate.c     | 19 ++++++++-----------
>   4 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 8ec27508473..2850edcb198 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -381,6 +381,8 @@ void arm_init_cpreg_list(ARMCPU *cpu);
>   
>   void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
>   void arm_translate_init(void);
> +void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
> +                            int *max_insns, vaddr pc, void *host_pc);
>   void arm_translate_code(CPUState *cs, TranslationBlock *tb,
>                           int *max_insns, vaddr pc, void *host_pc);
>   
> diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
> index c5a0bc61f47..3945dc49e5e 100644
> --- a/target/arm/tcg/stubs32.c
> +++ b/target/arm/tcg/stubs32.c
> @@ -3,6 +3,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "target/arm/internals.h"
>   #include "target/arm/tcg/translate.h"
>   
>   
> @@ -15,3 +16,9 @@ void a64_translate_init(void)
>   {
>       /* Don't initialize for 32 bits. Call site will be fixed later. */
>   }
> +
> +void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
> +                            int *max_insns, vaddr pc, void *host_pc)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index ebab9f36f08..db3990576c0 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10948,3 +10948,11 @@ const TranslatorOps aarch64_translator_ops = {
>       .translate_insn     = aarch64_tr_translate_insn,
>       .tb_stop            = aarch64_tr_tb_stop,
>   };
> +
> +void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
> +                            int *max_insns, vaddr pc, void *host_pc)
> +{
> +     DisasContext dc = {};
> +     translator_loop(cpu, tb, max_insns, pc, host_pc,
> +                     &aarch64_translator_ops, &dc.base, TCG_TYPE_I64);
> +}
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index aea38507ef4..9a971325144 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6906,19 +6906,16 @@ static const TranslatorOps thumb_translator_ops = {
>   void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>                           int *max_insns, vaddr pc, void *host_pc)
>   {
> -    DisasContext dc = { };
> -    const TranslatorOps *ops = &arm_translator_ops;
>       CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
> -    TCGType addr_type = is_a64(cpu_env(cpu)) ? TCG_TYPE_I64 : TCG_TYPE_I32;
>   
> -    if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
> -        ops = &thumb_translator_ops;
> -    }
> -#ifdef TARGET_AARCH64
>       if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
> -        ops = &aarch64_translator_ops;
> +        aarch64_translate_code(cpu, tb, max_insns, pc, host_pc);
> +    } else {
> +        DisasContext dc = { };
> +        translator_loop(cpu, tb, max_insns, pc, host_pc,
> +                (EX_TBFLAG_AM32(tb_flags, THUMB)
> +                 ? &thumb_translator_ops
> +                 : &arm_translator_ops),
> +                &dc.base, TCG_TYPE_I32);
>       }
> -#endif
> -
> -    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base, addr_type);
>   }

Oh, I see my confusion on the previous patch.
Yes, re-ordering this would be helpful.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

