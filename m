Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C1C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMy9-0008Aj-Ks; Thu, 16 Jul 2026 10:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkMy8-0008AM-8V
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkMy5-00045x-5s
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784211699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhZA5YDu7b/kYNoLcHQk8vnfTW5pXOBr0mgRR0qJzVU=;
 b=YCmCFu+3DsLcSvUBUUtIdd1X9Z7KPVXIpsOaUAQ3M5LdCt+osElM8wTmEpu1TLPbBRffAO
 9qiAURCAqw1zVfpMNMGe0x6UMfMzPUn+7KrIlQaZyMytFffvJMXE1w/qas5hWBS8erccbE
 l3adktHjhIOZRc10xqxK3amRoKx0BF0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-uYpuZTNBP5GYnKmlzHno9Q-1; Thu, 16 Jul 2026 10:21:38 -0400
X-MC-Unique: uYpuZTNBP5GYnKmlzHno9Q-1
X-Mimecast-MFC-AGG-ID: uYpuZTNBP5GYnKmlzHno9Q_1784211697
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e735bcceaso66780197b3.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784211697; cv=none;
 d=google.com; s=arc-20260327;
 b=NPV8hkWnp2vFh4HqeHUnfJWpn10jI+4BzuGDrDAOxnIczz469IjIKIwrrzb+uW5iCe
 PSyIVdr/WYHHUh04manF9wgdwipm+RMjIY9eK3/CzhkrAweVuj08N4q0bRIX3bHtun/P
 5Y7FtwIAx92cu/LUSUAheSNxGeTX9XcmIPu2hE7j71kLHMuUM1tozCq80kOIAMlNGu9K
 wmzpXsHa0mRdiDPjFag8zf2rGI2QJv4RsX1QQeNGsrKF0uOCWmpkw/MFITPZXChZaRDL
 SjkLisAziQWiAhXLP7r9ShLZFE+q/CXoYus7B8E6Fus87GYGwRiqaQs9KoAQNiM4+pxS
 Ydaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rhZA5YDu7b/kYNoLcHQk8vnfTW5pXOBr0mgRR0qJzVU=;
 fh=Y+qgqljnCD+vn9maPv5/L5D+nWzFUyAWPfDNwkTz0Pw=;
 b=hm453JUPUNQsFBJOnr5cFkYgQRQARAmWrJzdgtgLCp0B3CZr2FQ8JSrzdidckB0OJZ
 OVXDe52UCDkvqHrDqKKvJonI6wV00UcUQj+1cV2e9/e8kfUkKV2xBaJoPTQ4sBCsZF/V
 maJu0DUKcA0jmIiNNveL++qRnNCmp+LWXOS1x87sFb6+90NbwgnhY1GhCDwYOy4TW4vw
 Ts6fPpWi08zv133s87kLqrcNrv3EqXMWekkzJz+9sE0nScCCWtI4B+GyOMr9+ZZ/D3JT
 59uNUM/bfI0ZCZhsWvM53NUtLoCH7pMgC4ISqPOqDqqPPMTvwZqnxu6esw6TzsXMq9T8
 xyzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784211697; x=1784816497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rhZA5YDu7b/kYNoLcHQk8vnfTW5pXOBr0mgRR0qJzVU=;
 b=Bh9YMisowvoWqJrOyA8RCfeOh7FmPfPkNtf9CfgSRgf9uqnyPNpGAQdDMncuaBcTtc
 3+P9vkYLscaTQgLV8nCXc+kkqnXcydWXA+d0OLnx2AT4BoZmaMynuF8yYSTd9RbO2o1c
 MibO5MLfxZlX5QqKU9fz67AKKPcHXTGmpTiiygvxJHtW9L7ScichrME3xzFqthKjjX88
 OgK60HZAd+vAX39W/oqCGCXjYMYY8JJKqz++XOwcOXeMRZYSKK3kxnXmbdpJzg3bh3PY
 LQbAdyNQJvcq7mx+cjtwswJMI83KraKxG/3ySEPhyEEWFjTEKvL+YD8RW2duYhEx3NdZ
 kVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784211697; x=1784816497;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rhZA5YDu7b/kYNoLcHQk8vnfTW5pXOBr0mgRR0qJzVU=;
 b=gwZUVxvLUve0mtkN6XIiQ1pD7bYOeHKMOgQPMt+8DtToUxU1E8jnbm/no4pJCE2nc8
 PeTMEIU7oGGlkOkD4KD3n+LX8sSYnD2tVfwr5zTuWqItAIrBdf9dHzFmpSDGRXws2OUp
 sAfPB88mdBJbR0uw+kRCr1S7pvRw2WoGL9wfn/0brNzpMIIMNt9U/bsOnd/49a/xLt2y
 z2NqZANDA5jH+zpKWFFJ56VPsmk4cZYBKO5JTMsfn2g78QiSLjY5WDKmhbXGPPfsw/GE
 NnNVJLj6x9p03iRCvSs4/J5nGV09iN1FJC6vRvKkzvSZNUwLvEY39A4lkJHTW0YbQSmX
 SaXg==
