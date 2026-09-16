Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDBCC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6l0V-0004Jk-8a; Wed, 16 Sep 2026 04:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6l0U-0004JQ-1l
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6l0R-00020V-2X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789547317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y9aomF5UjsiAjOHszeiwlBzzH3cEWz7LBPwOfKjRpog=;
 b=C9meCd576YCHgapISNIrjOoAiTH1Ge3f3EBrpKM7fLPKDQgah9eMm4iV0rke4emqlPYQFL
 QwktmBCwTb816JfdR5uv+ZlzJ7tB1VazemoEL/VvsC+hKU8267GoZcbr2Dek0A3NPSZp+8
 XiIWFXbF7M2wTzMCWetyIeSoqsnKEMQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ZIIBWWUbPR2YNwyfkTN9jA-1; Wed, 16 Sep 2026 04:28:34 -0400
X-MC-Unique: ZIIBWWUbPR2YNwyfkTN9jA-1
X-Mimecast-MFC-AGG-ID: ZIIBWWUbPR2YNwyfkTN9jA_1789547313
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c293bac1764so375151366b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789547313; x=1790152113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y9aomF5UjsiAjOHszeiwlBzzH3cEWz7LBPwOfKjRpog=;
 b=Mw0mwzAQ+ror1yTdU7vVhD0hI+YLez3Y4NiNpBtA616rkpV8m+srNBACYqxlzLj29u
 XqF4Jq9hf0YVHbDk4k6BB2d3Xwg8N/hQfMfiTRokXvgCzZuEWPwr8C/aSuDfHtADrYV1
 d8CBvNTMsKiBQyAprEh8/iDVLBDatBEp4iqBBA3GcStqeOkOIi/1nfuoJ98BfcS0IIoZ
 3IB6jNdmToVEJRy2Ug9kZ/yXO3s+o6u4+AL+JiKDct3lWpAzOWcknOnWJqofynNi6DG9
 9DwY4O52TQ6eSgmn5i+aouoUBmJfZE4qZ3jbXbYhxj5pCRqIP9F16xiWWTrgg8UtCiB9
 LJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789547313; x=1790152113;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y9aomF5UjsiAjOHszeiwlBzzH3cEWz7LBPwOfKjRpog=;
 b=d3frfEJF4hxUusi/zXWIdIxbP3/bfclX+GNL6lYGWihE5oVZA0BEHf0iSUGg5Zj4y6
 kxgCATYpAqSBvHf2IctMDUXLB1tsocoBzqwSgvf17hrkz96Hew4DEp7nIt844EkSwiiQ
 KHfq5ExWBOUbCkINb/felqm98UVR8LyTuR95yOgM6saI6YWt3QzQMdZNasL8zyisNpjs
 qHufa2CpTnJ5qLwbzW6L+ZCCCjRN+fLqbYakFXkD85VUXjNSUzfhWegsGABqe8wSb6TG
 gNirPgadC6UKzW3/5a1uxSerk+Cid0dNNsry2KELnvED4E/t5j5IFNS47BVfFEss3s9F
 PGxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnYXMIRaM/afqLxh0MWE73ofWa23p+fKUUHb8GRtlVQzfl7YyxqJy7+kq0TY/bfKQsLNLS9ttR1llT@nongnu.org
X-Gm-Message-State: AFuF++nL+/uAy2QjZpQnMlOCtItUtgoGJp1cO9llSI5jIKq0JsDaujlR
 aHbOirW5BrXi8fXecqt45JHsqokr0O/HYVs/sREugfge7a9DN0OEfA6bHx5ZYGx/pcBleqDt41s
 +fAhWURjycqNeMJk/AOI/GOo9Ji2u7mCAmIf932coDGXHByAkyh93O9m3
X-Gm-Gg: AYBFou2K8JCIHIb4slyRbiNwAndL9yvaGJ+FI1n7XQtSgvHg1D1J0cNK0F8uDtrZ5mn
 khmeiDp+4EtvHyFB04HzH4lQqmkv6XkzZMEukLcS09J5z6AkiSxxD3nnQudq33kiG8+vcigcDjS
 G35i3UVyyR/mMrVQfjRtmfL+7JKL/uJqcWWbukV467qRMFKTKGKbMnYE6yCMV+RL3bHf0s8mTKQ
 KXYhSvG3qcp+fnrsI8//GmXeG0JedFxk6y1QqnE/osAq6H4aQph+mPvPHu7KTjNoQ+dPbsTvMSg
 5SmfHis4GF/SYHdimzZ5RN6cwkbOoT73pE2/wzDdFMroTztm/CwBtzbvK6oUJ3z0sOtWWVlLcRn
 AcorTH39qhlhINMTLsesUY8Rn3ya/7CnSUD54F8j2pw==
X-Received: by 2002:a05:6402:52c4:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6aa22402ed1mr2217886a12.11.1789547312679; 
 Wed, 16 Sep 2026 01:28:32 -0700 (PDT)
