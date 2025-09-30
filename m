Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5E1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3W2V-0003sV-N3; Tue, 30 Sep 2025 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3W2L-0003lY-L9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3W2C-0008T8-MO
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759222106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dMEjfZYlFnmyBhBcv4/tSuDAC/cU9xbNMYdte8M2eHI=;
 b=ZQi9g+cnI0wrzPm5NjM+rmrntJ3bXgTCqGDIO+NUm7YMHpaOPgyH735YTO7JXfRjKw54Nz
 KOt1pwwHGZ9C73Tlg9hR6ve8mH9xT/KGA5ysWhedc5OziSnov2mbCyb1jbDSVOF5l817Pb
 d4z4c7p9N+LiXheNLzG+yQT4TnQvtbk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Mksc3cTyN7uXzxD4d-eXhQ-1; Tue, 30 Sep 2025 04:48:25 -0400
X-MC-Unique: Mksc3cTyN7uXzxD4d-eXhQ-1
X-Mimecast-MFC-AGG-ID: Mksc3cTyN7uXzxD4d-eXhQ_1759222104
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so12895715e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759222104; x=1759826904;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dMEjfZYlFnmyBhBcv4/tSuDAC/cU9xbNMYdte8M2eHI=;
 b=CtHGlV4/f1BV6+RMwTGM2TgbG/+IE8Wv/xXjSJnAdKr8clAf6+txMk+7eDnyT3a8Uc
 QLx6OAiaJYFOichIoKyxu1lcjKLu7DJ+7Mk1+yypXXOTbuKoX2oJ7otsk3IpYlhuXhEv
 YfPebNTTrKRkAqgW814BjvTbShnZIoAjFOePD0ui3RH/qFxSnl9tcthBOVpGruk+kJ0p
 M+7+v1xyLSH9jQguC1b4UVW+Ny80k++L+2YFwG14Vc+/WBILewMJlBxo8jCXgrIvM0Xc
 F4JtdJsf7meNyypRhah1szU7+HUdfvitz43VIZO3YAWtnUr6WmVF8cuwrQ/ln9NEaMzE
 CNrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl5UYyYFxR+/knq4EQM9bSPvUQzEFbX/Av2RVo+QVp7aUP1uDDUau60sTY7r4kQzceoA+ryG8nGUoi@nongnu.org
X-Gm-Message-State: AOJu0YyrCxbuT/FktUG0G4WCO9feqeJh9EmXiLYsl7ObkX8padImbrXT
 0p7lm2tZdKbAW+NymtPIVQ4V8qbiHOzntqq9dzkcWSrWWIwQO0uuuQhyY4OBO6e6C0WzVNftfQv
 B1aZCbwpWrB3rWC18eD7iG/9idGKo7NZomf/cnFSwxkreEr7+D3BUJJcq
X-Gm-Gg: ASbGnctxLNlUwocUjsC0dvEHApEsU+Vo4lQKer0BIxaCdh/M67pLE9qn6V2y0FdwLNM
 PeA2BdRI03IQBXc3cxsciVD5gxaPee3vH8488RocVkaak+2ZWuefIg054zKt0y+5Q4yLgj5idm3
 T5h9ClosoOWTAocnoFfRo0hvjdDY22nsa+7tc+B0R9uJ/Ixr8gqhexMzLaLOdC9QW15lBz3072c
 +z2Qrmrznk0/jzZIwH7r6a6UZapUhF7M/oFFQjEq2lo/ytNFYJ/vKQq77OydolTeKuXRfsxUPCr
 umN62P+NiYNIjYKHQwwNCdWgW+5GfsrbUAVEnHRdwb4mCS5qXQEsvi9yUknYhw9MTo0k/w9RD7b
 OhWjNxUWv
X-Received: by 2002:a05:600c:6306:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-46e329ab373mr174532685e9.1.1759222103701; 
 Tue, 30 Sep 2025 01:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADYG5y+BdAycmkf9IBOk8N/dhdhv5tflqj4qv7TE3Ft7Yc40RdHwry1JqRn3HDEJyZMZ1hg==
X-Received: by 2002:a05:600c:6306:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-46e329ab373mr174532405e9.1.1759222103215; 
 Tue, 30 Sep 2025 01:48:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc560338csm22293639f8f.41.2025.09.30.01.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 01:48:22 -0700 (PDT)
Message-ID: <75040958-036d-4364-bff0-730bac8a01f2@redhat.com>
Date: Tue, 30 Sep 2025 10:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Thanos Makatos <thanos.makatos@nutanix.com>, 
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250929160807.73626-1-philmd@linaro.org>
 <20250929160807.73626-4-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250929160807.73626-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 18:08, Philippe Mathieu-Daudé wrote:
> The 'ram_addr_t' type is described as:
> 
>    a QEMU internal address space that maps guest RAM physical
>    addresses into an intermediate address space that can map
>    to host virtual address spaces.
> 
> This doesn't represent well an IOVA mapping size. Simply use
> the uint64_t type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/vfio/vfio-container.h | 10 +++++-----
>   hw/vfio-user/container.c         |  4 ++--
>   hw/vfio/container-legacy.c       |  8 ++++----
>   hw/vfio/container.c              |  5 ++---
>   hw/vfio/iommufd.c                |  6 +++---
>   5 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index 093c360f0ee..c4b58d664b7 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -81,10 +81,10 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>                                  VFIOContainer *bcontainer);
>   
>   int vfio_container_dma_map(VFIOContainer *bcontainer,
> -                           hwaddr iova, ram_addr_t size,
> +                           hwaddr iova, uint64_t size,
>                              void *vaddr, bool readonly, MemoryRegion *mr);
>   int vfio_container_dma_unmap(VFIOContainer *bcontainer,
> -                             hwaddr iova, ram_addr_t size,
> +                             hwaddr iova, uint64_t size,
>                                IOMMUTLBEntry *iotlb, bool unmap_all);
>   bool vfio_container_add_section_window(VFIOContainer *bcontainer,
>                                          MemoryRegionSection *section,
> @@ -167,7 +167,7 @@ struct VFIOIOMMUClass {
>        * Returns 0 to indicate success and -errno otherwise.
>        */
>       int (*dma_map)(const VFIOContainer *bcontainer,
> -                   hwaddr iova, ram_addr_t size,
> +                   hwaddr iova, uint64_t size,
>                      void *vaddr, bool readonly, MemoryRegion *mr);
>       /**
>        * @dma_map_file
> @@ -182,7 +182,7 @@ struct VFIOIOMMUClass {
>        * @readonly: map read only if true
>        */
>       int (*dma_map_file)(const VFIOContainer *bcontainer,
> -                        hwaddr iova, ram_addr_t size,
> +                        hwaddr iova, uint64_t size,
>                           int fd, unsigned long start, bool readonly);
>       /**
>        * @dma_unmap
> @@ -198,7 +198,7 @@ struct VFIOIOMMUClass {
>        * Returns 0 to indicate success and -errno otherwise.
>        */
>       int (*dma_unmap)(const VFIOContainer *bcontainer,
> -                     hwaddr iova, ram_addr_t size,
> +                     hwaddr iova, uint64_t size,
>                        IOMMUTLBEntry *iotlb, bool unmap_all);
>   
>   
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index 411eb7b28b7..e45192fef65 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -39,7 +39,7 @@ static void vfio_user_listener_commit(VFIOContainer *bcontainer)
>   }
>   
>   static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
> -                               hwaddr iova, ram_addr_t size,
> +                               hwaddr iova, uint64_t size,
>                                  IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
> @@ -81,7 +81,7 @@ static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
>   }
>   
>   static int vfio_user_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
> -                             ram_addr_t size, void *vaddr, bool readonly,
> +                             uint64_t size, void *vaddr, bool readonly,
>                                MemoryRegion *mrp)
>   {
>       VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index c0f87f774a0..3a710d8265c 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -69,7 +69,7 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
>   }
>   
>   static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
> -                                 hwaddr iova, ram_addr_t size,
> +                                 hwaddr iova, uint64_t size,
>                                    IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *bcontainer = VFIO_IOMMU(container);
> @@ -122,7 +122,7 @@ unmap_exit:
>   }
>   
>   static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
> -                                     hwaddr iova, ram_addr_t size,
> +                                     hwaddr iova, uint64_t size,
>                                        IOMMUTLBEntry *iotlb)
>   {
>       const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
> @@ -185,7 +185,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
>    * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>    */
>   static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
> -                                 hwaddr iova, ram_addr_t size,
> +                                 hwaddr iova, uint64_t size,
>                                    IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       int ret;
> @@ -210,7 +210,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
>   }
>   
>   static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool readonly,
> +                               uint64_t size, void *vaddr, bool readonly,
>                                  MemoryRegion *mr)
>   {
>       const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9d694393714..b5af3ac174c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -15,7 +15,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "system/tcg.h"
> -#include "system/ram_addr.h"

This is required for cpu_physical_memory_set_dirty_range()

C.



>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/vfio/vfio-container.h"
> @@ -74,7 +73,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>   }
>   
>   int vfio_container_dma_map(VFIOContainer *bcontainer,
> -                           hwaddr iova, ram_addr_t size,
> +                           hwaddr iova, uint64_t size,
>                              void *vaddr, bool readonly, MemoryRegion *mr)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> @@ -93,7 +92,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
>   }
>   
>   int vfio_container_dma_unmap(VFIOContainer *bcontainer,
> -                             hwaddr iova, ram_addr_t size,
> +                             hwaddr iova, uint64_t size,
>                                IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index f0ffe235919..68470d552ec 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -35,7 +35,7 @@
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>   
>   static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly,
> +                            uint64_t size, void *vaddr, bool readonly,
>                               MemoryRegion *mr)
>   {
>       const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
> @@ -46,7 +46,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
>   }
>   
>   static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
> -                                 hwaddr iova, ram_addr_t size,
> +                                 hwaddr iova, uint64_t size,
>                                    int fd, unsigned long start, bool readonly)
>   {
>       const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
> @@ -57,7 +57,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
>   }
>   
>   static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
> -                              hwaddr iova, ram_addr_t size,
> +                              hwaddr iova, uint64_t size,
>                                 IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);


