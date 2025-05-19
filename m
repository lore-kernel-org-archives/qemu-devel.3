Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4l-0003iH-4P; Mon, 19 May 2025 00:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrsG-0002bl-S5
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:13:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrsE-0004pK-OQ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:13:12 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73972a54919so3642879b3a.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747627988; x=1748232788; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yqv7HA3z1YUyLlsJ4gpBX/87FXfyOH64NZEVLFo2aJA=;
 b=E6Y/4PpMQYjanfW9+MiXr2HxuQeU43C5bZEBMssWCri9ceR2yPB0J4HPydML1rBjYd
 I48SmB79Jdb/INXiVt28IzdCMvI/++PSaJrdQsdhkG3gaLuYCUk2Jje5OlvvgsVu1hgY
 sY7jVb1XUdSw9pMwtrvS2YinjInM0y+4uLCDrINlhtQr8bQJGvQk+Xy7UDRMzSRpi4Tw
 JtP+7qyg9haP8Lo34WHq4O9RbaN2XMscGONSh9YXeVZ7tumdYGuEtLU4UN3K03KpOmWF
 ErHl1ta+6wM5FGdeLVRBhOBxoPp3b0nCiKo8MFiJy/5IHbchT7T9hjIZA1xrjB4y4uw1
 RdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627988; x=1748232788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqv7HA3z1YUyLlsJ4gpBX/87FXfyOH64NZEVLFo2aJA=;
 b=NnCiM5xdsEOijQAmBW6NsSR0LR9EUWZ6bHGZcyUd4WgsXcgI2x/k94DKmGBQxEcguk
 EX39NSPsZNX/TD5xgpqQIg2L8KAxd30txxMUMoJwX/kP/fyiBeM4zymtWNRGQltdgzKQ
 5gtTWlLDI1cW/7XsxJNckBSWEzowSF1i8ZkZxegWqTObjEZS6H8IkL9ThJrmSazZ+Tye
 bCebMfPb8KCO6gVIjMUApnWFU6Ratcpb97q5Wh5+Loi7AWZ53bPr9WICDW0gV7MLc+C7
 Pis5OyeY1bZF2oR13uc9ZFoKlfOoQFHhU4nCSW9iA6x/K8/UprFXzne/QHAmLq3548Q7
 lHwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfcEZVgoJg5mwjMa77EL9KZtEJ1iHVVCA71Di2NF7v8leutiGgcDY2+suvgjZMAX3MVuA2OZDChaxz@nongnu.org
X-Gm-Message-State: AOJu0YyfjtYKjr18CvbfQRVa7hr+08NNqjWu0APKN4a1yTgpkB/RnTRY
 o6Ra5ace8JUhqWdLzpccsmQJZgvVWvCPj3MIxwNAPienUOWfNVy7ylgjjLqDzHHt+a6XDtn8xcL
 /2z3yHOY=
X-Gm-Gg: ASbGncsEELM7puUC3CbDpEQpzADL7EPanKaGbKeUJWK0zTa9TQXMYlsRJRIvdN9bjzI
 JA4SExfDSl2brlZIyznqcKCbsx4BoJlRhkLmOX/NJliTqqweD3Dpfz1Wp+/qOv9YcPuQ1XQuWL+
 aFTfvVuAS0MkvmPA0l/FPKCkZCu+fp47EMlgFGd1l+zchCMVvNiRWswX+B7HWfSxv1i9Kd0hXCW
 +bRU9WUTCmtiDuq804or2x8X+6WyOzy8R5jPtObi57+Poms4fMHMuwO5h4gp39hDgIoXarLrDqy
 8lASy1snXAiEgAID1i7FHvRtRZBwg0r8/jRVx2hLE+3yqMj3ckmYz38K0O0=
X-Google-Smtp-Source: AGHT+IFVjr+7cxo4gYErqeNNoNHKpWMSZ+/1Pyw1kAnuFPOXJNKQX5GiV0FQAjA8LTXOF6+xNO2pNw==
X-Received: by 2002:a05:6a00:3921:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-742a97740damr15973043b3a.4.1747627988521; 
 Sun, 18 May 2025 21:13:08 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a985e417sm5220212b3a.123.2025.05.18.21.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:13:07 -0700 (PDT)
