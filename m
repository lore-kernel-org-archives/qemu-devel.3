Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86CCC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxqU-0006qU-3A; Thu, 06 Feb 2025 04:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxqQ-0006q8-OC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:06:47 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxqO-0008Cc-Mp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:06:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dae9a0566so266286f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738832803; x=1739437603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzCJVvvfB1EaRb4n7nTPbLIP0W9cumDbV+oH5GXptgs=;
 b=Wfl2z4jaKejKQjxVllFulSmaqfsKLnTJOao8meIdEzl/d+ssvfPg71Ixorpq4HO6Lk
 2Md1mlsXw1Tl/KNM/sx2O/5W0wCfy3BSS573qeBMGpJJOMX3BJoe9A3oiphHvH5uXuIX
 GnMapvGTk4kPLeJisZ1qCHUrTl4Firvcrhn+rbnjU3rME88bEpTgg1oo366cGmTHhq3w
 DORghthnrr+ERTUBG6cUvGgzRRbKPPg1MRl6lHx8eeT+MAMltESf1m1dhZqX2jv2PZ8X
 u0whhFs4HZdqE9r4ozcv+oFRSxMKzoKPDjV9vqMqpmHeJNCynRZUZ2fifnKZkYcEhu06
 H1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738832803; x=1739437603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzCJVvvfB1EaRb4n7nTPbLIP0W9cumDbV+oH5GXptgs=;
 b=iOO5N/ufA5B1EKZ8GcwbpWV8rqV8QsYQlvZ6ODnmSfMJc2z42qWfiVfdWgs3WXCUbP
 7YQoZ154o7UUmGz8g7H8QN7Ds0UbDVNUaK6WuN7zkaZZBiU3R2B7nlTG70zG3Lj4yKt5
 Ck/p3NvPByQdDkVUndoiwR2oBaa6pOphKize5dMlQCPsM+DyI7WgwUtlSXHEf9pj2dH9
 1ozIp5iJgLXRqEIz5nl6uTrVmQrSkLC/WAUJxgVPFh7eR0hwhJ2tVpcknV5+1QZu/e+i
 AqS4rmsjxxhR1CxvoUAdMtMR64ZusMreoXmR2/bMpTwlEwF1ED9l9iO00Uz8YftjoHU0
 MJVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJVLHrhyV1SJzwSQDUuhSKU8Bq+wjeh01Q5iuYFkkmVOZGHiGgZMng7RUTZLbRlqVJlw+AG5TB0L1g@nongnu.org
X-Gm-Message-State: AOJu0YxqozWp21fkaEQy7OowNO1VLJZeKPN8slpsYrvigcrcShtF0uVl
 K/tLb/pnmP0UEfjPEZGUtcSIUdxpDjJimecGlKVywbsCImWD6EGHs8Kr1gJo2R4=
X-Gm-Gg: ASbGncuKjC+xkv2yYrep476oITC6jpdclDFdt42MTcQucERpoaTjIc+6/fC4TIzEtM1
 ztaSZD46UEHmPz3fRoCgzvShOJkx2V4U4e52ZffeAZwPprdJ4qt3E0NwgF02MUP0w4lHMkbdh5R
 niNbLZA+MQw89Yusylqbl99Zy1PGbbyDvGBqtZVb9MaXmRXiZ44EauZKSkDgotfbOcjA68us/Vv
 zxBjdYzkT9W4rZF7LB6+s2h2x7wmIZHgI9wRld7/5j1cA+efIOTHPFTdh9JnFGg53RV7M9H99dF
 kp5+r/Ovr/5zDZAxpfsEKiLAKeZbFhydtP/Qrdk0vqxr3P0ek34ybOAbVzY=
X-Google-Smtp-Source: AGHT+IFbMv9XKV1GETfc05io7Kbe/qY9nyLARm8SIgneOGEa6PLUau6IEQaR3iG5eRZXRnBigTDGIQ==
X-Received: by 2002:a05:6000:1fa4:b0:38d:b125:3787 with SMTP id
 ffacd0b85a97d-38db48bcac1mr3965207f8f.17.1738832802699; 
 Thu, 06 Feb 2025 01:06:42 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde31ccesm1176186f8f.98.2025.02.06.01.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:06:42 -0800 (PST)
