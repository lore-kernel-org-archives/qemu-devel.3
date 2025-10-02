Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E6CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 06:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DC1-0001vv-Dn; Thu, 02 Oct 2025 02:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4DBx-0001tl-Ai
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4DBi-000154-SJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759387984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPsY3CfUUFwCkoL++FUa8+ITS2ZV56ABrofUnGO7PGU=;
 b=QhWoHgWvwO4dRioPwh5VyIAFKOYhbHWKtIA+CImHyEaoy0E44lFUGMV1s3w30XpSgUg2tm
 82TkQ0i2YrRCQBKfRaG4Iast1dVj/Jb9JlC5kajGGxQEWg/EK0TBdDhDFKKyYI8TAWXvGi
 Ye8Ig3CXvhqJ623P7qVf5NF2KRRwSPM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-2LPyVmr-P9ujtAunDX3QOQ-1; Thu, 02 Oct 2025 02:53:03 -0400
X-MC-Unique: 2LPyVmr-P9ujtAunDX3QOQ-1
X-Mimecast-MFC-AGG-ID: 2LPyVmr-P9ujtAunDX3QOQ_1759387982
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso2062965e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 23:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759387982; x=1759992782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPsY3CfUUFwCkoL++FUa8+ITS2ZV56ABrofUnGO7PGU=;
 b=ph0iKFXdhL+GI9Q/CLFuFHIsuE/5R1U0J5EGzOiuPhg0E7TC7JrYwjPPC74nAVc/c4
 3jDLV73h5D6qSvrjEo4PLoGDbQvVvx+gKe5V0Wu5Pkg7X3XmmiGcFyv5EoPbNrsF12hm
 /P7ft1YA847scmV8icopem9kBlYDu/uuBFGBGczkC77rjSuBsYfEz2gwHtsV9U8nf0FN
 J5krm6KMrWEFUkaPeweKfkVdTu6zQ7T9UeMuyIsIFw7wRH3DOj3WD+6WotwPpfCfovIw
 VBsRdd3ipOvkMWnWtmiyRxfuhUOTypqCVn/73DFN1Pr1AXPlpZJsqoEGfLzA1KUedEY+
 wcnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXch1fK5NofNL3DXqQOzoNuxWiXrdf3z5sJicEbBKMPiI67anfjG2Crwzk2YnU4XfxaZnynG3yVrv4M@nongnu.org
X-Gm-Message-State: AOJu0YyueGPHqSsARzs5fL89tKvfOQGgEAWtqofvMN8O2kr57Ka+z9RY
 KsU2Q/wBMQUfbnP36ThXLtivIpYDTqF3Be1+NFgjUnTIT7X4GtNxz1oM7uKqlrHqR/FQzBLthT6
 Bzaorg8qjWd1dhBIY+onMh34ZghWQRsHcJXcx9b6+eCEMlKmR0vCvrP9J
X-Gm-Gg: ASbGnctW5KiuoCVYzeYTilsXU3/h/mktu7bs6RGip2xqfnu8ZEO0QPwMXOVom2gLL7E
 Ud3Sk8fYAQwwS56uzQ8SBMnp9s/btt2NSo3At7K+BrXy6aK0kQlg8HNyZf990pPwSRSxP2H2aJG
 5NKTUXCLatDGMpyjkJfGgoJAyXSqBMDLaVFOmZoJ7DwOVEUVZ1COAY2KsC2TZlY5nxwj3fG1mko
 Fg3UqHYkCleSoKgOGlj682ixlGigilLTwQYybcVkHaIX22HcRM4Fjjri4kbj+KhxlWm2neOHPZ5
 mvfuY6QSh+Pi+8Hvif3kkdTE8KPQfrQIvRxD1Y0jhEHtRt5UuYrfl/W4OHIWFzJZuFqKflG0gCT
 zmWQFLMTjgCBQvDg7
X-Received: by 2002:a05:6000:4382:b0:3ea:c893:95a7 with SMTP id
 ffacd0b85a97d-4255780b1b8mr4352594f8f.31.1759387981601; 
 Wed, 01 Oct 2025 23:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiGuxTmVYJqEsiAblpRxkylI6pVQPxNzZH+RSjaslG/dYz+gEJ8HUIEbG78AIHKIfd9BXdWg==
