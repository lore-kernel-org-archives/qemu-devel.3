Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7921DC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMln-0004Iu-Se; Thu, 16 Jul 2026 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkMlm-0004Ik-0y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkMlj-0002KQ-Qb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784210934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Xj+UyKm2tdNA9Ri5EEohQp8ZcZaZ0DDF6krQkeuj1E=;
 b=KKMkEgYFLYfOZh7hm/YuPfeBkpx6TMPqNbUMI+72kIC88hQvDFsqd5zSsIDSlturZ8z0Uh
 +hc9CHTbxHZwhyXKm+xCAk6CA89rhtDN7Zqh5ZC4to/8mAoydVXFzOh5tf3ZW6aZRAkUCe
 3cYAQB7bNhvLGt2W6vZGRtc/s04KoIE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-_XBePZblMS2CRaQ5ReK0HQ-1; Thu, 16 Jul 2026 10:08:51 -0400
X-MC-Unique: _XBePZblMS2CRaQ5ReK0HQ-1
X-Mimecast-MFC-AGG-ID: _XBePZblMS2CRaQ5ReK0HQ_1784210931
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81e68b02459so171269967b3.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784210931; cv=none;
 d=google.com; s=arc-20260327;
 b=TJnBf4aBWq2AyOg1skyKZaEhUKK3OLV1z2pWChcacC1djdyhLM1iiTFBxBBtQEs4vx
 emfrszHYwNWQFmZ0+5AkHC9GWhyHu6k+XceaU9ZGIaZtswNdOLp92XnXgAxquOhn2kZh
 vCg+znxti8JuDnE+z32EkZ+XAlWzZlI6LiH2Zu6IA7Dsn4tIvEmki9O9dMkBfNjnnSbU
 AoKjDCWjPZb8LssXGn/UVqAWT8InCNovtn/BnWgON7AP+nK3pambLCXqNjexH5EovEut
 6FRPu8mNOZwTHDGe3MAcLR+jBdduSbqXtXxX3BSVZ2b9Eg17Lszzk7i442mDMM2tGdBT
 Y4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Xj+UyKm2tdNA9Ri5EEohQp8ZcZaZ0DDF6krQkeuj1E=;
 fh=scobbx4Z3/DtfOtk4QFSadtpeR2080Ksudnd1sTI/uM=;
 b=KvQ23wcl3p9+jjmQIMbunlAUBwXqeEkNtZIzLYQmIFZYCk8PZ5+fWYo/yA/qzElZLC
 zM5ikN6YFfv8yPoGj+n2k+NuHLUNelox8/mPvFDt1u4iNOxiCMXa2JTISgx3xA0/l748
 ahHRkrWpUODYLUb/Li3csqVFfZxyg1O9WQm7VxnN1jo5U7bMzbNZfeXlaaoUW5hqxp2A
 SaGAQJhZVMVatFgrCro6gilRDEkTa7lo6Dv8aVJ2p99kw+/QZ7VRxBKv8P8THZBNd8RP
 RWu2qCri4LE3ANfSPfUjTioeJpVXpGpLQw5tTkCPj8e2q6iftWSc5aHAcN7oZGMSgUQm
 cRcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784210931; x=1784815731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Xj+UyKm2tdNA9Ri5EEohQp8ZcZaZ0DDF6krQkeuj1E=;
 b=AoHyc5WYN1+38Z4y1+VmHILBc0fbf6JkrQEJPuNjP65RV2s7n9x9jpouNzjOlLw4Ms
 FkkMM+VyIudb1VvYwDZZAjv610uNVK7IgSvlSPeRUpS5w6uXKgmuLvmO3VVikL/hfJmc
 r7i426SOBx5Hl36eRLYhkS5C+n4/s24qiZFKIaD1XEeGkrrUnd0kWhdn4KJzimFlpn3Y
 Q+G2kcjoFeQp8FP907bUokAn/2yhl/j9nO1Oex8cQNkc0iHUm2dVrGFhtH/SJwcBlAna
 RUVU+l8lVVyETPP2awP5qwkaj+93Trw0PpPWIEzkPw79yhxNltvpkZNwLIlS6K74tAjy
 febQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784210931; x=1784815731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Xj+UyKm2tdNA9Ri5EEohQp8ZcZaZ0DDF6krQkeuj1E=;
 b=L1zXoJaK0U8FR9/wAOTgXLXq08A95ZeF/kh7KI/2BECl/g+0o7/J3NfNrcoXwNTjAU
 WPdV1nRn/oMivX8CA17zb72+OFwlXt5SrCBCF5dc6WRFpM+kN8eZuv/5xGN4NjDMmE+q
 eSxvG3jhM8TjEnPvXEOQ+DXqSj9GXCknkBxyPDfqm1DXO48A3vyVvbLKgqWcUNYTB9U2
 L1l0zCOBpXUnxptOoHJJ0/P5+zWK/DTr5PbkvUS+xZ2tUuNKIVQFiNWG8y5hsDEa1mQ5
 Gjc5GbTQNqJ+t9Nsz7QCPfZL0ryh9O+xjCcDUzI5QvkvPe2q6gZq4Jkp6M8FUdvpMpsl
 c2Eg==
