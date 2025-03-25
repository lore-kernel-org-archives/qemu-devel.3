Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7D8C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEe-0001bD-OC; Mon, 24 Mar 2025 21:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEc-0001Zq-1v
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEZ-0007Qn-7K
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224100e9a5cso96813205ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866653; x=1743471453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ESyhJvzRgJ6eHUMJCajcUTPd7s/x9kUPr3F5kS9BQiQ=;
 b=TTumDdVA3Xg38X66kz8P50DvwMujcJT9NPO9xpH9at0ItdUTsYqpFJFztYbTHAyndu
 8bTCrwBEbwM2i9RRdMOXXZo+gTkaToDYPUhUpGUSIQAh61pExWTvyUoC+JufpdZcX7Sm
 g7/EY4CYnyk3d/N53LSZv5HUOydEsHB6Zi9J6ZwUDJvKQeDHHOuMjN6wT9tJnvj7su6f
 ouQ1QdagrRC3DoYmcMsRF7iMPHB9epJ9CQEhqYbCuMisN/izWH21Nkhj5cYIjxSPbi/1
 3TySmCH9Kdx4VoCvwlmQbBH/QR4hJfOTNAydBxcE0hQYNVS+6AVV1wTwSscQAOsxRykb
 Ekiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866653; x=1743471453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESyhJvzRgJ6eHUMJCajcUTPd7s/x9kUPr3F5kS9BQiQ=;
 b=a7V7LS3rgI2vMDl5yxQ5vR0o8v6nFHRS8BQXf9Kc6JkvkN7TZvmgSZf+RTWqSo9vIK
 437GMCUaJ+U5t5za5C8d9cHKK7PtdvfUmjBr0XUn00qmL442fdUtJaiLkdwIf03HPEmi
 R20w3tgKL5mP3IgG1GdSyNYp7Lg7F7Si25zhuvk1QHOWfEoubz6zTduXwWKGDD7IhjLr
 6nn2u6phAEbT1wGk2DKXXWv3zSjqxd2sGIPGhhP0DmQcW110T9MaYcJiDnckS9glq5wa
 WB85UYR0Tg4hI/H/8wh+2WGtbxTIgz1YR8a7CNn/hy6FEF4yZ1xRajeorB3AKoU61Dmt
 dChQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ljZDz0m4mAxEgF8QUae40yWX7bciKpPHXjSVUskxO8+rEMSuJhQTtryZX4JYkB9cmz9bR0viWoqp@nongnu.org
X-Gm-Message-State: AOJu0YwNsivgPsWElQB8hbbvzIqh3QN2uClOjzP9KCJ7FvBm7N0PuduE
 zqV94TZXJxdoP2tC6JJ0UcsAZ9tE7evav8RYbegO7y0steadWMavkuWKxBbi1sNbL8VozvSCaTG
 8mmI=
X-Gm-Gg: ASbGnct4CGL/3puOw+T6w8Ye1CVaHOdRgzK4J0GNIPuJEW3KBoeOblqheIxtqhQv95O
 cyjmNVRjhd4fFzqw3y7q7CHvg3/vX4XrnYcdT3YtVyzPwjYz4hE4vm6LJ2OqnWFkatNYVBRH5LG
 WV8RwZGrCXSr/tzknLGLAwuBgxvmllu4sURlZQ9ergohqA5KaG9h1MP1kQHxCJXL4muv4OwxIdt
 y3ZXpl8ZbzgpvbIoo3AYVynykjHDcXEnnk06sX4pqJKatfwzFX1ppDIV3OzksvTCaCb1D4AnHuT
 MTqgJXmjxaXXM8kqzclpJQa++XgvuSgAu3JLVn89lHVyG0vfRdgLic+01g==
X-Google-Smtp-Source: AGHT+IFPDpmPfZp7Xp8wT8MAHKr9FhRK+XC9TA1s5D9zvkJb4+DIOdjr+lFEgJM76iB9RcZHsv97JA==
X-Received: by 2002:a05:6a00:1a93:b0:736:6ac4:d1ff with SMTP id
 d2e1a72fcca58-7390598e236mr27130189b3a.3.1742866653196; 
 Mon, 24 Mar 2025 18:37:33 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fa38e1sm8784770b3a.35.2025.03.24.18.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:32 -0700 (PDT)
Message-ID: <cf9f6109-64ef-4691-933b-dc44a6038f27@linaro.org>
Date: Mon, 24 Mar 2025 18:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] target/avr: Update cpu_sp after push and pop
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Not that AVR has memory paging traps, but it's better
> form to allow the memory operation to finish before
> updating the cpu register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/translate.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 6bb4154dff..3446007be1 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -967,40 +967,38 @@ static void gen_push_ret(DisasContext *ctx, int ret)
>       } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
>           TCGv t0 = tcg_constant_i32(ret & 0x00ffff);
>   
> -        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> -        gen_data_store_raw(ctx, t0, cpu_sp, 0, MO_BEUW);
> -        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +        gen_data_store_raw(ctx, t0, cpu_sp, -1, MO_BEUW);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
>           TCGv lo = tcg_constant_i32(ret & 0x0000ff);
>           TCGv hi = tcg_constant_i32((ret & 0xffff00) >> 8);
>   
>           gen_data_store_raw(ctx, lo, cpu_sp, 0, MO_UB);
> -        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
> -        gen_data_store_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
> -        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +        gen_data_store_raw(ctx, hi, cpu_sp, -2, MO_BEUW);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 3);
> +    } else {
> +        g_assert_not_reached();
>       }
>   }
>   
>   static void gen_pop_ret(DisasContext *ctx, TCGv ret)
>   {
>       if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
> +        gen_data_load_raw(ctx, ret, cpu_sp, 1, MO_UB);
>           tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_UB);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
> -        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        gen_data_load_raw(ctx, ret, cpu_sp, 0, MO_BEUW);
> -        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +        gen_data_load_raw(ctx, ret, cpu_sp, 1, MO_BEUW);
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
>       } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
> -        TCGv lo = tcg_temp_new_i32();
>           TCGv hi = tcg_temp_new_i32();
>   
> -        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> -        gen_data_load_raw(ctx, hi, cpu_sp, 0, MO_BEUW);
> +        gen_data_load_raw(ctx, hi, cpu_sp, 1, MO_BEUW);
> +        gen_data_load_raw(ctx, ret, cpu_sp, 3, MO_UB);
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 3);
>   
> -        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
> -        gen_data_load_raw(ctx, lo, cpu_sp, 0, MO_UB);
> -
> -        tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
> +        tcg_gen_deposit_tl(ret, ret, hi, 8, 16);
> +    } else {
> +        g_assert_not_reached();
>       }
>   }
>   

A bit hard to review with the side effect of gen_data_*_raw, but number 
seems to match.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