Message-ID: <20258263-a231-45be-b0f4-f6499d613640@linaro.org>
Date: Thu, 6 Feb 2025 10:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] hw/ssi: Make flash size a property in NPCM7XX FIU
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-4-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-4-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Hao,

On 6/2/25 02:30, Hao Wu wrote:
> This allows different FIUs to have different flash sizes, useful
> in NPCM8XX which has multiple different sized FIU modules.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/arm/npcm7xx.c             |  6 ++++++
>   hw/ssi/npcm7xx_fiu.c         | 11 +++++++----
>   include/hw/ssi/npcm7xx_fiu.h |  1 +
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index 386b2c35e9..2d6e08b72b 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -292,17 +292,21 @@ static const struct {
>       hwaddr regs_addr;
>       int cs_count;
>       const hwaddr *flash_addr;
> +    size_t flash_size;
>   } npcm7xx_fiu[] = {
>       {
>           .name = "fiu0",
>           .regs_addr = 0xfb000000,
>           .cs_count = ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
>           .flash_addr = npcm7xx_fiu0_flash_addr,
> +        .flash_size = 128 * MiB,
> +
>       }, {
>           .name = "fiu3",
>           .regs_addr = 0xc0000000,
>           .cs_count = ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
>           .flash_addr = npcm7xx_fiu3_flash_addr,
> +        .flash_size = 128 * MiB,
>       },
>   };
>   
> @@ -735,6 +739,8 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>   
>           object_property_set_int(OBJECT(sbd), "cs-count",
>                                   npcm7xx_fiu[i].cs_count, &error_abort);
> +        object_property_set_int(OBJECT(sbd), "flash-size",
> +                                npcm7xx_fiu[i].flash_size, &error_abort);
>           sysbus_realize(sbd, &error_abort);
>   
>           sysbus_mmio_map(sbd, 0, npcm7xx_fiu[i].regs_addr);
> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> index 21fc489038..ccdce67fa9 100644
> --- a/hw/ssi/npcm7xx_fiu.c
> +++ b/hw/ssi/npcm7xx_fiu.c
> @@ -28,9 +28,6 @@
>   
>   #include "trace.h"
>   
> -/* Up to 128 MiB of flash may be accessed directly as memory. */
> -#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
> -
>   /* Each module has 4 KiB of register space. Only a fraction of it is used. */
>   #define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
>   
> @@ -507,6 +504,11 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    if (s->flash_size == 0) {
> +        error_setg(errp, "%s: flash size must be set", dev->canonical_path);
> +        return;
> +    }
> +
>       s->spi = ssi_create_bus(dev, "spi");
>       s->cs_lines = g_new0(qemu_irq, s->cs_count);
>       qdev_init_gpio_out_named(DEVICE(s), s->cs_lines, "cs", s->cs_count);
> @@ -525,7 +527,7 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
>           flash->fiu = s;
>           memory_region_init_io(&flash->direct_access, OBJECT(s),
>                                 &npcm7xx_fiu_flash_ops, &s->flash[i], "flash",
> -                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
> +                              s->flash_size);

Per the comment, this is the device aperture.

Either add a check whether size is always <= 128 * MiB, or use
MIN(s->flash_size, NPCM7XX_FIU_FLASH_WINDOW_SIZE)?

>           sysbus_init_mmio(sbd, &flash->direct_access);
>       }
>   }
> @@ -543,6 +545,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
>   
>   static const Property npcm7xx_fiu_properties[] = {
>       DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
> +    DEFINE_PROP_SIZE("flash-size", NPCM7xxFIUState, flash_size, 0),
>   };
>   
>   static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.h
> index a3a1704289..1785ea16f4 100644
> --- a/include/hw/ssi/npcm7xx_fiu.h
> +++ b/include/hw/ssi/npcm7xx_fiu.h
> @@ -60,6 +60,7 @@ struct NPCM7xxFIUState {
>       int32_t cs_count;
>       int32_t active_cs;
>       qemu_irq *cs_lines;
> +    size_t flash_size;
>       NPCM7xxFIUFlash *flash;
>   
>       SSIBus *spi;


