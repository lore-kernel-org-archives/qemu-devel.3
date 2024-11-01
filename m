Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FACE6F07E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wId-00078C-PO; Fri, 01 Nov 2024 14:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wIc-00077d-Lh
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wIb-0005gD-5w
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:23:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so2573621b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730485384; x=1731090184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPexEx7VjbR4dJzx44VVL0It5cgb6HEvb4iS6PGJ2iM=;
 b=DBf1fy8KUt8Ct8UhhFPaWF6GVN1JBiGDyQZcyDLLeLoOCcA6oPYZEjBZ4zg+HMzDdK
 aPXiMHFyHtvScTtgfoI+iDzbil/lsxi8npFB1pbHKwjJBrEw+nSPCjwyHfLKeYd/Tu8F
 SErXPClp5L24dZLtc5i/QY4ByTT3fqNy8750lPNqCqR8y2x64rHlUA9EBkjVw9w4nyQy
 kcT/7JouUKVN/BnKNiIWrMMv11f92Z662kMIiMG3ntKdtbWPeKXjdmYIegg7xAQgp2za
 gbczfz8+ffVVR5vBH7U1+fYd3shNM12gzYYcYksi2kcajGzsSJtBBD3LFnhEjsfQNpt3
 i/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730485384; x=1731090184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPexEx7VjbR4dJzx44VVL0It5cgb6HEvb4iS6PGJ2iM=;
 b=sxLwg7NFeXAU1wM1DvIedTzuqQpo9NyvGuijRmsrCyGA6tl1BPkWGZ4VatmsJm3T7h
 4qWUq+Y/epdZubfMA54am23BBTh9/Fryi6jaYei8mixR6FDPuOfwyzmuQbn9P5IUwd8w
 OTa96sbd/du0nNCyEntwPQkj0iEDH3ZfruOzwOteBBWWPfO+3LGPuB8qsvKwqxPsdqCd
 K6izJtf+zVPhoSJsiJmaRcYrI0dUHKBIZXDb3xBEMTMKKjD2UMtXWo4cGxvbipJcZM3c
 UA/0qgGsAe2H5IYN2Wm1iMmhHbrkeNugA+C+QQbAT7o/ci0mJb2TVFmvW42tnDtbdlKj
 PjRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz1ND+FYi/mPVzOdoJS65C1sCFR0ndDVcLU2bLRnKzWUy1UeR21f8ADzBeZT+VFCJNn9Q7aQ3BAGJV@nongnu.org
X-Gm-Message-State: AOJu0YwvCnAXiGBvGHHmSK5FjZS26gbB78EW1nTSgIhvOWd7RpMAhAjR
 97Ub00ps77W0Pbcxu9vc2f9Y5Ms4ozh8Njaid5gO74n/rLcIKRVOivDRSLF4Ig8=
X-Google-Smtp-Source: AGHT+IEP34gAsmMa+1SI4jHYGNPKj4XFxlIxlq78dHW6OIRVk6U9ih4DV5Gfgui2CCOaUkTR9q1d7Q==
X-Received: by 2002:a05:6a20:3d89:b0:1d8:a322:6e with SMTP id
 adf61e73a8af0-1dba420516fmr7011861637.19.1730485383621; 
 Fri, 01 Nov 2024 11:23:03 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee44bf470dsm2800803a12.0.2024.11.01.11.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 11:23:03 -0700 (PDT)
Message-ID: <73bdeaf1-d000-4686-b76a-81c2bc7af123@linaro.org>
Date: Fri, 1 Nov 2024 11:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241101161125.1901394-1-peter.maydell@linaro.org>
 <20241101161125.1901394-3-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241101161125.1901394-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/1/24 09:11, Peter Maydell wrote:
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
>   
>           const int timer_irq[] = {
>               [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