X-Received: by 2002:a05:6000:4382:b0:3ea:c893:95a7 with SMTP id
 ffacd0b85a97d-4255780b1b8mr4352563f8f.31.1759387981083; 
 Wed, 01 Oct 2025 23:53:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9762sm2252557f8f.38.2025.10.01.23.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 23:52:59 -0700 (PDT)
Message-ID: <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
Date: Thu, 2 Oct 2025 08:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
the original intent of this callback is

     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
     *
     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
     * retrieve host information from the associated HostIOMMUDevice.
     *

The implementation below goes way behond the simple "attachment" of the
HostIOMMUDevice to the vIOMMU.
allocation of a vIOMMU; allocation of 2 HWPTs, creation of a new
SMMUv3AccelState
>
> Implement a set_iommu_device callback:
>  -If found an existing viommu reuse that.
I think you need to document why you need a vIOMMU object.
>  -Else,
>     Allocate a vIOMMU with the nested parent S2 hwpt allocated by VFIO.
>     Though, iommufd’s vIOMMU model supports nested translation by
>     encapsulating a S2 nesting parent HWPT, devices cannot attach to this
>     parent HWPT directly. So two proxy nested HWPTs (bypass and abort) are
>     allocated to handle device attachments.

"devices cannot attach to this parent HWPT directly".  Why? It is not clear to me what those hwpt are used for compared to the original one. Why are they mandated? To me this deserves some additional explanations. If they are s2 ones, I would use an s2 prefix too.

>  -And add the dev to viommu device list
this is the initial objective of the callback
>
> Also add an unset_iommu_device to unwind/cleanup above.

