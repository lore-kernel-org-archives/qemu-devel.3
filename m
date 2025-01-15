Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26403C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8Hu-0006nQ-IJ; Wed, 15 Jan 2025 13:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tY8Hr-0006my-H3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:38:43 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tY8Hp-0002Hl-Sh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:38:43 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21661be2c2dso127775065ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736966320; x=1737571120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLKS8BPrTkvEESr+Xd3LfYYd7sB95wIHlX5ZChxm3FQ=;
 b=dRAddE/kYS845YRN8GGy7aVKJBbw3knkNniobZNXw8FZRUXoR9ebiyqqqt34W+IvY2
 E9Ip5EunBWWlQFuGeW/1VSWT2308DPFb3PfjK3GN+8MubxEbwfo/xkKTjg4k1dWXjhyv
 AaESb3Mu+G/oDSWmER5Y+ufcnpVYudtWAHVR/ZuWmqy3pV5+MFg5fv/2LzioMv2PwQSp
 lbTgPPF8EOTwJ8zbItvO66ACZrs4tssWUiHEzxuKZ0VE8fF6Q3aN0mvdivpm5dUs5Q3k
 SwuanGmlv30wAIU2oY3cq1fXLs7XsGv2dHxp5Bq0JxZaUhFC83HxNXyfOgD+Qa9tuow6
 bEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736966320; x=1737571120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLKS8BPrTkvEESr+Xd3LfYYd7sB95wIHlX5ZChxm3FQ=;
 b=eN8uyEBSqSVXYf9YCD99G22W523ppw9vHiA9uycvhW5uResJjjgbMVGlfx+HXhWJqJ
 EmnqdTDUdNTB4+AQ7noYX2qyl2abrRrJwUzpKgm6fjH0v0Wc+c9bIjiqHSXqMjMQEIoC
 /qeCha43wT0CF0Vg2lml3DtESL3eXVcGX5DXvf9YEtSE5pzNAmjiCsmupRMCqyQDFmVD
 0WgHBT9zMfAv4rKY2r5sDsQ2ixnUzDPIFYoCqwpEI1h9Ugrljo/Ynuu1Tyjgqt+ncwJS
 /KB965dLYg2qivyEjf83R9WmgSDxBAyf9r3oYTBfWoDRHPpC5fOLeeme4ofSB758MY4q
 h7Cw==
X-Gm-Message-State: AOJu0YxqiEjmwre8U4mR7qIBpMNkjSsG538eQNkSF95y8rxzmDS2/VMK
 UkEs+qHoJ/xIYnh6m/sRhUsnHszc3MpCUuglGjpud9Gt7QlAKXImMo0dWFyeInj2V4/QZL2Gz4F
 Y
X-Gm-Gg: ASbGncshs0scewtY2MoN9aoeEvKibenZe1M4Ulw1tG834sBynYmHqujyZqywzn9RlJz
 8f5XrfPwmxjvCYrQ0KjcuUmhSKCiVNiAnsZGcmLzpi0RBVdMVnReWNYPjbnX4KgwQDVfPd97ZAm
 P+/p9uZzYstnGGPwPkpbqob3o2H0x2CJ2Bk0s4GCSO61DPyTI6PP3/P3wG/A0OotBRkQkWC53/C
 B/tMx5r+AOO6MEb/2Tq27evn2TEVigVURR7C5xWpSLPsWGMflhQ2a+6TmJqDrA+dVc57vC/DRZq
 ZJ5+Fns56OazJj9n5ZAYJbE=
X-Google-Smtp-Source: AGHT+IGZOJvgFSTq8eXf3Y2tpubwSCtYcBsFPZIMyg50qsWbbpCLokm27WIzTTOGsXOxLJbrIoeCtg==
X-Received: by 2002:a05:6a20:43a9:b0:1e1:b727:1801 with SMTP id
 adf61e73a8af0-1e88d15a830mr46683726637.27.1736966320075; 
 Wed, 15 Jan 2025 10:38:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406587a1sm9732820b3a.105.2025.01.15.10.38.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 10:38:39 -0800 (PST)
Message-ID: <d3ecd881-9907-4b6b-9693-63151a59be77@linaro.org>
Date: Wed, 15 Jan 2025 10:38:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/openrisc: Call cpu_openrisc_clock_init() in
 cpu_realize()
To: qemu-devel@nongnu.org
References: <20250114231304.77150-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250114231304.77150-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/14/25 15:13, Philippe Mathieu-Daudé wrote:
> OpenRISC timer is architecturally tied to the CPU.
> 
> It doesn't belong to the machine init() code to
> instanciate it: move its creation when a vCPU is
> realized (after being created).
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/openrisc/openrisc_sim.c | 2 --
>   hw/openrisc/virt.c         | 2 --
>   target/openrisc/cpu.c      | 2 ++
>   3 files changed, 2 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index e0da4067ba3..d7f97d19913 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -306,8 +306,6 @@ static void openrisc_sim_init(MachineState *machine)
>               exit(1);
>           }
>   
> -        cpu_openrisc_clock_init(cpus[n]);
> -
>           qemu_register_reset(main_cpu_reset, cpus[n]);
>       }
>   
> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> index 7b60bf85094..676cf8d692d 100644
> --- a/hw/openrisc/virt.c
> +++ b/hw/openrisc/virt.c
> @@ -487,8 +487,6 @@ static void openrisc_virt_init(MachineState *machine)
>               exit(1);
>           }
>   
> -        cpu_openrisc_clock_init(cpus[n]);
> -
>           qemu_register_reset(main_cpu_reset, cpus[n]);
>       }
>   
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index b7bab0d7abf..291fec04fda 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -165,6 +165,8 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
>       qemu_init_vcpu(cs);
>       cpu_reset(cs);
>   
> +    cpu_openrisc_clock_init(OPENRISC_CPU(dev));
> +
>       occ->parent_realize(dev, errp);
>   }
>   


