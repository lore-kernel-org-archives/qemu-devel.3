Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E3CAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aTF-0008F9-KK; Wed, 24 Sep 2025 21:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aT9-0008D2-9z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:08:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aT1-0007yB-4U
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:08:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso257597f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758762489; x=1759367289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ztfqaZ/MsUvC6elF0FGoons+FyLCZ369wcyPFzyv+U=;
 b=Z6tNjRBA5yJBF5TuF9gNHEcfAD0AS0BfHhhLlcYvac+aRQ/EwjPGo3AHeB0o+yIg2K
 +TEgRL0VjMfco3SlnaHNs2bU5FyQIybh2rmwNvY7B0cUNQja6USD+S6ngSj6laTH5CXR
 sRvOtFa2jRIzRH07iO2TlHtQw2cBBDnnOiHazALn7a513YvYiRXWO4pUYHQbwwAiD4q4
 /mMTJ/cCc4bf7+v3TxBIzP3RKuzTPpoS8U4nLQMnvP+EP0eJ9YlM06duu4qThzLZfQ7/
 tkzS9E38hUSb3spItIuH+oK7jw4Bil5z2nfRS+mjl36yyJCkVunPJPu5PuYoHJYRKcr9
 GV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762489; x=1759367289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ztfqaZ/MsUvC6elF0FGoons+FyLCZ369wcyPFzyv+U=;
 b=u30PVCpRuBg2gdOPeCYfsVsU0PsSEkIyJgJi9u7K/DY66lLvW39j+S9e8VCKD1Pn67
 cSMLzs7k6lQICUNfZeNNx+8+8szanJWbwexSd5RaR4DL4W9Zmdm9wQXrmjoQRXqbxg9X
 UKwbcHKJ7Bod6S9PVJKuVcRO0fQbPNysIrMvrEnqE3q8v1GH3A8DQEiZ6UKEBuAlCWAN
 lJtCv/zOAF9k6XfwDVXHYwqzKTV0qSoIH1IgUn8qkauw+Afs+Mu7ynYrNewwlJ8qjkhC
 K4GmaILyCC+6DVx05usNoLF70bAaxtyqPO18o/791quGGflMu2T9wSDaZowPdAY+UFcR
 DNQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0dTO1mAIQnZy+xzZITxWpQtwojwQjFtU6JiBDLrMw9AK/VkK4pnl0VjHI0wrbWCtWORA+hqUeNoQ5@nongnu.org
X-Gm-Message-State: AOJu0YwHRRU3/aQwQv+c4SfGs4pGFF723o1vCM5lurWfyeSR/IgtcUtB
 h+dCm336/Gyf8JatAuRf9dE+o56wfAkwVOdMk/GqON0bpwh/uauecuLAY6RVLxjSypU=
X-Gm-Gg: ASbGncsE7zbVOf+wTFlM/tZpPfl07ywAUJ+9QP51t4oQwdERIiZIAC/7hH4yNwHVv92
 x6oFDNYbo6Dg1Lprqpb8f269N3FkWYbIib6XtyXA1OIFPT8Tmgx/gU/IqG+0aEMj3gRoVO9Mg9Z
 PoP8Na6OdF2DOFKDSQBusL1idP7RshtAjodQKlSvB+mlWvZq6HrggQ51bQW3sIoQcnAjeEztWZs
 XB3wNXT7j2/6D9WHbEuM1PxV5WNiPIDp0CB3t4bXKFgy7/BdbwowGRe2iojyJiubAZ39Aq+pxSi
 mvbosmtPSAQ/khJglqXU1yixLzg4VVpFoiARO9Z9q3LTJt7Y18kvy0Q4BkBDQBHY5jcWM5PcT27
 JuxMGrWdNUaS+0N3tqHoEeXsQTbUNu8C6SwjW09I8yik8yMeNvSJRizGUD4k+HzeSGsBsvW3Qs/
 x4
X-Google-Smtp-Source: AGHT+IHlwV51wTAwA22Lh+pJh50xhgWZ811f5rNcVPrtga8FRlU2tAUxVT10lLcO6xjYMPET1d9ZfQ==
X-Received: by 2002:a05:6000:2f87:b0:3fe:4fa2:8cdc with SMTP id
 ffacd0b85a97d-40e4dabf3f7mr1592751f8f.60.1758762489115; 
 Wed, 24 Sep 2025 18:08:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89065b5sm673673f8f.17.2025.09.24.18.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 18:08:08 -0700 (PDT)
