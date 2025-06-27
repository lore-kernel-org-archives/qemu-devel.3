Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F76C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7qI-0007sZ-Pq; Fri, 27 Jun 2025 08:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7pr-0007qH-9d
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7po-0001xa-Th
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751025934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lek3TYxnGDlmuZNyXK2WeUfq2rrSXm5nt8GyGI53kDQ=;
 b=FFHC/SEiGeLC0KNJMp5uavPRkOgws9zV8KAwzryKiqqjnak0HH0Zu8h3WZGs6E1eV+tJ0L
 37MeNdl3CzkYPRyjCRuEnev5NvJgxzkqNm6k17N6VcxPLIk4xMaoRWcOf5tUUdj67698LO
 cCeJOVforcjjt3JnQZyutPUZ4A1nnk8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-2QTitAqPOgGmAZxqUy4-fQ-1; Fri, 27 Jun 2025 08:05:32 -0400
X-MC-Unique: 2QTitAqPOgGmAZxqUy4-fQ-1
X-Mimecast-MFC-AGG-ID: 2QTitAqPOgGmAZxqUy4-fQ_1751025931
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso11951215e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025931; x=1751630731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lek3TYxnGDlmuZNyXK2WeUfq2rrSXm5nt8GyGI53kDQ=;
 b=MHhJ6ha76SJrgRfqTNrQNT+JWQoEuJz3lhtHMP7kN1hmBJjNGCGVfuHc+jtkQjx5pO
 25bfzEYHxZ8vIxqd8QEg/mvsaRJ2XXFRaStmM8EjhYZ3qXspHoS012B1CUv4kaJZ1gLW
 KolSUphdayOGed2c4101mfnSrT1vwalQRs9UqPpc4g1zHScMnZie8gG87whT/Jat2xHa
 sq/BQrj2xiqAaAPgLr2dQM0p4tenKHskQHO1rOlBhIK3DOnKx+Eew+FkwVqHljLxywgN
 zi02OsYEAkoXH5umkAFCX7uTRyP1XPvNpW08D7izmeifXjZxWH+osvYEd4+S61kk09rW
 3B7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXySbKgNGWS9ex2As8AhYkpUQMakq4T5GYuwRGX3p1/Uac3Ssv+BpcU+HCtY7te4U9T17SPQAeWIZ3b@nongnu.org
X-Gm-Message-State: AOJu0Yx1GL7xKFnVUFpwOEMot3zhUA4Ue7YsbWCpFa6gGribdrxnvD+F
 cwWVPYKD5ZBV88j17AEi/cey4xa0/fbUDfF1YFojKATC7BD3wK2h8gsxMxVhbcc8YVCX8WqGYed
 3/fdFWzTMfBz7yjmyBuUc1QQJEf7WprT7QVfY/RkDtMTFh/JBP7Z2S6vN
X-Gm-Gg: ASbGncv8xYKclscF1TEdH/4HqqBGDi0ZcULuhc/lkE8WKglIeGgNswj4ho/jBNc4/sq
 LlO8+8DOmhcv+NxRwooPeYvoTuA2H1Z2PCogSMLgR+PYkHbgnmeX9E4ZOyxtFxn2sQZ/FNVNg1d
 fURobe8Ssw8gaplr0nBdpHt86W9LHjFL9mFWWM85i8guUYi8WWBzmvGWFiOjKCHbuZ+/a2WGO3K
 TYlz5BegwpFK21AS+dwk13d9CFKO99NSSZMUZ9bSMIM8xXPEKKtbBXNL6sXog9Vo63pYj9uNqBq
 svjo2dH7LsZcZVv7HzH28qAndOv96lfgnkjIxz1j+O9l7bMtM8CkSFhq31FUhgJc2ffSsA==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id
 5b1f17b1804b1-4538ee61e72mr25053205e9.20.1751025930866; 
 Fri, 27 Jun 2025 05:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Ux0yvhFmoBSSsplqBm1faGJGFFk7c/29s3tDfebyoGl/bR4ymsg5Ucz4RFs0BXOX62Y1fQ==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id
 5b1f17b1804b1-4538ee61e72mr25051415e9.20.1751025928667; 
 Fri, 27 Jun 2025 05:05:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453822c6b9fsm78820695e9.0.2025.06.27.05.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:05:27 -0700 (PDT)
Message-ID: <07d8f93a-d366-4c51-b585-242bc8aed683@redhat.com>
Date: Fri, 27 Jun 2025 14:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-8-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-8-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> Allow cold-plugging of an SMMUv3 device on the virt machine when no
> global (legacy) SMMUv3 is present or when a virtio-iommu is specified.
>
> This user-created SMMUv3 device is tied to a specific PCI bus provided
> by the user, so ensure the IOMMU ops are configured accordingly.
>
> Due to current limitations in QEMU’s device tree support, specifically
> its inability to properly present pxb-pcie based root complexes and
> their devices, the device tree support for the new SMMUv3 device is
> limited to cases where it is attached to the default pcie.0 root complex.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         |  8 +++++-
>  hw/arm/smmuv3.c              |  2 ++
>  hw/arm/virt.c                | 50 ++++++++++++++++++++++++++++++++++++
>  hw/core/sysbus-fdt.c         |  3 +++
>  include/hw/arm/smmu-common.h |  1 +
>  5 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index b15e7fd0e4..2ee4691299 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -959,7 +959,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>                  goto out_err;
>              }
>          }
> -        pci_setup_iommu(pci_bus, &smmu_ops, s);
> +
> +        if (s->smmu_per_bus) {
> +            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
> +        } else {
> +            pci_setup_iommu(pci_bus, &smmu_ops, s);
> +        }
>          return;
>      }
>  out_err:
> @@ -984,6 +989,7 @@ static void smmu_base_reset_exit(Object *obj, ResetType type)
>  
>  static const Property smmu_dev_properties[] = {
>      DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
> +    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
>      DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
>  };
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
> index ae30320c38..e52347634f 100644
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
> @@ -2932,6 +2955,16 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> +        if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
> +            error_setg(errp, "virt machine already has %s set. "
> +                       "Doesn't support incompatible iommus",
> +                       (vms->legacy_smmuv3_present) ?
> +                       "iommu=smmuv3" : "virtio-iommu");
> +        } else if (vms->iommu == VIRT_IOMMU_NONE) {
> +            /* The new SMMUv3 device is specific to the PCI bus */
> +            object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
> +        }
>      }
>  }
>  
> @@ -2955,6 +2988,22 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
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
> @@ -3157,6 +3206,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index e5e2d09294..80d0fecfde 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -161,6 +161,7 @@ struct SMMUState {
>      QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
>      uint8_t bus_num;
>      PCIBus *primary_bus;
> +    bool smmu_per_bus; /* SMMU is specific to the primary_bus */
>  };
>  
>  struct SMMUBaseClass {


