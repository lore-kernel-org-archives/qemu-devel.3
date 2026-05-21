Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77437CD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 07:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyEs-0004Of-3B; Thu, 21 May 2026 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPyEp-0004Nq-La
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:54:39 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPyEn-0002v1-TO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 03:54:39 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c19d23b19so7919211c88.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779350075; x=1779954875; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb29feHQDidaIV3Jtoxu6bpaKuO4rbbIc90G/eSOlaE=;
 b=NDgorI89XkE9nejs2wScrJiY8nOPFxhnfjuCHbrRUNSFmC/xkHgz3LHRyVflIQbLr1
 B3mzXbnMFFy0dGpKVnHG0S1943y3jCvBaN7ydhF6gVTdwDzAfttS2Fpe20jDStzZlq1n
 fQ902wpTSohXstCyrzOQLOCP64S3w2qpqNz2z3NYSd8vMevc09zVBQkse0FRl+6wklpQ
 90PDxa6LRvZlewD+NB5ye7nZ0xgicRIimlSgz+aARqrHi10FMnibigbdW/mXfj+bzeNo
 I7odzbIGr/YtmhMWkbs3neo25mrMaqoVsODuG35ZfxT/o+2MrNbCf0BPndUeZfntWFM8
 L80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350075; x=1779954875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pb29feHQDidaIV3Jtoxu6bpaKuO4rbbIc90G/eSOlaE=;
 b=oft2yobEF1cN45G77sIDQ+QopKaLpcULzpX/kYYOoocehS767sABn4kkKVqCWPzeU1
 YN3k48rmXl4oQNdwTrihVCztrG0XMhqOod+p8xAKxQEb608JE49fEqaX+pYYqgJ8q9r+
 gibb7fwu8q3p9952Z8VHSUX+0gX+DX6ZT86/d5ak46wf/tRZjuO07eqVKHqr15NjVAsi
 zkXwaiwwrFbAwp+xWJA88TaIkZmYr4rYDEw6b1W7wq1fBaoZmbR+KPgSfuJxJ5XrL7CT
 qYUtj9HL8Wsc5BCFdIckQNzcXI87BSsSsoU4BEJ6ijDmOKvzedx28/vizljWlg7nvDNN
 SByg==
X-Gm-Message-State: AOJu0YyMuJTwoCBRQHxpJ9xkOUba7B6CiMTIdwpeInRTMTlYzDsRarlt
 TGD9fZ4pKQhv4xc48P9rGbXuaE7rbG2nhSUjXOhymE5Oucf4O7zqB8Hw
X-Gm-Gg: Acq92OHHXdkwbzKtluHXYfAkKhqopHF3I8GgnxGZkc25RacCKIKH0X4TfMWULYX5zWk
 XdGeLsiZOVLK0KbOpjeqCtw1H4lmOZYgQJ+pIzLiyoKP17+F5HQibdFV5u3cgmIDTHDVFJMMoeY
 nMG6Yfl2c+9RZvDN/tRnd+Elzq9hc8bGI93p91IAeBrSumtIbMQvNDUSyqw+wuNYRyJNdxm/Qjd
 QtxbrHjNIad5Uvi+Tq7J4iPOkm2yrTdv/Y+ZYFeGbu+KJppiRRj8o2wCRfNAf06uFM4im/KFKG8
 q83kANMh3D55EVlp9vkynFZVGrJK/PJYO0r76fqCfLvoltmyWpXF4n2K6wFB7NZo5ot/5Fd8TqB
 UJcVz3azEkawGhcs4uTGVn9sd1j9cMqFgvXh+bkMwUk5XWMDKDNRdBkPYwFYk/2Js5xwvu23bQe
 bUlHDVBLSBSBE1CthPq5H0tC7Fyq+9WBYbAn4vZD9pnl9pPvEREZIexoXOODo=
X-Received: by 2002:a05:7022:1605:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-136321819bamr931904c88.0.1779350075328; 
 Thu, 21 May 2026 00:54:35 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc3490bcsm24526894c88.15.2026.05.21.00.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 00:54:34 -0700 (PDT)
Date: Thu, 21 May 2026 15:54:30 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com
Subject: Re: [PATCH] target/riscv: Use float_raise
Message-ID: <ag66BzwGxPqJzXln@ChaodeMacBook-Pro.local>
References: <20260521074016.1065645-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521074016.1065645-1-antonb@tenstorrent.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 21, 2026 at 07:40:16AM +0800, Anton Blanchard wrote:
> Use float_raise instead of open coding it.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/vector_helper.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index c4e150635e..72ea431746 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
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
> 
> 

