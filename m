Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5C2D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIADw-0003UL-0o; Mon, 02 Dec 2024 12:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADt-0003Ll-Bp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:28:37 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIADr-0000xX-T6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:28:37 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e5c0c46c3so1117674fac.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160515; x=1733765315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwDodWtD92lzeb7ahkhVWpqwO+w7/2wT/8EXLaQga9U=;
 b=aBrS1yFeVm7Dp/gsYHD/EZ10t7Z+feTp7akdAdd2I06g8+BiyFfJiLoD9uunEcMlqu
 hjPpZ+cw7Hy6QRppqgmii4p1ucGnd1eGU8lVG6/LWR/+sGg2oqAkkkKNbOdoS3VkjN2o
 JdNOJY96UBEttNEAkdXl56xo6NLfuMEYVXe+2bWs6toRJS4Rmt6OR6DujUZtniellSKJ
 QsGq3/xUpchih8e0Yt2qXE7hhenMC07q4rVx8CcR/xkn9BSpOWddywZzUAYU6ms/yt+P
 q9xyosJ3Hxc9NkMMMM5vfVRC7mHPUArjEbMF1pd6Ox088qbTCADUV6tFEYcdPVqmmFjk
 7Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160515; x=1733765315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwDodWtD92lzeb7ahkhVWpqwO+w7/2wT/8EXLaQga9U=;
 b=WdOKvi/suJqOFOhClgKkdPAXb18UrePik9GXQJ5hdg3yFcCMNHBwayv20JOrbzirit
 DxcnyRcC7qWXJrF7XZzHVadLhjiSZGWoOZlkpQNbYmhfivniWEl07+O5R5WaoN5zS9jz
 y3S36KnRm79/4lbhJTubeskENeSNGHTyRMobhfd2i7cSamNGPGJtE0goQpDUH0ZXrJMH
 EcZUYudb/w9GQKVGqdC0byBSqUfFU9JvxjMist5OU3HO1+JhJuYLHll1ODZnoruECjw8
 o1hnJyI/cFpKIEmTVLDY82UQRoyMqxUndvTATxvrg7f6f9cAZL1JYwQnolze3R/C53xK
 WfKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmQnAb/qHIWE8CN07Ic+Z/GOZeznoQNmHO9kMIxBGDefuSnh5aRUc2YJXOcwwXLu+/Uzmdz9mlQ6Gk@nongnu.org
X-Gm-Message-State: AOJu0Yz+QrqVhxW2vQ+eLtRUWXT3hQPKejnACsqoXm43TXi+JTlJqL0U
 pFLIkEPQK9JjKNh6sPaxcy0c6WS3x36/HC65P7KVR2I8cbpiB8L29Z5iCtqgA7qplUleZ8Xn5ju
 yqZo=
X-Gm-Gg: ASbGnctcH+SUUUiTMFiBsj1i+GELDbx9mMXgOYDbvSWwbLMDx2yYmMpe4jszyPf32qU
 LZDmpmZQm4KTHJOJsmK7Bm85xG3XciKoR6sQgY8FYw9ZArqsSS0Thj8D+grvsB+1OL3KZ3nA3qD
 C4mVIRz1DHIW6PCXmkzfXnFDUH60DRVVpd0Uhv2/6R3Ii6LwW+x+YXs3pz6wMrKvbFShyS6m1/d
 Am5tCg6gi+jPPH0e/NajhZrVxZoRAmmUjCzHFVp12k+Gh9T0w5EI8gL55jaLz8S59VuawM=
X-Google-Smtp-Source: AGHT+IGqt5bzHZmXcgja5kcw9wcsoEdmayxDQdI4fyhFMODgrtfcEg4uIp9AJUM/MyiBy4tAudWgSg==
X-Received: by 2002:a05:6871:b2c:b0:297:285e:ecf8 with SMTP id
 586e51a60fabf-29dc4191f64mr20142689fac.25.1733160514790; 
 Mon, 02 Dec 2024 09:28:34 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de92c4564sm3138612fac.26.2024.12.02.09.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:28:34 -0800 (PST)
Message-ID: <287f89fa-19f1-43c1-81b3-b36cf9f93fd9@linaro.org>
Date: Mon, 2 Dec 2024 11:28:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 39/54] target/alpha: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-40-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-40-peter.maydell@linaro.org>
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
> Set the default NaN pattern explicitly for the alpha target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 5d75c941f7a..70f67e6fd4e 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -199,6 +199,8 @@ static void alpha_cpu_initfn(Object *obj)
>        * operand in Fa. That is float_2nan_prop_ba.
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
> +    /* Default NaN: sign bit clear, msb frac bit set */
> +    set_float_default_nan_pattern(0b01000000, &env->fp_status);
>   #if defined(CONFIG_USER_ONLY)
>       env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
>       cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD


