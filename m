Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF1C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPUO-0008IF-O8; Wed, 26 Mar 2025 08:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPU5-0008Cc-BO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPU1-0002ci-Rp
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742990620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhD3yfBMykL6nbU4Oryunm0O5HU7fe6PWHNoVoMQcqk=;
 b=GuzK/KEGAkEwuIxQhHD70fWC4a4bRZrdo1knRgrZCuOzvE+26s/RB0KX624IUKsZ6GMi8a
 k+JUhMK1IcBaJgWnBOK24uZ6js98wXOOu2xsDyFdDjXeThfNR44lArH2HrrYcmOQWLDEkK
 lMGhWcAghwk+3Mdk88IK3Mzz2pYAsHs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-KyKlloqUN2qOvfyi4PQAPw-1; Wed, 26 Mar 2025 08:03:37 -0400
X-MC-Unique: KyKlloqUN2qOvfyi4PQAPw-1
X-Mimecast-MFC-AGG-ID: KyKlloqUN2qOvfyi4PQAPw_1742990616
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2262051205aso79588995ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742990616; x=1743595416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhD3yfBMykL6nbU4Oryunm0O5HU7fe6PWHNoVoMQcqk=;
 b=E7/OjwpzkObEX+vWkSBq/rlq63ZWoTFvb5CFp7MaBV1Yb1AUaamHiCvca7qVIorHtq
 JtbQsxCC0nuzLtN5XhLNqFtceg2id/erUCjmyuUZKSdkQyxM2Ghcl7zVUNwqORo3ed8A
 2OHzw8Don2WizklZHOL/cE4QOgCoQ7PV4OZDmJ6WI+cp6+l5lVIG1aau+wRbTDGU3BeV
 5vURkpuuAWSp6jGlXWwqX4cLpuHENilB/dA99LNhxHRDEfUN3eJlVzZ4CgVS4rOmAflr
 FAAa6nklE0BvaZsHJV3kq91MuBhnYijxcNnmYbgnBWy24yvGO0Y2Ur6rp0XK35eLrddZ
 aRjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6/lnX5iMfYCkh7cX2R68uvqYS+m/f0FXrollYm5W3k6+IG7wmIigmct9TtVWzWpqmeqfUiwz+Lkp/@nongnu.org
X-Gm-Message-State: AOJu0Yx9r+eUNwlQ3+VkKN/a0HJ/tXqk4UjcoGaxIkZeM6cdDqUJGZUx
 6WQhvqfw0MQuE++CSdqfF7+ETcJDWZ8D93ZtAdSelYjuPQF9vz43HIlRPqw54bsxX7c5MTJFAyE
 uF3s+lW8McPh0cshzVdxxsuuum8AQamJwpVD76RMGeEPVfgYJCxB75E2XOBGsEymCcV00ZULx+E
 dx5ffgDlXIe+2HWlJ+4si3towzRB8=
X-Gm-Gg: ASbGncujXwf/rHkxw+ucR6UaC8/fe45H4dV23VGVVAXiaQ8YG6ybMb8MKYI0TE3tCqi
 KBoI2NZcFZwuIJ2cfbRyn+3SEZznLm57QWHXlbifNEQnwu6Csc6S7uSOY7IzfIc5/CpQUMqk=
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22780e38317mr292878625ad.51.1742990616130; 
 Wed, 26 Mar 2025 05:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAFVK/FaCc+9hBPVt3oJ+raT5HxFeatdiIe434t5oZtYpjzXOSe4jM2w0zD+veGCcZXsz3/wqqVfzAxCBOUMo=
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22780e38317mr292877855ad.51.1742990615185; Wed, 26 Mar 2025
 05:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-4-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:02:58 +0100