Message-ID: <1a755fbf-e6d6-4f80-b35d-29fcb3f587d3@linaro.org>
Date: Thu, 25 Sep 2025 03:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, flwu@google.com,
 andrew@codeconstruct.com.au, Hao Wu <wuhaotsh@google.com>
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-4-lixiaoyan@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925005832.3708492-4-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On 25/9/25 02:58, Coco Li wrote:
> In the process of implementing serial gpio and adding the corresponding
> ENUMs, also complete the list for npcm8xx.
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/arm/npcm8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
> index a276fea698..10887d07fa 100644
> --- a/hw/arm/npcm8xx.c
> +++ b/hw/arm/npcm8xx.c
> @@ -92,8 +92,14 @@ enum NPCM8xxInterrupt {
>       NPCM8XX_GMAC2_IRQ,
>       NPCM8XX_GMAC3_IRQ,
>       NPCM8XX_GMAC4_IRQ,
> -    NPCM8XX_MMC_IRQ             = 26,
> +    NPCM8XX_ESPI_IRQ,
> +    NPCM8XX_SIOX0_IRQ,
> +    NPCM8XX_SIOX1_IRQ,
> +    NPCM8XX_MC_IRQ              = 25,
> +    NPCM8XX_MMC_IRQ,
>       NPCM8XX_PSPI_IRQ            = 28,
> +    NPCM8XX_VDMA_IRQ,
> +    NPCM8XX_MCTP_IRQ,
>       NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
>       NPCM8XX_TIMER1_IRQ,
>       NPCM8XX_TIMER2_IRQ,
> @@ -116,6 +122,14 @@ enum NPCM8xxInterrupt {
>       NPCM8XX_OHCI1_IRQ,
>       NPCM8XX_EHCI2_IRQ,
>       NPCM8XX_OHCI2_IRQ,
> +    NPCM8XX_SPI1_IRQ            = 82,
> +    NPCM8XX_RNG_IRQ             = 84,
> +    NPCM8XX_SPI0_IRQ            = 85,
> +    NPCM8XX_SPI3_IRQ            = 87,
> +    NPCM8XX_GDMA0_IRQ           = 88,
> +    NPCM8XX_GDMA1_IRQ,
> +    NPCM8XX_GDMA2_IRQ,
> +    NPCM8XX_OTP_IRQ             = 92,
>       NPCM8XX_PWM0_IRQ            = 93,   /* PWM module 0 */
>       NPCM8XX_PWM1_IRQ,                   /* PWM module 1 */
>       NPCM8XX_MFT0_IRQ            = 96,   /* MFT module 0 */
> @@ -128,6 +142,11 @@ enum NPCM8xxInterrupt {
>       NPCM8XX_MFT7_IRQ,                   /* MFT module 7 */
>       NPCM8XX_PCI_MBOX1_IRQ       = 105,
>       NPCM8XX_PCI_MBOX2_IRQ,
> +    NPCM8XX_GPIO231_IRQ         = 108,
> +    NPCM8XX_GPIO233_IRQ,
> +    NPCM8XX_GPIO234_IRQ,
> +    NPCM8XX_GPIO93_IRQ,
> +    NPCM8XX_GPIO94_IRQ,
>       NPCM8XX_GPIO0_IRQ           = 116,
>       NPCM8XX_GPIO1_IRQ,
>       NPCM8XX_GPIO2_IRQ,
> @@ -163,6 +182,12 @@ enum NPCM8xxInterrupt {
>       NPCM8XX_SMBUS24_IRQ,
>       NPCM8XX_SMBUS25_IRQ,
>       NPCM8XX_SMBUS26_IRQ,
> +    NPCM8XX_FLM0_IRQ            = 160,
> +    NPCM8XX_FLM1_IRQ,
> +    NPCM8XX_FLM2_IRQ,
> +    NPCM8XX_FLM3_IRQ,

Minor style comment, maybe worth adding a new line when the
following enum is not contiguous.

Regards,

Phil.

> +    NPCM8XX_JMT1_IRQ            = 188,
> +    NPCM8XX_JMT2_IRQ,
>       NPCM8XX_UART0_IRQ           = 192,
>       NPCM8XX_UART1_IRQ,
>       NPCM8XX_UART2_IRQ,
> @@ -170,6 +195,22 @@ enum NPCM8xxInterrupt {
>       NPCM8XX_UART4_IRQ,
>       NPCM8XX_UART5_IRQ,
>       NPCM8XX_UART6_IRQ,
> +    NPCM8XX_I3C0_IRQ            = 224,
> +    NPCM8XX_I3C1_IRQ,
> +    NPCM8XX_I3C2_IRQ,
> +    NPCM8XX_I3C3_IRQ,
> +    NPCM8XX_I3C4_IRQ,
> +    NPCM8XX_I3C5_IRQ,
> +    NPCM8XX_A35INTERR_IRQ       = 240,
> +    NPCM8XX_A35EXTERR_IRQ,
> +    NPCM8XX_PMU0_IRQ,
> +    NPCM8XX_PMU1_IRQ,
> +    NPCM8XX_PMU2_IRQ,
> +    NPCM8XX_PMU3_IRQ,
> +    NPCM8XX_CTI0_IRQ,
> +    NPCM8XX_CTI1_IRQ,
> +    NPCM8XX_CTI2_IRQ,
> +    NPCM8XX_CTI3_IRQ,
>   };
>   
>   /* Total number of GIC interrupts, including internal Cortex-A35 interrupts. */


