Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3889C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV9t-0000Gs-0u; Mon, 10 Feb 2025 09:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV9r-0000F5-Gd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:53:11 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV9p-0003Jv-8Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:53:10 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dc660b56cso3375732f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739199187; x=1739803987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWhDsEiYuxRKPXphxfZ/7andCBJuLYjmYo9q0Z0tb7o=;
 b=a97WZc3y5ISnXUr8VDsvzHKtilNR3n6vjmH04WX8KY0s+uCGyfOgVXxq065cZRd26g
 y4cs9sucXit/ra41ybK10i4TZ6L1pTI7UMwZRhJ0FrSfbaNBmRd+EYzpgv675s6UyHzM
 BbWynKjz/YO3mVbi19CrwbbKFDroeOdgIpiXB0gmfRjy1IGSHXVGeH4kGJToPBS8rwqa
 EsIXNuouDha6TYTU5ue+RqbladsoreD4hT0eT8tw5J/RpPvZvgTjPFC7llQtS1eTBh8K
 nEaQX52XOkSCU+y/e0F/fZT1IV8SGk3S+0krYx3vEIXGEKmx6v51FUgYa23+4zhE95dH
 Kr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199187; x=1739803987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWhDsEiYuxRKPXphxfZ/7andCBJuLYjmYo9q0Z0tb7o=;
 b=pVc1CRwVPICFL52kkQ6bzDUq2y3tPPxdMsn6npFiC6s7QtXxnWSP/iry3rEzxXjrtQ
 faC3KVDL/PlGftHm1AHh5Iv1T2PZwbF/oNBWA69m7DHpZCqPGRDm/HG6QONeSD8lZlR3
 GZxSkTFmdg9k6kulYgkhNQdjdeHO2E4aSsdZSjPMVD7JYhGApK/iPLsQcxpxxq671HrH
 hBcPlpUD4vg7N+5UMFLcVa4+QroMp16rU3i12p9FNg1aHugMcRaj5LqbLw3gUMnhQ/Im
 FXly/rCkbVp9I+tlKidZ44PowVxZNm/hU5UEWev1BrrMkopxhcUihNjZDW6ukqUqVJlx
 DGAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXXBEAVrN4BvqYcsmzeE1a6kZyGXEK9ZojNB/bYEbkhzeETDZr9++TEiwryzu01YIaM7rnoRliQuTL@nongnu.org
X-Gm-Message-State: AOJu0YyZv+SKicfV9PKI6u+TUhoU34sSEE5mJ+gB+lRrrBrA1RB0xxHc
 2ZDpNtqkK66RxIbBVARmyPlbF25szhLBffpGbRS0Uyo+vfgsI9SK397xto47Ipg=
X-Gm-Gg: ASbGncuVdj2gCjI4bkhjVWchSI14XsToRrqr9asGIFxXE3AQNwBGoqfr02ciyrC7y0g
 4/3u9qgxqZKykmuxPaFpj//uaJmTlevG40p5cLv2fga4Mzui9GcsG0zUnyk2Wb7X83FuyH8RkzS
 H1z8aTO5Ya9bGDzMGlBoyR1q9siKCtOIwjQfDFMSDL+m5p/N7dt1XRjuYE7GGQWmaFYrAv59VUX
 YtAaJdrsQ74UqGH5+Vsx1CyuavAWoFU7tdTyocNJn+iVNaAiw+ihUaq8FQkBshjCT9xt06MBtGp
 dJykuqYmwycYVGUC5QfY3r/XJNr87/CpAkOfa95TlOPS/7y3HLyVb0fLVtA=
X-Google-Smtp-Source: AGHT+IEM7phjRCE8jn/X+9WrBQ3EtyUOodwIejaHgSnLxbE6cQqKJCGwQIESapNq0xCzMC+aecpVWA==
X-Received: by 2002:a5d:6488:0:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38dc8dc0ab9mr12451376f8f.13.1739199187449; 
 Mon, 10 Feb 2025 06:53:07 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd9552667sm4908649f8f.45.2025.02.10.06.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:53:06 -0800 (PST)
Message-ID: <4f8886e4-1c00-4fa6-99aa-d5952842042c@linaro.org>
Date: Mon, 10 Feb 2025 15:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] hw/arm: Add NPCM8XX SoC
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com,
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-16-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206221203.4187217-16-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 6/2/25 23:12, Hao Wu wrote:
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   configs/devices/aarch64-softmmu/default.mak |   1 +
>   hw/arm/Kconfig                              |  13 +
>   hw/arm/meson.build                          |   1 +
>   hw/arm/npcm8xx.c                            | 804 ++++++++++++++++++++
>   include/hw/arm/npcm8xx.h                    | 107 +++
>   5 files changed, 926 insertions(+)
>   create mode 100644 hw/arm/npcm8xx.c
>   create mode 100644 include/hw/arm/npcm8xx.h


> diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
> new file mode 100644
> index 0000000000..2c8cfb1289
> --- /dev/null
> +++ b/include/hw/arm/npcm8xx.h
> @@ -0,0 +1,107 @@
> +/*
> + * Nuvoton NPCM8xx SoC family.
> + *
> + * Copyright 2022 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +#ifndef NPCM8XX_H
> +#define NPCM8XX_H
> +
> +#include "hw/boards.h"

Not necessary (MachineState is forward-declarated).

> +#include "hw/adc/npcm7xx_adc.h"
> +#include "hw/core/split-irq.h"
> +#include "hw/cpu/cluster.h"
> +#include "hw/gpio/npcm7xx_gpio.h"
> +#include "hw/i2c/npcm7xx_smbus.h"
> +#include "hw/intc/arm_gic_common.h"
> +#include "hw/mem/npcm7xx_mc.h"
> +#include "hw/misc/npcm_clk.h"
> +#include "hw/misc/npcm_gcr.h"
> +#include "hw/misc/npcm7xx_mft.h"
> +#include "hw/misc/npcm7xx_pwm.h"
> +#include "hw/misc/npcm7xx_rng.h"
> +#include "hw/net/npcm7xx_emc.h"
> +#include "hw/nvram/npcm7xx_otp.h"
> +#include "hw/sd/npcm7xx_sdhci.h"
> +#include "hw/timer/npcm7xx_timer.h"
> +#include "hw/ssi/npcm7xx_fiu.h"
> +#include "hw/usb/hcd-ehci.h"
> +#include "hw/usb/hcd-ohci.h"
> +#include "target/arm/cpu.h"


> +/**
> + * npcm8xx_load_kernel - Loads memory with everything needed to boot
> + * @machine - The machine containing the SoC to be booted.
> + * @soc - The SoC containing the CPU to be booted.
> + *
> + * This will set up the ARM boot info structure for the specific NPCM8xx
> + * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
> + * into memory, if requested by the user.
> + */
> +void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc);
> +
> +#endif /* NPCM8XX_H */


