Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43628CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITVB-0004RU-86; Mon, 10 Nov 2025 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITV9-0004Kd-8r
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:08:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITV7-0002eT-M6
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:08:14 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso14834605e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762787292; x=1763392092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bF8sqDq3Y9yJoTdmrgSp4/I+CrT9KMHPblROe//zOWg=;
 b=wVBJA7UuRjfiDYOTClvAt5+A5KHeWx/GYXq4yR2/He0mrU7ZOTUZ6wu1PMw95sK5ox
 vzi8HlkDaGszMJEtC9uH0CDKwbizqX6fbvBy9pLQEUSSGX78K4n4yaOatpW/IFOuP6qR
 RgE71q2jo+xorlEGZQASiS4cTMsgkuuPwm8Yn1BnQcjN6Nx8Fr2f9ENvlcS8dVdVl3Hk
 of9/wnjASqNSZ1qH8SLxX799sCq5lqbFdIWKpFjUvf3YGOu1L/CQsQd0lgePSmRUciP/
 fYApBYvD6nxT1mb+1bon1vlQTKaSUgtPnVVnif0K9bf/3FbrFQhxLaONotkEZjyT0EKM
 ECiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762787292; x=1763392092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bF8sqDq3Y9yJoTdmrgSp4/I+CrT9KMHPblROe//zOWg=;
 b=jQFAaWp02NsYF5UQl9vwMBKq2tE1Vj7vwZJ9nfZAgbd8d6oo6Z4c1prm5pjiUhWDyQ
 wdA6Uxh3eARH18sGlvmx1tQX32vqIofxc0+/0fPB9pgmJfOeDwq3qxMjkieGy6l/9OCx
 GZ2TN+WjgIcW8czhfsLYX0Uqvjgaewrdh3T8I5tPZqCpVqkem5EBl9rX+NVIKZMg8GSn
 ozCJr4nfw+sHc2GL+l9voMzGCnAavNfJa2J6ADxY6+HEnZIofEwDM6YI40rY5XzVQGp8
 QoTmZuLtI/b73CTlMG4oYTgTHGMfgju0Gkz0r4enTgjdVrFZCqzq9tP+7xgqW1C0YZ2p
 ajOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuNp2XRC2TU4dmiycc2nLCs3oLjjDA4kWi7xSDNaMCZL3xUZ224ViWId5O9Y/mKnVWQpbT+nZNiaV7@nongnu.org
X-Gm-Message-State: AOJu0Yx1WBYK1eeNzZJ8bWiMhUMD1VvZgQQCgwht4WEvlCVXH6LlfKTz
 1nHHURo0FON5HTXR+1dGz/I3Yut+qTZPb7bH768AENJekE5hkPAZXu7QTKGrEyazqc0=
X-Gm-Gg: ASbGnctUEZ5En9waxxgGA2DG7eM29KPNtivaK6uySWmmiOPc3POBlkrLZu/eIjwNF6d
 R2lX0omNr0IKazDJhCX6wPsx8iaZQcIDHYZ9zD65yMrL28wmu/MBIRevGeVh0qCfLa4r2xuwDVE
 Kcdf22DDH6zRAV6vRfZpqgyNwT2wbQ2EvryQIKaWQ0uiG01C25y+t2PSwJ53wpZTY5b7HlMWvlb
 6i7Y+s0Pw2Cxt89yXT6UTZjCyD7BPVcGO8Q82VShvmCV6UtUOjoUxK4VUdHLyH/lu2LpwJNA1oc
 8wQFfeyGx4zrBVpCvSPklq+CsaNYV4rj4qWWikHQsy2cE7pz7U/rFpXc+r5CjXLUNpmdu/ry8Bg
 /wbY8FaSd6Uom/HlPDj8J6eLa4ho/V7qWJxUsdgZDaKX7BYeaDdawO6JRAQfPGxxSsGHgWPSMMe
 cwg6JXsrL8k0XhQkBrjONrTcgHyX15mGdShzk4HwCSVsnWF85w+HMx7A+MHZxQRqk+jQ==
X-Google-Smtp-Source: AGHT+IHzqHOeeF+baSzCty3/imFjQ7Fyc3mA2N70JRhwsEcF7wDPyaYaG7UIsYnJ1AULjD76zeCTUw==
X-Received: by 2002:a05:6000:1786:b0:429:cfa3:5fde with SMTP id
 ffacd0b85a97d-42b26f689bbmr11081608f8f.11.1762787291782; 
 Mon, 10 Nov 2025 07:08:11 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b35ad7c16sm9874758f8f.15.2025.11.10.07.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:08:11 -0800 (PST)
Message-ID: <fb230984-7a49-4db7-89e6-1170678a4a81@linaro.org>
Date: Mon, 10 Nov 2025 16:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/arm/fsl-imx8mm: Adding support for SPI controller
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-9-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-9-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> It enables emulation of ECSPI in iMX8MM
> Added SPI IRQ lines
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/fsl-imx8mm.c            | 26 ++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  7 +++++++
>   3 files changed, 34 insertions(+)


> @@ -449,6 +454,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
>       }
>   
> +    /* ECSPIs */
> +    for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } spi_table[FSL_IMX8MM_NUM_ECSPIS] = {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI1].addr, FSL_IMX8MM_ECSPI1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI2].addr, FSL_IMX8MM_ECSPI2_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI3].addr, FSL_IMX8MM_ECSPI3_IRQ },
> +        };
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> +                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


