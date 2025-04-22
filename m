Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D561DC369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 11:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7BfB-00026h-1Q; Tue, 22 Apr 2025 07:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Bf8-00025y-DV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 07:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Bf5-0005i3-Aa
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 07:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745320770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsdmIFtX99VQcGuR1LBZf7rR8W5MrQzqwjTqq52/G6A=;
 b=epDWcMYRkc/bE0XOJ5b8+IyhzbgjWXnE/brx+yWpfZhpZEM7sQsT0gI4TZErf0108jlYzw
 tpzpFsoTcxhH5i79dx6QULUKzoK5anq0MQU82lY5fBzjHKvl6NiiQqnvCUKi7BWpzwY/1m
 vaB/kIHScR+gHjxBuy7D/FtLElOH8zQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-IsLeB_cjMSaBn5pAL-gsNA-1; Tue, 22 Apr 2025 07:19:29 -0400
X-MC-Unique: IsLeB_cjMSaBn5pAL-gsNA-1
X-Mimecast-MFC-AGG-ID: IsLeB_cjMSaBn5pAL-gsNA_1745320768
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so28957735e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 04:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745320768; x=1745925568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsdmIFtX99VQcGuR1LBZf7rR8W5MrQzqwjTqq52/G6A=;
 b=Cyu7kntmODpeC23b6YQOpGCp6/gxiKAOy3ptEmfcrRg/l9RGIzviRFEHNizti9GVCi
 3cx7Xt+PpO0C4yiiuZG56TEMXNGYLaot9MDFFu9DsGgDViHlgWc2CYrLSVGDGsu5SdZM
 uJd7eegyI3kWuBDeoer+izvgbRrZ7uWgYhQtMp3edDOYupaProbHgxt3ATk5Fbykt2CI
 umTdtB7UIR5vdgIizb5c+MOg9M637w/iCUQYzsXxvf/RJvtfk07Uwn4Icz2zu3TDQ15m
 Xos4wG4hQu/3LaDd4mPNy949KfBOI1YbaYj6WgT4h1hrAz5Z+mhtH00wLWbliPliivqu
 sV0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmsHu8q0xVg0ngUFfPEzT6kj9b5pInrGxi+PNbK3J6MMY7jqKPsOBy6Ip3ZRgmh6hrTxARS5tvow/K@nongnu.org
X-Gm-Message-State: AOJu0YynclXrwJogswXVf5B/p6tnQrNThY5XemW7ld1bISQlXhR9141m
 z43PDRDGWewYwHPSV7AqlwDCvXGI/aI07Q5xugw7Rqy5Z/0JNx2lmxeSdhTjVTX+GgmSpaiDjSJ
 eAtcChns5xqUiVcuswQwaxClumy/2jFz1mg4FXAzGHbPkG8TFrJF9
X-Gm-Gg: ASbGncvkCvr4rv3coAU0BWQrvGpzMCNPtYgm3qm0oo8igACirbA1yZeMy643Oe2QeKX
 JfiaB3neiti2foEopBkO46elbDJpv35Ekhkd5o5WtE5QInLrqROs1LGc9oYxQkv/bQaHI3M2RTR
 2sIDK2TQX/OcOw/9Nslhc3uc/Ak4Nb5IzofVcE3JtnFIQbx3n685JIhGLpIMZJx+arSZrXKVKw1
 7zlclVCu2SoPFt7Lko/aieaTfmCia6KCtS9aAs3qasqK3DB6IP+/+D7P9uXHR+7m5bWMh53naBV
 yBCNOw==
X-Received: by 2002:a05:600c:444e:b0:43c:fe9f:ab90 with SMTP id
 5b1f17b1804b1-4406ac17342mr101370515e9.28.1745320767759; 
 Tue, 22 Apr 2025 04:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgLC3SWsjAkWbXnn2rnb/1Pc98w1aii9oSgY/gpPlfphDfYQCqRSzXBou6osTCJQNwJ1DNgg==
X-Received: by 2002:a05:600c:444e:b0:43c:fe9f:ab90 with SMTP id
 5b1f17b1804b1-4406ac17342mr101370305e9.28.1745320767397; 
 Tue, 22 Apr 2025 04:19:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db230sm171907035e9.31.2025.04.22.04.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 04:19:26 -0700 (PDT)
Date: Tue, 22 Apr 2025 07:19:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?=22Philippe_Mathieu-Daud=E9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH] acpi: Add machine option to disable SPCR table
Message-ID: <20250422071902-mutt-send-email-mst@kernel.org>
References: <87a588wsc9.wl-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a588wsc9.wl-me@linux.beauty>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 22, 2025 at 03:47:18PM +0800, Li Chen wrote:
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


The patches look ok to me

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
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
> index 63c6ef93d2..d56f44f4e8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -590,6 +590,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
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
> @@ -1294,6 +1308,14 @@ static void machine_initfn(Object *obj)
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
> index f22b2e7fc7..cdf2791a50 100644
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
>      ``aux-ram-share=on|off``
>          Allocate auxiliary guest RAM as an anonymous file that is
>          shareable with an external process.  This option applies to
> -- 
> 2.49.0


