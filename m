Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5418BFCD0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kgc-00017L-Sv; Wed, 18 Mar 2026 02:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2kga-00016z-LH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:47:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2kgW-0007rs-J7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:47:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so54056585e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773816434; x=1774421234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQdDFSElZ+wmeLkOTAGHbjZXrDNiBnhyDg6GlfJfuNE=;
 b=wC3vSP2GscsQP7XpYpGyqYA+t/m1gDEFrS5I8AZ1gyr+uAiHY0KVqetU6/Iby0ElB8
 rds9AdAlFGIf8kzdM8Pnip8AfsgXRAoDrUU2LyUB5kq2JOkVy6plHBqwVU4p0wqMtlbd
 vNSIeKrVXKw1Id0++h5yVwp3zn0VSXBBiLM9etaR84Tcdpox6gcL6uZ/XKdttik907Qo
 KzPJXucBaJsEFv1bcE0i105ICqlN9ZhdV1JBqx1zNQuk1AM7FrkKNi5x5HdhIZvYMEwV
 +jkmTMzSsIFKvU/9qiV0wfK8Y+D+oN54sucPHyCy3F9ZLLv2oSR+cNU0F91CL+5n0Qe3
 ORrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816434; x=1774421234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQdDFSElZ+wmeLkOTAGHbjZXrDNiBnhyDg6GlfJfuNE=;
 b=b43C7ebc/xm2YW/jDtF5Ttr0bGcrmjaAGJAfTWCOS6aSVyGelyu2gF3683bB/qgL2Z
 0yiwlY57vce8kPSdShvTiSF3G7C3zogDGmIYRCyymFQ7KUY0UpX5lU4lvumRxgbV7YrE
 l8nAl/FPV6diPAj8OKl+NLO6FxrORaRwnk/TBt09zMunoayZ8vLfG5aK2JqHfwPZ4dpL
 mNTTvFXtd77mIAo32I8PSxzPiBNAOFc0ddO+vItfKedn65Rct9NxDWQ2jBat8bfYhsBR
 O2p3GcGMs7LeF1IaesPD4gEr4BsDq7PvB6C70roDw22NAre0r9a1HXFgvP77rQaROXXI
 d4fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCRs+p52H33EbwUsArYKnItbK8jL638wfvBXdB983zymdRKtu7DX0f66elIkmFwX9TuVknJTn49pBt@nongnu.org
X-Gm-Message-State: AOJu0Yw+lylw+NeQ6lYT7zG5I+m1P1GmaTCOAVuHSNeZzP/AAdp8tWLZ
 FEBMmnxoB0B66Jh3xvfy8vwjsLNbsUEsQjaoFVNmZbTsIGNxNMm7L2/0l76XueRSMnE=
X-Gm-Gg: ATEYQzyeFpP1PdpY2u2q3OFxp5wnkp3m1XWy08q1J35Ctrs1PVGH/nwxvhwMKDAvYAC
 XcP84Pr7nLYvTNlKwl1MKHf05SRJUcVGu1073rWoBErN0iARBaJVGkSzuSlkRyGh1Yv7W7dRvRG
 LMW5urUkcByGVahORWXj1gHCQ/px1aRzG3pg16wdVtA0f5bQZUujEx8CYJ96SA+wJ71mGbAUl1P
 vgiWqzjDeSUNiNaMqeRr8gVF4cPjjI8qBVslBnGIL8CBqL/KbZFq2cnXTYugJ9LPDH2jEv5tyXR
 ecOsBPlUinqqWW/ZjyAII0x9UkCJMvyAyhfyvJ+/sYsg5qKz5fgqbLBYaRsszI7VkhoWKwtw8/M
 IV8QbnAE54jdUd94SDW6nct8HEs/mp9vLLyrYlV4njz8GdBhUv3sDWkBU9uR7cTj32Gfw+IWUsW
 WrNAd0kWYD4qLq3Iuj0mTHjq5QRZRLlz3aUdDknUz+ECNpWYSHQ3B8K1Au9zhGIwZ11TGhNGpW+
 ldi
X-Received: by 2002:a05:600c:810c:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486f4475342mr35347295e9.20.1773816433637; 
 Tue, 17 Mar 2026 23:47:13 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm42472495e9.3.2026.03.17.23.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 23:47:12 -0700 (PDT)
Message-ID: <767522fd-f8bf-45ae-9245-91e18c9c91ad@linaro.org>
Date: Wed, 18 Mar 2026 07:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/pci-host/astro: Use proper region names
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260317195149.8386-1-deller@kernel.org>
 <20260317195149.8386-5-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317195149.8386-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 20:51, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> All 64-bit hppa machines have at least 4 Elroy PCI busses in the system.
> Make sure to use proper names in the qemu device tree, e.g. "elroy0" or
> "elroy2-pci-mmio", to be able to distinguish between the various chips.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/pci-host/astro.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> index 626aa9ce22..2c97d400bf 100644
> --- a/hw/pci-host/astro.c
> +++ b/hw/pci-host/astro.c
> @@ -433,7 +433,7 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
>   
>       /* Elroy config access from CPU.  */
>       memory_region_init_io(&s->this_mem, obj, &elroy_chip_ops,
> -                          s, "elroy", 0x2000);
> +                          s, dev->id, 0x2000);
>   
>       /* Elroy PCI config. */
>       memory_region_init_io(&phb->conf_mem, obj,
> @@ -448,7 +448,9 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
>                                   &phb->data_mem);
>   
>       /* Elroy PCI bus memory.  */
> -    memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
> +    g_autofree char *elroy_mmio_name;

Please move to function prologue:

     g_autofree char *elroy_mmio_name = NULL;

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    elroy_mmio_name = g_strdup_printf("%s-pci-mmio", dev->id);
> +    memory_region_init(&s->pci_mmio, obj, elroy_mmio_name, UINT64_MAX);
>       memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
>                               "pci-isa-mmio",
>                               ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);


