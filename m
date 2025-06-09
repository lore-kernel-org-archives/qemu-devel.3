Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB5C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 20:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOj8f-0006jG-5u; Mon, 09 Jun 2025 16:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOj8d-0006j7-Eg
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOj8b-0001d5-8s
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749501030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MRcEekPpnfvZT/DIWsjOb+kkveYtSWxGSRQrmG4LSUU=;
 b=RuDp985Kw6F617F5l0VOjDA6mdAhSMG4ruHCzcJTDj3Bq4DEE/xiIHDWB4cykRoKw1sofS
 Gmhh+BrKzzS4N79Cq3kvp0tVKjAGaWAa8IdCS+IGXFGaT2iMQg9NvBhEUTsV6S9ctGV+jy
 Qr0yAzfcijw8rSf1BhhubrEkFMMDsEY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-LJlG6vjaPMmpbvfeYWqMDA-1; Mon, 09 Jun 2025 16:30:28 -0400
X-MC-Unique: LJlG6vjaPMmpbvfeYWqMDA-1
X-Mimecast-MFC-AGG-ID: LJlG6vjaPMmpbvfeYWqMDA_1749501028
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450df53d461so37854425e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 13:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749501027; x=1750105827;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRcEekPpnfvZT/DIWsjOb+kkveYtSWxGSRQrmG4LSUU=;
 b=sxlbMw4skHbdRlqsgVVyha+hxmrN1PknLqjDnikicqyc+ZRXEtbfdjAgKI0q11Ha2v
 92AhM91f7Ty+TPWHaZMNPzxyj+ua2Oj8I5YlXguo5NB5IVNP0E9MU8hljMwbjhI0TYkm
 rTiA+1zkfowzDyeCzKDZuEwKNILhdYPfYrOUm/2qKUR6SknmkS+lcM8u4F/zhbvrcSj1
 oZ97Qng5UxaAP1P3y0ardBESRqZY6Ur7JJw5XMWW5+XhJBMaNxWXNil4Cn5l3T+4Ko2r
 vEfkHBG8T6TmToCYJWN2MfamoO/LS2MiHSjio3agMq2MdYAW6CkaoLGK//oXJ5oZAgJ/
 zwsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQ2bF1SIlsCHz7S9eZ6NjwfMW+SKbj4B1box7CMOd9OlTvlvFRbHk8RK0MtWrfbBtKUKbahgXdi3A@nongnu.org
X-Gm-Message-State: AOJu0Yz2FZ/do83itWGMiWMcNPXf150AHvdtLi+pICnRBJoPcxPJm+pJ
 UTM89crGywVP9N97VOQc4kfMtDPvSGUN4Yy3sKQVYLleZBC0nJZwYaAGNPv6BkH+/20qUXQw2ii
 +Rq+9rxav1Tme2TmUe3UXsdkfXUCGDT/WwZwffMy71C+eSqwntqzABRF3
X-Gm-Gg: ASbGncuI8dycsVYFTiOeZaZpTqSkN1ruMm8zeS7Xj1YtmBekPHwf9EbzSOI2CjGAD7O
 ta5UMKIhiIqhSS8p6Iy46DGeFIzENbW0KM4j3KlHKdIxv8Ov8aNNK9owQCrrSquOqD4rb2lHz9I
 sg3TMJ/eDwyYkllCE99fhZ0YdqHjXBgR8VKf3lQfBPMTOEX0Rm6AcmQj+X4sYmZoN3yJs815t2v
 tq46js9M0MzaGSSkz4IJAmPQPYNEiQse20ID0sDG3c/CygdxyS/VfsJ+AJO7UdXabQuiDK2siX7
 x2cSbGgoq7PFYzuKVBIzBFTTVn5H5zo+0FqEMkGf/ebx1QMEnlVTy2m8MDg6
X-Received: by 2002:a05:600c:3e0f:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45201460b91mr127829125e9.14.1749501027511; 
 Mon, 09 Jun 2025 13:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Lj3pJ/mGSbt0RDeVtzFM0NtYNAsL+u2s/ta5Rgnk+Q6bA6nd7a2R9sGHwYKVeDVNpEUjtA==
X-Received: by 2002:a05:600c:3e0f:b0:450:d3c6:84d8 with SMTP id
 5b1f17b1804b1-45201460b91mr127828905e9.14.1749501027070; 
 Mon, 09 Jun 2025 13:30:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53245275esm10339706f8f.76.2025.06.09.13.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 13:30:26 -0700 (PDT)
