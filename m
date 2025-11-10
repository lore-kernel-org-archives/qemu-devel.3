Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F70DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITY1-0000WP-17; Mon, 10 Nov 2025 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITXK-0000HX-Ne
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:10:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITXJ-0003FJ-01
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:10:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so14933925e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762787427; x=1763392227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXW7fhYGoyWOidsHt4uUDE0+GyZuaWwqJbxZE6pzZ9g=;
 b=hLzJTMXkpKqYdFkiFv4oMb2Z9edNqo+unVas9N2l7TF7u5JWfByqMOYwo0n/pHZMB6
 zdwnes269Vp56Q4x4WlnG4LgKYKEU4WDAnymUzpUC0wgItcDAGkEBnit4wtvVzXSImco
 luZOgy8qBNZ9QHmq7kEaTaRh9S4pCGqvLy7n1TADZ+ZmxJva55pyNGEXY/mtMbPCtug8
 PWYNeb9O2bN5KS9KWX+ESutZC5gXG9wOnfJDQp9bey7t+jXNOF6V8xYyKqUqQLQird1g
 S/kIeGBCKsPKrtKemlPmpM3pFAMe24yB+CIpXO6wSo0oVJwrNiHczEaIFs2S98eRPm9F
 gazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762787427; x=1763392227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXW7fhYGoyWOidsHt4uUDE0+GyZuaWwqJbxZE6pzZ9g=;
 b=nu9/Z7MU/XrNS1KcsoWu7PdOtJUARUFmGT6CsDZJEdgFY8tzy2nRw1Lz6Aa5ae8EM5
 96MV7yNKpilXB5J/H4RPOe0peiuWXoY+KI5HfNoJMolHG5VJ7wPbKfY+xxigougfs/5H
 375jJ+GGX+ALWkLSLg8mQS13ocjvyj8ssgTPrmZZImIr4zzW3Kg6OdfTpgtueWsO9njt
 nXPV6JzRirWR4e+YU4GUwjxkImzhvE7zw+88b1n3ZB6C/AwuzQL/cTAZXGl3mFlw1WTe
 z7151IORtXsUyd0y0r6dz3VXH1+ieCCrFkBaj+isMXRvk0ogQ125N5q4iQLlmskcjp6A
 5LSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfGskP0qwTJhgLhrdt5www+9H96Hwe0/ERTDz6nsERMczeJKaOEMLSBjXwnMP1g5/wJNBoeKbUhuUe@nongnu.org
X-Gm-Message-State: AOJu0YxpEXWyxlx3BkMocFiHI/68XawC58jC35JIearJf0bfyXf2DHL4
 Uhc7UOQSFhhvCd/mdgbpDRyxbAUZDyn323hzbyfNyJcTfUtBRFs8S5gD8spd3b2KS1hhoVE/E+P
 JK9lI6rPzfQ==
X-Gm-Gg: ASbGncs7lJzZDHTqkfzhvAja6lQ8O0LvRzFPDxnKxWJNqI/xOOrUc4QiyxOaB1NhxdH
 7uk7u5CfI3yw5rru/42cDpHsxYsJIH1bwOUsEpmKF6a+lPVzZhfzX7VBDC6i8l5xT1mquSuNkXG
 tPLklk1w+gjWKYKcZUpLHP80Eok9VjVOZA9wFUigS5ogaBayvORFuYxB6MGhP3+kluQQLZoyUju
 02iyDwXyUK5AUaajsGtaqygPERIKMULbal6j3mXnW39rJeuyKWbn+joJABfhUY2jpSyWLvD1hbc
 4Zc+9G5tTqxa1ZLOUfGzC0ntTGkPSlcNi4U20FZWG+YBxtg+9dPS1RKKA7AZ8YpU/jGeIvK/ejP
 p1NeIFLgd0i9cz3xqvVS0VEmLVDQ6VmvMD/Gvl0d5mb6FyIJ2AYXhinnvSb1O5LmM9toqRPtk/i
 GT7ALyr0c0V2EvyniZnAQwYwPtC0NXWbd5GVoMiOBeBPi7Zf4jRrg8OMo=
X-Google-Smtp-Source: AGHT+IFe0MBCzploi996OpvydZ8dI5flB9VfVqioJkL5sj30uRYvQnxGFm+BsXO35uG5QCqzLdUreQ==
X-Received: by 2002:a05:600c:4583:b0:477:19b7:d3c0 with SMTP id
 5b1f17b1804b1-4777322d955mr71999835e9.2.1762787426879; 
 Mon, 10 Nov 2025 07:10:26 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63dfecsm23229254f8f.12.2025.11.10.07.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:10:26 -0800 (PST)
Message-ID: <8085c125-dd25-4477-b08c-21654cf425ec@linaro.org>
Date: Mon, 10 Nov 2025 16:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] hw/arm/fsl-imx8mm: Adding support for USB controller
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-13-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-13-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> It enables emulation of USB on iMX8MM
> Enables testing and debugging of USB drivers
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/fsl-imx8mm.c            | 27 +++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  6 ++++++
>   4 files changed, 35 insertions(+)


> @@ -514,6 +519,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
>       }
>   
> +    /* USBs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_USBS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } usb_table[FSL_IMX8MM_NUM_USBS] = {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USB1].addr, FSL_IMX8MM_USB1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USB2].addr, FSL_IMX8MM_USB2_IRQ },
> +        };
> +
> +        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p2", 1);
> +        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p3", 1);
> +        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
> +                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


