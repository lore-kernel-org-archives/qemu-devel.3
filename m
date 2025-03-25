Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8EC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEY-0001YB-3N; Mon, 24 Mar 2025 21:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtER-0001WP-8y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:31 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEP-0007QF-9h
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:31 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30362ee1312so1610517a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866648; x=1743471448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2mbYEXOhUiqCfK+pSBO34P8IdJNnYPI/baQPVvT0po=;
 b=v8gjk/Sz6mzHcJZa4gIud3VCdvOS8f1FF9bSXS1D2vUkMdNp/lIjmB0gAf+GrgKtqM
 xblR96HdT0lFxmwm9bQsQ8hv6eZuE3TWjQV6X93zkiCbX09wGWqJ/8es1bLEe1sYD4JX
 ufKwnf0WZvzToZ+AepWZRkR7+p6BkYR7Kw4buEUklaFK8LM0XNIHttIZQ1sk1Yn7Tyl1
 Nv/2wvbcu+AJTravRO0zmf1zJRD31xZKhqVhQx7OBdsvz5LGHC38Rie+KLtihxQqIk6+
 wdtUcy9piweSN+8UrrcSHTWeJUAFZfAqRs9rXi5He9USYAnkdiS/HiG3sypdcdWv/bvf
 nn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866648; x=1743471448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2mbYEXOhUiqCfK+pSBO34P8IdJNnYPI/baQPVvT0po=;
 b=fIKp/BG3etiza1P2ykdX/J2CDdK9uyPAphU+fMcApTu2SjTYKcNl7JPzjdyyOcrc+x
 Dy52j9Zlng1lR26xgzj0HjQhRULpDJeQPssUKCC+hDwgoG7R7S6QxLJETqF3vFxzRSlV
 LOcku4il62U03nrH7yVMH5FEKdMIv+1kKtXTGBWvL467QqJcgnXcAXfGwS0x7uH8mncQ
 nOsOkvNHr2kEvFYSP9RKlkPzzIe2yyIWm7JWVu+GGSQ29ZBDVH5GstPOWXaBlOpTuDax
 ztM5HSgJ99uGRKWwkwj+8cp/J9ti3o3zIaiqu/nb8BsvZZ8zkoBsZAnEoUSO/+y8VaJ4
 86oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7oPMvlWwJpzZ1uBH+fJjlZh3xzNEXn3QXq9CM9SADOpzT30Q5Z1AcUaM/pjlHaBRttGI66H8TOTZR@nongnu.org
X-Gm-Message-State: AOJu0YwC1jgOer6vU/V/aj3f3rFPkyppczTexb/P2ETHZRn7cBPx3zjb
 eRZQR2CF1wufdyHxRMUcqMg4b2ITaWJN6wwKQft/wWTE5teZn3d0333lJzwoMWg=
X-Gm-Gg: ASbGncuE5hA0/G8OFXZav5+cQbXDhPHyy1Z2Hiq/5JJA8peA2dhCeYtSbTHV9IA7/xY
 MsJ0CIQlr9Rn4erKzT6CctnmQcvcSOGpPE9STL0RJtHpm/wMRDIzkAiGUu58R9hfgKHlAVK+iaG
 N1e/Jew3yMtWTHJXVv6VHc+6qXvnAq2h1dTvVK+FdgrsMKO8JYwaVzIjPptGsu3cCGhcjv9MwBR
 zsTtWfJuTGMoBz9yMcXuHQMQcMP8yJPlb2H7nbzZq/18se3ntQkYMaB7ofnpWjD1GQ1Fiq0GoQV
 0TxypQewqC411pNf58KqzmWU7GprAz/vyvQJ/ikv2EYF6EXmsGP34c0pcA==
X-Google-Smtp-Source: AGHT+IHuoIySUrq9lZzMF7Z/adbot5mQdfRYj0j1rvkExpPYO125OW2mj/R4qgkLhOlZvlCI0phyaA==
X-Received: by 2002:a05:6a21:999a:b0:1f5:67c2:e3eb with SMTP id
 adf61e73a8af0-1fe43439eb8mr25169786637.41.1742866647431; 
 Mon, 24 Mar 2025 18:37:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:26 -0700 (PDT)
