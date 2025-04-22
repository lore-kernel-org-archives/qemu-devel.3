Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F3EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hrv-00031F-4S; Tue, 22 Apr 2025 13:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hrl-0002u4-UO
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:57:06 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hrj-0002I9-Q5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:57:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736a72220edso5512056b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344621; x=1745949421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mcSq2AmetvHUxbePSkhygW54kBea0LV12LXwOsYBGjE=;
 b=q/bUed3C96+igpOexAF/dBL5cuhsjQnrwyQrqClDXUF0OonZVCxgOBs8UBxn9m3NvH
 VBAlrH9KOg8KShWZJcYDz/FhySML008ldvU4aBoxpjUD4F+7vtNz8ulTOGpjy+2KmZ3Y
 f7UBHR7xf0Bb5YiPygsHqkA3/+Tea4VT3YMi07UohBchQQhtU4QJPdzG5Jba/gyp4QMH
 +YWONTq2hvYZYL/6msmJbMKqhibNVuiMtiPYz3JVdKbUYXhoQLZFXXyldpqhRTjSgTw6
 nZ1TvnHbvyi3PGElmikoiJlkoYiIhpD05snroDfytEf4Jbd2A4YBdWHeNsNxDf5VijZg
 U5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344621; x=1745949421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcSq2AmetvHUxbePSkhygW54kBea0LV12LXwOsYBGjE=;
 b=Dp3I00/3jq+NLN4oplQ/pBkaDxai14s7zp3L7mQRiGwRuE7DZ1TW6e6BRwwlMB+4xP
 kD6o8PKSs0cJq0cRuJCIbEyqpLyOxncq5aH+Sa/P/63t6xE1ScHq1Smsyz8W54ud3Q7i
 j+kbKsh0KqUKW5Ku7imxT+ZHtttPz54+zU6rMGyaaEBo/C/ofx1soa0QhJX8FaQkgFOW
 ANOp9q/g+g7VHdtLN234+moJkmZTuGs3p6dCyyUh/bwD1k9EQYCq08X3j4Xkkc8YglYl
 Q/jnQRMpTYvrFsG2W8Rvd6ZI4Eu7TzDww17Fnhxi3VTdufAE4gL9BeKajmUF9dbl9hSG
 eRkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAF57r8fkB8kHUUsKVcpXCYG6uitTM3MpUts94fxv1C8VETVhohvq0LHRC0to3XlPN/WPwJrzCEtDc@nongnu.org
X-Gm-Message-State: AOJu0YztYnohNOqbjdDi+aezy/IR0AMk1dKqOHzEB+BNPJaWERsBQ13m
 QWhM8ItoV9B81SYKM8pzTJdbhslC5y1ysk4Em7TQvIED+N8Thmy090PZcRFHa38=
X-Gm-Gg: ASbGncvMeGnQkKtNpl6z1JAjaDfs97WQZnOGJJ2uI9uvafxW3d1FMLWXDkDPSJLb+ve
 Z92jquiy/MzrKXktJPEq3ZTKaRSwYQ/ZsC+GFayKOZEc0rLMIfhAd+ArwcAGqh3kKi8tV9lsuMY
 +vlOxw2o4HNnZ2L/PMPMbIJOlGjcu9yp5V7T+X3UP5wAD4Mf5S9hhWQfvZaWJNFlJgQE99boXoc
 VEg0P6tERLIGPOQ/64fvtmS3j5dMTTvzl8mnuse6VMgY1G7Mk9AmuIzjwRDH1X7jcy3eSxvV4dO
 pVx+lIev6j8LSPS4z7GgjH68rLAL0o8XRp6t2U5deYHnoKKgO49To4BvPXj//hu3wE1sN42JcUk
 VoVgRRsg=
X-Google-Smtp-Source: AGHT+IFcQaxY6b6GHl/vXjRjFbnATfQ2D2nFBnQZk6EfYpRB9AY5vSRjTZE66Ly9Zcw1lbx52Ky2jQ==
X-Received: by 2002:a05:6a00:8d93:b0:73b:71a9:a5ad with SMTP id
 d2e1a72fcca58-73dc15a06bamr21581055b3a.16.1745344621572; 
 Tue, 22 Apr 2025 10:57:01 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa5d084sm9209669b3a.103.2025.04.22.10.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:57:01 -0700 (PDT)
Message-ID: <f4126274-afbe-434e-9d83-e534e471ec41@linaro.org>
Date: Tue, 22 Apr 2025 10:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 13/19] hw/arm/virt: Check accelerator availability
 at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Replace compile-time check on CONFIG_{ACCEL} by
> runtime check on {accel}_enabled() helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c6ae7cc1705..d7197958f7c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3134,7 +3134,7 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
>   {
>       GSList *vct = NULL;
>   
> -#ifdef CONFIG_TCG
> +    if (tcg_enabled()) {
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
>   #ifdef TARGET_AARCH64
> @@ -3148,13 +3148,13 @@ static GSList *virt_get_valid_cpu_types(const MachineState *ms)
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
>   #endif /* TARGET_AARCH64 */
> -#endif /* CONFIG_TCG */
> +    }
>   #ifdef TARGET_AARCH64
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
>           vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
> -#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> +        if (kvm_enabled() || hvf_enabled()) {
>               vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
> -#endif /* CONFIG_KVM || CONFIG_HVF */
> +        }
>   #endif /* TARGET_AARCH64 */
>       vct = g_slist_prepend(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
>   


