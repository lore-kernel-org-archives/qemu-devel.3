Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D9FC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMhJ-00077x-SL; Thu, 19 Jun 2025 17:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMhH-00075J-F0
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:21:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMhF-0001X3-Of
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:21:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23602481460so10428195ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750368080; x=1750972880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7doDJ/db68rF2p+uzrYEnFpw7Z4rK0fC/W0sdHwMSU=;
 b=WZEyvzuqB8nbAoS+XdYh52kfkMbkBPKmo8mfGMmf9aK0wAvEcRkENM/+EZVHy9x+nV
 1gysGEr0rD0R+XlNvoNXcyFrhTVZ5NchxIURG7GOM29+u9VpS/HrDSSU2tAXJiGXeAWz
 t1bohE73c5yUqQg2J/mumrmj8ao8JPzMy3FRdBcw/O40POA6DHyfwNa2MAED63LuxieE
 77x15q/DAIsfq7B/dgNHcGI349beUrPySagcnPOKFb/fKRy99lOh/kDyXPZ6SLhHN9QO
 3i/wa9H0tPtPpkq0se7R5T6Eq+hE5XIy1F95DwhHBacRVqSiCk+cjHN5L+txo+zRUgx2
 w3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368080; x=1750972880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7doDJ/db68rF2p+uzrYEnFpw7Z4rK0fC/W0sdHwMSU=;
 b=ubEL7Lm8AAqRWlDGQ7ZZzPjNxcUdKoNFKT+yohAEBtWH5CSPwmXNQ9LUuHNwkB/PF3
 3zWnuzpG4obD15Tc3fUfuFn244kpD3dpjetZLiKLp4XTftQQAGW29RBvP7JO9cTSTe9a
 lSw+QUpHnnRsdFybcMWl0TrHIlg8QkNYTe090XsxxUY6KkfkN7LQzA9O5SS4V+gFDF+/
 p2Pp8FWRAKKDKBiOnaoC9eSthYe7rOZjv3EbJcw+Kkg3etJNvRF1npX+glrAV8tcDs7o
 cgrG5S5LwqRLDVgERSQgchUflUIt5uPkznTMVwUTlasJgBx5j2aVgn9sYSRGUFaWodR7
 1XLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegU7fUzERhW1Q/4410tgZjGhvjU/yUSS6949BqKjnuoGWeeazwUnbHQpz+OVIXu43pf4pnRSWZGMU@nongnu.org
X-Gm-Message-State: AOJu0YwW4wSXkn70QYyXuoOXfvxRsFytGUxqy7aT2BeLZpQGXLFcJGdA
 jaPxofypdUOO4gdyDSI862jKZAIeaspbbPmfFMydGB3t9qBF3+aXTOzJAV56ns9kgj8=
X-Gm-Gg: ASbGnct/Um7Snh7JhWHChCx9JQXHAj0iB2lJjCBPk7h8vN1gQSXMJXp91RwHY2J1R8Y
 tj51koKc6+4XmApUoczGiPcJOBjkBsXHf0qHQo/79XWzEcLHKqvkyPeQVTNbQaOglOa+JP0O2zb
 dtnWD8k17k6HKYNVXXvNLUkVnyUYQcD/23Xi3UFcDCwYvWqwchL4sE/Tj6ZEtFjtWuZc3LvL6/5
 NOp72PCms0PjYMIuMYqtvhI2ExQFV882Dpae1ZgVVZgtfAECYD42oMbouhDHJ70Q+qxlC5j++6D
 IkarS547kreg15T84NWHUx//tc87mk+7Thq43J+oDNUPJGM68DjypQnui6gpFzxACnVPAAfkZRS
 sN5F9ed/PWwZ5aaSuQ3O14bUoznsF
X-Google-Smtp-Source: AGHT+IEQqh/Ubi30Rlhodjm07WoXtVXgCHZjIMNF0osC39PpDf2E1+Yoz8NZp47g66fZPSIGvjBMug==
X-Received: by 2002:a17:903:4b27:b0:223:653e:eb09 with SMTP id
 d9443c01a7336-237d97c7f5dmr4839435ad.7.1750368079918; 
 Thu, 19 Jun 2025 14:21:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8695195sm2424095ad.187.2025.06.19.14.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:21:19 -0700 (PDT)
Message-ID: <b2e91f99-a0de-4740-a100-c006d4577db7@linaro.org>
Date: Thu, 19 Jun 2025 14:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] target/arm/hvf: Really set Generic Timer counter
 frequency
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
> not correct because the timers have already be initialized
> with the default frequency.
> 
> Set it earlier in the AccelOpsClass::cpu_target_realize()
> handler instead, and assert the value is correct when
> reaching hvf_arch_init_vcpu().
> 
> Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 632751d1eab..fce02d22ef9 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1008,12 +1008,16 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>       CPUARMState *env = &arm_cpu->env;
>       uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_match);
>       uint32_t sregs_cnt = 0;
> +    uint64_t freq_hz = 0;
>       uint64_t pfr;
>       hv_return_t ret;
>       int i;
>   
>       env->aarch64 = true;
> -    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
> +
> +    /* system count frequency sanity check */
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(freq_hz));
> +    assert(arm_cpu->gt_cntfrq_hz == freq_hz);
>   
>       /* Allocate enough space for our sysreg sync */
>       arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
> @@ -1080,6 +1084,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>   
>   bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
>   {
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(cpu->gt_cntfrq_hz));

Worth turning the inline asm into an inline function to avoid replication?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> +
>       return true;
>   }
>   


