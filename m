Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F9CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITU3-0002tF-QB; Mon, 10 Nov 2025 10:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITSJ-0001vL-HS
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:05:26 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITSG-0002Q1-Tr
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:05:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b32a3e78bso1229147f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762787115; x=1763391915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rbk3X3xVrOlmW7gRLS2fnuuCzhb7fOpPOo9RcDP/Cks=;
 b=ej/24bEckqgdqSruXEfiRELOKtwCllmTd1cD1qHFB9YnMrzhSPJdethgX0H9wfFjT2
 F0JBWpR399AVoVVI8Bw0oxyKueamfoMw7v9YpcFXl3yCbNysLk5m6bB2wZD1XKO3u4L/
 jI5eqrJpba6S1IesBI6wG76eDsxNbOJ4ZA+EsMYW17h6g+ZOYvvmzvZey+aA9Q0vC0aJ
 /w6yfaFqlp+MaCnpsfyPKDMI/p9I3KE4ATgart8WYnNpdky0x4xIxb/2jUVA4wUvgCy1
 EiSXij1ROhp6Ct9KLq2p55VZiwI9b6QHRyyP7F+Iw0PN5CZSJVUX65M2C1Njqi4O0kvB
 eTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762787115; x=1763391915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rbk3X3xVrOlmW7gRLS2fnuuCzhb7fOpPOo9RcDP/Cks=;
 b=GuUhLE3lYJoOeI26FosLGKXKfKM2qu6LOnFJP4UYLvNVrCyVhKxjDBVWazoe7hPOYU
 l8Dxoj9uHbeTXbq3W0+5Y3uAZs0xG3DrXxuOotSeerhckPfaERGvE59UFnu7D7szeazo
 paDSOo1pwezr0FpQBI/5DP1Z1nxm29b4ZGqSsuyfMIvwpJKNIkDZc9YQk96W6WSO++o6
 4d4H6V9QD5IgqoAl8cTueal98tRkSNr/IkpSh03i3fcF5RT1oVeGTxzsKfJoE4z/GJcT
 fW9eXtF3s2qQxT9FjyJFhK5MGnJBKD7q2wC6luay/g2AdHcRidLH+KkP4YASU74jq0vU
 zgJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIRTfBaisBsrhfYtMBPv9b5N286aKkHVzr2SYpuCTFJKQxZ5AHoLIl7zq+BJOnvCAd7/+t1Li5Us1c@nongnu.org
X-Gm-Message-State: AOJu0YxUnD4tzD3eVlCLhnsOsN7gaTtXnpwEiRPf8McbMnfwvJ+tET/I
 TSW2nqz33A2rw5IKGfOAT9NNVxlfsrlEs3YrTSUGj++/B1k1Fzt9FZUS0FzyPwUK3G6kwQkLbBL
 6Ejms7FNygA==
X-Gm-Gg: ASbGncv3tyguXB8NudC21JIFzQ3kaQ2Eh+bHipEyUq6ciAQnSN/S3qeeG3I300u8C2D
 V4JRgvGtjhFvCbydymNBoz29y1PiL3EzE1APdJtMXXzEDO7xFhPloeMX07dqSIWU1xJjmRnvyKn
 Zky9z7mzAwtzwHbjoeejve47WydeIR5LHzPLGTK+a3kosErHArNQSV7P9E+WRtuVDxADaPHRokN
 h7K5Wz2UtGBG5mZRrz8+nfAar16vqmbPFiwKCQkPPEJq/ap+qerpYcMjGn6dVAFxStUW2OgJFn2
 s0fS3oQVt2IVXbyxF9knkYrOTVxaimk2MEEiAv9wswOyNNVnaCdtEyEKnU5j/xOheXnaRaAA3FD
 F/MZE7hYPlZWUHydS6tyRfJ7aQyaNgfcFxV29mORLr530fYZT7pueE+uLwbkCuKJA7Yn9xowzNE
 rjhNjYAA8PqufEKQ2dLwhVmmf2ytAH1ZOaJ7lBUxrZICDVuaxawJaPwVbKsBZYxQLpnWwkqtp9b
 DFy
X-Google-Smtp-Source: AGHT+IH4vIkXfm1/SJQm3+r8cHc4Y9MBy/zR/zMEWxS69/Nf37dM/uJsY/PmiajOEQK+rF1btDs4rw==
X-Received: by 2002:a5d:5d87:0:b0:42b:4069:428b with SMTP id
 ffacd0b85a97d-42b4069458cmr1505469f8f.51.1762787114802; 
 Mon, 10 Nov 2025 07:05:14 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675caecsm22767350f8f.30.2025.11.10.07.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:05:14 -0800 (PST)
Message-ID: <5779078a-925b-4998-9534-5881e72e7125@linaro.org>
Date: Mon, 10 Nov 2025 16:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] hw/arm/fsl-imx8mm: Adding support for USDHC storage
 controllers
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-5-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-5-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> It enables emulation of SD/MMC cards through a virtual SDHCI interface
> The emulated SDHCI controller allows guest OS to use emulated storage as
> a standard block device.
> This will allow running the images such as those generated
> by Buildroot.
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/fsl-imx8mm.c            | 25 +++++++++++++++++++++++++
>   hw/arm/imx8mm-evk.c            | 17 +++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  7 +++++++
>   5 files changed, 51 insertions(+)


> @@ -342,6 +346,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gicdev, serial_table[i].irq));
>       }
>   
> +    /* USDHCs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } usdhc_table[FSL_IMX8MM_NUM_USDHCS] = {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC1].addr, FSL_IMX8MM_USDHC1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC2].addr, FSL_IMX8MM_USDHC2_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC3].addr, FSL_IMX8MM_USDHC3_IRQ },
> +        };
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
> +                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


