Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE108C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ce1-0002BJ-Tk; Fri, 11 Apr 2025 07:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u3Cdk-0001vL-1I
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u3Cdh-0007Sv-RO
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cw8+7uFjqv/U/6RPHtWvyu/EnTGr5bercZF2FcC4Two=;
 b=PKaLXxaIEKMf689oMMWNJGZ2iwRCT8eP6+0KikV6FleKU05Bp/LbqA7gFOAUNcOW0P5Djy
 k3W52qypkLqdhC4R2H55Pcz6/o1gfmej8r66AsdAk9O8x50YgAqvFQAMfvaInVq13AeWv0
 7DnKCxWz+W831kqdPy5B0ZbH+pnWXM0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Stw1N7NtMRGqOlObE9Pr4g-1; Fri, 11 Apr 2025 07:33:38 -0400
X-MC-Unique: Stw1N7NtMRGqOlObE9Pr4g-1
X-Mimecast-MFC-AGG-ID: Stw1N7NtMRGqOlObE9Pr4g_1744371217
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso11593835e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744371217; x=1744976017;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw8+7uFjqv/U/6RPHtWvyu/EnTGr5bercZF2FcC4Two=;
 b=rtRquz3nKSU7Lq6SC6xqxovNvSiSC88f/irpU9mHu6dxHRXrBiqrwpRjt+/45+nCkS
 OE1OoMjWTuXbdgw3Nnm0PbNkLUN6E7ehOx3kirHFp7pv4x3N0gxRhwpfGs4a3tafm1xc
 neks7DxVK+anVah+Vq/GWzXbs5iwb6vGgxW0Vau+GdnCrNHktVeFdhwMWlnUEFMHCUuQ
 5ITtHauTRTxCmgeoP+GLRslO/ccM7q6TvZ+WWKUGRpft6AXeEFqvso4SyhDV/NGv6tQ4
 iqWMv9C6AU8rdd87ixI6Xrj9Xam/DgeoajtwkOot8A2p5qolLZR8HF/ZiUeYQmRK/n5b
 8Nig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8YPEAzw+6L0BJvEe+0+5l2ruPaG+KRi0zvSx92sChli93ozuUG1pgL3EIv4kYvoGU4b6eDrw3apzf@nongnu.org
X-Gm-Message-State: AOJu0Yz7P+4MoTz4IA03GtIcBIqXJCMLPdoF56irWpD6LP+Is2zO1jGc
 m1UrHfNWB9GTMoscJ22Qv5qp6vTjLYcleycTbEPJw+SRC1zzaIVcz8Fay/qiMpLtpm9J5RcYceq
 KK1WbZvvSbHUGrZc8ed0OgshJZ9752HLwU+xjhzj+01iKQPWNzqDz
X-Gm-Gg: ASbGncsFwdgGo+ODp2+A7Pyrv385wB/xtGEycI6RgPPRgbFvyhQ9qP+pfbzCPo8IYJy
 lk4bq+96HWvooaWUZ0oHijx8LSBbI8I29uwfpE2kePljCHMxJuPgjJsaQ4HA4djNzD3vrIcc5e1
 BeEeVgRcb2USWAP8cXM0MJ3ydqPOyYIuL0NvoqVSamFU1xdryqOt8TchreTHxdIqA0ulqpXZ6C+
 R0CWB2luuYpFD+LzyoxD3Ifqb6sitrvmIs+j2YDkVN7dbaPYljjlYA2wwRguPivwgXl7Z5NAoJP
 NP7KT8HHAArmW/iggWMG1VlByd8mpyiyIXIxLdGW/6Q3pEhZpQ==
X-Received: by 2002:a05:600c:83c6:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43f3a7d872dmr23264235e9.0.1744371217360; 
 Fri, 11 Apr 2025 04:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlNa+cGsiERNvJwtBfre4SNusMdqUtOVpbg9Mk3paYsLc3070ddmzCyNRYGXf4MY4a/JH8HA==
X-Received: by 2002:a05:600c:83c6:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43f3a7d872dmr23263835e9.0.1744371216903; 
 Fri, 11 Apr 2025 04:33:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ccd8sm1763867f8f.72.2025.04.11.04.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 04:33:36 -0700 (PDT)
Message-ID: <53bd9468-aa91-48b7-b186-9909d65973b3@redhat.com>
Date: Fri, 11 Apr 2025 13:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio: Move realize() after attach_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Donald Dutile <ddutile@redhat.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250411101707.3460429-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/11/25 12:17, Zhenzhong Duan wrote:
> Previously device attaching depends on realize() getting host iommu
> capabilities to check dirty tracking support.
> 
> Now we save a caps copy in VFIODevice and check that copy for dirty
> tracking support, there is no dependency any more, move realize()
> call after attach_device() call in vfio_device_attach().
> 
> Drop vfio_device_hiod_realize() which looks redundant now.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Donald Dutile <ddutile@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 -
>   hw/vfio/container.c           |  4 ----
>   hw/vfio/device.c              | 28 +++++++++++-----------------
>   hw/vfio/iommufd.c             |  4 ----
>   4 files changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 09a7af891a..14559733c6 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -124,7 +124,6 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>   
>   void vfio_device_reset_handler(void *opaque);
>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_device_detach(VFIODevice *vbasedev);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 23a3373470..676e88cef4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -883,10 +883,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>   
>       trace_vfio_device_attach(vbasedev->name, groupid);
>   
> -    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> -        return false;
> -    }
> -
>       group = vfio_group_get(groupid, as, errp);
>       if (!group) {
>           return false;
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 4de6948cf4..6154d3f443 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -347,17 +347,6 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>   }
>   
> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
> -{
> -    HostIOMMUDevice *hiod = vbasedev->hiod;
> -
> -    if (!hiod) {
> -        return true;
> -    }
> -
> -    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
> -}
> -
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> @@ -372,6 +361,7 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>   {
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> +    HostIOMMUDeviceClass *hiodc;
>       HostIOMMUDevice *hiod = NULL;
>   
>       if (vbasedev->iommufd) {
> @@ -380,16 +370,20 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>   
>       assert(ops);
>   
> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
> +        return false;
> +    }
>   
>       if (!vbasedev->mdev) {
>           hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> -        vbasedev->hiod = hiod;
> -    }
> +        hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>   
> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
> -        object_unref(hiod);
> -        vbasedev->hiod = NULL;
> -        return false;
> +        if (!hiodc->realize(hiod, vbasedev, errp)) {
> +            object_unref(hiod);
> +            ops->detach_device(vbasedev);
> +            return false;
> +        }
> +        vbasedev->hiod = hiod;

This is not what I meant. I was not clear enough. Sorry about that.

hiodc->realize can be called under each container backend: legacy
and iommufd. I don't see much much value to make it common and
it would remove the unref/detach sequence to handle errors.

Thanks,

C.



>       }
>   
>       return true;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 530cde6740..e05b472e35 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -502,10 +502,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>        * FD to be connected and having a devid to be able to successfully call
>        * iommufd_backend_get_device_info().
>        */
> -    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> -        goto err_alloc_ioas;
> -    }
> -
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>                                            &caps->type, &caps->vendor_caps,
>                                            sizeof(VendorCaps), &caps->hw_caps,


