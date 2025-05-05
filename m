Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFDEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBypr-00005s-Mv; Mon, 05 May 2025 12:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBypm-0008VJ-Ls
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBypk-0000NN-P2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746463102;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEcUkHKJeiFH9GX+maI3cOTbKcu1SZ8Pxgp4P9Wrzcc=;
 b=Gd2r8e/7e1zP2r1FCUi2UHD4ZmkbS+JemFYz4xeqcMlwwtHo6lga+nIEHCDrqVdohI6NQq
 ChwbxGHsGvyyOUU0QZsIjHmNkMZjWU4m3igcugdSeHCmkIwieFXdlRSuBazMLIbcA4sI0n
 bYGiXweLzvQTygMnG75dmBOZjgGF3i0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-pm4_aYJ7MC-5OA9Ji-F8XA-1; Mon, 05 May 2025 12:38:20 -0400
X-MC-Unique: pm4_aYJ7MC-5OA9Ji-F8XA-1
X-Mimecast-MFC-AGG-ID: pm4_aYJ7MC-5OA9Ji-F8XA_1746463100
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39d917b1455so1238028f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463099; x=1747067899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEcUkHKJeiFH9GX+maI3cOTbKcu1SZ8Pxgp4P9Wrzcc=;
 b=dgeBSVAOltNBSOpPQWua+w7DBugFQWcHA/Sxmn389+WD6eaKbTr4jnb+MY4J8j65H3
 Oi8MwcnRfPZOzzbKEBueZcN2BV5PwfHwA/Pr40RgSTBw2ZY5Cwn40S+IuoDtwMvI3U6s
 2wnS8dGzzzUIgzxi1zwy4C9q1wLu7sfbgn4zrpJmIesE27qTagbDVuhAsp8WPoYsV/dk
 1s9UdpLGqBIUBFJhhqJZj4WDykR5iY5LgHtjJtxdKKQtvTTB9ewkXfpY0HjzC57K54cm
 CmH0UIazhdUv7DpfE7VaBl0mgnjwDJ9tAgf1227tk2Nie873r6fxkZHomQ/PEQT76vH6
 5MjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP7B4NYLCjMaeigbP41HYFHHPtaA+6e9G5nkcomsFUOajOq5gcxKn3oRKdMqZGb5vT/wb+5mx17joK@nongnu.org
X-Gm-Message-State: AOJu0YxhttCw4GHLP9AkcXOruRU/soij2oes6/O2OgXXf0995bDV7G3w
 VF6SVa84bLN0O/UFHGS8XkM14jWURlmXPnACk2ZWY6DOMj8KE+VFDR+v1Azw6sn9OHHczEAt8Hd
 v3+itK3sjtv/SFak4FWnaWVL32oOOQ/yW6zY+q+AIs+6mS+UiTtt3
X-Gm-Gg: ASbGncs9PWizilO/OobRWv49lxTCyRZ7mD9/NbVju/ZXirBBaFwERvQ5XMVnjt1F9qC
 1BsnBuN8r9ky5Z3r642aWKP1em0KelsnZBuf12C3s3SPbNYJO/UPLovzWyWSodau/wsBBGjTxUH
 jkfglFO1lyt8GZ6EqsbviFrqtKl6PkoO+1WIqg5GmzioaK3J2OpVItidNwdO58Sd5NxzlusGQv4
 dxjYTYVSymyKI0VGMJ1I3LwPxDCxuYB1m2EvWZTHihCRYG22VQSlRZPyuje/KINhgSdL+e8K0rS
 4VM837x/sJBR5E/hN7kcJnm0bDXk+MQC+6cZa84Y56P7DTeaXrp+rNErUH8=
X-Received: by 2002:a05:6000:2501:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-3a09fd88991mr5787957f8f.32.1746463099567; 
 Mon, 05 May 2025 09:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYK05Lo1kLg3U4hZdSc4s9zsv2L05FeohQGWzie3G7Pq7CJb6Pa+fVdXmOv3NzaJbPsMny9A==
X-Received: by 2002:a05:6000:2501:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-3a09fd88991mr5787944f8f.32.1746463099225; 
 Mon, 05 May 2025 09:38:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad76a2sm184856195e9.6.2025.05.05.09.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:38:18 -0700 (PDT)
Message-ID: <82239156-8ec5-4dde-8333-3569146d3195@redhat.com>
Date: Mon, 5 May 2025 18:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com, Yi Liu <yi.l.liu@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250411101707.3460429-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/11/25 12:17 PM, Zhenzhong Duan wrote:
> The saved caps copy can be used to check dirty tracking capability.
>
> The capabilities is gotten through IOMMUFD interface, so define a
> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
> caps raw data in "include/system/iommufd.h".
>
> This is a prepare work for moving .realize() after .attach_device().
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-device.h |  1 +
>  include/system/iommufd.h      | 22 ++++++++++++++++++++++
>  hw/vfio/iommufd.c             | 10 +++++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 66797b4c92..09a7af891a 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>      bool dirty_tracking; /* Protected by BQL */
>      bool iommu_dirty_tracking;
>      HostIOMMUDevice *hiod;
> +    HostIOMMUDeviceIOMMUFDCaps caps;
>      int devid;
>      IOMMUFDBackend *iommufd;
>      VFIOIOASHwpt *hwpt;
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..0f337585c9 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -18,6 +18,9 @@
>  #include "exec/hwaddr.h"
>  #include "exec/cpu-common.h"
>  #include "system/host_iommu_device.h"
> +#ifdef CONFIG_LINUX
> +#include <linux/iommufd.h>
> +#endif
>  
>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>  OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -63,4 +66,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
> +typedef union VendorCaps {
> +    struct iommu_hw_info_vtd vtd;
> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
> +} VendorCaps;
> +
> +/**
> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device capabilities.
> + *
> + * @type: host platform IOMMU type.
> + *
> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
> + *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + */
> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
> +    uint32_t type;
> +    uint64_t hw_caps;
> +    VendorCaps vendor_caps;
can't we store the raw data in the caps and let the vIOMMU code
interpret it via a PCIIOMMUOps callback?

If my understanding is correct this is also Nicolin's initial
suggestion, no?

Eric
> +} HostIOMMUDeviceIOMMUFDCaps;
>  #endif
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48db105422..530cde6740 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -324,7 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * vfio_migration_realize() may decide to use VF dirty tracking
>       * instead.
>       */
> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      int ret, devfd;
>      uint32_t ioas_id;
>      Error *err = NULL;
> +    HostIOMMUDeviceIOMMUFDCaps *caps = &vbasedev->caps;
>      const VFIOIOMMUClass *iommufd_vioc =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>  
> @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          goto err_alloc_ioas;
>      }
>  
> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> +                                         &caps->type, &caps->vendor_caps,
> +                                         sizeof(VendorCaps), &caps->hw_caps,
> +                                         errp)) {
> +        goto err_alloc_ioas;
> +    }
> +
>      /* try to attach to an existing container in this space */
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);


