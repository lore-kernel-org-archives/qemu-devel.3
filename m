Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A904C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFT-0003UB-20; Tue, 08 Jul 2025 16:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDsQ-0000ic-U7
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDsK-0000av-L5
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fK/SayyC85xjWsBK0N6nN7kRK8Md2b8sI+ruNwWFLVw=;
 b=KPMyafmNBdzgXGuLgv2p9x8Nz3rNF6agyPifg1/ptSIiP0rvKwffr1wXCyQ6kOv9+6EUNV
 3naGU9jo2npH4ZPT2g0yWNni+7V/EDKLO641DkhasRjGN19tCzFshhdWc7eWWhPiyf6f9W
 p9Rj7VZBR7WqJMCP9TpUkbr/0MDGrs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-DCHcBwW7OOCPQ1tQyJZ--A-1; Tue, 08 Jul 2025 05:55:57 -0400
X-MC-Unique: DCHcBwW7OOCPQ1tQyJZ--A-1
X-Mimecast-MFC-AGG-ID: DCHcBwW7OOCPQ1tQyJZ--A_1751968557
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2518943f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 02:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968556; x=1752573356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fK/SayyC85xjWsBK0N6nN7kRK8Md2b8sI+ruNwWFLVw=;
 b=LfBMXL40hKqLO3vPxLJBZJB0lz2H5SN3nf+GAFiG0YscrwtyZGU7QD3SL23mHKItDw
 wTxTi8wrZp7j/LkNm9QoDLI5A7BzEXIxAK9NWlGBaNhFGZlb6fO/tArN+Sxtj+/XDlbe
 F4MpELMuYEBPSdMA62O/vJ98qFeBO7FRVv8ej1xuf8F6QGnSSCwoDYxcNm/yzXPuIL+I
 v+cuVOWcai+upDTOqjwS4G51B2tVY0PPPOVJnPjQdslin6lCNjbvcRanXicTydNXk2cm
 50WXsVxd6bhyCLMHBwNNUJciXj/HOGZCGQdIkmzVc2/c5WdGMNAXG4uhGgAHnFNnpWBI
 xF7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbPJs0ZjZ1BOPrGn0izIjuXs4fKtfXk2Whdj3s+srEZnRVzWmZSH9mfagpjivApXNrcY+4EdOAqGCa@nongnu.org
X-Gm-Message-State: AOJu0YzZZFepupN6ycRYwf/YeFVsMifr603lDpekwTYKvLY0cN7t0wem
 4iPaD1HhjA+NJryPz+wsUmAEZ5y3pe7/xJgwWZgE9r/W8Z9507KciWSKB9DJF20/ppDVxO6+ijD
 rdUNlZ1vXZyMxBVCF5Xvg318Coo+YDUsQXW9FMJ2gqJ9AiC5mFrKpa2RW
X-Gm-Gg: ASbGnct4TqFAYUIqoUnx+J2ttYmlkkZjJpU+JnO+Opq9+1bTtz5XH+90VI5wAP9KeDv
 rzqRiwHwzqIpQTyoyZXq4G47PYElXqRgtCA19HSh3qV2YsU+PqesAwBX7TuN91Nt4XlbTJIVpbQ
 /sYfVNCggindAeJZQe95LDDluRDnoXTj+Qxhe5aAz9RyDiTrhfTV8YWli8PmsNe+0AWwUZYkGEd
 7ZnWdTtNuukfvjvrhII2Lx77UWVR4PKhUXWBgDceVKI9XB55+1BtDtJWt6NAvJ/O5y5c+BSpdW3
 3pbz8mJfTyipCrNLQMDPHVfyE1TM3SSNgGwgYcnFKP4DtImddFBzbs9jlejPArzsu/uMBA==
X-Received: by 2002:a5d:5f47:0:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3b4964f9d83mr14014520f8f.13.1751968556355; 
 Tue, 08 Jul 2025 02:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+X4OS9emeXDPRcKnY+CjQhHTmOGkUqYxozqVvoaykOSruKBA9s+Z6PY3leCGE6s5aaaWC4A==
X-Received: by 2002:a5d:5f47:0:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3b4964f9d83mr14014477f8f.13.1751968555830; 
 Tue, 08 Jul 2025 02:55:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c4f9sm12402125f8f.88.2025.07.08.02.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:55:55 -0700 (PDT)
Message-ID: <45c112f4-bcd3-44a1-a7b9-1ff0fa807f01@redhat.com>
Date: Tue, 8 Jul 2025 11:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-9-shameerali.kolothum.thodi@huawei.com>
 <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
 <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shameer,

