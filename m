Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDF2D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIADT-0002tq-Ke; Mon, 02 Dec 2024 12:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADC-0002qp-UA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:27:58 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADA-0000oI-6L
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:27:54 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ea55c356caso2475290b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160471; x=1733765271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t0r9fkzitlfbeabYCM+8qm9LFVwkHz3q1c87T1RFbGk=;
 b=XEiqkIjCp9Y+BC9XV8Xvhfyn5FyujbaYlCnpB0Mffh8bL6B1HIo4r6SOpFdJ3xNDb6
 3YCzW4OtS+i6t+CACHk8VBYxuNlYjRQ/5w6X1Dpzr2PCYcL0IREgnFR6g42PJDIvseiX
 IOuAJCWh/jXsOrqpfSSb9D9lTNxFCKrFOXM3Nt92FJ/OC/AK0bhSvvMk99OiQZlH02wo
 Ul+bAKCl3dI2SXBACC7iZnJkQQjg+zQxj4DU9etu8mmfwNvRp5gvUdAe+Apck57RMD/9
 COwaSvhKR9SkyXu9eKUpSIC+JYM3TRc9qRMxpMhh/zGIA0ZBgyplNlUVnbatExv/WTAh
 JX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160471; x=1733765271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0r9fkzitlfbeabYCM+8qm9LFVwkHz3q1c87T1RFbGk=;
 b=My8rPE+9eObr3BFvrrQNgT/KqFl5KnXO3azpBwg1ld4yI8vNg+sa87em5EWZqLhm/2
 ldxGSwAWRK5d7U1vwbvw1+RqaA4RFNhMB3CSHIZ1Hk5DgPC6ITz4TtGK9H/7NrW7it/2
 qxMcVBaeMuLai9HBcFP6O5QWPqHsAI8Z8BsPKM0wiLwN1ljufDGz8iLabuehtzZROKRE
 pbjVtIcji2WPo4FX6nwQxeaYjmGcevykABNeWj4KWG0xfrb+r17XWm3MzLcbFaRGRBwe
 LV8R/UROQcIO0xjduOB3xjPuk7qaVx4R8i9CgTCsNedZOhhN7sOPl4QqPBgucl6oGcwv
 DwDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJx9qRU2zGmtzf14CIWDMOlLfm4bqG1rRDZak1igQQK+HddviiMOhBFQH3cTvn9YCBH9eGm0KLUyoa@nongnu.org
X-Gm-Message-State: AOJu0Yz0Ugrj0pZkBZOMxdgYk525OMIxaRN6R402pDtbg6rtuNDC4fXf
 RbuV5nHnZ2ngYqO6NhVvhA9x0cuSyV7UfEvtTbQTe6enKQeb/wZq1Y14Dzh1b2XbitFrNRaSLjX
 BsZY=
X-Gm-Gg: ASbGnctMTQCsrgGHsyomwXRg9EDIUDV8ARON4xQN17ecgCYfPIKngONsXSmRNHL9pb4
 /Ad186PUFvd7mIvikgOSe0j4FcNXKDpyESyoRivemgC1dBEORng5K5j0sI0TbOwKqDkSwqquXnk
 ixGTpkhi3VXlnXsTzRMo2LPwDUiEk2vGo7rYktq4BWNV4dhwYPImEvl8gT1zzEmwoj2+at5zOU8
 Htec3ZjgNemWxT+bkDxI9TiU5ck4MYtwNF569wt1XxaHSGtKbQHzYHn9v8Xs53EBiUddFs=
X-Google-Smtp-Source: AGHT+IGayIqJX8bAFnxN9znk3f8XRjG+joO69J7/hwvbtagdc/xWYpobY5SGxTNosJo1Q7iPr9OwQQ==
X-Received: by 2002:a05:6808:138b:b0:3ea:5ab3:e61 with SMTP id
 5614622812f47-3ea6dc25008mr12773377b6e.25.1733160471001; 
 Mon, 02 Dec 2024 09:27:51 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d8639sm2325907a34.51.2024.12.02.09.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:27:50 -0800 (PST)
Message-ID: <84dc60a4-3766-4760-ae46-12268a0ae7fe@linaro.org>
Date: Mon, 2 Dec 2024 11:27:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 37/54] target/i386: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-38-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-38-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly, and remove the ifdef from
> parts64_default_nan().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c   | 4 ++++
>   fpu/softfloat-specialize.c.inc | 3 ---
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index c8bc5b7cfb3..e788fcd1b25 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -181,6 +181,10 @@ void cpu_init_fp_statuses(CPUX86State *env)
>        */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
>       set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
> +    /* Default NaN: sign bit set, most significant frac bit set */
> +    set_float_default_nan_pattern(0b11000000, &env->fp_status);
> +    set_float_default_nan_pattern(0b11000000, &env->mmx_status);
> +    set_float_default_nan_pattern(0b11000000, &env->sse_status);
>   }
>   
>   static inline uint8_t save_exception_flags(CPUX86State *env)
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index d77404f0c47..452fe378cd2 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
>   #if defined(TARGET_SPARC) || defined(TARGET_M68K)
>           /* Sign bit clear, all frac bits set */
>           dnan_pattern = 0b01111111;
> -#elif defined(TARGET_I386) || defined(TARGET_X86_64)
> -        /* Sign bit set, most significant frac bit set */
> -        dnan_pattern = 0b11000000;
>   #elif defined(TARGET_HPPA)
>           /* Sign bit clear, msb-1 frac bit set */
>           dnan_pattern = 0b00100000;


