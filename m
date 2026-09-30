Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E74CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoLW-0003Wd-AF; Wed, 30 Sep 2026 03:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBoLQ-0003Vh-LW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xBoLM-0006my-2r
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7NHnjNjsZhLYG+5q078NsBLNawoKBBDmZG7UBsr3EkA=;
 b=hhbWEy/o0JdQK2oCnbj4HD+vPHhUafN8eOw7CUWCm2hV2Sq6wKhMa5gTTNk2/qPEnNm9zD
 uF+GZ/zkaAdsORpcNvMmYobfRjFOb+VUWr2jaYjwk4DcjR11xKR5U2pjQbu+3gZYjGkhyG
 LVTCj7ZqrWTkZA2XJm9UOs+iDIw1Xhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-N1idkVWENfGErB6eCrvYyw-1; Wed, 30 Sep 2026 03:03:03 -0400
X-MC-Unique: N1idkVWENfGErB6eCrvYyw-1
X-Mimecast-MFC-AGG-ID: N1idkVWENfGErB6eCrvYyw_1790751782
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48af605d03fso907366f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790751782; x=1791356582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7NHnjNjsZhLYG+5q078NsBLNawoKBBDmZG7UBsr3EkA=;
 b=iWanEDhVOd4+ViCi7dyCazZvYonbHlx1QYJbpD9dtNBGb1J0zpJBSRKI1aDN8temJN
 /K69UZyE3Oh0X6ndNqzmnZIQivWg97yYGTLl12/iEqibJorMnC43rDhaOYQG+WMSAbvv
 291zpFuYEfxzRu9SU1Tn0Lop9sm90hGFHgK6k76aZJ0VkctqoynvbUjkCcAACxLuhTYz
 XSnbm7niXSilChDguJh6IIVtuv9HcjuzUwpin3XaeD0o5h/a3cLwLB16M/GPhDYnlw2Q
 8HfMZCiVU1Vc4B8H0J9jTyA8JpaCRZnUO28QZrFK59DNoQQs5lSquk6nlcSoAcMjyarg
 9lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751782; x=1791356582;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7NHnjNjsZhLYG+5q078NsBLNawoKBBDmZG7UBsr3EkA=;
 b=fjQJqkgnr1Mw6SwtGIAKBjNa4WGpUMqVyEqB+k+m23xChyyxfZC6KAGhfsKCVyvEu2
 oMfC80Vtci0EqkgkprZHnuAXC8z6NR+Bz/Ix157ctXASi5MhdA6qdfFpuRu3dl6GqTP0
 4dM2KTo3YAa9LNtRPIlJceKFcDh4lr+dG7AOnXOw8iiC9PfDGH9mSzEpE63k7ER01scq
 jkeQwQJbAihmnggbDPi1qjUkATzLOr9UWlQtPiRLHVuVDZuJhW7tfm5IgBdL8jRaAxH8
 /BSLV8DPY7cfXBmf6Gplss8MYrwPZrMKV7EbtKnx+62etEKdijCF3TVaQ26yOHFBedEJ
 8tjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ31zYkmllAH3dgCzCn6pDXjHFRxhy1/8fcFsP8+KMcKsPyKpI8Edjs5wKC3dITe8ABocQWtlhGwJg@nongnu.org
X-Gm-Message-State: AFq9FYLnD0F+RB999fLI5o/8a9z8L3Pw+R2Q9OXpyqN+lHdG2dEU/W8J
 rYfIym/x0TYzx1gXavL2z5Tay0Cpywayii/I/WCuepDsBUJ3f77YOfVcnHDGaVLu7y+0t6wTqV5
 Ukjweu2tbOFwMZAEEfKv2ZabwbeczlfDAiF1e7FaKdRX9wC3yMvPEGvMP
X-Gm-Gg: AYBFou03j2+xkx4MyibVqBp5YtTxgU/dfK0ZmV5x/KnWPAVsjtl9ozbHzgmApJ+sewH
 q6vA0KF4sFscxnhAf9mHllJmu3Nkhqk0C05jtFTawVZRz0IK+Z81zmSzyBLkLwfFd8NVaYLd3fv
 RNCpwiRnyXEcrj4wB6R8G00XdywdUoPQ3KAT3B1m9ELtPlD3kl0HZSY0aVqAZDPJPKT26vabGCx
 96ViMdULggG+KRP11HzUj9l+XlcbhSQFQ3kAex1pFRSGbhdzz6lwcbADks6waAgmPN4L7hppRM4
 2roYfHhQWNpqj2iuSOuNc3GrV9VREeN2dwEj0VZ8brgxbmJu/3ILWkthZwJ184x5S1rxzlOLcJZ
 h8mTl/TpPDprH8/fbubQaPAaZRTik62SyxA4Ey/mw
X-Received: by 2002:a05:6000:2483:b0:488:764c:79ff with SMTP id
 ffacd0b85a97d-48b02557561mr1036783f8f.44.1790751782402; 
 Wed, 30 Sep 2026 00:03:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2483:b0:488:764c:79ff with SMTP id
 ffacd0b85a97d-48b02557561mr1036720f8f.44.1790751781926; 
 Wed, 30 Sep 2026 00:03:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bf85dsm1307856f8f.13.2026.09.30.00.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:03:01 -0700 (PDT)
Message-ID: <e1e65118-9adb-4048-9776-48b72787767b@redhat.com>
Date: Wed, 30 Sep 2026 09:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/17] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-1-12bcf1c0b84a@virtuozzo.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-1-12bcf1c0b84a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 15f2a513501..45fd2e44c7f 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -85,7 +85,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>           if (cpr_is_incoming()) {
>               be->fd = cpr_find_fd(name, 0);
>           } else {
> -            cpr_save_fd(name, 0, be->fd);
> +            if (!cpr_save_fd(name, 0, be->fd, errp)) {
> +                return;
> +            }
>           }
>       } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>           error_setg(errp, "/dev/iommu does not exist"
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index 7ac7b372145..50ca5a3a7ea 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -847,13 +847,8 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
>   
> -    fd = vfio_cpr_group_get_device_fd(group->fd, name);
> +    fd = vfio_cpr_group_get_device_fd(group, name, errp);
>       if (fd < 0) {
> -        error_setg_errno(errp, errno, "error getting device from group %d",
> -                         group->groupid);
> -        error_append_hint(errp,
> -                      "Verify all devices in group %d are bound to vfio-<bus> "
> -                      "or pci-stub and not already in use\n", group->groupid);
>           return false;
>       }
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 2d40d8baeaf..807ffacdbc9 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -254,17 +254,33 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
>                                                   &vrdl->listener) == 0;
>   }
>   
> -int vfio_cpr_group_get_device_fd(int d, const char *name)
> +int vfio_cpr_group_get_device_fd(VFIOGroup *group, const char *name,
> +                                 Error **errp)
>   {
> +    ERRP_GUARD();
>       const int id = 0;
>       int fd = cpr_find_fd(name, id);
>   
> +    if (fd >= 0) {
> +        return fd;
> +    }
> +
> +    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>       if (fd < 0) {
> -        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, id, fd);
> -        }
> +        error_setg_errno(errp, errno, "error getting device from group %d",
> +                         group->groupid);
> +        error_append_hint(errp,
> +                          "Verify all devices in group %d are bound to "
> +                          "vfio-<bus> or pci-stub and not already in use\n",
> +                          group->groupid);
> +        return -1;
>       }
> +
> +    if (!cpr_save_fd(name, id, fd, errp)) {
> +        close(fd);
> +        return -1;
> +    }
> +
>       return fd;
>   }
>   
> @@ -291,6 +307,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
>        */
>       cpr_delete_fd("vfio_container_for_group", group->groupid);
>       close(fd);
> -    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd,
> +                &error_abort);
>       return true;
>   }
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index ffa4f8e099d..6e1659dcddc 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -32,11 +32,11 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>   #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>       g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>   
> -void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> -                             int fd)
> +bool vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> +                             int fd, Error **errp)
>   {
>       g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> -    cpr_save_fd(fdname, nr, fd);
> +    return cpr_save_fd(fdname, nr, fd, errp);
>   }
>   
>   int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f0698..ad13f2306f1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>       }
>   
>       fd = event_notifier_get_fd(e);
> -    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
> +    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
> +        event_notifier_cleanup(e);
> +        return false;
> +    }
>       return true;
>   }
>   
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index ecabe0c747d..9157a4ac649 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -60,7 +60,8 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>   void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>   void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>   
> -int vfio_cpr_group_get_device_fd(int d, const char *name);
> +int vfio_cpr_group_get_device_fd(struct VFIOGroup *group, const char *name,
> +                                 Error **errp);
>   
>   bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
>                                 struct VFIOGroup *group, int fd);
> @@ -71,8 +72,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
>   bool vfio_cpr_ram_discard_replay_populated(
>       struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
>   
> -void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> -                             int nr, int fd);
> +bool vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                             int nr, int fd, Error **errp);
>   int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>                               int nr);
>   void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,

The vfio part LGTM,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


