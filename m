Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C4FC02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTyO-0004BW-VP; Thu, 16 Jan 2025 12:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYTyN-0004An-8Y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYTyK-0004aa-Ui
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737049679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3st1H/4v7kqYUfxQp+S180ti7Pwfx4lmx0p8JBNR8g=;
 b=ZzPq49euk9z0PfjcNQ/P80wqhRIjGl5QviUXtbe8KiPlt+sDTfOC9V015f6aEVTT7zloGe
 gxcGZyVMF6ag8EMr6dMM3qKxVuttiF17avbNCZlnP+8Cd6k6x0r0WRySHM68Hm6/qXUgfw
 mIOlgBS64KzTNzVu1UW/rCqkkORjxJE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3jkSCmOYPtaw1fetAVKRRw-1; Thu, 16 Jan 2025 12:47:57 -0500
X-MC-Unique: 3jkSCmOYPtaw1fetAVKRRw-1
X-Mimecast-MFC-AGG-ID: 3jkSCmOYPtaw1fetAVKRRw
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-84990d44b31so1964939f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049676; x=1737654476;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A3st1H/4v7kqYUfxQp+S180ti7Pwfx4lmx0p8JBNR8g=;
 b=j1mWEl8Ekn6Kz+3W2S936a7XG9gATJL/oWqsDXBWyHpecpaE2vCYi4nnbTDTGJejI5
 66gus8Tv1FjyTWA3SFBefxwjiD1t+jcmZczOppVaUxRQVAfK4LSGdIHLKi1I0aDVWchL
 1UtKCg5rJ/auODnV4pe/NViugsHj9zlePuB3lBVv+OW4EkIoZTHnJiUB74GOhMeedgqK
 kpRbqINqKg6unRwGmdZ6vjO9ZaJnph6E8mxUevr/WpLxo0Kij5aOPbgZ2OPUyaNfLg0e
 /Y/YEyNEg4Ew+9ub6HonAuxmbTBGNmnAlDWIV5UtoXN9OyXK4LXYWFEhOotQtc+v5pCQ
 Bu1g==
X-Gm-Message-State: AOJu0YydSQs59J6GqbrALWfuNTMh9mmVSrGEaNTS75MFGPXLUoBZYYF4
 9yENr+x5+NIYxSQioYokDt3W8DPAr6mlNrQZoPVuOFHMcfAER/K9Wdo5M+THAA+w4sG99Dm0ky4
 XcB5z83S9MHA7eP1sEkZaGvvWuuJ2x4KXcmb/LExzUYr7RTl29Y8v
X-Gm-Gg: ASbGncvmtsg/eRGiK5kZgJpFXv+UifF1fwhOOVKslwiD7GPoh/tziouzAKFNYXrvvdc
 GSjDpIMLJgVO6vr2QgHcJ7dCaXI6aeLab2+HdgVFV9ohOFEU5hBjjmL/ClSRqp37BRqGyPicMIn
 d6EBMIfXM5uXlC6hWg7R6yNN6UndE3QtUGaJiF5/qj7996I/sa5q18zWm/qeL+8dUu1Wp84t02W
 KHrTNwHqpgqu+zVZ39dVtLdkZLCMmqALl39UvRZYatX0VOaF1zLPDpZ8wzs
X-Received: by 2002:a05:6e02:1f13:b0:3a7:bd4c:b17e with SMTP id
 e9e14a558f8ab-3ce3a7ab94bmr80029765ab.0.1737049675938; 
 Thu, 16 Jan 2025 09:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKfYBasW+hm6OZJ3cAPIWAQEKVj78tU3xfcvKbyvpyF2k202R8ntgUDCg1dUACiuCfeBlI6A==
X-Received: by 2002:a05:6e02:1f13:b0:3a7:bd4c:b17e with SMTP id
 e9e14a558f8ab-3ce3a7ab94bmr80029645ab.0.1737049675407; 
 Thu, 16 Jan 2025 09:47:55 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3cf71a76e37sm1131175ab.2.2025.01.16.09.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 09:47:54 -0800 (PST)
Date: Thu, 16 Jan 2025 12:47:40 -0500
From: Alex Williamson <alex.williamson@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
Message-ID: <20250116124740.51cf4182.alex.williamson@redhat.com>
In-Reply-To: <20250116095355.41909-1-east.moutain.yang@gmail.com>
References: <20250116095355.41909-1-east.moutain.yang@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 16 Jan 2025 17:53:55 +0800
Wencheng Yang <east.moutain.yang@gmail.com> wrote:

> On confidential VM platform, for example, AMD-SEV, P2P doesn't work.
> The underlying reason is that IOMMU driver set encryption bit on
> IOMMU page table pte entry, it's reasonalbe if the pte maps iova
> to system memory. However, if the pte maps iova to device's
> mmio bar space, setting encryption bit on pte would cause IOMMU
> translates iova to incorrect bus address, rather than mmio bar
> address.
> 
> To fix the issue, the key point is to let IOMMU driver know the
> target phyical address is system memory or device mmio.
> 
> VFIO allocates virtual address and maps it to device mmio bar,
> the member @ram_device of MemoryRegion indicates the memory
> region is for mmio. The patch passes the info to VFIO DAM API,
> IOMMU driver would do the correct thing.
> 
> Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> ---
>  hw/vfio/common.c                      | 67 +++++++++++++++++----------
>  hw/vfio/container-base.c              |  4 +-
>  hw/vfio/container.c                   |  6 ++-
>  hw/vfio/iommufd.c                     |  4 +-
>  hw/virtio/vhost-vdpa.c                |  6 +--
>  include/exec/memory.h                 |  7 ++-
>  include/hw/vfio/vfio-common.h         |  4 ++
>  include/hw/vfio/vfio-container-base.h |  4 +-
>  linux-headers/linux/vfio.h            |  1 +
>  system/memory.c                       | 11 +++--
>  10 files changed, 74 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f7499a9b74..2660a42f9e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -247,31 +247,42 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  
>  /* Called with rcu_read_lock held.  */
>  static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> +                               ram_addr_t *ram_addr, uint32_t *flag,
>                                 Error **errp)
>  {
>      bool ret, mr_has_discard_manager;
> +    uint32_t mr_flag = 0;
>  
> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> +    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, &mr_flag,
>                                 &mr_has_discard_manager, errp);
> -    if (ret && mr_has_discard_manager) {
> -        /*
> -         * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> -         * pages will remain pinned inside vfio until unmapped, resulting in a
> -         * higher memory consumption than expected. If memory would get
> -         * populated again later, there would be an inconsistency between pages
> -         * pinned by vfio and pages seen by QEMU. This is the case until
> -         * unmapped from the IOMMU (e.g., during device reset).
> -         *
> -         * With malicious guests, we really only care about pinning more memory
> -         * than expected. RLIMIT_MEMLOCK set for the user/process can never be
> -         * exceeded and can be used to mitigate this problem.
> -         */
> -        warn_report_once("Using vfio with vIOMMUs and coordinated discarding of"
> -                         " RAM (e.g., virtio-mem) works, however, malicious"
> -                         " guests can trigger pinning of more memory than"
> -                         " intended via an IOMMU. It's possible to mitigate "
> -                         " by setting/adjusting RLIMIT_MEMLOCK.");
> +    if (ret) {
> +        if (flag) {
> +            if (mr_flag & MRF_READONLY)
> +                *flag |= VFIO_MRF_READONLY;
> +
> +            if (mr_flag & MRF_RAMDEV)
> +                *flag |= VFIO_MRF_RAMDEV;
> +        }
> +
> +        if (mr_has_discard_manager) {
> +            /*
> +             * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> +             * pages will remain pinned inside vfio until unmapped, resulting in a
> +             * higher memory consumption than expected. If memory would get
> +             * populated again later, there would be an inconsistency between pages
> +             * pinned by vfio and pages seen by QEMU. This is the case until
> +             * unmapped from the IOMMU (e.g., during device reset).
> +             *
> +             * With malicious guests, we really only care about pinning more memory
> +             * than expected. RLIMIT_MEMLOCK set for the user/process can never be
> +             * exceeded and can be used to mitigate this problem.
> +             */
> +            warn_report_once("Using vfio with vIOMMUs and coordinated discarding of"
> +                             " RAM (e.g., virtio-mem) works, however, malicious"
> +                             " guests can trigger pinning of more memory than"
> +                             " intended via an IOMMU. It's possible to mitigate "
> +                             " by setting/adjusting RLIMIT_MEMLOCK.");
> +        }
>      }
>      return ret;
>  }
> @@ -298,9 +309,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        bool read_only;
> +        uint32_t flag = 0;
>  
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &flag, &local_err)) {
>              error_report_err(local_err);
>              goto out;
>          }
> @@ -313,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           */
>          ret = vfio_container_dma_map(bcontainer, iova,
>                                       iotlb->addr_mask + 1, vaddr,
> -                                     read_only);
> +                                     flag);
>          if (ret) {
>              error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -363,6 +374,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                         int128_get64(section->size);
>      hwaddr start, next, iova;
>      void *vaddr;
> +    uint32_t flag = 0;
>      int ret;
>  
>      /*
> @@ -377,8 +389,10 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>                 section->offset_within_address_space;
>          vaddr = memory_region_get_ram_ptr(section->mr) + start;
>  
> +        flag |= section->readonly? VFIO_MRF_READONLY: 0;
> +        flag |= section->ram_device? VFIO_MRF_RAMDEV: 0;
>          ret = vfio_container_dma_map(bcontainer, iova, next - start,
> -                                     vaddr, section->readonly);
> +                                     vaddr, flag);
>          if (ret) {
>              /* Rollback */
>              vfio_ram_discard_notify_discard(rdl, section);
> @@ -563,6 +577,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      hwaddr iova, end;
>      Int128 llend, llsize;
>      void *vaddr;
> +    uint32_t flag = 0;
>      int ret;
>      Error *err = NULL;
>  
> @@ -661,8 +676,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          }
>      }
>  
> +    flag |= section->readonly? VFIO_MRF_READONLY: 0;
> +    flag |= section->ram_device? VFIO_MRF_RAMDEV: 0;
>      ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
> -                                 vaddr, section->readonly);
> +                                 vaddr, flag);
>      if (ret) {
>          error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                     "0x%"HWADDR_PRIx", %p) = %d (%s)",
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 749a3fd29d..7cee2ac562 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -17,12 +17,12 @@
>  
>  int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                             hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly)
> +                           void *vaddr, uint32_t flag)
>  {
>      VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>  
>      g_assert(vioc->dma_map);
> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
> +    return vioc->dma_map(bcontainer, iova, size, vaddr, flag);
>  }
>  
>  int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4ebb526808..90c32cd16d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -176,7 +176,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>  }
>  
>  static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool readonly)
> +                               ram_addr_t size, void *vaddr, uint32_t flag)
>  {
>      const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                    bcontainer);
> @@ -188,9 +188,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>          .size = size,
>      };
>  
> -    if (!readonly) {
> +    if (!(flag & VFIO_MRF_READONLY)) {
>          map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>      }
> +    if (flag & VFIO_MRF_RAMDEV)
> +        map.flags |= VFIO_DMA_MAP_FLAG_MMIO;
>  
>      /*
>       * Try the mapping, if it fails with EBUSY, unmap the region and try
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3490a8f1eb..c773b45b5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -28,14 +28,14 @@
>  #include "exec/ram_addr.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            ram_addr_t size, void *vaddr, uint32_t flag)
>  {
>      const VFIOIOMMUFDContainer *container =
>          container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>  
>      return iommufd_backend_map_dma(container->be,
>                                     container->ioas_id,
> -                                   iova, size, vaddr, readonly);
> +                                   iova, size, vaddr, flag & VFIO_MRF_READONLY);
>  }
>  
>  static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12ed5..dea733ef8a 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -226,15 +226,15 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        bool read_only;
> +        uint32_t flag;
>  
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &flag, NULL,
>                                    &local_err)) {
>              error_report_err(local_err);
>              return;
>          }
>          ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
> -                                 iotlb->addr_mask + 1, vaddr, read_only);
> +                                 iotlb->addr_mask + 1, vaddr, flag & MRF_READONLY);
>          if (ret) {
>              error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
>                           "0x%" HWADDR_PRIx ", %p) = %d (%m)",
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9458e2801d..24405af0be 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -104,10 +104,15 @@ struct MemoryRegionSection {
>      hwaddr offset_within_region;
>      hwaddr offset_within_address_space;
>      bool readonly;
> +    bool ram_device;
>      bool nonvolatile;
>      bool unmergeable;
>  };
>  
> +/* memory region flag */
> +#define MRF_READONLY 0x1
> +#define MRF_RAMDEV   0x2
> +
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>  
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> @@ -742,7 +747,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   * Return: true on success, else false setting @errp with error.
>   */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> +                          ram_addr_t *ram_addr, uint32_t *flag,
>                            bool *mr_has_discard_manager, Error **errp);
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0c60be5b15..48018dc751 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -43,6 +43,10 @@ enum {
>      VFIO_DEVICE_TYPE_AP = 3,
>  };
>  
> +/* vfio memory region flag */
> +#define VFIO_MRF_READONLY 0x1
> +#define VFIO_MRF_RAMDEV   0x2
> +
>  typedef struct VFIOMmap {
>      MemoryRegion mem;
>      void *mmap;
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 4cff9943ab..bb473e7201 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
>  
>  int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                             hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, uint32_t flag);
>  int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                               hwaddr iova, ram_addr_t size,
>                               IOMMUTLBEntry *iotlb);
> @@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
>      bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
>      int (*dma_map)(const VFIOContainerBase *bcontainer,
>                     hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> +                   void *vaddr, uint32_t flag);
>      int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                       hwaddr iova, ram_addr_t size,
>                       IOMMUTLBEntry *iotlb);
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 1b5e254d6a..4a32e70c33 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
>  #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
>  #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
>  #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
> +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)

