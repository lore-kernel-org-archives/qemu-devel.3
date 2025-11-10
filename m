Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03097CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITRB-0000A8-Je; Mon, 10 Nov 2025 10:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITPk-00082g-VA
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:02:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITPa-0001vx-DZ
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:02:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so497830f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762786948; x=1763391748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Fsbf5aRwaaxHneoP7nfAfF5kehlMdZGAC/kjs2zoMI=;
 b=j/9ERcKGhtVJRh0To48BVYohcBC3x39SSd+gBhn1ubqRbWQIqO8TKfFXWvgUK/VHos
 ve1PJ9cs6R7zKSpik2rbfDTaP7XOIbJ+vZ/Wnmt4oWR1UIZ7uzuNG2QXQzYZ/xZa3J7g
 g5a06RgzYKJIWkGO29RK3qe4iIypE5OoWPPAUeC2J03YzJv7cLcb0AXcJnR6YGnhZC46
 nT2lVOexNVygP9vFt++vXSkUt/dkDzFSHBdjh9fBVURy2ElooHsy11bv65dBmguxg0Pa
 3S8UzCfZIYb+G7VSa4ShO4EDSwz+CrnXbj08E6sFAze+J2GrCze+O4u6neyLnxj8/Ps6
 /dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786948; x=1763391748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Fsbf5aRwaaxHneoP7nfAfF5kehlMdZGAC/kjs2zoMI=;
 b=QLK4bKeRxsx52x6Qhws/cbraxT1d8TC5bqCfe+CNcJinJfLOiCO3BUHME3u+M1E9/F
 2tOX7olvIKeem2xXJpHULHMIjLXyABDnSYahsAUC15GUfZn1ll7sn0AHd2ciIbSuj7lA
 laxsRocxxrCRZiz8fglUrtHV4PXLSmqdLtg8V1oWlGtbrDbzHT7YICHTOGIZU8sCB8SA
 OQHlD2UQbeuKfXiMACHB2+BTXPm8izgcUCUTcCMa3MIf4PSv5pjsS5A4vPG3nQiWJI8C
 mod5fso3hGFU3l+DSTZ8flX12dTiavG/lWDG5CEJSaN8xCcZUUeoxkmYivlSUD0EagOl
 e2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJOanB2Lq1Boba4FE5u1hQjlqXYb3613osqQK7BgzB2yv8Sk5crKX/fr6Z36rOJzcx0k1Y7yW6ijSq@nongnu.org
X-Gm-Message-State: AOJu0YxiH9dwcQCTus8nc0w6NPtGn7WM6dDQgyjRNWWwt6G7XrhEQdiO
 3f+M6SD3s2VoTOm75dcrf1w3VDQa1lRHveZSWKssv9qTENXW+dpUqYxsfxdvbnXxos0=
X-Gm-Gg: ASbGnctsMcIkSj5MojDtI/vWTjkXYzF6YUi302lhWnAPL8xAh13/MaqCyJPxoTvXC15
 nrwWznihFW0YDABEt+NcSxEPLvgqylu8+2QVKp8ehTjj6nUYQjrPxRQtNhaeY2eiGzUhsWyJN//
 oIbO6MLmpGUXWzk1h3qu1Ur75xyGV6ecdi3Sp34RhxU9QrB0FMToEc7XUS768/PltTLphHDgyj0
 m9YH3fMjm5/hf7nGBpRfEICjO/xhMyBdnOUfBYG9JoXSGOFeAVlmB2eklSeJdll0Jw+pcZVXF1A
 syBRi/arbUCc849UzZYroQb5qoAYF8+pinY2OiaPkWfh4ztCq5/aYCjB+3EV3CkLg7pGEBuXlF6
 eyhX2JSUHY1xPHh7pv5la4LdNk2WKChGszl5V/qQRH5yvzowoxbY2hUryRocILgi7RHm+OZtYLb
 htRlCt++W5kcIwzCOMDWHPxb95YPAMHzhAJOdEJAGf6M7KWEFCXfSOBzMJF0J5
X-Google-Smtp-Source: AGHT+IEnPF7NGhJd44EBuWs+tkraINu3VPM6goZEyDqW0HIktgLPONe5kbQOcfxsJD0akz6g7YzwIg==
X-Received: by 2002:a5d:5f83:0:b0:429:b9bc:e826 with SMTP id
 ffacd0b85a97d-42b2dc4a666mr7569544f8f.53.1762786947830; 
 Mon, 10 Nov 2025 07:02:27 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b35ad7c16sm9848860f8f.15.2025.11.10.07.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:02:27 -0800 (PST)
Message-ID: <86f568ff-edb8-4920-bd51-fc86e0637094@linaro.org>
Date: Mon, 10 Nov 2025 16:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/arm/fsl-imx8mm: Add GPIO controllers
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-7-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-7-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/11/25 12:22, Gaurav Sharma wrote:
> Enabled GPIO controller emulation
> Also updated the GPIO IRQ lines of iMX8MM
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/fsl-imx8mm.c            | 54 ++++++++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    | 14 +++++++++
>   3 files changed, 69 insertions(+)


> diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
> index ea5799b2cc..222d3bac1c 100644
> --- a/hw/arm/fsl-imx8mm.c
> +++ b/hw/arm/fsl-imx8mm.c
> @@ -177,6 +177,11 @@ static void fsl_imx8mm_init(Object *obj)
>           object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
>       }
>   
> +    for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
> +        g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
> +        object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
> +    }
> +
>       for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
>           g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
>           object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
> @@ -350,6 +355,54 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gicdev, serial_table[i].irq));
>       }
>   
> +    /* GPIOs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq_low;
> +            unsigned int irq_high;
> +        } gpio_table[FSL_IMX8MM_NUM_GPIOS] = {
> +            {
> +                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO1].addr,
> +                FSL_IMX8MM_GPIO1_LOW_IRQ,
> +                FSL_IMX8MM_GPIO1_HIGH_IRQ
> +            },
> +            {
> +                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO2].addr,
> +                FSL_IMX8MM_GPIO2_LOW_IRQ,
> +                FSL_IMX8MM_GPIO2_HIGH_IRQ
> +            },
> +            {
> +                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO3].addr,
> +                FSL_IMX8MM_GPIO3_LOW_IRQ,
> +                FSL_IMX8MM_GPIO3_HIGH_IRQ
> +            },
> +            {
> +                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO4].addr,
> +                FSL_IMX8MM_GPIO4_LOW_IRQ,
> +                FSL_IMX8MM_GPIO4_HIGH_IRQ
> +            },
> +            {
> +                fsl_imx8mm_memmap[FSL_IMX8MM_GPIO5].addr,
> +                FSL_IMX8MM_GPIO5_LOW_IRQ,
> +                FSL_IMX8MM_GPIO5_HIGH_IRQ
> +            },
> +        };
> +        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", true,
> +                                 &error_abort);
> +        object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
> +                                 true, &error_abort);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_low));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
> +                           qdev_get_gpio_in(gicdev, gpio_table[i].irq_high));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


