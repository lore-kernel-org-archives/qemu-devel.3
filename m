Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A40C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNnO-0000C7-P9; Thu, 20 Jun 2024 15:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKNnN-0000Bs-Mf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:50:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKNnL-0000AA-Q3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:50:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-363826fbcdeso995812f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718913005; x=1719517805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXi+uyR4RkxR742R2h/AAMkxPSDdOn0qbEMlH0UZsKQ=;
 b=BDxDhPlroKyvB604wRdNBMkAVv1y2Ar86Lutpl2GTxGFS5bRtIfZ3gfjWoNfl6sVSK
 2DWNFa0QhHUnNjDpfrQWwHg3bR1gkIKeM8/bcYPJXeRavH/++GwbMXS1FEpz7GgwYtR8
 QrpWxTvVqhluJmvuYev28KmswdmsiW/9C9vhPbIfL4IFOebKHIJWNjwIAWjpbDmox34F
 kuIbKFG5QwQe5uMrzdoVgbHhYpLJPQPMnTJ/TKaUTbgXOvOP23Z9Jb0pS9sHgrGvSS8R
 5BBBeK0Cj8qJprVNEuFLbSjeKJKk6rBkSmCbd6AHKxhz+DPa+WVEVqex3GWw8lrZxEGz
 QnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913006; x=1719517806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXi+uyR4RkxR742R2h/AAMkxPSDdOn0qbEMlH0UZsKQ=;
 b=jMxSIxS6ABX/u5Qz1QZ9l4cdgXFgKQfGaNk0waUozoGYH1QjoYD8b2j/ph1E/jm8yk
 /LnqHkwuJrm4q7ma8/vgt/cXcUbg7EVv2IJkjg9I4mklLihkxSAKkYUWArtKutcYASJB
 dYVnk7VK12PM5PV7I/ePBvved2KAucwrSvvSlboXr3TuXya1Vmoht62BZyEsORaWrgz6
 PSz9Q6QGvbOEta/BeIKvSDdmG0+kfpk2hZKeIXKjDzILOYCFCS2hbSb03aQ+rI4ywgTs
 xItjbC7yrtPOYXI1Zv4St3R3xeH24J0s+wnXsRsZ8xwierscxUnNOCO0kX1Q+MLcjbMP
 DnPQ==
X-Gm-Message-State: AOJu0Yz8KxRymZmRgmWLB4hjRl2pyWGKlOw4xox7d/kN3IsN5MORwTlF
 rUBL3uyKhp+XjjKN46KNDm/L1FYcuISKu2bnUAO44+6X2cpHrpe0TylBnoUHhFXRxbtI2XIgnKJ
 E
X-Google-Smtp-Source: AGHT+IHpB2+n497jIlPvx10TI0NE7dsSmrPSpGmmFp7eRvDh3nkPtqNgqu5sz1hnS1SKgPgD5v6kFQ==
X-Received: by 2002:adf:cf07:0:b0:364:7de:d70 with SMTP id
 ffacd0b85a97d-36407de0dcamr3573694f8f.29.1718913005599; 
 Thu, 20 Jun 2024 12:50:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-361bdd955f2sm7879598f8f.17.2024.06.20.12.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:50:05 -0700 (PDT)
Message-ID: <d1fb28b8-15a4-401f-933b-2388af390bd8@linaro.org>
Date: Thu, 20 Jun 2024 21:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 65/76] hw/mips/loongson3_virt: Wire up loongson_ipi device
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20240618160039.36108-1-philmd@linaro.org>
 <20240618160039.36108-66-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618160039.36108-66-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Jiaxun,

On 18/6/24 18:00, Philippe Mathieu-Daudé wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Wire up loongson_ipi device for loongson3_virt machine, so we
> can have SMP support for TCG backend as well.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_bootp.h |  3 +++
>   hw/mips/loongson3_bootp.c |  2 --
>   hw/mips/loongson3_virt.c  | 39 +++++++++++++++++++++++++++++++++++++--
>   hw/mips/Kconfig           |  1 +
>   4 files changed, 41 insertions(+), 4 deletions(-)


> diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
> index 03a10b63c1..b97b81903b 100644
> --- a/hw/mips/loongson3_bootp.c
> +++ b/hw/mips/loongson3_bootp.c
> @@ -25,8 +25,6 @@
>   #include "hw/boards.h"
>   #include "hw/mips/loongson3_bootp.h"
>   
> -#define LOONGSON3_CORE_PER_NODE 4
> -
>   static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
>   {
>       struct efi_cpuinfo_loongson *c = g_cpuinfo;
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 440268a074..4ad36f0c5b 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -36,6 +36,7 @@
>   #include "hw/mips/loongson3_bootp.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/intc/i8259.h"
> +#include "hw/intc/loongson_ipi.h"
>   #include "hw/loader.h"
>   #include "hw/isa/superio.h"
>   #include "hw/pci/msi.h"
> @@ -74,6 +75,7 @@ const MemMapEntry virt_memmap[] = {
>       [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
>       [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
>       [VIRT_UART] =        { 0x1fe001e0,           0x8 },
> +    [VIRT_IPI] =         { 0x3ff01000,         0x400 },
>       [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
>       [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
>       [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
> @@ -485,6 +487,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       Clock *cpuclk;
>       CPUMIPSState *env;
>       DeviceState *liointc;
> +    DeviceState *ipi = NULL;
>       char *filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *kernel_filename = machine->kernel_filename;
> @@ -494,6 +497,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       MemoryRegion *ram = g_new(MemoryRegion, 1);
>       MemoryRegion *bios = g_new(MemoryRegion, 1);
>       MemoryRegion *iomem = g_new(MemoryRegion, 1);
> +    MemoryRegion *iocsr = g_new(MemoryRegion, 1);
>   
>       /* TODO: TCG will support all CPU types */
>       if (!kvm_enabled()) {
> @@ -527,6 +531,19 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
>       create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
>   
> +    memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
> +
> +    /* IPI controller is in kernel for KVM */
> +    if (!kvm_enabled()) {
> +        ipi = qdev_new(TYPE_LOONGSON_IPI);
> +        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> +        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
> +        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
> +    }
> +
>       liointc = qdev_new("loongson.liointc");
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
>   
> @@ -543,6 +560,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>   
>       for (i = 0; i < machine->smp.cpus; i++) {
> +        int node = i / LOONGSON3_CORE_PER_NODE;
> +        int core = i % LOONGSON3_CORE_PER_NODE;
>           int ip;
>   
>           /* init CPUs */
> @@ -553,12 +572,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           cpu_mips_clock_init(cpu);
>           qemu_register_reset(main_cpu_reset, cpu);
>   
> -        if (i >= 4) {
> +        if (ipi) {

Coverity mentions a  Null pointer dereference (REVERSE_INULL) here
(CID 1547264):

   Null-checking "ipi" suggests that it may be null, but it has
   already been dereferenced on all paths leading to the check.

Maybe this silences it:

  -        if (ipi) {
  +        if (!kvm_enabled()) {

Still I'd rather using tcg_enabled() in this file.

Do you mind posting a patch fixing it?

> +            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
> +            base += core * 0x100;
> +            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
> +            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
> +        }
> +
> +        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
> +            MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);
> +            g_autofree char *name = g_strdup_printf("core%d_iocsr", i);
> +            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
> +                                     iocsr, 0, UINT32_MAX);
> +            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
> +                                        0, core_iocsr);
> +        }
> +
> +        if (node > 0) {
>               continue; /* Only node-0 can be connected to LIOINTC */
>           }
>   
>           for (ip = 0; ip < 4 ; ip++) {
> -            int pin = i * 4 + ip;
> +            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
>               sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>                                  pin, cpu->env.irq[ip + 2]);
>           }

