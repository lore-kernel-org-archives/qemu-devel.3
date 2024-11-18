Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DDCD591A3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4r0-0006yZ-1t; Mon, 18 Nov 2024 11:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD4qx-0006yP-VO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD4qv-0006Tx-GE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731948231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTofHqPJ8HIB8ldhKv8zMhl/Tm+3DOezoYK+Pk8J7QE=;
 b=CBzchgUNvW9dDv4Eo9h0+wdR1DBau58dtyJAPyOIHITOoqcopQr8LW+xihaCnNHyIl6PyU
 OiqJARXAAIDUJ1AfwhuoGvMnQJMy2AfudJCDHjaJ7dToHcv8YpRHl2Cboi1r9Spac/z3FE
 JjCpgkyQqSq+Wfb8CpqazZGodW6SYUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54--NvaYZ5WM6aDs01UidrV5Q-1; Mon, 18 Nov 2024 11:43:49 -0500
X-MC-Unique: -NvaYZ5WM6aDs01UidrV5Q-1
X-Mimecast-MFC-AGG-ID: -NvaYZ5WM6aDs01UidrV5Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so24116375e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731948227; x=1732553027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTofHqPJ8HIB8ldhKv8zMhl/Tm+3DOezoYK+Pk8J7QE=;
 b=lunPBkIwPAAWLkOwFBPbfuJVCzyHs+/JDsrJn1GZ5k09Qt4wT5eJ7LC4nTCttUQ1I9
 ZsFAw0LLLWzm2/VBa/7qpuYW8bq3ECQ8QWQON6L4oMJoU3ePN1Kp67ChswHsCOCKP8c7
 nrDXIvFXA/8RQLZUaV+igSfTl1LOvvqibGEqD8GZgw1gTDF/CpjztSeSJSff85mF8uYd
 AX3zOM2tD7ig0BzhV3w4wXoLr0+th6UTsHXI5+amJysmweL9q8YkwW0c5s3mCZtnblCa
 uPKbYRgOocNzGEobnJ1x7SEw6c9D/U/omkpCZlzIVrGB9r4SSljOrGYsfRMOQfjYz/qA
 Slow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsNttt0i25EYJHH8tmscmXFeQC52nof4EYFYhLPSiaSgAbCPTEskz2Z/iyVOc0oAeuacHCiXiCMkSD@nongnu.org
X-Gm-Message-State: AOJu0YxerDIsRCndDaaaCYQKhRzKsW9/9qBbMH6wakxjZ2cvKDDwGNGi
 gR4hc+dQedjCtzGifYm+Ti1JSKv2YXda6DUsWSApTy+eQmqzmQx4i40MxZRUw2Gi/Tuqu1qxiJ4
 GSAM114L/RbIu5JGc9wxRcV4n5y55XCCOpC3rVs4a7yieuuCzkdbqOtCyLG7Q
X-Received: by 2002:a05:600c:1911:b0:432:d797:4071 with SMTP id
 5b1f17b1804b1-432df790785mr95135515e9.32.1731948227625; 
 Mon, 18 Nov 2024 08:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpofT01CNDuorq8xB5mhsMM9OySOE4WWgdPLIon/DtID1yI/+Hzwnh9mjlXIRr8vZxytXPpw==
X-Received: by 2002:a05:600c:1911:b0:432:d797:4071 with SMTP id
 5b1f17b1804b1-432df790785mr95135325e9.32.1731948227232; 
 Mon, 18 Nov 2024 08:43:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab788e1sm160340815e9.15.2024.11.18.08.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 08:43:46 -0800 (PST)
Date: Mon, 18 Nov 2024 17:43:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/6] hw/loongarch/virt: Add generic function to init
 interrupt pin of CPU
Message-ID: <20241118174346.23b6d2ee@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241112021738.1952851-4-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-4-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 12 Nov 2024 10:17:35 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Here generic function virt_init_cpu_irq() is added to init interrupt
> pin of CPU object, IPI and extioi interrupt controllers are connected
> to interrupt pin of CPU object.
> 
> The generic function can be used to both cold-plug and hot-plug CPUs.

this patch is heavily depends on cpu_index and specific order CPUs
are created.

> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c         | 78 ++++++++++++++++++++++++-------------
>  include/hw/loongarch/virt.h |  2 +
>  2 files changed, 53 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b6b616d278..621380e2b3 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -58,6 +58,20 @@ static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>      return true;
>  }
>  
> +static CPUState *virt_get_cpu(MachineState *ms, int index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus;
> +
> +    /* Init CPUs */
> +    possible_cpus = mc->possible_cpu_arch_ids(ms);
> +    if (index < 0 || index >= possible_cpus->len) {
> +        return NULL;
> +    }
> +
> +    return possible_cpus->cpus[index].cpu;
> +}

instead of adding this helper I'd suggest to try reusing
virt_find_cpu_slot() added in previous patch.