Message-ID: <d94fc70b-2275-4c69-b163-6a3e3ff40f88@redhat.com>
Date: Mon, 9 Jun 2025 22:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 35/43] vfio/iommufd: register container for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-36-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-36-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 5/29/25 21:24, Steve Sistare wrote:
> Register a vfio iommufd container and device for CPR, replacing the generic
> CPR register call with a more specific iommufd register call.  Add a
> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/hw/vfio/vfio-cpr.h | 12 +++++++
>   include/system/iommufd.h   |  1 +
>   backends/iommufd.c         | 10 ++++++
>   hw/vfio/cpr-iommufd.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c          |  6 ++--
>   hw/vfio/meson.build        |  1 +
>   6 files changed, 112 insertions(+), 2 deletions(-)
>   create mode 100644 hw/vfio/cpr-iommufd.c
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 170a116..b9b77ae 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -15,7 +15,10 @@
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
> +struct VFIODevice;
>   struct VFIOPCIDevice;
> +struct VFIOIOMMUFDContainer;
> +struct IOMMUFDBackend;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> @@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>                                    Error **errp);
>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>   
> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
> +                                         Error **errp);
> +void vfio_iommufd_cpr_unregister_container(
> +    struct VFIOIOMMUFDContainer *container);
> +bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
> +void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
> +
>   int vfio_cpr_group_get_device_fd(int d, const char *name);
>   
>   bool vfio_cpr_container_match(struct VFIOContainer *container,
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index db9ed53..3c58ea8 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>       /*< protected >*/
>       int fd;            /* /dev/iommu file descriptor */
>       bool owned;        /* is the /dev/iommu opened internally */
> +    Error *cpr_blocker;/* set if be does not support CPR */
>       uint32_t users;
>   
>       /*< public >*/
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index ed8bb4c..2e9d6cb 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>           }
>           be->fd = fd;
>       }
> +    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
> +        if (be->owned) {
> +            close(be->fd);
> +            be->fd = -1;
> +        }
> +        return false;
> +    }
>       be->users++;
>   
>       trace_iommufd_backend_connect(be->fd, be->owned, be->users);
> @@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>           be->fd = -1;
>       }
>   out:
> +    if (!be->users) {
> +        vfio_iommufd_cpr_unregister_iommufd(be);
> +    }
>       trace_iommufd_backend_disconnect(be->fd, be->users);
>   }
>   
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> new file mode 100644
> index 0000000..60bd7e8
> --- /dev/null
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/vfio/vfio-cpr.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> +#include "system/iommufd.h"
> +#include "vfio-iommufd.h"
> +
> +static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
> +{
> +    if (!iommufd_change_process_capable(be)) {
> +        if (errp) {
> +            error_setg(errp, "vfio iommufd backend does not support "
> +                       "IOMMU_IOAS_CHANGE_PROCESS");
> +        }
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static const VMStateDescription iommufd_cpr_vmstate = {
> +    .name = "iommufd",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_incoming_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
> +{
> +    Error **cpr_blocker = &be->cpr_blocker;
> +
> +    if (!vfio_cpr_supported(be, cpr_blocker)) {
> +        return migrate_add_blocker_modes(cpr_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +    }
> +
> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
> +
> +    return true;
> +}
> +
> +void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
> +{
> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
> +    migrate_del_blocker(&be->cpr_blocker);
> +}
> +
> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
> +                                vfio_cpr_reboot_notifier,
> +                                MIG_MODE_CPR_REBOOT);
> +
> +    return true;
> +}
> +
> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
> +}
> +
> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
> +{
> +}
> +
> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
> +{
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ca00d08..c690c2c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>       if (!QLIST_EMPTY(&bcontainer->device_list)) {
>           return;
>       }
> -    vfio_cpr_unregister_container(bcontainer);
> +    vfio_iommufd_cpr_unregister_container(container);
>       vfio_listener_unregister(bcontainer);
>       iommufd_backend_free_id(container->be, container->ioas_id);
>       object_unref(container);
> @@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_listener_register;
>       }
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>           goto err_listener_register;
>       }
>   
> @@ -619,6 +619,7 @@ found_container:
>       }
>   
>       vfio_device_prepare(vbasedev, bcontainer, &dev_info);
> +    vfio_iommufd_cpr_register_device(vbasedev);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> @@ -656,6 +657,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       iommufd_cdev_container_destroy(container);
>       vfio_address_space_put(space);
>   
> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);
>   }
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 98134a7..12711fb 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'cpr.c',
> +  'cpr-iommufd.c',

This file should be compiled under CONFIG_IOMMUFD.


Thanks,

C.



>     'cpr-legacy.c',
>     'device.c',
>     'migration.c',


