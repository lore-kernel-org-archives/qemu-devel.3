Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAAAC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHlP-0000ai-Qq; Mon, 30 Jun 2025 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHlO-0000aQ-2o
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:53:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHlM-0001Fj-1U
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:53:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so4892046b3a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302426; x=1751907226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5esKLy+3aA8eJK1MoE7OD8reIo099UHwDY1/Ubcbow=;
 b=zzRvhZIjpYdD5IuhmbUpTPV+sutdYk6d9xyMXIN3FJLJ0mz1ZeyUGIepnMnlUTnFzH
 LCF2akaevYsk4T5Qy46z0twpOeQu08c0Dmbt0DQqY5RBm7rtoPMeoiygsxdfMGmWAfUV
 5wU/eAy5Y6FkuFLW6aIPahWazQLP2kxk0RePOb84fkUcrPP1+MbPpFFbJMet3UCe5azF
 zSTT9rP0e0cSDrSUX98ICmMo79BUkjoP0khIqIIhWCNs8k2GwXewcoFWQ6D/AIOryRd9
 guNOMwH1qpo42nRnv1gOW9pkBaBTevyPqfaLTyvjCHVIK4e0a/ylYQyH75lHZVcysWze
 JSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302426; x=1751907226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5esKLy+3aA8eJK1MoE7OD8reIo099UHwDY1/Ubcbow=;
 b=JRlLkRyprUqGDL/ef3chdF0GLfCFSLPNOdUo9wO5DxUBX9gFwDsX/k1uGlc8fVQ6st
 kG3/FGgTQAYIPlW4C9wT1+cds81CX4npJSZTP2yr0S4InvmudMD3JU8FxUryG8YJ+Sw+
 UGsGIL2Eelec5/MYCIeNrTp/qAjrPRtcHKOd5+K1KTEK2nqdRJnvk3HnA91669UD0T37
 WlwR7W+ICbmuQl1jlQYxQcZy9fSrznGEapsi/fa/7BHTDvGiv3D5ODaDF0ef2wHRZVuB
 SsSj3jBsCNmCZO1gLVxgAKqGizSJ0kFfvHhcb2hJsjQ0ba0Uv7swmsSP7UjlVLSzBcKT
 /MKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT93FED7GsdWN2LFuQG5fXYE+hBE7wIazEqIDlbmEdSBIfZKZ3e4L7eOjx2lWQVVtyrXV+NkdJst4n@nongnu.org
X-Gm-Message-State: AOJu0YyhoIPEcIqYB+iB5tCsyJ83dQIeGB7Ag8K+a6y+Z+3crao1J/bw
 ziggb1XqE9drnw8mbuqPITDY4PsjK9Xj8KeeREuI2D5c/3ekmJmdHwwg9iNopwOrptQ=
X-Gm-Gg: ASbGnctfpgnADhDX69kyfU7nyS2r9nfZHcM0Q5ycX3EIHnd5gaA2wxP7ZStN0w1I3KG
 mknHRMf6XItWPwXDQME17mlh5oAMeGYRQZKmfAJdjgwoJwMQmXKrz+b9O7EQ9wiUhejxbP1ZAow
 f9RTF4JDrDS7emmwISstyNwExH6pSXMPfH+zB2jWn5RPAR8x52ob0IvJRyU1ILDB9xZaUttNkxb
 FITNc/CRTd3wTWuaslfH2inZU0GWx9lNr2ottyAO9y8uLYna6ccSDRRXMCf7OHoqOSFDAAJ0+jO
 c1zLoPlkYxhPTvO3D0KqYdyywwQBqtlCPZQx2iEZJ7n9ogO6MuWm/9OFdWxL6PKZge6McX9hU4p
 rPidqtUVXZg==
X-Google-Smtp-Source: AGHT+IFMeF6ooYadkSyHe4utKVzxx8xCyWoBaLazAlUxEIs/56bgcMe9K4DNDvZSoKppSJoHlun3LQ==
X-Received: by 2002:a05:6a00:3c90:b0:742:a334:466a with SMTP id
 d2e1a72fcca58-74af6f43f06mr20021789b3a.12.1751302426541; 
 Mon, 30 Jun 2025 09:53:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5574390sm10253052b3a.90.2025.06.30.09.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 09:53:46 -0700 (PDT)
Message-ID: <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
Date: Mon, 30 Jun 2025 09:53:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Just a nit, using 'target/arm/trace.h' might be more readable than 
'../trace.h'.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


