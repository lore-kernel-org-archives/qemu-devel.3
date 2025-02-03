Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76417C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0YZ-0005hi-60; Mon, 03 Feb 2025 12:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tf0YW-0005hQ-Ek
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tf0YS-0007NZ-G1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738604893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AGRwcmZVKuaWA3ZGaJ7RzqZnFp5uJ21l29D1N/AmLA4=;
 b=Y6kP5C9mTOmarb6jMrXxEWYkwpT5arYUEWvzLH47Fn8/ZgMMDFxNM02yESZ+JEZfMjIrAm
 bZYX+K4TVggf5uV2qr5fC38WNro2dBn0CP8pqEZm4hRCzsAv5oJ4m2Qntye73t/IsbXIrH
 mTo5ngrT9ik5xkgfK7O4DVfrgJGVZ88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-MDeodwohN567dyyWAszb_w-1; Mon, 03 Feb 2025 12:48:11 -0500
X-MC-Unique: MDeodwohN567dyyWAszb_w-1
X-Mimecast-MFC-AGG-ID: MDeodwohN567dyyWAszb_w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso23241135e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604889; x=1739209689;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGRwcmZVKuaWA3ZGaJ7RzqZnFp5uJ21l29D1N/AmLA4=;
 b=uuW+NdI68DYqjIbupHWze7anxJ41+tT2PS0FEnCnADHPYNS6aufXXwrJGOBkroAGSF
 YWBAzgtsAd+DyKGOSQkHfzFltZKGGzGTpLTnfmzuPQzc+Jv34pG2vYn4SHIa3sgciK/u
 2dbP3+MQX7GUW4TI+Hm5kAQeiSqCFUlsvHYq0/p8FqNmhJy0UrUelLQaEdPamw6QGCap
 x+4Gj46F3+spod6RfOIuuY9s8ZWZQDwHMOcoGqxNjcUuCAK2K6HgbYz2esGW6yOAjQrq
 xYebvc0sQamkIo/iIpvcK+EsKdMcp/MKdCHNssFT2tNJHBDwVYbHcFI+sVDPkbft8ph/
 MHDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKeVqG9Jsm2DugWfhcUiMDYUpRw28BfzpsI7wftOVBi9DIXiNfBcxsGNWJ1yWX8kha1jEtS4lfSdJc@nongnu.org
X-Gm-Message-State: AOJu0Yy7u+bSySTt8xgcN7tnO+7vHt2kk9Hbh/cdj8PJ5yj93qnXaOaY
 GuoJRdWfo9GZjEMfBz8v+505ULB5mflSYQEUVqngcahyBkgzN8r+ULBi2DogmwUOSfIlZxSry0D
 8/Rse9yTkoFYZFFdJmv60bpzY6PE4iXzkJvOrUTQBEPRy0EbaMvCmN2suUwv/
X-Gm-Gg: ASbGncvMyrfXxfyKoR4FqdxE7XWYkwwUAY/e79faoZeJvTVIRzW1dlX8i5Q8CMbJ/UH
 m9oDPBjaNtsj4Grov3S2XliD9d7+3lZX7e73b9Ooz+8OktCqBdWceczCiB3tdJU9anMDsgOFLXx
 tOTSFPNBOXpGsQ65IWWu9gMQ09ercgaAKmh1Pn5VFMb97I0WWBKLv8tnAlAjxb9GfE5FsPas5CK
 H0lQPrittoWDyL4nbPk3ASAaOVwlftQsc2LxpmaL8bPjpZVSfPB3K8JzpPS8+Y/tOWS8MiMHJuR
 SKJkEgi82lZxcpJx7B2dCDPFIEFO91lwbF32hhIX1iM=
X-Received: by 2002:a5d:64a6:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38c5195e09emr19332799f8f.14.1738604889185; 
 Mon, 03 Feb 2025 09:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzlo4r91aeFaK9HI9hw79UuV425pP2eZlQ5fh294TDa3G2mrAwZckVFqzakR6MjGCEXCl8ng==
X-Received: by 2002:a5d:64a6:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38c5195e09emr19332778f8f.14.1738604888747; 
 Mon, 03 Feb 2025 09:48:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc13146sm195823645e9.4.2025.02.03.09.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:48:08 -0800 (PST)
Message-ID: <692bd42e-b9c0-4727-bfdc-339a3bd53162@redhat.com>
Date: Mon, 3 Feb 2025 18:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 05/26] vfio/container: preserve descriptors
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-6-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-6-git-send-email-steven.sistare@oracle.com>
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
> At vfio creation time, save the value of vfio container, group, and device
> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
> the saved descriptors, and remembers the reused status for subsequent
> patches.  The reused status is cleared when vmstate load finishes.
> 
> During reuse, device and iommu state is already configured, so operations
> in vfio_realize that would modify the configuration, such as vfio ioctl's,
> are skipped.  The result is that vfio_realize constructs qemu data
> structures that reflect the current state of the device.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c           | 105 ++++++++++++++++++++++++++++++++++--------
>   hw/vfio/cpr-legacy.c          |  17 +++++++
>   include/hw/vfio/vfio-common.h |   2 +
>   3 files changed, 105 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a90ce6c..81d0ccc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -31,6 +31,7 @@
>   #include "system/reset.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> +#include "migration/cpr.h"
>   #include "pci.h"
>   
>   VFIOGroupList vfio_group_list =
> @@ -415,12 +416,28 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>   }
>   
>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
> -                                            Error **errp)
> +                                            bool reused, Error **errp)

Please rename 'reused' to 'cpr_reused'. We should know what this parameter
is for and I don't see any other use than CPR.

>   {
>       int iommu_type;
>       const char *vioc_name;
>       VFIOContainer *container;
>   
> +    /*
> +     * If container is reused, just set its type and skip the ioctls, as the
> +     * container and group are already configured in the kernel.
> +     * VFIO_TYPE1v2_IOMMU is the only type that supports reuse/cpr.
> +     */
> +    if (reused) {
> +        if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
> +            iommu_type = VFIO_TYPE1v2_IOMMU;
> +            goto skip_iommu;
> +        } else {
> +            error_setg(errp, "container was reused but VFIO_TYPE1v2_IOMMU "
> +                             "is not supported");
> +            return NULL;
> +        }
> +    }
> +

Can we use 'iommu_type' below instead and avoid VFIO_CHECK_EXTENSION
ioctl ? and then set the iommu unless CPR reused is set.

>       iommu_type = vfio_get_iommu_type(fd, errp);
>       if (iommu_type < 0) {
>           return NULL;
> @@ -430,10 +447,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>           return NULL;
>       }
>   
> +skip_iommu:

I think we can avoid this 'skip_iommu' label with some minor refactoring.

>       vioc_name = vfio_get_iommu_class_name(iommu_type);
>   
>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>       container->fd = fd;
> +    container->reused = reused;
>       container->iommu_type = iommu_type;
>       return container;
>   }
> @@ -543,10 +562,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       VFIOContainer *container;
>       VFIOContainerBase *bcontainer;
>       int ret, fd;
> +    bool reused;

cpr_reused.

>       VFIOAddressSpace *space;
>       VFIOIOMMUClass *vioc;
>   
>       space = vfio_get_address_space(as);
> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
> +    reused = (fd > 0);


hmm, so we are deducing from the existence of a CprFd state element
that we are doing a live update of the VM.  This seems to me to be a
somewhat quick heuristic.

Isn't there a global helper ? Isn't the VM aware that it's being
restarted after a live update ? I am not familiar with the CPR
sequence.

>       /*
>        * VFIO is currently incompatible with discarding of RAM insofar as the
> @@ -579,28 +601,52 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>        * details once we know which type of IOMMU we are using.
>        */
>   
> +    /*
> +     * If the container is reused, then the group is already attached in the
> +     * kernel.  If a container with matching fd is found, then update the
> +     * userland group list and return.  If not, then after the loop, create
> +     * the container struct and group list.
> +     */
> +
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOContainer, bcontainer);
> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> -            ret = vfio_ram_block_discard_disable(container, true);
> -            if (ret) {
> -                error_setg_errno(errp, -ret,
> -                                 "Cannot set discarding of RAM broken");
> -                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
> -                          &container->fd)) {
> -                    error_report("vfio: error disconnecting group %d from"
> -                                 " container", group->groupid);
> -                }
> -                return false;
> +
> +        if (reused) {
> +            if (container->fd != fd) {
> +                continue;
>               }
> -            group->container = container;
> -            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> +            continue;
> +        }
> +
> +        /* Container is a match for the group */
> +        ret = vfio_ram_block_discard_disable(container, true);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                             "Cannot set discarding of RAM broken");
> +            if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
> +                      &container->fd)) {
> +                error_report("vfio: error disconnecting group %d from"
> +                             " container", group->groupid);
> +
> +            }
> +            goto delete_fd_exit;
> +        }
> +        group->container = container;
> +        QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +        if (!reused) {
>               vfio_kvm_device_add_group(group);
> -            return true;
> +            cpr_save_fd("vfio_container_for_group", group->groupid,
> +                        container->fd);
>           }
> +        return true;
> +    }

