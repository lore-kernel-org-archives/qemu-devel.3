Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967BC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHup-0004Eg-Q9; Mon, 30 Jun 2025 13:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHuX-0004Dj-1G
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:03:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHuV-00028f-7p
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:03:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23526264386so21166515ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302993; x=1751907793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrwSuaD+VoYFdUIXCegGF1YB386Md8D+3yHN0v09ydk=;
 b=KuSBmhATfF1rTQz1wg6Fg8gkONUFdpi+blCxjbYaSQH3YbX2cYeTbXHknJpdIbvCnc
 zIlU8blymILyCYUZJYRJ1ez0P7et7IMJZ5SRsPaHxiWWtsDmJyzsInPL+uNxxnK7vLB0
 ps3GES2q0JH4UQfO2ITIYEnIcALiece/o3ZeHz32eWOM3vNCDF047jnrxlsTCkabuOL5
 Iisj2gw2/xr+v3RgqLIsaBSse0w8IgxBJrSqnT8wXv8yHOz5mgqHO256RjuaQy/JJO+e
 wXs71TLmLaia3cZB/RSR1iqYsSpHl+Tf9VtILWfb53G1cVNZDYlnJCyu82mGCsIvqEOg
 PMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302993; x=1751907793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrwSuaD+VoYFdUIXCegGF1YB386Md8D+3yHN0v09ydk=;
 b=O3T5FifKa3vgxW0vmu+bz50YI3b6Z7F68VhuLMydt7T9+r/zmd73ZC6p0sHGi4OdVO
 Wa7gnUkQQfnbOWY1OPgc1Dh6ipA52f2/ovteW10bEOYv4Fpv4dxyzDuevMwE/dLbHiT2
 Cb21JnjizqaM4evSodVAA/iZwX/dtvcScB1GF3P/0WVxYOG2Cvh/kfqctm9prF7DabFN
 l3jmG1y04YMYgDfEZ8sMAG7XO5huY6XvT8S7580IC73ZaXBO+hthDEI7iffhHf0bjoJX
 /yLqDULVlwOVwjdkZga1x0+yOM+4cnpYDd4k+705iAFpCQTnmUuZBUvSesV1v4O9KXm1
 YZWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1bXRW9Z8vWQ/mkIN2kOab16HtNzv+6vlob9g0gtxOu5rRqTgQGyi8KF9JYH1W36M14PTbvBg4epV6@nongnu.org
X-Gm-Message-State: AOJu0YwJh67h/GiYd/T+9mMdCPVKFzL/erPHFdLgnn5/DvEPsXQSHin6
 nvbRimbVgdRovLPj1nINBFj5CaHY0nBcDTG0t2WTZPV9CEFNXhPH/Zi6wLfpq+kL+fI=
X-Gm-Gg: ASbGncvyjyGV99Q8BkFRbmmCAZXGqN25CEY3R683DDtO0r34LM1rBDmQkHNHWyRLDiy
 4SBJQsShHH0dDwSrEEKvYj7u9Gbtm38yp0D3p19DD326Iq80fW3MQasIg86Hykx/wddhF3hUGNW
 84hCNdBQbWuZwQZvJdPEurfM5iNRarjyG7LRTuiUUnxmRGsU3rUxGxKU5YaY/ts9av1KivyHA4d
 29UQ95V+v67Va7WCHU+CcC8kWcWafCm+qz2jg8+er0O/bA51TLlQTZgHU0K/j6BputHBEV1cbP6
 fWByJnusODpbA1EeX17Y3D1xJJTc7HGf8vpgaMrdLlEPjwL9qzUPw6EclbGYtQuMCE5y4PvrQcs
 =
X-Google-Smtp-Source: AGHT+IF2HmnU1qny5QzbedEQ6+Ndfh4HmISjPj7+aPFVUka9xFkbRFUIIEsxA4sS2DiQKku1YCJ0/w==
X-Received: by 2002:a17:903:3d0b:b0:235:f078:473e with SMTP id
 d9443c01a7336-23ac4682e55mr220615365ad.43.1751302993272; 
 Mon, 30 Jun 2025 10:03:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3b871csm84620735ad.187.2025.06.30.10.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 10:03:12 -0700 (PDT)
Message-ID: <93cc9ec2-2f79-43df-96e3-fb216862561c@linaro.org>
Date: Mon, 30 Jun 2025 10:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/arm: Better describe PMU depends on TCG or HVF
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
> (ignoring QTest, because vCPUs are not available there).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c     |  2 +-
>   target/arm/machine.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index b6a8ba83a46..0311ff315fe 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2352,7 +2352,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>       if (arm_feature(env, ARM_FEATURE_PMU)) {
>           pmu_init(cpu);
>   
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled() || hvf_enabled()) {
>               arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
>               arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
>           }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index e442d485241..baa7ad25ca9 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1,7 +1,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "qemu/error-report.h"
> -#include "system/kvm.h"
> +#include "system/hvf.h"
>   #include "system/tcg.h"
>   #include "kvm_arm.h"
>   #include "internals.h"
> @@ -853,7 +853,7 @@ static int cpu_pre_save(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_start(&cpu->env);
>       }
>   
> @@ -888,7 +888,7 @@ static int cpu_post_save(void *opaque)
>   {
>       ARMCPU *cpu = opaque;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_finish(&cpu->env);
>       }
>   
> @@ -921,7 +921,7 @@ static int cpu_pre_load(void *opaque)
>        */
>       env->irq_line_state = UINT32_MAX;
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_start(env);
>       }
>   
> @@ -1013,7 +1013,7 @@ static int cpu_post_load(void *opaque, int version_id)
>           }
>       }
>   
> -    if (!kvm_enabled()) {
> +    if (tcg_enabled() || hvf_enabled()) {
>           pmu_op_finish(env);
>       }
>   

If I understand correctly, this is supported for tcg and hvf, but not 
kvm, right?
I'm just a bit confused by commit description mentioning "simplify 
logic", which is more "make it explicit".

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks,
Pierrick

