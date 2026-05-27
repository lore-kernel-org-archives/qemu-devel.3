Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADE4CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDi4-0001Hp-RC; Wed, 27 May 2026 08:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDi2-0001De-4Z
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDhz-0002FV-Hx
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779886201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmIVvUgK/Jfq8EAUgtLqo/2md2hXVkdPiMRajXFIb9U=;
 b=d7RDwzDMKv17cpP/fmrPJ8h5yWyvEaZNFt45DnBOD8J8r46lk1HSbg+jw9Tn9rjTnpCo9M
 sGsFig9XTW0PNWyi+mFEsUQsS/dOTc1xA8sI9x65/mMMdAZe43g+NMtZSE2fYktYagSCIv
 YfDtykV14ngQYvzu4TiWGpTU8lH30fw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Nmn1w8T0NWaG2K2TYq397A-1; Wed, 27 May 2026 08:50:00 -0400
X-MC-Unique: Nmn1w8T0NWaG2K2TYq397A-1
X-Mimecast-MFC-AGG-ID: Nmn1w8T0NWaG2K2TYq397A_1779886199
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so7913093f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779886199; x=1780490999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmIVvUgK/Jfq8EAUgtLqo/2md2hXVkdPiMRajXFIb9U=;
 b=LMX/FqHQG8yVzyDIet+uJSAl2ba6fIrsRPTOwwXY/NAQZPweo1kkkMGKJq9aScJP+I
 AFMBYDM8/D7DjbI2YIGhAocsGHxBp08eZG7kRbp6yqZr88b6P18QJsUZKZeI3fNPJac8
 Okj9edjJzkNA4MiPIcUbYP0EJMJkyt4tFNFLiIN/e2yDLhPDn94TRzSpJxLr/enoozbP
 1Qw74bMiuTLztbO1DR6Fi8iC2i1GY43OAnNNw6JpzDM+fMfad4DtRKF2GZupHOh5d9FI
 Hcso4ge4hnIpokLSHypnNM807umJoPukHw62saEud3XM4yuK4fWdT9/gZyZNpkpSjw6L
 YllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886199; x=1780490999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PmIVvUgK/Jfq8EAUgtLqo/2md2hXVkdPiMRajXFIb9U=;
 b=NtOs/A/1e6qBL28LIc8zN6AooH/4qpSsxhJ5TO2Y/zIYOe+xOr0YquXke3CodTB7u9
 JQxRsxLLQcbYAJ82WFs7PJA81mBch3J56iLuierJJa8x3kUBs82tvJd3EPbzNVHmVhuS
 yJAH8vyJk2gqEFYKmOYyi6phbcxfMojf/Dhmb2LfD5dJaEYfrFCdxtatsTWVOUj86i9U
 ItGiR4An0XIXF5wI9y2L9+IZP4fQP84nKEhsHs5lCgcrDVZJqOojnnrF/yLP098SppS0
 mZzEEf54M2Z6F37uZwcQKbbU3iF2ntYE9R5nw7VrVm6HuvlJaIfHcBiDbby+yZHAvO5O
 ks+Q==
X-Gm-Message-State: AOJu0YzVs4YZdJjK7231yRKcjDJdxv872C2iLbojQVHTZxvXzQBi9YJ6
 /m3sTiN8w01LDnSEK4umvLEDyGZFTwxhn+9hlDDO47oX34SzM44imFMzoaalANi+YwDTkT5tYMx
 cr+wdJ1ibgMMSBHiAJb4M1GBElN+Hf/nqY9Dpafud2iHWIDRbm0ha+hJ1
X-Gm-Gg: Acq92OEQsO8pcyHtOxfHVPXwXTKgEFT9G8Tbo8I/OnbFKSAdZ9BpTP0cSEhpSM0cgzN
 ThWWOdfzJTQtepZQTDgx8eD08owx2x3xqYJV0KA4WSwEpXqN+J3rPmExMH78qGLAcr+kjLOIE9D
 3kNeq5XFl6CeZ35pd62aj1nCAcR4q2uQRlcgku/qYJvqydJG0Pw+yHYf5aoId3OqGoJ6NlIwFFU
 22uTMUHVYul/wlBsPbSZ55gNHOTmWDazV1oZf07PpK9CK2bFpoIhHOBDXZ7+zoNvjv4uCDAHfL5
 K3Su7TOlACrw765HDsQamcCKCfl10v0X3+0vcDKRvlMMXfEmZTbzx9axRbCVP9VcNVsopcW2HJA
 2iB+TVFUV8wTX9y/s
X-Received: by 2002:a05:6000:98d:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45eb367044bmr32847958f8f.3.1779886198766; 
 Wed, 27 May 2026 05:49:58 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45eb367044bmr32847894f8f.3.1779886198288; 
 Wed, 27 May 2026 05:49:58 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c47a2sm5714702f8f.37.2026.05.27.05.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:49:57 -0700 (PDT)
Date: Wed, 27 May 2026 14:49:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Message-ID: <20260527144955.64eff309@imammedo>
In-Reply-To: <4cdd38f4-4efc-48c5-a236-a40449ad8e85@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-10-imammedo@redhat.com>
 <4cdd38f4-4efc-48c5-a236-a40449ad8e85@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 26 May 2026 15:58:08 +0200
Eric Auger <eauger@redhat.com> wrote:

> Hi Igor,
> 
> On 3/3/26 10:25 AM, Igor Mammedov wrote:
> > Allow to use SBSA generic watchdog with virt machine type.
> > (includes conditional generation of corresponding FDT and
> > ACPI GTDT descriptors)
> > 
> > Use '-device sbsa_gwdt' to command line to enable it.  
> I thank that in general Peter is not a big fan of dynamic instantiation
> of sysbus devices. Don't you have means to instantiate it statically in
> arm virt memory map?

