Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48821CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 09:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuSlb-0005R2-7P; Fri, 05 Sep 2025 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuSjy-0002w9-QQ
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuSjp-0006tK-0e
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757064484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfLCcYWhy/M7bqtkVZrqMun6lsd4dGXdHhVES5bG/AU=;
 b=VwOOOmvEpAvQCFHjLXZWUl9+g1vdIyaLRXmklIPnedUKboGN//3Rk/hX8mcjEmQUOYG9AY
 706cPYOh+Gymf8EtbSDIYRXn94lJlGLrVNJQt21eMTgCh4A55f/4XXU50D0QQbdyP0uhys
 8jDcAEcU8h5LP456CWAaOGey0B2rDMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-1RrGHREOP_2ZVr46yJdX1A-1; Fri, 05 Sep 2025 05:27:52 -0400
X-MC-Unique: 1RrGHREOP_2ZVr46yJdX1A-1
X-Mimecast-MFC-AGG-ID: 1RrGHREOP_2ZVr46yJdX1A_1757064472
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e4a8e6df10so116168f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 02:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757064471; x=1757669271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfLCcYWhy/M7bqtkVZrqMun6lsd4dGXdHhVES5bG/AU=;
 b=v7MRldFW1MzZRJcCNMrQSQLLQ4gDbNRBOo7H2kVMwVNqfvcJ55rPNz51NYUbgRYd7V
 tN4SbO2wcyT9rVmoMrZ5e1l2gDqoQ936t4ScTuAlw3BoARX7K3kafF4LmH1L0Ty+LD5X
 ClX7c0RQKuKvAV6YAmgf1avNeihCNsJi/n32s99/r4sonO7qliiDflSvRe95edH9OwLc
 n+SEcA7GIpeV1rLYTh01BVelBEfmBJB5DZAROV8i1KWRQCcaYPeJFscIKLSw1Pb6kFS7
 LkAd2MqklGvtFpERJjnpgY+3Vvq2ANvCT/jbM7lw99Z3rdFk9w0Zborb1RLlG0N6p8jU
 3Prw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpyCqICvcZhvAO78drx3RXICIKd/+e9PwYu0G4IHAKYXmZQKpq0Wb6JLaZyWRy0DtcAb1hh/WcY7F2@nongnu.org
X-Gm-Message-State: AOJu0YxhNc+FNlDVMhLO1+2DbShpmjXWIY82b7KNJhV1bxg+NUytMuLo
 mkfTL1pGh2HRCqEs7rkp1KAIjFLzMtEPgBznlLOv53tcWqFzkv78L/2V3PBkwaIGl5oxSst9Nu7
 Hzg2yBE+4IaY8+/4O78pZuN4ZzaIH1byEFEXStD0t8786NhGoYVeyZt4u
X-Gm-Gg: ASbGnctXRtRBu0Zi4nMooZqvRsoweahCnN/kFQ5BHswGlF3TUa9yvJGDevpA68P/mNu
 dqfu0CIUEMPF9rVaGW5R6mYl5aWCLoUt00YF24i5d3SV8G0Kw8wEtLesBNp2empVTwQP6XuVywW
 zOjhDpQAu9z7u8XOjUEaiNmO2pSa2BeNyD7AKrEu4GsRqB0cacakt9q4FdXRkz61gscM5wBXK3n
 +51dI9ImSceUGpzLxD2021OoWxm2d7mO0fBKP2cFqOxjTfVYe6hWbMyk/3B7blfKah/1s0M6EXi
 m6EFTkfAqnOJA33rFZaWZPu3i0smNfWIPTTN2Ag+dheVp3NUN7bveyDw9tn2ctq2U12ZotatgXJ
 r3lOaSGD1cHA=
X-Received: by 2002:a05:6000:24c4:b0:3d6:3af4:7cd9 with SMTP id
 ffacd0b85a97d-3d63af4818emr17584335f8f.12.1757064470624; 
 Fri, 05 Sep 2025 02:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzOp6T18qWMrzI96B9xcPwJtqslzuyVx1th9qas1mhxn5tpBpUumUwjQ/ymBPnUrKthbsM8g==
X-Received: by 2002:a05:6000:24c4:b0:3d6:3af4:7cd9 with SMTP id
 ffacd0b85a97d-3d63af4818emr17584304f8f.12.1757064470061; 
 Fri, 05 Sep 2025 02:27:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3da13041bcasm14726110f8f.35.2025.09.05.02.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 02:27:49 -0700 (PDT)