Date: Mon, 19 May 2025 09:42:58 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH V3 1/4] acpi: Add machine option to disable SPCR table
Message-ID: <aCqvymq6RVHH3tie@sunil-laptop>
References: <87msberqzi.wl-me@linux.beauty>
 <87ldqyrqqo.wl-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldqyrqqo.wl-me@linux.beauty>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x434.google.com
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

On Thu, May 15, 2025 at 08:41:03PM +0800, Li Chen wrote:
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
>     -machine spcr=off
> 
> By default, the option is enabled (spcr=on), preserving existing
> behavior. When disabled, QEMU will omit the SPCR table from the guest's
> ACPI namespace, ensuring that only consoles explicitly declared in the
> kernel command line are registered.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
> 
> Changes since V2: Add Reviewed-by from Gavin Shan <gshan@redhat.com>
>                   for the first patch and fix style issue.
> Changes since V1: add Reviewed-by and Acked-by
> 
>  hw/arm/virt-acpi-build.c       |  5 ++++-
>  hw/core/machine.c              | 22 ++++++++++++++++++++++
>  hw/loongarch/virt-acpi-build.c |  4 +++-
>  hw/riscv/virt-acpi-build.c     |  5 ++++-
>  include/hw/boards.h            |  1 +
>  qemu-options.hx                |  5 +++++
>  6 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e178..f25c3b26ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -940,7 +940,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      }
> 
>      acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, vms);
> +
> +    if (ms->enable_spcr) {
> +        spcr_setup(tables_blob, tables->linker, vms);
> +    }
> 
>      acpi_add_table(table_offsets, tables_blob);
>      build_dbg2(tables_blob, tables->linker, vms);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed01798d37..71a935512e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -593,6 +593,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
>      ms->nvdimms_state->is_enabled = value;
>  }
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
>  static bool machine_get_hmat(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> @@ -1297,6 +1311,14 @@ static void machine_initfn(Object *obj)
>                                          "Table (HMAT)");
>      }
> 
> +    /* SPCR */
> +    ms->enable_spcr = true;
> +    object_property_add_bool(obj, "spcr", machine_get_spcr, machine_set_spcr);
> +    object_property_set_description(obj, "spcr",
> +                                   "Set on/off to enable/disable "
> +                                   "ACPI Serial Port Console Redirection "
> +                                   "Table (spcr)");
> +
>      /* default to mc->default_cpus */
>      ms->smp.cpus = mc->default_cpus;
>      ms->smp.max_cpus = mc->default_cpus;
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index fced6c445a..0e437bcf25 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -557,7 +557,9 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      acpi_add_table(table_offsets, tables_blob);
>      build_srat(tables_blob, tables->linker, machine);
>      acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, machine);
> +
> +    if (machine->enable_spcr)
> +        spcr_setup(tables_blob, tables->linker, machine);
> 
>      if (machine->numa_state->num_nodes) {
>          if (machine->numa_state->have_numa_distance) {
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 1ad6800508..7f6d221c63 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -680,7 +680,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>      build_rhct(tables_blob, tables->linker, s);
> 
>      acpi_add_table(table_offsets, tables_blob);
> -    spcr_setup(tables_blob, tables->linker, s);
> +
> +    if (ms->enable_spcr) {
> +        spcr_setup(tables_blob, tables->linker, s);
> +    }
> 
>      acpi_add_table(table_offsets, tables_blob);
>      {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 765dc8dd35..089104d54b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -444,6 +444,7 @@ struct MachineState {
>      SmpCache smp_cache;
>      struct NVDIMMState *nvdimms_state;
>      struct NumaState *numa_state;
> +    bool enable_spcr;
>  };
> 
>  /*
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..953680595f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> +    "                spcr=on|off controls ACPI SPCR support (default=on)\n"
>  #ifdef CONFIG_POSIX
>      "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>  #endif
> @@ -105,6 +106,10 @@ SRST
>          Enables or disables ACPI Heterogeneous Memory Attribute Table
>          (HMAT) support. The default is off.
> 
> +    ``spcr=on|off``
> +        Enables or disables ACPI Serial Port Console Redirection Table
> +        (SPCR) support. The default is on.
> +
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil

