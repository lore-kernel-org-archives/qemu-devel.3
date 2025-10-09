Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6E1CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uKK-00021h-Hk; Thu, 09 Oct 2025 13:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uKI-000200-BJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:21:14 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uKC-00025Z-6N
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:21:13 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33067909400so976389a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760030460; x=1760635260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBy4PkYAgH4V9PSaZlp1WOgFSahyETlpvg3d/GCVMLs=;
 b=KWoUlZEH7fSjQmchw8uM5AdI8eDx9cF+RO3BWHX0LSb0vU7CmyDPqomc+UuAl6cHIK
 a6Eaz7TCkaCFab96KDgy5Stzvy8VvsePCs7RSCuGQPk+uO5fFBpWAQS0GdaiVyHPeGqx
 UgIvK4b6tobWagncdxjUNm2z/YWQzgAgad0rJYDCs84m6GBv+yCOU4OhzDxIr3ppS4RR
 aolJP9CDRzm3uRlrnZ8f5b+HdNW9MXCypXC4zMAj+SXSYsJ9679m28wdcMiBSedejkkh
 y5KJXQmHDs5whyvpxFs2sZMMIXvw6GQD7Hfzm4owg3hLfn2Q6jVh7aGQRL4rwwWwdwum
 wi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760030460; x=1760635260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBy4PkYAgH4V9PSaZlp1WOgFSahyETlpvg3d/GCVMLs=;
 b=sfCf6V98BvCmTVPgMF55260engIbQqp/bOu7xSzj4prJeiFkHCbyI+tZRomN2A33Z0
 c6edjl7jMOAW7eae3LH8Zx3uCzxIxo+loPUEjWq/cXmV1T8//3jxBoRC0ID63QuGwNzI
 ABMQqLTlPrDWGqotDhRgsrCLNU35izvj15e12Z0amB2Fxd/SbyPUy05kX3NHUmYhbfa1
 1/ndpkNsv/fDXW0Otk5B7qG4r8Dt44wijcNVM+u7GMgUGehJ4WYUFqmdhHHO91fza2Zv
 qzHbfa8feLmwCF8ZQiV3TLJoWEni5CN8g0cz+dZ89W5sCv4Gt6Lq2Xv7CpvPVBn6rd4L
 pwww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE5o2XtKXVSMP8wqO3Pkgva6q8dhbzJNDd54D9MBwp/2cIyJLZFl5AU85FgbUmS6gWVSgQklurDmWx@nongnu.org
X-Gm-Message-State: AOJu0YxZZOjRr3poVGBZOtZ7RmZ+pBBGVcxShU//Xg916qFF07z4RFh1
 o6SP7fblHtrCpFQWrn7jbmmjjz7U6REjruiUWz2Pz4fsZeizZS+JZsrX1OJgHXCt+SH6uP+t314
 FqHgKlCY=
X-Gm-Gg: ASbGncs6ujvxzh5uh1vmQxH5Fm3DkKB7ppN9aXdRE8YnXXplz/2IJwAaNMLAXeaBpHj
 mjdiC47VnfEp+EhUN/ce3r3YvxDRnQ54bmd0tGacjgAUDA2YVNiqryVW5FXIkoka0FnnHqWy4wK
 IG1vHPbcevZ5Ow1OSzMi1OX4EIsOsqAc//6o4eBYNcnGGZzkN9GnYHEKcjD34c9X6llb8LwcRSE
 amkpCZbBPr+PVt7cpwSVQvEgIw1gg7TNKpvgjBH/WtniZOhYmiorfQQC7BS3nTxxde7UI2AjM+q
 CjOo3OtnBl7OgHAH8Q1f9DNvcNqNDb2NOzwnejNXGIPpsPAURqNM0ANus9e02Y8mV8zBUWwEg0V
 2uaucaBJOw0msgA+Qa5hl5+FH/7oQzlkla2eQrMEPmSau+FeQmPgvKGD2vxZoQ1Gv
