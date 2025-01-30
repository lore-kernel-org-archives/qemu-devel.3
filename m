Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43352C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdczl-0008B9-6m; Thu, 30 Jan 2025 17:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdczi-00089w-Vl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:26:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdczh-00028o-Gb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:26:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso15432655e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738275999; x=1738880799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KM/XoXqgNaQ/GxSHEqGpSfmcFkb5BDSf0xiYa4Q0Liw=;
 b=n6LIi7FCEGbGNek7Z9bot648/PG3W5vskBppe6+bRcxt2kzoyUOGdPT04g9ok1sjpa
 Sp18ucUC6B52qPDfNZgliOfwPO7JWnQ595XuDvLuX2ctfxozpZ45jyMAWEZgLXf1fzr9
 UA7Arfp/OuHuN+QutrLEfqcAG92BQ1X4b+RfGscwa0DvVAi8PWT+EVkVZALwo9fmbhUu
 F8T4xosy+2zD2Z2picW+szvD4C4pjNtJ0X8H0ng7mwm8qzzbT1ZtVnEj49wDf6nfbAQo
 CWFzu2ZVk+sLNHXiDf7p7KEH4TAU2y4UPqlZP2L40gkMBEuAkDZElh51SboYKkh1b1nV
 ndXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275999; x=1738880799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KM/XoXqgNaQ/GxSHEqGpSfmcFkb5BDSf0xiYa4Q0Liw=;
 b=CzJFlqUpfFj3DgdovRvJVvsl3lBOfy9XT2V/TVZPLJZJzGbcGmKYXapMt6LLnHgkoC
 LpmxJuESaJpKevns9LSdE12ZHi+GhPKPWEahFdv2B6jU7/Ulb4z8qi7ePMZALZmM3Aja
 LHlHlT94bMujbn48JyU5k9nCWqMEglJfx16m6P/GqYSysv0wCXGGoUBReHS6Mm3V4Lvv
 Gar1jzzlRV7bPxETmtKkYDAha39xpx8okTyqo7S3QXv0ZvYvw6kNUWCbEaR2OOYloqPg
 q4WKgbfD7GHs7e+Sap2YlfACMv9YVEgHwADj/Y/3RaT00StPw0dfmDzZwSoXvTfMjoGn
 Q88w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3eM9D247qRxkQU0IgUi9vCEnYWegrnMhq4uUcYyQZg0p3tes4nwgqFpOlrN0TwnsuXMf734p3pwIf@nongnu.org
X-Gm-Message-State: AOJu0YyIr2buMWGD1atpwxvxhrHr/XiN6rifXINdMETr+JBtJA+YtK81
 UX5WjaCUhR5sWlxfn/nziNrw2muyiIe1spRtN4OkHSi8UwBLDekVgqiT0Z+ZcG0=
X-Gm-Gg: ASbGnctz75qJ/mU+JMY6Dh2rAvNNUTyw8SNpaW0Sn7+Xpt49JYJE5s7y9i9T/LgKrYn
 ZR55d6DsK/pTGcnAyobHwGfB+3WhKWuh1ldJFyxkLtRD1BoSA2ykx9ubj8LtvylWpArLbbvmzcO
 4E1Yxy3XJ3i8rTEO6GdW93qGBaBxv+a1t0V4epfjw6W/2nqOvpErtjFXFWOJstLk2FBENQ63/NO
 6wcxf0jkwLx4SrCMoZbL4qYgMmiFQ19sDzYpZjqF0N77w5IuQQ8PPQfeLCXVrAa4U6TZOiyAVNK
 g7NVGwkbeL5OIrKuwbvq0IpMKOQ1jbQ790kyhmhJ3sx89uCpghbl0rG3a5Q=
X-Google-Smtp-Source: AGHT+IGUmp4EYSeWdnli/UbzoJ+vJDgIRi/kY+sOi1OXCQ3rr1TwdpRU2DAK3K/Pg1SqrNjfhWehow==
X-Received: by 2002:a7b:c356:0:b0:434:f218:e1a8 with SMTP id
 5b1f17b1804b1-438dd1a5b55mr65885935e9.19.1738275999498; 
 Thu, 30 Jan 2025 14:26:39 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b5780sm3141965f8f.67.2025.01.30.14.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:26:38 -0800 (PST)
Message-ID: <25be2867-6736-442f-989f-2ce1f2745c05@linaro.org>
Date: Thu, 30 Jan 2025 23:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] hw/sd/omap_mmc: Convert to SDBus API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> Convert the OMAP MMC controller to the new SDBus API:
>   * the controller creates an SDBus bus
>   * instead of sd_foo functions on the SDState object, call
>     sdbus_foo functions on the SDBus
>   * the board code creates a proper TYPE_SD_CARD object and attaches
>     it to the controller's SDBus, instead of the controller creating
>     a card directly via sd_init() that never gets attached to any bus
>   * because the SD card object is on a bus, it gets reset automatically
>     by the "traverse the qbus tree resetting things" code, and we don't
>     need to manually reset the card from the controller reset function
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  1 -
>   hw/arm/omap1.c        | 10 +++++++++-
>   hw/sd/omap_mmc.c      | 30 ++++++++++--------------------
>   3 files changed, 19 insertions(+), 22 deletions(-)


> @@ -643,6 +630,9 @@ static void omap_mmc_initfn(Object *obj)
>   
>   static void omap_mmc_realize(DeviceState *dev, Error **errp)
>   {
> +    OMAPMMCState *s = OMAP_MMC(dev);
> +
> +    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, dev, "sd-bus");

Why you don't create the bus in omap_mmc_initfn()?

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }



