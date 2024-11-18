Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103ABD591A3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD59l-0003Tu-2F; Mon, 18 Nov 2024 12:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD59k-0003TV-14
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD59h-0000O9-EM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731949394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6grmDEqfnmZgcf/oAt419w9M/oZkefmG2bMOe8rpv8=;
 b=LUguq2onvl8yjRNehiIRjfOSamfpiyAsp1ff49dzSDO1lfzz+4eli0BdAShu9YixM2HRzi
 CpJx0BZDg+yk/wYK4OE6XnlQP6ZJ3WZKBsv8m4zkfEd2dR2y/LMhGtFJfc8U9q4Acs9l7L
 MlA8Z+yhweV3baxKZjrXVcGBUxZgKX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-Jz519pzxP7KCK4qnfMmlow-1; Mon, 18 Nov 2024 12:03:11 -0500
X-MC-Unique: Jz519pzxP7KCK4qnfMmlow-1
X-Mimecast-MFC-AGG-ID: Jz519pzxP7KCK4qnfMmlow
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so21775115e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731949390; x=1732554190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6grmDEqfnmZgcf/oAt419w9M/oZkefmG2bMOe8rpv8=;
 b=gCuPccyZyFr3U5ISjuz6APh+/9MA0pTCh22/jp360OliyRsB/dAu+KjHkexpdZVgq6
 FfLkPypDfmZid4DOZ//cJtIbrrBc+LGLl5BLBD7imDqowMjjVJVuqtXCdpvrY48RBiCL
 05oumelqiZS1k6dpcSfoqGf3pBsTQZjkfDWprBQ3+VHBQJfkE55LiGyuJ5rnmTh4Prak
 a+2Pw7VUdw5UexTgJaLAZci6Xqpkki62CXJ/oVXsKpjA3fZciqoNQk4MxWoVgOh67Dgy
 HNIxHFRNs1rqbUeOHAEBWBievtzJ8viekJPnq/OSfENzCSgX30Sp7yahQ9b/Tw7rjaAg
 dSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0ruDzc9fbCsMZYIdxw3TfJHoR9Gnvh5wCItZzepAjd2xEMnHSEa+0oD4qhJ0ChGR5zOb28MtSkp3O@nongnu.org
X-Gm-Message-State: AOJu0Yxd+OVUTHQx4/asWTumRaT0rqMKYbCZ1+Dkc6ApkjnHkQdx+Ozl
 LRvigHkUY04fPkw7rrs3KHrbuE3AZ9kKCTVYPaap/j/B59pKmYOUgkIaR09FB6sUPGN7Ta8Bo6n
 Q/bLkHMfuiYtwnQK9KizcWaSZqgPCJ+fhM0IqDYZB7uApWYZEgRtV
X-Received: by 2002:a05:600c:510b:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-432df72c886mr115267835e9.9.1731949390113; 
 Mon, 18 Nov 2024 09:03:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDStCSg7u6P+qwkt3PQOV8Vbd68EEddRdXpM7Ml1dGbaYJ4s5dUXJfKsq+4iywNhZ7bZloxA==
X-Received: by 2002:a05:600c:510b:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-432df72c886mr115265505e9.9.1731949388141; 
 Mon, 18 Nov 2024 09:03:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b76fsm169417905e9.28.2024.11.18.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:03:07 -0800 (PST)
Date: Mon, 18 Nov 2024 18:03:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 6/6] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
Message-ID: <20241118180306.6b8019c4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241112021738.1952851-7-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-7-maobibo@loongson.cn>
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

On Tue, 12 Nov 2024 10:17:38 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
> hot-added CPUs, there is socket-id/core-id/thread-id property set,
> arch_id can be caculated from these properties. So that cpu slot can be
> searched from its arch_id.
> 
> Also change num-cpu property of extioi and ipi from smp.cpus to
> smp.max_cpus
> 
> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/virt.c | 68 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b49b15c0f6..5f81673368 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -890,7 +890,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>  
>      /* Create IPI device */
>      ipi = qdev_new(TYPE_LOONGARCH_IPI);
> -    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
> +    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
>      lvms->ipi = ipi;
>  
> @@ -905,7 +905,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>  
>      /* Create EXTIOI device */
>      extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
> -    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> +    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
>      if (virt_is_veiointc_enabled(lvms)) {
>          qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
>      }
> @@ -1369,11 +1369,15 @@ static void virt_get_topo_from_index(MachineState *ms,
>  }
>  
>  /* Find cpu slot in machine->possible_cpus by arch_id */
> -static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id, int *index)
>  {
>      int n;
>      for (n = 0; n < ms->possible_cpus->len; n++) {
>          if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
> +            if (index) {
> +                *index = n;
> +            }
> +
>              return &ms->possible_cpus->cpus[n];
>          }
>      }
> @@ -1386,10 +1390,12 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  {
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>      MachineState *ms = MACHINE(OBJECT(hotplug_dev));
> +    CPUState *cs = CPU(dev);
>      LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>      CPUArchId *cpu_slot;
>      Error *local_err = NULL;
> -    int arch_id;
> +    LoongArchCPUTopo topo;
> +    int arch_id, index;
>  
>      /* sanity check the cpu */
>      if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> @@ -1408,12 +1414,45 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
> +        cs->cpu_index = index;
this whole branch applies to cold-plugged CPUs as well, especially
if both (hot/cold plugged CPUs are getting wired with help of pre_plug)
So this hunk should be introduced somewhere earlier in series,
and than I'd likely won't need (cpu->phy_id == UNSET_PHY_ID) check to begin with.

the only difference vs cold-plug would be need to call acpi_ged plug handler,
like you are dong below in virt_cpu_plug

>      } else {
>          /* For cold-add cpu, find cpu slot from arch_id */
>          arch_id = cpu->phy_id;
> -        cpu_slot = virt_find_cpu_slot(ms, arch_id);
> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, NULL);
>      }
>  
>      numa_cpu_pre_plug(cpu_slot, dev, &local_err);
> @@ -1468,7 +1507,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
>      cpu_slot->cpu = NULL;
>      return;
>  }
> @@ -1477,14 +1516,24 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>                                  DeviceState *dev, Error **errp)
>  {
>      CPUArchId *cpu_slot;
> +    Error *local_err = NULL;
>      LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>      MachineState *ms = MACHINE(hotplug_dev);
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>  
>      /* Connect irq to cpu, including ipi and extioi irqchip */
>      virt_init_cpu_irq(ms, CPU(cpu));
> -    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> +    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
>      cpu_slot->cpu = CPU(dev);
> +
> +    if (lvms->acpi_ged) {
Why do you need check, can machine be created without acpi_ged?

> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      return;
>  }
>  
> @@ -1667,6 +1716,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
>      mc->numa_mem_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>      mc->auto_enable_numa_with_memdev = true;
> +    mc->has_hotpluggable_cpus = true;
>      mc->get_hotplug_handler = virt_get_hotplug_handler;
>      mc->default_nic = "virtio-net-pci";
>      hc->plug = virt_device_plug_cb;


