Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B76C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoaR-0005BU-0Y; Thu, 10 Jul 2025 06:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoUm-0000ut-Qs
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:27:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZoUk-0001OU-86
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:27:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so747052f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752143230; x=1752748030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ExcQf7fHBMrtra4ZtSmzzwYPnPNqnHoxY/K4Ap5Yr0=;
 b=pW2Df2OvWAIYYNPujq4yeq61LnuT4SNPXrnraT0bJ+Ub/PezWnxV/dZebrqDdvocjs
 tCQUhl6QHBLJ/3dBVyQXjq9UAkl8IQw1MzkUuzoi0HeHVVFUL58bcbF6hjbi/Yyav/oh
 uBQYftY7eqi1ylct25gWvZTwM3zuFzhUqSI0CM14aHNAvxxq9tkycq9AVHjfe+RuL/1/
 tUSuhS5A2CVnPHLLBfzmRGRKXxnal/lWlSyBzRscjGkmd8shOwICMsXR/+UowbIPgmhC
 TtVYRMphRUF673n/uIhsjom+I3bkJOBx1AiKAygxbXpbP9xn9ZYDds9DHci6a8ZJe2lE
 TauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752143230; x=1752748030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ExcQf7fHBMrtra4ZtSmzzwYPnPNqnHoxY/K4Ap5Yr0=;
 b=PlNvy4C3V7qT02CYNZ7bizS1ay5hVl1TicXFWotYu+j8rHmU6ISA+wyhS5u9vocgBI
 tOmtmgAt9k9WXs1of/V1u05Iw4TxUoGuBpFM9CKKwdGI+dztcSagREUXStQJlloRwOlA
 W/s2kiRcd2tn/TrjKFCof7/5++JYes+dQz7X9ngV5Z4T6ZiAWR86AOHTRf+7WAuTBxKv
 WUgK2FarpWaRtqzWSk3VzPHSU/ofTXvx1HKYtdN6pHr0UFMayPTrlzj3JVkxkoHDT3Fa
 TaBxn3rb+t53GwUU0KqReHWI/Vn8aRIJbqFMbpvYWo508s6Dm25KaCtACsh2BJsAJJhN
 uGAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxx+BDPHTJIYAqoMBAp0r0odwrxyQLk0ojdPz0duap5Z1xy7gIrn25c1gSXykDPPUGe593ozLqv+PN@nongnu.org
X-Gm-Message-State: AOJu0Yz5yP+yW5F1TFFyxqYzVZnk/U07RhPWBiFEHxaVklrEHpG+1gfl
 acYZDjuWkHGTiosO2pQehscW6u6Yhql2ktzrfoTaD+6yjBiOc3xuwHhvSelqGZAjP+8=
X-Gm-Gg: ASbGncuJOzlzXJAupLHyu5hm+HEEkgYQMFYIQXTSNEw1uOJPOm5xf3svua0qTzj7hMC
 jY3BdLK7YjeNmDNhq7h94lWEvAwbNnmhMNrAIjJgJ2uONxYNSGfR/9D4efXgA4q8dFSwB09rjhY
 okgRiofhhRNpDFKCfgm881N/hTN67+DmT4JQXNN2v/SEW9VH0RfiQvZMsk7Qq9liGZuymjWx4OL
 pei7hcnb+B7uNUfTpU+m+hmdukhehY1i6WRvRQtnmGnNIGkgaltV+X3E+er2OzI2XoampBDDXWM
 PZFMfIXDjCI59uW5lhlBjRS3drfb40BdVYHs8RV3tmClkNyw82X9abgJjf1uy29yNQynbCG2wdM
 WFw1q15fwrc1Y/ZE0szHVMwLbWBoPzUSODvTOJBTsjIQ=
X-Google-Smtp-Source: AGHT+IHm2FMkhRy5RU+rLKiPVfarhJWxSWYGdLQKao6bzXuD6BItfAL0EElyF+iZU6bm0L3VtjZNrw==
X-Received: by 2002:a05:6000:23c7:b0:3b3:e29:bda7 with SMTP id
 ffacd0b85a97d-3b5e788d2d1mr2277668f8f.9.1752143230309; 
 Thu, 10 Jul 2025 03:27:10 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cdc6a542sm49329635e9.1.2025.07.10.03.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:27:08 -0700 (PDT)
Message-ID: <6cc4ce6e-312f-425e-991b-74ac2d4cd6a9@linaro.org>
Date: Thu, 10 Jul 2025 12:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-2-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141018.674268-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 4/7/25 16:09, Mark Cave-Ayland wrote:
> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
> possible to specify any CPU via -cpu on the command line, it makes no
> sense to allow modern 64-bit CPUs to be used.
> 
> Restrict the isapc machine to the available 32-bit CPUs, taking care to
> handle the case where if a user inadvertently uses -cpu max then the "best"
> 32-bit CPU is used (in this case the pentium3).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ea7572e783..67c52d79b2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -418,6 +418,18 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>   #ifdef CONFIG_ISAPC
>   static void pc_init_isa(MachineState *machine)
>   {
> +    /*
> +     * There is a small chance that someone unintentionally passes "-cpu max"
> +     * for the isapc machine, which will provide a much more modern 32-bit
> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
> +     * been specified, choose the "best" 32-bit cpu possible which we consider
> +     * be the pentium3 (deliberately choosing an Intel CPU given that the
> +     * default 486 CPU for the isapc machine is also an Intel CPU).
> +     */
> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");

We should warn() the user about using "pentium3" for "max".

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    }
> +
>       pc_init1(machine, NULL);
>   }


