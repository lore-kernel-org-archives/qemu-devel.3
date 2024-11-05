Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF81D2B92D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8K55-0007iu-6g; Tue, 05 Nov 2024 08:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8K53-0007ia-B6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8K51-0002FO-2O
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730815125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9PjLir2uZnLPCMvMRdKL4jAsQ5rRGxJdY+62ie9guQ=;
 b=bZywNPJnOOh4raf879TaPdDUF0zpQLZW5vv7nXAOSOrc5EiPDGJoLeTLGhBpdwJIdDNQrx
 Zv1QQDfGNm4MwuDjEVJhV8xGpa2ik6s68Jx0RzXscBcboUn3qr03RSYV5PDk6X3qztBgRw
 AA72ICCZrVlSI3Poi6hmvqA2bJaHJOM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-WiXN83CKPm2ua1zs5Kd1UA-1; Tue, 05 Nov 2024 08:58:43 -0500
X-MC-Unique: WiXN83CKPm2ua1zs5Kd1UA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so4033758f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730815120; x=1731419920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9PjLir2uZnLPCMvMRdKL4jAsQ5rRGxJdY+62ie9guQ=;
 b=IsdnY5w5yuO43FJXKQjsiIffjtSeo9yioO3q7zhSehiNRPhKKzJztqD4eS5bBi2aGe
 CUeetxHyNRpyf4R0FuVb4FJbObXg/OConwhWHOdokrkeOS2/kIigAxsEeUIfY0sWF8ln
 sB9nTzlthddAWafjAlJeaLdpFdt4ljCL6+EV8fpXA7Ot7Exne9qO9fvpyX3dkycnLth8
 HcwTK9ZBJYei1DlMRMAPURtchL6yzuF7jP8L6wnHiMDIa5MpuNiOCLdn3AUeaN5nlUmR
 HFv0CWb572ib1c1nyx4Ea8SiLMTgiwaD7QVBifLelNRliH3EsrOHIOaaXL/2ezOhm3kK
 AUBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJ9OLnEqAjFZlqPga4vyPaR/97xRTZLXf38BFgZNgrZ2k4JoTY0N/KLeZ50j315lWzlxBRV+EzKLw@nongnu.org
X-Gm-Message-State: AOJu0YzGyLAMvft/6Poesc7OJEjdFhi/ekhwef2alnaFLojKVg6xcQGq
 PPcybCsmF+XtSBKOiSK00BkmeFl0Xcbmeq4hU3hrQod8c8zGb/vJDaG7PLcOCVlUHBfZNR9J9jA
 S3+DcLnQsyIFlT7HHIP38UzpfgY8bdhRcKm44bMb9CsMhm9kz4tfU52DTyXbR
X-Received: by 2002:a5d:5888:0:b0:37d:3f81:153f with SMTP id
 ffacd0b85a97d-381c149f226mr18140435f8f.17.1730815120372; 
 Tue, 05 Nov 2024 05:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu19HLuUwux73zYNQOY2PgK6AmspADo7YAB9mbkVRU3AaMlGHBH/UYKYycyAmypmPsKtINcg==
X-Received: by 2002:a5d:5888:0:b0:37d:3f81:153f with SMTP id
 ffacd0b85a97d-381c149f226mr18140412f8f.17.1730815120000; 
 Tue, 05 Nov 2024 05:58:40 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7449sm16339597f8f.49.2024.11.05.05.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 05:58:39 -0800 (PST)
Date: Tue, 5 Nov 2024 14:58:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 5/5] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
Message-ID: <20241105145837.3c10b922@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241104063435.4130262-6-maobibo@loongson.cn>
References: <20241104063435.4130262-1-maobibo@loongson.cn>
 <20241104063435.4130262-6-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Mon,  4 Nov 2024 14:34:35 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
> hot-added CPUs after power on, interrupt pin of extioi and ipi interrupt
> controller need connect to pins of new CPU.
> 
> Also change num-cpu property of extioi and ipi from smp.cpus to
> smp.max_cpus
> 
> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c         | 57 +++++++++++++++++++++++++++++++++----
>  include/hw/loongarch/virt.h |  2 ++
>  2 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e73f689c83..6673493109 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -891,8 +891,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>  
>      /* Create IPI device */
>      ipi = qdev_new(TYPE_LOONGARCH_IPI);
> -    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
> +    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> +    lvms->ipi = ipi;
>  
>      /* IPI iocsr memory region */
>      memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
> @@ -905,11 +906,12 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>  
>      /* Create EXTIOI device */
>      extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> +    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
>      if (virt_is_veiointc_enabled(lvms)) {
>          qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>      }
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> +    lvms->extioi = extioi;
>      memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
>                      sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
>      if (virt_is_veiointc_enabled(lvms)) {
> @@ -1403,8 +1405,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       }
>  
>      if (cpu->phy_id == UNSET_PHY_ID) {
> -        error_setg(&local_err, "CPU hotplug not supported");
> -        goto out;
> +        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> +            error_setg(&local_err,
> +                       "Invalid thread-id %u specified, must be in range 1:%u",
> +                       cpu->thread_id, ms->smp.threads - 1);
> +            goto out;
> +        }
> +
> +        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
> +            error_setg(&local_err,
> +                       "Invalid core-id %u specified, must be in range 1:%u",
> +                       cpu->core_id, ms->smp.cores - 1);
> +            goto out;
> +        }
> +
> +        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> +            error_setg(&local_err,
> +                       "Invalid socket-id %u specified, must be in range 1:%u",
> +                       cpu->socket_id, ms->smp.sockets - 1);
> +            goto out;
> +        }
> +
> +        topo.socket_id = cpu->socket_id;
> +        topo.core_id = cpu->core_id;
> +        topo.thread_id = cpu->thread_id;
> +        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
> +        if (CPU(cpu_slot->cpu)) {
> +            error_setg(&local_err,
> +                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
> +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
> +                       cpu->thread_id, cpu_slot->arch_id);
> +            goto out;
> +        }
> +        cpu->phy_id = arch_id;
>      } else {
>          /*
>           * For cold-add cpu, topo property is not set. And only physical id
> @@ -1484,10 +1518,22 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>                                  DeviceState *dev, Error **errp)
>  {
>      CPUArchId *cpu_slot;
> +    Error *local_err = NULL;
>      LoongArchCPU *cpu = LOONGARCH_CPU(dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>  
> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
> +    if (lvms->acpi_ged) {
> +        /* Connect irq to cpu, including ipi and extioi irqchip */

> +        virt_init_cpu_irq(ms, CPU(cpu));

why it depends on GED?
Can't you just call it unconditionally here for both hotplugged and coldplugged CPUs?
/and drop this call from for() loop of coldplug CPUs/

> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
> +    cpu_slot = virt_find_cpu_slot(ms, cpu->phy_id, NULL);
>      cpu_slot->cpu = CPU(dev);
>      return;
>  }
> @@ -1671,6 +1717,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>      mc->numa_mem_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->auto_enable_numa_with_memdev = true;
> +    mc->has_hotpluggable_cpus = true;
>      mc->get_hotplug_handler = virt_get_hotplug_handler;
>      mc->default_nic = "virtio-net-pci";
>      hc->plug = virt_device_plug_cb;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 861034d614..79a85723c9 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -61,6 +61,8 @@ struct LoongArchVirtMachineState {
>      MemoryRegion iocsr_mem;
>      AddressSpace as_iocsr;
>      struct loongarch_boot_info bootinfo;
> +    DeviceState *ipi;
> +    DeviceState *extioi;
>  };
>  
>  #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")


