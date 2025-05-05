Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8651DC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBuaY-0008KP-Fv; Mon, 05 May 2025 08:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBuaM-0008JK-M4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBuaH-00069U-Iw
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746446767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GCWre+YiiE1M/xjq50/0b5RxI5pgjZUljUe5DxoqVQw=;
 b=e3yLd862LjVU8J1Hnr/wmsNrNjZmX2l54UFBa8HUX2kqlLK6e/H5w8mhtwOmeWhR5QMkWj
 2iB/Lo6OmG883fTy8+X9/8df5RaMg4qQOsI1Qx1okI94OEbbpqxY5SiPUxCJbPswG74XBu
 VeiwtIvjNiAl2W3/EjtIi52mr+rs9/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-TIYWF9aoNLSDERECE_lAtQ-1; Mon, 05 May 2025 08:06:06 -0400
X-MC-Unique: TIYWF9aoNLSDERECE_lAtQ-1
X-Mimecast-MFC-AGG-ID: TIYWF9aoNLSDERECE_lAtQ_1746446765
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so18321875e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746446765; x=1747051565;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCWre+YiiE1M/xjq50/0b5RxI5pgjZUljUe5DxoqVQw=;
 b=XlWTW/rrDw5PAzqJwH10pgiZs7cIscdySApBIYEjN+PA3hGVanPMiUIve9dCVbUtpv
 6uVuKLp8S7ieynMjCRjcGpjtGii0tjrO87NEGZL/lDke/fEEf5ayuk7wuq622Ee9RCbC
 N2ObtHlV0+RupzhaixOYMyyIMXrAsmz8vGmCokBWmgiVf70fNE985K+DInJjMwOMzs+4
 yBlz9fkB00Oa6YcZ0dnlDGXjVlDZlRtIOFenE1ha++bZYaNRfB2IcJMHjn2blHEvQmoF
 syeEgeSMixwSnSsFcQ3ELlvXEmfzREGtUB58u0JkUy+x0bbglSUjF3CQXcfptNbhQKP8
 /gDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKPH5gdIbpZAbSna/1bQkcQaYbSOQKcTc/XkKUUr3n4DW1B+BmrtrSsGlcLgPZ0n5jsKSbFNlVx1Rw@nongnu.org
X-Gm-Message-State: AOJu0YwmCxnx+IGzYx0rbT/fi+mg+ZMDklgSdpkQJ2i5NOLlepwDDp4Z
 AVzAzZX1pIo0Ws8BFTHsXVCLiGwk8svHqvg+oRTplkSXg7k6teUFWXE+RPr6FEQWNM9n3mh70Im
 R41uOG6ZUV6AGnN8s2n5hdQvknuIozu7bT+c/aLLeL4W0FURsXRgi
X-Gm-Gg: ASbGncsLrA68AQ2Xg0n8T+TM4ZA1lOYCKmv4SHjK5g40TJdHmhgJslpjFVPb+yeT72T
 +upa4hEEGsTgbc1jdBQmdd2e+56NEixpAV1J67Qyg/LVZjoPj662Ioht+iIRjbP9N7mJrdcrKzq
 3l0SeQxAahAYdthx1KLxxR9Cqok+KzYngfXxeu5vrVuPxDQk85zxS62GRUFlphsfsHjUuxEUud0
 MgwrajpnkNJ/5KsNEIZAmyVlKC6WHW9T1jnZICir8Oyj2NPBlB98Dd13HIvGpC8wc889p8pzdA1
 pFjcG8JWBqvqDO2hnKTbS8x/3y8+lEpaMyzNBv0m2cMHJ2WOYA==
X-Received: by 2002:a05:600c:1c9e:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-441bbeda8a4mr118766855e9.16.1746446765031; 
 Mon, 05 May 2025 05:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBPbrjBNtyYkk4oNjjgXielF43GcL/WX5YU3vhsZqOhz6pQUJbj08iq2h4UJik1/7ut1gmaw==
