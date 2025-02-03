Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEB8C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf18d-0000Bz-3k; Mon, 03 Feb 2025 13:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tf18c-0000Bf-0q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tf18Z-0002gX-Tq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738607134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BIpaOPk4VDZ/rOG114IbkGjg3aVjJJaJP3Od6avLEQA=;
 b=A2YRQLLSjef01x4gCQRstbEJYypqC22zp+tpbkJHnfV4tOcgR1ZAD1WfDmsRFN4loTe7Aj
 9fQ4sH7k2xe3B3ufl5JcdBi51ObPicoV49o5lmQk1U29mQ5KOL/wKCiPpa8FuNP2tdONcC
 64g9x11Bu/m7p7BCj8houb3hlga+BfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-OK3TTtAfOy-VUMPSSTZwjQ-1; Mon, 03 Feb 2025 13:25:33 -0500
X-MC-Unique: OK3TTtAfOy-VUMPSSTZwjQ-1
X-Mimecast-MFC-AGG-ID: OK3TTtAfOy-VUMPSSTZwjQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso25230375e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738607132; x=1739211932;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIpaOPk4VDZ/rOG114IbkGjg3aVjJJaJP3Od6avLEQA=;
 b=pWWBF6+aynTUBU6tn93qSdsIr05SYo/YHlKdvQGFIS5eFQ+Gv26Hh6Z62HWmI8KWSO
 aBM8V89181Ps99ARydxA87bWMEByyjNsDb+llkRC9WcT43XYGsEviH56iWV8gZXLxhUF
 GjfOU1wCxHZ416SC3EI8NCTY+L//9rwYpXz9BO07H3wVDKYOPcjUcOovHMikSh8QO6Kw
 EzWVwgOuYBk+Uwsc1pEG5liPv0WskHFWSx0PWKnY9ellHlg6c2XUwK1UETqJHBFxQ7Wh
 rP0eDuIcPsu5TGf6skOfL9mJlW6W5kbX3yGm/g5//UOsSTT84owsXQmmUToA9ZvDuhQ1
 nZYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9a9htPlBpcX6Gqijx6BQGTLCLgkx6DGRz83cJXjZ2ajxHQvbjaQ+Ib/D6++1o14OhZWJBwzH/1bAf@nongnu.org
X-Gm-Message-State: AOJu0YzffepP3esk71exQm3M6EWSqxqf1G9sPMr9ody0ugceziJieMTI
 5GTe8au5p1/2kwIwXl40SU84b7LDyfXQ8EXpePBxC9yASq3w3lYpydIVXKgIugpDFwYUMxe4Ksa
 YKKhHG1EpbI8PZw6awmh/I8iU93dvgCmOjDug9CmjjnyqutJ+sA7A
X-Gm-Gg: ASbGncv0+hEPbD9fIRFCv4RUk5ZRw9o7n7MvOfZEWV/DBKrSOhh7zJL3WQ/Yi97OZcA
 nmWNXKEusol7XZ46SSYIP8X7+dpHPhVGoIQVIM8N0HwVe2mNyJc1m3HVa8q7EPN936UUmO6EUD3
 ce901vU/Eg2P3uFA7y7AOUC+ck+bqudFgn2+qQuZNKvM263HxagjyDd0t/ptSdcDrEY+1JibkOP
 /OyRBP0LaYmJkWoSKBGGltYt6lsKEtm91ALWz1HVwQeD6rrdA4S63fstGqCmQUBE/NsfDHYCK3N
 al6j8kxGWbAH9rRPSsOFSxMoIeiU2UI5XWf3mxqrDW0=
X-Received: by 2002:a05:600c:1c1a:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-438dc3c4694mr208638745e9.18.1738607131746; 
 Mon, 03 Feb 2025 10:25:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5oEhdbjQYIVe7gfflo1SMgvrev1nafXb0UXzifxiaizKIkmynXv6UH2ZYPbgskp1gbwdC1g==
X-Received: by 2002:a05:600c:1c1a:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-438dc3c4694mr208638575e9.18.1738607131328; 
 Mon, 03 Feb 2025 10:25:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f14esm161249165e9.34.2025.02.03.10.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:25:30 -0800 (PST)
