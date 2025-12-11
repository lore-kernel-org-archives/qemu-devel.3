Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177B3D41C35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 13:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTgvr-00087W-58; Thu, 11 Dec 2025 08:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTgvp-00087E-GE
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTgvm-0004DD-IS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 08:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765460523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sr2aFg8fTMyddLv202clpZpLgG72ErbP3QOFd54jjKc=;
 b=hZrnR0Yiv/UXU/RyK7BSzy7z394z0MnsU7gXp+Y/ZecHN7YiTJ2qAAqFOgWWsEs8GvyAAK
 mSb2+6MgwHq644k714VXgNNjoy6Zz2595pnWdzbkuC5BfydnGi0LigZ0a+rTi7lS9RSTCh
 Fx0W+jancb/t+6nR6kHjFQq86wQ5TEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-tZrjFU3YMRW5USB6YJC70A-1; Thu, 11 Dec 2025 08:42:02 -0500
X-MC-Unique: tZrjFU3YMRW5USB6YJC70A-1
X-Mimecast-MFC-AGG-ID: tZrjFU3YMRW5USB6YJC70A_1765460520
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2f79759bso76157f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765460520; x=1766065320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sr2aFg8fTMyddLv202clpZpLgG72ErbP3QOFd54jjKc=;
 b=GVtMOwl4BTdr5plfyQFYasaK0/nt2yERIaeJo2YsOmF4Mvw4wOW7XXOxnjZ/amN8P7
 ZWhxy0PcY9vXelZdEZ1PjsVG89iAs3OPPoxk0KzEy3helnJtS70ODXLXflO56hdi4k40
 WuSQv5PRpZYNUPbQT5NHBTixJ0/YGprOwSdgUW19JtB39mLuyUZNKqVQ3tsTK76fVfAF
 KHJcTt0bLDLXGkaiyIp8uzT4TqS9f2bZOiqqzPkwwi5g4hEjawLML7YZG3AsixJnlaFj
 iKR2iV1Kisoq75pWSYjdEmGJhZ/PtGp+c0/hWzQQPzHIovhOHdxcEOiu5+jpDE+79UlI
 nVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460520; x=1766065320;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sr2aFg8fTMyddLv202clpZpLgG72ErbP3QOFd54jjKc=;
 b=SAVaUsLkt/IqiERCHI6yl7lYOcaMMwOC7o0NO8kAC+zvWkiGbuOjPmVjYIRA+WNJaX
 PVmv12L+GIM7yMQ7uZiGtaKKvIhIAyhDu1mDrgjyUmuhLStdxmOb5NnrMu9iZUF6QoE0
 wF2ltf0lPQD6PT8LsTi/bf8/dxWYqAKcfQUIsrBgNDYiZzJad7iQPj78QsGUj8+qtDiM
 4A8OFhP+GH2Bm00wnvA0k8wT8PgYP5fZWlfYeWZEc47sryCHlFvqNNVB9nODjShnLY9B
 hT+CgvownWDDf6IkbjtNqUT2QgfDvPcTGKbx1ycLXr+lT8vHDzUl6Eui6JKED/35M9HM
 3lOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2hzC5NqUC7jmv+23rJVfqEqEvYeLnU5blaWT8uRj90kG2opZo2F/GGqoYnk9Bb4zCoehIuKnhDNUB@nongnu.org
X-Gm-Message-State: AOJu0YwK4DUggDkcjsgSajZKL4/i3MHJrRaTWxRHO3lGuG41xJ09gIjV
 qLKgainlLRrHOZuxog9YY8z/5wHMIp4G7MRV3Z4L2LbLlIR8GCkdp+gONSAqh8+UBOQnFBnAjYy
 NW+Ne83xISO8FKGa1+fvOthMqOOm8BCHF0d3VxElS9Gs2OGAQrdGcxF/R
X-Gm-Gg: AY/fxX6DBcy5GKndiVRbgTqjKETKJ6gpALQD7S834ybSM8LhwaAG5TfcDEwRaH+lpcP
 0QMqjMTGsRpx+Cr4ioNvPIhSVrU/v2XLiy0u4DqyZ6U+aG9pmMGBJdhJ2dJN6kQAutq/GvIlonq
 S+Nj8z4F/P+bJ8BNANhaB8rH176smFZai7HR/9+UX050Fvi4hxO+VK73MRYvpICfpxdKyQXr0+y
 DFwJBRQR8fFcWeRDz2vxduI0EwfIAHyZa8S0WrYISx3uymg0ClE6MAIqhbAqZBfRzfGKOwM2W0r
 gxSCVzomB7f+U/n/VBjsnXgLojM837Y1mgjsgE41HBNYjtVfJZdC5N0mPdYKMvyRFdEE5JemVq/
 QuWJ89+IbP5ELyr+zqNXnebM9C5sfcj2Cr6DXjkxnxbt7LNQT
X-Received: by 2002:a05:6000:178d:b0:429:d350:802d with SMTP id
 ffacd0b85a97d-42fa3b0a940mr6325035f8f.45.1765460520100; 
 Thu, 11 Dec 2025 05:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeKhx4lvRzSLyCnnSuC2Rs5FNi3/vJgtuq2ao0UCBmnyFfKmZX9u8R3dN1IFDKq52fFmoZSQ==
