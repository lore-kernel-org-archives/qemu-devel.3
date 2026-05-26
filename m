Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4355BCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqSX-0001OT-Sy; Tue, 26 May 2026 08:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqSO-0001Na-Tm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqSL-0004Cs-Ja
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779796819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChcPMDadlrI6rIB9RhY/JovaQ2suNNr3Fi9Cc4LIR/8=;
 b=jBtktm52g4TNpvaRSr5u0PUf19DkbPtv7G2coxXiZlj2Ol2dMG1P4kTXWcM7YBhRsIGJ0z
 rFYDd59RF59srmJxM+TtmDmQDnWMk1ynTdeHkoH2luG3e5VKs4JBrw0SXzdGg9e0i9CZ5R
 kkdyCN281kw2Qmll5KxwjKYdUi8KwGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-hzzz4bv9OCuWG4m2z_IKgQ-1; Tue, 26 May 2026 08:00:17 -0400
X-MC-Unique: hzzz4bv9OCuWG4m2z_IKgQ-1
X-Mimecast-MFC-AGG-ID: hzzz4bv9OCuWG4m2z_IKgQ_1779796817
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd233d1e2so16668825e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779796817; x=1780401617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChcPMDadlrI6rIB9RhY/JovaQ2suNNr3Fi9Cc4LIR/8=;
 b=hAaMbgs4LdVyAjwW641RpLV0tRLtXK0KWebJ19/fJg6EkOyOgTeHUIqW3Suifh0Aa/
 LAsMk1CcrM0Lb9iU2JPEZtqo9rkZvddcuvXwdnAXqLw5sxG6mQpYhFKHts1DaZowTi1F
 vJwNrwBkZPtOEMKCDvPlFii+TuUbT3ZB8+iXaUSAI68VTucX7snrB2FG5eD96SwYYTBA
 plDfcoIZTaLmti1MZFny05izWOIgjKWjBbcE55JJYNHnn2k0WlJlEIFMB1MHB2r7CrLQ
 Www4wDcyjVkHjSisx8dns9pLOLKrSBSwMu35S49Qyi7E8+cz01/NC+OL/KLb1voCp+dg
 yzUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QX4pd1f+IIsUTG4+ljG2MqxKSGlMrF+xi6QEyWej5DcZtEaIT4lzeZ0klzFuQIhZxgmQ46OGqtPLl@nongnu.org
X-Gm-Message-State: AOJu0Yx6BKYONeBw5MMiB8HBixJuWt9JzNgVTxYBkzJrISttVLvDCLhh
 dtmLjBrncUuz+1wmDnQM6+lbGdttmoE+qVsr+gRwqoRBiSfu01b/mML4pCDKKdvsoggrFaCjsBx
 54wfy5JZuDwUFwEMFHgDMLOUcTA5E5zDNX8Xh2PvfNp/oy6FjkFVpSE6W
X-Gm-Gg: Acq92OH2PwkwRXMr7jXnTx+jx4zADqb0BLkbahYxNy11FYQQABYuT+GeBEJ4Lirxp6h
 h4QT2+m7jx4lP+7w3Nez1dRchKZTBlrFtvy4yF6tLCBtlhuh83UV0wIgvsgGsEehk2391jIHYNp
 nUF8W91tv5rCjfQ1bP1ejahSgVBXCjKQm+/BS3aOge/P2Y7tw5ZLGigEvL4J2OBoULmSYQ/ZLlz
 +ETBSQ4Hvp/ji45cRd1OdZqtcDEaLhClLY2uoLzTcfoTUbKm52SBcM0y3l0gpgu1+5pmnnsfJdS
 UcW4dkGsApIf4D9nTSOEIX13vNdAWxzx6gJNqSz7lHuxrnRj5DQZrxGR8TVDP4rU3aPkILOpHDp
 pXTZhIC69hFec6gTVYpb09UmH1JNCWWiWwU9KX6fPoBVdJcDurGFCvDpvbV5T6Ztn3485lw==
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id
 5b1f17b1804b1-490482c44ddmr300238565e9.24.1779796816216; 
 Tue, 26 May 2026 05:00:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id
 5b1f17b1804b1-490482c44ddmr300235405e9.24.1779796813946; 
 Tue, 26 May 2026 05:00:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045262c8dsm170633525e9.2.2026.05.26.05.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:00:13 -0700 (PDT)