Message-ID: <44b5f066-e419-4ed2-916d-f64b3c003213@redhat.com>
Date: Fri, 5 Sep 2025 11:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, skolothumtho@nvidia.com
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Implement a set_iommu_device callback:
>  -If found an existing viommu reuse that.
>    (Devices behind the same physical SMMU should share an S2 HWPT)
I failed to see where this is done below?
>  -Else,
>     Allocate a viommu with the nested parent S2 hwpt allocated by VFIO.
>     Allocate bypass and abort hwpt.
>  -And add the dev to viommu device list
>
> Also add an unset_iommu_device to unwind/cleanup above.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c    | 154 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h    |  20 +++++
>  hw/arm/trace-events      |   4 +
>  include/system/iommufd.h |   6 ++
>  4 files changed, 184 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 66cd4f5ece..fe90d48675 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "trace.h"
>  #include "qemu/error-report.h"
>  
>  #include "hw/arm/smmuv3.h"
> @@ -17,6 +18,9 @@
>  
>  #include "smmuv3-accel.h"
>  
> +#define SMMU_STE_VALID      (1ULL << 0)
> +#define SMMU_STE_CFG_BYPASS (1ULL << 3)
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> @@ -39,6 +43,154 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>      return accel_dev;
>  }
>  
> +static bool
> +smmuv3_accel_dev_alloc_viommu(SMMUv3AccelDevice *accel_dev,
> +                               HostIOMMUDeviceIOMMUFD *idev, Error **errp)
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
> +    SMMUS2Hwpt *s2_hwpt;
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
> +    s2_hwpt = g_new(SMMUS2Hwpt, 1);
> +    s2_hwpt->iommufd = idev->iommufd;
> +    s2_hwpt->hwpt_id = s2_hwpt_id;
> +
> +    viommu->iommufd = idev->iommufd;
> +    viommu->s2_hwpt = s2_hwpt;
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
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    if (!idev) {
> +        return true;
> +    }
> +
> +    if (accel_dev->idev) {
> +        if (accel_dev->idev != idev) {
> +            error_report("Device 0x%x already has an associated idev",
would not use "idev" as end-user will not easily understand what the
beast is
> +                         smmu_get_sid(sdev));
> +            return false;
if this is considered as an error why don't we set errp?
> +        } else {
> +            return true;
> +        }
> +    }
> +
> +    if (!smmuv3_accel_dev_alloc_viommu(accel_dev, idev, errp)) {
> +        error_report("Device 0x%x: Unable to alloc viommu", smmu_get_sid(sdev));
> +        return false;
same here
> +    }
> +
> +    accel_dev->idev = idev;
> +    QLIST_INSERT_HEAD(&s_accel->viommu->device_list, accel_dev, next);
> +    trace_smmuv3_accel_set_iommu_device(devfn, smmu_get_sid(sdev));
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
> +    if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                               accel_dev->idev->hwpt_id,
> +                                               NULL)) {
> +        error_report("Unable to attach dev to the default HW pagetable");
also trace smmu_get_sid(sdev) to be consistent with other traces?
> +    }
> +
> +    accel_dev->idev = NULL;
> +    QLIST_REMOVE(accel_dev, next);
> +    trace_smmuv3_accel_unset_iommu_device(devfn, smmu_get_sid(sdev));
> +
> +    viommu = s->s_accel->viommu;
> +    if (QLIST_EMPTY(&viommu->device_list)) {
> +        iommufd_backend_free_id(viommu->iommufd, viommu->bypass_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->abort_hwpt_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->core.viommu_id);
> +        iommufd_backend_free_id(viommu->iommufd, viommu->s2_hwpt->hwpt_id);
> +        g_free(viommu->s2_hwpt);
> +        g_free(viommu);
> +        s->s_accel->viommu = NULL;
> +    }
> +}
> +
>  static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
>  {
>  
> @@ -98,6 +250,8 @@ static uint64_t smmuv3_accel_get_viommu_cap(void *opaque)
>  static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_address_space = smmuv3_accel_find_add_as,
>      .get_viommu_cap = smmuv3_accel_get_viommu_cap,
> +    .set_iommu_device = smmuv3_accel_set_iommu_device,
> +    .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 2cd343103f..55a6a353fc 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -11,16 +11,36 @@
>  
>  #include "hw/arm/smmuv3.h"
>  #include "hw/arm/smmu-common.h"
> +#include "system/iommufd.h"
> +#include <linux/iommufd.h>
>  #include CONFIG_DEVICES
>  
> +typedef struct SMMUS2Hwpt {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t hwpt_id;
> +} SMMUS2Hwpt;
> +
> +typedef struct SMMUViommu {
> +    IOMMUFDBackend *iommufd;
> +    IOMMUFDViommu core;
> +    SMMUS2Hwpt *s2_hwpt;
> +    uint32_t bypass_hwpt_id;
> +    uint32_t abort_hwpt_id;
> +    QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +} SMMUViommu;
> +
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
>      AddressSpace as_sysmem;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    SMMUViommu *viommu;
> +    QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
>  typedef struct SMMUv3AccelState {
>      MemoryRegion root;
>      MemoryRegion sysmem;
> +    SMMUViommu *viommu;
>  } SMMUv3AccelState;
>  
>  #if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..c4537ca1d6 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -66,6 +66,10 @@ smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s
>  smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
>  smmu_reset_exit(void) ""
>  
> +#smmuv3-accel.c
> +smmuv3_accel_set_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x)"
> +smmuv3_accel_unset_iommu_device(int devfn, uint32_t sid) "devfn=0x%x (sid=0x%x"
> +
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
>  strongarm_ssp_read_underrun(void) "SSP rx underrun"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 6ab3ba3cb6..b7ad2cf10c 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -38,6 +38,12 @@ struct IOMMUFDBackend {
>      /*< public >*/
>  };
>  
> +typedef struct IOMMUFDViommu {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t s2_hwpt_id;
> +    uint32_t viommu_id;
> +} IOMMUFDViommu;
> +
>  bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>  void iommufd_backend_disconnect(IOMMUFDBackend *be);
>  
Thanks

Eric


