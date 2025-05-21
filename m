Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3355DC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 07:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHe6o-0003YZ-7l; Wed, 21 May 2025 03:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHe6l-0003YE-0r
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHe6h-00032I-Sw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 03:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747813397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jYf+TVTVlvFpo//IqEPGrJiQsoKsSb44O1jN+9SWAq4=;
 b=Ahs0HX309M2qd5LvKQVJ9SRHxw1JFp7xsWuRVI5RzO17F3lOMeAntTuKjz5W/0qI0bmgQi
 KrjQtZObYBE9QkiTIFQTVuqk1ww5JSmZgm0LnFJvsmbwq6/yjQpypTohXsNXD1g4rXYYfL
 I0dAOuh6EBPVcGATCZrKOPh8dYlUDaQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-pAqtFHrFOwexZpLYYNpzpA-1; Wed, 21 May 2025 03:43:15 -0400
X-MC-Unique: pAqtFHrFOwexZpLYYNpzpA-1
X-Mimecast-MFC-AGG-ID: pAqtFHrFOwexZpLYYNpzpA_1747813394
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so14285345e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 00:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747813394; x=1748418194;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYf+TVTVlvFpo//IqEPGrJiQsoKsSb44O1jN+9SWAq4=;
 b=kSg9BKH24WOlKCjNvEPA044AD5SUAufQOzU+roKC/J/Pqc2SBlKypsy1/IO8inKO6M
 ObkHnDmimDkTjMHR7kT80DM12VahRSjb5alQCPd9F2cUmvWLKbumMvFm4SHrLnNEiXDg
 wEYyTBaLUbanODLnPhreluGJDvBFamE8/Dn2jO4n+SHfjFKML4c5I5/6xQIBOWx2NPQz
 SWdu81SF4v18omsGj8Ju31Bv8zMrBLM1Zj0N6ww8xabp5x4ZTm/qrVN4SyCG6pLMBelE
 r2LlRQQF5Bod7m5++7UQxhSnSP95vA2r/NAWOJxFrNRmo/IL4nqlI3DUo75MLD3hqlvW
 IlcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYK4n0a0eE4SC+WrAcVDX109HcvyKF+uoNU45vxrioGeVhAXvtEpHYyUgD+c3Q6VTIaq5WVmR1p8qG@nongnu.org
X-Gm-Message-State: AOJu0YwJAQdbkiHeN9KF77Ytww+xGuBMJbKwvjeOCpOM3gRVMWdqzsJI
 kikWOVlQ2h19eZzFy8r/SEIhx559RlA7y4DbXUT9WitrfU+o2chNUeFtmOR1g7WGDRj+bxsPypG
 jKMFsbfVQJvjTK1oQ4BwXKgvRqKykQpK1uwCRbspKflefZ4XmiF+iDDv7
X-Gm-Gg: ASbGncuHIQ9OaKS5irp1KFOC2H8CDEdacHmQpYU+3yb+BIdotXS5K2JVOXk3RfMDmJF
 S1ZMHRqEg5LPJMhDuk77/BnH8aNSsxqz2n+Ls73ao03emYPa16UrmRP0vRm9Po2pjKjJ0vlAKs3
 8zyhEybbV2j+NAtyzDslSd4fWg9gTdtf0ea2D7wQWvoS2NLi2bviY+0BEJMugfgRGxqHw+cTHQp
 +vMZ35hIg/RWaNmzxEgIiPvnNtKnNdpicQQQVl3FK1VFVHlgGk5VZNHBmH27hNvu8yaNVSjwHQE
 Bupk7Ll/IuIA6VSRRmri3nsP1MZN4h2BpVbk1r3x10/1RqEI0A==
X-Received: by 2002:a05:600c:820c:b0:442:f97b:87e with SMTP id
 5b1f17b1804b1-442fd608746mr177440525e9.6.1747813393961; 
 Wed, 21 May 2025 00:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGncWHEL52I++JiCI6LIB7QBqIyKHQGZmrQyPT5+13F0hjBy2i5xL1kgz26gJAk/neYdaJyEA==
X-Received: by 2002:a05:600c:820c:b0:442:f97b:87e with SMTP id
 5b1f17b1804b1-442fd608746mr177440295e9.6.1747813393585; 
 Wed, 21 May 2025 00:43:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b295e7sm58420075e9.2.2025.05.21.00.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 00:43:12 -0700 (PDT)
Message-ID: <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
Date: Wed, 21 May 2025 09:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] vfio/container: pass MemoryRegion to DMA
 operations
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Steven Sistare <steven.sistare@oracle.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-11-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520150419.2172078-11-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

+Steven,

On 5/20/25 17:03, John Levon wrote:
> Pass through the MemoryRegion to DMA operation handlers of vfio
> containers. The vfio-user container will need this later, to translate
> the vaddr into an offset for the dma map vfio-user message.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>


This change conflicts with :

   https://lore.kernel.org/qemu-devel/1747063973-124548-28-git-send-email-steven.sistare@oracle.com

Steven,

Could we use this version instead for the "live update" series ?

Thanks,

C.



> ---
>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>   hw/vfio/container-base.c              | 4 ++--
>   hw/vfio/container.c                   | 3 ++-
>   hw/vfio/iommufd.c                     | 3 ++-
>   hw/vfio/listener.c                    | 6 +++---
>   5 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 41c49b2aa5..c18986a621 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, bool readonly, MemoryRegion *mrp);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb, bool unmap_all);
> @@ -149,18 +149,19 @@ struct VFIOIOMMUClass {
>       /**
>        * @dma_map
>        *
> -     * Map an address range into the container.
> +     * Map an address range into the container. Note that @mrp will within an
> +     * RCU read lock region across this call.
>        *
>        * @bcontainer: #VFIOContainerBase to use
>        * @iova: start address to map
>        * @size: size of the range to map
>        * @vaddr: process virtual address of mapping
>        * @readonly: true if mapping should be readonly
> +     * @mrp: the memory region for this mapping
>        */
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> -
> +                   void *vaddr, bool readonly, MemoryRegion *mrp);
>       /**
>        * @dma_unmap
>        *
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 1c6ca94b60..a677bb6694 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly)
> +                           void *vaddr, bool readonly, MemoryRegion *mrp)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       g_assert(vioc->dma_map);
> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
> +    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
>   }
>   
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a9f0dbaec4..98d6b9f90c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>   }
>   
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                               ram_addr_t size, void *vaddr, bool readonly)
> +                               ram_addr_t size, void *vaddr, bool readonly,
> +                               MemoryRegion *mrp)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index af1c7ab10a..a2518c4a5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -34,7 +34,8 @@
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            ram_addr_t size, void *vaddr, bool readonly,
> +                            MemoryRegion *mrp)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 0afafe3464..a1d2d2561d 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -170,7 +170,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>            */
>           ret = vfio_container_dma_map(bcontainer, iova,
>                                        iotlb->addr_mask + 1, vaddr,
> -                                     read_only);
> +                                     read_only, mr);
>           if (ret) {
>               error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
> @@ -240,7 +240,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>   
>           ret = vfio_container_dma_map(bcontainer, iova, next - start,
> -                                     vaddr, section->readonly);
> +                                     vaddr, section->readonly, section->mr);
>           if (ret) {
>               /* Rollback */
>               vfio_ram_discard_notify_discard(rdl, section);
> @@ -564,7 +564,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>       }
>   
>       ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
> -                                 vaddr, section->readonly);
> +                                 vaddr, section->readonly, section->mr);
>       if (ret) {
>           error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",


