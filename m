Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DEDC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQcn-0004zx-T7; Tue, 04 Feb 2025 16:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQcl-0004uV-Rq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:38:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQck-0003jT-6y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:38:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so42542735e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738705104; x=1739309904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0hDIfiZm7cM2pMBKQYziSrKjmJPOXOvSA6Bjp6kfZE=;
 b=Uzq2Ss+4geK5XD3FkaRe/ByWe5wgCfiaOXalNUVvQD/IvzMnvbrupNe4VLCG2vgeEK
 I+8C62oOOIYNvLVjbpRgzjSkwtM+RFRbbSVZ+M9z0sq5q7AncZp4eDVOaQoAAlUL5nw/
 PJJkxAozup4xaRFQV8KfLetInSfZJqXkfuqCstJz+iqwnDW8DTtTNbsFLjn2zHhIsGL8
 ozs7FjpudBoFftAE50ny6WA6w+5XTswmuJATCoHM2aifAjToThjQF9+RZBB/twXYTvKc
 r+zcYtGMpMjYJhKbBHqN9vnx3fZwS1kIIgUBwelJpD0E9NlhRgScUjstH3+juAkHcgev
 AuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738705104; x=1739309904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0hDIfiZm7cM2pMBKQYziSrKjmJPOXOvSA6Bjp6kfZE=;
 b=uX33rZqahg9Ck5Ew17vYv9h+QMavgQVrhtg6n+f6suu/Ft/YrhEU9pck9QengsxfNd
 LEWzbcDsMflql3AbN3yKnvCEKIIMpQPJokOfI5KWw/LgdFfaZ8ign53DntccugS0Vehx
 v3TDdWYxOHyy0wj1c79pKKY7Hk9VkjMnViIWBsXhTglB34MqimxlekLymtWPH+3HJFcf
 ty2fCeShXBzK4i/Mwiso6ddj+d15803vA7+L7t/srUwaeE5Jn8XPFhIH082T1V104wQ9
 GI4ZhDjFvJDzfuFUMTJ3CB0Yj/ni18f8hTYHeGasLih6AcD9gYYSISyfC8CXYGNdN66F
 83Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCqxqfOpZMR+eTpC0vZKxBVIh+0EsfmTXblq3Q1Lkonfwb76sj3E8uct8+jV6xBJK91rtSo/FQw4fn@nongnu.org
X-Gm-Message-State: AOJu0YzYiA3gCFDBWCm44ERKBB31YkFBxCVg7M5pwq3Q+1vej/j+Qu7S
 9X8AahrtxlLjHcX2KRzmjSU+0B5xw6Zhzdi3Kw6XJHQhw6ZSxSoypVjh8y9JxEM=
X-Gm-Gg: ASbGnctu9Izt0XfDOvuws3qY/JjRmteCdUELq6JVhP26zWSKPY2KWrr2gYt9e+rd3sd
 7JRrXK39T/fQtkRDhMACepMgybeTld52R7hNfNvxR5Hn8ZgF7PfPnIpszZ2fqcgDn/Mo2h6Ga1N
 COreU7oiXUnIfIGQbIABJ1Gf7luGqA2MLFwTRO4JAC2sO7Sk1ggsAEQOES2Ovm8C30B5zdWDDcA
 wGEiXocYzEAo8+o1p2SwEji+pB+MUPFaxoFvqYUFf5ax/r7lqqAIPwTJ5mwoGKPHNuYlLVXm/UK
 Ud+ZjC+BLV2HsrncmgUCnRryaTcanme6D5VyBwuCxZ4tePg1scCcHVIFEgw=
X-Google-Smtp-Source: AGHT+IF7Rfe4e91lgRYBSH5dbcUsCzTt3t2Yv2Wfgaa/3dUjKrFfnejTo+ykNpWSTLgSSDvNGZGmgQ==
X-Received: by 2002:a05:6000:1882:b0:38a:88bc:aea4 with SMTP id
 ffacd0b85a97d-38db48be08bmr217475f8f.30.1738705104574; 
 Tue, 04 Feb 2025 13:38:24 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dae1a1e4bsm2606202f8f.55.2025.02.04.13.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:38:24 -0800 (PST)
Message-ID: <b053170f-1116-40be-8e60-95961721dd64@linaro.org>
Date: Tue, 4 Feb 2025 22:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] aspeed/soc: Support Non-maskable Interrupt for
 AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20250204060955.3546022-1-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204060955.3546022-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 4/2/25 07:09, Jamin Lin via wrote:
> QEMU supports GICv3 Non-maskable Interrupt, adds to support Non-maskable
> Interrupt for AST2700.
> 
> Reference:
> https://github.com/qemu/qemu/commit/b36a32ead
> 

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/arm/aspeed_ast27x0.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4114e15ddd..361a054d46 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -470,6 +470,10 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>                              qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>           sysbus_connect_irq(gicbusdev, i + 3 * sc->num_cpus,
>                              qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +        sysbus_connect_irq(gicbusdev, i + 4 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
> +        sysbus_connect_irq(gicbusdev, i + 5 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
>       }

Thank you!

