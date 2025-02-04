Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C6C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQZA-0003EV-3h; Tue, 04 Feb 2025 16:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQZ7-0003DW-TV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:34:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQZ6-0003Be-4g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:34:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso1274615e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738704878; x=1739309678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZd6lZm3wur9Q2MoFfzKgFC7LsjWq642M+ueUKAtHoM=;
 b=MGl+ZKwwxhRioG0PTZb5hxN5CSH7woJJY+2w9GxepawFmudQlsR1Cbd9+HUPFqRy8h
 d5/gkbv0SzI2MAQRe5l3t/pJKbNeKAFfe+VyKabJaRhmQLeD2GSTcI+UE9sezjmKJxs/
 UwcHXLgoyhWZiZCf1bPOGx68xtP4zssnNceWU1vVBA/FwTY6Rrg0PC+7rgrq3nWI/Ujl
 9WtgBB6g3Oc53hwMbhZOtW3JAZycxuj8BUKGrAgH95n7l4Ihi2CJeyr/JIGVfDLKGXUD
 CAooLOgv0OKpAGjmu1Q+7QdZRPZvAWlC/Mj/aHU1utduloQk7eX/dMHvRz0chV26+7Ms
 whxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738704878; x=1739309678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZd6lZm3wur9Q2MoFfzKgFC7LsjWq642M+ueUKAtHoM=;
 b=md/SAh3HbRitxRqaRIbL9f8BdEKd+Poi4YRRwZBsz+l6G0CTdi4N5J7fDC3yUyzntG
 acAg4fz0WA0l5yT7SVtLNwZxKanJIqsNlGbTWQWEi6XaOXtTpeNEuFiZF2bA4RpJJ6jS
 1Am9RKYcIk+JFZY6xzRpxNRCVyiHeP17QW77RSjexl/3D3S1Upp7ToYnQTSOLUejHPS3
 Qf1ink5sVReM6X6HiLIhHlpjlt2tDiuTHV32+XhBZy0jW9xbRsz2BpM3bBxOnwrcK49u
 nZQZCcUXqBISztITFIrurAxMM9RWWQGCtVzxS4lEFTIdvmd4shmHPOQ5voIbZOu6nuM2
 Drtg==
X-Gm-Message-State: AOJu0YxbkZVG7VQlo7eBagMTAmvKd912Hfm1KtFqW+KBzi+N51QtxDR+
 F32zkvCuVHhR2CotwgawQh7a6BiRqE9I87/XWjjDcYPa3Sx05Ys9Vv0jBS/b0Wy6EHJ3nwIwHFi
 7Jg0=
X-Gm-Gg: ASbGncuC0g2ay/Qh62ILXl151DMoS0oeBw4mR0SllGWHLZLLcf2uVDOIUqJkVEfaVCm
 hDryzOQwx6HoyE3+tuKvk06ToWkUfnRSs1zWVSv/vWgJfxmSMnSDplK4GYExHr5qonqRslz1ot6
 J9MMhuHsjMOkQz61QtM5G886gmJBQ0yqTyUvysEV5W7xJ6qjiD/xMtnzZ8eHLUGBsw9fLJjTHJs
 FmjOUVuLjl31b3xd5ya5JrDMezLTwT6xNP0Z4gUIjZJpN/GUtaE6gSCfyc5cny00jK+hIlYokOe
 9xPTBMy9MvT7449YF90KfHcc101lcwdtRbxM70ZnutZt9YlgzTdK5p/XOyo=
X-Google-Smtp-Source: AGHT+IFIFibL+P2/HhtnuupmP4Yq50LcDGGz9X1Pby9gO+eslPcAIWMjGAFcKJRCCWL9x7yzG23rEQ==
X-Received: by 2002:a05:600c:138b:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-4390cf5f8ebmr3133985e9.8.1738704877969; 
 Tue, 04 Feb 2025 13:34:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933789sm500875e9.4.2025.02.04.13.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:34:37 -0800 (PST)
Message-ID: <34a2d961-738b-423b-9ef1-5f4a85915e67@linaro.org>
Date: Tue, 4 Feb 2025 22:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] hw/arm/xlnx-zynqmp: Use &error_abort for
 programming errors
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20241108154317.12129-1-philmd@linaro.org>
 <20241108154317.12129-11-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108154317.12129-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

ping for trivial review?

On 8/11/24 16:43, Philippe Mathieu-Daudé wrote:
> When a property value is static (not provided by QMP or CLI),
> error shouldn't happen, otherwise it is a programming error.
> Therefore simplify and use &error_abort as this can't fail.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/xlnx-zynqmp.c | 44 ++++++++++++++------------------------------
>   1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index e735dbdf82..1770fb5402 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -689,16 +689,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>            * - SDIO Specification Version 3.0
>            * - eMMC Specification Version 4.51
>            */
> -        if (!object_property_set_uint(sdhci, "sd-spec-version", 3, errp)) {
> -            return;
> -        }
> -        if (!object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
> -                                      errp)) {
> -            return;
> -        }
> -        if (!object_property_set_uint(sdhci, "uhs", UHS_I, errp)) {
> -            return;
> -        }
> +        object_property_set_uint(sdhci, "sd-spec-version", 3, &error_abort);
> +        object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
> +                                 &error_abort);
> +        object_property_set_uint(sdhci, "uhs", UHS_I, &error_abort);
>           if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), errp)) {
>               return;
>           }
> @@ -714,10 +708,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
>           gchar *bus_name;
>   
> -        if (!object_property_set_bool(OBJECT(&s->spi[i])), "little-endian",
> -                                      true, errp)) {
> -            return;
> -        }
> +        object_property_set_bool(OBJECT(&s->spi[i]), "little-endian",
> +                                 true, &error_abort);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
>               return;
>           }
> @@ -767,14 +759,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       xlnx_zynqmp_create_unimp_mmio(s);
>   
>       for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
> -        if (!object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
> -                                      errp)) {
> -            return;
> -        }
> -        if (!object_property_set_link(OBJECT(&s->gdma[i]), "dma",
> -                                      OBJECT(system_memory), errp)) {
> -            return;
> -        }
> +        object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
> +                                 &error_abort);
> +        object_property_set_link(OBJECT(&s->gdma[i]), "dma",
> +                                 OBJECT(system_memory), &error_abort);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), errp)) {
>               return;
>           }
> @@ -815,10 +803,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi_dma), 0,
>                          qdev_get_gpio_in(DEVICE(&s->qspi_irq_orgate), 0));
>   
> -    if (!object_property_set_link(OBJECT(&s->qspi), "stream-connected-dma",
> -                                  OBJECT(&s->qspi_dma), errp)) {
> -         return;
> -    }
> +    object_property_set_link(OBJECT(&s->qspi), "stream-connected-dma",
> +                             OBJECT(&s->qspi_dma), &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), errp)) {
>           return;
>       }
> @@ -837,10 +823,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>       }
>   
>       for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
> -        if (!object_property_set_link(OBJECT(&s->usb[i].sysbus_xhci), "dma",
> -                                      OBJECT(system_memory), errp)) {
> -            return;
> -        }
> +        object_property_set_link(OBJECT(&s->usb[i].sysbus_xhci), "dma",
> +                                 OBJECT(system_memory), &error_abort);
>   
>           qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "intrs", 4);
>           qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);


