Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEABFC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezqA-0000B1-E1; Mon, 03 Feb 2025 12:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tezpq-0008EL-Sy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tezpo-0001ia-Qp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738602126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LNU5q6ITE6nwYOJ0ImcMUwCHZhqSC4ghrbMYsgK/G+I=;
 b=J/oSjB4Mq99gbf9BsEFoOvXd3SUeyOvjoj86rVbZZMSr5QsJRU1sFQ7HAsGBe5PUEczO/A
 YMAYfh4rZOHWcx3VJBsiXp8O6Cg7MBkRbrJ6wXp1g+qVKogbOth3cqM6sSBdsuijH4wIO9
 5A+qVNNGcb+JPtRmJC+GCb/ufk7lsLA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-3N7rrX3oN6iAgLgPgPRaeg-1; Mon, 03 Feb 2025 12:02:02 -0500
X-MC-Unique: 3N7rrX3oN6iAgLgPgPRaeg-1
X-Mimecast-MFC-AGG-ID: 3N7rrX3oN6iAgLgPgPRaeg
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6eeef7cb8so800048685a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738602122; x=1739206922;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNU5q6ITE6nwYOJ0ImcMUwCHZhqSC4ghrbMYsgK/G+I=;
 b=P8WAYSIAKQ2qUHcL/+7SKxVr8mlR2gWt45srulSRkom+JwH3ENl2948gL0EFY8hoja
 53CdP/kjVBMqkvJns1rMC0USVMENH/vRbJxkMOeHTZjofcRZS985x1y8PNasnupl+/eT
 tDWF1QBAVYT4KghOfSnFxCNRvG9fZZN3Anhi1vLp4a5bKhNH64Z6sVlPn8DnWptRmaiJ
 pOf1QGKh8UBsAyAuRPtMRGPMdMuK/ynutcD857y8hjrxD1e9OmWdtEKGaRNDeKw6jan3
 tKmu/NXUWDyvSDeZKyDt+YTvGxjWyb7l6v5YYPxRWlPFyEp9t5WqOwLFqab/LOHazT2e
 dpgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/vSW5UjKfNPbIGBXtsMqocE9uO3zdjfHZFAdr3VH/+9c+0agvkKoT/vT6bvg9PPQls3RnnBVA+vho@nongnu.org
X-Gm-Message-State: AOJu0YysRnjwCk4ZkcT3wkBk2FkTaSj9+J1JgUlZru5mPzmDJZHOaZkz
 mFZIV8Xubo6ArIwxxzUOgW/2IJaHa4CTnv5FjqwdCyiujiKp9bzpZJJo2pYkyBB0vvT1aogljbT
 6UjnSPe+TlPFJioJDI48kr4lTc/9ZBxwk7jxz6r6dkkaS5HiDmFa1
X-Gm-Gg: ASbGncup7mEwQD83e4KzizZsmBsYNSYs29ajhGdpvLkUYjebuyl+Bceju71dUmD5hOY
 etM1yeIfw0d6eTT28V3CdvKQdmwFMroGn9NIN3xnnEaAHnrEIMmzXTczY8svQmDKpVeqWMu46QT
 CyzTeq5istqLbIjvc+c5qsR9qQGVLfauSFa0XDCH8dGqtuROXxTImfEYY/BoArN5UaXsPChXU15
 UM2zZ/eNLotWZJE52oDFHICavZ42MLFAM9r8Gdl8PvStT7H3WvN5J9yXOpACOuo7/pFBm7WZR3k
 E2+a++6nDen1/9SqR2V1Eto4dkmDjTydrwyNKXGyg6k=
X-Received: by 2002:a05:620a:408e:b0:7b6:d327:cc47 with SMTP id
 af79cd13be357-7bffccca533mr3568994985a.8.1738602122060; 
 Mon, 03 Feb 2025 09:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6wB2RIAHTO4lECbeS2WqvkqpcF64VdjJa2ZQLMq8gBAS2EtGotbSA6ozje7SbeyhX8rJ7+w==
X-Received: by 2002:a05:620a:408e:b0:7b6:d327:cc47 with SMTP id
 af79cd13be357-7bffccca533mr3568988485a.8.1738602121509; 
 Mon, 03 Feb 2025 09:02:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e312asm51992051cf.43.2025.02.03.09.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:02:01 -0800 (PST)
Message-ID: <bbec2516-883b-4da4-bcff-d67628f09ef4@redhat.com>
Date: Mon, 3 Feb 2025 18:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 04/26] vfio/container: register container for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-5-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> Register a legacy container for cpr-transfer.  Add a blocker if the kernel
> does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c           |  6 ++--
>   hw/vfio/cpr-legacy.c          | 68 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/meson.build           |  3 +-
>   include/hw/vfio/vfio-common.h |  3 ++
>   4 files changed, 76 insertions(+), 4 deletions(-)
>   create mode 100644 hw/vfio/cpr-legacy.c
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4ebb526..a90ce6c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -618,7 +618,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       }
>       bcontainer = &container->bcontainer;
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>           goto free_container_exit;
>       }
>   
> @@ -666,7 +666,7 @@ enable_discards_exit:
>       vfio_ram_block_discard_disable(container, false);
>   
>   unregister_container_exit:
> -    vfio_cpr_unregister_container(bcontainer);
> +    vfio_legacy_cpr_unregister_container(container);
>   
>   free_container_exit:
>       object_unref(container);
> @@ -710,7 +710,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>           VFIOAddressSpace *space = bcontainer->space;
>   
>           trace_vfio_disconnect_container(container->fd);
> -        vfio_cpr_unregister_container(bcontainer);
> +        vfio_legacy_cpr_unregister_container(container);
>           close(container->fd);
>           object_unref(container);
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> new file mode 100644
> index 0000000..d3bbc05
> --- /dev/null
> +++ b/hw/vfio/cpr-legacy.c
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +
> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
> +{
> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
> +        return false;
> +
> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
> +        return false;
> +
> +    } else {
> +        return true;
> +    }
> +}
> +
> +static const VMStateDescription vfio_container_vmstate = {
> +    .name = "vfio-container",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    Error **cpr_blocker = &container->cpr_blocker;
> +
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +        return false;
> +    }
> +
> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
> +        return migrate_add_blocker_modes(cpr_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +    }
> +
> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
> +
> +    return true;
> +}
> +
> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    vfio_cpr_unregister_container(bcontainer);
> +    migrate_del_blocker(&container->cpr_blocker);
> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +}
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index bba776f..5487815 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -5,13 +5,14 @@ vfio_ss.add(files(
>     'container-base.c',
>     'container.c',
>     'migration.c',
> -  'cpr.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>   vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
>     'iommufd.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> +  'cpr.c',
> +  'cpr-legacy.c',
>     'display.c',
>     'pci-quirks.c',
>     'pci.c',
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0c60be5..53e554f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -84,6 +84,7 @@ typedef struct VFIOContainer {
>       VFIOContainerBase bcontainer;
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       unsigned iommu_type;
> +    Error *cpr_blocker;
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
>   
> @@ -258,6 +259,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
>   bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);

I think we should now rename the above routines to reflect what they do :
add/remove a notifier.

> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container);

Thanks,

C.

>   
>   extern const MemoryRegionOps vfio_region_ops;
>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;


