Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F22C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjVf-0001sQ-Az; Fri, 17 Jul 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkjVd-0001sI-Ag
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkjVb-0007cx-Dq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784298346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeAC5/pOAX5sTeZFbG2UORgUFmkPVvRxpH27tQbODvA=;
 b=Yuvkjx7fX83Uw9y23yT9zv12T7wcd9Z8xYaj9AblJUoHO0V+f3zqkM+JYkBQIxNK8JWda4
 PTqnslqzjHfsk9FuUomR72or3g+vU+gHLstdsE2odIuwHuTK2i29nYpGKdnEyeMEbFbZHO
 mMZgIPKrqcSSlM/RvCdQDoQrGmeYUek=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-JzihYMEWOxaEE4JgSXUDVQ-1; Fri, 17 Jul 2026 10:25:42 -0400
X-MC-Unique: JzihYMEWOxaEE4JgSXUDVQ-1
X-Mimecast-MFC-AGG-ID: JzihYMEWOxaEE4JgSXUDVQ_1784298340
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81ea59b5979so137578637b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 07:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784298340; cv=none;
 d=google.com; s=arc-20260327;
 b=SFNI9h71TCs7z0Hrdfu1om2J2ttZNIRiGCfSrRjG9Zi6F5607Xo0WWUjHDh/kNlumF
 h8a3lVw3bv+yu+Y31+yVs+J1X95SgRQvr0Bb45tkMQnJi+HlKQMfGey7x+wcTVptjq+p
 EQi+0AhBy/vVVlIq2nWEovHGmwbSDwdwCepWBPBxB0k5pO1WNa2xg5jbY5/6TYWM10Zh
 E1V2pWdq5RtR9s1f2Q1ijAo1P/EaatRyP9tqmaFFgrb7Fun7wULtorxOoefGFUK09SN9
 HyNcJ+KqRF4oFTIKKVn1D/7XId73rsDVDRLITfCTVtLUCQaPn3GNh+o5WAMAYzCR44ND
 ae4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jeAC5/pOAX5sTeZFbG2UORgUFmkPVvRxpH27tQbODvA=;
 fh=scobbx4Z3/DtfOtk4QFSadtpeR2080Ksudnd1sTI/uM=;
 b=lBse2LG42MdB4Woh22WqeDHRiqpnOwebbpyccjEp11HixwGtXrNig1R9toS5tULElu
 1XU4cXPNs/Wg9b2HxtG2AxDSbC6nb5wmpkCWQXaanvdzdzdCgt34H18RvX84xk5NL1j3
 5pN3QunsjjLo1hTGVoRglzt6YxRpwBlg/VG+KYxmTIVzaH0py55OaVVzP39KOebjdyCJ
 A78Pb2XYXJ1IGRr84JWsh7ohK9jUcKBdXjkfG38cOzAHmDHucmA8jtATwNEDyewRytrt
 00TFrHd8jQGnSWpXYArzwNCra2wR4ULc78ti44DwO9sY9Rytwy4qD0lsMhHh+b/n2k62
 eISw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784298340; x=1784903140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jeAC5/pOAX5sTeZFbG2UORgUFmkPVvRxpH27tQbODvA=;
 b=N92jY2WtOtFWHPCVSrIPQ8/mLfJLe8+FChLiv9AwcDqRkFWE9ev8bYIfMYtn4maPex
 QqYQyh7zH96IN6Syo5Ei0an9WRLk8PlkJzTGET7ArRKW/fTZjfpnsn5zk0Y/J3V23KOU
 mF1v3w8owe3iH+ZLgdB/Uq6yia59OMVVwuRoX7UQGOSCBuKCiltbfNV/c1R0YxqvXASc
 pJXOVsA713bCQJErMT2mhFEgkbrrffKX4iLwtpFgb0sm56m02pwDI6/akfWJPPAoFX/v
 9jT76QPAzY5O0g/NkotxKqCNmH5cyRr3sHyOJsr2QY3AO62qVp3tOBoVThaWitZ+yh3R
 bWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784298340; x=1784903140;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jeAC5/pOAX5sTeZFbG2UORgUFmkPVvRxpH27tQbODvA=;
 b=RZh8WuhS/SXaDo7j4e+/9wWPzCg/ss0cNBZnyKcSsjprEMIgoDIcb4LULzw6yUFecQ
 hPtzPNMZqymGougCaAd2N2C69wcw3S94ZqsxYenjZ8xWaN7ezHISOJItYdDOu55RYwsB
 oe+Y6HGXVq38l8UCdDW+E9pGRykZ1lQ5Hc+bgVr4XFsOTJskvFXPMKhtEHDiuV8Rypqe
 NR7vFN28Dfs/XEtqMCHSD45Wlq0fOabdvT2vsfL31RviiVlRySfehYEeA9UVVm/WZ2uE
 33kydGZB59W2LuC4ra4RvoURlgeFAKWLVhgNH6IbIxL2PklMAAL6IMbtAEypo4pAFqi4
 CfVQ==
