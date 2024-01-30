Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD676C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmWQ-0007Yc-W8; Tue, 30 Jan 2024 06:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmWM-0007TG-TC
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:43:18 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmWK-0007QZ-ON
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:43:18 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55a90a0a1a1so3620736a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614994; x=1707219794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPcbulb40b0Xgbnlp4HafEAm9Om4dQjZCzL0MdkOlMA=;
 b=lgYzEr6VSDtwvLH2ngfyW0LUHPNysA/e0GTADDWnOlViG9wXUEzdPMq6ntHS/74Keb
 AxCGXkrPE3AbiM0XDahoAGNewWJHafR7xVFoTB9bx0gldHyJwmER5bQEhYX2GD4yWS/I
 9zVRCxD8upAI6NVZYeUYdQbV7jGainhgkTjF2rnngcy/3t/353J5DH2JneAzltkR6NQ0
 XiCYtkP8MTDcRoarNEMppx+hRHyhcjo0jLqSkuiDNKyhmwJMAG5Rv4qhd5IritLfbl+a
 L+G5C07sS7W84ErNAgvu78J135FbFPX388a0COMPQUZd9ZV0K1KC9J23iFDodjwKLFUD
 qbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614994; x=1707219794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oPcbulb40b0Xgbnlp4HafEAm9Om4dQjZCzL0MdkOlMA=;
 b=tYvHu//azedYLTBExXA1ylQtayCbfyESTcNlOgmn6zIFenAwxH7XL9Sct6mo7U8ZTW
 3I4809Z2UUIzrWxaEwT/h/dYzKskP5r7+OJluf0H8DeYisuW7O2yC5kdsy9P0RyfuGu2
 aZmrS/PM0ib2bTzYu5rT5u65GVm0QySCkB56xbzOCE1xtCIan7x9xTBtuUdPWGm6ygGX
 1HsKkaPD8nE3Ap/DZuAqYiaaKArUCjVqb15Nf/yfESybn8WoVYvTELSZ7oUIlgjrGL6x
 orc3WRiNdJ3E5db8bb79wvOTtMXfa9MW4a1hGNW6UdmbVCGWnzMCSvDOVgWSRO85E8c7
 ydZA==
X-Gm-Message-State: AOJu0YyScaEStzyDbID/UzHvIVJxVBM/Dveg4QeyYOo0+iFtRK/JCg87
 ihs3ybjk2oYPyqfsuzzFd2vqJUc9Mr8s855eJkzefamsZTdZustGzv0e2RNQtYc=
X-Google-Smtp-Source: AGHT+IE76qFiDEKL/gGZ+ThXo74Ob8C6jAgRduzSYx4NOGfGnTfoM8voFnPJLb80EUgopKJJEw5LNw==
X-Received: by 2002:a17:906:a001:b0:a28:d68e:4372 with SMTP id
 p1-20020a170906a00100b00a28d68e4372mr6002255ejy.74.1706614994423; 
 Tue, 30 Jan 2024 03:43:14 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 hd10-20020a170907968a00b00a35cd148c7esm1865132ejc.212.2024.01.30.03.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:43:14 -0800 (PST)
Message-ID: <42f8556d-a094-4448-9183-b158ac12e650@linaro.org>
Date: Tue, 30 Jan 2024 12:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] leon3: implement multiprocessor
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-7-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-7-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Clément,

