Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C4FD41D58
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiX6-0005OG-LJ; Thu, 11 Dec 2025 10:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTiX4-0005NE-G1
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTiX2-0005Bp-Ro
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765466680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EJK41ynsPUuJv69DTopYLPaRucjPYfwFDkl1me2BzjA=;
 b=FAO65VtrmiZFLQMxkNSHqxcskrmScD/oCl3BKK7lMpk5lHu3Ovhec7EKu5vM0RYoY4g009
 lXRk98i4azIVIfLwmCv5cRfmjD5xqRxIXc/rCBICljDx1WfZPo1R6rPrdUCV8z+Xp479ys
 CiGjpcvMsSRcCT58z9X5MfiWzwDdKws=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-52OWLDfjMQqMv3L7jXsmPg-1; Thu, 11 Dec 2025 10:24:38 -0500
X-MC-Unique: 52OWLDfjMQqMv3L7jXsmPg-1
X-Mimecast-MFC-AGG-ID: 52OWLDfjMQqMv3L7jXsmPg_1765466677
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42f9e62b4feso148977f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765466677; x=1766071477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EJK41ynsPUuJv69DTopYLPaRucjPYfwFDkl1me2BzjA=;
 b=Yb0onjjckcJ0jqF5AQ/GMkXrhra9SE+DzKBZGVubj/0P3g/ur5cyCY3heuSgwKuBPW
 XPwP2ErPbnlF88v/oACk2DsaPfGG95zasCLHngGHu/U2d4LZlxvkPuj7Wr973GBl+SvU
 CfxeQdWeBrBnWS+pa2/4OuPj/knc0ZyyC3bSa8YtwmWh5AXIuH+4FQwc8iiGM4++mVfB
 Dr8nnS5Hb0tuQKOYV9J24vEx6arEb4qsIMEt3Z+J8ARcnFoBOMo+qcBWKlP/Srh9txUh
 9W4/sv1Xrenwiz+ElUdlBMzdMhtVCbJ4Ey6tOMWrnDpZEyNRxEPL8hXevFXTs8fDcjRU
 ryug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466677; x=1766071477;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJK41ynsPUuJv69DTopYLPaRucjPYfwFDkl1me2BzjA=;
 b=B7+A3MNA1NFj9Tw+3hsNHSTKZKrXOg+bCzzW9EoS5BFMyPTO0MFdb8u1+l7m2HBlkA
 q7UmRwPDMKmPSANjzjTzYW3mppkKg1ri5NJOVHBLECobiNvjLWymFsXB0vZW0ia2bZN6
 ycIippdH6p/aaNVWg3FBNCuqEPunUII0TMRHSR9E2kpkXZM02PLH2SudE/6Ek0n+78O3
 tl56kHvZ25knuxJiA+zYjRsdvoSBr5OZF3HPnoiGJLe2LqEMGfD8E495QkJ6w6bIWhdg
 A6NOCGV7moXku7bCj3T+ZcRYLUiIYAE+i0XoCrgAsyuMTvgYpjji6DAhSmbHdTvejw+u
 O/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+CKcaO0FeMqIPEJcyd7fKYk/Xs63XehAUWlwSFu99ssIOpOFrHK8yL83f7/DEiNGc21qB58oc8qD@nongnu.org
X-Gm-Message-State: AOJu0Yz3LRc43qRe2GDpZLBc5JKcyL9ps4CxTHFz5qKu6cg/NJf8HGIs
 nOXDcwYdJwICZNTUkRE+dErh54EqzKscq8cURZF/Yhqhg4r+O7UCEnicOPI6V5HXnq3kcDQld54
 Nwb7KYRsNfuVX5+nI+9tWFRLh+qaQf+0KJzJlk8tMn7t/38mogiPsP2Jo
X-Gm-Gg: AY/fxX6Dygi4mHgdTL4ALWW7Nfskwbqs3yH6ZMqsAr8pLFqwWd/YFNVqcZENxBNEcF0
 9rw82UDbmbSiHY8TD14xBgAxwraomfYYFDiya78FqEIJlcb9cuqViGfKuyki2I+b6sD1p4Ymq3g
 JpXahd7eIlkaK6plPLSBQzrgUU3yQGgnWObGywhix8dkgAZMzJWrF9/sleG/xYM43eHedd1mleu
 JUNEsVIjzG+UdtxoHOsq+qADtr8hNJHU3yBgqNDV+ZrulfhrLT9GbhPtpF1YzyM6BMqrN9rvv6l
 /zOhklimoblZS14xxLFHMesXumyNuyq+dhRlb3KSWE0byD06w7SnDYvBmyY63DN9NLsfoHkWtpO
 TMuM6DLJnbittj15+K8K8JeWNGHrVhX01U3PaGVBDFdLCMzM8
