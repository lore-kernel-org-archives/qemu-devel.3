Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ATB-0005OO-KT; Mon, 29 Sep 2025 05:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ATA-0005OF-Dg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:46:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3AT3-0006x6-NA
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:46:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so22631795e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759139203; x=1759744003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+V//qnbZFZJ90/YB6cboR6+ZHQ+fvTELXb3dtjAa1tM=;
 b=uK6/UnoowYSacorBF3nPcl67PGyJQxxvbX+lTDXJALqZwaAJUVfhyEyrZoQivaVwH0
 lJeF0KKyWuRHN05GmyNfhhLlqIOJSaQ01R17gIMB+yu7GGswSbRQJa7oqeFVGOa63LWr
 9/DrtFkJSGd9DyVXj+lsxPaqt0WRn2QEgIxT+FsDme7Q/m3kuTBmqFcTPKvYjOUZXuDz
 872CL2Z5P0k3/MMeBfs7j8y8zyt64ECXJ+bno9BysYk8icj0q6SnVWQkX6RIGeaUWrFN
 S0+zqbQPuZZHJ74ZT8f1wfgpxR8SBQNfzPnOJq8QK8hfDYhcGEBM/DHrhMrgBobr6gI8
 LpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759139203; x=1759744003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+V//qnbZFZJ90/YB6cboR6+ZHQ+fvTELXb3dtjAa1tM=;
 b=uRbZ3oPhK7KaoEHr0IM5xNJCJwOji4glMl6916RLQRNacq3+7TgL8WPNzhVx4GIIiJ
 V56a8Jp0Qx8VTNljNGo0K5GjjwR5UZ5USQVF2fuG2KBRjSG9xy04ovClSeycy4NNS05D
 tmDasgfJdYOElwobG3ZM0+GBS7M+sD4TqwrK55H36GCDZ2OVKBM42CxNq92FOjAyUDtj
 +ZUr66PRYa+2pWnmEtKiNlm/v9ebNlC0L0sLH4iuqF/Pk498fD/kn1Wxk6wdJZWIifAD
 8IPowrj9hyiXsvDFARcMG2nU+L/442TNxv35Ir5ABsLuXJglFM09f6t7gWxWOy8UCcoF
 5O/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC3iukUlkP4OPh/51cDEp8bWl1EueBT4RHZheLwnHHWlR2o17ByAscLq0wdsYj9QTWQqhA8Dw/4h8h@nongnu.org
X-Gm-Message-State: AOJu0Yw70xiIKOm66WGITjlH3yBE4eIWMOe/SSFBz6rvnWfGZs+lhZ8N
 4jwB7cUMALoeIp0nLGIvXeYS6CnRGef7n6ndSmGtnGGXIA1igDkP9NMnTBAfYCSDmrk=
X-Gm-Gg: ASbGncs8rOh0utFL2WxvKW4MFsskYvVTJUburaU9oZMdSUmt4QELiRegLRzSLx0VKzA
 zx9NRRYFzplBUG2I+dNTSD/vrCBZLHvRxVGlcMtlRFYojxTtbUWE9awGx36JB/DSdXsI06DHgJl
 Ub8lW1Gspr6Bax1tDcxPLFO0V1x5EeWIshgCdBf5HV0YsduE/YhvIHZRJIoKU4T5Id1o1BqikqN
 OBYEwwVByg69okvOcAaWnxcEQYoWcJjecgfA6YTZN5vQVJufIl6M2MikdOYwLbO+S3CmqsllaKL
 G0+nYIrHqkQkyw7bpDlPhC8eWFW+diLsTVrioB4x+mm6NiWo90TItroCUn+QAbMPYHPrJCMWHMV
 DUiLr7LMhRKCudXDKldvUOwn/vgKjeMvPizj9swYoHDI4pKW1NvLpWb+ToJOFVNX0CXjMLasrJX
 4d
X-Google-Smtp-Source: AGHT+IG+xDXrfnRqSGfqT7yAJTwNTupbpo2mb7dM9T/66xUt4T+D8ztrGwSr3oAPds6/lbpnk9koMw==
X-Received: by 2002:a05:600c:2d55:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-46e442fa57fmr40413305e9.12.1759139202735; 
 Mon, 29 Sep 2025 02:46:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f658ffsm5662925e9.14.2025.09.29.02.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 02:46:42 -0700 (PDT)
Message-ID: <1e08caeb-1cf9-4864-a3d0-6d9b3857f2a3@linaro.org>
Date: Mon, 29 Sep 2025 11:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>
Cc: peter.maydell@linaro.org, clg@kaod.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, flwu@google.com, andrew@codeconstruct.com.au,
 Hao Wu <wuhaotsh@google.com>
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-4-lixiaoyan@google.com>
 <1a755fbf-e6d6-4f80-b35d-29fcb3f587d3@linaro.org>
 <CADjXwji8M6RsmPtf6Duw+8WcesZD3qSZ9_cR-oiX+dzJ_w7Z9g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CADjXwji8M6RsmPtf6Duw+8WcesZD3qSZ9_cR-oiX+dzJ_w7Z9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 26/9/25 23:48, Coco Li wrote:
