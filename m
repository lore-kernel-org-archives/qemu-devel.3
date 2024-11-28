Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35074D69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGf9M-0001zH-T5; Thu, 28 Nov 2024 09:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGf9H-0001z2-8q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:05:39 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGf9F-0002O7-9C
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:05:38 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2967fb53621so859229fac.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732802734; x=1733407534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xOiZNbdFZ5kFofrwjYdl/45Dnvm8mHNlwFLr4Bom5sU=;
 b=EzbaxNZ5Aupiil7gh4uNnmAzCn+Hv9NmXnrZJkYIdx5lfQwre2W65MPlnqdemzOEfm
 kRKtgazzZOc2LnuzCTZVywup2yY0qSXUYZRZDNXha2ismRL3vWNozPk7ldjncs82BDFL
 tsXFwMWenZlNRWZ28/T5SfvY9NLZzJmpruu1Pj+RHpgNc3RArFGgzyE5IMTmaD3KmtXL
 GNQrMtOOJNwyAWkrOzKcg//DmFleDadUjIpDL8M692eQoclU+eGOE6te1TmmW/wn1k4e
 9QHk7zRp+QCqdeM9okjLcFXB9ZMY1Wd/gzp1JhO2Y6vqfXywDnXU6soiLU1nGOspc3Uk
 Wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732802734; x=1733407534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOiZNbdFZ5kFofrwjYdl/45Dnvm8mHNlwFLr4Bom5sU=;
 b=wkfPTUsJ1cQ2borZLpoJF3OkUS99eM7AzDoNpctetK/fBQPDtJmHHt1DZtWqRvIqfV
 z6ghHDgtzsuXjghbUZFDB31XMZKwrhip2y/R+CQ6h8DKVZCSoC53ySyXcLiYKA5J6WQ1
 xOCXcafXtLNuoJufFqB+C80TrBiqmhUrmICR9jPpD2Vgf0GcAUjCpGZcO708D1JzK+zR
 NIWK4F/tarWOhR/n/+WY2YCkqw91fsqVekiBNY/0s/pw97NsjnFF7j6X2FuUJX05Vju4
 a020F1TrU7QJ3jiBcA90tUzdlkqfEcCH9qsVuGCxHssOo2FLxJ/FzNJr13unYBlJCwre
 t07g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJyYNAZ82yVJhe/WwNe5EEZs1v0ktfzlFWJV2zQs8lbTKZuxsl4wmGDT9gJSX50AnrMNiwtrrwxXt/@nongnu.org
X-Gm-Message-State: AOJu0YwFNXsFIe1zaApd5xu6GwmBkkb8ygi/ntm4yGSKlmIY7wLN6wyT
 LL8nDaRPTrdQA7gJ5fjwV8UEDqxJe2uoVbqUOLrZhFtwXkh7hAUa1lJerTHwhwA=
X-Gm-Gg: ASbGncuacrN90GW5VNTm8fFKP9Dpff7EwN8hheFbpBIwn39a/FCIr1lRfIoevP0cBCC
 arv6Vz/qm7k/QzEaKZ6Z44x47D5A7LWFRVYcU/IxUi1uJ6Kh0Wg+VK0mWhMFLGEQ/UTD749hrQx
 rV9fHcOjL/RAy0fjC+uAfUI96KE1gBKo8SsUYv5Cs5RD1jlmABoeVFZjk82pNL1ToWgZojd49km
 NfVgDtLSq4AQVFGXtN2GtLJlOWFJyNMCfGbDypezXOTA5xU6HfA5zNPOFYxygNIPUY=
X-Google-Smtp-Source: AGHT+IH4wkKrvCcWep3tAqRl3w6N+m301W+Cd8rcmk19YgLuxNitXg/wqz5ebitKV1e0MHqsNVd9PQ==
X-Received: by 2002:a05:6870:3c1a:b0:29d:e784:1e66 with SMTP id
 586e51a60fabf-29de7845b83mr1603111fac.21.1732802733662; 
 Thu, 28 Nov 2024 06:05:33 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de901327dsm407423fac.15.2024.11.28.06.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 06:05:33 -0800 (PST)
Message-ID: <034e3bca-5324-414f-bdd7-9572dc98437f@linaro.org>
Date: Thu, 28 Nov 2024 08:04:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 11/25] target/x86: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the x86 target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c   | 7 +++++++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index 53b49bb2977..e9de084a96d 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -173,6 +173,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->mmx_status);
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->sse_status);
> +    /*
> +     * Only SSE has multiply-add instructions.
> +     * TODO: this might be wrong, as we never implemented any x86-specific
> +     * handling for the NaN case for multiply-add. This needs to be checked
> +     * against the manual.
> +     */
> +    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);

This is correct.

Section 14.5.2 Fused-Multiply-ADD (FMA) Numeric Behavior has table 14-17 FMA Numeric 
Behavior.  It boils down to selecting the first NaN from A * B + C.  Row 3 specifically 
documents C as the result for A and B both in {0, Finite, Inf}, which includes the infzero 
case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

