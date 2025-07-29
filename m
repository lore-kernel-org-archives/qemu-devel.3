Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109F4C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkFL-0003Oc-V9; Tue, 29 Jul 2025 09:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugkFG-00034y-IR
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugkFE-0002rK-6z
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753795189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LDjizpU/EzPnUMPRedF3wgACBhNX35/Srd+/Wgyjz68=;
 b=S8DT3SwF0Ozi3e0KU4wR8Ultka9GjjufubMYbXWQ0LnE1YZrAl/z1P3YpBy7y4N9UxNXEI
 LGj913pF5HFHJ1/DBMGXlTgh+ULB3/TzXuQTNgZdGMObPkZP7+aT9wlmgTO4U6P5g84Muu
 nnOQQ4jR39IcGVjBxhTZ4C2PawmM5VQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-hMvdXF0pPKeFqGnq49-s7w-1; Tue, 29 Jul 2025 09:19:47 -0400
X-MC-Unique: hMvdXF0pPKeFqGnq49-s7w-1
X-Mimecast-MFC-AGG-ID: hMvdXF0pPKeFqGnq49-s7w_1753795187
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b78329f180so2350964f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 06:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753795187; x=1754399987;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDjizpU/EzPnUMPRedF3wgACBhNX35/Srd+/Wgyjz68=;
 b=hr9kj0rn8ja8Gsd7e8AMhp9HUn+7i+qEbLZy32wJ+vQRrNNYqVMDBsuGz5ndzLfSw6
 Az2CM1nqQe0I9FJuOjZAN5yCvEcyDrs8qF0uekm0ZWzSfcwLQ08N9TlJgMo+/j00CQik
 5owOQYz8dcGPAsElWCfMw0rm/xEw6dKUgRrbhiLcwkPEyk7oTgCIxLJpNqiq2r6MGLfb
 xVstLkSVUUS4f5m3SBlxswZgCsK5IXlMnT1fFXZ1w8ZXR5avmiC+0GDKpJndtNgJJrDd
 fYqvZXBhf0szLspG/47fc5sXG6LJgHRVbRGGW/eB/Ie4iLZMgWkPusHbfdgABvKvxQ4r
 vB9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNy0kGUj1Yfum1NIml05N3AJDZ0fETybPjxXM7jnrczIClwZiV7YIGr9h3PhQX9ls8NbLD/rmf756v@nongnu.org
X-Gm-Message-State: AOJu0YzeV+7szcBV790wx+yy+22BXyWkxK+A4pQmYZkd6+1Rtv3ju8pT
 UIRpAy8pR7Ck1xRM+MMfa9KUw1OyCykdsSCaN4Jr0pydMdStrqbNsRUaw0/cucyoX5HyTYirXH+
 zGAE1xd/5pMMfyb66eE0pgAwByq621UU38nb2XTlnal4lY2QmEOUTZ3uY
X-Gm-Gg: ASbGnctEFR6MeAGxSLWSzNrTGwSbLR+fifwYZCK1Tgkv7oPZLsuZ+7TRxshNBaPZLGN
 SPLM73ha4hpPiGuxhMTjoauOg22MwZuKUpx/8IYQaopyNE0W0qroYTcwbPbIhlk3qfglwt2djg1
 aL4nRIbO0gyQMWYK+VoOI43bHjdMpFo4kPZGptWq0apDqAQJ7KplY1u+FHej0zx+3R2HqL8Nfve
 pzYKcNLSMI5+Iv+5VaFGIReR750DlKbW8Hqa1dVy7Hs5KimBnZEl1AjXXbtFzt1cImtg0zupS7O
 fQOAjyfwzgMysVyW/yKSOP/p/ONcKsLmexR8XziuXL//I11mBe7hJmj5bEoAm9vpeAi9H7mcUtY
 8bg==
X-Received: by 2002:a05:6000:230c:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3b77678c79fmr11168353f8f.54.1753795186533; 
 Tue, 29 Jul 2025 06:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXXygr+JrYGVr1X8yG8tucr3ub7ZbPxI3teJ6xFcI7wPBkh8N7MQPH6EInl7FicFWE/Gq5aw==
