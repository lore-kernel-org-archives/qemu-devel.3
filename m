Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689D2D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAFO-00062n-OP; Mon, 02 Dec 2024 12:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAFK-00060c-8Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:30:07 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAFI-0001EP-DP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:30:06 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29e70c9dc72so516178fac.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160603; x=1733765403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mujbQXLDp4KaL3CDmV1zPQ3iXN/ai15MwDT0HY01oVo=;
 b=a8C+BuX9HsvGMJYQhLu/G0zflePczDp9Jz1jlGyD9bGovGiFqMITGBt0ncofFFHwJj
 a7f6YN9fwWhH4hGE2akBIty+t2kAcGoQNB7GtTmtfugHbmAh5op+cqM9PgM/BrN682P6
 dLyHUKGd9n2tu5Adwq+w/B+Es8asOH4Lok6SEs5EubZUuasLMK/JeYT3tUro5f812/Et
 uQiXAf0KP654jEpwdAKSUApaDPzjrrJcnfCRoPTSZXcDr5Bb9tCEtuCsaTTrJunbdQNf
 CU0jFAmNeRzO3UFPXrkCjpwoSkFlQcEv4RExhM8V0MM7sIWvz6NX636Fz3Yh5PZgpXff
 CGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160603; x=1733765403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mujbQXLDp4KaL3CDmV1zPQ3iXN/ai15MwDT0HY01oVo=;
 b=XQf4T6MWscdfA4MuTpRXrHciD4e0njB+5zGDnqT6Kj9pvbELBeagi8EVW5tQqbknuQ
 l3pZPiyhT1//BViaTLfnjkRGq7sRubo2S6lRDPSSurUB4JWuUzPFx2bm2KgqtVztRedA
 lDMASVvlEgXVl620LB30zVA3Cx2vqQ13n0icVTNDrKsctkVmyf+P3UDRvBNkV/YerC3T
 5coehpPfUPxqy4APzBPc38H21vJI+NWPSqz/0IcPbLaHHEQVLx5NbhB30HkhkfUI7asU
 MX1smBOz5VpR3giEM+0F5j3KwbYaRK9qBSKho46vNuDmjWxwKEk+r9JdFW0XYelT/fop
 1CMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw69cDVVwW3//UAX3yNtOyIsPSVJFyFNJuViP0RxldQUst6BYJWa4hrNd9bTAPXM/gkHUc2tOV0aA5@nongnu.org
X-Gm-Message-State: AOJu0YzlIgH1rv/Okq8jJZdz5K+IwXIw6DzBi4HWKZWD04JZPvWBIlzY
 yaLcvCOY1qY51RSQifW/w2+SPGZKRWjdIslrP1Z31NHIOpQc7n9hXo+nMNqisQA=
X-Gm-Gg: ASbGnctwRlBUSFK1z9fBCABxMMm0CzL95moz4UCD+WlzbL7CK+1XIov7itFmLacZRa8
 2a85s6VWDmr6GYZQ6w0LbZ2SMXkRC5Ar4oPKbexjX1BSGbURy7EJ+U2bBF1nv7Vp9RbWACbblQx
 /+fHyW8NrREkedUbvrl0Y2uRsgqvwxjs5ifhb0tBsAMFTdyGB0jEjqSRf6aem29NHD2gg9FZMSD
 /jvEn2FMe96GoYstMWY7Mz6/U4Rj+B2pwSoh05TTCedjragj16BZU5nRdSQ5iXMGw6SgKI=
X-Google-Smtp-Source: AGHT+IFWxWwqW6oU5QAgj8vAv3pUuhT1jdcIvnRTZDO1xopoLM46l+k7ZWjEX/F0ILPh/0Bf0mlwsw==
X-Received: by 2002:a05:6870:6128:b0:296:cf2e:485e with SMTP id
 586e51a60fabf-29dc44c866fmr18220625fac.41.1733160602762; 
 Mon, 02 Dec 2024 09:30:02 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e421b2f83sm1663164fac.25.2024.12.02.09.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:30:02 -0800 (PST)
Message-ID: <daad98e2-424a-463a-bda7-f74869b89a3d@linaro.org>
Date: Mon, 2 Dec 2024 11:30:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 42/54] target/m68k: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-43-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-43-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
> Set the default NaN pattern explicitly for m68k.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/cpu.c              | 2 ++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 13b76e22488..9de8ce67078 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -105,6 +105,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
>        * preceding paragraph for nonsignaling NaNs.
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
> +    /* Default NaN: sign bit clear, all frac bits set */
> +    set_float_default_nan_pattern(0b01111111, &env->fp_status);
>   
>       nan = floatx80_default_nan(&env->fp_status);
>       for (i = 0; i < 8; i++) {
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index b5ec1944d15..ecb7a52ae7c 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -136,7 +136,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
>       uint8_t dnan_pattern = status->default_nan_pattern;
>   
>       if (dnan_pattern == 0) {
> -#if defined(TARGET_SPARC) || defined(TARGET_M68K)
> +#if defined(TARGET_SPARC)
>           /* Sign bit clear, all frac bits set */
>           dnan_pattern = 0b01111111;
>   #elif defined(TARGET_HEXAGON)


