Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE7BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmen-0001ln-SP; Tue, 28 Jan 2025 09:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tcmem-0001kd-ED
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:33:36 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tcmek-0004LN-RX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:33:36 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21661be2c2dso97944305ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074813; x=1738679613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7zR+WOlWPVsc5sCsvLuqT4FX/5nFZMkjKWuY6UE8Uo=;
 b=cetn5fOCUUqCGszh7oRpSpaIewXE6FFHppFoLBj3GviFbXxtQWECS0MciPCf8reBJ2
 c6G7PFoWQFo/J+BFbHmUIRgV64JtymRG+xVRtVV9/Eoqy6QwBy4ifsrd+H285QLgKsxm
 kL+WGYxYXL6jQ4TCUr+MPimVRRjFm/hpGKaKl6L5vLMQo4qLgPfOfJoBF7xj0nQj490p
 1E5cui3tdj/T3yZ4OjAiX3ejLt1cHRkyIh3Af35s8vMGg7ko03L0kydeTnySeQ05naZh
 nqD3h9IMnDkboIvzNJJYTrbG5Ziv/Yd3qtXTd1X+Rj5u0X4uxBkUIlsgEvEspyXgK6TB
 hv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074813; x=1738679613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7zR+WOlWPVsc5sCsvLuqT4FX/5nFZMkjKWuY6UE8Uo=;
 b=fkkzUV9wzRkrnN6fyEw9QUMXCXF8k+InzpwfrNsFYX9PoQgwHiPt6ffDJbU3a/p1C2
 vkXNZVPYmItVIq2dUTjlIrKcUhf1+IDZG+HmJI0utCUwVLOWnnKm+Sn6uzJiiMVn0jnu
 LhuiTFO/M+Nc3wLzKbjns/+iAyp/kQXZVSNxRQk/WBcisD22tl/7QhM0p6A41CUDqNkZ
 d7ZWAQvAXaAm637j5wILDWmkwEobU3ic2O3U6EwGVUxOo5FpYWUDS4Pqy+3rTuryLYk/
 buf/nMsAFH9Ay+qkDXBcgj6kzWqIFMEacln0QFsXzqd7yfEItSz+r5IxdTWCBF/hlcTq
 Yt5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyoeUhQBTyrSLMwjEPZkzXREdTpZTeG3YH18iJPylku+GX9Ck0f7klJYKEGRmpyWKfEg4Nhxi1/yu7@nongnu.org
X-Gm-Message-State: AOJu0YwKUrgAUHL8udCa7W/GlDRhKjFoNiQGC2uEoVxziMq3GHmGhGxj
 D2q4xWMg3dTkVJx8wQrgAt4xUANLkP07ZsEh4s7Blobs79CdLbLvAE4qr/lcd4E=
X-Gm-Gg: ASbGncsJ0+eUa4TsmBy8GyIq3u33zRjQcv94ml9p/PEIGDB2NsknEtsfeB70v+QfSC5
 2rD7B3KcPx084P1g14m96lZxiU95bBixHRf8omyJVQHsxCMWgqb9W0UrPIXVPPHgW84OweWStE/
 BFq3ojQ2/d44Gqz4jCrS4GptBFNSBL6hdVnOJbgMoXleIc5wiz55H4hh2teKUu5Y16nTowVCkpd
 i2PGeR59dYwiiz4/enItbm63Tgl3KTF04medPN9L9iI61Si1CQefxXcJER4wd9V5bB2l3saWVe6
 fBxzZXDykd4NimyjEEYeGYfr6SA=
X-Google-Smtp-Source: AGHT+IF2l8r64sdL3KYabFnCCL2XBv2n8H/uZn0mf9S7pPIG182sktZwVbU/nE9BasKlF5+2CNH2HQ==
X-Received: by 2002:a17:903:2381:b0:21a:8dec:e596 with SMTP id
 d9443c01a7336-21c355b54e7mr765127045ad.35.1738074813118; 
 Tue, 28 Jan 2025 06:33:33 -0800 (PST)
Received: from [192.168.0.102] ([187.75.36.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424aee6sm81655205ad.215.2025.01.28.06.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 06:33:32 -0800 (PST)
Message-ID: <bd929bd7-88d7-4808-b801-26a2858ef620@linaro.org>
Date: Tue, 28 Jan 2025 11:33:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] hw/gpio/imx_gpio: Don't clear input GPIO values
 upon reset
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-22-shentey@gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250120203748.4687-22-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x633.google.com
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

Hi,

On 1/20/25 17:37, Bernhard Beschow wrote:
> Input GPIO values such as a present SD card may get notified before the GPIO
> controller itself gets reset. Claring the input values thus loses data. Assuming

                                 ^- nit: Clearing


Cheers,
Gustavo

> that input GPIO events are only fired when the state changes, the input values
> shouldn't be reset.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/gpio/imx_gpio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
> index 549a281ed7..25546221e0 100644
> --- a/hw/gpio/imx_gpio.c
> +++ b/hw/gpio/imx_gpio.c
> @@ -298,7 +298,6 @@ static void imx_gpio_reset(DeviceState *dev)
>   
>       s->dr       = 0;
>       s->gdir     = 0;
> -    s->psr      = 0;
>       s->icr      = 0;
>       s->imr      = 0;
>       s->isr      = 0;