X-Gm-Message-State: AOJu0YxdJbZv+Cqsl9NfkS3lnYlN67f2Tz9iy26dR+M0Zmi/j+47AjO6
 INDGI5wXy6cJsI4DmYGxYrtX53RDGar8g0NlQ4ZjEHnEv0I5XtSvVwXxcrcEvRTpSfqFci/rmxB
 99JO1wcFfE0+R5pbGDvHuMXw4+8ovaWkIILcPMeZ1WXZwnA0CNuUisAIIBga76tq0DgwkrzcaIO
 Eg3zmbzpMnFK/W7Rfig6zePvKInvguJdU=
X-Gm-Gg: AfdE7claUiWRz/GXtOPmJxib5lBXmlX4DysMWl1myDhKHSo9NOC2wrFiP/8nY45MWqT
 mwTXIN5NYZfltzQHpaoIAaQe5fyvTgCSznh7MznS0j5vNI1jmwxvfortwgket5vY7QE9Z8oCRps
 Y8O25F1BtFjPxE1XD6ydbmXevCuXe5qt3Yezd/HF5a9Gr6ihwk1A0LvlwI
X-Received: by 2002:a05:690c:b87:b0:81e:dc5a:a4f2 with SMTP id
 00721157ae682-81edc5aa65bmr38559877b3.41.1784210930772; 
 Thu, 16 Jul 2026 07:08:50 -0700 (PDT)
X-Received: by 2002:a05:690c:b87:b0:81e:dc5a:a4f2 with SMTP id
 00721157ae682-81edc5aa65bmr38559537b3.41.1784210930135; Thu, 16 Jul 2026
 07:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132359.96785-1-dbassey@redhat.com>
 <20260716132359.96785-4-dbassey@redhat.com>
In-Reply-To: <20260716132359.96785-4-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 16 Jul 2026 16:08:36 +0200
X-Gm-Features: AUfX_myI5aewZb4BTDvwppcMtV1Kk_YjpuI_XlGbYPoDyohRj4YOkh6eDsFx8n0
Message-ID: <CADSE00JbLQS=AP-V=xUj8H_Jn5L41ADi5J1ciaLB9D2P_GZs7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Dorinda,

On Thu, Jul 16, 2026 at 3:25=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> Commit the memory region transaction before sending the SHMEM_MAP reply
> so the KVM memory slot exists before the guest can access the mapped
> region.
>
> This moves the commit to while the backend is still blocked waiting for
> the reply, which can trigger ADD_MEM_REG back to the backend and
> deadlock. Filter shmem mapping regions out of vhost_section() by
> checking the MR owner type to prevent this.

This is a nice alternative that prevents the deadlock without delaying
the commit.

>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/virtio/vhost-user.c |  6 +++---
>  hw/virtio/vhost.c      | 10 ++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 517cc4ca716..8d0f463aab8 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1998,17 +1998,17 @@ vhost_user_backend_handle_shmem_map(struct vhost_=
dev *dev,
>      }
>
>  send_reply_commit:
> -    /* Send reply and commit after transaction started */
> +    /* Commit before reply so the KVM memory slot exists before guest ac=
cess */
> +    memory_region_transaction_commit();

Without the need to delay the commit, both the transaction_start() and
transaction_commit() can be dropped entirely. virtio_add_shmem_map()
already opens and commits a transaction via
memory_region_add_subregion(). That also makes send_reply_commit
redundant.

Something like this (untested, but should work fine with your filter below)=
?:

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d627351f45..55d8ce1f83 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1955,8 +1955,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev =
*dev,
         }
     }

-    memory_region_transaction_begin();
-
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_ne=
w(
         vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
@@ -1964,7 +1962,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev =
*dev,

     if (!mapping) {
         ret =3D -EFAULT;
-        goto send_reply_commit;
+        goto send_reply;
     }

     /* Add the mapping to the shared memory region */
@@ -1972,22 +1970,8 @@ vhost_user_backend_handle_shmem_map(struct
vhost_dev *dev,
         error_report("Failed to add shared memory mapping");
         object_unref(OBJECT(mapping));
         ret =3D -EFAULT;
-        goto send_reply_commit;
-    }
-
-send_reply_commit:
-    /* Send reply and commit after transaction started */
-    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
-        payload->u64 =3D !!ret;
-        hdr->size =3D sizeof(payload->u64);
-        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
-            error_report_err(local_err);
-            memory_region_transaction_commit();
-            return -EFAULT;
-        }
+        goto send_reply;
     }
-    memory_region_transaction_commit();
-    return 0;

 send_reply:
     if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
         ...
     }
     return 0;

> +
>      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>          payload->u64 =3D !!ret;
>          hdr->size =3D sizeof(payload->u64);
>          if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
>              error_report_err(local_err);
> -            memory_region_transaction_commit();
>              return -EFAULT;
>          }
>      }
> -    memory_region_transaction_commit();
>      return 0;
>
>  send_reply:
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b529..e5c219be095 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, Mem=
oryRegionSection *section)
>  {
>      MemoryRegion *mr =3D section->mr;
>
> +    /*
> +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMAP.
> +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transact=
ion
> +     * commit, deadlocking the backend.
> +     */
> +    if (object_dynamic_cast(memory_region_owner(mr),
> +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> +        return false;
> +    }
> +

This is really nice. The filter looks correct to me.

>      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
>          uint8_t handled_dirty;
> --
> 2.52.0
>


