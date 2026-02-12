Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F53EE3697
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYhZ-0001Zv-Ah; Thu, 12 Feb 2026 10:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqYhX-0001ZW-Qf
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqYhV-00038L-UH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770910432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vp6gomsiopYHNTeY9ZRfiq06F8SF+RE+sMXgI8LTt14=;
 b=NG4sqGua0+TFWP0evpouHPXXhkC0+lN4EtCqxZtxBTDmHk2n8FAHR0dNi9AbJ0mTn+T6DS
 gfaLOZ0IobMsr7BclQCnQT9QZ0KP9EJTZCHGqDw2kfVcKcvxwEMjhqfWT8beN6Po9WZyrq
 CIB+xsNGZpj61y5mGqzaqBlb6tLYsBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-zOcIyiUnO8GwDXP0fS8H5A-1; Thu, 12 Feb 2026 10:33:51 -0500
X-MC-Unique: zOcIyiUnO8GwDXP0fS8H5A-1
X-Mimecast-MFC-AGG-ID: zOcIyiUnO8GwDXP0fS8H5A_1770910430
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483101623e9so29201325e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770910429; x=1771515229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp6gomsiopYHNTeY9ZRfiq06F8SF+RE+sMXgI8LTt14=;
 b=ekiUqJYF7c14IKT3xHWUCofysYqYmX6jkc4ZVOHpG4LOfwkUG3qPsK/VqoqiLVusJh
 GZfg/DhZeDOCYSfsNnDSgnKBrvS+efI8Xp5g51EGickzb3WYtOUgDrV7zivSrdPJizvB
 FzZSewTnf+hZhrKIAsEpWoRCBASQ+KvfqQUGt4RO3h2HRRKdyEWCyurqctcDeZg3PbUt
 7lQoXU/8ewlulBJ4OxkVBImb7I1PGQXkQVXX9dYN3nnHbN4fWuCt1cb1ZgTaOJ1/VdE5
 diANODKckkA9XxJjDosSgno5ylszjuSikzSA2w0uKwFhZD1csm/L9bhoDUE47bQueln7
 KHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770910429; x=1771515229;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp6gomsiopYHNTeY9ZRfiq06F8SF+RE+sMXgI8LTt14=;
 b=gvTqma3ASSUqq1JWqDQP5VxwrVdDSvzTPoiA3qswQYC9GCaaMtSi+3IY77w/iepcq+
 kn5SfXW5KqtiZ/LGesj5uGxvZXoboerTDZSSwVW6bhj8SwjATypql87xWHEjpIUIaAzs
 Vv9ZrM7wrs7Kah5lBzPb2xfdTvvWEoe00uiCHX1K2gELJOiANa242oxVpdmaUqGStBYI
 pObCcbYFYvPcJCDemB5Mr+BOICO9sE6SxDW9QYtpFpeNq8ATbxUt7vxa8sSTtuP3pAl2
 wzv6RifPlIZ8KKrniWzYgjE+kgdNmTWdn7h5e4DnJ2dqEFfVhiipDHVL6+qeotsHOq7y
 krug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8vuyE8e8nwcwpgxeAwboiYyHAW0BtJnbC1tIWZxSvuQr7MIV23y33GJ97cUlKH6u6vOTzTwUrrCKv@nongnu.org
X-Gm-Message-State: AOJu0YzqbPt9n70OnYsCfQwkKqEIlTmm9tpdHg+gpBOeQqfZjFcyDnJs
 wkg6sSIomtnPXCsiicSLI7ZkFwa3+lb5CdKaF04N8MOCM+HAJ88jarl2esdMghJCjl705w1fFz3
 G/fIdK1UH+xhHMYwhUwB7O93xvmDtO9uw0tqI8T31u4HxQwtOc8YmiqNQPuWKXnL3
X-Gm-Gg: AZuq6aLDAW4gOMcio9663+KcY/RqUbT5et6hxrj2OAEXWVhzcn7vdkOpJLpHnfyyFRo
 lZxIlHPHjcj1C4lA13iO24dpgzuiunPlESMU+1BLcaYC6yHZ5qAzDAp2hncKYZki82OP8CLUJ0R
 5A6VXRfMRsD5meTBAGjGwt3jGkOFv/bn28mzA+8d8PtfvW70BGj9YhbVqPIYXle2B9S/TodE1Bb
 opWKZwhEKwzfNWpXyLFka7sIkvJ/JvvHkwMjEBDYykLGolXZF84Y/fy5yc6Dp0EGC0S8wxb81nA
 ZfSVUHZMAqtj4BsDRSzsGJ4BmRlokT1fpmxLrqjswpSZFVo7fYp/nM3NkVNkCpxxbK2W4h+iuue
 v2xji9aT9/Bz7Yl5qyEh4bq2eFceDatUfPtmnyUcmt0Ai8tFkvzy5yfNkol7e
