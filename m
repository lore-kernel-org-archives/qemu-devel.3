Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD20D3E764
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOMb-0004Ja-Me; Wed, 10 Dec 2025 12:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOMa-0004Iy-0X
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOMW-0006TD-Ev
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765389147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smGcrdwEqS1iInt5jXmAh/gVSipA+ZYJymcTyqPd0Yk=;
 b=F8tAgSSYwXtqCyCKWkHAx7noT+kYDQGMWGwyRuamMdt2DGzd1wfD/sRXAA+3+2i5DaXmQs
 E7rRsTYu+DBi/mby5YTPzxLbXox5Z0eync2X03i4PUKHJdOXbg5x23gH+W2ICDYBo4aTWl
 4GCDirAYzX7g8j7XFHfZUoTfByabHC0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-DayU5xvGMDGsTfyjqgQkpA-1; Wed, 10 Dec 2025 12:52:24 -0500
X-MC-Unique: DayU5xvGMDGsTfyjqgQkpA-1
X-Mimecast-MFC-AGG-ID: DayU5xvGMDGsTfyjqgQkpA_1765389143
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2955f0b8895so11210235ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765389143; x=1765993943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smGcrdwEqS1iInt5jXmAh/gVSipA+ZYJymcTyqPd0Yk=;
 b=FINVHJju998s8NcvJcBTNvis402fXCpAzS/E/dgKgRiCcQFsN/NSAR+Vhl4AB2WI4/
 HV2ylgE59do/6Olus7l16G5rVFhUknlNKUXuT3gW3c1NlDAE+Z8ppbKE7GsoIZhOevHI
 Fomc3BP9LZ8+K4AA076rKtyqevxi7OdxlyJUPQRy98YWe6wl2GLDzhvrDJ3twk/V/52H
 T193c57kpsNc4XKA2XOWz9IaA9V1oWl0PH8RK5ILsEi90suN2oWmEP0BLe2lIHcaII1d
 INDE6zs23pwYKtz6V5LhC6T7ly4NmeChtkFzRCbU+VWWSfGJUXfHYeXN6EDtoOFtqGHz
 kQFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP8Ctntwi+cz+D4yK6fJDc5wYNxdx/MRvEdLk5Jf1Sfph3dRUFyMi1NeJZisoyeTa5Dac1yyGl5xsq@nongnu.org
X-Gm-Message-State: AOJu0YzqL+SDSZSULO7h9c1Q9dzlVxnz7YGWaOOKXrj26c7Fg0nylM1j
 7aOdghu7sJxBzx6kw7LsEULAQkejOPTdjXFjhR7jVCMjEhnl3K3+GFJT74LAUnh7FgoqVeLQg+H
 KoWAFCtJbYbK6O2X/GX6F8RuzZD87aD5d/HChzihW0Sk/tPxuMqJoH5xl
X-Gm-Gg: AY/fxX6rlk547Lkida6KjjEEncx6qx7G8iOf3NxonzkPtwbgEK59p51MOTxLu4QNgqm
 0RQuEr4hkyhqiji/VBcQonx8sb4LcCP6jO5ipnR49RBpLxcJeOa+OpgDvFhGi3mQ1hhubHqgbFW
 kfgLPCHuDpZHRMrWHwstVPxMZSV4rksb0VR5BivFX10T3QFGbnz9tYhaXqm7SbLN1aY4t+HrkKT
 ZBdCugD3mr+I9y5AaAUAvZ1xyf7iBUTL9VPoUIG+jSaRgwljd5oOVZqnEeT3cfpK+2BbqJW0gKe
 Lz0YCJXeSwjWEjw5fh8ocEIcPPsTl335W3b/OSFXS3VwAavLSVc0QfWH4Q2XWVPjL+aTYx/+Rz4
 teqB7/Uj8zg7J6aUiJfA4Kws/tLz0W9bg+RXBMRiBZjYmr/oSAUg9of2apA==
X-Received: by 2002:a17:903:2f0e:b0:297:eb3c:51ed with SMTP id
 d9443c01a7336-29ee7bb8041mr2145375ad.16.1765389143001; 
 Wed, 10 Dec 2025 09:52:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQw6k6hqSLmkmt4WuUMN+DhpTV5E6gRh4KINZLLdi1qzg7iRtBTlAUkqoG1jd8nYSoSHeI3g==
