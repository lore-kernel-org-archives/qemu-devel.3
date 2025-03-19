Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwBn-0001i3-Ts; Wed, 19 Mar 2025 12:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwBa-0001f6-RI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwBY-0007k4-OV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-226185948ffso75247835ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742401346; x=1743006146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rO2MNbQQQgbESzpsC5KV/+MviBMdJ/rq/hSxY+auNz8=;
 b=Qfu+SbpsOAS/Bhb0P9R/11EHEmybRYb8oLBAIQYJVjNWQVa3RSMHJ6GLEJS9eKe9eF
 2svmnz9t9AsCpy2X6++gslP1EOtZMRy+5NGcHfQ1wJee6wiTFCoYZ8AyTNFwazqJRKGO
 k5pwHHWKD0S2cXBAuBudzmlO0ji/6VOwGbMlMmiXlJv6Wp0B9q3N33hKJ3+3VKI1yyPB
 J68ry8m5qrxLX22zQ34uxvDaZX8uwtYRDXEXkXarh2NhVQagFiz/bPsN/f7GJ47hTqZx
 hq2JXoe35BYFHG6KulpL1VczAYnkSo0Ijrh0gNIzk4n+aVEHcHMQOPaoTMFOMQlXnDmQ
 XT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401346; x=1743006146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rO2MNbQQQgbESzpsC5KV/+MviBMdJ/rq/hSxY+auNz8=;
 b=W89945DZQDvvR90CHWDAo3Jplw/o6lS4XmsOalA8zupirJt9uSfYB+pF2H/SuLFmpJ
 u9PEckWxPJ1AmU6VMoXEI1jxNTRlR2eB4A7uy0kqJWAZf8eT5QnBdHhe6rYVOCzPR+6G
 F01tvdudexa6n9jBO6ZUk24a8RchWqKDxzuX4HMoTaeVDN7keWqVToM84FWsbX95tXVv
 Lgn/DA9FhPm6n++qakVyDOpLnzB3MAle0WnGOW5XheWT9Ca+chDEOOuICkhSU2AwshW3
 exIapMsSW9QFiEe7pmjOVzs9yUy2VI+C5ebNBxVWRQAC0eeecRA94VEwnSFtV8qd4jcl
 Nukg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2VXIZi1t4pYFHxr438OJwxrqsT9M6/p9ky0JG2ok3O857Qv5mM/KaZ3XQ2uz1FEuGZ2EoJVi2TwQ@nongnu.org
X-Gm-Message-State: AOJu0YyAXAG9B6kTjrDozl609DOspaFdd8ahHLgPAvF0VKj6pWt9sZMU
 lX6jjB124J7Y/uGZAL6aYJAhqYmvwEXkZmY2NJ6cAq46fiO08xycHKeOBod3tAwtJ2RtpBboBS2
 Y
X-Gm-Gg: ASbGncubvnLqybERV1TRlX19EVcuY52ds0bO7oiaWMHb4K5ycR9X8VIjstJS+4lL78f
 NtVDtT6fTb7MCXNOiB73fwD0cTsr0tDpYKyC+BYU86KtkavQ2UC+peCYH36CG6QaFefN0vJ47Gw
 KClqHidw5ML7rDQUyuXRR5nwHFHNUf3ixEmPa83MCYPT5JeXlzmDQeOD7fXiDtMwPvbm+QVD7P1
 OFYa+0lI0kZZnqdOr33AKVM7idq5D1w+lp/x7i2nZMwJ54zTPmVw+zsJHcASd3bjRIUJz1u45dp
 ISNu6b9vtI5fh505V9V8GvmUxoPN7YAi4VcpP/4YClc3VTF84P2gqXip9fSwOp9eiOXca6/2sQf
 kMeUILJ8P
X-Google-Smtp-Source: AGHT+IFW6Vl6bqCTpUzzam1f6cvd1JnCv67BL1ywNEp6CPSwJQDQTufv1QxPmm2KPCuKEdyFpHFmFA==
X-Received: by 2002:a17:902:db12:b0:223:49cb:5eaa with SMTP id
 d9443c01a7336-22649a46a18mr61159225ad.35.1742401346361; 
 Wed, 19 Mar 2025 09:22:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2264e5a8934sm14313475ad.159.2025.03.19.09.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:22:26 -0700 (PDT)
Message-ID: <b7b2a67e-fc35-47fb-913e-8e101d9778f1@linaro.org>
Date: Wed, 19 Mar 2025 09:22:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 07/12] tcg: Check TARGET_INSN_START_EXTRA_WORDS
 range at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/19/25 06:45, Philippe Mathieu-Daudé wrote:
> Define TARGET_INSN_START_WORDS_MAX and use it to check
> TARGET_INSN_START_EXTRA_WORDS at runtime in tb_gen_code().
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op.h      | 4 +---
>   include/tcg/tcg.h         | 2 ++
>   accel/tcg/translate-all.c | 2 ++
>   3 files changed, 5 insertions(+), 3 deletions(-)

Nack.

> @@ -52,8 +52,6 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
>       tcg_set_insn_start_param(op, 1, a1);
>       tcg_set_insn_start_param(op, 2, a2);
>   }
> -#else
> -#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
>   #endif

This is far superior to ...

> @@ -351,6 +352,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
>   #endif
>       tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
> +    tcg_debug_assert(tcg_ctx->insn_start_words <= TARGET_INSN_START_WORDS_MAX);

... this.


r~

