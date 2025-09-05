Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42023CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuS2i-0002lO-K3; Fri, 05 Sep 2025 04:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuS2R-0002co-DF
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuS2K-0007RQ-I1
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757061784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQhLshlqLpdrWmdUkHjxY52FvGwLrvRq5tezYToIO0Y=;
 b=HUp8lvoZ9LPWj72zdMcORo6LPPRlR69mUv3xRs3Lo4KHWDYd3DsKdRfpklm7ArE+nFSJLb
 D1eRTNvL6o5kDp1wFSRMMmuMGhYz9UMRNXTjtgRreBwy6JlqGel90M8Ol/J5ucrZ9rmIgQ
 KiwE0in70NFb4wXWAqr/qN4XNNLPyfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-mgHz2UNpOju24e99QeYeOQ-1; Fri, 05 Sep 2025 04:43:03 -0400
X-MC-Unique: mgHz2UNpOju24e99QeYeOQ-1
X-Mimecast-MFC-AGG-ID: mgHz2UNpOju24e99QeYeOQ_1757061782
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b9ca27a11so13341595e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 01:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757061782; x=1757666582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQhLshlqLpdrWmdUkHjxY52FvGwLrvRq5tezYToIO0Y=;
 b=ibaE8smdnZ5qBnnVr7tDIa5G335MfJIFRWlu8itLCm8bose1aRAZPQmSuzLUSPrDCn
 jcCno95PMLTeBkcCRasRjv0aN2xO9HP6j/3kkk53yx1rSdcF5OG93xHkj3BBTpGDheXY
 4WNIr+Vda1WxkreVEwL4gxCgq6mi9jvVRP5Z8nio0nQu5apzywkEOkSMpEK249bRL6Bd
 sQhu9Y4pkJB0c/5MeuxHhkbyyfs2AUzxFxhMzvdHPv/bq9xcEOWJPScjwIy9Ky/6fxxj
 cI6oq+PMKYiEomk18gj1Agl/lBQadust9G6SPixFBFBJ0EKIkZNZFx/J3Ukw9k/orHk+
 8pGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhqxmiuvUVglTIJgJFPnRK+TWghgfMi2p4vmq2GycGS5PInIbmRmAxGW3i4Aq0SlhyLScmJxRqkgxU@nongnu.org
X-Gm-Message-State: AOJu0Yww5BDyXwVDSz+bTKFt+jHeF0eW1/0MvH8kcGM5HD4XE0TJV1di
 eVmcq9HJqgFkOg4DVWli9QadVofiLpyGrbDY9S51q12WZEHLbPXy6+r1DbDPHDu8M+qYa/dOSi/
 9S3NaZOBa7w17Oyc9j27DBe7r8cx5x3Slv/OCBgISddT9ODyLY4KEkyvU
X-Gm-Gg: ASbGnctF2B3NmbbIQyc2ncbWkUUTOPTaKv3cF9Q2I1TwN7Mq5HNjetHBtzHcG/jViAu
 aTgF/Y+Lw0QKrbKGk+px7Le1zLggtVzxIai+1hWXMrUoJM2E/suLvbBNFTonXAGoKOz24d/tk+w
 tTuR2tdb31H+ZQWCAUizxOe592AOW6EEfN4OEbOgiDzdXRvVRwzVkD3CR8JOgQ2yRRcxKIo2bTZ
 giboFjMjgfVPX8yVyiC5q0zS/Pekxw5p/C3VU6RDmH6kINEAAoKCkVgrMdFnK8+s69+EBKyQCB/
 ZHJIEujYZIgvnUeBYXxe+Vl9jPLwA+WDAGo7IlMV7P1WHrli1iM4QdBn/E3KuCw1yIigOdPgZNh
 BF/toj6mnzbo=
X-Received: by 2002:a05:6000:64c:b0:3e3:c69e:a1ca with SMTP id
 ffacd0b85a97d-3e3c69ea5c3mr1199736f8f.10.1757061781890; 
 Fri, 05 Sep 2025 01:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfHs8OlhI75MyapHmJXmYqo+pUNJMeFA+JCo5kww5W2z4epg6ZYGTjKcJPlY4u8lT1cwq4vA==
X-Received: by 2002:a05:6000:64c:b0:3e3:c69e:a1ca with SMTP id
 ffacd0b85a97d-3e3c69ea5c3mr1199706f8f.10.1757061781441; 
 Fri, 05 Sep 2025 01:43:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9d37sm30914926f8f.49.2025.09.05.01.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 01:43:00 -0700 (PDT)
Message-ID: <f6980853-3559-4a7a-afcc-5a7a2385335b@redhat.com>
Date: Fri, 5 Sep 2025 10:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, skolothumtho@nvidia.com
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> Accelerated SMMUv3 is only useful when the device can take advantage of
> the host's SMMUv3 in nested mode. To keep things simple and correct, we
> only allow this feature for vfio-pci endpoint devices that use the iommufd
> backend. We also allow non-endpoint emulated devices like PCI bridges and
> root ports, so that users can plug in these vfio-pci devices.
>
> Another reason for this limit is to avoid problems with IOTLB
> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
> SID, making it difficult to trace the originating device. If we allowed
> emulated endpoint devices, QEMU would have to invalidate both its own
> software IOTLB and the host's hardware IOTLB, which could slow things
> down.
>
> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
> translation (S1+S2), their get_address_space() callback must return the
> system address space to enable correct S2 mappings of guest RAM.
>
> So in short:
>  - vfio-pci devices return the system address space
>  - bridges and root ports return the IOMMU address space
>
> Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
> Hence, if a vfio-pci device is behind the SMMuv3 with translation enabled,
> it must return the IOMMU address space for MSI. Support for this will be
> added in a follow-up patch.
It sounds antithetical to what is said above:

"vfio-pci devices return the system address space"

Eric

>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c               | 50 ++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel.h               | 15 +++++++++
>  hw/arm/smmuv3.c                     |  4 +++
>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>  include/hw/arm/smmuv3.h             |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  6 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 2eac9c6ff4..0b0ddb03e2 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -7,13 +7,19 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/vfio/pci.h"
> +
>  #include "smmuv3-accel.h"
>  
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> +    SMMUv3State *s = ARM_SMMUV3(bs);
>      SMMUDevice *sdev = sbus->pbdev[devfn];
>      SMMUv3AccelDevice *accel_dev;
>  
> @@ -25,30 +31,72 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>  
>          sbus->pbdev[devfn] = sdev;
>          smmu_init_sdev(bs, sdev, bus, devfn);
> +        address_space_init(&accel_dev->as_sysmem, &s->s_accel->root,
> +                           "smmuv3-accel-sysmem");
>      }
>  
>      return accel_dev;
>  }
>  
> +static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> +{
> +
> +    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> +        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
> +        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
> +        return true;
> +    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
> +        object_property_find(OBJECT(pdev), "iommufd"))) {
> +        *vfio_pci = true;
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>                                                int devfn)
>  {
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      SMMUState *bs = opaque;
> +    bool vfio_pci = false;
>      SMMUPciBus *sbus;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUDevice *sdev;
>  
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        error_report("Device(%s) not allowed. Only PCIe root complex devices "
> +                     "or PCI bridge devices or vfio-pci endpoint devices with "
> +                     "iommufd as backend is allowed with arm-smmuv3,accel=on",
> +                     pdev->name);
> +        exit(1);
> +    }
>      sbus = smmu_get_sbus(bs, bus);
>      accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>      sdev = &accel_dev->sdev;
>  
> -    return &sdev->as;
> +    if (vfio_pci) {
> +        return &accel_dev->as_sysmem;
> +    } else {
> +        return &sdev->as;
> +    }
>  }
>  
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
>  };
>  
> +void smmuv3_accel_init(SMMUv3State *s)
> +{
> +    SMMUv3AccelState *s_accel;
> +
> +    s->s_accel = s_accel = g_new0(SMMUv3AccelState, 1);
> +    memory_region_init(&s_accel->root, OBJECT(s), "root", UINT64_MAX);
> +    memory_region_init_alias(&s_accel->sysmem, OBJECT(s),
> +                             "smmuv3-accel-sysmem", get_system_memory(), 0,
> +                             memory_region_size(get_system_memory()));
> +    memory_region_add_subregion(&s_accel->root, 0, &s_accel->sysmem);
> +}
> +
>  static void smmuv3_accel_class_init(ObjectClass *oc, const void *data)
>  {
>      SMMUBaseClass *sbc = ARM_SMMU_CLASS(oc);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 4cf30b1291..2cd343103f 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -9,11 +9,26 @@
>  #ifndef HW_ARM_SMMUV3_ACCEL_H
>  #define HW_ARM_SMMUV3_ACCEL_H
>  
> +#include "hw/arm/smmuv3.h"
>  #include "hw/arm/smmu-common.h"
>  #include CONFIG_DEVICES
>  
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
> +    AddressSpace as_sysmem;
>  } SMMUv3AccelDevice;
>  
> +typedef struct SMMUv3AccelState {
> +    MemoryRegion root;
> +    MemoryRegion sysmem;
> +} SMMUv3AccelState;
> +
> +#if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
> +void smmuv3_accel_init(SMMUv3State *s);
> +#else
> +static inline void smmuv3_accel_init(SMMUv3State *d)
> +{
> +}
> +#endif
> +
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index bcf8af8dc7..2f5a8157dd 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -32,6 +32,7 @@
>  #include "qapi/error.h"
>  
>  #include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
>  
> @@ -1898,6 +1899,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      sysbus_init_mmio(dev, &sys->iomem);
>  
>      smmu_init_irq(s, dev);
> +    if (sys->accel) {
> +        smmuv3_accel_init(s);
> +    }
>  }
>  
>  static const VMStateDescription vmstate_smmuv3_queue = {
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 1bcceddbc4..a8eb2d2426 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -48,7 +48,6 @@ struct PXBBus {
>      char bus_path[8];
>  };
>  
> -#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
>  
>  static GList *pxb_dev_list;
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..3bdb92391a 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,7 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +    struct SMMUv3AccelState  *s_accel;
>  };
>  
>  typedef enum {
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index a055fd8d32..b61360b900 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
>  
>  #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>  #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
> +#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>  


