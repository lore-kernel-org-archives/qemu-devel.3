Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCA9C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjyR-0007Pi-R9; Tue, 30 Jan 2024 04:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjyL-0007NP-3x
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:00:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjyJ-0000cW-9J
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:00:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40faf6788d1so352755e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706605197; x=1707209997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kaCN24dQNyXvD6n/hNhjPBiRSYdAo+dj7kInqDM1l6Y=;
 b=H3FA0VEDA8FFkyekvEu3tcTIbSpw3E14NMr5JM8RorUQ4dcJzg8chr6+v6f7eJKta5
 Jpaqpe4BvVj2nQk+JZXARI329RisBINCx66twGeBr01lH/JHCdMy8kCv3BhVW9de6pBq
 ks6pjbbbHOc9IeePmnBUsR6LPe0IunEO6CsM76Q0jOy5IDRIuOKqODBlab5E52ZnCKoc
 6L7+k96oEPyBQMT9k3IIXmJtDtoYDEvZhg8JFKRVF+wNpdvHhnDU35ZC9Czbx8pLzHWJ
 93xFCGBabiZhbx8PNR59qZykFx4tGkq+Wrh66Ojnxw2Aqr0APdue47624xhuDpDmKjZv
 +5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706605197; x=1707209997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kaCN24dQNyXvD6n/hNhjPBiRSYdAo+dj7kInqDM1l6Y=;
 b=KZKRP3OKWFYFZ2t76mK/eUQMxYn1EwSsk+W7nbFWpUvC5y0kquwNFPQ97w6cIjT0Vm
 hCdE3zYcN9hmafHw++g1/WPldfAt6VNLL8VCBGcBrpn/OvXfCni6q2dsIulk7QFqMScu
 BCoik1wDvda2sSOvIEQcR9hBUpFavUjt1GxBIDG80+QQ0on0V0B7UsF6btpYKndrTqyl
 gDIE3C6kO9WUU2H30is7QHZN9cSTjN1nLGfLnUoKm0laZhdSkQTE20pdcsz1DrMKI32h
 +UnHFSq/kuCep7Bmn0FnSYdMKfNMwUrjYxurKFbTviX1ihi+6nEoOPImApJZK+6gxukt
 2kFg==
X-Gm-Message-State: AOJu0YyJc2Tljx//zmoN3H/5Z8hvxyRI8yKq8p6/RLtJjR5pHLkqKdwX
 UVMD4mYJ7Ia66FQV887rqpQ/dScE0CLU7Mpqfo0Kf2xQNPc7jnI3c+fRjCNHiXvt93jekKvxXjO
 o
X-Google-Smtp-Source: AGHT+IE+Vn+G3g2GxG9T9UNRI3oYVT5v3lRa1uT9tKuE3VKbA95dec5c7dnD/ZE9UZrnscF1ttJFhw==
X-Received: by 2002:adf:ec4c:0:b0:338:c276:d78c with SMTP id
 w12-20020adfec4c000000b00338c276d78cmr784487wrn.1.1706605196843; 
 Tue, 30 Jan 2024 00:59:56 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c314d00b0040efb445698sm3537724wmo.5.2024.01.30.00.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:59:56 -0800 (PST)
Message-ID: <3cf25250-3114-40cf-9ef8-6e400fa64d1d@linaro.org>
Date: Tue, 30 Jan 2024 09:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] intc/grlib_irqmp: implements multicore irq
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-5-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-5-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/1/24 14:02, Clément Chigot wrote:
> Now there is an ncpus property, use it in order to deliver the IRQ to
> multiple CPU.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c         | 43 ++++++++++++++++++-----------------
>   hw/sparc/leon3.c              |  3 ++-
>   include/hw/intc/grlib_irqmp.h |  2 +-
>   3 files changed, 25 insertions(+), 23 deletions(-)


>   static void grlib_irqmp_check_irqs(IRQMPState *state)
>   {
> -    uint32_t      pend   = 0;
> -    uint32_t      level0 = 0;
> -    uint32_t      level1 = 0;
> +    uint32_t pend = 0;
> +    uint32_t level0 = 0;
> +    uint32_t level1 = 0;
> +    int i;
>   
>       assert(state != NULL);
>       assert(state->parent != NULL);
>   
> -    /* IRQ for CPU 0 (no SMP support) */
> -    pend = (state->pending | state->force[0])
> -        & state->mask[0];
> -
> -    level0 = pend & ~state->level;
> -    level1 = pend &  state->level;
> +    for (i = 0; i < state->parent->ncpus; i++) {
> +        pend = (state->pending | state->force[i]) & state->mask[i];
> +        level0 = pend & ~state->level;
> +        level1 = pend &  state->level;

     for (unsigned i = 0; i < state->parent->ncpus; i++) {
         uint32_t pend = (state->pending | state->force[i])
                         & state->mask[i];
         uint32_t level0 = pend & ~state->level;
         uint32_t level1 = pend &  state->level;

>   
> -    trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
> -                                 state->mask[0], level1, level0);
> +        trace_grlib_irqmp_check_irqs(state->pending, state->force[i],
> +                                     state->mask[i], level1, level0);
>   
> -    /* Trigger level1 interrupt first and level0 if there is no level1 */
> -    qemu_set_irq(state->parent->irq, level1 ?: level0);
> +        /* Trigger level1 interrupt first and level0 if there is no level1 */
> +        qemu_set_irq(state->parent->irq[i], level1 ?: level0);
> +    }
>   }
>   
> -static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
> +static void grlib_irqmp_ack_mask(IRQMPState *state, int cpu, uint32_t mask)

unsigned cpu, ...

>   {
>       /* Clear registers */
>       state->pending  &= ~mask;
> -    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
> +    state->force[cpu] &= ~mask;
>   
>       grlib_irqmp_check_irqs(state);
>   }
>   
> -void grlib_irqmp_ack(DeviceState *dev, int intno)
> +void grlib_irqmp_ack(DeviceState *dev, int cpu, int intno)

unsigned cpu, ...

>   {
>       IRQMP        *irqmp = GRLIB_IRQMP(dev);
>       IRQMPState   *state;
> @@ -133,7 +133,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
>   
>       trace_grlib_irqmp_ack(intno);
>   
> -    grlib_irqmp_ack_mask(state, mask);
> +    grlib_irqmp_ack_mask(state, cpu, mask);
>   }
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