X-Gm-Features: AQ5f1JrEV7UIbZ4lVI9nLOmckberkisXgYu4ms1nqOMT9_e6OcOx-bAUclzSMHE
Message-ID: <CAJaqyWeRhwjTK8CZKNbDzv620664h90PkdWq+gHBs-n6JdkSsA@mail.gmail.com>
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Implement the insertion of available buffers in the descriptor area of
> packed shadow virtqueues. It takes into account descriptor chains, but
> does not consider indirect descriptors.
>
> Enable the packed SVQ to forward the descriptors to the device.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v4 -> v5:
> - This was commit #2 in v4. This has been reordered to commit #3
>   based on review comments.
> - vhost-shadow-virtqueue.c:
>   (vhost_svq_valid_features): Move addition of enums to commit #6
>   based on review comments.
>   (vhost_svq_add_packed): Set head_idx to buffer id instead of vring's
>   index.
>   (vhost_svq_kick): Split into vhost_svq_kick_split and
>   vhost_svq_kick_packed.
>   (vhost_svq_add): Use new vhost_svq_kick_* functions.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++--
>  1 file changed, 112 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 4f74ad402a..6e16cd4bdf 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtqueu=
e *svq,
>      /* Update the avail index after write the descriptor */
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> +}
> +
> +/**
> + * Write descriptors to SVQ packed vring
> + *
> + * @svq: The shadow virtqueue
> + * @out_sg: The iovec to the guest
> + * @out_num: Outgoing iovec length
> + * @in_sg: The iovec from the guest
> + * @in_num: Incoming iovec length
> + * @sgs: Cache for hwaddr
> + * @head: Saves current free_head
> + */
> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                 const struct iovec *out_sg, size_t out_=
num,
> +                                 const struct iovec *in_sg, size_t in_nu=
m,
> +                                 hwaddr *sgs, unsigned *head)
> +{
> +    uint16_t id, curr, i, head_flags =3D 0, head_idx;
> +    size_t num =3D out_num + in_num;
> +    unsigned n;
> +
> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> +
> +    head_idx =3D svq->vring_packed.next_avail_idx;
> +    i =3D head_idx;
> +    id =3D svq->free_head;
> +    curr =3D id;
> +    *head =3D id;
> +
> +    /* Write descriptors to SVQ packed vring */
> +    for (n =3D 0; n < num; n++) {
> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_flag=
s |
> +                                     (n < out_num ? 0 : VRING_DESC_F_WRI=
TE) |
> +                                     (n + 1 =3D=3D num ? 0 : VRING_DESC_=
F_NEXT));
> +        if (i =3D=3D head_idx) {
> +            head_flags =3D flags;
> +        } else {
> +            descs[i].flags =3D flags;
> +        }
> +
> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> +        descs[i].id =3D id;
> +        if (n < out_num) {
> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
> +        } else {
> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
> +        }
> +
> +        curr =3D cpu_to_le16(svq->desc_next[curr]);
> +
> +        if (++i >=3D svq->vring_packed.vring.num) {
> +            i =3D 0;
> +            svq->vring_packed.avail_used_flags ^=3D
> +                1 << VRING_PACKED_DESC_F_AVAIL |
> +                1 << VRING_PACKED_DESC_F_USED;
> +        }
> +    }
>
> +    if (i <=3D head_idx) {
> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> +    }
> +
> +    svq->vring_packed.next_avail_idx =3D i;
> +    svq->shadow_avail_idx =3D i;
> +    svq->free_head =3D curr;
> +
> +    /*
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
> +     */
> +    smp_wmb();
> +    svq->vring_packed.vring.desc[head_idx].flags =3D head_flags;
>  }
>
> -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
>  {
>      bool needs_kick;
>
> @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>          uint16_t avail_event =3D le16_to_cpu(
>                  *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
> -        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail_i=
dx, svq->shadow_avail_idx - 1);
> +        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail_i=
dx,
> +                     svq->shadow_avail_idx - 1);
>      } else {
>          needs_kick =3D
>                  !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_N=
OTIFY));
> @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq=
)
>      event_notifier_set(&svq->hdev_kick);
>  }
>
> +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
> +{
> +    bool needs_kick;
> +
> +    /*
> +     * We need to expose the available array entries before checking
> +     * notification suppressions.
> +     */
> +    smp_mb();
> +
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        return;

It's weird SVQ does not need to kick if _F_EVENT_IDX. This should have
code checking the device ring flags etc.

> +    } else {
> +        needs_kick =3D (svq->vring_packed.vring.device->flags !=3D
> +                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
> +    }
> +
> +    if (!needs_kick) {
> +        return;
> +    }
> +
> +    event_notifier_set(&svq->hdev_kick);
> +}
> +
>  /**
>   * Add an element to a SVQ.
>   *
> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
struct iovec *out_sg,
>          return -EINVAL;
>      }
>
> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> -                        in_num, sgs, &qemu_head);
> +    if (svq->is_packed) {
> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> +                             in_num, sgs, &qemu_head);
> +    } else {
> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                            in_num, sgs, &qemu_head);
> +    }
>
>      svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
>      svq->desc_state[qemu_head].ndescs =3D ndescs;
> -    vhost_svq_kick(svq);
> +    if (svq->is_packed) {
> +        vhost_svq_kick_packed(svq);
> +    } else {
> +        vhost_svq_kick_split(svq);
> +    }
>      return 0;
>  }
>
> --
> 2.48.1
>


