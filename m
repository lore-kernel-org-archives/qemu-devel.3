Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C6FA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFg2K-0004rj-9I; Wed, 22 Apr 2026 18:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFg2J-0004rY-2j
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:27:11 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFg2H-000085-JZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:27:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso2239265a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776896827; x=1777501627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xNY5SMN6Q9vv+mz1SxvQsPT4fL/nBBEeWiz67yF1izk=;
 b=CLSlBeNZGvOoiqispCGOwJk+UVJJ3qbGq3l7XP7ekXKva6Y7ZD4Pi8u6kMqvVXl8MF
 S5FRvn/G/YREn+MdUt9YWZ/y10LtCR8iQm1FtvZhMPRpHfe+e3txf/N7JEc3Ge9wNQtH
 QwOvLMeLyQXpVjfyCXdy0i5Gc9DDR5YhtUyfg/lnPq2MtQSabP4K7ZV99yrMf7PpLlke
 4FQK1t+EJfMNT2a0zf4ZivZCYZ1jWwCiUAFEd/037OFlZcXJxFZUdHGjR/syqyZzCGWT
 cqwVjwpLoSE/ap2c9X2Qu/7eFpvXRhNGQtkGQ6jakLKh/oJAkIzZNujhWBqYtbMeXJhW
 7stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776896827; x=1777501627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNY5SMN6Q9vv+mz1SxvQsPT4fL/nBBEeWiz67yF1izk=;
 b=FlSZACMACLIBGRMZlG04yFKJ8IrOfL8st9xYbPvHraYDPIebskZZrSc2wazC/KE00x
 kUOODIpgqYLUHBlCOZL1rwKrf4veysUhgQD1wpnSMcLQDRzN3EHsm4ujPQ3uMqc/cQuX
 R8C5HN31e5CeJnhWatEg5Db28zv2WWI1pd4CZPV5XwVSGIjxVr4KoZDa4U+9ySZRzjJk
 qQR4wnae/OMRCCINHgqY1oa1d9e9GQjUtsbb/9GkMfJj2Scj7QSDG+mWGi5xPoI7Wuj4
 2G02hoGSu2POhMF5pGAXOiGDA1hfLDePaov7CpoIDstWsPbzTUoAKGD7TS1sw7H8hxEg
 eO4Q==
X-Gm-Message-State: AOJu0YzAWMNrZ37k/tN+s1gnrYd34vhzH8lf0KJXvEhyGAFBSoFXs9Cr
 gfq9Fnh0hxGlU4hV0Xcpof5LOAiDq6puw0L4dK0BMUjFexBR8jBKa3Cxxj/NKvyBJOHQXn2WlIX
 pOH4qgiU=
X-Gm-Gg: AeBDieszoxY0bSpo4fsH2bo++5DuhfYydIP+pOIYHBBdd8UPbztjsQCaI9cx6g2RkwN
 qQnvtFI5lap+TFKfxL+GiIB+ulAcQgfsJ0mnFGc+Vq5DYxGkparEXsB6/1cDr7pZvFWATZSHjIB
 Ffrmb7v8aVZ74WJI0UdCO4I+6Sa2fMPMgx47A/NRS85uIFRQrHcnoDPJPl0sMyUp83yFLLEQ15R
 wvc8OlOJuUDXtTJ3dlvVryVuJuCSzdJbgwPOdkI1E8g4bQzrIBfJlTyVGzVba1/Tn4B3hrMOTTV
 dei+p6pdQ33d485vNc9dgcb0U874nyCMVhtryTp1ZDuvtu1XVF1Zcaw6Y2IQ0A9QhQWadKe4ikW
 tFa5xRXVbkK6hnZ+QYUD3zNsnwmNQacpw8X8bvCo7hgFt0JRmHOvcP8cAUq7FArRPoDJEnI4oAU
 GnScgDOQMeZmYO1DpIJ1hDnLkNYQ3wQM9+tvMyb3QnE7Wvfd9v2w==
X-Received: by 2002:a05:6a20:12c4:b0:39c:c07:1450 with SMTP id
 adf61e73a8af0-3a08d8a91d6mr29658278637.42.1776896826957; 
 Wed, 22 Apr 2026 15:27:06 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797701d880sm13563314a12.20.2026.04.22.15.27.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 15:27:06 -0700 (PDT)
Message-ID: <94efd8f6-13a2-4ab8-ab4a-1219a17441ad@linaro.org>
Date: Thu, 23 Apr 2026 08:27:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/32] target/arm: teach arm_cpu_has_work about halting
 reasons
To: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-25-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/22/26 22:52, Alex Bennée wrote:
> @@ -1691,6 +1707,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>   #endif
>   }
>   
> +/**
> + * arm_set_cpu_power_state() - set power state synced with halt_reason
> + */
> +static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
> +{
> +    CPUARMState *env = &cpu->env;
> +
> +    cpu->power_state = state;
> +    env->halt_reason = (state == PSCI_OFF) ? HALT_PSCI : NOT_HALTED;
> +}
> +

Not really for public consumption.
Better in internals.h, perhaps?
Unnecessary parenthesis.

> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index a788376d1d3..4ca63a54443 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -78,6 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>   
>       /* Finally set the power status */
>       assert(bql_locked());
> +    target_cpu->env.halt_reason = NOT_HALTED;
>       target_cpu->power_state = PSCI_ON;
>   }
>   
> @@ -186,6 +187,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
>   
>       /* Finally set the power status */
>       assert(bql_locked());
> +    target_cpu->env.halt_reason = NOT_HALTED;
>       target_cpu->power_state = PSCI_ON;
>   }
>   

Not using it here?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

