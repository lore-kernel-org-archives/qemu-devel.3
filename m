Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F9CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmmu-00082w-Ry; Wed, 03 Sep 2025 08:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmms-00082B-UL
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:40:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmmr-00065U-9p
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:40:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-619487c8865so1656110a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903226; x=1757508026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=92pQNbhDYD6JTspyvViEeknOzi/ZkGvtt6B+3bP0b5Y=;
 b=yZxjpZ9BryvngiV0v2SyDrpPplOJVdRHMI5aW2C1muW8YHnMdSQLE/wgAJSFSHs0pc
 dmhKQ71AE2i0Cf19maXUmAji96EpFRBpISLvo07sMMczTvmyNc2rZNFGj5cf269WlZx6
 7xhL5VIxmmQEoBB/vOFiQTzKWuR6w3hlh2m5uq4LF7rVfOzSUzVHb3Io6g1utLJ2s6xI
 ybKn3mEOSUKH+EHQggfXX5ON6i8ZoHC1egl7iKpzUC79kya9/8MBjRf8sR3DzbZQ1aS5
 /UQNNkHgYWI3GSj7gLJE7xDsExUPPefitCou8Gmbif3j10gY2JK4rttUTXcqPzI50gmr
 wvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903226; x=1757508026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92pQNbhDYD6JTspyvViEeknOzi/ZkGvtt6B+3bP0b5Y=;
 b=agcvkokKx7WRCzW8Ur3GIu/40h5HBDyTIZoj3TfsHa7k96PfpSJmBQ/yMZXcSc3SG/
 6XEtJAG5+ZNC9Ph7q7kxvkUKNlvv0avIQpv8g361i7tOBENCzolozEPoz9syQGfzJcXk
 up0XWC6cH2ZEWfjGAyV3mfWENPNnxzNUkEYu1/wCaKUxTwU2VGIZNHyR7LizCfEJfJCZ
 fasU8x7SQIQka5g3GldYKM09P1rk2WVsUQEt0twOCFVFz8kqrPXHI7qWQWV+0iaYpWq+
 t/0aiOsR0F2JBm1vsOZA863eri7nxHvInFeCUZRSOfqma5XVMHQzTLb15LkatgS3iFg4
 nH0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp8Kk0OL2/Pio6zTpM6UifOd7BoKbn49DVYvfU5adW8glhuOW7eWnOOf6BUaH3zSy1Lm4317bH5Z3t@nongnu.org
X-Gm-Message-State: AOJu0YwSKbs4owJRSzWxp4oDQVXWg5yGZ2mWCaLZ+xXocRmIDVTEjfdY
 OX8M03nEmQZYfIQoC/up0ob9rcubGB/odFgMZNDBtV8FIoFpXQYWHJ5ED/Mz3602ZEk=
X-Gm-Gg: ASbGncvR5K3aFeR532tqz1ewr6I5o+yyq5gr77dEqItcDtxlUhgiqKy4EtZ075at+ax
 ltkljSPjj77ghly+RP/KU4iyE8ams8m14Lt8FEZyEPoBwL6nLmMSwWiDG8QtRA/ii2m64CcFzBX
 AoTmrV5bf16NF2N8/9iPwLo4FjOsJi/PpZxEVOoCmBvC1cowN711ydHj5SRxQhacQM7ByjRDW8O
 YFoWY+bf5XFcxm1yoOc2J1m9sTJHGxqNQ4kldn5rjtroA1aTyulePqQbO8lu9uRQQVJrMY2lOLk
 PJPSnQw+i9eoNFKyOzxWFJQWa1HWiVKrHZLyRTna12puq1191DKlKia9v/Mbpk1VRv4VB8yc/cU
 yUUKm/5afNPhaf0jM3v2KNOd3fhD4Mc0G1yJAM3TyM0VHnWzLexkFs5aHii8SmIR1QsiyLdE=
X-Google-Smtp-Source: AGHT+IFn5QyYU2aoHLwt7Ai7cekoXZHTgzO58dtLAZYo3suo4OSLB48OKXC2C27INbRPUtq3tUUzbw==
X-Received: by 2002:a17:906:730f:b0:b04:6157:43b with SMTP id
 a640c23a62f3a-b046157053bmr366844066b.25.1756903226375; 
 Wed, 03 Sep 2025 05:40:26 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0416842ffasm905026566b.38.2025.09.03.05.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:40:26 -0700 (PDT)
Message-ID: <b0890e8d-011b-4501-b500-44ec9772f825@linaro.org>
Date: Wed, 3 Sep 2025 14:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] target/arm: Call aarch64_add_pauth_properties()
 once in host_initfn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>   target/arm/cpu64.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 26cf7e6dfa2..f81cfd0113c 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -762,20 +762,20 @@ static void aarch64_a53_initfn(Object *obj)
>   
>   static void aarch64_host_initfn(Object *obj)
>   {
> -#if defined(CONFIG_KVM)
>       ARMCPU *cpu = ARM_CPU(obj);
> +#if defined(CONFIG_KVM)
>       kvm_arm_set_cpu_features_from_host(cpu);
>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>           aarch64_add_sve_properties(obj);
> -        aarch64_add_pauth_properties(obj);
>       }
>   #elif defined(CONFIG_HVF)
> -    ARMCPU *cpu = ARM_CPU(obj);
>       hvf_arm_set_cpu_features_from_host(cpu);
> -    aarch64_add_pauth_properties(obj);
>   #else
>       g_assert_not_reached();
>   #endif
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        aarch64_add_pauth_properties(obj);
> +    }
>   }
>   
>   static void aarch64_max_initfn(Object *obj)


