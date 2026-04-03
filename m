Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67F9E7E358
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ad3-00050N-DM; Fri, 03 Apr 2026 05:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8acz-0004zd-7x
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8acx-0005N4-4q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775207741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/YVG5zEQaIXFEnuMRpB3HAGNmijTTDSxzi9qniyqcYc=;
 b=G+drhUt0X7XwDCKIE5F9Z8MkAmC/foAX5nmL+kXG34TN+k0OQet1tOfdaalHTjOIVlwKdC
 4TAScqq8ng5VYc4HxkwXftOFYapfg6DM5gH+a4Q8tawsAV5c7tmz2h1tqXAWuI7LT7huYb
 qljnVEzLrWKbgTn4QdoZjvK/ZuDAu9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-YpGOWKFHPkGguvhXJ6afVQ-1; Fri, 03 Apr 2026 05:15:37 -0400
X-MC-Unique: YpGOWKFHPkGguvhXJ6afVQ-1
X-Mimecast-MFC-AGG-ID: YpGOWKFHPkGguvhXJ6afVQ_1775207736
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b96365ea8so2267532f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775207736; x=1775812536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/YVG5zEQaIXFEnuMRpB3HAGNmijTTDSxzi9qniyqcYc=;
 b=fBz9a/WuIqblU4w3CmY1PPxCXWhU5/2w0so5Sb5gbaq0MsV0aZ5xNmcLJk1PRu/iZv
 sjl5udINfR1j8NFFyGVQkIrjAMo00oHHm02kwMCPUp8lrwFsAl3aQ7lMoy7Q27wGFvey
 PcMi2bgs4rraAzFMzqKPZMXpn2i8Mt3AlyyTzSOj/g8js21i4tMc31uuIh30q2LVbNG8
 UE1LBmfl+aZ5QlIQXhPJ8CB1ahGfmcvgpCQMXJz2KW3KjXvRKNWECxPR8Yi8JbZa5Maz
 ae3zbXGecexeX5cKuQm6GZi1ejuo8FHmQtKI8gyjc9JO36FlcUaSoC18U1P/oMfTDtVC
 KVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775207736; x=1775812536;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YVG5zEQaIXFEnuMRpB3HAGNmijTTDSxzi9qniyqcYc=;
 b=m2Y4U2VrYRzA0N2e2cHldlqVYcPScDS1SqiHkT6B0CrpQFFAXm9BdkU2sGAeoEzylA
 kDQ4U4oOYHiHe82NIFMLRUrHRZgCX3SzgYkLvhtgusXaapUmQe7RUpjtuSX5/jJB/oLG
 WR1wYEngYHTn/Pi5d3gZew/YoNgt45BbYVu0aOUZYz6DdaqV22uQtlf4OsZ+vpfCR1xj
 z+YAD6Snrvh4kstO7HEo56pICj2G160NQMr4yl+znt8tFC95N6cNrDL2ZzlM3w1+Aiff
 wS4pxvJzr8CggoDqX993zltQQarOB0X727oTi9wm+VXWaQf4OgJvi7Tw+/3U4yvbCYMt
 NcPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvPe719Og9nJL35N+eLhAZVuJDFQ4JHwFdsmqnvWX/+82PDm5+RqHhk7AoZsyCw+9jxsA4v3zNh7dW@nongnu.org
X-Gm-Message-State: AOJu0Yw/yJkHzV2TZT9QSHofAwBjO6AksrtOxDODQCUvfIUXU8xdn1ZD
 DlvivILQvQw8tbB8cVBl9yb6tK8iSA5zp5oiEqO4xngWBJy2HCmsg3zLhdgixEKPY5zeRHjylpg
 ipyVc2VE31m0t0gGfHEwLwonuSP4lnL54RN05Hw9dUDH6MPbL68QByfXB
X-Gm-Gg: AeBDievDTZSR3sKPQNqzFS69UdOtDv3RT/oZtVUUJhVfvrZufMqn9U+WjLhN+7Ygj78
 lqTMQN94IIJWFa8eJmEw6z+Tpy3M8PW1vVe0blc48jL3wBdYTat1oA5/ymN5P+Vu0Ea0WQcjFsO
 JrqZyD3tDCWkEZiuae7XsgnFJpHW1WkGtQZAwC1C72HIJdoeMU1fIAcQ8fQ+NXVImSFlJoWYDAQ
 Yb7xUNV3L8mWA9a30+7VBfQJS5ve3HWiijL9mLdN2myhCfkgutHo+xl96viM8msV8MHa+gxLg+z
 CpmTdWGXM+QCOQJLpUzeic38Fn0aZMrt+1oaIa9m0ozqzhRAKxXNnCCIrhYrjzExggHr4m4zNB1
 da3xPDZD+TvHwYrAIta12A8wlzdoI/MaiQZIDuIzBNJk4LCVPzs8iFEUxOPRo
