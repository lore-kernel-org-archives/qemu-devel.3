Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87ACC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PDZ-0005zQ-4O; Mon, 13 May 2024 02:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s6PDP-0005q1-Jd
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s6PDM-0003pU-2Q
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715581870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=797dreJwwtDvwa5S8exMLXc4FHv7MqN20AnCWFX1jsY=;
 b=NKJczLLwMyB30lXVVCrAqdK150X4ekVW+KozHFcRHS2Fz9yiW794b27B7e4Imi26Xce75N
 ZXhm+v5V4GPUm6N73fJd6ddLHKbtn2BADo+JmlNaEjgscKHRSFycw2NBXKixmm5eh9ZkJg
 bp1AKe++sj0bKu5V3f7BstvqrKT7LLk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-XEJJfbFGOwa0ratV69el2g-1; Mon, 13 May 2024 02:31:09 -0400
X-MC-Unique: XEJJfbFGOwa0ratV69el2g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59bfd32b8fso222468666b.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 23:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715581868; x=1716186668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=797dreJwwtDvwa5S8exMLXc4FHv7MqN20AnCWFX1jsY=;
 b=OQt+/V+IfLi9bKMV6TCkmCPEnHXHTsPtgqqoLB+LR1JXoYNyCIJN16oUSpioRaeJyz
 PYqyylgypebLTRe9Tl1RF9fGTqaNeXW0Oj4tf8Sg6KmHHRAACIdhu29ncYCJxvcsfFJm
 T4KHS7Eflk3tXhQY/7ZkHaUXxnJGkXWZv00jhtF2aoy7k7MqkcthwNG0/4fr6Qa5rGAr
 hBgMAYKPuCuttVQblR6bhdx/oEsLuG0nMzo3NkZhQ0C5CvCATZsnKr9nWN1Qq73jD19l
 d9JV62OQuVaRRbL1MFknDCLWdnxwZZxaCsuz10jkde868YI3Mm9ImNsSGjKL06q1x74P
 kfbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlu+YwCqMfOqZGcdOJr9J7VuT8Rg6L8PQtn9Aq/Q8FevnXEz0k2Vu8sjhC0Tsr2CRUGpbVxEjgi1k+2fYRhKQ+gx3L3z0=
X-Gm-Message-State: AOJu0YwkTuc5Z/muc+EAP9HV1oL4fHGT/B8cnj6SLL1ZO+mPol6jPdQs
 gYig5esC8Oqb9zPIIjI5pnYJzsiqrV50v+MKj/mzATMRrT52JYUpTZZ5B6+hvIL7F00GPqEl3Sa
 YxqQxV0YnOaYn3/gI3v2FnADRfHvj2R7TVw9u6hRnrDZtzqWd0hL5
X-Received: by 2002:a17:906:3183:b0:a59:b784:ced4 with SMTP id
 a640c23a62f3a-a5a2d67873fmr583206166b.75.1715581867821; 
 Sun, 12 May 2024 23:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUNuCqfXAxJSW1/WD5alA4d36gQpoD5AsTdvL4Ux3vlFNcigWdfJoy+KQV58sNhgynZGsLpQ==
X-Received: by 2002:a17:906:3183:b0:a59:b784:ced4 with SMTP id
 a640c23a62f3a-a5a2d67873fmr583203966b.75.1715581867265; 
 Sun, 12 May 2024 23:31:07 -0700 (PDT)
Received: from redhat.com ([31.187.78.170]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0173asm557451066b.179.2024.05.12.23.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 23:31:06 -0700 (PDT)
Date: Mon, 13 May 2024 02:31:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table version 4 format
Message-ID: <20240513023035-mutt-send-email-mst@kernel.org>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
 <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 06, 2024 at 10:22:11PM -0700, Sia Jee Heng wrote:
> Update the SPCR table to accommodate the SPCR Table version 4 [1].
> The SPCR table has been modified to adhere to the version 4 format [2].
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

What does this achieve? We don't normally change unless it gets
us some useful feature.


> ---
>  hw/acpi/aml-build.c         | 14 +++++++++++---
>  hw/arm/virt-acpi-build.c    | 10 ++++++++--
>  hw/riscv/virt-acpi-build.c  | 12 +++++++++---
>  include/hw/acpi/acpi-defs.h |  7 +++++--
>  include/hw/acpi/aml-build.h |  2 +-
>  5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..7c43573eef 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>  
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id)
> +                const char *oem_id, const char *oem_table_id, const char *name)
>  {
>      AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
> @@ -2042,8 +2042,16 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, f->pci_flags, 4);
>      /* PCI Segment */
>      build_append_int_noprefix(table_data, f->pci_segment, 1);
> -    /* Reserved */
> -    build_append_int_noprefix(table_data, 0, 4);
> +    /* UartClkFreq */
> +    build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> +    /* PreciseBaudrate */
> +    build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> +    /* NameSpaceStringLength */
> +    build_append_int_noprefix(table_data, f->namespace_string_length, 2);
> +    /* NameSpaceStringOffset */
> +    build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
> +    /* NamespaceString[] */
> +    g_array_append_vals(table_data, name, f->namespace_string_length);
>  
>      acpi_table_end(linker, &table);
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6a1bde61ce..cb345e8659 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -428,11 +428,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>  /*
>   * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
>   */
>  static void
>  spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> +    const char name[] = ".";
>      AcpiSpcrData serial = {
>          .interface_type = 3,       /* ARM PL011 UART */
>          .base_addr.id = AML_AS_SYSTEM_MEMORY,
> @@ -456,9 +457,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          .pci_function = 0,
>          .pci_flags = 0,
>          .pci_segment = 0,
> +        .uart_clk_freq = 0,
> +        .precise_baudrate = 0,
> +        .namespace_string_length = sizeof(name),
> +        .namespace_string_offset = 88,
>      };
>  
> -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
> +    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_table_id,
> +               name);
>  }
>  
>  /*
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..5fa3942491 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -176,14 +176,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>  
>  /*
>   * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
>   */
>  
>  static void
>  spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>  {
> +    const char name[] = ".";
>      AcpiSpcrData serial = {
> -        .interface_type = 0,       /* 16550 compatible */
> +        .interface_type = 0x12,       /* 16550 compatible */
>          .base_addr.id = AML_AS_SYSTEM_MEMORY,
>          .base_addr.width = 32,
>          .base_addr.offset = 0,
> @@ -205,9 +206,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>          .pci_function = 0,
>          .pci_flags = 0,
>          .pci_segment = 0,
> +        .uart_clk_freq = 0,
> +        .precise_baudrate = 0,
> +        .namespace_string_length = sizeof(name),
> +        .namespace_string_offset = 88,
>      };
>  
> -    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
> +    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_id,
> +               name);
>  }
>  
>  /* RHCT Node[N] starts at offset 56 */
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 0e6e82b339..2e6e341998 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
>      uint8_t flow_control;
>      uint8_t terminal_type;
>      uint8_t language;
> -    uint8_t reserved1;
>      uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
>      uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
>      uint8_t pci_bus;
> @@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
>      uint8_t pci_function;
>      uint32_t pci_flags;
>      uint8_t pci_segment;
> -    uint32_t reserved2;
> +    uint32_t uart_clk_freq;
> +    uint32_t precise_baudrate;
> +    uint32_t namespace_string_length;
> +    uint32_t namespace_string_offset;
> +    char namespace_string[];
>  } AcpiSpcrData;
>  
>  #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb..68c0f2dbee 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id);
> +                const char *oem_id, const char *oem_table_id, const char *name);
>  #endif
> -- 
> 2.34.1


