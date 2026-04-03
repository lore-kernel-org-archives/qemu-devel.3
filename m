Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DCBE7E35C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8av4-00007R-GC; Fri, 03 Apr 2026 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8auz-0008W6-OY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w8aux-00011W-W5
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775208859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8RekIHAlxFoOKsjmOsCYqeU4umAM2txRXdn+eAAPc7s=;
 b=D1CIiydB/OfX5jLPwhXK2e5hxGIVsUsA98K54f7usJtpGUcyCa0J8xsy7y2S6xL/rgLtbK
 BP6/I5P45fwsaBL4ZX6eet/GPmMfLQiTuGq0IQCcVCIkA+TTlGuLmdieoPYJSoMAJ5wnEo
 ZfmeHEoO6PaCTH6CZPoVL7uvx6zU0Uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-U9VwmA_MMS-6XawyhpPw_A-1; Fri, 03 Apr 2026 05:34:17 -0400
X-MC-Unique: U9VwmA_MMS-6XawyhpPw_A-1
X-Mimecast-MFC-AGG-ID: U9VwmA_MMS-6XawyhpPw_A_1775208856
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-486fcc05b20so10971275e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775208856; x=1775813656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8RekIHAlxFoOKsjmOsCYqeU4umAM2txRXdn+eAAPc7s=;
 b=frFALjP5H8LHTn8Oh/VrwFA/VR0jEBuqunjX1Q7cspMQh2XwSZEmDubYw9r57mPf+X
 7Nr12aHvkY3HBbQmwqrxV0e/Pj8nhngUlbrPe4sviK7C3a/ufAgLAV5qDXixNhqZetb+
 8vMD9EoyC9YZWVRq750YnWn3bz72HHL4mPM4c7kNrotT2Czp+DlAxBoMY/cox56gzugf
 h8/teiYsBqB/rCZ3VI2/j2Gg5DLEycFIASUqCXVM+ItZyLqGASx/k6Yh77CMlIB+WsQn
 /jo3QzTc93bB/F4s1j/xZxUOkcZnYkv0BjwhElhjMPUlq2pdQSuzIdgK2KyTmg+qtUp9
 1i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775208856; x=1775813656;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RekIHAlxFoOKsjmOsCYqeU4umAM2txRXdn+eAAPc7s=;
 b=eAtrlMFMWGXoqfauYvdmA0sYJ6cV2B5C6d0WgMw5gptHuRtKyCrpzQUTf9ZtwI9w5H
 OOid5560/C3X2wSYK8XKdfKCLlbk8eVrZwHnYYFHHegetWujILYZ5rD23l5JD2nQjyuo
 oHQZZQowHpDfYuMxI28vnwk1PNbSdGn20yIoI+o5NMz9ExRS5n4huz1cMyuCCQdLpbgO
 lWC9NB+aM18BgGiPuN67ShriTgKmz0YTo2+op0L6TDpbDE+OM5qRpz4xTL/9KaKA4j4A
 DB66wDs8kSA7J6/fokmpuwgEk4LLdsnA1ejuDphFSmuTwkxRueglhv1s+D5UvkxIFNWE
 OCTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3dlGF+ND6Xd9PFL+W0rk1GbI9j1wmKK8DOASqHtM74u+9u3sMOyCEXF95ItaI6shXsaG8nQODuo4z@nongnu.org
X-Gm-Message-State: AOJu0YyzHnH0BT/GXKAZyuuZ9KAW8uxIhAZC7t2txZ6+viStzdA2aBYg
 eco5p0nRDRB2EPGLV6joJNlbdGw4Dj/dOCCRSerAJF5yYW5pJFZmfdWHw1TIjPeS/x1zvW/WExd
 iUqVFKRjxjo9slNKXS7BrO3FMeuIfR95llxSKNUXGzo/dDyDNsjR9MAyBYzaRmmLS
X-Gm-Gg: ATEYQzx7P+J3EPAUCl8op+Frdvryrp3I8jn6MGWtSnlqMkM8YOYg1K2kgsn7cS+9hAr
 A/mslxoZWMEhxwFudez8NxXg/a4/4v8fNB6nYEwWtsv/RjDfxDvIyxNmyrSiCu3jrpGd43NxLAT
 oE5eO84gs4e+gvD6J0M43rmvd27L/oom8B20ldZpeW3ipi253O2lPzj4SYEx/8PTOZU/0JfCyOe
 WrjCDaeElsmurNSy730itvyD0uHefzCTb6hFGHQcobEPTU1L3yTmnfs0/dBXqYBdNMEKzil6S74
 SXEbeMWGb2E8UTqONTL+GU4u5i3msBkBPRXd+shJMXUBVAEgTqOah+vXQ3+K4tgDy7kq6PrOxNN
 Lm30wbhYZI+BCCGKcMVVucap9V45x0D7hohqh8tADXIfNVxA3OWP6cSYJ6n6G
X-Received: by 2002:a05:600c:3b1e:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488996cd897mr32954645e9.4.1775208856107; 
 Fri, 03 Apr 2026 02:34:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1e:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488996cd897mr32954295e9.4.1775208855621; 
 Fri, 03 Apr 2026 02:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48895e19c10sm62649475e9.8.2026.04.03.02.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 02:34:15 -0700 (PDT)