X-Received: by 2002:a05:6000:1789:b0:43c:f8ce:269 with SMTP id
 ffacd0b85a97d-43d2927659bmr3888158f8f.2.1775207736251; 
 Fri, 03 Apr 2026 02:15:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:43c:f8ce:269 with SMTP id
 ffacd0b85a97d-43d2927659bmr3888103f8f.2.1775207735715; 
 Fri, 03 Apr 2026 02:15:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f1esm14996648f8f.2.2026.04.03.02.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 02:15:34 -0700 (PDT)
Message-ID: <f15d6ad1-df46-4283-a2b9-4af2b5b20213@redhat.com>
Date: Fri, 3 Apr 2026 11:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/iommufd: Control dirty tracking for nesting
 parent HWPT
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com
References: <20260401084133.56266-1-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260401084133.56266-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/1/26 10:41, Shameer Kolothum wrote:
> QEMU smmuv3 accel does not support live migration yet, so dirty
> tracking for the nesting parent HWPT is not useful.
> 
> Also, nested vIOMMU use cases can break on some platforms. For
> example, SMMUv3 with HTTU may advertise dirty tracking capability,
> but the kernel supports it only for stage-1. Requesting dirty
> tracking for a nesting parent HWPT (stage-2) can fail.
> 
> Add a vIOMMU flag to explicitly request dirty tracking for the
> nesting parent HWPT. For nested cases, dirty tracking is enabled
> only when requested by the vIOMMU.
> 
> Non-nested cases and Intel vIOMMU keep the existing behavior.
> 
> Fixes: fc6dafb98cec ("hw/arm/smmuv3: Implement get_viommu_cap() callback")
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   include/hw/core/iommu.h       |  2 ++
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/i386/intel_iommu.c         |  7 +++++--
>   hw/vfio/device.c              | 11 +++++++++++
>   hw/vfio/iommufd.c             | 11 +++++++++--
>   5 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 86af315c15..cd59a367ce 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -21,6 +21,8 @@ enum viommu_flags {
>       /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>       VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
> +    /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
> +    VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
>   };
>   
>   /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 828a31c006..a95c5bf503 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>   void vfio_device_unprepare(VFIODevice *vbasedev);
>   
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4924aa4375..5ec5ed82d7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4831,9 +4831,12 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>   static uint64_t vtd_get_viommu_flags(void *opaque)
>   {
>       IntelIOMMUState *s = opaque;
> -    uint64_t flags;
> +    uint64_t flags = 0;
>   
> -    flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
> +    if (s->fsts) {
> +        flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
> +                VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
> +    }
>   
>       return flags;
>   }
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..8f7ae919a5 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -522,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>       vbasedev->bcontainer = NULL;
>   }
>   
> +bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
> +                  VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING);
> +    }
> +    return false;
> +}
> +
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 131612eb83..231635cdc7 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -349,6 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       ERRP_GUARD();
>       IOMMUFDBackend *iommufd = vbasedev->iommufd;
>       VFIOContainer *bcontainer = VFIO_IOMMU(container);
> +    bool viommu_nesting, viommu_nesting_dirty;
>       uint32_t type, flags = 0;
>       uint64_t hw_caps;
>       VendorCaps caps;
> @@ -402,8 +403,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           return false;
>       }
>   
> +    viommu_nesting = vfio_device_get_viommu_flags_want_nesting(vbasedev);
> +    viommu_nesting_dirty =
> +        vfio_device_get_viommu_flags_want_nesting_dirty(vbasedev);
> +
>       if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +        if (!viommu_nesting || viommu_nesting_dirty) {
> +            flags |= IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +        }
>       }
>   
>       /*
> @@ -411,7 +418,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        * force to create it so that it could be reused by vIOMMU to create
>        * nested HWPT.
>        */
> -    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
> +    if (viommu_nesting) {
>           flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
>   
>           if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,



Applied to vfio-next.

Thanks,

C.



