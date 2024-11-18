Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7215CD591A5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4ye-00089l-Il; Mon, 18 Nov 2024 11:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD4yb-00089G-0l
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tD4yX-0007jJ-IM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731948703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnSWK1e0/v4RdDaAfGdPQZ2JUZ376QSKq7MHCgv8MbM=;
 b=X3azwdjb52aXLY2iNjsPz0vXgVvDdtBktthhGRz1dHcAR99U6ZX+ZDqIA3VCatfkFGmdsR
 FM01weBHMT37/u33LAyUPWSjgWY8Jq+7/R9eJuKgWyt47nY1j7T6iiTNqRwfhh0mLwyUFL
 BkwabPlMQ6Eo/B2WcKXq8WhWWkUzY1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-RleqlidlPo-O2yrifiUN-w-1; Mon, 18 Nov 2024 11:51:42 -0500
X-MC-Unique: RleqlidlPo-O2yrifiUN-w-1
X-Mimecast-MFC-AGG-ID: RleqlidlPo-O2yrifiUN-w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso16170485e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731948701; x=1732553501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnSWK1e0/v4RdDaAfGdPQZ2JUZ376QSKq7MHCgv8MbM=;
 b=fx1pc2Der1gt4BHLZxWKB3b1Lw5WDaSFqllO2mmCeJmAlwAFVV2rzAVhEKJ3c0N1r7
 Sgf3/dvvRbCokdsHkLriabOCZsB7h1xMbQvIxpln4eipg0F/r/7ocv57Tf/OO9tY4arS
 fR8rfynduJG1FB4Iq0aFD/aaVYKsU0RJrVt/HqtVs+egvpR6aAhFK2LXenuqnGQ1IhzJ
 haPa6VaK4GVpkay/IZET4xziv9lN5v7YOE2s/653uTwnjay7BsAa2XPjFUTmM4/Kqx+O
 bZTIl1V9pMX8dLFZemYcm9YkObXqrFclo8/veRj7bQddiC9L5sz46OI0CCmZMemrw+fR
 Xi8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcxIB9jgLoJEBG5S6mSHsxKGSojOT6a7oKVKOjzdDifDDeHQzS2SwuGGugmghK3NrRXEakZcMcoqaI@nongnu.org
X-Gm-Message-State: AOJu0YzvLSTCIYUtK2Y+0igOdz+BuUVQDdHQ+AJT/lZn+CO57uZLk0yF
 lT2gJLl9AJef3p5YY6rjcyiPCo8V0I4TYMM2rWYOTfykS+3f2q9nnHHaSGWuDuvbTTn2PYT44ky
 Mz3YttMFTkaRWam4v/HUiuVXNio/iYe5cEXtzVbwR4/SMKuZuZ3IE
X-Received: by 2002:a05:600c:5021:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-432df78788amr99134175e9.26.1731948701353; 
 Mon, 18 Nov 2024 08:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVq23Vv6ipFtOIQZS6GsG1VjSdXv7u+GYzH+r9U3pZSKEIiCxKguaU7xhmExFBXTlCXcMrsA==
X-Received: by 2002:a05:600c:5021:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-432df78788amr99133625e9.26.1731948700808; 
 Mon, 18 Nov 2024 08:51:40 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm164972725e9.28.2024.11.18.08.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 08:51:40 -0800 (PST)
Date: Mon, 18 Nov 2024 17:51:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 5/6] hw/loongarch/virt: Update the ACPI table for
 hotplug cpu
