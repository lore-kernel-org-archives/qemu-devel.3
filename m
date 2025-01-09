Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2364E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrAS-0001wK-4R; Thu, 09 Jan 2025 06:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrAQ-0001tV-7f
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:57:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrAO-0002fT-MV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:57:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so9228185e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423855; x=1737028655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJlxzpSG0e4bXoynPmdtY5JzroW7mpGQlyBaz29mtAQ=;
 b=CM4GXiBarq7scRAXj/m2Q/4oz/B8Hc5G5kABAH7r/BXB+fF2/YYZN/Mi5mQjkzsY40
 7+I3+bS1UPsBNEv15Rb+CCsRqrF1C2XXu7N8YvcbJQIHI0+1rL/M8eIi7g62q8ScCVcw
 x9pWanO8ZeGTkrG5gsNtW1hFBMKD37v+g+bgi4itfufcbpkrEvhoHTwF2q6d34QdnLLT
 bZHGeJKCIzLy7wWNLDIEpE2pTdNfF5dpwS2joDwJonc0oVKci1AF8BaSA2VDLBEjnQxQ
 +Y/OUwKgysZ/RfgorUwvdnJKXMetACcAFUUEApykxLthcA8MR8FrFGld3NJNMnJZby9D
 unZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423855; x=1737028655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJlxzpSG0e4bXoynPmdtY5JzroW7mpGQlyBaz29mtAQ=;
 b=u+HxHhivIuqGzRBnh0q/2KH39egsmOyeanrlhD7hFGL18z8J5hc454XxsdUCgEhEWT
 NmSufg2IoC0lyfTOXTALrx6s5knBrX5fOceBxzt3qcuuSsobD3xpP4A9lUi8cK3pdh0s
 YfH3OMY+laoP8P/92siDDgvfDIWBjyYB/H1CqcZNgu8nYnLyZVi6ABotAJVhwshFREi4
 TTze0eBmJW2c4utYDcdwnl63iIY3rL1bkjjaq7EC9R1AKj0HRr6wgqkSSO5Ofnfwsa3R
 +ReBwzKJptpWy9DIYvjsN+A5zqX0t8GxzXpiHVUPlw/X2NG6gMz3hqqBavh61qU6MMWk
 p+/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjAQ0lrXWZgQLDOfMowZc74cgpOefhSzzjuNSdx/bQifoE9FIty3PjqKZmn+r5fL2ZzZQZEFlGvGk1@nongnu.org
X-Gm-Message-State: AOJu0YwELA6luyFPTKzWj3OHfdCC0sD9I8WXGeou0JHxoXaZJyzp6KlT
 xzf54V7hzyVk9Z7Wbhbbe5psHk5vFbsb3H1lyIyUQZRPuLaEKY3PJuTINS2FKWyrorBciAI6ENW
 Jcsc=
X-Gm-Gg: ASbGncuI83Mgwkvf4z043k0/eYCg2QRFnprJSUhkAD4YVQ1ne1lzn8JJOZfSTYLw0cN
 EbP6zjzXoeILzcSHoXE2ANrgEMFFrJHYOKB20j5qgRHuDlQcWLEk4Zq/S5WL5ktxaMf1B9e0NBc
 009QuM+NMa29sXdL/vJJrcyPlMrCeY2kNkK56ydIWk/wksRg63mKfeZaEueMJpB3IPlaevmBPSA
 wt/ZFx8YpltpQMZKOqPYS0BynpXVGsvf75cBe9yErbei/oTV7sUVjBbQztoWdU7Qa3rFhJKaPO8
 MSLHUvLb8d2DHNAPDfSXyAan
X-Google-Smtp-Source: AGHT+IHIYzOiRrZUxUInL3PdQ4qT5dxHEI1ap7/g90KfBjfqxpEEEm7WHEjQjf9cAezCiQrRB6V02g==
X-Received: by 2002:a7b:c5ca:0:b0:436:e3e6:b725 with SMTP id
 5b1f17b1804b1-436e3e6b799mr48368215e9.6.1736423855317; 
 Thu, 09 Jan 2025 03:57:35 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2c27008sm53506825e9.0.2025.01.09.03.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:57:34 -0800 (PST)
Message-ID: <920a78ba-08fa-4a0e-a72e-4ca210181a13@linaro.org>
Date: Thu, 9 Jan 2025 12:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/gpio/imx_gpio: Turn DPRINTF() into trace events
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-15-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-15-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> While at it add a trace event for input GPIO events.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/gpio/imx_gpio.c   | 16 +++++-----------
>   hw/gpio/trace-events |  5 +++++
>   2 files changed, 10 insertions(+), 11 deletions(-)


> @@ -210,8 +205,7 @@ static void imx_gpio_write(void *opaque, hwaddr offset, uint64_t value,
>   {
>       IMXGPIOState *s = IMX_GPIO(opaque);
>   
> -    DPRINTF("(%s, value = 0x%" PRIx32 ")\n", imx_gpio_reg_name(offset),
> -            (uint32_t)value);
> +    trace_imx_gpio_write(s->iomem.addr, imx_gpio_reg_name(offset), value);

Similar comment from patch 12 (iomem.addr -> qom_path?), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

