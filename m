Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB9FC369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 00:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Njs-0000K5-PM; Tue, 22 Apr 2025 20:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1u7Njj-0000IH-Fg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 20:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1u7Njd-0004St-5h
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 20:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745367181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6+mB4NhHWZ7wEs28ll5p9trBzfFuFxRj3V7gEMakDE=;
 b=Vc3Gg6biMPdcz1evCzg9boqhrxmQ4hJO5AhMR0lCwkCdxVpE3VtjSB4Fvjd/Jc5SCLWdjw
 orkY482tYE0udcB1HbwjyJtUkNe782valSyHHOFAWm01NPyOQ/bteBFlbbsyAdCdKYGdk4
 1tVGAcGtAYB5UcM/XtAK8Q9PsvryI9I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-qIsp29fzPvertPLAk_QRYw-1; Tue, 22 Apr 2025 20:11:36 -0400
X-MC-Unique: qIsp29fzPvertPLAk_QRYw-1
X-Mimecast-MFC-AGG-ID: qIsp29fzPvertPLAk_QRYw_1745367095
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7395095a505so4097788b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 17:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745367095; x=1745971895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6+mB4NhHWZ7wEs28ll5p9trBzfFuFxRj3V7gEMakDE=;
 b=XRprkbHJBNAR0IykQJNTODKejrPuX4qfHfVWr6TVz18lF9TBHLIpM0p7JbhjzVi0iJ
 nbZToIBt3G312WEfZW4C0+pTC/HT214nNz71vEshJ4u3oAnkih1xoOYkGuQwAI7DJtKm
 X0OBQ5aq+FDp2DQIju3Lte4br59YEFfseSxrz1xfZ2TCDS4HmYgx+ldcmSzuO3Hpmn/o
 WX/ajly82IiWPIiZIalH36SPy4eHvaD6Ub7l9OG0FGK4LWDT1HedCcKoQTJ0xM86DZ4B
 rDb3akA+21+t6qj9T91N32D0g+kaKfoQN24VOQTnGB+EYIwwsWGalO+LLOYKH7GrYeuY
 YqLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLN5AUruZQS0BzwY0Ha699Kk+FgZmZPvh5X3TjV+BzCGIMW1rUBsKbSztqmW1HxHyGtBnD6TZ3SiLy@nongnu.org
X-Gm-Message-State: AOJu0Yx20C85kG6TYsBWD7DLzpLk0/Ddvb4GIBV1Vlgjh4FDLdIV9flk
 1YoohvauIk3O9nUPkUZnJEbZ/hEbNUKvsI7sNplDvnVgeU71wBPSN45hFcI76H3WTsKWK4x6/qT
 NhHLAX6u4KwmxxqLOhAZqckBAxSGE9gHomcmsB746ET3j86W3RFIf
X-Gm-Gg: ASbGncscTcn/O57GSA9+Dd/gwjTmIQqLpHBnbBNG87uzpUfPMqVJJHkt3oOG+NbQVCl
 IvRLQzEzIFklOEP3NYwlltYyYkod7nlm9vkxOfeFerRkI9c+atiifNtcatOT9xMr+vMCmjGA6vW
 FFUJCsZRW8wvt23uUz5Bz99Wm0dlEBAIC85W0evzn/A57VXqQ8yuv6MgPzovdODbRSE5RPbexu+
 QmFP6qVimYdyZNJFPdGFl5HMyGKTWPsWEQA+HZzPLYDqGXaF3jjncnyzdcV1fWKUMH2YYn5dG0z
 UPOyR/KWLNm8
X-Received: by 2002:a05:6a20:c892:b0:1f5:8479:dfe2 with SMTP id
 adf61e73a8af0-203cbc25ecfmr26254157637.6.1745367094884; 
 Tue, 22 Apr 2025 17:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtOHL0yGv3OwqyoNx75CP5SbkeSzxVPMwTl1NUeRIfq2MM/COn6hYUkCbhJ6iJZp5DS06kDA==
X-Received: by 2002:a05:6a20:c892:b0:1f5:8479:dfe2 with SMTP id
 adf61e73a8af0-203cbc25ecfmr26254129637.6.1745367094523; 
 Tue, 22 Apr 2025 17:11:34 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db157c783sm8062057a12.77.2025.04.22.17.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 17:11:33 -0700 (PDT)
Message-ID: <2bbfd5d1-be8a-41aa-822f-4c38449b79a7@redhat.com>
Date: Wed, 23 Apr 2025 10:11:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] acpi: Add machine option to disable SPCR table
To: Li Chen <me@linux.beauty>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
 <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/22/25 10:05 PM, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> The ACPI SPCR (Serial Port Console Redirection) table allows firmware
