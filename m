Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C77C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErio-0003Pn-Il; Tue, 13 May 2025 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uErim-0003Pc-RP
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:39:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uErik-0007Sd-Qa
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:39:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a0ba0b6b76so4121365f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747150745; x=1747755545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1aB1bR5uYVtXnisXsyHLAxy/NZGcPHLGwq4sthZMzJY=;
 b=yGTBCOwZmzffOhOOah4CQ+WZexD49cZimiriI105xWDBVcyg9sd/X1S1PZphhAB7gY
 ISsTefwsM1PHLh9XoR4iJqFgM2EZEQxtX4Rh59X8gqlGlyKMt7VwsQ4bfGRKAtBWclNW
 z+a9y+4LaX9SNZvnx+CfcIeXQWAAOWy/aDdjC5GCTv50yHSpej341hljkitSSCLtOwL8
 HV2G/jBfOvrpPSCxbeNykyd79obCJHUJ8TqEIDHSdTnQgbsw14+4t6eLwnNAywwsPuqL
 66g1LxDZ4BBTH9JbG7n8fEeJLa1tDayehdmSKvLJukiIUxEROhulTT54ma2YkyQqiXWU
 BggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747150745; x=1747755545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1aB1bR5uYVtXnisXsyHLAxy/NZGcPHLGwq4sthZMzJY=;
 b=hc6Pbd8azkeAtYs8msLjBZd2eGApMfvNkmTrK1T+AiZu/lb6VftdprDVG8aun3Cpj9
 uGa1rm40X7I4J6v/5/dv8d7E7pzNJHYCVbu4cVQIr2Rxa1FHl8c9bQy+Xs8qxnsRspG7
 538fQaf1mh0JJiUzljShnNJ5UacJhRiOmEd97epDzEQZJuJTC5RrtvAbswo2lQEjjFxt
 FqSz7fNpTBCgvLj2sICCdECcU8atitxMkwBJK8YGwfLgK4foOLStNNk9svm6OQ3WiOoU
 iA3GNkQuEQ3QJnH5YDCh7wfz5BegulWeyhMZuJbeD6g82FWl+XdgW4jCmDjmhDA6KUb/
 aZCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+yzHYYHxH8Az877fP4nIl7idsHLXAEv1KwQtfCsclVaGt31QbKhNbX/sUDR0sMS9gN5m+2ZApFWbP@nongnu.org
X-Gm-Message-State: AOJu0YwdoIK0kC+fOd134tvNqL8HtCXagEl+rWQyCowWPNBTXOSBJwZc
 QqHjBCDgNwAWdrp2Xu8fyVSDLK6rHXDmcBZwjRvrd3ZR07/emFsvyqU3oCu+U6uK5tdu9HIr02H
 Yg6ZHfg==
X-Gm-Gg: ASbGncvvR32QGYrKxLbWuN0plJx78JA8Q4hCaHkG8T8cwDP7ixLyMupZ4/pcvRJNzYS
 WdWF9iXTC9PP28LRmM1VXLiWUywJKnpM3Mc5aWW9y7lBwxLrYcoGyZVKHZnmPTldECIckvgvnK+
 DgOKECWfX4KYbScQvzRDV3XmEn+hy7Ce6YjpLHG19lYfvO1a/xo3ifEQXXfue5zj17vFnPA6dXx
 pjHv3Z1WQoYFJ9yHGCc20VVEPWYHTgEgW8yKKvfqrJJ1iPioI6pQzSO/zFWGOeFE81Ni9lV59t+
 3L+k0uTGP9ggP7MyEkcsHIWC/vMfP5OPL3mnOAnPqouFDTlXNYhJe5bp4Ad41k6dSdjx+e9IPYX
 ElhqpigD3Dx9J
X-Google-Smtp-Source: AGHT+IFxKfWecEWGkr8SFgolB2gDXwLfwsSyvhrpPdv46ezRqgPwKv9xC9rgSH/rk4eQp3aLVh/qIg==
X-Received: by 2002:a5d:64c4:0:b0:3a1:fdff:5394 with SMTP id
 ffacd0b85a97d-3a1fdff552fmr10206373f8f.57.1747150744829; 
 Tue, 13 May 2025 08:39:04 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2af7sm16816967f8f.52.2025.05.13.08.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:39:04 -0700 (PDT)
Message-ID: <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
Date: Tue, 13 May 2025 16:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-3-chigot@adacore.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513141448.297946-3-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/5/25 16:14, Clément Chigot wrote:
> From: Frederic Konrad <konrad.frederic@yahoo.fr>
> 
> This introduces a first-cpu-index property to the arm-gic, as some SOCs
> could have two separate GIC (ie: the zynqmp).
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/arm_gic.c                | 2 +-
>   hw/intc/arm_gic_common.c         | 1 +
>   include/hw/intc/arm_gic_common.h | 2 ++
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index d18bef40fc..899f133363 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] = {
>   static inline int gic_get_current_cpu(GICState *s)
>   {
>       if (!qtest_enabled() && s->num_cpu > 1) {
> -        return current_cpu->cpu_index;
> +        return current_cpu->cpu_index - s->first_cpu_index;

Note, CPUState::cpu_index is meant for accelerators code and shouldn't
be used in hw/ (in particular because it vary when using hotplug).

>       }
>       return 0;
>   }
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index 0f0c48d89a..ed5be05645 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
>   
>   static const Property arm_gic_common_properties[] = {
>       DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
> +    DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
>       DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
>       /* Revision can be 1 or 2 for GIC architecture specification
>        * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
> diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
> index 97fea4102d..93a3cc2bf8 100644
> --- a/include/hw/intc/arm_gic_common.h
> +++ b/include/hw/intc/arm_gic_common.h
> @@ -129,6 +129,8 @@ struct GICState {
>       uint32_t num_lrs;
>   
>       uint32_t num_cpu;
> +    /* cpu_index of the first CPU, attached to this GIC.  */
> +    uint32_t first_cpu_index;
>   
>       MemoryRegion iomem; /* Distributor */
>       /* This is just so we can have an opaque pointer which identifies

Alternative series motivated to remove &first_cpu / qemu_get_cpu():
https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/