/me neither

in previous version there was a machine option to enable the feature
to that was rejected in favor of device.

in this case for platform  -device of sysbus based device, I don't think
we can do better that dynamic sysbus. 

 
> 
> Eric
> > 
> > Tested with Fedora 43:
> >   FDT: -M virt,acpi=off -device sbsa_gwdt
> >   ACPI: -M virt -device sbsa_gwdt
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/arm/Kconfig           |  1 +
> >  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
> >  hw/arm/virt.c            |  2 ++
> >  hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
> >  hw/watchdog/sbsa_gwdt.c  |  1 +
> >  5 files changed, 67 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index c66c452737..1222efadd1 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -36,6 +36,7 @@ config ARM_VIRT
> >      select VIRTIO_MEM_SUPPORTED
> >      select ACPI_CXL
> >      select ACPI_HMAT
> > +    select WDT_SBSA
> >  
> >  config CUBIEBOARD
> >      bool
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 719d2f994e..9c14b1d4d5 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -64,6 +64,7 @@
> >  #include "hw/virtio/virtio-acpi.h"
> >  #include "target/arm/cpu.h"
> >  #include "target/arm/multiprocessing.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> >  
> >  #define ARM_SPI_BASE 32
> >  
> > @@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
> >      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
> >                          .oem_table_id = vms->oem_table_id };
> > +    uint32_t gtdt_start = table_data->len;
> > +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
> >  
> >      acpi_table_begin(&table, table_data);
> >  
> > @@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      build_append_int_noprefix(table_data, irqflags, 4);
> >      /* CntReadBase Physical address */
> >      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
> > +
> >      /* Platform Timer Count */
> > -    build_append_int_noprefix(table_data, 0, 4);
> > +    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
> >      /* Platform Timer Offset */
> > -    build_append_int_noprefix(table_data, 0, 4);
> > +    build_append_int_noprefix(table_data,
> > +        wdt ? (table_data->len - gtdt_start) +
> > +              4 + 4 + 4 /* len of this & following 2 fields to skip */
> > +            : 0, 4);
> > +
> >      if (vms->ns_el2_virt_timer_irq) {
> >          /* Virtual EL2 Timer GSIV */
> >          build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
> > @@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          build_append_int_noprefix(table_data, 0, 4);
> >          build_append_int_noprefix(table_data, 0, 4);
> >      }
> > +
> > +    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> > +    if (wdt) {
> > +        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > +        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
> > +        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> > +        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> > +        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> > +        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> > +                  platform_bus_get_irqn(pbus, sd, 0);
> > +
> > +        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
> > +        build_append_int_noprefix(table_data, 28 /* Length */, 2);
> > +        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> > +        /* RefreshFrame Physical Address */
> > +        build_append_int_noprefix(table_data, rbase, 8);
> > +        /* WatchdogControlFrame Physical Address */
> > +        build_append_int_noprefix(table_data, cbase, 8);
> > +        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
> > +        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
> > +    }
> >      acpi_table_end(linker, &table);
> >  }
> >  
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index cab2e21e8a..a87991b591 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -95,6 +95,7 @@
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_host.h"
> >  #include "qemu/guest-random.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> >  
> >  static GlobalProperty arm_virt_compat_defaults[] = {
> >      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> > @@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
> > +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
> >  #ifdef CONFIG_TPM
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> >  #endif
> > diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> > index 89d0c46445..76aa1bc579 100644
> > --- a/hw/core/sysbus-fdt.c
> > +++ b/hw/core/sysbus-fdt.c
> > @@ -36,6 +36,7 @@
> >  #include "hw/display/ramfb.h"
> >  #include "hw/uefi/var-service-api.h"
> >  #include "hw/arm/fdt.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> >  
> >  /*
> >   * internal struct that contains the information to create dynamic
> > @@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
> >      return 0;
> >  }
> >  
> > +static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
> > +{
> > +    PlatformBusFDTData *data = opaque;
> > +    PlatformBusDevice *pbus = data->pbus;
> > +    const char *parent_node = data->pbus_node_name;
> > +    void *fdt = data->fdt;
> > +    uint64_t cbase, rbase;
> > +    char *nodename;
> > +    int irq;
> > +
> > +    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
> > +    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
> > +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
> > +
> > +    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
> > +    qemu_fdt_add_subnode(fdt, nodename);
> > +
> > +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
> > +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> > +                           cbase, SBSA_GWDT_CMMIO_SIZE,
> > +                           rbase, SBSA_GWDT_RMMIO_SIZE);
> > +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
> > +                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
> > +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> > +    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
> > +
> > +    g_free(nodename);
> > +    return 0;
> > +}
> > +
> >  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
> >  {
> >      return 0;
> > @@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
> >      TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
> >      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
> >      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
> > +    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
> >      TYPE_BINDING("", NULL), /* last element */
> >  };
> >  
> > diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> > index acb970e8b3..c4dd8005b7 100644
> > --- a/hw/watchdog/sbsa_gwdt.c
> > +++ b/hw/watchdog/sbsa_gwdt.c
> > @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
> >      dc->realize = wdt_sbsa_gwdt_realize;
> >      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
> >      dc->hotpluggable = false;
> > +    dc->user_creatable = true;
> >      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
> >      dc->vmsd = &vmstate_sbsa_gwdt;
> >      dc->desc = "SBSA-compliant generic watchdog device";  
> 


