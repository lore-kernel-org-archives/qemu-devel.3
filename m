Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F6CC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7Q7-0000EZ-RB; Wed, 14 May 2025 04:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7Q6-0000E9-Jv
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:24:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7Q4-0005Z5-TF
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:24:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so73303705e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747211091; x=1747815891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=av46M68xXgOR7pc4VwZhztS/jiJDHfHlHQ56qBxA2sc=;
 b=ZvpsRp7XNjmDUgXKp/vyT/uYd4cK4VOcfuYzraEZGAp9g5fr6Trj3UKaWmKT81fgO6
 r7oPwiJg3cS+g8YCKNzsRgpoMvnpsB5iBR12scW5YKGlpQn/uvIFojk+ziPsZ1k+iaix
 CssNKeDmquct3pM7eUv2OiC96qNAAva51Gv57TYSk9yuV1NdEZu40Gu/sFDuOp5JvNex
 mwIR3K3EQ8tCh0YhxOeuTmuMbtd+u8pa/2Do9H+LKUNgS3yT5OKSxmdcGK6j4uJWgzC9
 jv8TNjs+A4SZjIKk1wWjT8vSEm9HQf06fj08nAvafVL+2sFfba8iGxefys/Ziz4igm3F
 zfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747211091; x=1747815891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=av46M68xXgOR7pc4VwZhztS/jiJDHfHlHQ56qBxA2sc=;
 b=tquff15t3wScg7TZ/LtbCfHwuQYzQyMlyGc0Hhd7Po6q7tjikiyinzV4e+ce7RsFsv
 Txm/A8xZE7hVY/lXFLOKB2ZPo6wSlJUQ5E0XVwhFyRUvsNqx7q5uMEwrWYFyKtHMuxV6
 sATl2uaPeTtwvWk4mcqX8pzqjvNJxqrWBN06mQ50YXtbjbTcxaUjvE5GpRZ7b7Le2098
 nzy/T+eLcidY10yh61yivqlZzbo37EOgb2l2+WjqEcjwHNbnPI5onbqdaKXqyNgGHvuZ
 LAbd0rxgAx9VVNZtYuO9YZeBK+25WcY6KXUVSvRNz0HFBnKnolEux4+PHISXeurLszSL
 iL4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSW8rKvL8ZymERXtB4wR2MbBAOHQ4TA55YmgT/PwvDc4/kDkeYYFbgF9HQPH0CLruCMMX9t9qF2wyj@nongnu.org
X-Gm-Message-State: AOJu0Yws8fqGo8a2g8aigkFleyO43tyDdcZHSIQxyS63fB7ZX9VOxGhA
 77Xd2/k0HqunmxgnTxWNeCPlsX0Kaqty4BSfDFPFteZHJw2RoACjUi416p2dU+I=
X-Gm-Gg: ASbGncsKi2k2SppNKOMtjGw8Ay9K89SYXyXZGo/8Jv9nwQlV6zn0e7w5fw+S1QLd4u0
 eKun2V6WaDVff7p08wn2AVAfdAUsAQPRj1KwmJwHOnkf6ddwEstQP8fIyPSeCsvi0bm6oLawwtK
 x+d51R2y6JqBOXT//5PalADTy4ce41wIfPeIhD1dplklTkKbbjH1cDlT0dWpuz8hu8gA7KPr64V
 Nyl1LzywyitQP1SdGM2/0C0+AIga1RpQGU4wcxGtB0avIIhQfCF0hceb136oXVPXDEtWgw3kaDD
 CPA1j8FZ4dY/HK0AWnWi0eQjfMo7XEvwR5IUFPmkcXt9ljr6F4gGpyPd0xZ4lOH3VmVAi5qKBqU
 zSkCBe0C2y/1rOPoI
X-Google-Smtp-Source: AGHT+IH+YFi9iwUZmwPVIyB+B8sbdynw1q2z3kgdizkwvZHF3btfx3gEZjaLIrSJBhf3Th13M3nVzg==
X-Received: by 2002:a05:600c:a00a:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-442f20b9ca0mr18553925e9.6.1747211090986; 
 Wed, 14 May 2025 01:24:50 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f338050csm19216975e9.10.2025.05.14.01.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:24:50 -0700 (PDT)
Message-ID: <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
Date: Wed, 14 May 2025 09:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250513173928.77376-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
> arm_cpu_has_feature() is equivalent of arm_feature(), however
> while the latter uses CPUARMState so is target-specific, the
> former doesn't and can be called by target-agnostic code in hw/.

CPUARMState is no more target-specific than ARMCPU.

Did you really mean to use CPUState?
Or is it merely that arm_cpu_has_feature is out-of-line?


r~

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu_has_feature.h | 2 ++
>   target/arm/cpu.c             | 7 +++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/target/arm/cpu_has_feature.h b/target/arm/cpu_has_feature.h
> index 2adfccd9208..352f9d75bed 100644
> --- a/target/arm/cpu_has_feature.h
> +++ b/target/arm/cpu_has_feature.h
> @@ -62,4 +62,6 @@ typedef enum arm_features {
>       ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
>   } ArmCpuFeature;
>   
> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature);
> +
>   #endif
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8c9d161f2ef..759636a3b0e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -54,6 +54,13 @@
>   #include "target/arm/gtimer.h"
>   #include "target/arm/multiprocessing.h"
>   
> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature)
> +{
> +    CPUARMState *env = &cpu->env;
> +
> +    return arm_feature(env, feature);
> +}
> +
>   static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);