Message-ID: <afb5fddf-8b03-4ad8-a11d-5a6f0ac2ea8c@redhat.com>
Date: Fri, 3 Apr 2026 11:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260403035541.18355-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/3/26 05:55, Zhenzhong Duan wrote:
> For attachment with pasid, pasid together with flag VFIO_DEVICE_ATTACH_PASID
> should be passed in.
> 
> Define IOMMU_NO_PASID to represent device attachment without pasid same as
> in kernel.
> 
> The implementation is similar for detachment.
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/core/iommu.h |  2 ++
>   hw/vfio/iommufd.c       | 44 +++++++++++++++++++++++++----------------
>   hw/vfio/trace-events    |  4 ++--
>   3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 86af315c15..bfcd511013 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -28,4 +28,6 @@ enum host_iommu_quirks {
>       HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
>   };
>   
> +#define IOMMU_NO_PASID 0
> +
>   #endif /* HW_IOMMU_H */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 399b36aa75..f020b56208 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -20,6 +20,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "system/iommufd.h"
> +#include "hw/core/iommu.h"
>   #include "hw/core/qdev.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "system/reset.h"
> @@ -305,43 +306,48 @@ out:
>       return ret;
>   }
>   
> -static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> -                                         Error **errp)
> +static int iommufd_cdev_pasid_attach_ioas_hwpt(VFIODevice *vbasedev,
> +                                               uint32_t pasid, uint32_t id,
> +                                               Error **errp)
>   {
>       int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_attach_iommufd_pt attach_data = {
>           .argsz = sizeof(attach_data),
> -        .flags = 0,
> +        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_ATTACH_PASID,
> +        .pasid = pasid,
>           .pt_id = id,
>       };
>   
>       /* Attach device to an IOAS or hwpt within iommufd */
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
>           error_setg_errno(errp, errno,
> -                         "[iommufd=%d] error attach %s (%d) to id=%d",
> -                         iommufd, vbasedev->name, vbasedev->fd, id);
> +                         "[iommufd=%d] error attach %s (%d) pasid %d to id=%d",
> +                         iommufd, vbasedev->name, vbasedev->fd, pasid, id);
>           return -errno;
>       }
>   
> -    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> -                                        vbasedev->fd, id);
> +    trace_iommufd_cdev_pasid_attach_ioas_hwpt(iommufd, vbasedev->name,
> +                                              vbasedev->fd, pasid, id);
>       return 0;
>   }
>   
> -static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> +static bool iommufd_cdev_pasid_detach_ioas_hwpt(VFIODevice *vbasedev,
> +                                                uint32_t pasid, Error **errp)
>   {
>       int iommufd = vbasedev->iommufd->fd;
>       struct vfio_device_detach_iommufd_pt detach_data = {
>           .argsz = sizeof(detach_data),
> -        .flags = 0,
> +        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_DETACH_PASID,
> +        .pasid = pasid,
>       };
>   
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
> -        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
> +        error_setg_errno(errp, errno, "detach %s pasid %d failed",
> +                         vbasedev->name, pasid);
>           return false;
>       }
>   
> -    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> +    trace_iommufd_cdev_pasid_detach_ioas_hwpt(iommufd, vbasedev->name, pasid);
>       return true;
>   }
>   
> @@ -362,7 +368,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       /* Try to find a domain */
>       QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>           if (!cpr_is_incoming()) {
> -            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> +            ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                      hwpt->hwpt_id, errp);
>           } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
>               ret = 0;
>           } else {
> @@ -435,7 +442,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           return false;
>       }
>   
> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +    ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, hwpt_id,
> +                                              errp);
>       if (ret) {
>           iommufd_backend_free_id(container->be, hwpt_id);
>           return false;
> @@ -488,7 +496,8 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>   
>       /* If CPR, we are already attached to ioas_id. */
>       return cpr_is_incoming() ||
> -           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
> +           !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                container->ioas_id, errp);
>   }
>   
>   static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
> @@ -496,7 +505,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>   
> -    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
> +    if (!iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, &err)) {
>           error_report_err(err);
>       }
>   
> @@ -922,7 +931,8 @@ host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
> -    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> +                                                hwpt_id, errp);
>   }
>   
>   static bool
> @@ -931,7 +941,7 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
>   
> -    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
> +    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
>   }
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 846e3625c5..764a3e4855 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -182,8 +182,8 @@ vfio_vmstate_change_prepare(const char *name, int running, const char *reason, c
>   
>   iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
>   iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
> -iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
> -iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
> +iommufd_cdev_pasid_attach_ioas_hwpt(int iommufd, const char *name, int devfd, uint32_t pasid, int id) " [iommufd=%d] Successfully attached device %s (%d) pasid %d to id=%d"
> +iommufd_cdev_pasid_detach_ioas_hwpt(int iommufd, const char *name, uint32_t pasid) " [iommufd=%d] Successfully detached %s pasid %d"
>   iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
>   iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
>   iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"