Message-ID: <300179da-7963-4540-acc0-d97c93c7c2c2@redhat.com>
Date: Tue, 26 May 2026 14:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/32] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes
 in DSDT
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-31-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-31-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/19/26 12:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
> created with tegra241-cmdqv.
>
> For each accelerated SMMUv3 instance, add a Tegra241 CMDQV device
> object under the DSDT \_SB namespace, with HID "NVDA200C" and a UID
> that matches the Identifier of the corresponding SMMUv3 IORT node, so
> the guest OS can associate the DSDT device with the right SMMU. The
> _CRS covers the CMDQV MMIO aperture plus its interrupt, and _CCA
> declares I/O cache coherency.
>
> See ACPI Specification 6.5, Section 6 (Device Configuration) for
> _HID/_UID/_CCA/_CRS.
>
> Generated DSDT entry for a CMDQV instance paired with SMMUv3 Identifier=1:
>   ...
>   Device (CV01)
>   {
>       Name (_HID, "NVDA200C")  // _HID: Hardware ID
>       Name (_UID, One)  // _UID: Unique ID
>       Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>       Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>       {
>           QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>               0x0000000000000000, // Granularity
>               0x000000000C080000, // Range Minimum
>               0x000000000C0CFFFF, // Range Maximum
>               0x0000000000000000, // Translation Offset
>               0x0000000000050000, // Length
>               ,, , AddressRangeMemory, TypeStatic)
>           Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
>           {
>               0x00000094,
>           }
>       })
>   }
>   ...
> Generated IORT SMMUv3 node (Identifier = 1):
>
>   ...
>   [048h 0072 001h]                        Type : 04
>   [049h 0073 002h]                      Length : 0058
>   [04Bh 0075 001h]                    Revision : 04
>   [04Ch 0076 004h]                  Identifier : 00000001
>   [050h 0080 004h]               Mapping Count : 00000001
>   [054h 0084 004h]              Mapping Offset : 00000044
>   ...
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |  1 +
>  2 files changed, 53 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9d05982137..99490aa7b1 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -65,6 +65,9 @@
>  #include "target/arm/cpu.h"
>  #include "target/arm/multiprocessing.h"
>  
> +#include "smmuv3-accel.h"
> +#include "tegra241-cmdqv.h"
> +
>  #define ARM_SPI_BASE 32
>  
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
> @@ -1121,6 +1124,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
> +{
> +    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
> +        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
> +        PlatformBusDevice *pbus;
> +        Aml *dev, *crs, *addr;
> +        SysBusDevice *sbdev;
> +        hwaddr base;
> +        uint32_t id;
> +        int irq;
> +
> +        if (smmuv3_accel_cmdqv_type(obj) != SMMUV3_CMDQV_TEGRA241) {
> +            continue;
> +        }
> +        id = object_property_get_uint(obj, "identifier", &error_abort);
> +        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +        sbdev = SYS_BUS_DEVICE(obj);
> +        base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> +        base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +        irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> +        irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +        irq += ARM_SPI_BASE;
> +
> +        dev = aml_device("CV%.02u", id);
> +        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(id)));
> +        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +        crs = aml_resource_template();
> +        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> +                                AML_CACHEABLE, AML_READ_WRITE, 0x0, base,
> +                                base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
> +                                TEGRA241_CMDQV_IO_LEN);
> +        aml_append(crs, addr);
> +        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
> +                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
> +                                      (uint32_t *)&irq, 1));
> +        aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +        aml_append(scope, dev);
> +
> +        trace_virt_acpi_dsdt_tegra241_cmdqv(id, base, irq);
> +    }
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -1185,6 +1233,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
>  
> +    if (!vms->legacy_smmuv3_present) {
> +        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
> +    }
> +
>      aml_append(dsdt, scope);
>  
>      pci0_scope = aml_scope("\\_SB.PCI0");
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 5ebb3dc9ea..e49a2b324d 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
>  
>  # virt-acpi-build.c
>  virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
> +virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
>  
>  # smmu-common.c
>  smmu_add_mr(const char *name) "%s"


