Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D1D1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 00:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t87Vp-0001k5-00; Mon, 04 Nov 2024 19:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t87Vm-0001je-HC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t87Vk-0007ur-9a
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730766811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8xFmH8UJN8b0VX2UnKbE8j74yN2twaQ/6rPHnaBTwk=;
 b=aPEGY7/d4nrBRj/gx/gmBgRoi2xj3tuSYQqQEkZw/J2aQ3xh3cDr4uqcTStHY/sRMfJNem
 mdJZ6zfel8Sj5XPB/zv5WMsiHjjMsfRkYmwixLFSgfVGLOeBsvhkt/PS4Dsdenu9jNGwgG
 fC7PIxrICQLuFBb7w56jXwHGDjYy4fM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-53fS7k-oOVO-Mhl4-MpdgA-1; Mon, 04 Nov 2024 19:33:28 -0500
X-MC-Unique: 53fS7k-oOVO-Mhl4-MpdgA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-20cc1fddb87so49262065ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 16:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730766808; x=1731371608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8xFmH8UJN8b0VX2UnKbE8j74yN2twaQ/6rPHnaBTwk=;
 b=ootHbiOOUsekwpeWYV8gbJG5mqgS8MizM2Kg7A7ONGqgubniHFuB4UyG3B9sKWob/8
 LtyN6bDzLBPhIl28GPbO6Y292DShc9vLmx86CoOcskBc/cqXJBqawLAGb20/RNGtq9un
 MzAR3PygkKhqlCinPeuHjvbtZqqzf5TtKEXxgmMMVQ6233NB3yv4xSEyPJPLCv0WZJbW
 NjfJNj5oLIfxdadrHbqysv6NjRK8gwOQLY/1CntR2nr3W4C4GTqrwoWJ0cLW9vejJR1K
 6Jnv0d7szkagEDBPN7kSAvXet/4hI2E6CUYMxYpjtYWuelXb7ehWCGn4Iay1UdNun0TH
 Fwlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+c629t399WFeioa0A/IwbPkq78aBr16hv3dl6HpowCS0WhyCeIWxbO+aZkFRo5tl2UgvzsOeDQt1r@nongnu.org
X-Gm-Message-State: AOJu0Yw2140dGgD55rGpgABs0HcQIapYVG9Q+rrXG/XUPHLv39k4DY5q
 6od7QhZNIRWfawYHURCOQdeLw0GlDs1uX4iFoB0CQeo+i8ncUtbtID0YMvOoxjejTB99XzPPg68
 K7AP3nIfgff+MvjD2PO3cpGZ8kew7DETsllNAy1XiaQx9lEVs8h7/
X-Received: by 2002:a17:902:ecc5:b0:20e:552c:53ee with SMTP id
 d9443c01a7336-21103b04ec4mr242140355ad.24.1730766807804; 
 Mon, 04 Nov 2024 16:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX+7cv1aZ7k3LRdQsKhcQYYG/UL2K2q3Bt7w2z2msJFlYbz4mZAbKca+D/U/1caWF0pV2svQ==
X-Received: by 2002:a17:902:ecc5:b0:20e:552c:53ee with SMTP id
 d9443c01a7336-21103b04ec4mr242139715ad.24.1730766807293; 
 Mon, 04 Nov 2024 16:33:27 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057c1608sm66684265ad.228.2024.11.04.16.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 16:33:26 -0800 (PST)
Message-ID: <1ad74261-c8db-4689-a7a9-83cd95d126b2@redhat.com>
Date: Tue, 5 Nov 2024 10:33:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: jonathan.cameron@huawei.com, alex.bennee@linaro.org, imammedo@redhat.com, 
 pbonzini@redhat.com, maz@kernel.org, will@kernel.org,
 oliver.upton@linux.dev, jean-philippe@linaro.org, lpieralisi@kernel.org,
 david@redhat.com, philmd@linaro.org, andrew.jones@linux.dev,
 eric.auger@redhat.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com,
 gustavo.romero@linaro.org
References: <20241103152455.202462-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241103152455.202462-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/4/24 1:24 AM, Salil Mehta wrote:
> Extract common GIC and CPU interrupt wiring code to improve code
> readability and modularity, supporting reuse in future patch sets. This
> refactor is benign and introduces *no* functional changes.
> 
> Note: This patch has been isolated from a larger patch set to facilitate
> early merging and reduce the complexity of the original set, as it
> operates independently. All original tags and author contributions are
> retained.
> 
> [!] Please note, this is a purely cosmetic change. No functional change.
> 
> Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> [4/05/2024: Issue with total number of PPI available during create GIC]
> Suggested-by: Miguel Luis <miguel.luis@oracle.com>
> [5/05/2024: Fix the total number of PPIs available as per ARM BSA to avoid overflow]
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 108 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 60 insertions(+), 48 deletions(-)
> 

