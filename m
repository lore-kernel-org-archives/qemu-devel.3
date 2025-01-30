Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73884C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 15:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdW49-0007PB-Nv; Thu, 30 Jan 2025 10:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdW48-0007Ol-96
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 10:02:48 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdW46-0005Xm-Hn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 10:02:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so6876795e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738249364; x=1738854164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Sx31kzS7KIGm5Y5yXe9pPHKOur2vJlTHveOeD6YllA=;
 b=q972mj7olsDBBsNUFaVwQ0gutGJE36PpPDxFUV1lM9rZAJ1Z00IHtp+QN305uIKmf9
 096domcFzrQexPcWPzNRkWb52yrASzJbKBTlu9ef1GfFEV26GySbp0hm9UbecZIX99lv
 FQpaHWvmHAjHUunYHV0AQI6jHlILP3NXXom6+CT+DOag8Qs3PV7lVdOgQADFeChZe0RP
 RvkJErd3+oKKI4bkqn3/yO3mnlrQXjy38c6Yz6vEYZBo3infGOkjXkubA3scueTmjkc2
 W2nr4ki6Db32/2CiqP9frKFP+FzsFOvRmD+fFzyQk0+gcidRx9zNj9nSxO0rlhfys6qf
 nTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738249364; x=1738854164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Sx31kzS7KIGm5Y5yXe9pPHKOur2vJlTHveOeD6YllA=;
 b=jJT8G8qCk0cRf8qinhdC4+foog02TeNUije5qgndiaTuArdVwpx8kO+xKAISJyWLw4
 vkvQ/cuAbFmpsrpVME7G4l+nSGfrfuUiPAPaw5ocFRuDKpVDuJGgGFHCo9xjCYBW5L/z
 k2kvwehgovavKx7xLTt0jFK+ouRmgiUFkElIyQQ3TJrHg7JEJj8QQbrFmrdJJxzHXuCQ
 FIGm7+8qxGPZYORbM2p0j9RfXvQb/SFfV+0z5NEMTztwoM4wFJQvB6wKtCvqwdu8CKcd
 MVFc7OfT0kezs23nt8kYSfCz1yXQY/v9aifpnhIu8ZuOT/CiFAGPgMmXPHNi9+JdG8ka
 051Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCTDqeouVTrUuI52GAIpybBPNZ7XldMtkUIf0zEsTpHnCDCdts+Yxh22NbO/TN7K3r55y7ACKnrtvG@nongnu.org
X-Gm-Message-State: AOJu0YyUIaUWMEPj1BFAdiorB42zt9XAsBLfvzsF+7TKl8EE+KraVtYv
 gocqNACwOHpDwVq05hT1VNhWu2wVjmgi++2FAuHygJwIJqT8Sl8H+u0ZW0Pf1wU=
X-Gm-Gg: ASbGncu6WO5frbAv500PrNJy0VMHviJZAnoY5/2DxTmptX3NDYL2TFEnecFH6wBh9Fv
 gPa3w8RK6DDVd+Ptwkdvb99kx2HJdoUSSpLdcSlc7cBe9hQJPfkx1jh442naV5gJQ9QATCeck84
 grD4rLx0yjIyQ/4z0edh+nZVhfMaEZVtteePexlZOwVmLif0E7JPeDbY9m8tQTKPtAlCjGCaXkD
 TrVRFH1buNbAyFO01yoOFUyjBD0OLqfSCW0lSfAauYcr2xZbGMw3hRy5Wfl4KqJvFwCVMvVIqPx
 o8M41dlRKc6463cikuCU0inFIs7AYnSVK9ADGS5KoRFvRmz5nsbYN0TzDb8=
X-Google-Smtp-Source: AGHT+IFM+QZCtMpOLCNOPEnxbCfm9Rgs0JZiY19IPtP48b/hbJaj2fdAoTxO7MP5PvcqxTmUignyyQ==
X-Received: by 2002:a05:600c:a089:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-438dc3bac30mr85894195e9.11.1738249364203; 
 Thu, 30 Jan 2025 07:02:44 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e236f9bfsm27129865e9.0.2025.01.30.07.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 07:02:43 -0800 (PST)
Message-ID: <74cefc5b-a9d0-41e2-b654-985ba225e6ec@linaro.org>
Date: Thu, 30 Jan 2025 16:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101161125.1901394-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/11/24 17:11, Peter Maydell wrote:
> When calculating the index into the GIC's GPIO array for per-CPU
> interrupts, we have to start with the number of SPIs.  The code
> currently hard-codes this to 'NUM_IRQS = 256'.  However the number of
> SPIs is set separately and implicitly by the value of
> AST2700_MAX_IRQ, which is the number of SPIs plus 32 (since it is
> what we set the GIC num-irq property to).
> 
> Define AST2700_MAX_IRQ as the total number of SPIs; this brings
> AST2700 into line with AST2600, which defines AST2600_MAX_IRQ as the
> number of SPIs not including the 32 internal interrupts.  We can then
> use AST2700_MAX_IRQ instead of the hardcoded 256.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_ast27x0.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 5638a7a5781..7b246440952 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -66,7 +66,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_GPIO]      =  0x14C0B000,
>   };
>   
> -#define AST2700_MAX_IRQ 288
> +#define AST2700_MAX_IRQ 256
>   
>   /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
>   static const int aspeed_soc_ast2700_irqmap[] = {
> @@ -403,7 +403,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>       gicdev = DEVICE(&a->gic);
>       qdev_prop_set_uint32(gicdev, "revision", 3);
>       qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
> -    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ);
> +    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ + GIC_INTERNAL);

Pre-existing, GIC has AST2700_MAX_IRQ + GIC_INTERNAL IRQs, ...

>   
>       redist_region_count = qlist_new();
>       qlist_append_int(redist_region_count, sc->num_cpus);
> @@ -417,8 +417,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>   
>       for (i = 0; i < sc->num_cpus; i++) {
>           DeviceState *cpudev = DEVICE(&a->cpu[i]);
> -        int NUM_IRQS = 256;
> -        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
> +        int intidbase = AST2700_MAX_IRQ + i * GIC_INTERNAL;

... then our base IRQ starts at AST2700_MAX_IRQ + i * GIC_INTERNAL,
having i = [0..3]. Jamin, is that correct?

>   
>           const int timer_irq[] = {
>               [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,


