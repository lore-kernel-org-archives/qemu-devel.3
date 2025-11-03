Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AFDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxmq-0003SA-Nz; Mon, 03 Nov 2025 11:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxmp-0003Rw-II
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxme-000499-0W
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762188711;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2mzI29oojPvR6WejxEc0b6TlzG6uFGzZY+idHVO0ow=;
 b=ezT3mRS2kbJtjpnha541zBdKDV6OU1kWhu2BOCdcBnaibfhOJX7nuZw9mT1HReBcQFQXIE
 cY7P4YpII5cSSX4rgF1nutuDjPI1/x0Wz54yTkRk2h/SJ7Ix1qaXHykSWryzRpk/HzQ30t
 ptD/SZcGpJMPqyYlqwE+c2lOO9IuS4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-ti4V5VySP4SkPZss5dCLuA-1; Mon, 03 Nov 2025 11:51:48 -0500
X-MC-Unique: ti4V5VySP4SkPZss5dCLuA-1
X-Mimecast-MFC-AGG-ID: ti4V5VySP4SkPZss5dCLuA_1762188707
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429cdb0706aso1547136f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188707; x=1762793507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2mzI29oojPvR6WejxEc0b6TlzG6uFGzZY+idHVO0ow=;
 b=UENgqjn7iRLMEm1NnH+iTC18IGX2iZzi4evhGI7Vz9ExO/ZYHI/YkUJ8sFKv5kGhhR
 fSKZzUZl8EJSiUffFIZsDZE4M6RRET5vTTlXPLzplG7959ayRNsuPoVnjfv/0Kac/HTi
 vgkYzD+h2DvhC+SsOd3f1nBfHYBJkqQxQVn8lJTzCnWy53xCMfbfTDvEvrCsXunNhaAQ
 VGKgvbCDfkly5/bgq1nXbU+z4HZmvcDnK/gS3R15gSggu5ulTbZgPw5vg5dZmIfjam62
 89eXU6SyYgdEDVNnxZULS9GIjxHpP2eKza2lItY1Yc5Pq+WC/VhVlk8o3ywoqFUThKbz
 e4vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/XTFb7u/ZvipuHw2K2Ar5JeUR7yYUgYkIsewTUOxvUZ2II8JyP57Ntcge907+QtALFCX5mfAza8ks@nongnu.org
X-Gm-Message-State: AOJu0YyUCRSKY5g7ENhOLa21lsaFkVVJX7ogXow/BBfgEmYkiFIb2IyM
 PIBjfPNHALT5Dbt+Uh9RS9q8waJ9n4IepEp7l8rBmRpM/2HwOeyi3c1Ezx2mX055S0VJxOscGYf
 Hecg2RCb4CnvmPr0529NWOgl5ldZFDb1A+UAk0hZrt33COmvVbOuhHLlw
X-Gm-Gg: ASbGnctxZlHBAFHdy1Qc36H1315VN5TZkJTtDh9AvnayvzjQEurJ+oWhXxFfFbd4G3T
 qJdZlQvLTSHDji/h0cCa59a1QOcEACgBH0LhTKoM7lJC2ZfHTP0nfUiaAgU0oDN9LTqLnv73xgz
 pk8DcZiWaxdyNWvV1VsXdstky0mr5ubKnIDjcU9ab/gGEriGrquPxxkkCEgowCJEz1kPyRkpURM
 j6qxrCUxFsHVOVSNRBfzttj2nKs5mn+WpsfbZc0i0Mpxwn5fZyn+9uW4mC351bd8F9T2pq8XAY2
 yiq7tg1/qn50zzEWmFlLSEpF0Feouv20FVS5fE7VNQ7AI2HLHkpQEsg80KN85hssdRHwipktm9n
 jOyG4ReOtExeljIxLjFU/on7cyM3nh3SpeCWN0lr6ABVocA==
X-Received: by 2002:a05:6000:2301:b0:429:8d46:fc40 with SMTP id
 ffacd0b85a97d-429bd682dd2mr12131313f8f.25.1762188707117; 
 Mon, 03 Nov 2025 08:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEotaw287g1lb2lhrTcaCRzhvp0/x8klbGbixmmi379YOwWofmKIsnkvzMMjY1Wy/z+zMVZvw==
