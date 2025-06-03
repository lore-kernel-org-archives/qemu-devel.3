Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FF6C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQwK-0002uo-Sr; Tue, 03 Jun 2025 08:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQwF-0002tT-7c
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQwC-0000nl-77
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748954411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5k2v5Y0UwmhUgDPLYigt/iJWB7+Js6vTusTc9w0nFHY=;
 b=N2PFJw7AI+62gIlQngEdBxABxWmC5ud10VOMUT+eFfJMQwGORawBO/8NiwwidOM7cXu+nA
 GB+pHAo/1aWNT1wpMhWhRfW2RIXPfL+ArxLGvH9KxwiHcqGuv5FAuV15hK00nFvG7wzFK0
 lCEjCqt9h0kmefIUTfTCvJmFbVG1Gps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mC3uupo7PB-8sy3ZzkzNUQ-1; Tue, 03 Jun 2025 08:40:10 -0400
X-MC-Unique: mC3uupo7PB-8sy3ZzkzNUQ-1
X-Mimecast-MFC-AGG-ID: mC3uupo7PB-8sy3ZzkzNUQ_1748954410
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso2754300f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748954409; x=1749559209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5k2v5Y0UwmhUgDPLYigt/iJWB7+Js6vTusTc9w0nFHY=;
 b=vt1wTCKH1niqmmwRcmlEUa1DKzCi6wqATRLT2AhonKjqz1R4EbGFfDvxmKHkRpmWHz
 rMQZPABTgc0XpmAQlJlWhy3XVPJ1ufdPgb5Xo3JuIEbmLlLCAFaNG4I5EXWD6v0Z118B
 6HDUWKl1w9x18nxfmgN0ezj8f7KMInxyeceWvV0p7QBqWLb87T4JdJRtKZf8iBm2nvIG
 rLCZEKT4Y9/Yg94VPs90Sj9Op84KCX5baVZWsS62QVftod62v8DsSqmNR5E5LURnb6kK
 a4zpIYwTczXNp13f4pQ9TePwLqRane//qd82yRxmpNQjaFNMBsU4i86zGqz0C/ooS7Vf
 4bdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5U9CSDN8QFjzWW7IDfMbsOC8D2h3jUPNBejY13yo7mpyErJkeq9lRAEdbyXo84GVr+AFmi1MEH/Qe@nongnu.org
X-Gm-Message-State: AOJu0YwteGckRZPitEnQmMf+KCCO/8USqXe11b75QaFC0JoW7sBn9IZJ
 J6MZjWdgKus6XyM92J8KEuz2EDnv37IIEJIvPbswnhr/mSOv4/ibSkdRCyzLi5fgq70TpLjaa4e
 EVyaawRAAC0K6W0VtB0Ur7rOWtaYxgCjyeBvewic8HIV9hUz0EWF7SjYs
X-Gm-Gg: ASbGncs69dQEaQbPJEMvLYNBLbhbgF4VPS6AfFOyDU+K2HaOGR6+AlcheCQFsD1a21j
 iBpffDY7/+gO80O5dLd3tR6R52apjp2nxDkNVUvovmkX+n57BrxsoGkvC9OVCOdPWRSLh3eGHye
 RZ9R+GaqXegYag1LGKQVbJn5JqUyuqEdD2585mmudSqCV4zmcLuPiJSaiSnkp4jAkG1f+vvq6HI
 Azz10WIdGYKyfT1X5YcvQPSOrQuvn26bE47aP3+484pEM3PFUyMfzZ/1VFohe25fQyusQX7HVut
 PaDru6TVpqF2nLPAS/gWRO1ho86RRN1AWsNGBQi2T3bQWzbWb8cUtcuNEjQ=
X-Received: by 2002:a05:6000:2004:b0:3a3:5ae4:6e81 with SMTP id
 ffacd0b85a97d-3a4fe160ccemr9715779f8f.8.1748954409483; 
 Tue, 03 Jun 2025 05:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GbtUuUIIEESZdz0gS6tHs1aNV9xFqjNwftSsC9HccnRLnBWNEaVsbz+SIYhIzjQ9QQqOTQ==
X-Received: by 2002:a05:6000:2004:b0:3a3:5ae4:6e81 with SMTP id
 ffacd0b85a97d-3a4fe160ccemr9715744f8f.8.1748954409064; 
 Tue, 03 Jun 2025 05:40:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b8a8sm17914526f8f.5.2025.06.03.05.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 05:40:07 -0700 (PDT)
Message-ID: <5fa661fe-5400-4d13-8ba8-ce15f806b017@redhat.com>
Date: Tue, 3 Jun 2025 14:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530093512.3959484-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 5/30/25 11:35 AM, Zhenzhong Duan wrote:
> Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
> specific. Save them as raw data in a union supporting different vendors,
> then vendor IOMMU can query the raw data with its fixed format for
> capability directly.
>
> Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
> capability related structures with CONFIG_LINUX.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/host_iommu_device.h | 11 +++++++++++
>  hw/vfio/iommufd.c                  |  8 +++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index 809cced4ba..10fccc10be 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -14,6 +14,13 @@
>  
>  #include "qom/object.h"
>  #include "qapi/error.h"
> +#ifdef CONFIG_LINUX
> +#include "linux/iommufd.h"
> +
> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;
>  
>  /**
>   * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
> @@ -26,7 +33,9 @@
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
>      uint64_t hw_caps;
> +    VendorCaps vendor_caps;
missing the doc comment update for new field vendor_caps

Otherwise

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


>  } HostIOMMUDeviceCaps;
> +#endif
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>  OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> @@ -38,7 +47,9 @@ struct HostIOMMUDevice {
>      void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
>      PCIBus *aliased_bus;
>      int aliased_devfn;
> +#ifdef CONFIG_LINUX
>      HostIOMMUDeviceCaps caps;
> +#endif
>  };
>  
>  /**
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index d661737c17..fbf47cab09 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -834,16 +834,14 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      VFIODevice *vdev = opaque;
>      HostIOMMUDeviceIOMMUFD *idev;
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    VendorCaps *vendor_caps = &caps->vendor_caps;
>      enum iommu_hw_info_type type;
> -    union {
> -        struct iommu_hw_info_vtd vtd;
> -    } data;
>      uint64_t hw_caps;
>  
>      hiod->agent = opaque;
>  
> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> -                                         &type, &data, sizeof(data),
> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
> +                                         vendor_caps, sizeof(*vendor_caps),
>                                           &hw_caps, errp)) {
>          return false;
>      }


