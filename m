Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B8EC36013
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txruK-00088u-DX; Thu, 27 Mar 2025 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txru0-00086U-Sm
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txrty-0003Wa-9q
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:28 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1087971f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743099863; x=1743704663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uF5SeKhZI3Nn+8j2LeUDfw3h5jEFvSqO/j0ufeklhgk=;
 b=nvcdJNC2rqN8oOmQeDefQqRhqTziGQo2OLXDjxiLOfPygO1KavHWaoYsuaV5GVCVNC
 bJTiDuU5Ekl01X3QL4FGF6XlC5x3WubuUU3HRBNfAI/MVPfT0WshA/Q3VLPnPpk5KTUO
 7PRJPkBQLECh7s6h4fWPfJq7xE7lmV+lTFGummPqSP8c/T39KrhvAFwQY3BglWLFylkp
 nPP/Zv0ZMsJRMAWlaTbnN82bShRWbhlDXtlMT3690VRjM455GwSd9MmK2NWhy4RSO0EA
 Pw6UhOEbDFx5I95aKnPTe4TtnPg30BG/2oHlIipuwtAjKhYrMUlfP/Hx0ZrQzcmZ2fbz
 0ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743099863; x=1743704663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uF5SeKhZI3Nn+8j2LeUDfw3h5jEFvSqO/j0ufeklhgk=;
 b=gE/BFke5rnLJKO/mpkOf2T18Q9/LfcencgOsPb6MFb5Sm0rYiPHy86r6FLzI79QDHm
 43suvoo3aWrZoQDA5TFG6mePuJe1ia6appqulSJ5a2vcMohSOJwdyUeR/nDnWdKbHzVE
 LT4Q+Fh2s7JfRpTKjCWbFpp1wK+D0OxVxnQ1z0A/tgu6jx1/cLc5spe18vyz0JO1qm3y
 NmF9oC0SJFz2WU5Xn4Fg/C9TwMTP5fRGl9MnsjfoSj0eWmMRVKE6sJmknDIHI6Ap7F98
 A90IfatQbutlE2n0zC8EAl6thCXSwOjbgQoeJXELrVF6/u9Iflz5a3t12OHav7PG6HAv
 A1pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJvRiZ5qVZ6IGIwpi9KS3DhMIEGDJZ4seGyU6UruyoaiIhfjHtAnNwvs2gNNZcdz1vt+9XR3XwNUYf@nongnu.org
X-Gm-Message-State: AOJu0YyT/QxXbIimJiG++/6Ix+IQYYeM1aT+1LTU0IKnvbMoJN/Ktx0b
 Tk4kqqZfZ8SWx3XhuJ6dhl+SZzCZTY7SSlK3gsF1mZ1ihVB7JI5NuUbDSS9/lN4=
X-Gm-Gg: ASbGncsRRGwwaf/4OTyjpiZRO/scaaEl4G+2JlJml0dSv9BjN+YI3kZBeiyC+BpmsDf
 CpZJ5VS7J4oKdcCv5dXMP9D8R27nTdj8ia4FnTXpyJX1vfrl+OEWPpzeiNi3pQwj00wTjuV4PZe
 sNnCXvC/H3JTO9xCkkNN1Jx9oeWu4waJsYpUt6/JbjcdXZWUWfjlXRcT9A5smgJ520wG+fb2M9E
 1PCsHsHlBDnWJzn1+5J8TOFTU9LfxechZpaptJc2LEMLzOgcEWCj2H4rfgBvjDWO5AvLddMfjp5
 71rJY9b3wAPalfwjKTLwUKKzDqV1Qm/dAy7rN7X+bG/Q7Aa7OjCXaLvdALAOWbZp7oWaQ5NWfz6
 ZxMJq6hJJck7R
X-Google-Smtp-Source: AGHT+IGC2U3NfupT7WV9N1+73Zezzt/oxYu+Zpf76nlIGuQnb3UXEX6eatXrfD2mDW2kEWojPzBQ2Q==
X-Received: by 2002:a05:6000:40e1:b0:391:255a:748b with SMTP id
 ffacd0b85a97d-39ad1784903mr4518139f8f.39.1743099863076; 
 Thu, 27 Mar 2025 11:24:23 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314f5c6sm46747875e9.40.2025.03.27.11.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 11:24:22 -0700 (PDT)
Message-ID: <dee36972-4483-492d-a64f-17c0d0000f59@linaro.org>
Date: Thu, 27 Mar 2025 19:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/3/25 23:44, Richard Henderson wrote:
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

Please declare sram_io_mem in AtmegaMcuState, after sram_io.

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