X-Gm-Message-State: AOJu0Yw1zVEjIT7/PuwWwK/mNHqENipNJFE811wXmeTpE4ZC3bwa8mMp
 mQgTiUubt2bE9EBQRMIGCj9a9W/UlYCUkUXyBrQFJjHah5o+Bo4gJnl5JO4FNIVZc/TwQvz6DQS
 75hdlv5dS74otMIMaK13Zz0yJHQuBMR5gX12hTcGj0MpefofVbcFaMciWAp3UnOc5pvkullyhOh
 Hh9dWHukB2I5LvBAKRx4Wq7v7lV8GJYcuvQ6+Lne8IEqWT
X-Gm-Gg: AfdE7cnt0C59/sN+sQ8W5twMC3oFnyCqCPBptk14k/qgzdgGY0FBmZvPKAMwkMqwkHC
 mezzDYxnBS4QNJFA9pyhOXwLsFwfmLGdTaMnThqpejmzsYpqJQ3HuZPfptcFMg/qQaSnHinZa8h
 59OcPb5in6CJ28I/XmmYcF3qZmruDlXz/UaAe3Ye37kVG8/LdhbSOUpcwr
X-Received: by 2002:a05:690c:338b:b0:7fd:e030:2407 with SMTP id
 00721157ae682-81e90091580mr158916947b3.29.1784211697279; 
 Thu, 16 Jul 2026 07:21:37 -0700 (PDT)
X-Received: by 2002:a05:690c:338b:b0:7fd:e030:2407 with SMTP id
 00721157ae682-81e90091580mr158916537b3.29.1784211695990; Thu, 16 Jul 2026
 07:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260707112149.2867886-1-aesteve@redhat.com>
 <20260707112149.2867886-3-aesteve@redhat.com>
In-Reply-To: <20260707112149.2867886-3-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 16 Jul 2026 16:21:24 +0200
X-Gm-Features: AUfX_mykbzkTkdZuEqHkEtFhrK2TjSN42DeSTy1birjy4A2F2rk3yRTBi1CjtUs
Message-ID: <CADSE00+abo=8ny1L=u=b-bOj53DaAqwrDQzNCky7Fhh2QHSQPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio: use g_autoptr guard for shmem map transaction
To: qemu-devel@nongnu.org, Dorinda Bassey <dbassey@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 7, 2026 at 1:22=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:
>
> Use g_autoptr(VirtioShmemGuard) to automatically commit the memory
> region transaction opened by virtio_add_shmem_map_start(), removing
> explicit virtio_add_shmem_map_end() calls on each exit path of
> vhost_user_backend_handle_shmem_map(). This also allows the
> send_reply_commit label to be folded into send_reply since the two
> blocks are now identical.
>
> VirtioShmemGuard is a sentinel type whose non-NULL value triggers
> the cleanup function on scope exit via GLib's g_autoptr infrastructure,
> similar to those used in main-loop.h and rcu.h.

This patch is now superseded by
https://lore.kernel.org/all/20260716132359.96785-4-dbassey@redhat.com/

I will drop this patch from the series and send the single remaining
patch in v2.

>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c     | 21 ++++-----------------
>  hw/virtio/virtio.c         |  4 +++-
>  include/hw/virtio/virtio.h | 16 ++++++++++++++--
>  3 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index f6bf9e0ba4..0306b06b48 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1933,6 +1933,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>                                      VhostUserPayload *payload,
>                                      int fd)
>  {
> +    g_autoptr(VirtioShmemGuard) shmem_guard =3D NULL;
>      VirtioSharedMemory *shmem;
>      VhostUserMMap *vu_mmap =3D &payload->mmap;
>      VirtioSharedMemoryMapping *existing;
> @@ -1977,7 +1978,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>          }
>      }
>
> -    virtio_add_shmem_map_start();
> +    shmem_guard =3D virtio_add_shmem_map_start();
>
>      /* Create VirtioSharedMemoryMapping object */
>      VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_=
new(
> @@ -1986,7 +1987,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>
>      if (!mapping) {
>          ret =3D -EFAULT;
> -        goto send_reply_commit;
> +        goto send_reply;
>      }
>
>      /* Add the mapping to the shared memory region */
> @@ -1994,22 +1995,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_d=
ev *dev,
>          error_report("Failed to add shared memory mapping");
>          object_unref(OBJECT(mapping));
>          ret =3D -EFAULT;
> -        goto send_reply_commit;
> -    }
> -
> -send_reply_commit:
> -    /* Send reply and commit after transaction started */
> -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> -        payload->u64 =3D !!ret;
> -        hdr->size =3D sizeof(payload->u64);
> -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> -            error_report_err(local_err);
> -            virtio_add_shmem_map_end();
> -            return -EFAULT;
> -        }
> +        goto send_reply;
>      }
> -    virtio_add_shmem_map_end();
> -    return 0;
>
>  send_reply:
>      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e604781ffe..1db800fcd7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3226,9 +3226,11 @@ VirtioSharedMemoryMapping *virtio_shared_memory_ma=
pping_new(uint8_t shmid,
>      return mapping;
>  }
>
> -void virtio_add_shmem_map_start(void)
> +VirtioShmemGuard *virtio_add_shmem_map_start(void)
>  {
>      memory_region_transaction_begin();
> +    /* Anything non-NULL causes the cleanup function to be called */
> +    return (VirtioShmemGuard *)(uintptr_t)1;
>  }
>
>  void virtio_add_shmem_map_end(void)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 9935452486..b9e67f789c 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -104,6 +104,8 @@ enum virtio_device_endian {
>  #define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping"
>  OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEMO=
RY_MAPPING)
>
> +typedef void VirtioShmemGuard;
> +
>  /**
>   * VirtioSharedMemoryMapping:
>   * @parent: Parent QOM object
> @@ -396,17 +398,27 @@ VirtioSharedMemoryMapping *virtio_shared_memory_map=
ping_new(uint8_t shmid,
>   * Begins a transaction to add a shared memory mapping. Call this before=
 adding
>   * a shared memory mapping when the commit must be delayed until after a=
 reply
>   * is sent to a vhost-user backend.
> + *
> + * Returns: Non-NULL guard that triggers cleanup on scope exit.
>   */
> -void virtio_add_shmem_map_start(void);
> +VirtioShmemGuard *virtio_add_shmem_map_start(void);
>
>  /**
>   * virtio_add_shmem_map_end() - End a shmem map transaction
>   *
>   * Completes the transaction started by virtio_add_shmem_map_start() and=
 makes
> - * the mapping visible to the guest.
> + * the mapping visible to the guest. Prefer using g_autoptr(VirtioShmemG=
uard)
> + * over calling this directly.
>   */
>  void virtio_add_shmem_map_end(void);
>
> +static inline void virtio_shmem_guard_cleanup(VirtioShmemGuard *guard)
> +{
> +    virtio_add_shmem_map_end();
> +}
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(VirtioShmemGuard, virtio_shmem_guard_clean=
up)
> +
>  /**
>   * virtio_add_shmem_map() - Add a memory mapping to a shared region
>   * @shmem: VirtioSharedMemory region
> --
> 2.54.0
>


