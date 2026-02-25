Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C4FD45EC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvM7N-0001DF-V2; Wed, 25 Feb 2026 16:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM78-0001Az-0u
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:08:12 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvM76-0007XO-E9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:08:09 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8cb4136d865so7382085a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053687; x=1772658487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YO2TpS1dPnzmQ2/STtbXkMTRFMvcPo958JRS8qgqZwk=;
 b=LUgIQpQ/bLalVTrRnJCNxyR0f6fySooDEh17CcyiX0orDAQS8l2d/Q/xlXblvW46TA
 u1Yuqwo+cS6i0wxrXVGTfKJhVstLs+tIg0wkmktgJYrOp4W3rqWEYXUYOlFtFc/LLfbm
 wVqoGAAjF5u/ykAwsjYgJGpvo9cjGfDtpTba30jBCs3k2Ug/d04p+4viqg01T4snUrhA
 4SeDs1ZwcfCXSGhHQk5JU1WKmB5Wrs2vWDUh4DoDSdTBfhAjbyKYOgxFX9Tm4GxMwFUL
 X1luIAYsbrC+hykPt/gG5fLme9GuTAjxH0IgVz67eoA2O8jSLICAf02+taA1u1GmR47C
 5y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053687; x=1772658487;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YO2TpS1dPnzmQ2/STtbXkMTRFMvcPo958JRS8qgqZwk=;
 b=fGLbAFm3JzS4hPOvNiXI4QZoCOPGAexo8IgHXOSyLMi6qxvCK89zsGefjVXaSpGtPb
 ulYT6VmhS8j9i3VJ2BRlgSdXE8KKIDaoXMeuarq+ctLphsrsGJQYYD9Oj0xadZmG0yIZ
 ESuQmFb+9tvNFLimm3RDhwnxzDiSY7QClaK5gqBM2x22FsNEsoi2o6v2gIVIGhT8u5UN
 ZRzwR7DMXua4RQcgg9VE49u2H2fIbQx9MIYcoZCMgoQCdvGC5Oked8HC8Pa7V8yXx7TU
 244o/ESwpd9OU9/2INpSVJQOtXR7ZImW9rsy2GuO2I9ryCFUhW5WnIVg0TXnFQiIyWRI
 2JYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFP/UzCAeHj7BwRKDSs/qqBxgQc32t/kwal2vLzzAHr+AA2oUazPXckGB0Ibn5oWYoh0Q70xCNKPg@nongnu.org
X-Gm-Message-State: AOJu0YykOnYBLygNaAQFVydHaGjC13ZddNSv/aLyv34rszUHSiGEEjqr
 aT90tcGdLpo5ETf6i4Bmnkp6MnnJja+c4yTn0kqr2JrSV0KBBIJ39jRY5ZSWkqVC4Y0=
X-Gm-Gg: ATEYQzzrDiLoDIQgiAVnosY2560M4Ut43cZ//V1R0nW7tg5EUJzVdjw6k+cFLhLM4ER
 UaVzdKhHQr0U5GoX/sppJruvYZCBwsfVt3j7ohG5wqh1sa2vfT0QHJhsx1l0m7Ler2BdfO209j2
 PN8rAJpUScYBgoiudFGCfLfDXUlkY/P1hUTJKov1hDSiFu7xw8Oxxk2NZtZsca/Kk0N77OBkHF5
 pnxkXHQTDZ7fpL37PRLKDj5g4lOcC0iF68WKOzX9FCPsadneB1sNcnIR9u0vZrJtcymtlcIxJgB
 X4EfklLOJTgrYu0DKdmIxkvlX8QZJk54ywuIbmn1RVM8weyyYQUeb+Kzf1HKagnEbC3gCL7b9c6
 DbatB40K+JHajW+qSqxnAg6/ls4bOjoz35mqUeMQOqCWoLnMKSxxUewVwOGAg5MRsp/05E9+Qow
 ZdlJ9TMf6DyFktyNQv5AxCgSXRmUFFHvohc2UBAKFfE8p5fZo=
X-Received: by 2002:a05:620a:1a1c:b0:8cb:2c2f:90e with SMTP id
 af79cd13be357-8cbbd01043amr273097785a.39.1772053686803; 
 Wed, 25 Feb 2026 13:08:06 -0800 (PST)
Received: from [10.34.149.227] ([172.56.178.189])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf659210sm26532085a.8.2026.02.25.13.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:08:06 -0800 (PST)
Message-ID: <91f7430d-b993-43b8-90c2-d06b07525c31@linaro.org>
Date: Thu, 26 Feb 2026 08:07:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fpu: Fix unexpected exception flags when converting
 infinity to OCP E4M3
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225110802.1217946-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x735.google.com
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

On 2/25/26 22:08, Max Chou wrote:
> Infinity is a special case distinct from numeric overflow:
> - Numeric overflow: finite value exceeds format's max normal
>    -> overflow|inexact
> - Infinity conversion: input is already infinite
>    -> no flags
> 
> This commit fixes the unexpect exception flags by relocating the float
> exception flag update flow to be outside the uncanon_e4m3_overflow.
> And raising the overflow|inexact for numeric overflow in uncanon_normal.
> 
> Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   fpu/softfloat-parts.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index a738758aee..3c323c0cec 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -277,7 +277,6 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
>                                             const FloatFmt *fmt, bool saturate)
>   {
>       assert(N == 64);
> -    float_raise(float_flag_overflow | float_flag_inexact, s);
>       if (saturate) {
>           p->exp = fmt->exp_max;
>           p->frac_hi = E4M3_NORMAL_FRAC_MAX;
> @@ -388,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>                   if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
>                       partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
>                       exp = p->exp;
> +                    flags |= (float_flag_overflow | float_flag_inexact);
>                   }
>                   break;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