Message-ID: <5c19c4ac-fed9-4405-921d-42da3a4ed93c@linaro.org>
Date: Mon, 24 Mar 2025 18:21:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hw/avr: Set offset_io and increase page size to 1k
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu-param.h |  8 +------
>   hw/avr/atmega.c        | 54 ++++++++++++++++++++++++++----------------
>   2 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> index 81f3f49ee1..f5248ce9e7 100644
> --- a/target/avr/cpu-param.h
> +++ b/target/avr/cpu-param.h
> @@ -21,13 +21,7 @@
>   #ifndef AVR_CPU_PARAM_H
>   #define AVR_CPU_PARAM_H
>   
> -/*
> - * TARGET_PAGE_BITS cannot be more than 8 bits because
> - * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
> - *     should be implemented as a device and not memory
> - * 2.  SRAM starts at the address 0x0100
> - */
> -#define TARGET_PAGE_BITS 8
> +#define TARGET_PAGE_BITS 10
>   #define TARGET_PHYS_ADDR_SPACE_BITS 24
>   #define TARGET_VIRT_ADDR_SPACE_BITS 24
>   
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 273582b8af..d4fc9c4aee 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -14,6 +14,7 @@
>   #include "qapi/error.h"
>   #include "exec/memory.h"
>   #include "exec/address-spaces.h"
> +#include "exec/target_page.h"
>   #include "system/system.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
> @@ -222,6 +223,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>       DeviceState *cpudev;
>       SysBusDevice *sbd;
>       char *devname;
> +    uint32_t offset_io, offset_sram;
>       size_t i;
>   
>       assert(mc->io_size <= 0x200);
> @@ -231,13 +233,25 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    /*
> +     * Bias the virtual data section so that the start of RAM is at
> +     * the start of the second page of the physical data section.
> +     * This puts all of the I/O at the end of the first page of the
> +     * physical data section.
> +     */
> +    offset_io = TARGET_PAGE_SIZE - mc->io_size;
> +    offset_sram = TARGET_PAGE_SIZE;
> +
>       /* CPU */
>       object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
>   
>       object_property_set_uint(OBJECT(&s->cpu), "init-sp",
>                                mc->io_size + mc->sram_size - 1, &error_abort);
>       object_property_set_uint(OBJECT(&s->cpu), "offset-io",
> -                             0, &error_abort);
> +                             offset_io, &error_abort);
> +
> +    offset_io += OFFSET_DATA;
> +    offset_sram += OFFSET_DATA;
>   
>       qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>       cpudev = DEVICE(&s->cpu);
> @@ -245,8 +259,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>       /* SRAM */
>       memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
>                              &error_abort);
> -    memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA + mc->io_size, &s->sram);
> +    memory_region_add_subregion(get_system_memory(), offset_sram, &s->sram);
>   
>       /* Flash */
>       memory_region_init_rom(&s->flash, OBJECT(dev),
> @@ -258,13 +271,14 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>        *
>        * 0x00 - 0x1f: Registers
>        * 0x20 - 0x5f: I/O memory
> -     * 0x60 - 0xff: Extended I/O
> +     * 0x60 - 0x[1]ff: Extended I/O
>        */
>       s->io = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
>       qdev_prop_set_string(s->io, "name", "I/O");
>       qdev_prop_set_uint64(s->io, "size", mc->io_size);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(s->io), &error_fatal);
> -    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA, -1234);
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, offset_io, -1234);
>   
>       /* Power Reduction */
>       for (i = 0; i < POWER_MAX; i++) {
> @@ -277,7 +291,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>                                   TYPE_AVR_MASK);
>           sysbus_realize(SYS_BUS_DEVICE(&s->pwr[i]), &error_abort);
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
> -                        OFFSET_DATA + mc->dev[idx].addr);
> +                        offset_io + mc->dev[idx].addr);
>           g_free(devname);
>       }
>   
> @@ -289,7 +303,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>           }
>           devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
>           create_unimplemented_device(devname,
> -                                    OFFSET_DATA + mc->dev[idx].addr, 3);
> +                                    offset_io + mc->dev[idx].addr, 3);
>           g_free(devname);
>       }
>   
> @@ -305,7 +319,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>           qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i));
>           sbd = SYS_BUS_DEVICE(&s->usart[i]);
>           sysbus_realize(sbd, &error_abort);
> -        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
> +        sysbus_mmio_map(sbd, 0, offset_io + mc->dev[USART(i)].addr);
>           connect_peripheral_irq(mc, sbd, 0, cpudev, USART_RXC_IRQ(i));
>           connect_peripheral_irq(mc, sbd, 1, cpudev, USART_DRE_IRQ(i));
>           connect_peripheral_irq(mc, sbd, 2, cpudev, USART_TXC_IRQ(i));
> @@ -321,12 +335,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>           }
>           if (!mc->dev[idx].is_timer16) {
>               create_unimplemented_device("avr-timer8",
> -                                        OFFSET_DATA + mc->dev[idx].addr, 5);
> +                                        offset_io + mc->dev[idx].addr, 5);
>               create_unimplemented_device("avr-timer8-intmask",
> -                                        OFFSET_DATA
> +                                        offset_io
>                                           + mc->dev[idx].intmask_addr, 1);
>               create_unimplemented_device("avr-timer8-intflag",
> -                                        OFFSET_DATA
> +                                        offset_io
>                                           + mc->dev[idx].intflag_addr, 1);
>               continue;
>           }
> @@ -337,9 +351,9 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>                                    s->xtal_freq_hz, &error_abort);
>           sbd = SYS_BUS_DEVICE(&s->timer[i]);
>           sysbus_realize(sbd, &error_abort);
> -        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
> -        sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc->dev[idx].intmask_addr);
> -        sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc->dev[idx].intflag_addr);
> +        sysbus_mmio_map(sbd, 0, offset_io + mc->dev[idx].addr);
> +        sysbus_mmio_map(sbd, 1, offset_io + mc->dev[idx].intmask_addr);
> +        sysbus_mmio_map(sbd, 2, offset_io + mc->dev[idx].intflag_addr);
>           connect_peripheral_irq(mc, sbd, 0, cpudev, TIMER_CAPT_IRQ(i));
>           connect_peripheral_irq(mc, sbd, 1, cpudev, TIMER_COMPA_IRQ(i));
>           connect_peripheral_irq(mc, sbd, 2, cpudev, TIMER_COMPB_IRQ(i));
> @@ -349,12 +363,12 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>           g_free(devname);
>       }
>   
> -    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8, 6);
> -    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078, 8);
> -    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074, 2);
> -    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060, 1);
> -    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c, 3);
> -    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
> +    create_unimplemented_device("avr-twi",          offset_io + 0x0b8, 6);
> +    create_unimplemented_device("avr-adc",          offset_io + 0x078, 8);
> +    create_unimplemented_device("avr-ext-mem-ctrl", offset_io + 0x074, 2);
> +    create_unimplemented_device("avr-watchdog",     offset_io + 0x060, 1);
> +    create_unimplemented_device("avr-spi",          offset_io + 0x04c, 3);
> +    create_unimplemented_device("avr-eeprom",       offset_io + 0x03f, 3);
>   }
>   
>   static const Property atmega_props[] = {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


