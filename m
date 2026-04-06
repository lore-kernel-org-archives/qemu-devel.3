Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84128FB5164
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9rZP-0007Fj-4J; Mon, 06 Apr 2026 17:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9rZN-0007FD-DT
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:33:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9rZL-0008JF-T9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:33:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82c28f0a4ecso3255639b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775511194; x=1776115994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5fWDynpNM7WVWiq3joGoyQsNbyPENgRR5SE6uFUXQY=;
 b=z2aWzrZdOiCp0oxkWBWjjuc1MKqzVVSCzM6l/JTJliRcX+CJNH5mnqrLbHN6H4Fu64
 bCxAiUB43PUAPOUrHR6mQEo9efU/w9VQYycmMku/zLnhaA2Mj4SumXRLWz9heJ3xyNJM
 +XijztYe8y5S0f1x/zCwE8P8F77jE98jrDHXf8s377kCIkG20ABepEcjgOzT9d0G9STz
 r5Jr45/3E0ZaVtTRuZW17tsF5zHLcPIadq+z/KpFuntewDD+9Y4D5SjKxc70N8uGJ6D/
 i8HqZ2HRz2joasIUCPfQJ51v4wSTdBP+CTzPjPzZI1rleM+tr8W8PUnqfBif4qN4GJlG
 NQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775511194; x=1776115994;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5fWDynpNM7WVWiq3joGoyQsNbyPENgRR5SE6uFUXQY=;
 b=H31kmCy2cwpE4VhYRh5QiB9Oi65Cn5UGbIth/EjB1efrPWKmuvs2KE5I1KdqqdxTxf
 3QZQLgXNYL2/hqcY3ONx4UW4Iu3ga8+Igss3Jo1cSp+gVrKz6FK9TMmwPw8eOjEpzgvF
 XkNRQHgyFqk9oaA2wzIMsUERaDbiWrE15+visreL4ki/4KkObf5f1EDbl27KmkAWmAt6
 esipmUaCNbk27dbV989FvSCQyhN6bHmPeGad5t+nqZrUhj2MSQ8cXqINcC0y9savteBu
 NKthS+KiIVD5Z0JII/TPHq83RtmH2vNus1C3f507NbBRnUQx3tVkQDrWZtXKdyoK8WlG
 G5VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn2Yvb079piozf3mWP8ZIitxMOFK/8+z/UtJZwby0GYH0CQsgbE0ZofTriHVMkxsIoivd7T8NUc/Rf@nongnu.org
X-Gm-Message-State: AOJu0Ywm7Z/qw/uLPTR67DE5pj4xtUYvaB4DbRqPogWRRTjkumYJpAzb
 cmU8I5najykx2xYeOfcaxwAjSTB7mIJ6iMeOK46AB9aS4tFM70NXgS7Vc622UmfLzac=
X-Gm-Gg: AeBDiesIFQs6uVku/5E2XRapFRoYdS8Lxfu3F83FrIivxmAYMQAkTnfYt88fnqEju4t
 LGFYzhz3NKTAF/FteHTpnwvP7RBno6vvA3j5MHMm0bHHxp8sEhPwnj59AXOx2lzV8/Fstmy+VOK
 IQhP+DVH6zr9PcaSMtx3s2Vl8d8NDWyykMA+yJdeKKR9ejx/KNOKb0DclDEyigpdcRu/JgZ2dG7
 A6MHvYdbQ3otESY0nz+HHa1+Eqqrsw31zOnJGw4Voegnpfm8KXAcMQIXnQ/L3MS8J2sJnnFkW4Y
 r08PPClabjDPKc1T0WfrPXoVsqZvHFDeGn/sJftGc6/orjfUUJaHzIiAHIDK0n46YlUAqllRo7L
 EJS/kLK/IbCXHJlqRbqM3ESvyc4ENYYZjR/um9MY3MdJLDL5Jl6IGQA74MS2Gi70jPGetTgZgip
 dshK/jE1ei78ivn08QPHF408djx6gdIKPxTaqzCEsKN9bJwFPdwy7b25q64045H5LKUuI=
X-Received: by 2002:a05:6a00:14c3:b0:82a:5ef0:210c with SMTP id
 d2e1a72fcca58-82d0da8f33dmr14453607b3a.24.1775511194192; 
 Mon, 06 Apr 2026 14:33:14 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm13772768b3a.25.2026.04.06.14.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 14:33:13 -0700 (PDT)
Message-ID: <7b8e5cb7-e5fb-4734-93df-de3e30c3f199@linaro.org>
Date: Tue, 7 Apr 2026 07:33:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/20] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-16-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
> Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 35ad7530c4b..ebab9f36f08 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -25,7 +25,6 @@
>   #include "translate-a64.h"
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
> -#include "arm_ldst.h"
>   #include "semihosting/semihost.h"
>   #include "cpregs.h"
>   
> @@ -10800,7 +10799,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       if (pc & 3) {
>           /*
>            * PC alignment fault.  This has priority over the instruction abort
> -         * that we would receive from a translation fault via arm_ldl_code.
> +         * that we would receive from a translation fault via translator_ldl_end.
>            * This should only be possible after an indirect branch, at the
>            * start of the TB.
>            */
> @@ -10812,7 +10811,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       }
>   
>       s->pc_curr = pc;
> -    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
> +    insn = translator_ldl_end(env, &s->base, pc, MO_LE);
>       s->insn = insn;
>       s->base.pc_next = pc + 4;
>   