I think you shall document the introduction of SMMUv3AccelState.It
currently contains a single member, do you plan to add others.
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 150 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h   |  17 +++++
>  hw/arm/trace-events     |   4 ++
>  include/hw/arm/smmuv3.h |   1 +
>  4 files changed, 172 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 6b0e512d86..81fa738f6f 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -8,6 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "trace.h"
>  
>  #include "hw/arm/smmuv3.h"
>  #include "hw/iommu.h"
> @@ -17,6 +18,9 @@
>  
>  #include "smmuv3-accel.h"
>  
> +#define SMMU_STE_VALID      (1ULL << 0)
> +#define SMMU_STE_CFG_BYPASS (1ULL << 3)
I would rather put that in smmuv3-internal.h where you have other STE
macros. Look for "/* STE fields */
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                 PCIBus *bus, int devfn)
>  {
> @@ -35,6 +39,149 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static bool
> +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> +                              HostIOMMUDeviceIOMMUFD *idev, Error **errp)
> +{
> +    struct iommu_hwpt_arm_smmuv3 bypass_data = {
> +        .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
> +    };
> +    struct iommu_hwpt_arm_smmuv3 abort_data = {
> +        .ste = { SMMU_STE_VALID, 0x0ULL },
> +    };
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    SMMUState *bs = sdev->smmu;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    uint32_t s2_hwpt_id = idev->hwpt_id;
> +    SMMUViommu *viommu;
> +    uint32_t viommu_id;
> +
> +    if (s_accel->viommu) {
> +        accel_dev->viommu = s_accel->viommu;
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> +                                      s2_hwpt_id, &viommu_id, errp)) {
> +        return false;
> +    }
> +
> +    viommu = g_new0(SMMUViommu, 1);
> +    viommu->core.viommu_id = viommu_id;
> +    viommu->core.s2_hwpt_id = s2_hwpt_id;
> +    viommu->core.iommufd = idev->iommufd;
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(abort_data), &abort_data,
> +                                    &viommu->abort_hwpt_id, errp)) {
> +        goto free_viommu;
> +    }
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    viommu->core.viommu_id, 0,
> +                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
> +                                    sizeof(bypass_data), &bypass_data,
> +                                    &viommu->bypass_hwpt_id, errp)) {
> +        goto free_abort_hwpt;
> +    }
> +
> +    viommu->iommufd = idev->iommufd;
> +
> +    s_accel->viommu = viommu;
> +    accel_dev->viommu = viommu;
> +    return true;
> +
> +free_abort_hwpt:
> +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> +free_viommu:
> +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> +    g_free(viommu);
> +    return false;
> +}
> +
> +static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> +                                          HostIOMMUDevice *hiod, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
you are using smmuv3_accel_get_dev but logically the function was
already called once before in smmuv3_accel_find_add_as()? Meaning the
add/allocate part of the function is not something that should happen
here. Shouldn't we add a new helper that does SMMUPciBus *sbus =
g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus); if (!sbus) {
return; } sdev = sbus->pbdev[devfn]; if (!sdev) { return; } that would
be used both set and unset()?
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +    uint16_t sid = smmu_get_sid(sdev);
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_setg(errp, "Device 0x%x already has an associated IOMMU dev",
> +                       sid);
> +            return false;
> +        }
> +        return true;
> +    }
> +
> +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> +        error_setg(errp, "Device 0x%x: Unable to alloc viommu", sid);
> +        return false;
> +    }
> +
> +    accel_dev->idev = idev;
> +    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, sid);
> +    return true;
> +}
> +
> +static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
> +                                            int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUViommu *viommu;
> +    SMMUDevice *sdev;
> +    uint16_t sid;
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
> +    sid = smmu_get_sid(sdev);
> +    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               accel_dev->idev->hwpt_id,
> +                                               NULL)) {
> +        error_report("Unable to attach dev 0x%x to the default HW pagetable",
> +                     sid);
> +    }
> +
> +    accel_dev->idev = NULL;
> +    QLIST_REMOVE(accel_dev, next);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, sid);
> +
> +    viommu = s->s_accel->viommu;
> +    if (QLIST_EMPTY(&viommu->device_list)) {
> +        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
> +        g_free(viommu);
> +        s->s_accel->viommu = NULL;
> +    }
> +}
> +
>  static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
>  {
>  
> @@ -121,6 +268,8 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
>      .get_viommu_flags = smmuv3_accel_get_viommu_flags,
> +    .set_iommu_device = smmuv3_accel_set_iommu_device,
> +    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)
> @@ -128,4 +277,5 @@ void smmuv3_accel_init(SMMUv3State *s)
>      SMMUState *bs = ARM_SMMU(s);
>  
>      bs->iommu_ops = &smmuv3_accel_ops;
> +    s->s_accel = g_new0(SMMUv3AccelState, 1);
>  }
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 70da16960f..3c8506d1e6 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -10,12 +10,29 @@
>  #define HW_ARM_SMMUV3_ACCEL_H
>  
>  #include "hw/arm/smmu-common.h"
> +#include "system/iommufd.h"
> +#include <linux/iommufd.h>
>  #include CONFIG_DEVICES
>  
> +typedef struct SMMUViommu {
would deserve to be documented with explanation of what it does abstract
> +    IOMMUFDBackend *iommufd;
> +    IOMMUFDViommu core;
> +    uint32_t bypass_hwpt_id;
> +    uint32_t abort_hwpt_id;
> +    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +} SMMUViommu;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUViommu *viommu;
> +    QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
> +typedef struct SMMUv3AccelState {
> +    SMMUViommu *viommu;
> +} SMMUv3AccelState;
> +
>  #ifdef CONFIG_ARM_SMMUV3_ACCEL
>  void smmuv3_accel_init(SMMUv3State *s);
>  #else
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..86370d448a 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  smmu_reset_exit(void) ""
>  
> +#smmuv3-accel.c
> +smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
>  strongarm_ssp_read_underrun(void) "SSP rx underrun"
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index bb7076286b..5f3e9089a7 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -66,6 +66,7 @@ struct SMMUv3State {
>  
>      /* SMMU has HW accelerator support for nested S1 + s2 */
>      bool accel;
> +    struct SMMUv3AccelState  *s_accel;
>  };
>  
>  typedef enum {
Thanks

Eric


