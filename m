Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C8C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWExR-00029X-VP; Mon, 30 Jun 2025 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWExP-000292-3Y
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:54:03 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWExM-0003SH-Ts
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:54:02 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60ef850d5fbso1075946eaf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751291638; x=1751896438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2+aNGMH1e/b5IHEMQB/GrgkSrXfAXV43kyoLohUsj8=;
 b=qC6IFsa6o8UqXBIjRNtHlyA9jJ6hXxHtp50/pSVt+OmOoggWfbXkOlBQELceRqokp2
 +8jkxdsuj+oprD4c/9pl1VsAO/wSfAU5djQpoiZGT2THD+3ricJfEtCHdwloZn4gvhfw
 Vf3RWO+qFcq1WhJqgqf76/pFd9caMtSVVk0qiDbhp0tGu7IOSjWY6/gW4/9Fa4ZMmXSw
 vCee6mNNtCawJSROdg0aCsSUGNX9J1/InRK+x6pOz0lYGaLkk6pjIzI/3LAfg1ohVA9c
 iUfg/UUo/1uldm1twzza+3yJZod0+MyKothMtrY/Bbw6hKpI7/Q9WVuNu0BATz3Ftib4
 c1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291638; x=1751896438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2+aNGMH1e/b5IHEMQB/GrgkSrXfAXV43kyoLohUsj8=;
 b=BJlfm4wuYVsBGEiEpKNFwipq5oPhMKJQ9nZ8VvEWVFr/oeHkSUhLpsL66ivoWfBg+b
 w3AGlNmrlCd4C3MlLAcFNs30SVN8Th8VJxVTR6HV1fXDioykGqTkgfGz2/DzHjORuwBS
 GQrAwV1itErnvLBde4QQLaWlyXa57XYru+nkDM5tSaQIMvQP39Z+WaVIV/BJ87DdZSmv
 bDegfePQ/fQtVni7CdFt3DcuzJ0kgaAwA0OTVaoJBeAXVXAGgBPj/3kHOjAve96sghcT
 UukIgqgnNdQbrHv7TDGTN6oQqAJCJhoihP+fzvcVjtksVUrPElTKT4D7hgLpw+LFxCPq
 aPKA==
X-Gm-Message-State: AOJu0Yy6xRSMFZo1RJ8fhAEJTtwM6nIKI2h0hYny1Np1Km+774wA/DIP
 qB20rS2me+3yp8HOSrTGmBVzp9cWHq5MYkcXrXqUYQGwGPEeqRnOtoqgdKIZpnGBGGxYJaqxaLh
 LoIzR
X-Gm-Gg: ASbGncv9itobNKsiyUC1YQOntjd1cEBFMvC+i4ltt0h8tV2TltN5my6uypmZYp2tCnF
 zMHLzr7WhmcGWHj362wmsXtMlVRN6lYdYd3cWVXsD2F4tQClc/X5M3iQFmKLcQIU/zXJ33FYosa
 +V0Zg46wFxRJAqrIDdvLNjBAPqMcqwH0yuRoECv/QsrIGLCIg/HsZ7IHWo32R/sO1yLdTFgSrVL
 06Qu1r724kQuwwsqPkzovGz68lrKrLguxvJlndpYqjhbcAoq7//Jg3BsL/fMeRWc1Q7a7hq7Bq6
 32ZeYWjpS/SRRydyv6EgPZ9j9vSFra75EYR7H88wp/+gzSqst7uNpjXOMpsLZCJs0hZTImJrLvv
 m
X-Google-Smtp-Source: AGHT+IHxBr6UDfZTCSH+fGuSJovF+TKpZrVB64LQMMBan1uTQuJNtdhluZxpInfS02l0AL74y8epww==
X-Received: by 2002:a4a:e90b:0:b0:611:80f3:eb44 with SMTP id
 006d021491bc7-611b90eca36mr8752055eaf.3.1751291637996; 
 Mon, 30 Jun 2025 06:53:57 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85a0d9esm1108781eaf.30.2025.06.30.06.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 06:53:57 -0700 (PDT)
Message-ID: <3c2dac0a-8524-42f2-bc7e-b57d66699660@linaro.org>
Date: Mon, 30 Jun 2025 07:53:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
To: qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250630130937.3487-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
> It is useful to compare PSCI calls of the same guest running
> under TCG or HVF.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c    | 3 ++-
>   target/arm/tcg/psci.c   | 3 +++
>   target/arm/trace-events | 3 +++
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 7a99118c8c2..6309c5b872e 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -34,6 +34,7 @@
>   #include "target/arm/multiprocessing.h"
>   #include "target/arm/gtimer.h"
>   #include "trace.h"
> +#include "../trace.h"
>   #include "migration/vmstate.h"
>   
>   #include "gdbstub/enums.h"
> @@ -1149,7 +1150,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
>       int target_el = 1;
>       int32_t ret = 0;
>   
> -    trace_hvf_psci_call(param[0], param[1], param[2], param[3],
> +    trace_arm_psci_call(param[0], param[1], param[2], param[3],
>                           arm_cpu_mp_affinity(arm_cpu));

Lacks removal of the hvf trace?

r~

>   
>       switch (param[0]) {
> diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
> index cabed43e8a8..8df27ca123e 100644
> --- a/target/arm/tcg/psci.c
> +++ b/target/arm/tcg/psci.c
> @@ -25,6 +25,7 @@
>   #include "internals.h"
>   #include "arm-powerctl.h"
>   #include "target/arm/multiprocessing.h"
> +#include "../trace.h"
>   
>   bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
>   {
> @@ -79,6 +80,8 @@ void arm_handle_psci_call(ARMCPU *cpu)
>            */
>           param[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
>       }
> +    trace_arm_psci_call(param[0], param[1], param[2], param[3],
> +                        arm_cpu_mp_affinity(cpu));
>   
>       if ((param[0] & QEMU_PSCI_0_2_64BIT) && !is_a64(env)) {
>           ret = QEMU_PSCI_RET_NOT_SUPPORTED;
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 4438dce7bec..a9cb5e0f5c6 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -13,3 +13,6 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>   
>   # kvm.c
>   kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
> +
> +# tcg/psci.c and hvf/hvf.c
> +arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"


