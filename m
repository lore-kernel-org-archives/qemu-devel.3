Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4BBC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txSh6-0000u4-OA; Wed, 26 Mar 2025 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh1-0000r9-Q8
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSgz-0005ik-PG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2255003f4c6so457315ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002960; x=1743607760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2+niFRVTMJRdZez4RhAi1o+lkjF/AM3JuYUoySr+NOM=;
 b=eWkCAtJ9F3i8cU+IuhxYht2IFbo6cTtxl8JaDmiYPN7SUb8s4srY1y6g6SKxUPoGKU
 VktmUjO5Ol9L1pb/49UYdElAsp3lEfhgmKHTyayKweiIxR9nDUN9O/rcZ0jMPxh8cnGz
 Gijk2+OTCIC2F4cctO3yJpSmyoyn+tHWZOgCq2wz+ixTVgZ+6bA1sRI+wbaynRi2PaaC
 542/p+F+2ZHBlRf1gUMAKxNe9wpT/jXjU1dDgIxc2y0K4E8r38/pfc52D2apKi3RZH9j
 WhPu6UhJO9+DW/birBGjNycTGvlGcTj2y5aVdw+nET/n4h90AzwEJ7h9mc7yU6aBzU5x
 et+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002960; x=1743607760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+niFRVTMJRdZez4RhAi1o+lkjF/AM3JuYUoySr+NOM=;
 b=tkA9mz7vIgMsrbdcBiNv8h76E5CB0RV/5nlPP4h8AoHFRnYOhFP1WomA9pkDFDIl/T
 R88hpDJTrLvSFYZ55SgO3KYApMTMSRaIpdGEi/rLrz4/WlO19Krz3p8VAyiNAgTX7+pA
 WHbaxZFhg+nrUcxmNJ96fZtK1oO6J3vxSAebdiY0GTdP1hpuZzDB2Ll5TEGhCskN6SR2
 DPMRnl8vKltEK3EqehfbS7wDFvQQniUImwaJFoxd3xfLNFeIc+lQL5mWSYaxyDIIw271
 BRHJqqfnRkZLEwQNxOrAytjHs3fY85y3B3WH7FZvOTXWqd2xqsXmTPLJu06RLrIj+Gpm
 Q35Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo3oO92uVe3zti/xEjMVwr2YXfM1Z/J2UCySKrLF3YhT7u1WsCGVsS/cJhJTZZh41uNvmSCABX2cOI@nongnu.org
X-Gm-Message-State: AOJu0Yyz8OgmAGdgfqO9qnMMLqR/NJGwKYI5ro+MQ6bYQ0xMedlq5b/E
 U8cZFbFjWDBO0flrkTIqpZjKAQGeESEDyL4NPllb+dcuGhQohdpmFnt+zXyGn+hPvT/ci0jCIcT
 i
X-Gm-Gg: ASbGncv/AgEh8E4+8lp0KR40DKnrEa6OU5yxuapZ9GXk4E6p1/3YkvPVjEb5OtuKZpv
 NqK7LRWlM5MzCBeCovS1SBRtsKUZaWlvs5s0YRSJb6X5LAVZUUk0jvxMKtc0s/HuKajLXsH5MEN
 b3gZKRiiQPvAcPfPW7Cv4p3jnQjr3jym+/b4l16KX27tuf20MOmT5qC50Rcba1xfHUhiULm9hou
 h5HLVRck/q1MFJX2koHhMQXOgzCoZ3J5eexOXsQdV8onD0FRuL8p0Jx5+2cXEQK+tKwTDU5TEbd
 5uE/6vglYRCiYZ/dml//uS92T4SyP9f9O3iyuFB+THi+COJ73GCx7ENvJts/fRrmWmeH
X-Google-Smtp-Source: AGHT+IHqYS5wuBY0ZfH0pGyxVIVqG6CpF44aU7G1PnJ6qykviEaFsjyd8NaZE8s6d+Oj+ptskG3CDQ==
X-Received: by 2002:a17:902:e74d:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22780e10df0mr320196865ad.39.1743002960110; 
 Wed, 26 Mar 2025 08:29:20 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:19 -0700 (PDT)
Message-ID: <b5b28249-0548-48fc-9967-19a2f9e8d247@linaro.org>
Date: Wed, 26 Mar 2025 08:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325224403.4011975-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/25/25 15:44, Richard Henderson wrote:
> If i/o does not cover the entire first page, allocate a portion
> of ram as an i/o device, so that the entire first page is i/o.
> 
> While memory_region_init_ram_device_ptr is happy to allocate
> the RAMBlock, it does not register the ram for migration.
> Do this by hand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/avr/atmega.h |  1 +
>   hw/avr/atmega.c | 39 ++++++++++++++++++++++++++++++++-------
>   2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..9ac4678231 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -41,6 +41,7 @@ struct AtmegaMcuState {
>       MemoryRegion flash;
>       MemoryRegion eeprom;
>       MemoryRegion sram;
> +    MemoryRegion sram_io;
>       DeviceState *io;
>       AVRMaskState pwr[POWER_MAX];
>       AVRUsartState usart[USART_MAX];
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index f6844bf118..11fab184de 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -19,6 +19,7 @@
>   #include "hw/sysbus.h"
>   #include "qom/object.h"
>   #include "hw/misc/unimp.h"
> +#include "migration/vmstate.h"
>   #include "atmega.h"
>   
>   enum AtmegaPeripheral {
> @@ -224,8 +225,6 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>       char *devname;
>       size_t i;
>   
> -    assert(mc->io_size <= 0x200);
> -
>       if (!s->xtal_freq_hz) {
>           error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
>           return;
> @@ -240,11 +239,37 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>       qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>       cpudev = DEVICE(&s->cpu);
>   
> -    /* SRAM */
> -    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
> -                           &error_abort);
> -    memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA + mc->io_size, &s->sram);
> +    /*
> +     * SRAM
> +     *
> +     * Softmmu is not able mix i/o and ram on the same page.
> +     * Therefore in all cases, the first page exclusively contains i/o.
> +     *
> +     * If the MCU's i/o region matches the page size, then we can simply
> +     * allocate all ram starting at the second page.  Otherwise, we must
> +     * allocate some ram as i/o to complete the first page.
> +     */
> +    assert(mc->io_size == 0x100 || mc->io_size == 0x200);
> +    if (mc->io_size >= TARGET_PAGE_SIZE) {
> +        memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
> +                               &error_abort);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + mc->io_size, &s->sram);
> +    } else {
> +        int sram_io_size = TARGET_PAGE_SIZE - mc->io_size;
> +        void *sram_io_mem = g_malloc0(sram_io_size);
> +
> +        memory_region_init_ram_device_ptr(&s->sram_io, OBJECT(dev), "sram-as-io",
> +                                          sram_io_size, sram_io_mem);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + mc->io_size, &s->sram_io);
> +        vmstate_register_ram(&s->sram_io, dev);
> +
> +        memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
> +                               mc->sram_size - sram_io_size, &error_abort);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    OFFSET_DATA + TARGET_PAGE_SIZE, &s->sram);
> +    }
>   
>       /* Flash */
>       memory_region_init_rom(&s->flash, OBJECT(dev),

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