Message-ID: <d5ec094e-490d-4de4-ac3a-66b1bdae11e2@redhat.com>
Date: Mon, 3 Feb 2025 19:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 06/26] vfio/container: preserve DMA mappings
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-7-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Preserve DMA mappings during cpr-transfer.
> 
> In the container pre_save handler, suspend the use of virtual addresses
> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will
> be remapped at a different VA after exec.  DMA to already-mapped pages
> continues.
> 
> Because the vaddr is temporarily invalid, mediated devices cannot be
> supported, so add a blocker for them.  This restriction will not apply
> to iommufd containers when CPR is added for them in a future patch.
> 
> In new QEMU, do not register the memory listener at device creation time.
> Register it later, in the container post_load handler, after all vmstate
> that may affect regions and mapping boundaries has been loaded.  The
> post_load registration will cause the listener to invoke its callback on
> each flat section, and the calls will match the mappings remembered by the
> kernel.  Modify vfio_dma_map (which is called by the listener) to pass the
> new VA to the kernel using VFIO_DMA_MAP_FLAG_VADDR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c           | 44 +++++++++++++++++++++++++++++++++++++++----
>   hw/vfio/cpr-legacy.c          | 32 +++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-common.h |  3 +++
>   3 files changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 81d0ccc..2b5125e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -32,6 +32,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "migration/cpr.h"
> +#include "migration/blocker.h"
>   #include "pci.h"
>   
>   VFIOGroupList vfio_group_list =
> @@ -132,6 +133,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       int ret;
>       Error *local_err = NULL;
>   
> +    assert(!container->reused);
> +
>       if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> @@ -183,12 +186,24 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                                     bcontainer);
>       struct vfio_iommu_type1_dma_map map = {
>           .argsz = sizeof(map),
> -        .flags = VFIO_DMA_MAP_FLAG_READ,
>           .vaddr = (__u64)(uintptr_t)vaddr,
>           .iova = iova,
>           .size = size,
>       };
>   
> +    /*
> +     * Set the new vaddr for any mappings registered during cpr load.
> +     * Reused is cleared thereafter.
> +     */
> +    if (container->reused) {
> +        map.flags = VFIO_DMA_MAP_FLAG_VADDR;
> +        if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
> +            goto fail;
> +        }
> +        return 0;
> +    }

This is a bit ugly.

When reaching routine vfio_attach_device(), could we detect that CPR is
in progress and replace the 'VFIOIOMMUClass *' temporarily with a set of
CPR specific handlers ?


> +
> +    map.flags = VFIO_DMA_MAP_FLAG_READ;
>       if (!readonly) {
>           map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>       }
> @@ -205,7 +220,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>           return 0;
>       }
>   
> -    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
> +fail:
> +    error_report("vfio_dma_map %s (iova %lu, size %ld, va %p): %s",
> +        (container->reused ? "VADDR" : ""), iova, size, vaddr,
> +        strerror(errno));
> +


FYI, I am currently trying to remove this error report.


>       return -errno;
>   }
>   
> @@ -689,8 +708,17 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       group->container = container;
>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>   
> -    bcontainer->listener = vfio_memory_listener;
> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> +    /*
> +     * If reused, register the listener later, after all state that may
> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
> +     * the listener will invoke its callback on each flat section and call
> +     * vfio_dma_map to supply the new vaddr, and the calls will match the
> +     * mappings remembered by the kernel.
> +     */
> +    if (!reused) {
> +        bcontainer->listener = vfio_memory_listener;
> +        memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> +    }

oh ! This is an important change. Please move in its own patch.

>       if (bcontainer->error) {
>           error_propagate_prepend(errp, bcontainer->error,
> @@ -1002,6 +1030,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           return false;
>       }
>   
> +    if (vbasedev->mdev) {
> +        error_setg(&vbasedev->cpr_mdev_blocker,
> +                   "CPR does not support vfio mdev %s", vbasedev->name);
> +        migrate_add_blocker_modes(&vbasedev->cpr_mdev_blocker, &error_fatal,
> +                                  MIG_MODE_CPR_TRANSFER, -1);
> +    }

same here, the cpr blocker for mdev devices should be in its own patch.


>       bcontainer = &group->container->bcontainer;
>       vbasedev->bcontainer = bcontainer;
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
> @@ -1018,6 +1053,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>       QLIST_REMOVE(vbasedev, container_next);
>       vbasedev->bcontainer = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
> +    migrate_del_blocker(&vbasedev->cpr_mdev_blocker);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);
>   }
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index ce6f14e..f3a31d1 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -14,6 +14,21 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   
> +static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
> +{
> +    struct vfio_iommu_type1_dma_unmap unmap = {
> +        .argsz = sizeof(unmap),
> +        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
> +        .iova = 0,
> +        .size = 0,
> +    };
> +    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> +        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> @@ -29,12 +44,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>       }
>   }
>   
> +static int vfio_container_pre_save(void *opaque)
> +{
> +    VFIOContainer *container = opaque;
> +    Error *err = NULL;
> +
> +    if (!vfio_dma_unmap_vaddr_all(container, &err)) {
> +        error_report_err(err);

We should modify vmstate_save_state_v() to call .pre_save() handlers
with an Error ** parameter.


Thanks,

C.



> +        return -1;
> +    }
> +    return 0;
> +}
> +
>   static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIOGroup *group;
>       VFIODevice *vbasedev;
>   
> +    bcontainer->listener = vfio_memory_listener;
> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>       container->reused = false;
>   
>       QLIST_FOREACH(group, &container->group_list, container_next) {
> @@ -49,6 +79,8 @@ static const VMStateDescription vfio_container_vmstate = {
>       .name = "vfio-container",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
> +    .pre_save = vfio_container_pre_save,
>       .post_load = vfio_container_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a435a90..1e974e0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -143,6 +143,7 @@ typedef struct VFIODevice {
>       unsigned int flags;
>       VFIOMigration *migration;
>       Error *migration_blocker;
> +    Error *cpr_mdev_blocker;
>       OnOffAuto pre_copy_dirty_page_tracking;
>       OnOffAuto device_dirty_page_tracking;
>       bool dirty_pages_supported;
> @@ -310,6 +311,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>   
> +void vfio_listener_register(VFIOContainerBase *bcontainer);
> +
>   /* Returns 0 on success, or a negative errno. */
>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);