X-Gm-Message-State: AOJu0Yzzcwquq6eQex7oACVcz/SSpJrbTjH5Q1espxaDws3y0FjM3rI2
 9u4PJT1MUJUJNweQJEv2xuEYStEdiJoISdNHsNRjjB6pke5stV7zbuisqTz98064VHSKVWbbd4f
 HoIT1N/wN0A74d6ES8EAizP8Nk6JKA1ahS78KeXJCPRVaqsF83P+lj+unWrnIxh/vbSUCbYFYFM
 5t49ZPgJKxpck1AHHBXmyTP/F/f8S05mg=
X-Gm-Gg: AfdE7ckwPXiND1hJHfOptqnkXbRwPzizxWY6061hIdvu7clxeYnkmZnolgu+Xw4nUUb
 PWk+XfmSHcp5V1i8OeaeZAjzkKOuUlPPUxpqB8mUUaLGWw0g0sxcgoCMU8YCy+ONFv7O+8GM6Qp
 o+6iLRxIXRULEtCixC4Vv6ISJdGP/rhb8tZclXbVH4/EO7ahAqW9dqJfdE
X-Received: by 2002:a05:690c:6b86:b0:81e:98d3:cac7 with SMTP id
 00721157ae682-81ef26cb5bcmr9095327b3.12.1784298339661; 
 Fri, 17 Jul 2026 07:25:39 -0700 (PDT)
X-Received: by 2002:a05:690c:6b86:b0:81e:98d3:cac7 with SMTP id
 00721157ae682-81ef26cb5bcmr9095177b3.12.1784298339140; Fri, 17 Jul 2026
 07:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260717134920.265128-1-dbassey@redhat.com>
 <20260717134920.265128-2-dbassey@redhat.com>
In-Reply-To: <20260717134920.265128-2-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 16:25:27 +0200
X-Gm-Features: AUfX_mzVCPv53kKJJyv8XdA_VjX9oi8_zK3f1bCLEx5cCA-bhwidH5_pCv_QBf4
Message-ID: <CADSE00+LZO1+CcFcWeLX8qLWjoy43zqcPBiaN8u8bn_YP-Zuug@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vhost: Fix SHMEM_MAP transaction ordering and
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

On Fri, Jul 17, 2026 at 3:49=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com>=
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
>
> The explicit transaction begin/commit wrapping is dropped since
> virtio_add_shmem_map() already commits via memory_region_add_subregion().
> The unmap handler keeps the original ordering: reply before delete, so
> the backend is unblocked before the transaction commit.
>
> Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>
> Tested-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 20 ++------------------
>  hw/virtio/vhost.c      | 10 ++++++++++
>  2 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 517cc4ca716..01468f7441a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>          }
>      }
>
> -    memory_region_transaction_begin();
> -
>      /* Create VirtioSharedMemoryMapping object */
>      VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mapping_=
new(
>          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>
>      if (!mapping) {
>          ret =3D -EFAULT;
> -        goto send_reply_commit;
> +        goto send_reply;
>      }
>
>      /* Add the mapping to the shared memory region */
> @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_d=
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
> -            memory_region_transaction_commit();
> -            return -EFAULT;
> -        }
> +        goto send_reply;
>      }
> -    memory_region_transaction_commit();
> -    return 0;
>
>  send_reply:

Minor idea for follow-up, not a blocker: with nothing left to do after
the reply, we could drop reply_ack =3D false and the handler=E2=80=99s
send_reply block, and rely on backend_read()=E2=80=99s default reply handli=
ng.

>      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
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
>      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
>          uint8_t handled_dirty;
> --
> 2.52.0
>