X-Received: by 2002:a05:600c:1c9e:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-441bbeda8a4mr118766105e9.16.1746446764601; 
 Mon, 05 May 2025 05:06:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc7d9sm134868285e9.7.2025.05.05.05.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:06:03 -0700 (PDT)
Message-ID: <bfeb9363-a33a-4a2f-b0e9-115beebb1fbf@redhat.com>
Date: Mon, 5 May 2025 14:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] vfio: add unmap_all flag to DMA unmap callback
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-9-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-9-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/25 21:39, John Levon wrote:
> We'll use this parameter shortly; this just adds the plumbing.

I am not sure the 'unmap_all' name reflects what the dma_unmap()
handler does.

> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container-base.c              | 4 ++--
>   hw/vfio/container.c                   | 8 ++++++--
>   hw/vfio/iommufd.c                     | 6 +++++-
>   hw/vfio/listener.c                    | 8 ++++----
>   include/hw/vfio/vfio-container-base.h | 4 ++--
>   5 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 09340fd97a..3ff473a45c 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -85,12 +85,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>   
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
> -                             IOMMUTLBEntry *iotlb)
> +                             IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       g_assert(vioc->dma_unmap);
> -    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
> +    return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
>   }
>   
>   bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 1dfdc312bd..766ba5a275 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -124,7 +124,7 @@ unmap_exit:
>    */
>   static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>                                    hwaddr iova, ram_addr_t size,
> -                                 IOMMUTLBEntry *iotlb)
> +                                 IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -138,6 +138,10 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> +    if (unmap_all) {
> +        return -ENOTSUP;
> +    }
> +
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -205,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>        */
>       if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
>           (errno == EBUSY &&
> -         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
> +         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, false) == 0 &&
>            ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>           return 0;
>       }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 62ecb758f1..6b2764c044 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -46,11 +46,15 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>   
>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                 hwaddr iova, ram_addr_t size,
> -                              IOMMUTLBEntry *iotlb)
> +                              IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>   
> +    if (unmap_all) {
> +        return -ENOTSUP;
> +    }
> +
>       /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
>       return iommufd_backend_unmap_dma(container->be,
>                                        container->ioas_id, iova, size);
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 6f77e18a7a..c5183700db 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -172,7 +172,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           }
>       } else {
>           ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       iotlb->addr_mask + 1, iotlb);
> +                                       iotlb->addr_mask + 1, iotlb, false);
>           if (ret) {
>               error_setg(&local_err,
>                          "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> @@ -201,7 +201,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
>       int ret;
>   
>       /* Unmap with a single call. */
> -    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
> +    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL, false);
>       if (ret) {
>           error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
>                        strerror(-ret));
> @@ -638,7 +638,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>               /* The unmap ioctl doesn't accept a full 64-bit span. */
>               llsize = int128_rshift(llsize, 1);
>               ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                           int128_get64(llsize), NULL);
> +                                           int128_get64(llsize), NULL, false);
>               if (ret) {
>                   error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                                "0x%"HWADDR_PRIx") = %d (%s)",
> @@ -648,7 +648,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>               iova += int128_get64(llsize);
>           }
>           ret = vfio_container_dma_unmap(bcontainer, iova,
> -                                       int128_get64(llsize), NULL);
> +                                       int128_get64(llsize), NULL, false);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 5527e02722..92cee54d11 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -81,7 +81,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              void *vaddr, bool readonly);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
> -                             IOMMUTLBEntry *iotlb);
> +                             IOMMUTLBEntry *iotlb, bool unmap_all);
>   bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section,
>                                          Error **errp);
> @@ -122,7 +122,7 @@ struct VFIOIOMMUClass {
>                      void *vaddr, bool readonly);
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
> -                     IOMMUTLBEntry *iotlb);
> +                     IOMMUTLBEntry *iotlb, bool unmap_all);
>       bool (*attach_device)(const char *name, VFIODevice *vbasedev,
>                             AddressSpace *as, Error **errp);
>       void (*detach_device)(VFIODevice *vbasedev);

Please add documentation to dma_unmap().

Thanks,

C.