X-Received: by 2002:a05:6402:52c4:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6aa22402ed1mr2217841a12.11.1789547312158; 
 Wed, 16 Sep 2026 01:28:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2406d6sm1072896a12.12.2026.09.16.01.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:28:31 -0700 (PDT)
Message-ID: <8a44f72e-2d00-4663-b348-8ca174ab276e@redhat.com>
Date: Wed, 16 Sep 2026 10:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de,
 den@openvz.org, sgarzare@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-1-4d31b2dc6afd@virtuozzo.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-1-4d31b2dc6afd@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 9/15/26 22:59, Andrey Drobyshev wrote:
> In its current form, the mechanism for saving CPR FDs into hash table
> has flaws.
> 
> The CPR fd hash table uses the same CprFd for both key and value, and
> is created with a key destroy function.  Inserting a second element
> with the same (name, id) key leads to a use after free.  According to
> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
> value with the new element, and destroys the new key.  Thus when
> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
> 
>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */
> 
> Any subsequent cpr_find_fd() for that key then returns freed memory.
> 
> This is reachable whenever two CPR-aware objects register fds under the
> same name, and it happens long before an actual CPR, since cpr_save_fd()
> is typically called from .realize(), i.e. at boot time.
> 
> Apart from the UAF itself, when the user decides to perform CPR migration,
> on CPR target we'd get corrupted FD from the hash table and fail somewhere
> in .realize() for affected devices.
> 
> As a solution, let's altogether prohibit adding CprFds with duplicate
> keys.  Since FDs are being registered for a subsequent CPR right at the
> startup in .realize(), that'll allow us to error out and exit QEMU (or
> fail a device hotplug op) gracefully instead of delaying potential
> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
> instead of 'void' and provide an 'errp' argument to it.  That way caller
> becomes responsible for checking the return value and propagating the
> error.
> 
> Also update all the callers to use the adjusted interface to keep things
> compilable and bisectable.
> 
> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
> 
> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   backends/hostmem-memfd.c   |  5 ++++-
>   backends/hostmem-shm.c     |  5 ++++-
>   backends/iommufd.c         |  4 +++-
>   hw/vfio/container-legacy.c | 17 +++++++++-----
>   hw/vfio/cpr-legacy.c       | 10 +++++----
>   hw/vfio/cpr.c              |  6 ++---
>   hw/vfio/pci.c              |  5 ++++-
>   include/hw/vfio/vfio-cpr.h |  6 ++---
>   include/migration/cpr.h    |  2 +-
>   migration/cpr.c            | 55 ++++++++++++++++++++++++++++++----------------
>   system/physmem.c           |  5 +++--
>   11 files changed, 78 insertions(+), 42 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index e21c5a3f2e2..a95a4368a9e 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -54,7 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       if (fd == -1) {
>           return false;
>       }
> -    cpr_save_fd(name, 0, fd);
> +    if (!cpr_save_fd(name, 0, fd, errp)) {
> +        close(fd);
> +        return false;
> +    }
>   
>   have_fd:
>       backend->aligned = true;
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index 806e2670e03..2fa7b823a62 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -48,7 +48,10 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>       if (fd < 0) {
>           return false;
>       }
> -    cpr_save_fd(backend_name, 0, fd);
> +    if (!cpr_save_fd(backend_name, 0, fd, errp)) {
> +        close(fd);
> +        return false;
> +    }
>   
>   have_fd:
>       /* Let's do the same as memory-backend-ram,share=on would do. */
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
> index 7ac7b372145..1d2c8356189 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -844,16 +844,21 @@ static void vfio_group_put(VFIOGroup *group)
>   static bool vfio_device_get(VFIOGroup *group, const char *name,
>                               VFIODevice *vbasedev, Error **errp)
>   {
> +    ERRP_GUARD();
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
>   
> -    fd = vfio_cpr_group_get_device_fd(group->fd, name);
> +    fd = vfio_cpr_group_get_device_fd(group->fd, name, errp);
>       if (fd < 0) {
> -        error_setg_errno(errp, errno, "error getting device from group %d",
> -                         group->groupid);
> -        error_append_hint(errp,
> -                      "Verify all devices in group %d are bound to vfio-<bus> "
> -                      "or pci-stub and not already in use\n", group->groupid);
> +        if (!*errp) {
> +            error_setg_errno(errp, errno,
> +                             "error getting device from group %d",
> +                             group->groupid);
> +            error_append_hint(errp,
> +                              "Verify all devices in group %d are bound to "
> +                              "vfio-<bus> or pci-stub and not already in use\n",
> +                              group->groupid);
> +        }
>           return false;
>       }
>   
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 2d40d8baeaf..14a06a1fa59 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -254,15 +254,16 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
>                                                   &vrdl->listener) == 0;
>   }
>   
> -int vfio_cpr_group_get_device_fd(int d, const char *name)
> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp)
>   {
>       const int id = 0;
>       int fd = cpr_find_fd(name, id);
>   
>       if (fd < 0) {
>           fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, id, fd);
> +        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
> +            close(fd);
> +            fd = -1;
>           }
>       }
>       return fd;
> @@ -291,6 +292,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
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
> index ecabe0c747d..e57766e7e2b 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -60,7 +60,7 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>   void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>   void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>   
> -int vfio_cpr_group_get_device_fd(int d, const char *name);
> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp);
>   
>   bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
>                                 struct VFIOGroup *group, int fd);
> @@ -71,8 +71,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
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
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 56fb67e6b4d..3ad084d5bab 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -28,7 +28,7 @@ typedef struct CprState {
>   
>   extern CprState cpr_state;
>   
> -void cpr_save_fd(const char *name, int id, int fd);
> +bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
>   void cpr_delete_fd(const char *name, int id);
>   int cpr_find_fd(const char *name, int id);
>   void cpr_resave_fd(const char *name, int id, int fd);
> diff --git a/migration/cpr.c b/migration/cpr.c
> index bca43e9bf35..aeb9ad12392 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -82,10 +82,27 @@ static GHashTable *get_cpr_fds_hash(void)
>       return cpr_fds_hash;
>   }
>   
> +static CprFd *find_fd(const char *name, int id)
> +{
> +    CprFd key = {
> +        .name = (char *)name,
> +        .id = id,
> +    };
> +
> +    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
> +}
> +
>   static void cpr_fd_hash_insert(CprFd *elem)
>   {
> -    /* Use the same CprFd as key and value. */
> -    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
> +    GHashTable *hash = get_cpr_fds_hash();
> +
> +    /*
> +     * The same CprFd is used as key and value, and the table owns the key.
> +     * Inserting a duplicate would destroy the new element while keeping it
> +     * as the value, so a duplicate key is a bug in the caller.
> +     */
> +    g_assert(!g_hash_table_contains(hash, elem));
> +    g_hash_table_insert(hash, elem, elem);
>   }
>   
>   static int cpr_fd_pre_save(void *opaque)
> @@ -127,26 +144,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> -void cpr_save_fd(const char *name, int id, int fd)
> +bool cpr_save_fd(const char *name, int id, int fd, Error **errp)
>   {
> -    CprFd *elem = g_new0(CprFd, 1);
> +    CprFd *elem;
>   
> +    if (find_fd(name, id)) {
> +        error_setg(errp, "cpr fd '%s' id %d is already registered", name, id);
> +        return false;
> +    }
> +
> +    elem = g_new0(CprFd, 1);
>       trace_cpr_save_fd(name, id, fd);
>       elem->name = g_strdup(name);
>       elem->namelen = strlen(name) + 1;
>       elem->id = id;
>       elem->fd = fd;
>       cpr_fd_hash_insert(elem);
> -}
> -
> -static CprFd *find_fd(const char *name, int id)
> -{
> -    CprFd key = {
> -        .name = (char *)name,
> -        .id = id,
> -    };
>   
> -    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
> +    return true;
>   }
>   
>   void cpr_delete_fd(const char *name, int id)
> @@ -176,7 +191,7 @@ void cpr_resave_fd(const char *name, int id, int fd)
>       int old_fd = elem ? elem->fd : -1;
>   
>       if (old_fd < 0) {
> -        cpr_save_fd(name, id, fd);
> +        cpr_save_fd(name, id, fd, &error_abort);
>       } else if (old_fd != fd) {
>           error_report("internal error: cpr fd '%s' id %d value %d "
>                        "already saved with a different value %d",
> @@ -192,8 +207,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
>   
>       if (fd < 0) {
>           fd = qemu_open(path, flags, errp);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, id, fd);
> +        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
> +            close(fd);
> +            fd = -1;
>           }
>       }
>       return fd;
> @@ -400,10 +416,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>           }
>       } else {
>           fd = monitor_fd_param(monitor_cur(), fdname, errp);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, index, fd);
> -        } else {
> +        if (fd < 0) {
>               error_prepend(errp, "Could not parse object fd %s:", fdname);
> +        } else if (!cpr_save_fd(name, index, fd, errp)) {
> +            close(fd);
> +            fd = -1;
>           }
>       }
>       return fd;
> diff --git a/system/physmem.c b/system/physmem.c
> index a4a6a4710c6..e94fe5d4a4a 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2445,8 +2445,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
>           fd = qemu_shm_alloc(0, errp);
>       }
>   
> -    if (fd >= 0) {
> -        cpr_save_fd(name, 0, fd);
> +    if (fd >= 0 && !cpr_save_fd(name, 0, fd, errp)) {
> +        close(fd);
> +        fd = -1;

May be return -1 directly ?

>       }
>       *reused = false;
>       return fd;
> 


Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


