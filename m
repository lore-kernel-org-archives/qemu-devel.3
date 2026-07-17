Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4D8C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgtP-0008Rz-Fz; Fri, 17 Jul 2026 07:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkgtI-0008Rc-Qx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkgtF-0001I1-QL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784288280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tSBbtzhEee8x3sehSYzNoHxJmlSUVvIZDqRZMY4dBU=;
 b=QDJwIYySsfOs1qXXzDmPYybuI8jSMf+7fvmFBecuI7s8/gL1DcgNw1ZMBBpczIq7b4oOIJ
 6nCZbF/SzP62Ap6L7y6pfp3GkLiSHlJwSvvh4PvCbv71KSkIhswlTidKqJjC4Bh0xv5IRA
 KtpuiTja+hhB+1DavpvEihF/3xLq06s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-JVkrwYxZMMSXm5so3mjS4A-1; Fri, 17 Jul 2026 07:37:59 -0400
X-MC-Unique: JVkrwYxZMMSXm5so3mjS4A-1
X-Mimecast-MFC-AGG-ID: JVkrwYxZMMSXm5so3mjS4A_1784288278
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81cb01c07b2so75947027b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784288278; cv=none;
 d=google.com; s=arc-20260327;
 b=JhA5foT5dhBK/UzOF6t4NbBMJ1C19s5XUdVyBmOtc6OtL2mQeSWyLFUGtjycCqFBE4
 JWjFWLJXCOYM24svpiCvuiRXDlHNm43j9W94Dgz8lHC4N4SdlpWEoA8hgFvLSM2hC3wu
 MVSPDwyNJ967ZQincCPh5vr7ewrMQ6XMDv0hcJM6+6Vx8obr/kDxyIPFuhcSwbWUeOxP
 DVwoHtVP8vVOnvQyr9pKsLMSzB13U2HKpvValyQUaPruaInkz2Zje6/3OwzUDE+BFf2N
 PoxdCJCz+MQGutw1/mT2WBmhAsff3w02l+a7rkjRR2prLM4hCfWHAV8vbOvFubkZx+ju
 hkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9tSBbtzhEee8x3sehSYzNoHxJmlSUVvIZDqRZMY4dBU=;
 fh=scobbx4Z3/DtfOtk4QFSadtpeR2080Ksudnd1sTI/uM=;
 b=RSh9tVBe+lkcaPaDE/HJeX1kNxhjVD10Vf2B0r6RhfPBOLtqIadUva26Bp40QGJ+X6
 Y6WYXjivVdgHHBkzWa7VbUCLA2YVdtpY6W4EDSoH3glf1To338M+NbKcXVfEWFcM1KLg
 nF2TQGmyhH/cLKntLW8WQEeqQN01Lr2kXBvLdXqtcNnlKucEAl9vp30miZ4c2SNvm3DZ
 9rjIZgFgGMHsfaAsi8pRTw+bDx6MLpJJlHRn2GwVTYvd5VqLdTN2phXp9P7LdWCN/1VI
 G4+aPM7guLQN2t8Fkgovo5ipJj6/RXQPdPVjvRc4/HVLmNmzoQnK3hdWcHq0LWvaGbIQ
 t94A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784288278; x=1784893078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9tSBbtzhEee8x3sehSYzNoHxJmlSUVvIZDqRZMY4dBU=;
 b=JUlqT2EY4Hg39ajfxmD1yKik9VfCNwHI5B2D40tlRj/mnqxe7Jui4LTBeZc9FuvKX1
 YGwm6mJ8QVoffIv7RqB3oOK5vuCiAB3xWIVXo/zaGuXvEQp1BbUru9gK5HfiH5veaOIm
 VUE5hOIaWqkSNj0BMfAQ2o1QMrOoJ520MySulopRBtu7tTi000d70gQ7Yu9Ppd8BY8ie
 pJpNULnNqfuFfeiQASoJPOO1gy/qltPHOAmEUVQ56oSHiFSgSHFy/AKcrRFhdH0JRBo3
 xRMEXXb6HyUMfkmsDbyxaMckbbgBzxziQ/qWO4lWepo7qSOy7AcpZsTDfCDFkpAg+QOn
 q0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784288278; x=1784893078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9tSBbtzhEee8x3sehSYzNoHxJmlSUVvIZDqRZMY4dBU=;
 b=gLt19S4SaosDMWI2cHjgtPXeiWVfhvQ1UbtqShW7zEdaY3aaDVlRvwfFmDqd/OFlB6
 a3dnvPWH2zW4Dimvev+NiyulFQO5U8VpAF4NW8tzkOv3BVUgcfcMs1yuWuvps/DWRjia
 4DNfeyESaQzDrfDkSb/tM2Yv+jMPa+GNOLVhOt1wKlkL3oQ/63SppnonSnZ9WIX1EEue
 XHgAMa7dSvFMhvuP7v+tjsQ88Dlg+uh10225Y1iRX1OqGZ1t4MI1tdxzifWSDS8f+SK0
 l0DdotgFXVquxL8cLT1Vy9298CfwB4oap4zqzu1U2afzH5oGRJKQf9Vp6rB0v1wt9gp1
 7Q+Q==
X-Gm-Message-State: AOJu0YzXpfnJlUNgWK9buwDpdWVq2EdS0ef8bnFMckXGunzIRoOrh91/
 UxZ/zY4xTy/vONYr7AdlqfvS2I+GYfElWtZdl/8ao9sXOPSl1y+vl2afjwuiaA1Zm6q+aHcw27+
 b+JoBqCj6Rc+TDThsyKAde3lorGtlNHHHVcrCH8c4lh/plWgI2EHEvsEMSEZpvOKri1Z5x5B0IZ
 HHSEM89iM3TEidznGVUC000LKT7AKR5k4=
X-Gm-Gg: AfdE7cmSNi28HUbAcmju+uTt8+SmYwzcVOryWo0A2CSZzuc+q9bjYRzngtAIxoau82o
 cwJBRkWDCrk1xbTNv6s58SE3O+ojdW0/bk0p/4WmzsDH9P3gHTCQTWtdx87fZUX+xGF8ROmXNpo
 nEM4kzOZWDNrs6kMOO54YX3PBe7l2jt0Xje6aSyDKHSYll/IVeyFw9jjub
X-Received: by 2002:a05:690c:3387:b0:80c:85e5:8748 with SMTP id
 00721157ae682-81ef2637cadmr5668717b3.70.1784288278440; 
 Fri, 17 Jul 2026 04:37:58 -0700 (PDT)
X-Received: by 2002:a05:690c:3387:b0:80c:85e5:8748 with SMTP id
 00721157ae682-81ef2637cadmr5668587b3.70.1784288278030; Fri, 17 Jul 2026
 04:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
In-Reply-To: <20260717103301.228974-2-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 13:37:47 +0200
X-Gm-Features: AUfX_mwzu8xMDvz8DA1Vv2RVQfI2KqHGxCBAJWSHc8L9SpWIKf6dPTls-pt7prs
Message-ID: <CADSE00LuTV5CoE5nW2S6X-_bvmeqehs5zF62PQgzDfwP8WSdrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
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

On Fri, Jul 17, 2026 at 12:33=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com=
> wrote:
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
>
> Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>

I tested this patch on top of [1] with the rust-vmm backend [2] as
described in the linked series cover letter.

Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>

[1] https://lore.kernel.org/all/20260630112310.552606-1-aesteve@redhat.com/
[2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-media

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


