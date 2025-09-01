Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D938CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut28k-0003Ud-Jt; Mon, 01 Sep 2025 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut28i-0003UE-LJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:51:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut28g-0000Nw-2z
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:51:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7722ea37so13646285e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756723911; x=1757328711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cmx1rdds1sqZIL+MsUfeUulT98pAMTAAhlMa04/omvo=;
 b=J1Dd85rbFdXFnppCPP4BdXQbKuBpGpZ7iXkqNQ7oe99U+XKVHUZLqN6e016gWLXqiU
 SEKMIaGsKtbyovtvr9EJmHdjn/X3iNsk6zmhOp1F5a7scBQGz1VeSasukL10NJgjHvJQ
 6f680sewHL7TXEqIsh9XgrAIe3DkUod6IntPHuxGnsZdviFilk5N9Fs1FcTNLYylfVpS
 4bxbVtgn84ZfFUFyThvaDIdU54PPY29zM8vUCPBSYdJcum6vQRINSMB+xq2+wRKQA8Jr
 KnGZcQH0I5Z1qeq6ruvWwIQuwJw1BLRdTYeFbtzYlc+qORwyeCgHUas9Oxq6w4FR6Tah
 Vl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756723911; x=1757328711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cmx1rdds1sqZIL+MsUfeUulT98pAMTAAhlMa04/omvo=;
 b=w0Am5m4H7/ziAsbcAi7x6vfAS4JTkJtT5pUDd2Rs2K8zZe4cmxOTco7EPumgIE4HFo
 JZCMHbJe2+8nW6qSfRuSc+vt3Unyn62leLDt7spmeSaowvBZO6l+6Ell+cpa6/1P2eAT
 WPVHUbd5w2jRdizSDdegKpSFv7qKy3qw7z5PVcjWZdObZeu6nySNMytVDdDkz25FXYmS
 H6rPYq+C7w3EGaBPkmvgDCg1B7LH7vYSEqdQqP/8k56ZnnKElU2KPgex8uBerJaf/KBQ
 Dpma53wVTzZFIBYnUqHRS/KbYihMxXVapsD1t4HuOGKVrh+7usmkKwvOoybVuy49Op9Q
 F/iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGTaj1vplhYy7CF2XrhZ2gx65NOCyqLhs8/alcbkDhuo9kdpCsjGy0MzYMyElE5KqoHyTWXMOg+xBg@nongnu.org
X-Gm-Message-State: AOJu0YzdjqseyKpgKdaDZqSbj1dCW3NXrM1rB6bLGzBxceE45ypmra0Y
 wHaAoMO8WvwLY730JkX4ovPtWDvEsQQBoDAheEatU36xeHzVyIlS7bK7zqL8d8AGoWk=
X-Gm-Gg: ASbGnct/JiESWi2SwGkdNoz7VqIN4+LI6jwpoa9uLd2XaR9W38ugTGWTRS6FL1IcYOB
 yU7CAKhAo/mRGb3fsf1yW+NL9VuhurX5pAjrxk9bJ2qPWxbMJQ4Xp16xSs+4s+eDOOpnplgWogH
 P0J8dauWRdTOudrvGim3FtP6Z2jsJ2cnQCkbLm4RBtYNsB0c3cck8x74H5/Axl4Gyt2NhcASLFP
 AtPaKRsG4j4yg0JwZkbH5O812X2hZN0yYkm9Wy961WdkXyWIZy4TfVpnB2Y2x+zewuURNeqCZiv
 HWxrnsEmdoagIO/dIf2BInA6kfSfh1q2B3DtVA5LSN1aPTipuVjyqCDXko/wSe/EU3ONg39VVWB
 YEYpRBuPrTavgq0LrSzVXazxfcpz0hhsZ3IJuDfxx8CP36sMJiwADQGV4VY+YiLjm4oXPzruuKn
 ox
X-Google-Smtp-Source: AGHT+IHkC3AGCylC23C2hvVGk5F/RdftejxdF8ig0qBNXO2NH4fVeiLIPbBdKIbF5qSRKRlf6GMVHQ==
X-Received: by 2002:a05:600c:a45:b0:456:2139:456a with SMTP id
 5b1f17b1804b1-45b85599135mr61749835e9.15.1756723911404; 
 Mon, 01 Sep 2025 03:51:51 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0b9402299sm13862566f8f.18.2025.09.01.03.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 03:51:50 -0700 (PDT)
Message-ID: <e99ce8c4-b2cc-4eba-a947-f150330eda34@linaro.org>
Date: Mon, 1 Sep 2025 12:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/loongarch/virt: Add reset interface for virt-machine
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250901081900.2931303-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901081900.2931303-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Bibo,

