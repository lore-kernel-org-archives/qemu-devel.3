Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5377CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oOG-0002rs-P3; Tue, 15 Apr 2025 18:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oOD-0002gi-0c
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:04:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oO6-0000S3-9g
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:04:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so5720187a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754652; x=1745359452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XIAFQxotD3+tJXaXoyxTWZeETTUdPIsA82fB11Zs+BE=;
 b=irajcy7aEgVgGDDk/whAe2/8GXjRmtY2PJARANRXPSILNi14Iv09Q0aRGSkojPn9TS
 K6CjV+QTUDeVKCUj3tM3QZnGzwEQDftFTpWhMuBezBpnkS6XtYHav+O+yI3WQof9lMm8
 hLtUaVTnyMpNO+Qe1zDC9kpFQuei7EQECwum/tIhd1jnQ2wBhrARUOPf2Lpr/UQ6almG
 TDJ40BccboQOY4gDanXn8vsTaiZ9VQIj83lUB6MAuD75vUvV9QE/ScjwNl/nBk/Ui0qg
 h6MSxJhQs+IXXdBMiTfNSQHfC9jQWDuKAbwYkTyqXy1C1d+B9MyoC95ybkjotMgUiZ6X
 CChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754652; x=1745359452;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIAFQxotD3+tJXaXoyxTWZeETTUdPIsA82fB11Zs+BE=;
 b=pfcwAjiBXuCAogT34kkNuwrKU/F+rUAN5jTiK7dSJEsoDGTwgByCPgxqMTf/nczFLa
 rYmhfSWd9kb1u2KxPATCtoRicvtCdidY13iXm6sC9JxMMr6kN0CYQmTlNBLjV5T75tb1
 i7SNqWqioRVGV6dqH1H+lOvadrVrVEldw4jotCXYe/4xbgdg6XDBNuXxiCng6/hohprO
 XXOZp3OyyfmvCF0c+D0zHXDAYemNVWaoZTZ+Vp9Of+9HtUyem4GGS5tm0IDnpsiSRzfT
 Nd/asgFyUdKXjxgaDXgvbETRzk8v+i5XXHgd0KHUBoAaEk1N8wsz6OpeLtPuiK6FPESA
 /cxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrqJRK7DNd8me6jqQStagys/mr1BLRhZxpWFQQspb/WPmM168V6L7WJkUfYwyKfGsLxdGNno24oRti@nongnu.org
X-Gm-Message-State: AOJu0YzZxkhrbafGDDH/Uqv7UojT/IP4pCLNxFXMlLfZq1xAmioAcl66
 /h/j1EzgOiGtCTJwqRLtWfuPHTs+UP6uKpI8TCY8J8yltRVamf6Vr7KIJNecj+sl+4hpRcQSHdE
 PisM=
X-Gm-Gg: ASbGncvxX/+TChiW6qM+RqrOJbkssOgRLqpqu7Xo+vsMGX1EvpYbmfSnZsLFDIgO7i6
 MsXebpSC4AuPIG7nlJrlZMmfKKxrCHIavxX3C92S2Hr5aHbnyvWcCSGKXCr3H1J6dfw6y5yqK5G
 YEceZl8I+VAgDFE73k/5+7xXcs5SmxHOf4qFOTfF+wE+y9O06/kQ8i2eoVCzXho1CjJMnzvsjGb
 TG9ZUz/vZIBob7tNZy2665aT6g/nsTafJ/O8XSCBrT29lScblejcVNxrf97NHwxLS5FlQOIXuA5
 ryjayOtXhJQdH1VOfcU0NLfy6NOGZDXtn+hBrPccVD0dJL1KYAphTg==
X-Google-Smtp-Source: AGHT+IGz/55+xWaIyI4b5ozie6BuF8CSxteSiTEZ2hrav82D4GZKgTWkhSp/kzVvfUTKqbPsQnm1IQ==
X-Received: by 2002:a17:90b:51cc:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-3085eefb554mr1297754a91.4.1744754652217; 
 Tue, 15 Apr 2025 15:04:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308613c7f07sm92994a91.40.2025.04.15.15.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:04:11 -0700 (PDT)
Message-ID: <a68f735e-7417-4fb5-adf8-c2f9e29560f4@linaro.org>
Date: Tue, 15 Apr 2025 15:04:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 108/163] tcg: Do not default add2/sub2_i32 for 32-bit
 hosts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-109-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-109-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Require TCG_TARGET_HAS_{add2,sub2}_i32 be defined,
> one way or another.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target-has.h  | 2 ++
>   tcg/mips/tcg-target-has.h | 3 +++
>   tcg/ppc/tcg-target-has.h  | 3 +++
>   tcg/tcg-has.h             | 3 ---
>   tcg/tci/tcg-target-has.h  | 4 ++--
>   5 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
> index 0d6a785542..3973df1f12 100644
> --- a/tcg/arm/tcg-target-has.h
> +++ b/tcg/arm/tcg-target-has.h
> @@ -24,6 +24,8 @@ extern bool use_neon_instructions;
>   #endif
>   
>   /* optional instructions */
> +#define TCG_TARGET_HAS_add2_i32         1
> +#define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
> index 48a1e68fbe..9f6fa194b9 100644
> --- a/tcg/mips/tcg-target-has.h
> +++ b/tcg/mips/tcg-target-has.h
> @@ -48,6 +48,9 @@ extern bool use_mips32r2_instructions;
>   #define TCG_TARGET_HAS_sub2_i64         0
>   #define TCG_TARGET_HAS_ext32s_i64       1
>   #define TCG_TARGET_HAS_ext32u_i64       1
> +#else
> +#define TCG_TARGET_HAS_add2_i32         1
> +#define TCG_TARGET_HAS_sub2_i32         1
>   #endif
>   
>   /* optional instructions detected at runtime */
> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
> index 033d58e095..8d832ce99c 100644
> --- a/tcg/ppc/tcg-target-has.h
> +++ b/tcg/ppc/tcg-target-has.h
> @@ -25,6 +25,9 @@
>   #define TCG_TARGET_HAS_extr_i64_i32     0
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> +#else
> +#define TCG_TARGET_HAS_add2_i32         1
> +#define TCG_TARGET_HAS_sub2_i32         1
>   #endif
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   \
> diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
> index 6125ac677c..50e8d0cda4 100644
> --- a/tcg/tcg-has.h
> +++ b/tcg/tcg-has.h
> @@ -14,9 +14,6 @@
>   #define TCG_TARGET_HAS_extr_i64_i32     0
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
> -/* Turn some undef macros into true macros.  */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
>   #endif
>   
>   #if !defined(TCG_TARGET_HAS_v64) \
> diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
> index 4cb2b529ae..6063f32f7b 100644
> --- a/tcg/tci/tcg-target-has.h
> +++ b/tcg/tci/tcg-target-has.h
> @@ -8,11 +8,11 @@
>   #define TCG_TARGET_HAS_H
>   
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> +#define TCG_TARGET_HAS_add2_i32         1
> +#define TCG_TARGET_HAS_sub2_i32         1
>   
>   #if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   #endif /* TCG_TARGET_REG_BITS == 64 */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


