Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D0AC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUgA-00014r-5A; Mon, 24 Feb 2025 04:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUg8-00014b-IK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:23:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUg6-0004tt-L2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:23:08 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso3147435f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740388983; x=1740993783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c4ZTrmiAhDrXLavwnaQ6EMxIiojxWAekdFXvzUygYnQ=;
 b=vZT8obt44wu7hy8CmA0SNTaR7cggfMoLJScR9skpmhJXr2ZJfuBhE9DLiH6ocOvwlM
 3gMmT1VNfDpdScCLwhnZp3lkJkPgaWpB2Dklt32ctkVIp4lyaCrHVO7q5BBleSzc4/U9
 MGj7tA2d/yZbtTqEqxOqIXXJjk4NZImI1CHlJJ7KgnI5XyhkEakX96u98vvzaYJUxXLD
 vQr2OCgKeNxmzbZpneaYbkJD3qMftvRczdZQ4Spal+DyI5hWnHrhU/c8DuRjudEqEJ99
 wWjmGdilA2vRkOJY09luxdEKsHLBwY0Y6cbNNwvL9SwVaVJ95hUZTm5rNr5gyKWXDUjc
 6Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740388983; x=1740993783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4ZTrmiAhDrXLavwnaQ6EMxIiojxWAekdFXvzUygYnQ=;
 b=XiX/b50w5+3fJChCF9QNW1KaeFfFiY34BcXTVktouum6Hu/km3L3Gs0DzP2FTyzp6d
 K4y6nBuy/GMmqOGauMA/aPvnfaxVr2ggMryDcROzDmxdFyfbFU24aImAZfpg7BW4x4kl
 kC94wVJ7WxVpjYSDD63+5Q3vPMJGu4BL7UPhydscYzpIwhtrOwUNqLofKFvru5gHYNpI
 EJPbAUclGg5bvM+QOf94Amp1sRrmV2WZ+wr6aLcizQZW+bSeOLqYmVh7ZPxhC57H8S12
 kyMcsUZOyeys0+tP53X/XsQW7/3N5oC86f6jlrvWkEcxATee9FQZ/TFn6V9bKDBRQr3N
 08uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgVa/RPCqldVAHdMJMrur1VNc2WOTjN9yiq/2Dq2exsyRKqzGJMZQBG+VnxBE9nIe/KIbbB/dKUT3w@nongnu.org
X-Gm-Message-State: AOJu0YzrQ59J9jsRpGJ6+UmN1BHEZmKQ0BbuuHrdUH+LsLS6pAT6DgRS
 +P8CcMxGDb50VRLvyBAX+XTNgpG3czExwaA79UdeVV9IbFxuYf8npVSDLvrfxMc=
X-Gm-Gg: ASbGncu7T86gD2vOeAPUoD+as33O9+v5C4I07MLBCn6W7/jh+NwCwX81xJhDw8R/MLo
 jZKZ8ofI0pvCW4XeX6uk8njv1yM3AkZjsq8exO/e682VgHnWhBDQz6EpGc4Wo4Zeumu5PetOqNb
 hYPsTwBl7sLMpFMsZegrPmos27eChhRZbfX0EBqCwMaO14CQYswCC3rrtaKHzvRqxk03qgoALGW
 GBO1YfGX9CElHD6z5PX8W4TUTiMKvpaQJmg2tVKm0E/2jzojTGL/5ainZnV+XitHNxP7xtNNxPH
 ghRwsB4T3sSwFgetFSDSVmJyWMMa4Zu0uCGcUEFfFNYV9t+XczKZ0tUE8Yk7xEJ3zSZQuA==
X-Google-Smtp-Source: AGHT+IFAwRpZBf4pw/ZPEKUOGANpwsfDTvyG2F/BsSzYbsxroGWSFBkMkijvF9ULxnr5OBfkU11Y0A==
X-Received: by 2002:a5d:584b:0:b0:38f:2176:45a0 with SMTP id
 ffacd0b85a97d-38f707b0957mr11184231f8f.33.1740388983551; 
 Mon, 24 Feb 2025 01:23:03 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8f1csm31502063f8f.69.2025.02.24.01.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:23:03 -0800 (PST)
Message-ID: <6b2f8e99-d7f3-4f37-97a2-e9260a11a34b@linaro.org>
Date: Mon, 24 Feb 2025 10:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/macio/gpio.c: Add defines for register bits
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250223001445.D21104E603E@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250223001445.D21104E603E@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 23/2/25 01:14, BALATON Zoltan wrote:
> Add named constants for register bit values that should make it easier
> to understand what these mean.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/misc/macio/gpio.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
> index 4364afc84a..06be5a4f98 100644
> --- a/hw/misc/macio/gpio.c
> +++ b/hw/misc/macio/gpio.c
> @@ -34,6 +34,9 @@
>   #include "qemu/module.h"
>   #include "trace.h"
>   

Maybe use an enum and add a comment /* Register ... bits */, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#define OUT_DATA   1
> +#define IN_DATA    2
> +#define OUT_ENABLE 4
>   
>   void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
>   {
> @@ -41,14 +44,14 @@ void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
>   
>       trace_macio_set_gpio(gpio, state);
>   
> -    if (s->gpio_regs[gpio] & 4) {
> +    if (s->gpio_regs[gpio] & OUT_ENABLE) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "GPIO: Setting GPIO %d while it's an output\n", gpio);
>       }

