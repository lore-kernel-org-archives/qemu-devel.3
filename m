Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C60CD167E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8rR-0005Vu-BD; Fri, 09 Jan 2026 04:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ve8rO-0005SG-UV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ve8rM-0003vl-JZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767951163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AADArgLhHTZy437dGXe5a735ddp3euGjsquLaiwRRjE=;
 b=QLupk6Vc+CflITjKz1NWE9sDMD6DnVAaPE7U1lYTLvewhds0wtB/Y+K+59Ih2L166qXltw
 jEjiK16RcBfwISOw2kWNwRFQ+etjTXSu3KOJ25s9OYmOFgrsFhiuqQoFCUo3nuZ2ZEUXh/
 H84zn26F9GxiAbwG6ql22W3WrXxxKP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-8ZHQojHLO5-5pKZ43c5_3A-1; Fri, 09 Jan 2026 04:32:42 -0500
X-MC-Unique: 8ZHQojHLO5-5pKZ43c5_3A-1
X-Mimecast-MFC-AGG-ID: 8ZHQojHLO5-5pKZ43c5_3A_1767951161
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso2857412f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767951159; x=1768555959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AADArgLhHTZy437dGXe5a735ddp3euGjsquLaiwRRjE=;
 b=DeUbH8s47pBU07BuHQopvPDKa1q3qeYY2V7UtkcTEYchq7oe7YJQWGnZ63k6kvNd7U
 RuEbC9ZC8QUlKTB3Kix5fwLibXQMNlFpYbw/aUZ0eBtG8pAoRg7nlR9YdR0ZOoyXh83c
 009Dqbh1vmaOwftonBm+wxSjl8kcslt64HNRjJmSvsBj6JTI3whmIGmCoihzdvQOt85f
 9INqVnezYkxozmglsHcIUBX5Nv6rQwhc2hLloLvcvza/vj5DAfrH9JxE6xcpmEv7VQLa
 F0fL93FO8WqbLsgwNBEWAt1aI5sVPMzE6TpRED85gDAFgGI+Rxb6XMjjb6ZwPufeedeb
 aKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767951159; x=1768555959;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AADArgLhHTZy437dGXe5a735ddp3euGjsquLaiwRRjE=;
 b=SM8t3xBYy0xpDGkK62vMMndGowRenXYniUBZmNLIDHnK6FYG2CWr9nEuLVVfaqN6jO
 nezx7B2d0c1cpvOnTj0CeB3uIDFh00bNB+q34AtjgFeYfOESdJmXFBfxPfc3e5E8soz/
 GGJCewQY2DeyOCdxgm+adk4/6yKe+piY8ELhx6e3hpde9nqNkNAxyvb13nLI/VuW9WtO
 FFaqyaHwswITnETSYbkcJ1dQIrS1kdTaEoHtcbNhOmRaGQE0L+5fkVPNbmHPAPtSMhFJ
 XVjUPuEQ36jFKFstt8dCc3TOLu52M10qXZ3CddwMTCmHI2SBNt1RmSdCyhjor9pSGm4L
 6lWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdd4re453YSO2z79Not+lo9BtiP0a+eAB3eC3IR0/9CqpfX5LL7FAsMzn8mAf3uSzfgziCx4J1LQkU@nongnu.org
X-Gm-Message-State: AOJu0YzMcHIHUXvWN53B5jsZcaF8iFyqFZbYx9JPFohcE6ot2b93s7hJ
 pgSDPkFc7bY14VP9D4x1xCsLiY0ZPSmM6G21GVoQDeNWHJWMhRRJnXNRp+XFD3yTdVeZlpjQde2
 jXXU4sM4IkWJILx5l2pZqNgR1wvvDg7NuvjXeKGkwnHc+JvjelpEt9+oj
X-Gm-Gg: AY/fxX7UtODV1CGfY08t1FxgmPAv4qm1Gz8TNOLWdlDjIIetRK5oWFwxA2qLfsvbcG5
 HI33NUQd0Z7GBILvE9wi41CnYMPyJ3h91eSTcNAxTC3NWWWxpW/2BiOJ0ZfRorI3Wc+wY1YVWw2
 YeuH03TgV9uDIbBf6ANarIJ3ia8qyg8bbD6ZiSJHp5yoSBvVJps1yYb2u1O1Q5UdYKURq3V7J/d
 in+ja8dRFXSC41PKxleS/GcSwFnWtG+L9G08Ku9mjn8mzzFdlANA4LXTeaULHNnluRFO2EHwSas
 IETjoMmoNzc1+7I7Lh0jnhXjN4qf0cNoQyHtq0PaVQRRQTArm4dKBCmEQ7SDBOEnxYOh+T7v+jO
 DeCDeMGI0Tgj7xP/kVJGtQz07N5f0ZSiS4rrDooeUuEJp2aLy
