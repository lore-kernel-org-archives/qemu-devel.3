Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADBCC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Gjp-0005Tr-GY; Thu, 03 Apr 2025 05:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0Gjm-0005Rb-5Y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0Gjg-00078Z-Lj
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 05:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743671981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gWY1DLK8YFsV6C0uUG0CxfohG13zX17xUgq3D9Zbz+Q=;
 b=dmHNCtVlPJzrRhRQGwlY8dgoBguROT+1kWT4Nd/Hk3pODaqkUXgpz3XRvAgO+tGRm8+MNO
 Z8PWFsmwuuKlmSoqEyBAFDubZ3YWqNwt65cWcsSmvpDELtk5w6HRINvMV9o8iIEGdaD8kp
 y5tpJ82eWnpSQnWWWhOlnpr+2ZE5R6g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-OTrGLf7DNDuYJOpUdVIyEg-1; Thu, 03 Apr 2025 05:19:38 -0400
X-MC-Unique: OTrGLf7DNDuYJOpUdVIyEg-1
X-Mimecast-MFC-AGG-ID: OTrGLf7DNDuYJOpUdVIyEg_1743671977
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so5105215e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 02:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743671977; x=1744276777;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWY1DLK8YFsV6C0uUG0CxfohG13zX17xUgq3D9Zbz+Q=;
 b=RqufK7HVSdaKEyykjT0gO45yQh4JWQ9b/NR6DRgtBIJ1eZdiC8R+VUh6i1YETiVzGp
 aKDMtKPgwWnX+MjAvSMfgp8hwaLpZqvO+3SSIlLY+plI/dMSKfkndd5K1WzOE7jjqX9n
 6F0Dgq7h17qOXIN7cNH4aYZ+Lw/3SJY8idRS+glkzLv6ucw9+YNZ4qw7eEyISHTUYVzr
 50fioZLEvJH0qSD6UnGnmESkeCI9iHS8h5U1r1WeVubKBIW2UPVV6FKwrJtetFVTpMLu
 6CeLU6riYTcY882sZsR2j+aHs4IUw7lZhpARIz+eZyf2lV/Yti1DaJt8tMj1Gfohjwb9
 FEuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBGj3aX2G/LiPczBcVhErhYSWcZ+bd0gEnTkkxHUwCAX1nPHhJo2F+OyyHXA4Zv8fwQvj1q15t75fs@nongnu.org
X-Gm-Message-State: AOJu0YyCZ+VSFdnax7sL5SFzPB7SMRwKbfxUg9vweVrnTXaAc+tuo4OS
 Fw1gk8y1wqlcr5XlwF2TyLeTKPRqA3Ue0dPLs3XICawQAha0cOhsjFbNo6Cl7/YeLSPCO7dZMly
 WauRWQVP1ma6PhKNs9pRtxJ2UImGWnJR3UyVmwZ5HhsWO9shTRDeZ
X-Gm-Gg: ASbGncvKLw/a4ktEvKrAnQVAGoaZSwP/AlHhwowwe15xXL8If0Y4Z/MHQIujJgDQSDQ
 yoD6Rq7jka4hYgPr/V5eA0xyonJimpfS9ReJ6HHs80evZapp+I/Xvkg7KOzFwGpBHrF1JNfn9EH
 hM892/IpiVUcXVdsZK5h3WWQPFYTMXi/c79d4O9LIpe/BttiXdXPfuSlpf2ivfV6KWn8yWvLX+M
 tb1tH1bH1ERquP1oeTqcw7HIA0MqC3xVFfADp+S419A4wyz3MRHuml2c7b1e2/lRpLSvRfaDDCR
 Z72nvOjUKFIQXD7d6LynmJsSvmlJeNsqQUDlcLSiFDFqq6eUL/u+Sg==
X-Received: by 2002:a05:600c:470f:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43eb5c95bf9mr50561115e9.24.1743671976884; 
 Thu, 03 Apr 2025 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9/AQmaAzHaEnSt3+Y157WxNmjV67fz+c8x3NAwoDDLHNYQucmfzWbGHQUHKhdKb6cFMq1zQ==
X-Received: by 2002:a05:600c:470f:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43eb5c95bf9mr50560825e9.24.1743671976515; 
 Thu, 03 Apr 2025 02:19:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a76cesm1261518f8f.37.2025.04.03.02.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 02:19:35 -0700 (PDT)
Message-ID: <3369ecab-21ea-4198-9ffa-73307a795f69@redhat.com>
Date: Thu, 3 Apr 2025 11:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/28] vfio: add vfio_prepare_device()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2/19/25 15:48, John Levon wrote:
> Commonize some initialization code shared by the legacy and iommufd vfio
> implementations (and later by vfio-user).
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/common.c              | 19 +++++++++++++++++++
>   hw/vfio/container.c           | 14 +-------------
>   hw/vfio/iommufd.c             |  9 +--------
>   include/hw/vfio/vfio-common.h |  2 ++
>   4 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index eefd735bc6..4434e0a0a2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1569,6 +1569,25 @@ retry:
>       return info;
>   }
>   
> +void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> +                         VFIOGroup *group, struct vfio_device_info *info)

I would prefer that the first version did not have a 'group' parameter.
Let's add it when needed.


Thanks,

C.




> +{
> +    vbasedev->group = group;
> +
> +    vbasedev->num_irqs = info->num_irqs;
> +    vbasedev->num_regions = info->num_regions;
> +    vbasedev->flags = info->flags;
> +    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
> +
> +    vbasedev->bcontainer = bcontainer;
> +    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> +    if (group) {
> +        QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
> +    }
> +
> +    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +}
> +
>   bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
>                                         VFIODevice *vbasedev, AddressSpace *as,
>                                         Error **errp)
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 82987063e5..37a3befbc5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -876,17 +876,11 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>       }
>   
>       vbasedev->fd = fd;
> -    vbasedev->group = group;
> -    QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>   
> -    vbasedev->num_irqs = info->num_irqs;
> -    vbasedev->num_regions = info->num_regions;
> -    vbasedev->flags = info->flags;
> +    vfio_prepare_device(vbasedev, &group->container->bcontainer, group, info);
>   
>       trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
>   
> -    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
> -
>       return true;
>   }
>   
> @@ -939,7 +933,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
> -    VFIOContainerBase *bcontainer;
>   
>       if (groupid < 0) {
>           return false;
> @@ -968,11 +961,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           return false;
>       }
>   
> -    bcontainer = &group->container->bcontainer;
> -    vbasedev->bcontainer = bcontainer;
> -    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> -    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> -
>       return true;
>   }
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e295f251c0..85c70eae37 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -604,14 +604,7 @@ found_container:
>           iommufd_cdev_ram_block_discard_disable(false);
>       }
>   
> -    vbasedev->group = 0;
> -    vbasedev->num_irqs = dev_info.num_irqs;
> -    vbasedev->num_regions = dev_info.num_regions;
> -    vbasedev->flags = dev_info.flags;
> -    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
> -    vbasedev->bcontainer = bcontainer;
> -    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> -    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +    vfio_prepare_device(vbasedev, bcontainer, NULL, &dev_info);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c40f8de6bc..ae3ecbd9f6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -250,6 +250,8 @@ void vfio_reset_handler(void *opaque);
>   struct vfio_device_info *vfio_get_device_info(int fd);
>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>   bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
> +void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> +                         VFIOGroup *group, struct vfio_device_info *info);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,