X-Received: by 2002:a05:6000:2301:b0:429:8d46:fc40 with SMTP id
 ffacd0b85a97d-429bd682dd2mr12131293f8f.25.1762188706691; 
 Mon, 03 Nov 2025 08:51:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm20960647f8f.47.2025.11.03.08.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 08:51:46 -0800 (PST)
Message-ID: <51afaf95-20bb-44f9-8595-8e6f699a6b75@redhat.com>
Date: Mon, 3 Nov 2025 17:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/32] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-11-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Accelerated SMMUv3 is only meaningful when a device can leverage the
> host SMMUv3 in nested mode (S1+S2 translation). To keep the model
> consistent and correct, this mode is restricted to vfio-pci endpoint
> devices using the iommufd backend.
>
> Non-endpoint emulated devices such as PCIe root ports and bridges are
> also permitted so that vfio-pci devices can be attached beneath them.
s/beneath them/downstream?
> All other device types are unsupported in accelerated mode.
>
> Implement supports_address_space() callaback to reject all such
callback
> unsupported devices.
>
> This restriction also avoids complications with IOTLB invalidations.
> Some TLBI commands (e.g. CMD_TLBI_NH_ASID) lack an associated SID,
> making it difficult to trace the originating device. Allowing emulated
> endpoints would require invalidating both QEMU’s software IOTLB and the
> host’s hardware IOTLB, which can significantly degrade performance.
>
> For vfio-pci devices in nested mode, get_address_space() returns an
> address space aliased to system address space so that the VFIO core
> can set up the correct stage-2 mappings for guest RAM.
>
> In summary:
>  - vfio-pci devices(with iommufd as backend) return an address space
>    aliased to system address space.
>  - bridges and root ports return the IOMMU address space.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f62b6cf2c9..550a0496fe 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -7,8 +7,13 @@
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
>  /*
> @@ -38,6 +43,41 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
> +{
> +
> +    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
> +        object_dynamic_cast(OBJECT(pdev), TYPE_PXB_PCIE_DEV) ||
> +        object_dynamic_cast(OBJECT(pdev), TYPE_GPEX_ROOT_DEVICE)) {
> +        return true;
> +    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI))) {
> +        *vfio_pci = true;
> +        if (object_property_get_link(OBJECT(pdev), "iommufd", NULL)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static bool smmuv3_accel_supports_as(PCIBus *bus, void *opaque, int devfn,
> +                                     Error **errp)
> +{
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +    bool vfio_pci = false;
> +
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        if (vfio_pci) {
> +            error_setg(errp, "vfio-pci endpoint devices without an iommufd "
> +                       "backend not allowed when using arm-smmuv3,accel=on");
> +
> +        } else {
> +            error_setg(errp, "Emulated endpoint devices are not allowed when "
> +                       "using arm-smmuv3,accel=on");
> +        }
> +        return false;
> +    }
> +    return true;
> +}
>  /*
>   * Find or add an address space for the given PCI device.
>   *
> @@ -48,15 +88,39 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>  static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>                                                int devfn)
>  {
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      SMMUState *bs = opaque;
>      SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>      SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>      SMMUDevice *sdev = &accel_dev->sdev;
> +    bool vfio_pci = false;
>  
> -    return &sdev->as;
> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
> +        /* Should never be here: supports_address_space() filters these out */
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * In the accelerated mode, a vfio-pci device attached via the iommufd
> +     * backend must remain in the system address space. Such a device is
> +     * always translated by its physical SMMU (using either a stage-2-only
> +     * STE or a nested STE), where the parent stage-2 page table is allocated
> +     * by the VFIO core to back the system address space.
> +     *
> +     * Return the shared_as_sysmem aliased to the global system memory in this
> +     * case. Sharing address_space_memory also allows devices under different
> +     * vSMMU instances in the same VM to reuse a single nesting parent HWPT in
> +     * the VFIO core.
> +     */
> +    if (vfio_pci) {
> +        return shared_as_sysmem;
> +    } else {
> +        return &sdev->as;
> +    }
>  }
>  
>  static const PCIIOMMUOps smmuv3_accel_ops = {
> +    .supports_address_space = smmuv3_accel_supports_as,
>      .get_address_space = smmuv3_accel_find_add_as,
>  };
>  
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


