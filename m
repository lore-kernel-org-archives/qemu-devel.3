Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3BEC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnj9-0008LY-Uk; Fri, 31 Jan 2025 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdnj8-0008LQ-5D
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdnj5-0003lT-G6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738317254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1af3kCnsQVg3JPqYTccf9/7n9LejJEJfh8iZBvXx70=;
 b=jC6tVFJ586mvj2mMMlG+nVofgIxeHuGM1TBuAJIDy56CWooPSuqsQjRMu1iOlyI8ms1JV3
 kD/xvjI/YqG0YkjJDI9fQ3sTDC/NChFDcQrOeZJFEX20OppvrRSubTfS2AbHshp5TXy0WP
 UpodP0S6fkviRE3dLbOLRhGdRIdNhwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-8AfMOtiaPmqivTLJKaCH8Q-1; Fri, 31 Jan 2025 04:54:12 -0500
X-MC-Unique: 8AfMOtiaPmqivTLJKaCH8Q-1
X-Mimecast-MFC-AGG-ID: 8AfMOtiaPmqivTLJKaCH8Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43621907030so15068325e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 01:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738317251; x=1738922051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1af3kCnsQVg3JPqYTccf9/7n9LejJEJfh8iZBvXx70=;
 b=Tq0BQh+Pt/7CUzoVhH9EZx8iMXxuWHZKCiL1uOmQKZAGZrV8KatomDZk03I8huy3ap
 UI0yx6lWUPgiNsS95fdc9yOGHAf7ExlJFcKvwd+ATj3AgQITMfINODXwoAjy5QYg4cAx
 S3dLvGuzcOuzdDoOh/JYgFJKwBoA13O7rQaj7eIhYesTzfSCKxZ7HXdsqn5TTnoXss1I
 3PaJ/t725mkor9sQrFwoFauaAWoxWISvRaDF34Vi9cZwaXYs7BFA1AUikwdnVbellTUJ
 JnldyxrBOIL7FciryKcRJ96lv6oTguHm7LsPEZKXoflTnF/U9t/rPjIl4uKiqW7JgErW
 3ExQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8bgTYDFjJbEgEIXlAUdNmWm6kMInofFRevzNF+TMicRCU6TWGM/jFwqCOc+FG8/IGtACU5g1j52qN@nongnu.org
X-Gm-Message-State: AOJu0Yz2An4n8TDCAaUSPK0Uzb59b5NadR+/htKp5OYN9A4gWcssEShn
 c1HGz9EU/ZoquAmFgKKPY2TcCpdcuSobya8mOj4tKYcuAfBUAGrzH6cZZ70sHkGuymE/kChARG6
 M+5zP8Pyje2R2o/wHqy2wPi1wzx2S7XyZyUN3uIyIUX74sRxXnhAA
X-Gm-Gg: ASbGncsfo6BcKs2Wgv9MM6XMAPgpRQgBsqqK7fxNctkqaPO8VWaWsmASa8KjzD7tz55
 OX12r5DJEXlwwJXRy1ujI4x6fPgovSIDkqPfOasSuDpb/3euyQ6fAwwaUmIMVx+B8OC5y6kacXa
 l06wEdQZTp/yFok9zVnErVvHfKlIUgJPZpRYcS6P6xLJreudst/sAt3UB8IuEHqFzxeGgWu6G+T
 SVOD4FefjEyYugVDPqnuYffMlbyioyeIEUsV5UIyjvTSEwKw8eLCfD+VQxq9lZg5hYF5cR1G/nv
 aWVCw7BbJjeb3eNimsRP0gpS+/G4PTnprn4OTd9wQBdzjjg8dlx0
X-Received: by 2002:a05:600c:4753:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-438dc435842mr110056915e9.31.1738317251256; 
 Fri, 31 Jan 2025 01:54:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjyHb98seLyfLB5lriy7trga1JEkRSqyMz2dtdBnNjwTMe+U7huenWA5agIRmnRH2e2rKKYg==
X-Received: by 2002:a05:600c:4753:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-438dc435842mr110056495e9.31.1738317250666; 
 Fri, 31 Jan 2025 01:54:10 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f4a8sm50261575e9.37.2025.01.31.01.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 01:54:10 -0800 (PST)