> +
>  static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -365,7 +379,7 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
>  static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>  {
>      int num;
> -    const MachineState *ms = MACHINE(lvms);
> +    MachineState *ms = MACHINE(lvms);
>      int smp_cpus = ms->smp.cpus;
>  
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
> @@ -375,7 +389,7 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
>      /* cpu nodes */
>      for (num = smp_cpus - 1; num >= 0; num--) {

loops based on smp_cpus become broken as soon as you have
 '-smp x, -device your-cpu,...
since it doesn't take in account '-device' created CPUs.
You likely need to replace such loops to iterate over possible_cpus
(in a separate patch please)
  
>          char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
> -        LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
> +        LoongArchCPU *cpu = LOONGARCH_CPU(virt_get_cpu(ms, num));
>          CPUState *cs = CPU(cpu);
>  
>          qemu_fdt_add_subnode(ms->fdt, nodename);
> @@ -783,16 +797,42 @@ static void virt_devices_init(DeviceState *pch_pic,
>      lvms->platform_bus_dev = create_platform_bus(pch_pic);
>  }
>  
> +static void virt_init_cpu_irq(MachineState *ms, CPUState *cs)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env;
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> +    int pin;
> +
> +    if (!lvms->ipi || !lvms->extioi) {
> +        return;
> +    }
> +
> +    env = &(cpu->env);
> +    env->address_space_iocsr = &lvms->as_iocsr;
> +    env->ipistate = lvms->ipi;
> +    /* connect ipi irq to cpu irq, logic cpu index used here */
> +    qdev_connect_gpio_out(lvms->ipi, cs->cpu_index,
I'd try to avoid using cpu_index (basically internal CPU detail) when
wiring components together. It would be better to implement this the way
the real hw does it.


> +                              qdev_get_gpio_in(DEVICE(cs), IRQ_IPI));
> +
> +    /*
> +     * connect ext irq to the cpu irq
> +     * cpu_pin[9:2] <= intc_pin[7:0]
> +     */
> +    for (pin = 0; pin < LS3A_INTC_IP; pin++) {
> +        qdev_connect_gpio_out(lvms->extioi, cs->cpu_index * LS3A_INTC_IP + pin,
> +                              qdev_get_gpio_in(DEVICE(cs), pin + 2));
> +    }
> +}
> +
>  static void virt_irq_init(LoongArchVirtMachineState *lvms)
>  {
>      MachineState *ms = MACHINE(lvms);
> -    DeviceState *pch_pic, *pch_msi, *cpudev;
> +    DeviceState *pch_pic, *pch_msi;
>      DeviceState *ipi, *extioi;
>      SysBusDevice *d;
> -    LoongArchCPU *lacpu;
> -    CPULoongArchState *env;
>      CPUState *cpu_state;
> -    int cpu, pin, i, start, num;
> +    int cpu, i, start, num;
>      uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
>  
>      /*
> @@ -843,6 +883,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>      ipi = qdev_new(TYPE_LOONGARCH_IPI);
>      qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> +    lvms->ipi = ipi;
>  
>      /* IPI iocsr memory region */
>      memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
> @@ -853,18 +894,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>      /* Add cpu interrupt-controller */
>      fdt_add_cpuic_node(lvms, &cpuintc_phandle);
>  
> -    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        cpu_state = qemu_get_cpu(cpu);
> -        cpudev = DEVICE(cpu_state);
> -        lacpu = LOONGARCH_CPU(cpu_state);
> -        env = &(lacpu->env);
> -        env->address_space_iocsr = &lvms->as_iocsr;
> -
> -        /* connect ipi irq to cpu irq */
> -        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
> -        env->ipistate = ipi;
> -    }
> -
>      /* Create EXTIOI device */
>      extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
>      qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> @@ -872,6 +901,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>          qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>      }
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> +    lvms->extioi = extioi;
>      memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
>                      sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
>      if (virt_is_veiointc_enabled(lvms)) {
> @@ -879,16 +909,10 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>                      sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
>      }
>  
> -    /*
> -     * connect ext irq to the cpu irq
> -     * cpu_pin[9:2] <= intc_pin[7:0]
> -     */
> +    /* Connect irq to cpu, including ipi and extioi irqchip */
>      for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        cpudev = DEVICE(qemu_get_cpu(cpu));
> -        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
> -            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
> -                                  qdev_get_gpio_in(cpudev, pin + 2));
> -        }
> +        cpu_state = virt_get_cpu(ms, cpu);
> +        virt_init_cpu_irq(ms, cpu_state);
>      }
>  
>      /* Add Extend I/O Interrupt Controller node */
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 9ba47793ef..260e6bd7cf 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -60,6 +60,8 @@ struct LoongArchVirtMachineState {
>      MemoryRegion iocsr_mem;
>      AddressSpace as_iocsr;
>      struct loongarch_boot_info bootinfo;
> +    DeviceState *ipi;
> +    DeviceState *extioi;
>  };
>  
>  #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")


