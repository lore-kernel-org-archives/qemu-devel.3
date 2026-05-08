Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F2CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 23:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLUOu-0003eU-Kc; Fri, 08 May 2026 19:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLUOt-0003eM-EB
 for qemu-devel@nongnu.org; Fri, 08 May 2026 19:14:31 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLUOr-0002Ww-V8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 19:14:31 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479d37e7d7fso938853b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778282068; x=1778886868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxITso2L1WjtW6GxlAH6k5t5JemCg53Wy4drXzRJYl0=;
 b=OhXDr09o2dWGhoqEM9WV55mgr9d96oZot1ceyh58JQsW15poTe0nd4u/mgAplvnb58
 +cCOb7yP8cV1VzVSYqOlXWWsWeZmn4U3CsBd8jcwfFa9PbJo/a0e0J1jUONtdQYhHRwr
 qY2chPpJaa9zpg7tA7jhqcES01TwfXSZcoxZSrw+1c4G2xTv9CJd/rR+0h6ehYY6eEx1
 PR7jj85No8sXKDxzUB2gNskTzea6C1Xe3CkhGG/MZkX+txud1/VxlbDyN7C2hS3rifIn
 2Bunjm4lTOeDZmj93x/Lnt7nZM4+DJecQANYbPvY6wM9SCn83ux8559+OlB8o7UxCFzR
 QRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282068; x=1778886868;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxITso2L1WjtW6GxlAH6k5t5JemCg53Wy4drXzRJYl0=;
 b=nggs1ISOUW0zNs7yP4Vu/7Y66h+vGArKKTXmbLf9uzxBh3y+GD6MjXrWoYqt0hprcC
 tHN1PsV9qjX4CVv9BzFfJ2y+Gv45CFMy7sadvBAinUZg7WDqZNBWmCgd4WpWpgn/pM0K
 a6LdhGOzIxIkaNCnVZ+LNxj9Bm9Z0rx2DPgnhkgNokkgsaIw8j/qdhLQEKCHI83Sv4Zf
 4irnip4N6TIqBRQ8HvTszPy3aVqLqv8LCpb1/v91gOSawQaUgolgfEim4a3KpGpvGocO
 keRB0RMsLgN1tlcdobiMViy+ktwqj2XRSuN4fpOZPNHk3TD0N6tdiSXpbblWeXcdawx0
 /Pzw==
X-Gm-Message-State: AOJu0YzAMkY7NgMJos6wLwb0RhQMGJ/vMwOzD96pGf01ks4v3KS2Ycyp
 ZsFZRWCpY0iezRTyWkfkdWujaDu2dN1snvpkWchtfodqpQixgIFVQfKhDcoN0L8o/lHv3319dEW
 T9teL
X-Gm-Gg: AeBDieuce9bp1YihC/WjV9xDh6kN7vwR4NOWLB3wzJYYXucFwV311NjTEBcLnQCfX/o
 cGqVHNoKR9asyy9EVx+uzasVEQkD6GdScAzpg2O/fMo60ZogWFnwfT+TU+VO2udd5MdeFzJZ868
 WOqzTP578ihHc/FBBKsN8ng+8m9D90fygbjFw27ooiQDA1+Vqx/J8H6nm9BLHsU95NP9M3RBcmq
 J4+IcEPCzkbZN7/OjqtUC7Q3Nb6dNvf12KwS0vrrUNFrfks5IX11n+1MuHkxSpUOXQl4ECNycGc
 bW2a6jBRXJh302Y7eao/nFxUf0Y6RCrVluC5Ezc4OxZLJZI9SHKQgV7KjkKZMyphQcay8bPBCl1
 pdz38xZEhQB/dhyZGf8TetRrhkHeKZE1B2lqY1HF+OVJOpLYL0ClPyK3M4epV9KPWqRYvbiiin8
 MRurMXPY9H3GC3VBUU5zJj2CD6jHit+yAt6eKepTM9DLANc+LI+kqnE7x9FMmgGE62b9r8hVIgt
 JVR7iXB10veN5BHGLDwTfM8GzYYK0E=
X-Received: by 2002:a05:6808:4fc9:b0:467:2a6e:adb6 with SMTP id
 5614622812f47-480420d6d4emr8579968b6e.8.1778282068403; 
 Fri, 08 May 2026 16:14:28 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:6e19:130d:53e2:92d2?
 ([2600:381:c938:6375:6e19:130d:53e2:92d2])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435574490b0sm3080426fac.17.2026.05.08.16.14.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 16:14:28 -0700 (PDT)
Message-ID: <2eae4f6a-713c-4c4b-af12-aff5c5134d2b@linaro.org>
Date: Fri, 8 May 2026 18:14:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] target/arm: enable event stream on WFE instructions
To: qemu-devel@nongnu.org
References: <20260505112014.102993-1-alex.bennee@linaro.org>
 <20260505112014.102993-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505112014.102993-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 5/5/26 06:20, Alex Bennée wrote:
> +/*
> + * Unlike almost everything else that messes with the halt_reason and
> + * event_register details the timer callbacks are not in the vCPU
> + * context.
> + *
> + * To prevent races we atomically consume a HALT_WFE and set the event
> + * register. Either way we trigger the an exit event.
> + */
>   static void arm_wfxt_timer_cb(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
>       CPUState *cs = CPU(cpu);
> +    CPUARMState *env = &cpu->env;
> +
> +    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
> +        qatomic_set(&env->event_register, true);
> +    }

A qatomic_set should be paired with some other qatomic.

This callback runs in the main loop thread.

> +    if (env->event_register) {
> +        env->event_register = false;
> +        return;
> +    }

This is always run on a vcpu thread.
Is there a race here?  Do you actually need

     if (qatomic_xchg(&env->event_register, false))

> @@ -495,32 +586,46 @@ void HELPER(wfe)(CPUARMState *env)
>  #else
>      /*
>       * WFE (Wait For Event) is a hint instruction.
> -     * For Cortex-M (M-profile), we implement the strict architectural behavior:
> +     *
>       * 1. Check the Event Register (set by SEV or SEVONPEND).
>       * 2. If set, clear it and continue (consume the event).
>       */
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        CPUState *cs = env_cpu(env);
> +    CPUState *cs = env_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
> +    uint32_t excp;
> +    int target_el = check_wfx_trap(env, true, &excp);

target_el is in the wrong patch, unused here.
It's also being computed too early.


r~