Date: Fri, 31 Jan 2025 10:54:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <20250131105408.3c7326da@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250128035526.3750043-1-anisinha@redhat.com>
References: <20250128035526.3750043-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 28 Jan 2025 09:25:26 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> introduced 'default_cpu_version' for PCMachineClass. This created three
> categories of CPU models:
>  - Most unversioned CPU models would use version 1 by default.
>  - For machines 4.0.1 and older that do not support cpu model aliases, a
>    special default_cpu_version value of CPU_VERSION_LEGACY is used.
>  - It was thought that future machines would use the latest value of cpu
>    versions corresponding to default_cpu_version value of
>    CPU_VERSION_LATEST [1].
> 
> All pc machines still use the default cpu version of 1 for
> unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
> mean that over a period of time, for the same machine type, the cpu version
> would be different depending on what is latest at that time. This would
> break guests even when they use a versioned machine type. Therefore, for
> pc machines, use of CPU_VERSION_LATEST is not possible. Currently, only
> microvms use CPU_VERSION_LATEST.
> 
> This change cleans up the complicated logic around default_cpu_version
> including getting rid of default_cpu_version property itself. A couple of new
> flags are introduced, one for the legacy model for machines 4.0.1 and older
> and other for microvms. For older machines, a new pc machine property is
> introduced that separates pc machine versions 4.0.1 and older from the newer
> machines. 4.0.1 and older machines are scheduled to be deleted towards
> end of 2025 since they would be 6 years old by then. At that time, we can
> remove all logic around legacy cpus. Microvms are the only machines that
> continue to use the latest cpu version. If this changes later, we can
> remove all logic around x86_cpu_model_last_version(). Default cpu version
> for unversioned cpu models is hardcoded to the value 1 and applies
> unconditionally for all pc machine types of version 4.1 and above.
> 
> This change also removes all complications around CPU_VERSION_AUTO
> including removal of the value itself.
> 
> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> 
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/i386/microvm.c     |  3 +-
>  hw/i386/pc.c          | 14 +++++++++
>  hw/i386/pc_piix.c     |  6 ++--
>  hw/i386/pc_q35.c      |  6 ++--
>  hw/i386/x86-common.c  |  4 +--
>  include/hw/i386/pc.h  |  7 +++--
>  include/hw/i386/x86.h |  2 +-
>  target/i386/cpu.c     | 69 ++++++++++++++++++++++---------------------
>  target/i386/cpu.h     | 21 +++----------
>  9 files changed, 67 insertions(+), 65 deletions(-)
> 
> changelog:
> v2: explain in commit log why use of CPU_VERSION_LATEST for machines
> is problematic.
> v3: fix a bug that broke the pipeline
> https://gitlab.com/mstredhat/qemu/-/pipelines/1626171267
> when cpu versions are explicitly specified in the command line,
> respect that and do not enforce legacy (unversioned) cpu logic.
> The pipeline is green now with the fix:
> https://gitlab.com/anisinha/qemu/-/pipelines/1626783632
> v4: made changes as per Zhao's suggestions.
> Pipeline passes https://gitlab.com/anisinha/qemu/-/pipelines/1635829877
> v5: adjustment of pc_init_cpus() declaration as per Zhao's suggestion. This
> simplifies things and also passes compilation.
> CI still passes https://gitlab.com/anisinha/qemu/-/pipelines/1637657451
> v6: cosmetic commit log correction as suggested by Igor. rebase, added tags.
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index a8d354aabe..ffb1b37fe5 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -458,7 +458,8 @@ static void microvm_machine_state_init(MachineState *machine)
>  
>      microvm_memory_init(mms);
>  
> -    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
> +    x86_cpu_uses_lastest_version();

for microvm, we do not have versioned machines,
hence we are not obliged to keep the same cpu between
different qemu versions.

I'd prefer to follow arm/virt with no default cpu behavior,
but that ship has sailed off already. 

Lets try instead of the latest, use cpu model name as is
(i.e. typically it would be non versioned model) that would keep
existing CLI work.
Ones that want a specific version can use explicit versioned name on CLI.

i.e. remove the notion of CPU_VERSION_LATEST 1st (a separate patch).
if this accepted that would make this patch a bit simpler.

> +    x86_cpus_init(x86ms);
>  
>      microvm_devices_init(mms);
>  }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b46975c8a4..f97a519573 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -30,6 +30,7 @@
>  #include "hw/hyperv/hv-balloon.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/i386/vmport.h"
> +#include "target/i386/cpu.h"
>  #include "system/cpus.h"
>  #include "hw/ide/ide-bus.h"
>  #include "hw/timer/hpet.h"
> @@ -615,6 +616,19 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
>      }
>  }
>  
> +void pc_init_cpus(MachineState *ms)
> +{
I'd not introduce this function, instead add duplicated
call x86_cpu_set_legacy_version() to pc_init1/pc_q35_init,
this way it would be more concise and introduce less code churn

> +    X86MachineState *x86ms = X86_MACHINE(ms);
> +    PCMachineState *pcms = PC_MACHINE(ms);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +
> +    if (pcmc->no_versioned_cpu_model) {
> +        /* use legacy cpu as it does not support versions */
> +        x86_cpu_set_legacy_version();
> +    }
> +    x86_cpus_init(x86ms);
> +}
> +
>  static
>  void pc_machine_done(Notifier *notifier, void *data)
>  {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 04d2957adc..dc684cb011 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -181,7 +181,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>      }
>  
>      pc_machine_init_sgx_epc(pcms);
> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> +
> +    pc_init_cpus(machine);
>  
>      if (kvm_enabled()) {
>          kvmclock_create(pcmc->kvmclock_create_always);
> @@ -457,7 +458,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      ObjectClass *oc = OBJECT_CLASS(m);
>      pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
>      pcmc->pci_root_uid = 0;
> -    pcmc->default_cpu_version = 1;
>  
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
> @@ -669,7 +669,7 @@ static void pc_i440fx_machine_4_0_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_4_1_options(m);
> -    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
> +    pcmc->no_versioned_cpu_model = true;
>      compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 77536dd697..045b05da64 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -187,7 +187,8 @@ static void pc_q35_init(MachineState *machine)
>      }
>  
>      pc_machine_init_sgx_epc(pcms);
> -    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> +
I'd drop newline