On 16/1/24 14:02, Clément Chigot wrote:
> This allows to register more than one CPU on the leon3_generic machine.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/sparc/leon3.c | 106 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 74 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 7866f0a049..eacd85ee4f 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -54,6 +54,8 @@
>   #define LEON3_PROM_OFFSET    (0x00000000)
>   #define LEON3_RAM_OFFSET     (0x40000000)
>   
> +#define MAX_CPUS  4
> +
>   #define LEON3_UART_OFFSET  (0x80000100)
>   #define LEON3_UART_IRQ     (3)
>   
> @@ -67,9 +69,12 @@
>   #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
>   
>   typedef struct ResetData {
> -    SPARCCPU *cpu;
> -    uint32_t  entry;            /* save kernel entry in case of reset */
> -    target_ulong sp;            /* initial stack pointer */
> +    struct CPUResetData {
> +        int id;
> +        SPARCCPU *cpu;
> +        target_ulong sp;  /* initial stack pointer */
> +    } info[MAX_CPUS];
> +    uint32_t entry;             /* save kernel entry in case of reset */
>   } ResetData;
>   
>   static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
> @@ -125,18 +130,19 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
>       stl_p(p++, 0x01000000); /* nop */
>   }
>   
> -static void main_cpu_reset(void *opaque)
> +static void leon3_cpu_reset(void *opaque)
>   {
> -    ResetData *s   = (ResetData *)opaque;
> -    CPUState *cpu = CPU(s->cpu);
> -    CPUSPARCState  *env = &s->cpu->env;
> +    struct CPUResetData *info = (struct CPUResetData *) opaque;
> +    int id = info->id;
> +    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
> +    CPUState *cpu = CPU(s->info[id].cpu);
> +    CPUSPARCState *env = cpu_env(cpu);
>   
>       cpu_reset(cpu);
> -
> -    cpu->halted = 0;
> -    env->pc     = s->entry;
> -    env->npc    = s->entry + 4;
> -    env->regbase[6] = s->sp;
> +    cpu->halted = cpu->cpu_index != 0;
> +    env->pc = s->entry;
> +    env->npc = s->entry + 4;
> +    env->regbase[6] = s->info[id].sp;

You take care to initialize with different stack, ...

>   }
>   
>   static void leon3_cache_control_int(CPUSPARCState *env)
> @@ -170,8 +176,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
>   
>   static void leon3_irq_ack(CPUSPARCState *env, int intno)
>   {
> -    /* No SMP support yet, only CPU #0 available so far.  */
> -    grlib_irqmp_ack(env->irq_manager, 0, intno);
> +    CPUState *cpu = CPU(env_cpu(env));
> +    grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
>   }
>   
>   /*
> @@ -213,6 +219,20 @@ static void leon3_set_pil_in(void *opaque, int n, int level)
>       }
>   }
>   
> +static void leon3_start_cpu_async_work(CPUState *cpu, run_on_cpu_data data)
> +{
> +    cpu->halted = 0;
> +}
> +
> +static void leon3_start_cpu(void *opaque, int n, int level)
> +{
> +    CPUState *cs = CPU(opaque);
> +
> +    if (level) {
> +        async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
> +    }
> +}
> +
>   static void leon3_irq_manager(CPUSPARCState *env, int intno)
>   {
>       leon3_irq_ack(env, intno);
> @@ -238,17 +258,21 @@ static void leon3_generic_hw_init(MachineState *machine)
>       AHBPnp *ahb_pnp;
>       APBPnp *apb_pnp;
>   
> -    /* Init CPU */
> -    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
> -    env = &cpu->env;
> +    reset_info = g_malloc0(sizeof(ResetData));
>   
> -    cpu_sparc_set_id(env, 0);
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        /* Init CPU */
> +        cpu = SPARC_CPU(cpu_create(machine->cpu_type));
> +        env = &cpu->env;
>   
> -    /* Reset data */
> -    reset_info        = g_new0(ResetData, 1);
> -    reset_info->cpu   = cpu;
> -    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
> -    qemu_register_reset(main_cpu_reset, reset_info);
> +        cpu_sparc_set_id(env, i);
> +
> +        /* Reset data */
> +        reset_info->info[i].id = i;
> +        reset_info->info[i].cpu = cpu;
> +        reset_info->info[i].sp = LEON3_RAM_OFFSET + ram_size;

... but all CPUs are initialized with the same stack. Is this
expected?

> +        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
> +    }
>   
>       ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
> @@ -266,14 +290,28 @@ static void leon3_generic_hw_init(MachineState *machine)
>   
>       /* Allocate IRQ manager */
>       irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
> +    object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
> +                            &error_fatal);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
> -    qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
> -                                        env, "pil", 1);
> -    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
> -                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
> +
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        cpu = reset_info->info[i].cpu;
> +        env = &cpu->env;
> +        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_start_cpu,
> +                                            cpu, "start_cpu", 1);
> +        qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
> +                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                                           "start_cpu", 0));
> +        qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
> +                                            env, "pil", 1);
> +        qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
> +                                    qdev_get_gpio_in_named(DEVICE(cpu),
> +                                                           "pil", 0));
> +        env->irq_manager = irqmpdev;
> +        env->qemu_irq_ack = leon3_irq_manager;
> +    }
> +
>       sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
> -    env->irq_manager = irqmpdev;
> -    env->qemu_irq_ack = leon3_irq_manager;
>       grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
>                               GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
>                               2, 0, GRLIB_APBIO_AREA);
> @@ -347,10 +385,13 @@ static void leon3_generic_hw_init(MachineState *machine)
>               uint8_t *bootloader_entry;
>   
>               bootloader_entry = memory_region_get_ram_ptr(prom);
> -            write_bootloader(env, bootloader_entry, entry);
> -            env->pc = LEON3_PROM_OFFSET;
> -            env->npc = LEON3_PROM_OFFSET + 4;
> +            write_bootloader(&reset_info->info[0].cpu->env, bootloader_entry,
> +                             entry);
>               reset_info->entry = LEON3_PROM_OFFSET;
> +            for (i = 0; i < machine->smp.cpus; i++) {
> +                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
> +                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
> +            }
>           }
>       }
>   
> @@ -389,6 +430,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
>       mc->init = leon3_generic_hw_init;
>       mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
>       mc->default_ram_id = "leon3.ram";
> +    mc->max_cpus = MAX_CPUS;
>   }
>   
>   DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)


