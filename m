Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0D8CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2at-0004Ox-UK; Thu, 07 May 2026 13:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2as-0004Oj-88
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2an-00052G-Ek
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778175176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo3E2XXicjBLiL0D75kG81d1vDDjJjWPFqkeiVbzQPs=;
 b=howmtpPX1h3/AsXpzItwQDgFoPP0EFhzVgXgMSzFeoUI9FHv7HyEkKRaHkGO1t7du42glt
 UoCWA8SwJTOESvMoSYBt6nttLjGL+ZAWnF941kayczSJeDkp7H/B6YTXsjf3kLL/GuRwz+
 wYPgCmy2bgeoZ1qO8Mba76wYWCt8AYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-prnvJEK7N86BF0aF9PZxfw-1; Thu, 07 May 2026 13:32:55 -0400
X-MC-Unique: prnvJEK7N86BF0aF9PZxfw-1
X-Mimecast-MFC-AGG-ID: prnvJEK7N86BF0aF9PZxfw_1778175174
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso784340f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778175174; x=1778779974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lo3E2XXicjBLiL0D75kG81d1vDDjJjWPFqkeiVbzQPs=;
 b=WgIQdQnXsdeQelhZRIjhIUnZe1YROoefbeklxBk1GjUnopu9J6SHnnX6hZFKQC/5NR
 sxvfd7LXw67oDT+KqUi93wtUu6IRfdPaVTeE24TN/XpAtnBHUJGU7oY09RGEpHvyjZq7
 ynQcr5lckuXznbikiLN00p5TTZn+nKdSB/tQfB0nvcqZzs1BPQ71rFe4As7Dysvn7sU3
 HCS1whED8aWSnTVUYunlsihN8xoIk5Q6nKGsOWrLJJ8DSJk+phtJJ7Ep/X7o2Qp1eqSM
 Y7QMzp0Zy+4dO30W7u8qoNbuhrUooPiZQQ2UTIJjE48mH/D098vLyX+9nH2azX6jIBiy
 4P6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O9YcOWxmrpDfmz1d89iEUdQDAVzHPRers4mex6oOcTLH6HozTURj3X6u6XSmfD8Knq0dOpZkyx3rR@nongnu.org
X-Gm-Message-State: AOJu0YyiOges0cNgsSdxgsc12b9nzOzwxuu7gqqRYEKFxP+g0mrPIHDW
 OTOFScncr/K1sg+Lpi3FqM6CByH3fkXiEC+QN5dTuimy1tCrrV2vprhYOSE2BA47OP2g7Jgh0n7
 ugpIF1PGFTrERiQWzphZHpm+2jlwStPVy/20JyBH4kOcyYmBTJ+Nzn4sJ
X-Gm-Gg: AeBDiev3F4o9rEVV+HXBz1I2GnDGuKlqeKSeiiM2f1w3N4cpkXP03GwGkqhe/6qEySz
 ON/l3Rc49NfnSVvkEZRHLEshtpqHuXxMVHbcrZ4Sd04iBKdOcObAAPdYv/7+G6iPkPcX5ahjXRu
 Ntra5pprRLesjD5+yB+9+uw6zf/QzUCM1SVysG7MHzHbPqyG/Po+wHE8oVjB+KEZf+pIoPsg6zh
 g/ibZb2QX1stjp4flF+uFIrHUc/CzkWqyf7PvqeBomENpvizfyA8J7yaFlrTqcP+5DJE3IhYzt+
 XrjBS1FaNYssrDJ9VTFHtL5VfpDP21KHx4sUpmja0HJSG2lMp5x8/ZNlcv3Nv3WaM5YHIyj53lQ
 D7yxOhUFKoQVNjcCOm4SxdVY7eZPjN8WXVGnX6IE8BIdzVMAA19xNX2OMGtlXm6s4KLzLxg==
X-Received: by 2002:a05:600c:8485:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48e51f2f853mr154341275e9.14.1778175173983; 
 Thu, 07 May 2026 10:32:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48e51f2f853mr154340765e9.14.1778175173498; 
 Thu, 07 May 2026 10:32:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45412cefdf1sm519368f8f.10.2026.05.07.10.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:32:53 -0700 (PDT)
Message-ID: <0926e6eb-f904-4d28-8929-563f497cfeda@redhat.com>
Date: Thu, 7 May 2026 19:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/31] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes
 in DSDT
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-30-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-30-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
> created with tegra241-cmdqv.
>
> The SMMUv3 device identifier is used as the ACPI _UID. This matches
> the Identifier field of the corresponding SMMUv3 IORT node, allowing
> the CMDQV DSDT device to be correctly associated with its SMMU.

Could you add a link to the ACPI spec to check the content of what is
generated.

maybe you can also describe the aml in the coommit msg

Thanks

Eric
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |  1 +
>  2 files changed, 53 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 65ccc96349..fbc793d06e 100644
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
> @@ -1114,6 +1117,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
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
> @@ -1178,6 +1226,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
> index 6f602b9eda..e5e4e93324 100644
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