X-Google-Smtp-Source: AGHT+IH1FAWfvBzrrCuDrAPeDrDy/VYApiylvYJ72tru8BvuXGesSjYDvLHUYuagXvzisTMp9413zw==
X-Received: by 2002:a17:90b:1805:b0:334:e020:2f16 with SMTP id
 98e67ed59e1d1-33b511188a6mr12221741a91.11.1760030459594; 
 Thu, 09 Oct 2025 10:20:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61b12756sm389895a91.25.2025.10.09.10.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:20:59 -0700 (PDT)
Message-ID: <bba7ba47-cb69-4bcc-9dce-bee9cc4b9bf2@linaro.org>
Date: Thu, 9 Oct 2025 10:20:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/hppa: Introduce
 HppaMachineState::boot_info::firmware structure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009143106.22724-1-philmd@linaro.org>
 <20251009143106.22724-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009143106.22724-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/9/25 07:31, Philippe Mathieu-Daudé wrote:
> Current code uses CPUHPPAState::@kernel_entry to hold either:
>   - kernel entry virtual address
>   - firmware interactive mode
> and CPUHPPAState::@cmdline_or_bootorder to hold either:
>   - kernel &cmdline physical address
>   - firmware boot order
> 
> Besides, these variables don't belong to CPUHPPAState, they
> depend on how the machine is started, and only apply to the
> first CPU.
> 
> Introduce firmware specific fields in HppaMachineState, using
> their correct type. Introduce the @is_kernel field, to allow
> distinguishing between firmware or kernel mode.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index a2996ef7682..138cd97efd9 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -41,6 +41,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
>   
>   struct HppaMachineState {
>       MachineState parent_obj;
> +
> +    struct {
> +        bool is_kernel; /* kernel:1 firmware:0 */
> +        union {
> +            struct {
> +                char bootorder;
> +                bool interactive_mode;
> +            } firmware;
> +        };
> +    } boot_info;

I think this is more complicated than necessary.

> @@ -481,6 +492,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>                         "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
>                         ", size %" PRIu64 " kB\n",
>                         kernel_low, kernel_high, kernel_entry, size / KiB);
> +        hms->boot_info.is_kernel = true;
>   
>           if (kernel_cmdline) {
>               cpu[0]->env.cmdline_or_bootorder = 0x4000;
> @@ -519,13 +531,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>           }
>       }
>   
> -    if (!kernel_entry) {
> +    if (!hms->boot_info.is_kernel) {
>           /* When booting via firmware, tell firmware if we want interactive
> -         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
> -         * or hard disc (cmdline_or_bootorder='c').
> +         * mode (interactive_mode=1), and to boot from CD (bootorder='d')
> +         * or hard disc (bootorder='c').
>            */
> -        kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
> -        cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];
> +        hms->boot_info.firmware.interactive_mode = machine->boot_config.has_menu
> +                                                  ? machine->boot_config.menu
> +                                                  : 0;
> +        hms->boot_info.firmware.bootorder = machine->boot_config.order[0];
...
> @@ -668,8 +683,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>       }
>   
>       cpu[0]->env.gr[26] = ms->ram_size;
> -    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
> -    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
> +    cpu[0]->env.gr[25] = hms->boot_info.is_kernel
> +                         ? cpu[0]->env.kernel_entry
> +                         : hms->boot_info.firmware.interactive_mode;
> +    cpu[0]->env.gr[24] = hms->boot_info.is_kernel
> +                         ? cpu[0]->env.cmdline_or_bootorder
> +                         : hms->boot_info.firmware.bootorder;


I think you'd be better served by placing

     uint64_t boot_gr24;
     uint64_t boot_gr25;

in HppaMachineState and set them in machine_HP_common_init_tail.

> @@ -679,7 +698,8 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>       cpu[0]->env.kernel_entry = 0;
>       cpu[0]->env.initrd_base = 0;
>       cpu[0]->env.initrd_end = 0;
> -    cpu[0]->env.cmdline_or_bootorder = mc->default_boot_order[0];
> +    cpu[0]->env.cmdline_or_bootorder = 0;
> +    hms->boot_info.firmware.bootorder = mc->default_boot_order[0];

Setting hms in reset seems wrong.


r~

