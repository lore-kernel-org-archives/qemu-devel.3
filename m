Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC12CC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiG9-0006l5-Kf; Tue, 15 Jul 2025 12:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubhhW-0004cT-MH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubhhU-0001i6-5E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752593770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gulOM/aKBwqJKOM/Hzj1YiaMRbz5qh9GcNlafnLutSQ=;
 b=T4Yn0yAOl96JG9Dm6gUP7UizdchWLn0ZAd/0115Mze9oaES4dyzoDmHI2L5Dtl8EWi+F8l
 S3nVvPoFb5/ZVPw7pjyi65MFxr7EZnSRGtKU7GtccPLWgVY2DKDIwL6bfBsxx7VLJyR8VF
 MhMq4tFDdh/HKSbVpYuaitIWoBOfM/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-D0F_FmfxMkK0Ck3l_vuwfw-1; Tue, 15 Jul 2025 11:36:08 -0400
X-MC-Unique: D0F_FmfxMkK0Ck3l_vuwfw-1
X-Mimecast-MFC-AGG-ID: D0F_FmfxMkK0Ck3l_vuwfw_1752593768
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45617e7b82fso13540755e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752593767; x=1753198567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gulOM/aKBwqJKOM/Hzj1YiaMRbz5qh9GcNlafnLutSQ=;
 b=skuheIF18LB+oj4/+ZbndDAs/9Q/9MjK0JDv/TNspNJ7yX00zO+wk/oKMRG/7V7yzp
 Oabi7tNiUVgFFeb5tFPqlBkZsSOMvH2/h6DMfbrqFvi7T4EQKGtcfogdaIkEVz8cEXT+
 XYB9my9TZKVGKPHrFfo+lYb3yCCY4ThLXAukda315CUuJAAU5k6wLFRYtwkXi2/1nldu
 dLEW1bogoU0Is2JD2t/4qsmLLXXccJ6Zrmsa7FVOWwy5ZSkWbv5psJPcQ8hTOYPg/30R
 fQtJcndGMZYtcFUH6eLZUXYefLfInmgjqKtOBcc1Gc9eUlDligcP4bmTHcEXbhxFLmKn
 Lc3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQCWlbVpLVzkW9qjsLUH4+GKm1+DWldhCEM3DTs9G3lzd4FUBD4dr9tWM/VvT0YLxSnNuGTQ9SEqpN@nongnu.org
X-Gm-Message-State: AOJu0Yxmicr2Zk4XVuYodzXCm30atwY7q+GJ7xjrKz11dKzXx8GsA4bT
 Qj9vKsedeAmjEtoVFHiBdKNQDHGH0qokZ0C/17fU/aFGN/50zf+a8uhuhxYfAYABRSz0+UZ21vm
 9nkEF13zbZqEYMOabsT0a1Lbie5zDjM6H+lcBLk3u5XUmQwEA1Na6p4hp
X-Gm-Gg: ASbGncttIhnrKZg5q+eaDK0hZO8AHUYGN+EzHePgXJwiq5UbzHNvqLuLeiLRjfZkc3B
 rwee7SnboAWw9ORLqtfyuSh3FQQsVwG5HMPq5iJ76bClT7mW5hu9DsxAkhEzV98A9wfzfV+3zIB
 6pFmQ1bn41zsxzhrYlsaK0i+lpAQlzF2BF2jnmnQ81mwcMrsYsL4Cjj34bzivr6bjcmiSRWAYK2
 jNXIGzbu+fheI3EWfB0QAZbRKD4eumSNS976XAA1mEm0tkmFROUYjb+H+p6ZuoqVSbPua7QbSU4
 DPkzdhgVWyUcWdeyxGfOlp7AFn0N87+E9ml/XCbYrs2quZ1C9WnarRAzFIeJMkD/a6rKQeY1kuJ
 WIO3g0PZiM5I=
X-Received: by 2002:a05:6000:210a:b0:3b5:e6f3:ac9b with SMTP id
 ffacd0b85a97d-3b5f187ec93mr13836868f8f.5.1752593767586; 
 Tue, 15 Jul 2025 08:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkRUSnhPYYKUZxFOC61y1DMpFSrYJnOo9tP7R3buhRy0qZUGDWjxNTCXycaYVyp4oaEoElVw==
X-Received: by 2002:a05:6000:210a:b0:3b5:e6f3:ac9b with SMTP id
 ffacd0b85a97d-3b5f187ec93mr13836829f8f.5.1752593767072; 
 Tue, 15 Jul 2025 08:36:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562360c989sm38862355e9.37.2025.07.15.08.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:36:06 -0700 (PDT)
Message-ID: <4d51e561-dc39-44d5-b52e-6b4dc1ce8603@redhat.com>
Date: Tue, 15 Jul 2025 17:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Zhenzhong,

On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
> pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
> to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
> get a bitmap with each bit represents a vIOMMU exposed capability.
Suggesting:
Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
allows to retrieve capabilities exposed by a vIOMMU. The first planned
capability is VIOMMU_CAP_HW_NESTED that advertises the support of HW
nested stage translation scheme. pci_device_get_viommu_cap is a wrapper
that can be called on a PCI device potentially protected by a vIOMMU.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS          |  1 +
>  hw/pci/pci.c         | 11 +++++++++++
>  include/hw/iommu.h   | 16 ++++++++++++++++
>  include/hw/pci/pci.h | 23 +++++++++++++++++++++++
>  4 files changed, 51 insertions(+)
>  create mode 100644 include/hw/iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1842c3dd83..d9fc977b81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2302,6 +2302,7 @@ F: include/system/iommufd.h
>  F: backends/host_iommu_device.c
>  F: include/system/host_iommu_device.h
>  F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..df1fb615a8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2992,6 +2992,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>      }
>  }
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
>  int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                           bool exec_req, hwaddr addr, bool lpig,
>                           uint16_t prgi, bool is_read, bool is_write)
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..e80aaf4431
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,16 @@
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
> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
with the enum name change,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> +};
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index df3cc7b875..a11ab14bdc 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -453,6 +453,19 @@ typedef struct PCIIOMMUOps {
>       * @devfn: device and function number of the PCI device.
>       */
>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_cap: get vIOMMU capabilities
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't
> +     * support exposing capabilities to other subsystem, e.g., VFIO.
> +     * vIOMMU can choose which capabilities to expose.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: 64bit bitmap with each bit represents a capability emulated
> +     * by VIOMMU_CAP_* in include/hw/iommu.h
> +     */
> +    uint64_t (*get_viommu_cap)(void *opaque);
>      /**
>       * @get_iotlb_info: get properties required to initialize a device IOTLB.
>       *
> @@ -633,6 +646,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
>  
> +/**
> + * pci_device_get_viommu_cap: get vIOMMU capabilities.
> + *
> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
> + * capability, 0 if vIOMMU doesn't support esposing capabilities.
> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_cap(PCIDevice *dev);
> +
>  /**
>   * pci_iommu_get_iotlb_info: get properties required to initialize a
>   * device IOTLB.