X-Received: by 2002:a17:903:2f0e:b0:297:eb3c:51ed with SMTP id
 d9443c01a7336-29ee7bb8041mr2145285ad.16.1765389142571; 
 Wed, 10 Dec 2025 09:52:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29ec8353ad5sm23042015ad.52.2025.12.10.09.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:52:22 -0800 (PST)
Message-ID: <ed5a4f7d-a071-4c4c-8e78-ab2e1709f4eb@redhat.com>
Date: Wed, 10 Dec 2025 18:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/23] Workaround for ERRATA_772415_SPR17
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-22-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
> range mapped on second stage page table could still be written.
>
> Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
> Update, Errata Details, SPR17.
> https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
>
> Also copied the SPR17 details from above link:
> "Problem: When remapping hardware is configured by system software in
> scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
> Access bit if enabled) in first-stage page-table entries even when
> second-stage mappings indicate that corresponding first-stage page-table
> is Read-Only.
>
> Implication: Due to this erratum, pages mapped as Read-only in second-stage
> page-tables may be modified by remapping hardware Access/Dirty bit updates.
>
> Workaround: None identified. System software enabling nested translations
> for a VM should ensure that there are no read-only pages in the
> corresponding second-stage mappings."
>
> Introduce a helper vfio_device_get_host_iommu_quirk_bypass_ro to check if
> readonly mappings should be bypassed.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

since it will be moved to a different series, I skip the review for now.

Thanks

Eric
> ---
>  include/hw/vfio/vfio-container.h |  1 +
>  include/hw/vfio/vfio-device.h    |  3 +++
>  hw/vfio/device.c                 | 14 ++++++++++++++
>  hw/vfio/iommufd.c                |  9 ++++++++-
>  hw/vfio/listener.c               |  6 ++++--
>  5 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index 9f6e8cedfc..a7d5c5ed67 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -52,6 +52,7 @@ struct VFIOContainer {
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
>      NotifierWithReturn cpr_reboot_notifier;
> +    bool bypass_ro;
>  };
>  
>  #define TYPE_VFIO_IOMMU "vfio-iommu"
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 48d00c7bc4..f6f3d0e378 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -268,6 +268,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>  void vfio_device_unprepare(VFIODevice *vbasedev);
>  
>  bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
> +                                                uint32_t type, void *caps,
> +                                                uint32_t size);
>  
>  int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>                                  struct vfio_region_info **info);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 71eb069eb6..290011e154 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -533,6 +533,20 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>      return false;
>  }
>  
> +bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
> +                                                uint32_t type, void *caps,
> +                                                uint32_t size)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_host_iommu_quirks(PCI_DEVICE(vdev), type,
> +                                                   caps, size) &
> +                  HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO);
> +    }
> +    return false;
> +}
> +
>  /*
>   * Traditional ioctl() based io
>   */
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 63f8442865..2a7b0d0c07 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -351,6 +351,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      VFIOContainer *bcontainer = VFIO_IOMMU(container);
>      uint32_t type, flags = 0;
>      uint64_t hw_caps;
> +    VendorCaps caps;
>      VFIOIOASHwpt *hwpt;
>      uint32_t hwpt_id;
>      int ret;
> @@ -396,7 +397,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       * instead.
>       */
>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
> -                                         &type, NULL, 0, &hw_caps, errp)) {
> +                                         &type, &caps, sizeof(caps), &hw_caps,
> +                                         errp)) {
>          return false;
>      }
>  
> @@ -411,6 +413,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       */
>      if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
>          flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +
> +        if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,
> +                                                       &caps, sizeof(caps))) {
> +            bcontainer->bypass_ro = true;
> +        }
>      }
>  
>      if (cpr_is_incoming()) {
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index ca2377d860..090f935d30 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -502,7 +502,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
>      int ret;
>      Error *err = NULL;
>  
> -    if (!vfio_listener_valid_section(section, false, "region_add")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_add")) {
>          return;
>      }
>  
> @@ -668,7 +669,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      int ret;
>      bool try_unmap = true;
>  
> -    if (!vfio_listener_valid_section(section, false, "region_del")) {
> +    if (!vfio_listener_valid_section(section, bcontainer->bypass_ro,
> +                                     "region_del")) {
>          return;
>      }
>  


