Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A19CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 01:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS3UC-00018Q-9j; Tue, 26 May 2026 21:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wS3U6-00017M-6Q
 for qemu-devel@nongnu.org; Tue, 26 May 2026 21:55:02 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wS3U4-0002we-8A
 for qemu-devel@nongnu.org; Tue, 26 May 2026 21:55:01 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so7207897a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779846898; x=1780451698; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TV8Fg2uSH4Ri0oTa+Wo87XwB1dWuaOQgUlZN0sUtqbk=;
 b=aiTEHHRgUjjfFZ8AVdXAAzYwBO75MzlmOhUABQBdaZL/GNrEhAmPIJhbTwCZYaGE4D
 wKikbOezYkqlfvl1zIW3jlm4WJQlDGufBCOF8FoyPsCeJGYECiwU29eSNnKes1wGV+S0
 oboVlNZkjBd/jZ/GLPsfOfPbja9iJQYjaAKAbzumwNx8GoKcG+dAXCnF2BP0AWmRNTLt
 9TtF6kCLr0y5qgLKfRibaYkdVvQZCgIWxPv76tx+6H9GD1Boqf7f1IZ3l2NP7Z/AiZXf
 VvDxJehibUKv0aC/GOHgoZ3aAvugzpbTnm2JwUC06rxa2D39GLzJludNKmhMDqrWHg7q
 Wb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779846898; x=1780451698;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TV8Fg2uSH4Ri0oTa+Wo87XwB1dWuaOQgUlZN0sUtqbk=;
 b=CXm5YYzGysZIv2l9yCEuu+9y4f5Obe1GIP0JDFPymLPA7Ita2E8IOVv+Ne5RRu1Ahm
 NwZD40fR37BqeHsv1xXeiiuzII/sVg13spkQ4WFVbHyyOB000tg1IwLy1l6OTYnEGGa3
 CjOkbJSo2ULdrEDPAKcCUxkr6KPs1aMj1MrTP0WLjklQ4Jh2yZyV99JLqDoR1s4KgjDI
 p/hnmNbgdhQgoIFE88W/IaCnH56GJ1Atwslef6BkiFGOV8lrhb5AXQBxqwICn340racn
 ZzByRqDVWzAhFuqMWhdPjRM+lTy9MLLPXi/LJZPtjEOIL9NjN+0SglAbrnbsSQleWCdN
 CcCw==
X-Gm-Message-State: AOJu0Yw54/L1rD5pBJxsGaeMyCW3nzb+JYqseoK4cPihv9tnAqXepJ3O
 3NQ3oNVxsbAbE4djXIUz1J6jDyDscEZT4cJFxUrdH6MXsDGbAvlSIXM0HOkwpQc0kdI=
X-Gm-Gg: Acq92OGlHgBIiA3B47YDG9njghI5AJeIBo/vyNEFAoVcwdXXbKWgECG8aql4kyYZFk2
 6B08IMKYE2c1TpqWroNOjoucRZlY66yF6n41X6OtlVT0MgqIurvTdRJUeyzGieM9jBwNrIuqvdb
 Iod5CVOvJKGsN0tYwhoZWPoGPlWXwNQfIVdnt5P7GIBL9EQsfM/8QKNg/Wq4klcVaIdhjeY987D
 l7crZBBdMoS3oE+C6hUFKSvVlKfdjvv+rgoJTZ5gU2Xa68kMgNdycFCGhaIuWt+CnLxTi3HysGw
 cqmefZgpmJeBFarSsonFpWx58Ny+6IBs640vFDBoCttTl46xwfoZb9c2qPKAHg6Gks7IiUVkexw
 ri1kK5TAoxsmWi6vEl8YNoxBNReI7ZMU3+FEpyAvD3B9+sDXEbSPXAErbworZEci63EuzGZPO92
 RK08erokuBwwbDZ5HAIgMwbpQKuAxRpojS0Cbf5Taz7rb62dnGI82QK9YOP+i67deQ2WnQgVv1+
 TaQVxcsl9qtFQ==
X-Received: by 2002:a17:90b:2d08:b0:36a:f064:d48a with SMTP id
 98e67ed59e1d1-36af064eeb6mr7632224a91.4.1779846898137; 
 Tue, 26 May 2026 18:54:58 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7263178dsm18188054a91.3.2026.05.26.18.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 18:54:57 -0700 (PDT)
Date: Wed, 27 May 2026 09:54:55 +0800
From: Max Chou <max.chou@sifive.com>
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2] target/riscv: Use float_raise
Message-ID: <ahZN-VWq7SXgzqzp@sifive.com>
References: <20260521110824.1091323-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521110824.1091323-1-antonb@tenstorrent.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Max Chou <max.chou@sifive.com>