On 7/8/25 10:54 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Tuesday, July 8, 2025 8:41 AM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
>> gustavo.romero@linaro.org; mst@redhat.com;
>> marcel.apfelbaum@gmail.com; Linuxarm <linuxarm@huawei.com>;
>> Wangzhou (B) <wangzhou1@hisilicon.com>; jiangkunkun
>> <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3
>> dev instantiation
>>
>> Hi Shameer,
>>
>> On 7/3/25 10:46 AM, Shameer Kolothum wrote:
>>> Allow cold-plugging of an SMMUv3 device on the virt machine when no
>>> global (legacy) SMMUv3 is present or when a virtio-iommu is specified.
>>>
>>> This user-created SMMUv3 device is tied to a specific PCI bus provided
>>> by the user, so ensure the IOMMU ops are configured accordingly.
>>>
>>> Due to current limitations in QEMU’s device tree support, specifically
>>> its inability to properly present pxb-pcie based root complexes and
>>> their devices, the device tree support for the new SMMUv3 device is
>>> limited to cases where it is attached to the default pcie.0 root complex.
>>>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> Tested-by: Nathan Chen <nathanc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmu-common.c         |  8 +++++-
>>>  hw/arm/smmuv3.c              |  2 ++
>>>  hw/arm/virt.c                | 50 ++++++++++++++++++++++++++++++++++++
>>>  hw/core/sysbus-fdt.c         |  3 +++
>>>  include/hw/arm/smmu-common.h |  1 +
>>>  5 files changed, 63 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index b15e7fd0e4..2ee4691299 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -959,7 +959,12 @@ static void smmu_base_realize(DeviceState *dev,
>> Error **errp)
>>>                  goto out_err;
>>>              }
>>>          }
>>> -        pci_setup_iommu(pci_bus, &smmu_ops, s);
>>> +
>>> +        if (s->smmu_per_bus) {
>>> +            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
>>> +        } else {
>>> +            pci_setup_iommu(pci_bus, &smmu_ops, s);
>>> +        }
>>>          return;
>>>      }
>>>  out_err:
>>> @@ -984,6 +989,7 @@ static void smmu_base_reset_exit(Object *obj,
>> ResetType type)
>>>  static const Property smmu_dev_properties[] = {
>>>      DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
>>> +    DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus,
>> false),
>>>      DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>>>                       TYPE_PCI_BUS, PCIBus *),
>>>  };
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index ab67972353..bcf8af8dc7 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1996,6 +1996,8 @@ static void smmuv3_class_init(ObjectClass
>> *klass, const void *data)
>>>      device_class_set_parent_realize(dc, smmu_realize,
>>>                                      &c->parent_realize);
>>>      device_class_set_props(dc, smmuv3_properties);
>>> +    dc->hotpluggable = false;
>>> +    dc->user_creatable = true;
>>>  }
>>>
>>>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 05a14881cf..8662173c43 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -56,6 +56,7 @@
>>>  #include "qemu/cutils.h"
>>>  #include "qemu/error-report.h"
>>>  #include "qemu/module.h"
>>> +#include "hw/pci/pci_bus.h"
>>>  #include "hw/pci-host/gpex.h"
>>>  #include "hw/virtio/virtio-pci.h"
>>>  #include "hw/core/sysbus-fdt.h"
>>> @@ -1440,6 +1441,28 @@ static void create_smmuv3_dt_bindings(const
>> VirtMachineState *vms, hwaddr base,
>>>      g_free(node);
>>>  }
>>>
>>> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>>> +                                  DeviceState *dev, PCIBus *bus)
>>> +{
>>> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms-
>>> platform_bus_dev);
>>> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
>>> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
>>> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
>>> +    MachineState *ms = MACHINE(vms);
>>> +
>>> +    if (strcmp("pcie.0", bus->qbus.name)) {
>>> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
>> while testing the series I hit the warning with a rhel guest which boots
>> with ACPI.
>> I think we shall make the check smarter to avoid that.
>> maybe also check firmware_loaded and virt_is_acpi_enabled()?
> Thanks for giving it a spin. Yes, just confirmed that the warning appears.
> The above check will work, but can we make use of vms->acpi_dev for
> this check instead? It is essentially the same and I think that will work. 
>
>     if (!vms->acpi_dev && strcmp("pcie.0", bus->qbus.name))
>
> Please let me know.

with that fixed, feel free to add my

*Tested-by: Eric Auger <eric.auger@redhat.com> I have tested non
regression on legacy SMMU, SMMU device protecting pcie.0 and pxb
topologies. Looks good to me. Thanks Eric *

>
> Thanks,
> Shameer