X-Received: by 2002:a05:600c:3548:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-48367175f3fmr43502765e9.35.1770910429251; 
 Thu, 12 Feb 2026 07:33:49 -0800 (PST)
X-Received: by 2002:a05:600c:3548:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-48367175f3fmr43502285e9.35.1770910428822; 
 Thu, 12 Feb 2026 07:33:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5c93asm11641472f8f.39.2026.02.12.07.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:33:48 -0800 (PST)
Message-ID: <504b4481-ccb5-4d31-a9ec-596ee9efa7e1@redhat.com>
Date: Thu, 12 Feb 2026 16:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/31] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-22-anisinha@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260212062522.99565-22-anisinha@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/12/26 07:25, Ani Sinha wrote:
> Normally the vfio pseudo device file descriptor lives for the life of the VM.
> However, when the kvm VM file descriptor changes, a new file descriptor
> for the pseudo device needs to be generated against the new kvm VM descriptor.
> Other existing vfio descriptors needs to be reattached to the new pseudo device
> descriptor. This change performs the above steps.
> 
> This chnage is untested.

It is now.

> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/vfio/helpers.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index f68f8165d0..2ff189a53b 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -116,6 +116,91 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>    * we'll re-use it should another vfio device be attached before then.
>    */
>   int vfio_kvm_device_fd = -1;
> +
> +/*
> + * Confidential virtual machines:
> + * During reset of confidential vms, the kvm vm file descriptor changes.
> + * In that case, the old vfio kvm file descriptor is
> + * closed and a new descriptor is created agaist the new kvm vm file
> + * descriptor.
> + */
> +
> +typedef struct KVMVfioFileFd {

The KVM prefix should be reserved to the KVM subsystem. Let's use
VFIO (Yeah, it's not CalmelCase)

So, VFIODeviceFd should be correct enough for the type and
'vfio_device_fd_' prefix for the routines below?


> +    int fd;
> +    QLIST_ENTRY(KVMVfioFileFd) node;
> +} KVMVfioFileFd;
> +
> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =

vfio_device_fds.

> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
> +
> +static void insert_fd_to_list(int fd)

This function name is too generic. How about vfio_device_fd_list_add()

> +{
> +    KVMVfioFileFd *file_fd;
> +    file_fd = g_malloc0(sizeof(*file_fd));
> +    file_fd->fd = fd;
> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
> +    return;

Please drop the return.

> +}
> +
> +static void remove_fd_from_list(int fd)

and vfio_device_fd_list_remove() ?

> +{
> +    KVMVfioFileFd *file_fd, *next;
> +
> +    QLIST_FOREACH_SAFE(file_fd, &kvm_vfio_file_fds, node, next) {
> +        if (file_fd->fd == fd) {
> +            QLIST_REMOVE(file_fd, node);
> +            g_free(file_fd);
> +            break;
> +        }
> +    }
> +    return;

Please remove.

> +}
> +
> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,

vfio_device_fd_rebind() for this one and there are some more
below.

Thanks,

C.

> +                                  Error **errp)
> +{
> +    KVMVfioFileFd *file_fd;
> +    int ret = 0;
> +    struct kvm_device_attr attr = {
> +        .group = KVM_DEV_VFIO_FILE,
> +        .attr = KVM_DEV_VFIO_FILE_ADD,
> +    };
> +    struct kvm_create_device cd = {
> +        .type = KVM_DEV_TYPE_VFIO,
> +    };
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
> +        return -errno;
> +    }
> +
> +    if (vfio_kvm_device_fd != -1) {
> +        close(vfio_kvm_device_fd);
> +    }
> +
> +    vfio_kvm_device_fd = cd.fd;
> +
> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> +        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +            error_setg_errno(errp, errno,
> +                             "Failed to add fd %d to KVM VFIO device",
> +                             file_fd->fd);
> +            ret = -errno;
> +        }
> +    }
> +    return ret;
> +}
> +
> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier = {
> +    .notify = kvm_vfio_filefd_rebind,
> +};
> +
>   #endif
>   
>   void vfio_kvm_device_close(void)
> @@ -153,6 +238,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>           }
>   
>           vfio_kvm_device_fd = cd.fd;
> +        /*
> +         * If the vm file descriptor changes, add a notifier so that we can
> +         * re-create the vfio_kvm_device_fd.
> +         */
> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>       }
>   
>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> @@ -160,6 +250,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>                            fd);
>           return -errno;
>       }
> +
> +    insert_fd_to_list(fd);
>   #endif
>       return 0;
>   }
> @@ -183,6 +275,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>                            "Failed to remove fd %d from KVM VFIO device", fd);
>           return -errno;
>       }
> +
> +    remove_fd_from_list(fd);
>   #endif
>       return 0;
>   }