> +    pc_init_cpus(machine);
>  
>      if (kvm_enabled()) {
>          kvmclock_create(pcmc->kvmclock_create_always);
> @@ -339,7 +340,6 @@ static void pc_q35_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pcmc->pci_root_uid = 0;
> -    pcmc->default_cpu_version = 1;
>  
>      m->family = "pc_q35";
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
> @@ -547,7 +547,7 @@ static void pc_q35_machine_4_0_1_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_machine_4_1_options(m);
> -    pcmc->default_cpu_version = CPU_VERSION_LEGACY;
> +    pcmc->no_versioned_cpu_model = true;
>      /*
>       * This is the default machine for the 4.0-stable branch. It is basically
>       * a 4.0 that doesn't use split irqchip by default. It MUST hence apply the
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 008496b5b8..1ed5bc6010 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -66,15 +66,13 @@ out:
>      object_unref(cpu);
>  }
>  
> -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> +void x86_cpus_init(X86MachineState *x86ms)
>  {
>      int i;
>      const CPUArchIdList *possible_cpus;
>      MachineState *ms = MACHINE(x86ms);
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>  
> -    x86_cpu_set_default_version(default_cpu_version);
> -
>      /*
>       * Calculates the limit to CPU APIC ID values
>       *
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a558705cb9..563f765d7f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -92,9 +92,6 @@ struct PCMachineClass {
>  
>      /* Compat options: */
>  
> -    /* Default CPU model version.  See x86_cpu_set_default_version(). */
> -    int default_cpu_version;
> -
>      /* ACPI compat: */
>      bool has_acpi_build;
>      int pci_root_uid;
> @@ -125,6 +122,9 @@ struct PCMachineClass {
>       * check for memory.
>       */
>      bool broken_32bit_mem_addr_check;
> +
> +    /* whether the machine supports versioned cpu models */
> +    bool no_versioned_cpu_model;
>  };
>  
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> @@ -136,6 +136,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>  
>  /* pc.c */
>  
> +void pc_init_cpus(MachineState *ms);
>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  
>  #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index d43cb3908e..2d2b987fa1 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -114,7 +114,7 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>                                      unsigned int cpu_index);
>  
> -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> +void x86_cpus_init(X86MachineState *pcms);
>  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
>  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                        DeviceState *dev, Error **errp);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1b9c11022c..c1f868c4dd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -192,6 +192,9 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
>   */
>  #define CACHE_DESCRIPTOR_UNAVAILABLE 0xFF
>  
> +/* default cpu version to use */
> +#define DEFAULT_CPU_VERSION 1
> +
>  /*
>   * Return a CPUID 2 cache descriptor for a given cache.
>   * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABLE
> @@ -5343,20 +5346,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>      },
>  };
>  
> -/*
> - * We resolve CPU model aliases using -v1 when using "-machine
> - * none", but this is just for compatibility while libvirt isn't
> - * adapted to resolve CPU model versions before creating VMs.
> - * See "Runnability guarantee of CPU models" at
> - * docs/about/deprecated.rst.
> - */
> -X86CPUVersion default_cpu_version = 1;
> +static bool use_legacy_cpu;
> +void x86_cpu_set_legacy_version(void)
> +{
> +    use_legacy_cpu = true;
so all the difference between legacy and not legacy, is alias_of
in QMP output.

In that case lets be more specific and name it as such
i.e. something like 'qmp_has_alias'

> +}
>  
> -void x86_cpu_set_default_version(X86CPUVersion version)
> +static bool use_latest_cpu;
> +void x86_cpu_uses_lastest_version(void)
>  {
> -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
> -    assert(version != CPU_VERSION_AUTO);
> -    default_cpu_version = version;
> +    use_latest_cpu = true;
>  }
>  
>  static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
> @@ -5374,14 +5373,11 @@ static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
>  /* Return the actual version being used for a specific CPU model */
>  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>  {
> -    X86CPUVersion v = model->version;
> -    if (v == CPU_VERSION_AUTO) {
> -        v = default_cpu_version;
> -    }
> -    if (v == CPU_VERSION_LATEST) {
> +    if (use_latest_cpu) {
>          return x86_cpu_model_last_version(model);
>      }
> -    return v;
> +
I'd drop newline

> +    return model->version;
>  }
>  
>  static const Property max_x86_cpu_properties[] = {
> @@ -5985,10 +5981,15 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
>      if (!cc->model || !cc->model->is_alias) {
>          return NULL;
>      }
> -    version = x86_cpu_model_resolve_version(cc->model);
> -    if (version <= 0) {
> +
> +    if (use_legacy_cpu) {
> +        /* legacy cpu models do not support cpu aliases */
>          return NULL;
>      }
> +
> +    version = x86_cpu_model_resolve_version(cc->model);
> +    assert(version);
> +
>      return x86_cpu_versioned_model_name(cc->model->cpudef, version);
>  }
>  
> @@ -6002,11 +6003,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
>      g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
>  
>      if (!desc && alias_of) {
> -        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
> -            desc = g_strdup("(alias configured by machine type)");
> -        } else {
>              desc = g_strdup_printf("(alias of %s)", alias_of);
misaligned wrt 'new' 'if' block?

> -        }
>      }
>      if (!desc && cc->model && cc->model->note) {
>          desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
> @@ -6109,13 +6106,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      } else {
>          info->deprecated = false;
>      }
> -    /*
> -     * Old machine types won't report aliases, so that alias translation
> -     * doesn't break compatibility with previous QEMU versions.
> -     */
> -    if (default_cpu_version != CPU_VERSION_LEGACY) {
> -        info->alias_of = x86_cpu_class_get_alias_of(cc);
> -    }
> +
> +    info->alias_of = x86_cpu_class_get_alias_of(cc);
>  
>      QAPI_LIST_PREPEND(*cpu_list, info);
>  }
> @@ -6287,7 +6279,12 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
>      const X86CPUVersionDefinition *vdef;
>      X86CPUVersion version = x86_cpu_model_resolve_version(model);
>  
> -    if (version == CPU_VERSION_LEGACY) {
> +    /*
> +     * if the machine uses legacy cpus, use legacy cpus with no versions
> +     * when no explict CPU versions are specified in the CPU definition
> +     * passed from the command line.
> +     */
> +    if (version == DEFAULT_CPU_VERSION && use_legacy_cpu) {
>          return;
>      }

I think we can safely drop this check altogether since followup
call x86_cpu_def_get_versions will return version 1 if not specified
and looking at model definitions all existing v1 defs have no property
overrides. So 'for' loop is effectively would be nop.
 
>  
> @@ -6317,7 +6314,11 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
>      X86CPUVersion version = x86_cpu_model_resolve_version(model);
>      const CPUCaches *cache_info = model->cpudef->cache_info;
>  
> -    if (version == CPU_VERSION_LEGACY) {
> +    /*
> +     * If machine supports legacy cpus and no explicit cpu versions are
> +     * specified, use the cache from the unversioned cpu definition.
> +     */
> +    if (version == DEFAULT_CPU_VERSION && use_legacy_cpu) {
>          return cache_info;
>      }

the same as above comment, only wrt cache_info

>  
> @@ -6452,7 +6453,7 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
>      /* Unversioned model: */
>      m = g_new0(X86CPUModel, 1);
>      m->cpudef = def;
> -    m->version = CPU_VERSION_AUTO;
> +    m->version = DEFAULT_CPU_VERSION;

with this being the remaining user of macro just drop it and use 1 directly.

>      m->is_alias = true;
>      x86_register_cpu_model_type(def->name, m);
>  
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index b26e25ba15..bdbe54b26f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2679,27 +2679,14 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access);
>  void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
>                                     TPRAccess access);
>  
> -/* Special values for X86CPUVersion: */
> -
> -/* Resolve to latest CPU version */
> -#define CPU_VERSION_LATEST -1
> -
> -/*
> - * Resolve to version defined by current machine type.
> - * See x86_cpu_set_default_version()
> - */
> -#define CPU_VERSION_AUTO   -2
> -
> -/* Don't resolve to any versioned CPU models, like old QEMU versions */
> -#define CPU_VERSION_LEGACY  0
> -
>  typedef int X86CPUVersion;
>  
>  /*
> - * Set default CPU model version for CPU models having
> - * version == CPU_VERSION_AUTO.
> + * Set CPU model version to the lastest version.
> + * Currently, this is only used by microvm.
>   */
> -void x86_cpu_set_default_version(X86CPUVersion version);
> +void x86_cpu_uses_lastest_version(void);
> +void x86_cpu_set_legacy_version(void);
>  
>  #ifndef CONFIG_USER_ONLY
>  