On 1/9/25 10:19, Bibo Mao wrote:
> With generic cpu reset interface, pc register is entry of FLASH for
> UEFI BIOS. However with direct kernel booting requirement, there is
> a little different, pc register of primary cpu is entry address of ELF
> file.
> 
> At the same time with requirement of cpu hotplug, hot-added CPU should
> register reset interface for this cpu object. Now reset callback is
> not registered for hot-added CPU.
> 
> With this patch reset callback for CPU is register when CPU instance
> is created, and reset interface is added for virt-machine board. In
> reset interface of virt-machine, reset for direct kernel booting
> requirement is called.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>    1. Add qemu_unregister_reset() in function loongarch_cpu_unrealizefn(),
>       remove reset callback if vCPU is unrealized.
> ---
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c         |  9 +--------
>   hw/loongarch/virt.c         | 14 ++++++++++++++
>   include/hw/loongarch/boot.h |  1 +
>   target/loongarch/cpu.c      | 11 +++++++++++
>   4 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 14d6c52d4e..4919758a20 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -324,12 +324,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       return kernel_entry;
>   }
>   
> -static void reset_load_elf(void *opaque)
> +void reset_load_elf(void *opaque)
>   {
>       LoongArchCPU *cpu = opaque;
>       CPULoongArchState *env = &cpu->env;
>   
> -    cpu_reset(CPU(cpu));
>       if (env->load_elf) {
>           if (cpu == LOONGARCH_CPU(first_cpu)) {
>               env->gpr[4] = env->boot_info->a0;
> @@ -429,12 +428,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> -    int i;
> -
> -    /* register reset function */
> -    for (i = 0; i < ms->smp.cpus; i++) {
> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));

I agree CPU reset shouldn't be part of loading code to memory.

> -    }
>   
>       info->kernel_filename = ms->kernel_filename;
>       info->kernel_cmdline = ms->kernel_cmdline;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b15ada2078..4fc8506c10 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1199,6 +1199,19 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>       }
>   }
>   
> +static void virt_reset(MachineState *machine, ResetType type)
> +{
> +    CPUState *cs;
> +
> +    /* Reset all devices including CPU devices */
> +    qemu_devices_reset(type);
 > +> +    /* Reset PC and register context for kernel direct booting 
method */
> +    CPU_FOREACH(cs) {
> +        reset_load_elf(LOONGARCH_CPU(cs));
> +    }
> +}
> +
>   static void virt_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1223,6 +1236,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>       mc->has_hotpluggable_cpus = true;
>       mc->get_hotplug_handler = virt_get_hotplug_handler;
>       mc->default_nic = "virtio-net-pci";
> +    mc->reset = virt_reset;
>       hc->plug = virt_device_plug_cb;
>       hc->pre_plug = virt_device_pre_plug;
>       hc->unplug_request = virt_device_unplug_request;
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 9819f7fbe3..386b4406ad 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -114,5 +114,6 @@ struct memmap_entry {
>   };
>   
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
> +void reset_load_elf(void *opaque);
>   
>   #endif /* HW_LOONGARCH_BOOT_H */
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 3a7621c0ea..61c8acb3c2 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -652,6 +652,13 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>       info->print_insn = print_insn_loongarch;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void loongarch_cpu_reset_cb(void *opaque)
> +{
> +    cpu_reset((CPUState *) opaque);
> +}
> +#endif
> +
>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> @@ -668,6 +675,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>       qemu_init_vcpu(cs);
>       cpu_reset(cs);

Devices shouldn't call their DeviceReset handler manually, as it is
always called after DeviceRealize.

> +#ifndef CONFIG_USER_ONLY
> +    qemu_register_reset(loongarch_cpu_reset_cb, dev);

qemu_register_reset() is a legacy API, replaced by
qemu_register_resettable().

That said, I don't think the CPU object has to register its own
reset handlers. Instead that should the be responsibility of the
object creating the CPU objects.

> +#endif
>   
>       lacc->parent_realize(dev, errp);
>   }
> @@ -678,6 +688,7 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
>   
>   #ifndef CONFIG_USER_ONLY
>       cpu_remove_sync(CPU(dev));
> +    qemu_unregister_reset(loongarch_cpu_reset_cb, dev);

Ditto, legacy -> qemu_unregister_resettable().

>   #endif
>   
>       lacc->parent_unrealize(dev);
> 
> base-commit: 91589bcd9fee0e66b241d04e5f37cd4f218187a2