X-Received: by 2002:a05:6000:178d:b0:429:d350:802d with SMTP id
 ffacd0b85a97d-42fa3b0a940mr6324987f8f.45.1765460519488; 
 Thu, 11 Dec 2025 05:41:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a67800sm5837686f8f.4.2025.12.11.05.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 05:41:59 -0800 (PST)
Message-ID: <329a1022-9a29-4519-9457-5a8c3e064d26@redhat.com>
Date: Thu, 11 Dec 2025 14:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/33] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-13-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 11/20/25 14:21, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Implement the VFIO/PCI callbacks to attach and detach a HostIOMMUDevice
> to a vSMMUv3 when accel=on,
> 
>   - set_iommu_device(): attach a HostIOMMUDevice to a vIOMMU
>   - unset_iommu_device(): detach and release associated resources
> 
> In SMMUv3 accel=on mode, the guest SMMUv3 is backed by the host SMMUv3 via
> IOMMUFD. A vIOMMU object (created via IOMMU_VIOMMU_ALLOC) provides a per-VM,
> security-isolated handle to the physical SMMUv3. Without a vIOMMU, the
> vSMMUv3 cannot relay guest operations to the host hardware nor maintain
> isolation across VMs or devices. Therefore, set_iommu_device() allocates
> a vIOMMU object if one does not already exist.
> 
> There are two main points to consider in this implementation:
> 
> 1) VFIO core allocates and attaches a S2 HWPT that acts as the nesting
>     parent for nested HWPTs(IOMMU_DOMAIN_NESTED). This parent HWPT will
>     be shared across multiple vSMMU instances within a VM.
> 
> 2) A device cannot attach directly to a vIOMMU. Instead, it attaches
>     through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). Based on the STE
>     configuration,there are three types of nested HWPTs: bypass, abort,
>     and translate.
>      -The bypass and abort proxy HWPTs are pre-allocated. When SMMUv3
>       operates in global abort or bypass modes, as controlled by the GBPA
>       register, or issues a vSTE for bypass or abort we attach these
>       pre-allocated nested HWPTs.
>      -The translate HWPT requires a vDEVICE to be allocated first, since
>       invalidations and events depend on a valid vSID.
>      -The vDEVICE allocation and attach operations for vSTE based HWPTs
>       are implemented in subsequent patches.
> 
> In summary, a device placed behind a vSMMU instance must have a vSID for
> translate vSTE. The bypass and abort vSTEs are pre-allocated as proxy
> nested HWPTs and is attached based on GBPA register. The core-managed
> nesting parent S2 HWPT is used as parent S2 HWPT for all the nested
> HWPTs and is intended to be shared across vSMMU instances within the
> same VM.
> 
> set_iommu_device():
>    - Reuse an existing vIOMMU for the same physical SMMU if available.
>      If not, allocate a new one using the nesting parent S2 HWPT.
>    - Pre-allocate two proxy nested HWPTs (bypass and abort) under the
>      vIOMMU and install one based on GBPA.ABORT value.
>    - Add the device to the vIOMMU’s device list.
> 
> unset_iommu_device():
>    - Re-attach device to the nesting parent S2 HWPT.
>    - Remove the device from the vIOMMU’s device list.
>    - If the list is empty, free the proxy HWPTs (bypass and abort)
>      and release the vIOMMU object.
> 
> Introduce struct SMMUv3AccelState, representing an accelerated SMMUv3
> instance backed by an iommufd vIOMMU object, and storing the bypass and
> abort proxy HWPT IDs.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/smmuv3-accel.c    | 154 +++++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3-accel.h    |  16 ++++
>   hw/arm/smmuv3-internal.h |   3 +
>   hw/arm/trace-events      |   4 +
>   include/hw/arm/smmuv3.h  |   1 +
>   5 files changed, 178 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index bd4a7dbde1..4dd56a8e65 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -8,6 +8,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> +#include "trace.h"
>   
>   #include "hw/arm/smmuv3.h"
>   #include "hw/iommu.h"
> @@ -15,6 +16,7 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/vfio/pci.h"
>   
> +#include "smmuv3-internal.h"
>   #include "smmuv3-accel.h"
>   
>   /*
> @@ -43,6 +45,156 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>       return accel_dev;
>   }
>   
> +static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
> +{
> +    return FIELD_EX32(s->gbpa, GBPA, ABORT) ?
> +           accel->abort_hwpt_id : accel->bypass_hwpt_id;
> +}
> +
> +static bool
> +smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                          Error **errp)
> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { SMMU_STE_VALID, 0x0ULL },
> +    };
> +    uint32_t s2_hwpt_id = idev->hwpt_id;
> +    uint32_t viommu_id, hwpt_id;
> +    SMMUv3AccelState *accel;
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                      s2_hwpt_id, &viommu_id, errp)) {
> +        return false;
> +    }
> +
> +    accel = g_new0(SMMUv3AccelState, 1);
> +    accel->viommu.viommu_id = viommu_id;
> +    accel->viommu.s2_hwpt_id = s2_hwpt_id;
> +    accel->viommu.iommufd = idev->iommufd;
> +
> +    /*
> +     * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
> +     * later for guest STEs or GBPAs that require bypass or abort configuration.
> +     */
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
> +                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(abort_data), &abort_data,
> +                                    &accel->abort_hwpt_id, errp)) {
> +        goto free_viommu;
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
> +                                    0, IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(bypass_data), &bypass_data,
> +                                    &accel->bypass_hwpt_id, errp)) {
> +        goto free_abort_hwpt;
> +    }
> +
> +    /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
> +    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +        goto free_bypass_hwpt;
> +    }
> +    s->s_accel = accel;
> +    return true;
> +
> +free_bypass_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
> +free_abort_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, accel->viommu.viommu_id);
> +    g_free(accel);
> +    return false;
> +}
> +
> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_setg(errp, "Device already has an associated idev 0x%x",
> +                       idev->devid);
> +            return false;
> +        }
> +        return true;
> +    }
> +
> +    if (s->s_accel) {
> +        goto done;
> +    }
> +
> +    if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
> +        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
> +                          idev->devid);
> +        return false;
> +    }
> +
> +done:
> +    accel_dev->idev = idev;
> +    accel_dev->s_accel = s->s_accel;
> +    QLIST_INSERT_HEAD(&s->s_accel->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, idev->devid);
> +    return true;
> +}
> +
> +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> +                                            int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUv3AccelState *accel;
> +    SMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        return;
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        return;
> +    }
> +
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    idev = accel_dev->idev;
> +    accel = accel_dev->s_accel;
> +    /* Re-attach the default s2 hwpt id */
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
> +        error_report("Unable to attach the default HW pagetable: idev devid "
> +                     "0x%x", idev->devid);
> +    }
> +
> +    accel_dev->idev = NULL;
> +    accel_dev->s_accel = NULL;
> +    QLIST_REMOVE(accel_dev, next);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
> +
> +    if (QLIST_EMPTY(&accel->device_list)) {
> +        iommufd_backend_free_id(accel->viommu.iommufd, accel->bypass_hwpt_id);
> +        iommufd_backend_free_id(accel->viommu.iommufd, accel->abort_hwpt_id);
> +        iommufd_backend_free_id(accel->viommu.iommufd, accel->viommu.viommu_id);
> +        g_free(accel);
> +        s->s_accel = NULL;
> +    }
> +}
> +
>   /*
>    * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
>    * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
> @@ -145,6 +297,8 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>       .supports_address_space = smmuv3_accel_supports_as,
>       .get_address_space = smmuv3_accel_find_add_as,
>       .get_viommu_flags = smmuv3_accel_get_viommu_flags,
> +    .set_iommu_device = smmuv3_accel_set_iommu_device,
> +    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>   };
>   
>   static void smmuv3_accel_as_init(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 0dc6b00d35..c72605caab 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -10,10 +10,26 @@
>   #define HW_ARM_SMMUV3_ACCEL_H
>   
>   #include "hw/arm/smmu-common.h"
> +#include "system/iommufd.h"
> +#include <linux/iommufd.h>
>   #include CONFIG_DEVICES
>   
> +/*
> + * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
> + * Holds bypass and abort proxy HWPT IDs used for device attachment.
> + */
> +typedef struct SMMUv3AccelState {
> +    IOMMUFDViommu viommu;
> +    uint32_t bypass_hwpt_id;
> +    uint32_t abort_hwpt_id;
> +    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +} SMMUv3AccelState;
> +
>   typedef struct SMMUv3AccelDevice {
>       SMMUDevice sdev;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    QLIST_ENTRY(SMMUv3AccelDevice) next;
> +    SMMUv3AccelState *s_accel;
>   } SMMUv3AccelDevice;
>   
>   #ifdef CONFIG_ARM_SMMUV3_ACCEL
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..81212a58f1 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -583,6 +583,9 @@ typedef struct CD {
>       ((extract64((x)->word[7], 0, 16) << 32) |           \
>        ((x)->word[6] & 0xfffffff0))
>   
> +#define SMMU_STE_VALID      (1ULL << 0)
> +#define SMMU_STE_CFG_BYPASS (1ULL << 3)
> +
>   static inline int oas2bits(int oas_field)
>   {
>       switch (oas_field) {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..2aaa0c40c7 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
>   smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>   smmu_reset_exit(void) ""
>   
> +#smmuv3-accel.c
> +smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
> +smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
> +
>   # strongarm.c
>   strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
>   strongarm_ssp_read_underrun(void) "SSP rx underrun"
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index bb7076286b..e54ece2d38 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -66,6 +66,7 @@ struct SMMUv3State {
>   
>       /* SMMU has HW accelerator support for nested S1 + s2 */
>       bool accel;
> +    struct SMMUv3AccelState *s_accel;

This is a sign that SMMUv3AccelState should a QOM object.

C.


>   };
>   
>   typedef enum {