Message-ID: <20241118175139.510424ad@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241112021738.1952851-6-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-6-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 12 Nov 2024 10:17:37 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On LoongArch virt machine, ACPI GED hardware is used for CPU hotplug
> handler, here CPU hotplug support feature is added based on GED handler,
> also CPU scan and reject method is added about CPU device in DSDT table.
> 
> Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/loongarch/Kconfig        |  1 +
>  hw/loongarch/acpi-build.c   | 35 +++++++++++++++++++++++++++++++++--
>  hw/loongarch/virt.c         | 10 ++++++++++
>  include/hw/loongarch/virt.h |  1 +
>  4 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
> index fe1c6feac1..bb2838b7b5 100644
> --- a/hw/loongarch/Kconfig
> +++ b/hw/loongarch/Kconfig
> @@ -17,6 +17,7 @@ config LOONGARCH_VIRT
>      select LOONGARCH_EXTIOI
>      select LS7A_RTC
>      select SMBIOS
> +    select ACPI_CPU_HOTPLUG
>      select ACPI_PCI
>      select ACPI_HW_REDUCED
>      select FW_CFG_DMA
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 50709bda0f..c220edec68 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -47,6 +47,22 @@
>  #define ACPI_BUILD_DPRINTF(fmt, ...)
>  #endif
>  
> +static void virt_madt_cpu_entry(int uid,
> +                                const CPUArchIdList *apic_ids,
> +                                GArray *entry, bool force_enabled)
> +{
> +    uint32_t flags, apic_id = apic_ids->cpus[uid].arch_id;
> +
> +    flags = apic_ids->cpus[uid].cpu || force_enabled ? 1 /* Enabled */ : 0;
> +
> +    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
> +    build_append_int_noprefix(entry, 0, 1);       /* Type */
> +    build_append_int_noprefix(entry, 8, 1);       /* Length */
> +    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
> +    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */

is it really APIC ID or just copy paste mistake from x86?


> +    build_append_int_noprefix(entry, flags, 4); /* Flags */
> +}
> +
>  /* build FADT */
>  static void init_common_fadt_data(AcpiFadtData *data)
>  {
> @@ -123,15 +139,17 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
>  
>      for (i = 0; i < arch_ids->len; i++) {
> +        uint32_t flags;
> +
>          /* Processor Core Interrupt Controller Structure */
>          arch_id = arch_ids->cpus[i].arch_id;
> -
> +        flags   = arch_ids->cpus[i].cpu ? 1 : 0;
>          build_append_int_noprefix(table_data, 17, 1);    /* Type */
>          build_append_int_noprefix(table_data, 15, 1);    /* Length */
>          build_append_int_noprefix(table_data, 1, 1);     /* Version */
>          build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>          build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
> -        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
> +        build_append_int_noprefix(table_data, flags, 4); /* Flags */
>      }
>  
>      /* Extend I/O Interrupt Controller Structure */
> @@ -334,6 +352,7 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>  {
>      uint32_t event;
>      LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
> +    CPUHotplugFeatures opts;
>  
>      build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
>                    HOTPLUG_HANDLER(lvms->acpi_ged),
> @@ -346,6 +365,18 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>                                   AML_SYSTEM_MEMORY,
>                                   VIRT_GED_MEM_ADDR);
>      }
> +
> +    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
> +        opts.acpi_1_compatible = false;
> +        opts.has_legacy_cphp = false;
> +        opts.fw_unplugs_cpu = false;
> +        opts.smi_path = NULL;
> +
> +        build_cpus_aml(dsdt, machine, opts, virt_madt_cpu_entry,
> +                       VIRT_GED_CPUHP_ADDR, "\\_SB",
> +                       AML_GED_EVT_CPU_SCAN_METHOD, AML_SYSTEM_MEMORY);
> +    }
> +
>      acpi_dsdt_add_power_button(dsdt);
>  }
>  
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 0e0c6c202b..b49b15c0f6 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -666,11 +666,17 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
>  {
>      DeviceState *dev;
>      MachineState *ms = MACHINE(lvms);
> +    MachineClass *mc = MACHINE_GET_CLASS(lvms);
>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
>      }
> +
> +    if (mc->has_hotpluggable_cpus) {
> +        event |= ACPI_GED_CPU_HOTPLUG_EVT;
> +    }
> +
>      dev = qdev_new(TYPE_ACPI_GED);
>      qdev_prop_set_uint32(dev, "ged-event", event);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> @@ -682,6 +688,10 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
>      /* ged regs used for reset and power down */
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
>  
> +    if (mc->has_hotpluggable_cpus) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
> +    }
> +
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>                         qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
>      return dev;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 260e6bd7cf..79a85723c9 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -30,6 +30,7 @@
>  #define VIRT_GED_EVT_ADDR       0x100e0000
>  #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
>  #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
> +#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
>  
>  #define COMMAND_LINE_SIZE       512
>  


