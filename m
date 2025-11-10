Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F64ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITVA-0004PL-IJ; Mon, 10 Nov 2025 10:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITUC-0002yL-Ke
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:07:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITUA-0002Yi-VH
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:07:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710022571cso30519925e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762787232; x=1763392032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lwwzwCzI6D56NImJU9pLm5yH5z6Mdo+dGpZ7cwcXz+Y=;
 b=SegzNV/d7NB/cLaVQ65I6fjLUq1jPKNtSElpK/FrR2A13NxPgots5Uyp8qhLw9PXwN
 WKphqzAphMUSdeIKiSzVKuVmW/5Ka0dw4pMox7lZ0rpzm/iWVHIDUOFbK54j8gWnPXTb
 MViKc2swKSQQRkqb9bQCM143J70P2cdc2KTI/WX6ZTrMP5y6ACMxR7Z+brYbUIqX4UfW
 sSk/a3brJaoXTnRzLwiVn8UT9N8KkKyyMERAXIM6T5rxbxlllTk2507zCMlGfd9UuGAZ
 ZMkblGjAn/fKNoaLFCT3qjADZE2p71L05wvHAVGrq8gayg/XFyyP5veDGLrhmI1NpYYB
 0oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762787232; x=1763392032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lwwzwCzI6D56NImJU9pLm5yH5z6Mdo+dGpZ7cwcXz+Y=;
 b=Gl1TbkIpkagp0E1gBj84ld+F4pmwUfu+yVfEyRkIjF2P7dQxjl58QwfdNlUyC9LVXu
 5/SzkAjA9QiG0NOS/I8w3jPUFwCJXwiXu7+KramC1Udbiz0tOHwfP0+2n3vES9iU4+XT
 dsmaW1LWKhSRIfVb001IzbDhvI2qbPf7kMlCP/mSou+LoyCrvnHDmdmdtnSQX+suqoHo
 ahDrB5qS8XBOuZFt1CYa18XaOfXiUxZgxXYji4rsFo0EK8rj9WIHf0FipeZyuRg4xoUM
 aAv5v23G5kWtIXBsPx/viLIB7EAJjWEN03v7BLf66G1At4T58lV9aqwioAfs7GH/dinD
 KxWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW8cKnuyka8NVuB46Nnh+6u1E4sIXJRv9VksqoN3NU/WqcecVLPi9/IFpWu/ixDn452Xj7j0hBi/C3@nongnu.org
X-Gm-Message-State: AOJu0YySxPIPe2CwLYJaaoD6aCTuEVH8wsKmv6/PWpgNgBkVH8ontX9h
 gHmmDNkXUloOu6RnIZHBJOR0mmiJlaT2LNtfaL/CE/BmDNeZ0e6jVlVb9rUu1AmFrDE=
X-Gm-Gg: ASbGncs+HwElkQjJYXCU+c/ltjanARtfS3J2d8au6lr7poVGHi5Jib4zfplPfTvkQS6
 lKL14/OhXXMHx7Vg1/RESRev95GHPe0bZA5JUGR0EvNEtPHyPBOow9GXjqG9BxRJ3FNSQekP8Lr
 sSWkXQf4u/3YeWEPgSC7FFxLBfLoDjDbK0+On8KFdEDU/Pm5Xje3bHAohcUnsqdCsiFDqfkfRQQ
 FBxCQitdwnWn8m6tFXf9i/LVFbpYXxBonY899uAx4A9gsumxyeUWxgnGuRSCSOHC4/FWsglYamB
 cbGplwEWFL13o0797/0mprGZ0wXXaz5FtNrqi8mWoa7JecPzOkFUpGVOkpgnCCpnJ/3hldNDzHH
 XbPegS8vvVPM16zN4KNV2Wo0VZBqp+ItPJid9zl0LYgTiFLAC19C/rMu58UD/pDYAKc08vu7H+B
 oDTgb3GjXgOvd0PwXWnp9yYFaQ1sEWAkfcuQzo6EePVL4wo70bMSqv7GaWU5CeDfHB9g==
X-Google-Smtp-Source: AGHT+IHRkuqXSBEeEB9VNd+fIZXzdShDQN2fuGG5Q0sKlOFok4rjJqNuMwXMGmUv1ecWx0gP8XS6rg==
X-Received: by 2002:a05:600c:358a:b0:475:dd89:abc with SMTP id
 5b1f17b1804b1-477732308a1mr80777095e9.11.1762787232478; 
 Mon, 10 Nov 2025 07:07:12 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bccd41bsm205993575e9.2.2025.11.10.07.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:07:12 -0800 (PST)
Message-ID: <649832dd-030a-429e-892b-d08ba087118d@linaro.org>
Date: Mon, 10 Nov 2025 16:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/arm/fsl-imx8mm: Adding support for I2C emulation
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-8-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-8-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> This can be used to test and debug I2C device drivers.
> Added I2C interrupts
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  2 ++
>   hw/arm/fsl-imx8mm.c            | 27 +++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  8 ++++++++
>   4 files changed, 38 insertions(+)


> diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
> index 222d3bac1c..eaa9a66efc 100644
> --- a/hw/arm/fsl-imx8mm.c
> +++ b/hw/arm/fsl-imx8mm.c
> @@ -177,6 +177,11 @@ static void fsl_imx8mm_init(Object *obj)
>           object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
>       }
>   
> +    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
> +        g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
> +        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
> +    }
> +
>       for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
>           g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
>           object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
> @@ -355,6 +360,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gicdev, serial_table[i].irq));
>       }
>   
> +    /* I2Cs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } i2c_table[FSL_IMX8MM_NUM_I2CS] = {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C1].addr, FSL_IMX8MM_I2C1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C2].addr, FSL_IMX8MM_I2C2_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C3].addr, FSL_IMX8MM_I2C3_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C4].addr, FSL_IMX8MM_I2C4_IRQ },
> +        };
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
> +                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