X-Received: by 2002:a05:6000:1447:b0:430:f41f:bd42 with SMTP id
 ffacd0b85a97d-432c3775b0bmr11862665f8f.57.1767951159477; 
 Fri, 09 Jan 2026 01:32:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyJQMwQQ1SY9aPI3x7roKpeXShL7uRw/UCwEAumZvq/bhBqG6CuIyCQKCY3iMOl1U4vzxC2Q==
X-Received: by 2002:a05:6000:1447:b0:430:f41f:bd42 with SMTP id
 ffacd0b85a97d-432c3775b0bmr11862617f8f.57.1767951158943; 
 Fri, 09 Jan 2026 01:32:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm21282194f8f.2.2026.01.09.01.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 01:32:38 -0800 (PST)
Message-ID: <fb38c496-4a80-45e2-9a4d-a40e3bbf8c5a@redhat.com>
Date: Fri, 9 Jan 2026 10:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
 <fde9622a-a336-469e-982d-b82991243424@redhat.com>
 <CH3PR12MB75482AA6E44111F51B5F8E47ABBBA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB75482AA6E44111F51B5F8E47ABBBA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Shameer,

On 1/2/26 16:35, Shameer Kolothum wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: 15 December 2025 10:55
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 11/20/25 14:22, Shameer Kolothum wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> If user wants to expose PASID capability in vIOMMU, then VFIO would also
>>> need to report the PASID cap for this device if the underlying hardware
>>> supports it as well.
>>>
>>> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
>>> vconfig space. This is a choice in the good hope of no conflict with any
>>> existing cap or hidden registers. For the devices that has hidden registers,
>>> user should figure out a proper offset for the vPASID cap. This may require
>>> an option for user to config it. Here we leave it as a future extension.
>>> There are more discussions on the mechanism of finding the proper offset.
>>>
>>>
>> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2
>> @BN9PR11MB5276.namprd11.prod.outlook.com/
>>>
>>> Since we add a check to ensure the vIOMMU supports PASID, only devices
>>> under those vIOMMUs can synthesize the vPASID capability. This gives
>>> users control over which devices expose vPASID.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>    hw/vfio/pci.c      | 38 ++++++++++++++++++++++++++++++++++++++
>>>    include/hw/iommu.h |  1 +
>>>    2 files changed, 39 insertions(+)
>>
>>
>> I just noticed another problem with this change. It relies on the
>> availability of the HostIOMMUDevice which doesn't exist with VFIO
>> mdev devices, such as vGPU. QEMU simply coredumps :/
>>
>> We will have to check/protect QEMU in some ways. I need to take
>> a closer look because mdev handling seems to be spread across
>> the code and may need to be improved first.
> 
> I did attempt a rework on this patch and the previous one(patch #31) to
> address the above issue and to avoid the #ifdef CONFIG_IOMMUFD in
> vfio. Please find below:
> 
> Patch #1:
> This adds get_pasid_info to  HostIOMMUDeviceClass. One thing I am not
> sure, below is to use #ifdef CONFIG_LINUX or not. Please take a look
> and let me know if this is the right direction or not.

I don't think CONFIG_LINUX is needed there because the declarations
are not specific to linux. A simple way to try a windows build is with :

   --cross-prefix=x86_64-w64-mingw32-

you might need to add :

   --disable-sdl

and targets should be aarch64-softmmu,ppc64-softmmu,x86_64-softmmu,s390x-softmmu

You should resend a v7, in whole or in parts, as you wish.

Thanks,

C.

> 
> 
>  From e1305b0d44b2002778059decc3d6b220414b0589 Mon Sep 17 00:00:00 2001
> From: Shameer Kolothum <skolothumtho@nvidia.com>
> Date: Fri, 2 Jan 2026 14:50:58 +0000
> Subject: [PATCH 1/2] backends/iommufd: Add get_pasid_info
> 
> TODO:
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c                 | 17 +++++++++++++++++
>   include/system/host_iommu_device.h | 19 +++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2c9ce1a03a..7beff372ba 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -634,11 +634,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       }
>   }
> 
> +static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
> +                                        HostIOMMUDevicePasidInfo *pasid_info)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    if (!caps->max_pasid_log2) {
> +        return false;
> +    }
> +
> +    g_assert(pasid_info);
> +    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
> +    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
> +    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
> +    return true;
> +}
> +
>   static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>   {
>       HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> 
>       hioc->get_cap = hiod_iommufd_get_cap;
> +    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
>   };
> 
>   static const TypeInfo types[] = {
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index bfb2b60478..6e62f643fe 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -22,6 +22,13 @@ typedef union VendorCaps {
>       struct iommu_hw_info_arm_smmuv3 smmuv3;
>   } VendorCaps;
> 
> +
> +typedef struct HostIOMMUDevicePasidInfo {
> +    bool exec_perm;
> +    bool priv_mod;
> +    uint64_t max_pasid_log2;
> +} HostIOMMUDevicePasidInfo;
> +
>   /**
>    * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>    *
> @@ -116,6 +123,18 @@ struct HostIOMMUDeviceClass {
>        * @hiod: handle to the host IOMMU device
>        */
>       uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> +#ifdef CONFIG_LINUX
> +    /**
> +     * @get_pasid_info: Return the PASID information associated with the Host
> +     * IOMMU device.
> +     *
> +     * @pasid_info: If success, returns the PASID related information.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*get_pasid_info)(HostIOMMUDevice *hiod,
> +                           HostIOMMUDevicePasidInfo *pasid_info);
> +#endif
>   };
> 
>   /*
> --
> 
> Patch #2:
> This adds a check for mdev to avoid the coredump mentioned above.
> Please let me know If you have a nicer/broader solution to address this
> for mdev devices.
> 
>  From bbb54b349fccd61d8dab6b95be11c42510db3f95 Mon Sep 17 00:00:00 2001
> From: Shameer Kolothum <skolothumtho@nvidia.com>
> Date: Fri, 2 Jan 2026 14:52:26 +0000
> Subject: [PATCH 2/2] hw/vfio/pci: Add pasid cap synthesize
> 
> TODO:
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/pci.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8b8bc5a421..5f1a93cfc8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -24,6 +24,7 @@
>   #include <sys/ioctl.h>
> 
>   #include "hw/hw.h"
> +#include "hw/iommu.h"
>   #include "hw/pci/msi.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -2498,9 +2499,41 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>       return 0;
>   }
> 
> +/*
> + * Try to retrieve PASID CAP through IOMMUFD APIs. If available, adds the
> + * PASID capability in the end of the PCIe config space.
> + * TODO: Add support for enabling pasid at a safe offset.
> + */
> +static void vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev)
> +{
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    HostIOMMUDeviceClass *hiodc;
> +    HostIOMMUDevicePasidInfo pasid_info;
> +
> +    if (vdev->vbasedev.mdev) {
> +        return;
> +    }
> +
> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc->get_pasid_info ||
> +        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
> +        return;
> +    }
> +
> +    if (hiodc->get_pasid_info(hiod, &pasid_info)) {
> +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
> +                        pasid_info.max_pasid_log2, pasid_info.exec_perm,
> +                        pasid_info.priv_mod);
> +        /* PASID capability is fully emulated by QEMU */
> +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
> +    }
> +}
> +
>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> +    bool pasid_cap_added = false;
>       uint32_t header;
>       uint16_t cap_id, next, size;
>       uint8_t cap_ver;
> @@ -2578,12 +2611,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                   pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>               }
>               break;
> +        /*
> +         * VFIO kernel does not expose the PASID CAP today. We may synthesize
> +         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
> +         * record its presence here so we do not create a duplicate CAP.
> +         */
> +        case PCI_EXT_CAP_ID_PASID:
> +             pasid_cap_added = true;
> +             /* fallthrough */
>           default:
>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>           }
> 
>       }
> 
> +    if (!pasid_cap_added) {
> +        vfio_pci_synthesize_pasid_cap(vdev);
> +    }
> +
>       /* Cleanup chain head ID if necessary */
>       if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>           pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> --
> 2.43.0
> 
> Please let me know your thoughts.
> 
> Thanks,
> Shameer


