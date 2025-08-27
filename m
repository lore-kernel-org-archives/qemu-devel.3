Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4095FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEeJ-00027f-Gg; Wed, 27 Aug 2025 07:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEe5-00022k-2K
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urEdv-0005tZ-34
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756295319;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+UVQ7WJeOjwQL4HUQJyBYv5r5tBcm29gvCyjnwOE4g=;
 b=RaP4dBded4Ph+IEIO5GjEJH+hOP71tLPCNj5fnFuWeanjqndtBC7N1W85g2rNXkRSv1b58
 r8K/f/k9Y6qi+mWrkXgJPybqTG2hNAK6Y/DebrnH0pkFJ/RwwkkR5uXjTM5d8csNBV3xp1
 Bikt4mHnZO4LKz3Kuq0DVDs21rWfLiY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-IShCyc-PM3SBJPQr3iLnpA-1; Wed, 27 Aug 2025 07:48:37 -0400
X-MC-Unique: IShCyc-PM3SBJPQr3iLnpA-1
X-Mimecast-MFC-AGG-ID: IShCyc-PM3SBJPQr3iLnpA_1756295317
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0511b3so40024835e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 04:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756295316; x=1756900116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+UVQ7WJeOjwQL4HUQJyBYv5r5tBcm29gvCyjnwOE4g=;
 b=oAEdzNuOdWjcOc3MRme6LeKu22am8u8rSX+rdlTbtYtzQnxUcoGn8Ewt/W4Az+bELT
 FWHfLVPmH5DGs1zbfOvHHcfMR0QU+LQV0qXdG3R4p75reY+4jtxVs1DYK5UdvzLS/BIq
 6zROsL/2ty0ANw6sFVqfTbWgKtj0ALHy2xOWeBWGyb3eCk5RcrZz6mSaPqZkmOVFawu6
 OzpnAOcKkfbW5PO9jbJbwMimeoF0m782czeDCA9+aButSCaxcysZSPwgBZUPYfi8WaZC
 HFGzd0JaciiLlVUtPUFDze2mC7B0HX/oxNg0HUKNIn9QeADyMHKROUIvyCZgPbY6xEJ/
 O56g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF/USRcTYyIhDYEBKMvZCOjvEdu9rfdvM4DRiEVuCo4Ezxio+ulwhzKjHtoopBU0NxvfjwAny6b6vH@nongnu.org
X-Gm-Message-State: AOJu0Yywy1ts+qRTMEYiEgVRytgRU8JoreiNNoNmMDniu7r9Xsl+UuyT
 RDqux5vz/IXxWgkGfxVh3XkK7nx86En8De1Dq2IaT8QIbTa14PVM4O6oYtTYZSfh4hN+MJK+l1i
 w8Osdqn1Yj/RYOZYFKxdXEDgzVKWwEBaO234FaAQXVGXMxNs5xg2zQJUZ5LHScrLBLx4=
X-Gm-Gg: ASbGncumIlBcPJvjFPtiEzqVvQgOGyVLGrbgV13AFo0gwGvMr/cTp22MBbtr9+BakF/
 2Qibhx5tgqS96LKofOaLgWViiywXuGVqLyE+uYiRcbUVAWDZyM/pQmYvwDqB2bA6WCO9ejZI8CT
 I6Y5vvKga+W3XG9shMWpXG7u8YvYu7Wzz6u3swuH6/eaj2TNsjDTWU9t4JaRKZrq2nuaQxHIMyR
 fpypdgsjTANTPPZHdvGTtHo2Xs8+46m3sK7NZ0p+03CkwkP4qfW4KrMKpORbSA+CAyfKSfKIIvw
 BfuqtPdjthi8kdS3L33AkmM2vPI6B+Pr/eLgR7uIr77E+hoftjp9ItXScW+14pYgLExHFSNyKqE
 4JIvSZCwBJ2I=
X-Received: by 2002:a05:600c:1c23:b0:459:d9a2:e92d with SMTP id
 5b1f17b1804b1-45b57d530b8mr135391305e9.5.1756295315752; 
 Wed, 27 Aug 2025 04:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrnrYEw+m+Bp8EMaIjO1zY78h4OXXUz7nW4RlQpcKe7xaIccBw3HOdqpI4hOTcXJ7mhYoanw==
X-Received: by 2002:a05:600c:1c23:b0:459:d9a2:e92d with SMTP id
 5b1f17b1804b1-45b57d530b8mr135391085e9.5.1756295315332; 
 Wed, 27 Aug 2025 04:48:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f334c95sm27382445e9.25.2025.08.27.04.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:48:34 -0700 (PDT)
Message-ID: <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
Date: Wed, 27 Aug 2025 13:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_HW_NESTED,
> if yes, create nested parent domain which could be reused by vIOMMU to create
> nested domain.
>
> Introduce helper vfio_device_viommu_get_nested to facilitate this
> implementation.
>
> It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
> forbidden and VFIO device fails in set_iommu_device() call, until we support
> passthrough device with x-flts=on.
>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-device.h |  2 ++
>  hw/vfio/device.c              | 12 ++++++++++++
>  hw/vfio/iommufd.c             |  8 ++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 6e4d5ccdac..ecd82c16c7 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>  
>  void vfio_device_unprepare(VFIODevice *vbasedev);
>  
> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev);
I would suggest vfio_device_viommu_has_feature_hw_nested or something alike
get usually means tou take a ref count associated with a put
> +
>  int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                  struct vfio_region_info **info);
>  int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 08f12ac31f..3eeb71bd51 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -23,6 +23,7 @@
>  
>  #include "hw/vfio/vfio-device.h"
>  #include "hw/vfio/pci.h"
> +#include "hw/iommu.h"
>  #include "hw/hw.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> @@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>      vbasedev->bcontainer = NULL;
>  }
>  
> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
> +                  VIOMMU_CAP_HW_NESTED);
> +    }
> +    return false;
> +}
> +
>  /*
>   * Traditional ioctl() based io
>   */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8c27222f75..e503c232e1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -379,6 +379,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create nested parent
I would rather not use another terminology here. You previously used
hw_nested, I think that's better. Also bear in mind that smmu supports
S1, S2 and S1+S2 in emulated code.

Thanks

Eric
> +     * domain which could be reused by vIOMMU to create nested domain.
> +     */
> +    if (vfio_device_viommu_get_nested(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +    }
> +
>      if (cpr_is_incoming()) {
>          hwpt_id = vbasedev->cpr.hwpt_id;
>          goto skip_alloc;


