Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFC4D7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAN2-0004hW-CQ; Mon, 02 Dec 2024 12:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAN0-0004aR-6o
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:38:02 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAMy-0003dk-Oz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:38:01 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea36b05654so2259588b6e.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161079; x=1733765879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8+nHehsC8BRradJMcn7F/iMrg3kS6H9BcBMk0Pyysfg=;
 b=ElM6rOUcffCVb9Ro7ADaqJBLHQcimyM5+xqDdcTp5jG07NLg2wAAUqwsEEAWElcnqT
 9CXZFTnOH6DsfAhfk5bO9LEkfLYF0hythzgBxH+v6LmTuh67qVhREax49gIaUoaHtXtg
 3qCnq4PYd+93xLg3iab1z7TBVZQNi+AGa8z1/iHpRP8t7mvdenAaIBEyoGBOW5tutY7N
 FFM3Z0E+xOfS+MXZzU6YlvEF2AnGqJ62u3CQZtfxRP8fW+8UFb4Jxm3Gkb3pCEwc71eV
 tqs92J2WggY66mBesEuMFukDjtJLNp/y9kbBO+ZasPqJFG1jdAVgPCOWEkdX+icfoLPc
 4wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161079; x=1733765879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+nHehsC8BRradJMcn7F/iMrg3kS6H9BcBMk0Pyysfg=;
 b=RNyqIa0kvAUDYPvqGjKMNGXVXSBrtVms4kT2TJ/HhexCcZq0obPwqzZlDEAv6XfOz1
 Y4ln8Ojsd2jHvyAvnC3lYf5VWq7g3OZEePspqB4Q7RyAmzdOmVRWLt7S9O4XiG6PSSUt
 lmVJqltkmok2OcpYiUoqJkTfHEfxvgN95pRgfuh9k9YEkoJ4x/ltCA7JZDi9TfN3Lhwc
 otJLm3bE1yRdC/vsfD3O8r5WSVf1Xd77drllsKOKNbrFGz1l/B08UDtpGD/pFq2dBVS0
 rHQtSbMyfGYZBc88pEJmlQkzppfOtyv3wF1c0i+8LPxWSGIYo7vJDljey1FK1kz32Xv+
 yY0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPKLhtjjysubUv3J4+BVpAMLbG15GlDOMmxTei06MXKZklsy0kAw0uZjX/G3poBW27hzpM3LFiryGv@nongnu.org
X-Gm-Message-State: AOJu0Yx8cs6C63+XeUbIyTWDTvwycIEDb2ardm/WE4Ntgn9yanTUgrjJ
 XGWqIdp4DFJRh50rI5U0OROju3kaS2IDGkC0BdNzLte28sX/wquEk74sqxtjq6w=
X-Gm-Gg: ASbGnctT+kCFiVOwuTYT1HHie5HbmmYA60yu2SImwBxMD47Ls6E4kkiNYavNxofVM9p
 4HzH0j5cAiOP4VQcjI6/dMxOVRATSIB5VWPmGIFu/TLOGTVu8ujt7+cjxdvbZypEkma+/9wkkOU
 7gzTt8YHJEuZwZkcHMqNV1rN+tjDshvBq/3l0sWYiYzER9E7VmzUCu5AfUEn8M3DH9OD4SkjuT7
 MjrGrbQYQpDQzagr8NUK3Ts+SLKkhd4dU3KLi6aWRY1bMlrFAbM57L0bmopraEFd8tOmVE=
X-Google-Smtp-Source: AGHT+IG6uCKLcYAMdEiqd1mCTPK46FapY9nk3sYvCBBK0Igf2PRUzXcuzEWcaqI4jyyjFRR1hi4w1g==
X-Received: by 2002:a05:6808:f0a:b0:3ea:4be7:254b with SMTP id
 5614622812f47-3ea6dd29936mr17819684b6e.28.1733161079430; 
 Mon, 02 Dec 2024 09:37:59 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8621131bsm2381031b6e.36.2024.12.02.09.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:37:58 -0800 (PST)
Message-ID: <8c2fc603-cfc9-4e00-b84f-6172f09b6f78@linaro.org>
Date: Mon, 2 Dec 2024 11:37:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 50/54] target/xtensa: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-51-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-51-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
> Set the default NaN pattern explicitly for xtensa.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/xtensa/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 3163b758235..0d4d79b58b4 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -136,6 +136,8 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
>       /* For inf * 0 + NaN, return the input NaN */
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
>       set_no_signaling_nans(!dfpu, &env->fp_status);
> +    /* Default NaN value: sign bit clear, set frac msb */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>       xtensa_use_first_nan(env, !dfpu);
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