X-Received: by 2002:a05:6000:230c:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3b77678c79fmr11168318f8f.54.1753795186031; 
 Tue, 29 Jul 2025 06:19:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7908161e3sm2510783f8f.37.2025.07.29.06.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 06:19:45 -0700 (PDT)
Message-ID: <9989340c-c304-4208-9c33-f54fc5d1e865@redhat.com>
Date: Tue, 29 Jul 2025 15:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250729092043.785836-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Zhenzhong

On 7/29/25 11:20, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
> allows to retrieve capabilities exposed by a vIOMMU. The first planned
                                                vIOMMU device

"device" is implied, but I find it easier to understand if it is stated
openly.

> capability is VIOMMU_CAP_HW_NESTED that advertises the support of HW
> nested stage translation scheme. pci_device_get_viommu_cap is a wrapper
> that can be called on a PCI device potentially protected by a vIOMMU.
> 
> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
> capabilities which are only derermined by user's configuration, no host

typo: determined

> capabilities involved. Reasons are:
> 
> 1. there can be more than one host IOMMUs with different capabilities

"host IOMMU devices"

Such as iommufd and VFIO IOMMU Type1 ?

> 2. there can also be more than one vIOMMUs with different user
>     configuration, e.g., arm smmuv3.
> 3. This is migration friendly, return value is consistent between source
>     and target.
> 4. It's too late for VFIO to call get_viommu_cap() after set_iommu_device()
>     because we need get_viommu_cap() to determine if creating nested parent
>     hwpt or not at attaching stage, meanwhile hiod realize needs iommufd,

hiod -> "host IOMMU device"

>     devid and hwpt_id which are ready after attach_device().

I find the above sentence difficult to understand.


>     See below sequence:
> 
>       attach_device()
>         get_viommu_cap()
>         create hwpt
>       ...
>       create hiod
>       set_iommu_device(hiod)
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS          |  1 +
>   include/hw/iommu.h   | 17 +++++++++++++++++
>   include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>   hw/pci/pci.c         | 11 +++++++++++
>   4 files changed, 54 insertions(+)
>   create mode 100644 include/hw/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37879ab64e..840cb1e604 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2304,6 +2304,7 @@ F: include/system/iommufd.h
>   F: backends/host_iommu_device.c
>   F: include/system/host_iommu_device.h
>   F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
>   
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..021db50db5
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,17 @@
> +/*
> + * General vIOMMU capabilities, flags, etc
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +enum {
> +    /* hardware nested stage-1 page table support */
> +    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),
> +};
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6b7d3ac8a3..d89aefc030 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -462,6 +462,21 @@ typedef struct PCIIOMMUOps {
>        * @devfn: device and function number of the PCI device.
>        */
>       void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_cap: get vIOMMU capabilities
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't
> +     * support exposing capabilities to other subsystem, e.g., VFIO.
> +     * vIOMMU can choose which capabilities to expose.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: 64bit bitmap with each bit represents a capability emulated by
> +     * VIOMMU_CAP_* in include/hw/iommu.h, these capabilities are theoretical
> +     * which are only determined by user's configuration and independent on the

What is meant by "user's configuration" ? the vIOMMU device properties ?

> +     * actual host capabilities they may depend on.
> +     */
> +    uint64_t (*get_viommu_cap)(void *opaque);
>       /**
>        * @get_iotlb_info: get properties required to initialize a device IOTLB.
>        *
> @@ -642,6 +657,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                    Error **errp);
>   void pci_device_unset_iommu_device(PCIDevice *dev);
>   
> +/**
> + * pci_device_get_viommu_cap: get vIOMMU capabilities.
> + *
> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
> + * capability, 0 if vIOMMU doesn't support esposing capabilities.

exposing

Thanks,

C.



> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_cap(PCIDevice *dev);
> +
>   /**
>    * pci_iommu_get_iotlb_info: get properties required to initialize a
>    * device IOTLB.
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..df1fb615a8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2992,6 +2992,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>       }
>   }
>   
> +uint64_t pci_device_get_viommu_cap(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_cap) {
> +        return iommu_bus->iommu_ops->get_viommu_cap(iommu_bus->iommu_opaque);
> +    }
> +    return 0;
> +}
> +
>   int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                            bool exec_req, hwaddr addr, bool lpig,
>                            uint16_t prgi, bool is_read, bool is_write)


