Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4031FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAuxB-0005mt-Pd; Fri, 02 May 2025 14:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAux4-0005ld-6I
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAux0-0006Y6-L5
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746209849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJnKAunZ1Djkl7EOu7Ew/I8Ps+gfCr9/BDa7pBfgzXo=;
 b=fm+rE+cWt2gEI7GJE4NhWIlTlOhMWRybNVldocdhQD79OguPv/veAalpc1LePIv5n0U4rn
 R8m9SLQzEMELPawUKxpmE9YQCyoBxP/QSH1Ut919PSXmV9eDz4OijZOAOqqeXfnk84EbpS
 Hgv5AKKIqCn6QU3VSbFxLDixN7pHiNc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-pinFxsA-PHOC3bkyaYU8iA-1; Fri, 02 May 2025 14:17:28 -0400
X-MC-Unique: pinFxsA-PHOC3bkyaYU8iA-1
X-Mimecast-MFC-AGG-ID: pinFxsA-PHOC3bkyaYU8iA_1746209848
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c09f73873fso351431185a.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746209848; x=1746814648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJnKAunZ1Djkl7EOu7Ew/I8Ps+gfCr9/BDa7pBfgzXo=;
 b=vjotMSPf/HJcQ6v+n3e01gRY7XohQDLeii7uT+JcqCv7mMQU5XazBjowZsIVH0+1BG
 +9C6OsbaT0VJttr20XKWWGE6KdJjzyH+jzReh6j2YlXSh+wEJk4DtKMWOjx3CYSg9LRP
 R1MUEeDBFfk/ZgKK/+Lv//e5kHwZbPeaEi2n5AR7W+5RbpAvMN3bbzM+b+VgvUrG5Ohe
 TmNPLrea6Le5vbUXAJAFAFk5SCOW/Z4ulxhh+GgcPe8kuGcUHgztbYvzjOF4KRDF+NpG
 b2Ggy4bMiOuhVnn46zs4W5wSjLmDEJu4GoJhfMN5pRPgvla5V0apFa8TxmCygF3uE2kw
 z/tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWbOdxBCpm1nvbS9AaIttbNjkvs7nFL9DHqdrx6oN8+XcvgU24mdhkEzxggyv4DE+GAcF6TnhQ95dG@nongnu.org
X-Gm-Message-State: AOJu0YxzJqhGlH2m06XdP5o+4abdObwNGTfSbcZSDt4fRAINQk7YZ/Ns
 LJFJrLPkJl69bZ5uNaRrHcmgij2+AMuf0PdsL8/ymsYTs40LCx7LYZd1x0qMatB/6Z6YyS6jv5q
 bJLsSXGmlMvZ/nNdQpRDkN6hD/33Uij4n2/wKzDkMo/8aZ+yXB4Gm
X-Gm-Gg: ASbGncubMGDAIXR3d4aH9IpHu+7FeQK1SRjW7es4YSvVjEUCXulT3KSYdpyU4p/MEnv
 A/rEEDGFURRAKeTiS6nl16qZTJ/VPbkodIjC88z/k6w1Jj3frVT4kzWcUraJAmGwwFDlqXI9Rep
 +QvRX32ivLEPLVCiNfDKr3QD5FdhjPZitrmH8O7DUxsaxA3CQQFALTPrqzUKMpC04horCiF/Tf8
 2YR8q8oaxcAmiAMYWnGijxv5EMZNaBjNq/9plz68JbkL3eSpSkXn2iHDWrAYIZmiZa5DlFMNVIf
 SFaaBzxEY3Fg
X-Received: by 2002:a05:622a:5585:b0:479:2509:528a with SMTP id
 d75a77b69052e-48c32ac7333mr58708101cf.42.1746209847982; 
 Fri, 02 May 2025 11:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR+KliBMOy+ZyDdiVaubEILS4dM3R5wu6AwSglnNS1l/jR66arUKJ4Ro233+sWgGGr2E8+LQ==
X-Received: by 2002:a05:622a:5585:b0:479:2509:528a with SMTP id
 d75a77b69052e-48c32ac7333mr58707841cf.42.1746209847697; 
 Fri, 02 May 2025 11:17:27 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b98d0fb2dsm20974591cf.77.2025.05.02.11.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 11:17:27 -0700 (PDT)
Message-ID: <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
Date: Fri, 2 May 2025 14:16:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/2/25 6:27 AM, Shameer Kolothum wrote:
> Although this change does not affect functionality at present, it lays
> the groundwork for enabling user-created SMMUv3 devices in
> future patches
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
>   hw/arm/virt.c   |  3 ++-
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..605de9b721 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -24,6 +24,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-core.h"
>   #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>   #include "cpu.h"
>   #include "exec/target_page.h"
>   #include "trace.h"
> @@ -1874,6 +1875,25 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>       smmuv3_init_regs(s);
>   }
>   
> +static int smmuv3_pcie_bus(Object *obj, void *opaque)
> +{
> +    DeviceState *d = opaque;
> +    PCIBus *bus;
> +
> +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
> +        return 0;
> +    }
> +
> +    bus = PCI_HOST_BRIDGE(obj)->bus;
> +    if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
> +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
> +                                 &error_abort);
> +        /* Return non-zero as we got the bus and don't need further iteration.*/
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>   static void smmu_realize(DeviceState *d, Error **errp)
>   {
>       SMMUState *sys = ARM_SMMU(d);
> @@ -1882,6 +1902,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       Error *local_err = NULL;
>   
> +    if (!object_property_get_link(OBJECT(d), "primary-bus", &error_abort)) {
> +        object_child_foreach_recursive(object_get_root(), smmuv3_pcie_bus, d);
> +    }
> +
>       c->parent_realize(d, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> @@ -1996,6 +2020,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>       device_class_set_parent_realize(dc, smmu_realize,
>                                       &c->parent_realize);
>       device_class_set_props(dc, smmuv3_properties);
> +    dc->hotpluggable = false;
> +    dc->bus_type = TYPE_PCIE_BUS;
Does this force legacy SMMUv3 to be tied to a PCIe bus now?
if so, will that break some existing legacy smmuv3 configs?, i.e., virtio-scsi attached to a legacy smmuv3.

>   }
>   
>   static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 177f3dd22c..3bae4e374f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -56,6 +56,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/virtio/virtio-pci.h"
>   #include "hw/core/sysbus-fdt.h"
> @@ -1442,7 +1443,7 @@ static void create_smmu(const VirtMachineState *vms,
>       }
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,