> to specify a preferred serial console device to the operating system.
> On ARM64 systems, Linux by default respects this table: even if the
> kernel command line does not include a hardware serial console (e.g.,
> "console=ttyAMA0"), the kernel still register the serial device
> referenced by SPCR as a printk console.
> 
> While this behavior is standard-compliant, it can lead to situations
> where guest console behavior is influenced by platform firmware rather
> than user-specified configuration. To make guest console behavior more
> predictable and under user control, this patch introduces a machine
> option to explicitly disable SPCR table exposure:
> 
>      -machine spcr=off
> 
> By default, the option is enabled (spcr=on), preserving existing
> behavior. When disabled, QEMU will omit the SPCR table from the guest's
> ACPI namespace, ensuring that only consoles explicitly declared in the
> kernel command line are registered.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Changes since V1: add Reviewed-by and Acked-by
> 
>   hw/arm/virt-acpi-build.c       |  5 ++++-
>   hw/core/machine.c              | 22 ++++++++++++++++++++++
>   hw/loongarch/virt-acpi-build.c |  4 +++-
>   hw/riscv/virt-acpi-build.c     |  5 ++++-
>   include/hw/boards.h            |  1 +
>   qemu-options.hx                |  5 +++++
>   6 files changed, 39 insertions(+), 3 deletions(-)
> 

One coding style issue below. With it fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e178..f25c3b26ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -940,7 +940,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       }
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, vms);
> +
> +    if (ms->enable_spcr) {
> +        spcr_setup(tables_blob, tables->linker, vms);
> +    }
>   
>       acpi_add_table(table_offsets, tables_blob);
>       build_dbg2(tables_blob, tables->linker, vms);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63c6ef93d2..d56f44f4e8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -590,6 +590,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
>       ms->nvdimms_state->is_enabled = value;
>   }
>   
> +static bool machine_get_spcr(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->enable_spcr;
> +}
> +
> +static void machine_set_spcr(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->enable_spcr = value;
> +}
> +
>   static bool machine_get_hmat(Object *obj, Error **errp)
>   {
>       MachineState *ms = MACHINE(obj);
> @@ -1294,6 +1308,14 @@ static void machine_initfn(Object *obj)
>                                           "Table (HMAT)");
>       }
>   
> +    /* SPCR */
> +    ms->enable_spcr = true;
> +    object_property_add_bool(obj, "spcr", machine_get_spcr, machine_set_spcr);
> +    object_property_set_description(obj, "spcr",
> +                                   "Set on/off to enable/disable "
> +                                   "ACPI Serial Port Console Redirection "
> +                                   "Table (spcr)");
> +
>       /* default to mc->default_cpus */
>       ms->smp.cpus = mc->default_cpus;
>       ms->smp.max_cpus = mc->default_cpus;
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index fced6c445a..0e437bcf25 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -557,7 +557,9 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       acpi_add_table(table_offsets, tables_blob);
>       build_srat(tables_blob, tables->linker, machine);
>       acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, machine);
> +
> +    if (machine->enable_spcr)
> +        spcr_setup(tables_blob, tables->linker, machine);
>   

	if (machine->enable_spcr) {
	    spcr_setup(tables_blob, tables->linker, machine);
	}

>       if (machine->numa_state->num_nodes) {
>           if (machine->numa_state->have_numa_distance) {
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 1ad6800508..7f6d221c63 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -680,7 +680,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>       build_rhct(tables_blob, tables->linker, s);
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, s);
> +
> +    if (ms->enable_spcr) {
> +        spcr_setup(tables_blob, tables->linker, s);
> +    }
>   
>       acpi_add_table(table_offsets, tables_blob);
>       {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f22b2e7fc7..cdf2791a50 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -444,6 +444,7 @@ struct MachineState {
>       SmpCache smp_cache;
>       struct NVDIMMState *nvdimms_state;
>       struct NumaState *numa_state;
> +    bool enable_spcr;
>   };
>   
>   /*
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..953680595f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>       "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>       "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> +    "                spcr=on|off controls ACPI SPCR support (default=on)\n"
>   #ifdef CONFIG_POSIX
>       "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>   #endif
> @@ -105,6 +106,10 @@ SRST
>           Enables or disables ACPI Heterogeneous Memory Attribute Table
>           (HMAT) support. The default is off.
>   
> +    ``spcr=on|off``
> +        Enables or disables ACPI Serial Port Console Redirection Table
> +        (SPCR) support. The default is on.
> +
>       ``aux-ram-share=on|off``
>           Allocate auxiliary guest RAM as an anonymous file that is
>           shareable with an external process.  This option applies to

Thanks,
Gavin