Where's the kernel patch that implements the MMIO map flag.  That needs
to come first.

I also don't understand why we're creating multiple read-only and
ramdev flags to distill back into vfio mapping flags.  Thanks,

Alex

>  	__u64	vaddr;				/* Process virtual address */
>  	__u64	iova;				/* IO virtual address */
>  	__u64	size;				/* Size of mapping (bytes) */
> diff --git a/system/memory.c b/system/memory.c
> index b17b5538ff..71c54fc045 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -223,6 +223,7 @@ struct FlatRange {
>      uint8_t dirty_log_mask;
>      bool romd_mode;
>      bool readonly;
> +    bool ram_device;
>      bool nonvolatile;
>      bool unmergeable;
>  };
> @@ -240,6 +241,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)
>          .size = fr->addr.size,
>          .offset_within_address_space = int128_get64(fr->addr.start),
>          .readonly = fr->readonly,
> +        .ram_device = fr->ram_device,
>          .nonvolatile = fr->nonvolatile,
>          .unmergeable = fr->unmergeable,
>      };
> @@ -252,6 +254,7 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
>          && a->offset_in_region == b->offset_in_region
>          && a->romd_mode == b->romd_mode
>          && a->readonly == b->readonly
> +        && a->ram_device == b->ram_device
>          && a->nonvolatile == b->nonvolatile
>          && a->unmergeable == b->unmergeable;
>  }
> @@ -657,6 +660,7 @@ static void render_memory_region(FlatView *view,
>      fr.dirty_log_mask = memory_region_get_dirty_log_mask(mr);
>      fr.romd_mode = mr->romd_mode;
>      fr.readonly = readonly;
> +    fr.ram_device = mr->ram_device;
>      fr.nonvolatile = nonvolatile;
>      fr.unmergeable = unmergeable;
>  
> @@ -2184,7 +2188,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>  
>  /* Called with rcu_read_lock held.  */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> +                          ram_addr_t *ram_addr, uint32_t *flag,
>                            bool *mr_has_discard_manager, Error **errp)
>  {
>      MemoryRegion *mr;
> @@ -2246,8 +2250,9 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>          *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>      }
>  
> -    if (read_only) {
> -        *read_only = !writable || mr->readonly;
> +    if (flag) {
> +        *flag |= (!writable || mr->readonly)? MRF_READONLY: 0;
> +        *flag |= mr->ram_device? MRF_RAMDEV: 0;
>      }
>  
>      return true;