X-Received: by 2002:a5d:5f45:0:b0:42c:a420:e755 with SMTP id
 ffacd0b85a97d-42fab31cb50mr2844533f8f.23.1765466677324; 
 Thu, 11 Dec 2025 07:24:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlyrHBj0iFoY/GJJIhEn6Tem75am4I1jatEtjJXn/l61+WBn0n6QfH8hHxkfWRoJQOiZuBQg==
X-Received: by 2002:a5d:5f45:0:b0:42c:a420:e755 with SMTP id
 ffacd0b85a97d-42fab31cb50mr2844498f8f.23.1765466676816; 
 Thu, 11 Dec 2025 07:24:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b6bfsm6113841f8f.43.2025.12.11.07.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:24:36 -0800 (PST)
Message-ID: <4fd538c5-842c-4c96-83ed-dae4da8f8783@redhat.com>
Date: Thu, 11 Dec 2025 16:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/33] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-31-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-31-skolothumtho@nvidia.com>
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

On 11/20/25 14:22, Shameer Kolothum wrote:
> Retrieve PASID width from iommufd_backend_get_device_info() and store it
> in HostIOMMUDeviceCaps for later use.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   backends/iommufd.c                 | 6 +++++-
>   hw/arm/smmuv3-accel.c              | 3 ++-
>   hw/vfio/iommufd.c                  | 7 +++++--
>   include/system/host_iommu_device.h | 3 +++
>   include/system/iommufd.h           | 3 ++-
>   5 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index e68a2c934f..6381f9664b 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -388,7 +388,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>   
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     uint64_t *caps, Error **errp)
> +                                     uint64_t *caps, uint8_t *max_pasid_log2,
> +                                     Error **errp)
>   {
>       struct iommu_hw_info info = {
>           .size = sizeof(info),
> @@ -407,6 +408,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       g_assert(caps);
>       *caps = info.out_capabilities;
>   
> +    if (max_pasid_log2) {
> +        *max_pasid_log2 = info.out_max_pasid_log2;
> +    }
>       return true;
>   }
>   
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 35a94c720a..254d29ee2d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -113,7 +113,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>       uint64_t caps;
>   
>       if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> -                                         &info, sizeof(info), &caps, errp)) {
> +                                         &info, sizeof(info), &caps, NULL,
> +                                         errp)) {
>           return false;
>       }
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ca8a6b7029..bbe944d7cc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -353,7 +353,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        * instead.
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, NULL, 0, &hw_caps, NULL,
> +                                         errp)) {
>           return false;
>       }
>   
> @@ -889,19 +890,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
>       VendorCaps *vendor_caps = &caps->vendor_caps;
>       enum iommu_hw_info_type type;
> +    uint8_t max_pasid_log2;
>       uint64_t hw_caps;
>   
>       hiod->agent = opaque;
>   
>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
>                                            vendor_caps, sizeof(*vendor_caps),
> -                                         &hw_caps, errp)) {
> +                                         &hw_caps, &max_pasid_log2, errp)) {
>           return false;
>       }
>   
>       hiod->name = g_strdup(vdev->name);
>       caps->type = type;
>       caps->hw_caps = hw_caps;
> +    caps->max_pasid_log2 = max_pasid_log2;
>   
>       idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
>       idev->iommufd = vdev->iommufd;
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82..bfb2b60478 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -30,6 +30,8 @@ typedef union VendorCaps {
>    * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>    *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
>    *
> + * @max_pasid_log2: width of PASIDs supported by host IOMMU device
> + *
>    * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
>    *               IOMMUFD this represents a user-space buffer filled by kernel
>    *               with host IOMMU @type specific hardware information data)
> @@ -37,6 +39,7 @@ typedef union VendorCaps {
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
>       uint64_t hw_caps;
> +    uint8_t max_pasid_log2;
>       VendorCaps vendor_caps;
>   } HostIOMMUDeviceCaps;
>   #endif
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 41e216c677..aa78bf1e1d 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, uint64_t size);
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     uint64_t *caps, Error **errp);
> +                                     uint64_t *caps, uint8_t *max_pasid_log2,
> +                                     Error **errp);
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,