On 2026-05-21 11:08, Anton Blanchard wrote:
> 
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/vector_helper.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index c4e150635e..d1be0682fe 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4084,7 +4084,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
>          (bfloat16_is_infinity(f) && sign) ||
>          (bfloat16_is_normal(f) && sign) ||
>          (bfloat16_is_zero_or_denormal(f) && !bfloat16_is_zero(f) && sign)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return bfloat16_default_nan(s);
>      }
>  
> @@ -4095,7 +4095,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
>  
>      /* frsqrt7(+-0) = +-inf */
>      if (bfloat16_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return bfloat16_set_sign(bfloat16_infinity, sign);
>      }
>  
> @@ -4124,7 +4124,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
>          (float16_is_infinity(f) && sign) ||
>          (float16_is_normal(f) && sign) ||
>          (float16_is_zero_or_denormal(f) && !float16_is_zero(f) && sign)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float16_default_nan(s);
>      }
>  
> @@ -4135,7 +4135,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
>  
>      /* frsqrt7(+-0) = +-inf */
>      if (float16_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float16_set_sign(float16_infinity, sign);
>      }
>  
> @@ -4164,7 +4164,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
>          (float32_is_infinity(f) && sign) ||
>          (float32_is_normal(f) && sign) ||
>          (float32_is_zero_or_denormal(f) && !float32_is_zero(f) && sign)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float32_default_nan(s);
>      }
>  
> @@ -4175,7 +4175,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
>  
>      /* frsqrt7(+-0) = +-inf */
>      if (float32_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float32_set_sign(float32_infinity, sign);
>      }
>  
> @@ -4204,7 +4204,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
>          (float64_is_infinity(f) && sign) ||
>          (float64_is_normal(f) && sign) ||
>          (float64_is_zero_or_denormal(f) && !float64_is_zero(f) && sign)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float64_default_nan(s);
>      }
>  
> @@ -4215,7 +4215,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
>  
>      /* frsqrt7(+-0) = +-inf */
>      if (float64_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float64_set_sign(float64_infinity, sign);
>      }
>  
> @@ -4285,8 +4285,7 @@ static uint64_t frec7(uint64_t f, int exp_size, int frac_size,
>               * Overflow to inf or max value of same sign,
>               * depending on sign and rounding mode.
>               */
> -            s->float_exception_flags |= (float_flag_inexact |
> -                                         float_flag_overflow);
> +            float_raise(float_flag_inexact | float_flag_overflow, s);
>  
>              if ((s->float_rounding_mode == float_round_to_zero) ||
>                  ((s->float_rounding_mode == float_round_down) && !sign) ||
> @@ -4338,13 +4337,13 @@ static bfloat16 frec7_h_bf16(bfloat16 f, float_status *s)
>  
>      /* frec7(+-0) = +-inf */
>      if (bfloat16_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return bfloat16_set_sign(bfloat16_infinity, sign);
>      }
>  
>      /* frec7(sNaN) = canonical NaN */
>      if (bfloat16_is_signaling_nan(f, s)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return bfloat16_default_nan(s);
>      }
>  
> @@ -4370,13 +4369,13 @@ static float16 frec7_h(float16 f, float_status *s)
>  
>      /* frec7(+-0) = +-inf */
>      if (float16_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float16_set_sign(float16_infinity, sign);
>      }
>  
>      /* frec7(sNaN) = canonical NaN */
>      if (float16_is_signaling_nan(f, s)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float16_default_nan(s);
>      }
>  
> @@ -4402,13 +4401,13 @@ static float32 frec7_s(float32 f, float_status *s)
>  
>      /* frec7(+-0) = +-inf */
>      if (float32_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float32_set_sign(float32_infinity, sign);
>      }
>  
>      /* frec7(sNaN) = canonical NaN */
>      if (float32_is_signaling_nan(f, s)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float32_default_nan(s);
>      }
>  
> @@ -4434,13 +4433,13 @@ static float64 frec7_d(float64 f, float_status *s)
>  
>      /* frec7(+-0) = +-inf */
>      if (float64_is_zero(f)) {
> -        s->float_exception_flags |= float_flag_divbyzero;
> +        float_raise(float_flag_divbyzero, s);
>          return float64_set_sign(float64_infinity, sign);
>      }
>  
>      /* frec7(sNaN) = canonical NaN */
>      if (float64_is_signaling_nan(f, s)) {
> -        s->float_exception_flags |= float_flag_invalid;
> +        float_raise(float_flag_invalid, s);
>          return float64_default_nan(s);
>      }
>  
> -- 
> 2.34.1