With the following nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a0d3bef875..d6892b0266 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -761,6 +761,65 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
>              (vms->gic_version != VIRT_GIC_VERSION_2);
>   }
>   
> +/*
> + * Mapping from the output timer irq lines from the CPU to the GIC PPI inputs
> + * we use for the virt board.
> + */
> +const int timer_irq[] = {
> +    [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +    [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +    [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +    [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> +    [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
> +};
> +

'static' is needed at least since it's a file-scoped array.

> +static void wire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
> +{
> +    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +    unsigned int smp_cpus = MACHINE(vms)->smp.cpus;
> +    DeviceState *cpudev = DEVICE(cs);
> +    int i = CPU(cs)->cpu_index;
> +    int intidbase, irqn;
> +
> +    intidbase = NUM_IRQS + i * GIC_INTERNAL;
> +

The function name wire_gic_cpu_irqs() looks not standard enough. How about to
rename it to virt_set_cpu_irqs(), or virt_connect_cpu_irqs() since we already
had virt_set_cpu_properties()? The subject and changelog need to be adjusted
accordingly.

Lets make some of the variant's names a bit meaningful, and CPU() isn't needed
since @cs is already CPUState?

     int index = cs->cpu_index;
     int n, intidbase = NUM_IRQS + i * GIC_INTERNAL;

> +    for (irqn = 0; irqn < ARRAY_SIZE(timer_irq); irqn++) {
> +        qdev_connect_gpio_out(cpudev, irqn,
> +                              qdev_get_gpio_in(vms->gic,
> +                                               intidbase + timer_irq[irqn]));
> +    }
> +
> +
> +    if (vms->gic_version != VIRT_GIC_VERSION_2) {
> +        qemu_irq irq = qdev_get_gpio_in(vms->gic,
> +                                        intidbase + ARCH_GIC_MAINT_IRQ);
> +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
> +                                    0, irq);
> +    } else if (vms->virt) {
> +        qemu_irq irq = qdev_get_gpio_in(vms->gic,
> +                                        intidbase + ARCH_GIC_MAINT_IRQ);
> +        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
> +    }
> +
> +    qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> +                                qdev_get_gpio_in(vms->gic, intidbase
> +                                                  + VIRTUAL_PMU_IRQ));
> +
> +    sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +    sysbus_connect_irq(gicbusdev, i + smp_cpus,
> +                       qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +    sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
> +                       qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +    sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
> +                       qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +    if (vms->gic_version != VIRT_GIC_VERSION_2) {
> +        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
> +        sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
> +    }
> +}
> +
>   static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>   {
>       MachineState *ms = MACHINE(vms);
> @@ -862,54 +921,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>        * CPU's inputs.
>        */
>       for (i = 0; i < smp_cpus; i++) {
> -        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> -        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
> -        /* Mapping from the output timer irq lines from the CPU to the
> -         * GIC PPI inputs we use for the virt board.
> -         */
> -        const int timer_irq[] = {
> -            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> -            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> -            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> -            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> -            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
> -        };
> -
> -        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> -            qdev_connect_gpio_out(cpudev, irq,
> -                                  qdev_get_gpio_in(vms->gic,
> -                                                   intidbase + timer_irq[irq]));
> -        }
> -
> -        if (vms->gic_version != VIRT_GIC_VERSION_2) {
> -            qemu_irq irq = qdev_get_gpio_in(vms->gic,
> -                                            intidbase + ARCH_GIC_MAINT_IRQ);
> -            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
> -                                        0, irq);
> -        } else if (vms->virt) {
> -            qemu_irq irq = qdev_get_gpio_in(vms->gic,
> -                                            intidbase + ARCH_GIC_MAINT_IRQ);
> -            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
> -        }
> -
> -        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> -                                    qdev_get_gpio_in(vms->gic, intidbase
> -                                                     + VIRTUAL_PMU_IRQ));
> -
> -        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> -        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> -        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> -        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
> -                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> -
> -        if (vms->gic_version != VIRT_GIC_VERSION_2) {
> -            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
> -                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
> -            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
> -                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
> -        }
> +        wire_gic_cpu_irqs(vms, qemu_get_cpu(i));
>       }
>   
>       fdt_add_gic_node(vms);

Thanks,
Gavin


