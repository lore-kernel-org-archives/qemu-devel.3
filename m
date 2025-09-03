Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB1CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmuE-0004pf-O9; Wed, 03 Sep 2025 08:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmuD-0004o8-Oq
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:48:05 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmuC-0000BM-7k
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:48:05 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61cb4370e7bso9825351a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903682; x=1757508482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHgaZwe20OB2RTNBClXsk7/P1c0TMf7hbNDsoPb8Wd8=;
 b=eNm6uR05HRLqSHsf06VvIqjbhLiBG9VYx6HxiVit7bEHzp/p3+ulFZOg5CQm6PkD/O
 +kdV+nXWVLEWR1tyQGCFBAmmRpQlvYp9EDY8vYsCYIXahN4dHi6QwPoffn2lm7zlrsy0
 6xRxqCtDH1TI7BO+2vFR8B9sGJTWxNBOo6Ig7jwBrQa+xYzqypEe7lwCNyNI/Tw9V5On
 G1VcRWf+bARTwxFruKqMXuK3k6aZkTXQ3qY/iFwSXnp/upbBUFP6mpnrp1qWllxuHt0t
 eeu4Ed79kLK3jfxoGyfjBVbuOr0X4RambFUMf7/64x/BcvI/s0bKSDgDC7Ow42iDbjFy
 B94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903682; x=1757508482;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHgaZwe20OB2RTNBClXsk7/P1c0TMf7hbNDsoPb8Wd8=;
 b=E5nQO1D/0vrJsRurCSRheDNA34V+tiihN4dhPKO6uzQwxmHCpYvCzOCGvAHJ1JOqQ1
 DFISsrnxcqq6kh4icizijeyut5pv8T8KHjmBaANF6bmthkfniBtaskM7Ibigx8NqbRQR
 UULfEdIN0MssmgpXStW16JJoiB0qaPsLPmrKj2301URvRhnKkqEl3JtKeNxAN7InbESy
 rYa6ZNgY/MHHCGxGElLV1hRgWF8WeWCMJxD3HgYN0JGoijGX/T8YN4Wz4Kz8g4buX+8V
 f4k7XXEL4GiXzYtYzRyD1izlJS1+yXL7rQb2kxHNW5vkxtDkQrTpYprgNlxmX4Tqcxuv
 8jtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv73qDkZMdcf5E2/nd6Sdu8zDzY3aE0LjWwF6bYYQ0JMdOaU8eJ/rmuHXLnQTVr5V3gE5FSnApBeSX@nongnu.org
X-Gm-Message-State: AOJu0Yy7Fw5pfk5/ao79/WmdmHpapeI1GRwA83v3X2WhX2cytXieYanD
 ATEZ7BcY3KzC3kKrZS33xW8mTAoEleviMiXWwr7183NfJnU7nHgjDYjIAYPKozeYdEI=
X-Gm-Gg: ASbGnctCP9U6ZCrASADMIZ6A7RfBigfiu0+Syzh9SUbfAuXFencn5oQCmgXR9I452Ul
 x1ffMkwu8KjVIxQ+A49Go23402S0utO5cq7xE9LZ990jsOjGMuQoB4WlcpIuFi+eshMtFKlW54T
 q1mmteHJM2KF14ymMMQo08xPynypgnEjV3cD9/JqH/N6AeJZEfP3zuK1oruPnmvpV1IX7B7qX/W
 ZYJsZhkureA/4GLwiu6gs20WrYWtYxRYK3Iy+ED9vg0Y5BLTwq3TfNr0IvGj3gd/4o6o1irIATu
 MFegn2GYrylnk0NDGisYaGDu6DwTrhgGVs432X88znisUj2ntx0iNk4yCgDohjybqhV27hqCZPO
 6GZ8lDGT5uAKyqP2qLc4KWhDWUxJMgxpjoTYpXCSvctxlr66N4EQlBq5oVJ+5/arYY46RCls=
X-Google-Smtp-Source: AGHT+IGeKUC5JYfdVaeQ4bCb0WZIKWTm2cj0TQNEGnpnUJk17W8bCFTRPpcirfn308Hq0A/xy6Gndw==
X-Received: by 2002:a05:6402:270e:b0:617:b28c:e134 with SMTP id
 4fb4d7f45d1cf-61d260cc308mr14393716a12.0.1756903682187; 
 Wed, 03 Sep 2025 05:48:02 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bacsm12257696a12.16.2025.09.03.05.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:48:01 -0700 (PDT)
Message-ID: <a7eb6a3c-09a5-448b-a27a-812b6dee03fd@linaro.org>
Date: Wed, 3 Sep 2025 14:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] target/arm/hvf: Keep calling hv_vcpu_run() in loop
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 40 +++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0cfe3066c23..b60efdc1769 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2141,30 +2141,32 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>       int ret;
>       hv_return_t r;
>   
> -    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
> -        hvf_inject_interrupts(cpu)) {
> -        return EXCP_INTERRUPT;
> -    }
> -
>       if (cpu->halted) {
>           return EXCP_HLT;
>       }
>   
> -    flush_cpu_state(cpu);
> +    do {
> +        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
> +            hvf_inject_interrupts(cpu)) {
> +            return EXCP_INTERRUPT;
> +        }
>   
> -    bql_unlock();
> -    r = hv_vcpu_run(cpu->accel->fd);
> -    bql_lock();
> -    switch (r) {
> -    case HV_SUCCESS:
> -        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
> -        break;
> -    case HV_ILLEGAL_GUEST_STATE:
> -        trace_hvf_illegal_guest_state();
> -        /* fall through */
> -    default:
> -        g_assert_not_reached();
> -    }
> +        flush_cpu_state(cpu);
> +
> +        bql_unlock();
> +        r = hv_vcpu_run(cpu->accel->fd);
> +        bql_lock();
> +        switch (r) {
> +        case HV_SUCCESS:
> +            ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
> +            break;
> +        case HV_ILLEGAL_GUEST_STATE:
> +            trace_hvf_illegal_guest_state();
> +            /* fall through */
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } while (ret == 0);
>   
>       return ret;
>   }
r~


