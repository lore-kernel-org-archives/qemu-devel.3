Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBADCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 06:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5Cu-0000lF-Gv; Wed, 13 Aug 2025 02:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1um5Cq-0000kZ-1W
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:43:28 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1um5Cl-0000bh-Eb
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:43:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afca523e810so70306566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1755067397; x=1755672197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq3FWtEzlyXdBgQe8AZETTNmZnyBTapHLCyPb66quJ4=;
 b=HqiCZJ8jI1gvHgVh0eiYyirqnqoENm7WnbN5JrTMt4kdgnjKoILU9j6lRN8uK34G3q
 cVe1zRL6ztqDIlIH9j8hLFv1z6owRHmcrnT8O3dkU/lsCUdZZJOygEwtjbe6VzcIOZuh
 pLZ+40hr2sGb1MwAxM/gBuhpY9OGDM4MxYFAv4kYDlm78yrnana0PmVmIYQ6cXuIhODU
 Ti3OqIz7s3ZX+KU6BwpXlCwJsUtkt1EqwK1xmnjbx52lgUveqTN6zBwm4GAgL0mZEjJk
 B40zZTIb5h6GVfM+AjpML5mivewUu/73jj5FkuqIvBWSZT57LuoHRqjYVHoK7KrP3IBD
 rQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755067397; x=1755672197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq3FWtEzlyXdBgQe8AZETTNmZnyBTapHLCyPb66quJ4=;
 b=NXdW17yIrljAQnZT3vxny9MkEVkz6PNlkqWydoxx0rBU7bmi8lwm/UJk49U8SVGkxM
 D5q9dMLEckNMCYSL62waTj286NDnPc2dvIXqwhaW+QZx2e3D6ksbKwV/pUdCqso8y8et
 XvLKWdYUVpzRrZbXHsPGz+jWiOhm68PW3nlF7zK16CW/YmGlPkMRk4I+BQpwUXZBx8vh
 BuVruCS7gOjNiXfzOjQ58QJA3AlgAYM1kFSOcIXiLL4vVU8Ale2SJZLjFdwpZ13qu8DX
 OVVAI/ivzgxTh5qA+/6IfoUSwbg5QNzRkAGPA/l+envDr+KvvipBqJVWtPawXIoqjrWH
 OT2Q==
X-Gm-Message-State: AOJu0Yz4lNyNwch10CByvmREU69HL1jYYqE+/PuC7838wLpLW5S189qK
 FNJCcrM2wtzmTo8YlF5x3zII823gU9ZJM5mtX3jx9CAN5peJIvygj6ujsrf55sYy9WkHH/s+9nP
 0vgkjxfHmUGe/5KVmt9eFVP10ULuQy+L2pXEGZnFxFJVXnPlY+Rc6
X-Gm-Gg: ASbGnctu3WxUtCADmsYMZp+DjVcdvgAxy5Y5CrG7F/8UWOD3YUkp/FzyOp8i69/WV0L
 ZtVDRxvaA4AKp4DFiDnB8G0Fk4+s0FTLMvBmsZAF4KXiB1CoacJoH45lI6AyFRVRp87XKtZD7OL
 LGCCEQKrhFs21nJHbQHvmcjypOAGxF0J3H2U8R1L4zWjShoMHqPcrl8GSvoj/x3gK9fhH/sqcez
 sIUKjRFNEiCWySAVcLD
X-Google-Smtp-Source: AGHT+IG9G6kJ99EhIuju+YKsRZT39Z5Bx6x1H0+s3fdEa/+9VlkEAOAL68ph0vj27kqWjZuPzB6+BBBVO3cWMUYPy+8=
X-Received: by 2002:a17:907:d1b:b0:af9:3d0a:f382 with SMTP id
 a640c23a62f3a-afca4e539a0mr192587166b.46.1755067397209; Tue, 12 Aug 2025
 23:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
In-Reply-To: <20250729092043.785836-3-zhenzhong.duan@intel.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 13 Aug 2025 14:43:05 +0800
X-Gm-Features: Ac12FXyFp0OWG_5IphsDLGHWT19oD7n2mTrbT8zklFXn3yNgAGWMzBweFq-ICPY
Message-ID: <CALw707oaU-1uiVjV4k=RQLbXJWk2vhqDMX7+r=Mx=QhQQZE1Hg@mail.gmail.com>
Subject: Re: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, 
 ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com, 
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On Tue, Jul 29, 2025 at 5:21=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
> allows to retrieve capabilities exposed by a vIOMMU. The first planned
> capability is VIOMMU_CAP_HW_NESTED that advertises the support of HW
> nested stage translation scheme. pci_device_get_viommu_cap is a wrapper
> that can be called on a PCI device potentially protected by a vIOMMU.
>
> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
> capabilities which are only derermined by user's configuration, no host
> capabilities involved. Reasons are:
>
> 1. there can be more than one host IOMMUs with different capabilities
> 2. there can also be more than one vIOMMUs with different user
>    configuration, e.g., arm smmuv3.
> 3. This is migration friendly, return value is consistent between source
>    and target.
> 4. It's too late for VFIO to call get_viommu_cap() after set_iommu_device=
()
>    because we need get_viommu_cap() to determine if creating nested paren=
t
>    hwpt or not at attaching stage, meanwhile hiod realize needs iommufd,
>    devid and hwpt_id which are ready after attach_device().
>    See below sequence:
>
>      attach_device()
>        get_viommu_cap()
>        create hwpt
>      ...
>      create hiod
>      set_iommu_device(hiod)
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  MAINTAINERS          |  1 +
>  include/hw/iommu.h   | 17 +++++++++++++++++
>  include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>  hw/pci/pci.c         | 11 +++++++++++
>  4 files changed, 54 insertions(+)
>  create mode 100644 include/hw/iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37879ab64e..840cb1e604 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2304,6 +2304,7 @@ F: include/system/iommufd.h
>  F: backends/host_iommu_device.c
>  F: include/system/host_iommu_device.h
>  F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>  F: util/chardev_open.c
>  F: docs/devel/vfio-iommufd.rst
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

Could we include header "qemu/bitops.h" here to use `BIT_ULL()` in this fil=
e?
Or it will get compile error when including it in the other IOMMU.

> +enum {
> +    /* hardware nested stage-1 page table support */
> +    VIOMMU_CAP_HW_NESTED =3D BIT_ULL(0),
> +};
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6b7d3ac8a3..d89aefc030 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -462,6 +462,21 @@ typedef struct PCIIOMMUOps {
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
> +     * Returns: 64bit bitmap with each bit represents a capability emula=
ted by
> +     * VIOMMU_CAP_* in include/hw/iommu.h, these capabilities are theore=
tical
> +     * which are only determined by user's configuration and independent=
 on the
> +     * actual host capabilities they may depend on.
> +     */
> +    uint64_t (*get_viommu_cap)(void *opaque);
>      /**
>       * @get_iotlb_info: get properties required to initialize a device I=
OTLB.
>       *
> @@ -642,6 +657,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, Hos=
tIOMMUDevice *hiod,
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
> +        return iommu_bus->iommu_ops->get_viommu_cap(iommu_bus->iommu_opa=
que);
> +    }
> +    return 0;
> +}
> +
>  int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                           bool exec_req, hwaddr addr, bool lpig,
>                           uint16_t prgi, bool is_read, bool is_write)
> --
> 2.47.1
>
>

Thanks,
Jim