The above changes are difficult to understand and I really don't like
these 'if (reused)' code sequences scattered all over the place. It
would make reading and long term maintenance easier if we could
introduce helpers to hide the "CPR reuse" aspect of the machine
initialization phase.


> +    /* No matching container found, create one */
> +    if (!reused) {
> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>       }
> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);>       if (fd < 0) {
>           goto put_space_exit;
>       }
> @@ -612,11 +658,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,>           goto close_fd_exit;
>       }
>   
> -    container = vfio_create_container(fd, group, errp);
> +    container = vfio_create_container(fd, group, reused, errp);
>       if (!container) {
>           goto close_fd_exit;
>       }
>       bcontainer = &container->bcontainer;
> +    container->reused = reused;

that's done already in vfio_create_container()

>   
>       if (!vfio_legacy_cpr_register_container(container, errp)) {
>           goto free_container_exit;
> @@ -652,6 +699,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       }
>   
>       bcontainer->initialized = true;
> +    cpr_resave_fd("vfio_container_for_group", group->groupid, fd);

can't we have an helper routine to open/reuse/resave the fd ? Same
comment for vfio_get_device() and vfio_get_group()

>   
>       return true;
>   listener_release_exit:
> @@ -677,6 +725,8 @@ close_fd_exit:
>   put_space_exit:
>       vfio_put_address_space(space);
>   
> +delete_fd_exit:
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);

Another exit label. That's the 7th in vfio_connect_container() ...
This is becoming too complex, we need to refactor first.


Thanks,

C.



>       return false;
>   }
>   
> @@ -688,6 +738,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   
>       QLIST_REMOVE(group, container_next);
>       group->container = NULL;
> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>   
>       /*
>        * Explicitly release the listener first before unset container,
> @@ -741,7 +792,12 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       group = g_malloc0(sizeof(*group));
>   
>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
> -    group->fd = qemu_open(path, O_RDWR, errp);
> +
> +    group->fd = cpr_find_fd("vfio_group", groupid);
> +    if (group->fd < 0) {
> +        group->fd = qemu_open(path, O_RDWR, errp);
> +    }
> +
>       if (group->fd < 0) {
>           goto free_group_exit;
>       }
> @@ -769,6 +825,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>       }
>   
>       QLIST_INSERT_HEAD(&vfio_group_list, group, next);
> +    cpr_resave_fd("vfio_group", groupid, group->fd);
>   
>       return group;
>   
> @@ -794,6 +851,7 @@ static void vfio_put_group(VFIOGroup *group)
>       vfio_disconnect_container(group);
>       QLIST_REMOVE(group, next);
>       trace_vfio_put_group(group->fd);
> +    cpr_delete_fd("vfio_group", group->groupid);
>       close(group->fd);
>       g_free(group);
>   }
> @@ -803,8 +861,14 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>   {
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
> +    bool reused;
> +
> +    fd = cpr_find_fd(name, 0);
> +    reused = (fd >= 0);
> +    if (!reused) {
> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
> +    }
>   
> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "error getting device from group %d",
>                            group->groupid);
> @@ -849,6 +913,8 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>       vbasedev->num_irqs = info->num_irqs;
>       vbasedev->num_regions = info->num_regions;
>       vbasedev->flags = info->flags;
> +    vbasedev->reused = reused;
> +    cpr_resave_fd(name, 0, fd);
>   
>       trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
>   
> @@ -865,6 +931,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>       QLIST_REMOVE(vbasedev, next);
>       vbasedev->group = NULL;
>       trace_vfio_put_base_device(vbasedev->fd);
> +    cpr_delete_fd(vbasedev->name, 0);
>       close(vbasedev->fd);
>   }
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index d3bbc05..ce6f14e 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -29,10 +29,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>       }
>   }
>   
> +static int vfio_container_post_load(void *opaque, int version_id)
> +{
> +    VFIOContainer *container = opaque;
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    container->reused = false;
> +
> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            vbasedev->reused = false;
> +        }
> +    }
> +    return 0;
> +}
> +
>   static const VMStateDescription vfio_container_vmstate = {
>       .name = "vfio-container",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .post_load = vfio_container_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
>           VMSTATE_END_OF_LIST()
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 53e554f..a435a90 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -85,6 +85,7 @@ typedef struct VFIOContainer {
>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>       unsigned iommu_type;
>       Error *cpr_blocker;
> +    bool reused;
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
>   
> @@ -135,6 +136,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       bool migration_events;
> +    bool reused;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;


