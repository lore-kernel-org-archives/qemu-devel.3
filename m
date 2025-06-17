Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E931CC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSZb-0003IS-EP; Tue, 17 Jun 2025 05:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSZV-0003Gn-HQ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSZQ-0006qR-FP
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750152331;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCvYnmfUh3k8L/nZQL0ryA8dOhrVVEcQo/AQMdvdIgw=;
 b=CsQprP/MVHlaiyWIXNP3xTi3HJfsWEiudxhJr3ZfptnZaZkweJErIDJNVNHQh03NiABBWy
 zYBpgzxLX66o8lr0UNFtlojpaatuc7CbNK4YB6m4A/ki1Adri0nUUr+bcVGLCO4wJqrKSc
 DzSUhbAIZDUD1C3Kh8qic249g8U9pvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-vY8ahxVePVyO9nN6BQP6mA-1; Tue, 17 Jun 2025 05:25:28 -0400
X-MC-Unique: vY8ahxVePVyO9nN6BQP6mA-1
X-Mimecast-MFC-AGG-ID: vY8ahxVePVyO9nN6BQP6mA_1750152327
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso33074795e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750152327; x=1750757127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BCvYnmfUh3k8L/nZQL0ryA8dOhrVVEcQo/AQMdvdIgw=;
 b=fjz0P0y2jhx4gVLhB5tuDN6HAXWClW165AbIyPa7Old21wazDx92J+TM78feF6TKcu
 yBKzThDPfMDsmVGeDNEKv2F+7uhZ4xhrbFl13cktzJ39NtNLbxyfnSSgOJb479j/0u9N
 9JQ0Hx7C3hTB0CbBXLV3MoNR6M5iOm1X2x5i4KZwzX7Am7E9ZtP3Vy2i+127egZORRM8
 R51ENOy45BuDLu6pjxU44Cju7iVY2/A7lMk7thwovNPUJghT9vaHlb7DQlJKk623+jPo
 FepOlPDkGq8E9oVW48Us2CLoWqCTgIWFRaOM/ARx4bhfkBGZ66joNlJA1LJR60mAxMzz
 s8qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzKZHvva1f3O9ou4s1MUA8yrpwJWV2oo2V+cOlvQlUVw8+Gewtk/No5Poue46KF87r6nmN0lyFvs1@nongnu.org
X-Gm-Message-State: AOJu0YwK3JUFfCWitEFVNLe4JQupYI9TyO0/AJQEwKpVinxM/qqK3Ake
 68DvKVUo+clfN4zXryQXjOm6AKZTZ51LrQZTJTM44iYdVS073kh9rLq1kqkbLYDgSkV/usDn8vd
 VtxzRvjCK5bjgK7212tmocVW6FFh/eU6qphaP4hj0bK0BpNukM7SaC3W1
X-Gm-Gg: ASbGncs5bGQbi3M28u0AgFggLOMczLOstTP9Fhi3f2Y1TuGsSTPYT2heTnSD1nX8ehw
 hcQUMoUsAYZ89jsxQUiCGDYEssj3NMMgT0SwTGKPWWOHNXnjB4+T+5gyLaQGaJ8/FQ1lu83yKDF
 Fs2wOEd+sYfSgktn23qCgSM240WyYdgkv189M5Jy/wWP8S4yECmi6YCqTLQamCIVdbkz/dmDA+2
 FQT0Jv0vcnzMO7pSC/dAK+0sLUkaGtZCGzpyTwEQ7RT8hl3m1K0+Q0t1jeGL2ex0Cb7n5MDSWJ4
 Os8Xs1bFhwL+kPq4Zoe+XIW8oB2KmHDT2RNi0+6dAXMXP/qNkCAZWnlGcZN3ALbyYJQ0MQ==
X-Received: by 2002:a05:600c:1da8:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-4533ca6762cmr121599965e9.14.1750152326913; 
 Tue, 17 Jun 2025 02:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm4h75K5VeAYnPOElgKAsTwh2AYpFU1pYDu7kTFnCk33CWYBWdo0t/GHRlSyLEdKIrdG0L5w==
X-Received: by 2002:a05:600c:1da8:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-4533ca6762cmr121599715e9.14.1750152326464; 
 Tue, 17 Jun 2025 02:25:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13cfbesm170841525e9.22.2025.06.17.02.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 02:25:25 -0700 (PDT)
Message-ID: <8704b4ec-d0b4-4c6c-95fb-dbe597d16a9e@redhat.com>
Date: Tue, 17 Jun 2025 11:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250613144449.60156-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,
On 6/13/25 4:44 PM, Shameer Kolothum wrote:
> Allow cold-plug of smmuv3 device to virt if there is no machine
> wide legacy smmuv3 or a virtio-iommu is specified.
>
> Device tree support for new smmuv3 dev is limited to the case where
> it is associated with the default pcie.0 RC.
>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c      |  2 ++
>  hw/arm/virt.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/core/sysbus-fdt.c |  3 +++
>  3 files changed, 52 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..bcf8af8dc7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      device_class_set_parent_realize(dc, smmu_realize,
>                                      &c->parent_realize);
>      device_class_set_props(dc, smmuv3_properties);
> +    dc->hotpluggable = false;
> +    dc->user_creatable = true;
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index eeace4754d..3be007d87c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -56,6 +56,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/core/sysbus-fdt.h"
> @@ -1443,6 +1444,28 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
>      g_free(node);
>  }
>  
> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
> +                                  DeviceState *dev, PCIBus *bus)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    MachineState *ms = MACHINE(vms);
> +
> +    if (strcmp("pcie.0", bus->qbus.name)) {
> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
> +        return;
> +    }
> +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +
> +    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
> +    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> +                           0x0, vms->iommu_phandle, 0x0, 0x10000);
> +}
> +
>  static void create_smmu(const VirtMachineState *vms,
>                          PCIBus *bus)
>  {
> @@ -2931,6 +2954,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
> +            error_setg(errp, "virt machine already has %s set. "
> +                       "Doesn't support incompatible iommus",
> +                       (vms->legacy_smmuv3_present) ?
> +                       "iommu=smmuv3" : "virtio-iommu");
> +        }
>      }
>  }
>  
> @@ -2954,6 +2984,22 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
> +            PCIBus *bus;
> +
> +            bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
> +                                                   &error_abort));
> +            if (pci_bus_bypass_iommu(bus)) {
> +                error_setg(errp, "Bypass option cannot be set for SMMUv3 "
> +                           "associated PCIe RC");
> +                return;
> +            }
> +
> +            create_smmuv3_dev_dtb(vms, dev, bus);
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -3156,6 +3202,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index c339a27875..e80776080b 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -31,6 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "system/device_tree.h"
>  #include "system/tpm.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/platform-bus.h"
>  #include "hw/vfio/vfio-platform.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
> @@ -518,6 +519,8 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_TPM
>      TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
>  #endif
> +    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
> +    TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
>      TYPE_BINDING("", NULL), /* last element */


