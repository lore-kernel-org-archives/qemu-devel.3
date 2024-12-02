Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3697ED78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIADq-00039X-Bn; Mon, 02 Dec 2024 12:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADc-00033k-5S
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:28:24 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADa-0000tD-IJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:28:19 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e5bf419ebso701759fac.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160497; x=1733765297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tyhNyqT5MCIswHKLH9fjphfuQs/C3ZDVSsgWFJZ9Ng=;
 b=dBZDci8tRmmR/9zZALpzrqHi3O//lVru94Rk3JAiCTCBXhrCacYM8PlpcuIx1A2hP3
 uj5fb/x6HgiGLDGm1p3syuyJsMnuYa9hCUnO6l1p0JYQa17vu3JeFaBxBs1rik98cnQq
 h9fil/Z9x0gVwOvdI3C7yBalZ/cBDqVgSqoDUHpCMlLEkQ/AIcyHnTkJYQ2MOlNDBT2D
 Bd8Kzufy6ogcGP8ISVxeEZixA5amXe4uIyx/Nc8rHSkETzKmv7JaTBClVAPD/Fmldxx8
 Td/dXJ/xCwK8lSdLNxkpDz0ypCk39aFzopJtkbPGE8WCc30uP6uAiZf+nBRGZm32cwhO
 HXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160497; x=1733765297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tyhNyqT5MCIswHKLH9fjphfuQs/C3ZDVSsgWFJZ9Ng=;
 b=l4IAMvC3xBxOXrwDh31JGIMM4aBVzNhhi7pMVOViQ2FSUz765lzunO/7u2hR2vdlxS
 UPGXAi2R1PvQ45LM6SCQYEMps8rMbQDhxh/N7GERSU43iaZPAE5rQJGPMhPGb2X1M46p
 dhaM+zXaiHcujHxKK9pDF8ibap08H2SvXkm9XFnLW0Pw/8I1P4RLDg4W0l3lORCHawtN
 yWKOoD8AE9VjM1dQaUZuNLMJHt2yaD1wCpm36Hi5nrNsdtu6m7h2gc7iNMkk8UKzscat
 S8FPJquwEzkthPKcLsnxrOQRtgWYieDpG1jz6jT4Bvf4WtNr5AzgcI51W5UvNChwB7fz
 R6ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHB0JqUqBdQcNuvjQrcm0eSFnoFwkWRchmNSkHDuVNLAPdjTwJenT3KbTcUy/bUuxlIfd3vun/nvDD@nongnu.org
X-Gm-Message-State: AOJu0Yyw62mH7eqV5s26TgjN4wmdbEE4HCpoEScQna8pV8kmBe9GSo46
 KdzsnT7XtRafkk5UEjtphCUIJOJunOfbjHu3eBUiclGBEVm93wcIxJ5+cL1GBwo=
X-Gm-Gg: ASbGncsyXoLcSrSbKdp/xofNZxwOl5jMRdXxbBu3mBb+cul7DPaJDWOseYL66azAvHO
 UxZKWwExeN6I0gdgF0PCXmAWwN0lMI5XB3F64HDalksyxDQHDgx9AvEFafXiFgtC+vmJHZXoZbI
 W/5cye5EEKoQITqT0b8dy7CyFEkoBKfGwIDaXiqBRdFMz9ytKfCgWBPtNTx7PbLQMpBjf/wBxjP
 kiCXT55V6wehKubpODjV5lB6l9dkjx77j4CueKCrAf85V3EQygd4Rgly+c4KmSNtUBghVQ=
X-Google-Smtp-Source: AGHT+IG3vrgfnl0m5EOX+I1AcC62TrzaplzTo/hE8mz8ZSZ0hq5Ti+LXeDvb8Dgg+FYXb3ST9iXm0w==
X-Received: by 2002:a05:6870:b9cb:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-29dc3f9edecmr18107514fac.7.1733160496864; 
 Mon, 02 Dec 2024 09:28:16 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e7786d4c5sm220167fac.53.2024.12.02.09.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:28:16 -0800 (PST)
Message-ID: <e95f0ed1-b179-4ef6-bc75-a9075841ae0c@linaro.org>
Date: Mon, 2 Dec 2024 11:28:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 38/54] target/hppa: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-39-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
>   target/hppa/fpu_helper.c       | 2 ++
>   fpu/softfloat-specialize.c.inc | 3 ---
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index 69c4ce37835..239c027ec52 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -65,6 +65,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
>       set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
>       /* For inf * 0 + NaN, return the input NaN */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
> +    /* Default NaN: sign bit clear, msb-1 frac bit set */
> +    set_float_default_nan_pattern(0b00100000, &env->fp_status);
>   }
>   
>   void cpu_hppa_loaded_fr0(CPUHPPAState *env)
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index 452fe378cd2..b5ec1944d15 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
>   #if defined(TARGET_SPARC) || defined(TARGET_M68K)
>           /* Sign bit clear, all frac bits set */
>           dnan_pattern = 0b01111111;
> -#elif defined(TARGET_HPPA)
> -        /* Sign bit clear, msb-1 frac bit set */
> -        dnan_pattern = 0b00100000;
>   #elif defined(TARGET_HEXAGON)
>           /* Sign bit set, all frac bits set. */
>           dnan_pattern = 0b11111111;


