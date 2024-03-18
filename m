Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B3C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmEJ4-0001Qn-O9; Mon, 18 Mar 2024 10:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEIy-0001QU-OI
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEIu-00061V-Av
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710773370;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAhMlN+4Flnq/DqiBhtf/48VNc9Up6YS7bao/jvU/Gg=;
 b=G3/vPCuHtxVf0PixHmCgg7uGUKWmQ268XKXbhNe0ArPfT0JyYR/qZLthadb+bRb0xu9T+w
 sfRcKBQ7c2oE9aQayGmJqNaXh68SMeV37kjSpzpNI4qoBAbrsd8hAJZYeC6uvEeQk6h06z
 TLIGrpfOGZuvk2GUeQlkHWUdN7+XJKo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-y3tI_8xCPWScK0h1qfmvsw-1; Mon, 18 Mar 2024 10:49:28 -0400
X-MC-Unique: y3tI_8xCPWScK0h1qfmvsw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c37f2c8d21so2228696b6e.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710773363; x=1711378163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KAhMlN+4Flnq/DqiBhtf/48VNc9Up6YS7bao/jvU/Gg=;
 b=HsI8BIuyLm0nuvZbRzYlDt1l5u20a9aVP9XnKyPlNmhlqji549PYhZ24gReX5Yk0VE
 M9qdtSQfM+Prw8fuGGiY2xczxILXnk+cxejRi1pnaYjW8btBLhuDwYD/KY5RqjNLGyit
 A+dKVEXwA6xquriVQCMCK38/6Vg/cmdoyV6HiX0dW1Pe7oLO5LfW8waaf45sthBWi/8b
 3cZJl90ZrYFDEGMaiUy5XDkWIdDA2emM8AmiMRPt6eYjRciki/wHbEtaRwXlMsyeqHAh
 94zPzTqsaPHAyqbWkVwj3NGHPflHRfvfFHrWBUM5Gxs8Q5GQVZrhwy0s43YODjaU8m3a
 Nn7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR33+gKNxJU5wa406WJCoKPjlOuwFW1jUSps0dehPYDUagiKquJ2jB7vAfNfNtNiR+zMTBBEzfGg5GrATowsj8fPuvyis=
X-Gm-Message-State: AOJu0Ywf2ATMJc8tAPmYGxL+Ltu2KM8loQbiLV4LUoFPMA+CYvzyPSky
 sEsv6dz3JbluY5hh5OP6sd9yz34ziDZW94cD3TYytxzzAJrIW5VFkepWmJtP+Vnmm4Z+LlZknBX
 yNOcGfR37JWY+EBi1W99GS2iYgnpshK55jdGkrDeDs+06NVNgDk7i
X-Received: by 2002:a05:6808:6412:b0:3c3:582f:3005 with SMTP id
 fg18-20020a056808641200b003c3582f3005mr17677414oib.46.1710773363179; 
 Mon, 18 Mar 2024 07:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVR4yMkfIm5rde54MB652Zik3f6RPNXmFntMldtzDcVjKwOR8f6y3Gu+ykFhwaUe0d4mHz8g==
X-Received: by 2002:a05:6808:6412:b0:3c3:582f:3005 with SMTP id
 fg18-20020a056808641200b003c3582f3005mr17677388oib.46.1710773362917; 
 Mon, 18 Mar 2024 07:49:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bj31-20020a05620a191f00b00789eec76e58sm2136901qkb.50.2024.03.18.07.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:49:22 -0700 (PDT)
Message-ID: <12e21f3f-c425-4f8a-9dd9-d81f95afb4fd@redhat.com>
Date: Mon, 18 Mar 2024 15:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 2/28/24 04:58, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This adds pci_device_set/unset_iommu_device() to set/unset
> HostIOMMUDevice for a given PCIe device. Caller of set
> should fail if set operation fails.
>
> Extract out pci_device_get_iommu_bus_devfn() to facilitate
> implementation of pci_device_set/unset_iommu_device().
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/pci/pci.h | 38 ++++++++++++++++++++++++++-
>  hw/pci/pci.c         | 62 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 96 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index fa6313aabc..8fe6f746d7 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -3,6 +3,7 @@
>  
>  #include "exec/memory.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/host_iommu_device.h"
>  
>  /* PCI includes legacy ISA access.  */
>  #include "hw/isa/isa.h"
> @@ -384,10 +385,45 @@ typedef struct PCIIOMMUOps {
>       *
>       * @devfn: device and function number
>       */
> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
> +     *
> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
> +     * retrieve host information from the associated HostIOMMUDevice.
> +     *
> +     * Return true if HostIOMMUDevice is attached, or else return false
> +     * with errp set.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     *
> +     * @dev: the data structure representing host IOMMU device.
@errp is missing
> +     *
> +     */
> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
> +                            HostIOMMUDevice *dev, Error **errp);
> +    /**
> +     * @unset_iommu_device: detach a HostIOMMUDevice from a vIOMMU
> +     *
> +     * Optional callback.
> +     *
> +     * @bus: the #PCIBus of the PCI device.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number of the PCI device.
> +     */
> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>  } PCIIOMMUOps;
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> +                                Error **errp);
> +void pci_device_unset_iommu_device(PCIDevice *dev);
>  
>  /**
>   * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580..8078307963 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2672,11 +2672,14 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>      }
>  }
>  
I would write some comments describing the output params and also
explicitly saying some are optional
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                                           PCIBus **aliased_bus,
> +                                           PCIBus **piommu_bus,

piommu_bus is not an optional parameter. I would put it before aliased_bus. 

> +                                           int *aliased_devfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> -    uint8_t devfn = dev->devfn;
> +    int devfn = dev->devfn;
>  
>      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2717,13 +2720,66 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +    assert(iommu_bus);
> +
> +    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
> +        iommu_bus = NULL;
> +    }
> +
> +    *piommu_bus = iommu_bus;
> +
> +    if (aliased_bus) {
> +        *aliased_bus = bus;
> +    }
> +
> +    if (aliased_devfn) {
> +        *aliased_devfn = devfn;
> +    }
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    if (iommu_bus) {
>          return iommu_bus->iommu_ops->get_address_space(bus,
>                                   iommu_bus->iommu_opaque, devfn);
>      }
>      return &address_space_memory;
>  }
>  
> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *base_dev,
> +                                Error **errp)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
I would add a comment explaining why you don't care about aliased bus
and devfn
> +    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
> +        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
> +                                                      iommu_bus->iommu_opaque,
> +                                                      dev->devfn, base_dev,
> +                                                      errp);
> +    }
> +    return 0;
> +}
> +
> +void pci_device_unset_iommu_device(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, NULL, &iommu_bus, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
> +        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
> +                                                        iommu_bus->iommu_opaque,
> +                                                        dev->devfn);
> +    }
> +}
> +
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>  {
>      /*
Thanks

Eric


