Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B246E6F07F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wIY-00076r-64; Fri, 01 Nov 2024 14:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wIW-00076R-Cv
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wIU-0005fd-Og
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so2002851b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730485377; x=1731090177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUDvt9zB2u2y5ROb3kv7PLYaVN7QRM7k7c1aVoW9TuE=;
 b=vkS6QY0HUojHCahlqzi1tEg8Cl0iu8l29io8M6O9AKjccUdRNLJdtkn++T7TMgBUg7
 5407SuQKHqjK2/0ooUFcJcIPUr7vt/LAAb+mkMPZRiBqmp/qJDpSo2BfHh2EdZM4oWm1
 CtPjsTqn1X5m9bNphvCRzxkoVLRoxq2PJX5HePaujXpLTvhpr8Yj3/14UK/XiuqX5eV2
 Obf+Cxx6QW3JOJNqJ2fBc8yGerVVoZh15fIRm+A7b705EFOUcM6r0e0xk7gEBvZQqomc
 0hUcMLep+92xwcvpY8y4j5iqu/jkPs7uxo+3XbMeDfE1+mRtNCufvgxRaUDIMk8L/25u
 15XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730485377; x=1731090177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUDvt9zB2u2y5ROb3kv7PLYaVN7QRM7k7c1aVoW9TuE=;
 b=pUwjOQAeQQTnlEZ3HbNpUr+1s22uuNtd5xV7NxdSaoqLOnVLHkZqinGCWZY3EjWx6b
 g6kg/HdhpPrLXby1zk1Gb5ktEK7WTKNi31lhSDc7hPHtqcjzRQ+QaNgwg7X0f+46XaBS
 BwpzPog+23d6STiZBk/kK5pypKfO09rdcITtJn5QGQZ+pSu7WM1u9SGvjOWuyOj9vpjn
 IAVxlcKZbbzq9XsKMlEVRPgw+BvnjIW+5HyDO+OqCzXfkTnBJgd6+OVbBPc061lAdaAZ
 mFrHLhpWdP8GGvIrQOWp6xNrfP0HMjTmMf3NAscTa6dFNtzNx6Axs2lu5I/dXPmG28aJ
 99PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaM6cOlnFtquKU5fIm+HjaowVRaeAhN0rZbMIoBGWOntqeay+LORgt2evYPxcNqk8RwTka5MiS4lLJ@nongnu.org
X-Gm-Message-State: AOJu0Yyi/5Y8ToKvyP3W1klZIrueVx/+/r1yqy+/DHhru5SFQbgtOKwQ
 Wj8txBdYxyMjQTBoMIEPc1WS30Hx09MzaIAZB7nLr+m26mEej/rCpcr8jmGYzJk=
X-Google-Smtp-Source: AGHT+IHHsvWaJFpnQqgRMfmoAmiUvm+RUFjIUVP3W+jPhdkEHBSLHFvQjsBHyG1uNGDhQ4zuO88deQ==
X-Received: by 2002:a05:6a21:78e:b0:1d9:832b:e28e with SMTP id
 adf61e73a8af0-1d9eecbe578mr15489370637.23.1730485377113; 
 Fri, 01 Nov 2024 11:22:57 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93daac954sm3032501a91.23.2024.11.01.11.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 11:22:56 -0700 (PDT)
Message-ID: <e3264752-c334-404f-9063-9a17bd9238ef@linaro.org>
Date: Fri, 1 Nov 2024 11:22:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-2-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241101161125.1901394-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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



On 11/1/24 09:11, Peter Maydell wrote:
> Use the private peripheral interrupt definitions from bsa.h instead
> of defining them locally.
> 
> Note that bsa.h defines these values as INTID values, which are all
> 16 greater than the PPI values that we were previously using.  So we
> refactor the code to use INTID-based values to match that.
> 
> This is the same thing we did in commit d40ab068c07d9 for sbsa-ref.
> It removes the "same constant, different values" confusion where this
> board code and bsa.h both define an ARCH_GIC_MAINT_IRQ, and allows us
> to use symbolic names for the timer interrupt IDs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_ast27x0.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index dca660eb6be..5638a7a5781 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -13,6 +13,7 @@
>   #include "qapi/error.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/arm/aspeed_soc.h"
> +#include "hw/arm/bsa.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "hw/i2c/aspeed_i2c.h"
> @@ -416,28 +417,28 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>   
>       for (i = 0; i < sc->num_cpus; i++) {
>           DeviceState *cpudev = DEVICE(&a->cpu[i]);
> -        int NUM_IRQS = 256, ARCH_GIC_MAINT_IRQ = 9, VIRTUAL_PMU_IRQ = 7;
> -        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
> +        int NUM_IRQS = 256;
> +        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
>   
>           const int timer_irq[] = {
> -            [GTIMER_PHYS] = 14,
> -            [GTIMER_VIRT] = 11,
> -            [GTIMER_HYP]  = 10,
> -            [GTIMER_SEC]  = 13,
> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
>           };
>           int j;
>   
>           for (j = 0; j < ARRAY_SIZE(timer_irq); j++) {
>               qdev_connect_gpio_out(cpudev, j,
> -                    qdev_get_gpio_in(gicdev, ppibase + timer_irq[j]));
> +                    qdev_get_gpio_in(gicdev, intidbase + timer_irq[j]));
>           }
>   
>           qemu_irq irq = qdev_get_gpio_in(gicdev,
> -                                        ppibase + ARCH_GIC_MAINT_IRQ);
> +                                        intidbase + ARCH_GIC_MAINT_IRQ);
>           qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
>                                       0, irq);
>           qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> -                qdev_get_gpio_in(gicdev, ppibase + VIRTUAL_PMU_IRQ));
> +                qdev_get_gpio_in(gicdev, intidbase + VIRTUAL_PMU_IRQ));
>   
>           sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>           sysbus_connect_irq(gicbusdev, i + sc->num_cpus,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

