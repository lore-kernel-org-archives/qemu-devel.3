Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11BBCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIT2y-0006JG-I0; Mon, 10 Nov 2025 09:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vIT2r-0005tB-R4
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:39:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vIT2p-00063a-IP
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:39:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477632d9326so23891015e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762785538; x=1763390338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1YeCpGyvL7oNB8u0xlywafc3OeQJ0d36c/QuGhsZqZk=;
 b=Wy3L6AxIun6B++2849xafz4FQ6KBpEhCXTJDw59aiohHWhLI3gnTfoevIXdyQRkVbZ
 aWMmrko4JIjq04WeiKm29jO9S+MkNkjR5WZ+NXBJo2I+YW5X7HJXBnYQLlc/myvD2rKe
 xtCNPYiESUNbfUSd9oV38KFsMBNcgdnAv7xN26oKe/QEC7WIJZuPBXSexfthZMHBH0MD
 HSmT9r9khm10V/0YcL+oG6sKZCVwF3CS+yJ6td6bZXaGEcz/8o3pn1fMwNFb5DjrYd2y
 ptyiii+ryUXCbPF65miu8aupLy3I5S4kpun/S8Uk4xtiFpM/O0+3LwiZ/gEkwPJHXBvK
 oN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762785538; x=1763390338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YeCpGyvL7oNB8u0xlywafc3OeQJ0d36c/QuGhsZqZk=;
 b=pgXfKiuWFUeaiPBq6cM1rsBT5b6UxfTDdnMTNEG14RYS8a953Mlwhq8aqMQOChBgMx
 gNjeCvfEZSj9VBO1YI3gVH8/54n6vGcPT9FbMwgbUJTuwqo0jEYF/G58gwbihJ2m6JcV
 NUoL0CkIytxDYauvfojWYAylxQKxUJzBciaDP/XqwUIvLeq65AIyNVcbVpsLWXRl8NQb
 BJEaOQwaesHnhofWUHEDeWrb5H7iJdQf8dgJGgrl3gpTD+TmKAsZH5z1bNTeNgufLjmG
 azYfp3Bp7aoN2gohfflF5Kf6sMT3uu6q9yUceczHYim8d+szGlXRj9fidr8OcGaOl0JW
 ejPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS2WaVmQsor/N9Q3LGm50ZCo2Z4Uz77V1qPCXTs1QZHRITbDwelth3M2onCSWtIZ52ZllADvFpK7pA@nongnu.org
X-Gm-Message-State: AOJu0Yy6zBq9/TU3hhuNxDLh2vOWMn65d4qKOwo0IBZSYFt/LdRNa8Yo
 5jyK2NinE3XJ/nxsiFmb8Y76tBimnFTXyE91rarlt6+vF2LqAsViy/WPZWUlAfltcjc=
X-Gm-Gg: ASbGncvFnP71O3QuuSfdvLGgfX4vPfv6g7E6wtt6FJc+4Bg75j9DrgJqQ9Bf9qDi7zX
 hD8J3v0TuoeLQosgEVGHcFafpYdbEToT2xiPWj6KXnPp6K/zrSHtg1TkWm3jGMi8IMeUmmavnt7
 z6ofT0noLdkUbRNrigNo5Zr/srI9i2zXQvhhRo3iWJvg2TFKrVARWensgNdBo/fjWuNVzP9/Nfp
 1dRGUcTqpZ3jjdvKuvWlW8fYL58Euolsva1fwGL0e+Bb6SJFdaOSVk1QrfOleVxX4Rl7REXbzcM
 5JkZg86eDkSYUjiH4WiVs3+zbAEYRDa4PITdIp6Sf0/zw5H1vksgryJ936pDKgqKlq8sHZ7omJX
 b2kjBXIm74FAA3Ib/wiS5crSuEh2LC8Hv9CTfMpYBDhICdUl7uu+HgCyCnILC2NLkJPPxBd2tjX
 t9OT7d1agU8JJsHEilkWNuV7PsVmQQWbrcTMV+vOoGozfV3rBgjwISUbH22ppf1pc+DA==
X-Google-Smtp-Source: AGHT+IGT4jbPA6lwacTRf5Wne1RjAbc3siLJMMI8Bu7EF5Ka3sdfJcjPXVUaTPfWazrn30OxU/ctOA==
X-Received: by 2002:a05:600c:1ca4:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-47773230870mr70920975e9.11.1762785537941; 
 Mon, 10 Nov 2025 06:38:57 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e86fc9sm114900275e9.2.2025.11.10.06.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:38:57 -0800 (PST)
Message-ID: <f977087d-b25c-4f8e-af6c-d36c5cda0e29@linaro.org>
Date: Mon, 10 Nov 2025 15:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] Adding comprehensive support for i.MX8MM EVK
 board
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Gaurav,

On 10/11/25 12:22, Gaurav Sharma wrote:
> This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit)
> board to QEMU, enabling emulation of this ARM Cortex-A53 based development
> platform.
> 
> The series includes:
> 
> 1. Core peripheral support (CCM clock controller, Analog module)
> 2. GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
> 3. GPIO,I2C,SPI,USDHC and USB Emulation support
> 4. PCIe and ENET Controller Emulation support
> 5. Documentation and functional test included
> 
> Key features ported:
> - Basic boot support with Linux
> - UART console for serial communication
> - Interrupt handling
> - Clock and power management infrastructure
> 
> Testing:
> - Linux kernel boots to console
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> 
> Gaurav Sharma (13):
>    hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
>    hw/arm/fsl-imx8mm: Implemented CCM(Clock Control Module) and Analog IP
>    hw/arm/fsl-imx8mm: Implemented support for SNVS
>    hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>    hw/arm/fsl-imx8mm: Add PCIe support
>    hw/arm/fsl-imx8mm: Add GPIO controllers
>    hw/arm/fsl-imx8mm: Adding support for I2C emulation
>    hw/arm/fsl-imx8mm: Adding support for SPI controller
>    hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>    hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>    hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>    hw/arm/fsl-imx8mm: Adding support for USB controller
>    hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation

Thanks a lot for splitting the previous patch so cleanly,
review will be much easier. Also kudo for including a functional
test :)

Regards,

Phil.