> Hi Phil,
> 
> Thanks for the review!
> It looks like IRQ mapping enums on other boards also generally do not 
> have line breaks, is it ok if I keep it like this for consistency sake?

This is just a suggestion, since you are modifying these lines. I
won't object if you keep the old style, and I don't mind if the
other boards as not changed (also, can be done as future cleanup).

(please avoid top-posting on technical mailing lists).

> 
> Best,
> Coco
> 
> On Wed, Sep 24, 2025 at 6:08 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     Hi,
> 
>     On 25/9/25 02:58, Coco Li wrote:
>      > In the process of implementing serial gpio and adding the
>     corresponding
>      > ENUMs, also complete the list for npcm8xx.
>      >
>      > Signed-off-by: Coco Li <lixiaoyan@google.com
>     <mailto:lixiaoyan@google.com>>
>      > Reviewed-by: Hao Wu <wuhaotsh@google.com
>     <mailto:wuhaotsh@google.com>>
>      > ---
>      >   hw/arm/npcm8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>      >   1 file changed, 42 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
>      > index a276fea698..10887d07fa 100644
>      > --- a/hw/arm/npcm8xx.c
>      > +++ b/hw/arm/npcm8xx.c
>      > @@ -92,8 +92,14 @@ enum NPCM8xxInterrupt {
>      >       NPCM8XX_GMAC2_IRQ,
>      >       NPCM8XX_GMAC3_IRQ,
>      >       NPCM8XX_GMAC4_IRQ,
>      > -    NPCM8XX_MMC_IRQ             = 26,
>      > +    NPCM8XX_ESPI_IRQ,
>      > +    NPCM8XX_SIOX0_IRQ,
>      > +    NPCM8XX_SIOX1_IRQ,
>      > +    NPCM8XX_MC_IRQ              = 25,
>      > +    NPCM8XX_MMC_IRQ,
>      >       NPCM8XX_PSPI_IRQ            = 28,
>      > +    NPCM8XX_VDMA_IRQ,
>      > +    NPCM8XX_MCTP_IRQ,
>      >       NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
>      >       NPCM8XX_TIMER1_IRQ,
>      >       NPCM8XX_TIMER2_IRQ,
>      > @@ -116,6 +122,14 @@ enum NPCM8xxInterrupt {
>      >       NPCM8XX_OHCI1_IRQ,
>      >       NPCM8XX_EHCI2_IRQ,
>      >       NPCM8XX_OHCI2_IRQ,
>      > +    NPCM8XX_SPI1_IRQ            = 82,
>      > +    NPCM8XX_RNG_IRQ             = 84,
>      > +    NPCM8XX_SPI0_IRQ            = 85,
>      > +    NPCM8XX_SPI3_IRQ            = 87,
>      > +    NPCM8XX_GDMA0_IRQ           = 88,
>      > +    NPCM8XX_GDMA1_IRQ,
>      > +    NPCM8XX_GDMA2_IRQ,
>      > +    NPCM8XX_OTP_IRQ             = 92,
>      >       NPCM8XX_PWM0_IRQ            = 93,   /* PWM module 0 */
>      >       NPCM8XX_PWM1_IRQ,                   /* PWM module 1 */
>      >       NPCM8XX_MFT0_IRQ            = 96,   /* MFT module 0 */
>      > @@ -128,6 +142,11 @@ enum NPCM8xxInterrupt {
>      >       NPCM8XX_MFT7_IRQ,                   /* MFT module 7 */
>      >       NPCM8XX_PCI_MBOX1_IRQ       = 105,
>      >       NPCM8XX_PCI_MBOX2_IRQ,
>      > +    NPCM8XX_GPIO231_IRQ         = 108,
>      > +    NPCM8XX_GPIO233_IRQ,
>      > +    NPCM8XX_GPIO234_IRQ,
>      > +    NPCM8XX_GPIO93_IRQ,
>      > +    NPCM8XX_GPIO94_IRQ,
>      >       NPCM8XX_GPIO0_IRQ           = 116,
>      >       NPCM8XX_GPIO1_IRQ,
>      >       NPCM8XX_GPIO2_IRQ,
>      > @@ -163,6 +182,12 @@ enum NPCM8xxInterrupt {
>      >       NPCM8XX_SMBUS24_IRQ,
>      >       NPCM8XX_SMBUS25_IRQ,
>      >       NPCM8XX_SMBUS26_IRQ,
>      > +    NPCM8XX_FLM0_IRQ            = 160,
>      > +    NPCM8XX_FLM1_IRQ,
>      > +    NPCM8XX_FLM2_IRQ,
>      > +    NPCM8XX_FLM3_IRQ,
> 
>     Minor style comment, maybe worth adding a new line when the
>     following enum is not contiguous.
> 
>     Regards,
> 
>     Phil.

