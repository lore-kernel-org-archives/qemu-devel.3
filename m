Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31DC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2dA-00034e-Dp; Mon, 17 Feb 2025 10:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2d8-00034N-S7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:01:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2d6-0006xk-UY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:01:54 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f325dd90eso1461978f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739804510; x=1740409310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AAzIQyMN9qYAjU2Tp3QEwJMsCO2X01fJXoL87c9eZM=;
 b=usWzgJC7HCl/VhhkxOWTm7VZUjiY72HqiDkOsRekE+YH2yDPXj0SMyF0TeOsfG8/9V
 hvYxAMU3fR1JHR+tzDjxnALSCDT1q8nwh/kAbq9EfYaP2yBFTE4dalIu0OD6XOhQwP+H
 2IjCAdtQcRWRlW6wf/LhTldylmCWF1/QuRyQYaGubrNvbBnxvQhqmyDoW71vStMb7MpI
 c69ZYiNw0ALqxxEZVBSBmJjMS9Ih2yhngWHJ5JCYFzyVomHPHfacxGefuZbEXFIRonFl
 27Ls5kFRD5N0IKwZHWO3ACmeV6jHDFzu08DKJFVR5U5wQyKfaaeFW3FFaKRCgbz/Hr/m
 O9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739804510; x=1740409310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AAzIQyMN9qYAjU2Tp3QEwJMsCO2X01fJXoL87c9eZM=;
 b=dhtqpObAq7W4G0ZdC5+3Z/uEzgLASj4/ef+qCcdLRLw8d9pZ57KfCiqupTOZcRoFHv
 lQFz8RKtEc9Bbe4tilRLdtxohNca0i6uduD5YccQRqJNP0KjSrfNJfVYs/vG0OSNs1IT
 5D44StdXc0A/NClI7nAUc8BgFMd9PPRb6Fdz7lhJZSUNtJA+mAlWdwzSE5rCxM6nCWKF
 5kpibW1h3a950LZQWWBjLZp1XIbXS+PrbRVup+tz9N4GnsT/jGHHvF2pYLXOdQB1mL6+
 j1kJQuKlGNFz8hq952NmVeRHKjrBsreeimUvLRtNs346BIt0R243aGYSWdBtMyvvfd9a
 wRGg==
X-Gm-Message-State: AOJu0Yzm0EVUQi5V9veW5BcQZzHo7hPxz9rdWwKPWLho/gPCKRZ9XwwC
 NlL1O1PiW3XsQp5qE+5TY97/2S9+iP1griAYii3ldTlFYiaOn38WGDOI05JIhPM=
X-Gm-Gg: ASbGncsafe6sfoh8rh/26mF5+bXK3VyeqEnYx8pCXxutMiMT+85JPBo0tdZc97IMRdS
 HtWdOjJ11eQ2oBDXxAPxEfRlZBYN+irQlG47fwDt9f+J+0h5R3lxImltQO8Sgr4p5oMcZhA4SaM
 c8cQvbJaqTS/e3PV6k7ZvevFFBpR835BwToFo03ZPDwl2hD50+m3YHxpDngN+bGLpuFZSvQermL
 zrxtuNOGGgZuh5r598SmFc6fFpEivHfSa+jgw8aHWp//rxycQNPNXz2am9Bfg3Pi+aKkVR6sDCu
 d+kSgSKhUK8mQei8XKjfExDMa9drHg==
X-Google-Smtp-Source: AGHT+IFgDPjon7CRTeHv9/585GbSQr6lPZYnnAggj/PUO7tDZNXLK2wK8w5zFFGob2D/MOxoGAi5KA==
X-Received: by 2002:a05:6000:1862:b0:38f:4c8a:d5ea with SMTP id
 ffacd0b85a97d-38f4c8ad67cmr1782672f8f.22.1739804510055; 
 Mon, 17 Feb 2025 07:01:50 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b432asm12235412f8f.6.2025.02.17.07.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 07:01:49 -0800 (PST)
Message-ID: <17651f42-8a9d-444c-8598-b0a6c099cbe6@linaro.org>
Date: Mon, 17 Feb 2025 16:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] hw/char/pl011: Consider TX FIFO overrun error
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-6-philmd@linaro.org>
 <CAFEAcA8ZSSD=TxCier0Ji8+DVDspgqKQeKJyVDZ+LEBy=j9=Lw@mail.gmail.com>
 <CAFEAcA_MLUCqBPLfdwp1u-TEFLz-u5MsmAFeGEYfpOgC0cX8zQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_MLUCqBPLfdwp1u-TEFLz-u5MsmAFeGEYfpOgC0cX8zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 17/2/25 15:52, Peter Maydell wrote:
> On Mon, 17 Feb 2025 at 14:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> When transmission is disabled, characters are still queued
>>> to the FIFO which eventually overruns. Report that error
>>> condition in the status register.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/char/pl011.c      | 20 ++++++++++++++++++++
>>>   hw/char/trace-events |  2 ++
>>>   2 files changed, 22 insertions(+)
>>>
>>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>>> index 447f185e2d5..ef39ab666a2 100644
>>> --- a/hw/char/pl011.c
>>> +++ b/hw/char/pl011.c
>>> @@ -61,6 +61,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
>>>   /* Data Register, UARTDR */
>>>   #define DR_BE   (1 << 10)
>>>
>>> +/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
>>> +#define RSR_OE  (1 << 3)
>>> +
>>>   /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
>>>   #define INT_OE (1 << 10)
>>>   #define INT_BE (1 << 9)
>>> @@ -158,6 +161,16 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
>>>       return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
>>>   }
>>>
>>> +static bool pl011_is_tx_fifo_full(PL011State *s)
>>> +{
>>> +    if (pl011_is_fifo_enabled(s)) {
>>> +        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fifo));
>>> +        return fifo8_is_full(&s->xmit_fifo);
>>> +    }
>>> +    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo));
>>> +    return !fifo8_is_empty(&s->xmit_fifo);
>>
>> More repetition of expressions, but anyway
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Here I propose to squash in this tweak:
> 
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -165,12 +165,13 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
> 
>   static bool pl011_is_tx_fifo_full(PL011State *s)
>   {
> -    if (pl011_is_fifo_enabled(s)) {
> -        trace_pl011_fifo_tx_is_full("FIFO", fifo8_is_full(&s->xmit_fifo));
> -        return fifo8_is_full(&s->xmit_fifo);
> -    }
> -    trace_pl011_fifo_tx_is_full("CHAR", !fifo8_is_empty(&s->xmit_fifo));
> -    return !fifo8_is_empty(&s->xmit_fifo);
> +    bool fifo_enabled = pl011_is_fifo_enabled(s);
> +    bool tx_fifo_full = fifo_enabled ?
> +        fifo8_is_full(&s->xmit_fifo) : !fifo8_is_empty(&s->xmit_fifo);
> +
> +    trace_pl011_fifo_tx_is_full(fifo_enabled ? "FIFO" : "CHAR",
> +                                tx_fifo_full);
> +    return tx_fifo_full;
>   }

Thank you, appreciated!

> 
> thanks
> -- PMM


