Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3AEC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjjK-0001xB-16; Wed, 07 Aug 2024 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjjF-0001w5-DQ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sbjjC-0006H5-AB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723048891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQKg2GQIw1kFQjQ5do1kRO0rDjuPIJiLNnrOpRCIhPQ=;
 b=b3FpJmgcE2sa/BlL29/OpPhpQeTwlzRB3WxhqUXcEPHyHWBclwYlqT6XgAsE5Xy3jZUGYh
 6o/6BBxdT0a5FhdoeWWwFVFSxKkZSNsta+fnsCuXoQN9bT2yeMuS+AThYsDxMycStdExuF
 512XbqjeBoYwyALkwaAD+yMMIFKjtd0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-t_872c14OZ2t6NXZoYF98g-1; Wed, 07 Aug 2024 12:41:28 -0400
X-MC-Unique: t_872c14OZ2t6NXZoYF98g-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5d5545ca462so61661eaf.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723048887; x=1723653687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQKg2GQIw1kFQjQ5do1kRO0rDjuPIJiLNnrOpRCIhPQ=;
 b=FWEMW5lIKJbzXa2G9VPC2mJhmj7wtuW6KzEUI74OIrCzBdhNqNz8I02BWDgZJqKdrs
 QoX1QgTlg5XH+tmqTi9C5CG9x1tSFAyzk6fZ9K8lNUnCXeIpKim4btTg/oayxp8YeDjW
 ODh/Z9QskVbDsEn0C0YKvdHbhMTZf7/waIrsgegYM9RG3YZ/XhhGmc26NYNt5zmruTc8
 S7rsCLKUdJ4d5vvgNZJP/wWjC5fHSszS4xdaUz7gITRtQV2/UJBKFxqRew2y56stQb0y
 QlkY8TbWWG1GaHPfB9Uj/edRf3AGIx+EJWd11+1kWz3SUPl5N398H0uVLSXybzzJd0lZ
 Z9xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFgz4ZsKJgW0dh4blfhekO+lCXgNBcesAgwSf6IaowY61gw62rB/EdqE4b4LOFoLcmPZAg9CVJvz9E@nongnu.org
X-Gm-Message-State: AOJu0YxCYwvs4LgSBqKH4Sd0JZoo71sqgrMZYlP8LXp4tOJRfoW8Eaww
 XdzKTsozzID3Y+mpURd4aIm/cOBCFKSbkK576HUWnLiRoWOI+AM2IbyCvZamwqAK5pNKfa6Gb8t
 Owp+WU2chMlPvRfhI4SO4B2m8uC7T3rz9VEgvtl2rHIbB2HC2yERQ99jla9Jakqzk5N0K04vSn5
 /meiVs+cOufoVnabZVXg9Cv6Vibcs=
X-Received: by 2002:a05:6358:52ca:b0:1a8:b28a:2d84 with SMTP id
 e5c5f4694b2df-1af6ce39c76mr1025740955d.2.1723048887288; 
 Wed, 07 Aug 2024 09:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9gWydBl9F3csvuyFSGiZMHW2dmhVius3+MFd5Lq7bPIFLj0vsdDhZii4U1IUZONg2ktuU0au8VxtS63emYg=
X-Received: by 2002:a05:6358:52ca:b0:1a8:b28a:2d84 with SMTP id
 e5c5f4694b2df-1af6ce39c76mr1025738855d.2.1723048886902; Wed, 07 Aug 2024
 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-2-sahilcdq@proton.me>
In-Reply-To: <20240802112138.46831-2-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 18:40:51 +0200
Message-ID: <CAJaqyWcaz7eqvnUbA3mfWY34oZgvf1wf2BwytEhOB9HV14zevw@mail.gmail.com>
Subject: Re: [RFC v3 1/3] vhost: Introduce packed vq and add buffer elements
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> This is the first patch in a series to add support for packed
> virtqueues in vhost_shadow_virtqueue. This patch implements the
> insertion of available buffers in the descriptor area. It takes
> into account descriptor chains, but does not consider indirect
> descriptors.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v2 -> v3:
> * vhost-shadow-virtqueue.c
>   - Move parts common to "vhost_svq_add_split" and
>     "vhost_svq_add_packed" to "vhost_svq_add".
>   (vhost_svq_add_packed):
>   - Refactor to minimize duplicate code between
>     this and "vhost_svq_add_split"
>   - Fix code style issues.
>   (vhost_svq_add_split):
>   - Merge with "vhost_svq_vring_write_descs()"
>   - Refactor to minimize duplicate code between
>     this and "vhost_svq_add_packed"
>   (vhost_svq_add):
>   - Refactor to minimize duplicate code between
>     split and packed version of "vhost_svq_add"
>
>  hw/virtio/vhost-shadow-virtqueue.c | 174 +++++++++++++++++++----------
>  1 file changed, 115 insertions(+), 59 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..4c308ee53d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -124,97 +124,132 @@ static bool vhost_svq_translate_addr(const VhostSh=
adowVirtqueue *svq,
>  }
>
>  /**
> - * Write descriptors to SVQ vring
> + * Write descriptors to SVQ split vring
>   *
>   * @svq: The shadow virtqueue
> - * @sg: Cache for hwaddr
> - * @iovec: The iovec from the guest
> - * @num: iovec length
> - * @more_descs: True if more descriptors come in the chain
> - * @write: True if they are writeable descriptors
> - *
> - * Return true if success, false otherwise and print error.
> + * @out_sg: The iovec to the guest
> + * @out_num: Outgoing iovec length
> + * @in_sg: The iovec from the guest
> + * @in_num: Incoming iovec length
> + * @sgs: Cache for hwaddr
> + * @head: Saves current free_head
>   */
> -static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwadd=
r *sg,
> -                                        const struct iovec *iovec, size_=
t num,
> -                                        bool more_descs, bool write)
> +static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
> +                                const struct iovec *out_sg, size_t out_n=
um,
> +                                const struct iovec *in_sg, size_t in_num=
,
> +                                hwaddr *sgs, unsigned *head)
>  {
> +    unsigned avail_idx, n;
>      uint16_t i =3D svq->free_head, last =3D svq->free_head;
> -    unsigned n;
> -    uint16_t flags =3D write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
> +    vring_avail_t *avail =3D svq->vring.avail;
>      vring_desc_t *descs =3D svq->vring.desc;
> -    bool ok;
> -
> -    if (num =3D=3D 0) {
> -        return true;
> -    }
> +    size_t num =3D in_num + out_num;
>
> -    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num);
> -    if (unlikely(!ok)) {
> -        return false;
> -    }
> +    *head =3D svq->free_head;
>
>      for (n =3D 0; n < num; n++) {
> -        if (more_descs || (n + 1 < num)) {
> -            descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_NEXT);
> +        descs[i].flags =3D cpu_to_le16(n < out_num ? 0 : VRING_DESC_F_WR=
ITE);
> +        if (n + 1 < num) {
> +            descs[i].flags |=3D cpu_to_le16(VRING_DESC_F_NEXT);
>              descs[i].next =3D cpu_to_le16(svq->desc_next[i]);
> +        }
> +
> +        descs[i].addr =3D cpu_to_le64(sgs[n]);
> +        if (n < out_num) {
> +            descs[i].len =3D cpu_to_le32(out_sg[n].iov_len);
>          } else {
> -            descs[i].flags =3D flags;
> +            descs[i].len =3D cpu_to_le32(in_sg[n - out_num].iov_len);
>          }
> -        descs[i].addr =3D cpu_to_le64(sg[n]);
> -        descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
>
>          last =3D i;
>          i =3D cpu_to_le16(svq->desc_next[i]);
>      }
>
>      svq->free_head =3D le16_to_cpu(svq->desc_next[last]);
> -    return true;
> +
> +    /*
> +     * Put the entry in the available array (but don't update avail->idx=
 until
> +     * they do sync).
> +     */
> +    avail_idx =3D svq->shadow_avail_idx & (svq->vring.num - 1);
> +    avail->ring[avail_idx] =3D cpu_to_le16(*head);
> +    svq->shadow_avail_idx++;
> +
> +    /* Update the avail index after write the descriptor */
> +    smp_wmb();
> +    avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
>  }
>

I think this code is already in a very good shape. But actual testing
is needed before acks.

As a suggestion, we can split it into:
1) Refactor in vhost_svq_translate_addr to support out_num+in_num. No
functional change.
2) Refactor vhost_svq_add_split to extract common code into
vhost_svq_add. No functional change.
3) Adding packed code.

How to split or merge the patches is not a well-defined thing, so I'm
happy with this patch if you think the reactor is not worth it.

> -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
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
>                                  const struct iovec *out_sg, size_t out_n=
um,
>                                  const struct iovec *in_sg, size_t in_num=
,
> -                                unsigned *head)
> +                                hwaddr *sgs, unsigned *head)
>  {
> -    unsigned avail_idx;
> -    vring_avail_t *avail =3D svq->vring.avail;
> -    bool ok;
> -    g_autofree hwaddr *sgs =3D g_new(hwaddr, MAX(out_num, in_num));
> +    uint16_t id, curr, i, head_flags =3D 0;
> +    size_t num =3D out_num + in_num;
> +    unsigned n;
>
> -    *head =3D svq->free_head;
> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
>
> -    /* We need some descriptors here */
> -    if (unlikely(!out_num && !in_num)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "Guest provided element with no descriptors");
> -        return false;
> -    }
> +    *head =3D svq->vring_packed.next_avail_idx;
> +    i =3D *head;
> +    id =3D svq->free_head;
> +    curr =3D id;
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num=
 > 0,
> -                                     false);
> -    if (unlikely(!ok)) {
> -        return false;
> +    /* Write descriptors to SVQ packed vring */
> +    for (n =3D 0; n < num; n++) {
> +        uint16_t flags =3D cpu_to_le16(svq->vring_packed.avail_used_flag=
s |
> +                                     (n < out_num ? 0 : VRING_DESC_F_WRI=
TE) |
> +                                     (n + 1 =3D=3D num ? 0 : VRING_DESC_=
F_NEXT));
> +        if (i =3D=3D *head) {
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
> +                    1 << VRING_PACKED_DESC_F_AVAIL |
> +                    1 << VRING_PACKED_DESC_F_USED;
> +        }
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, t=
rue);
> -    if (unlikely(!ok)) {
> -        return false;
> +    if (i <=3D *head) {
> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
>      }
>
> +    svq->vring_packed.next_avail_idx =3D i;
> +    svq->free_head =3D curr;
> +
>      /*
> -     * Put the entry in the available array (but don't update avail->idx=
 until
> -     * they do sync).
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
>       */
> -    avail_idx =3D svq->shadow_avail_idx & (svq->vring.num - 1);
> -    avail->ring[avail_idx] =3D cpu_to_le16(*head);
> -    svq->shadow_avail_idx++;
> -
> -    /* Update the avail index after write the descriptor */
>      smp_wmb();
> -    avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
> -
> -    return true;
> +    svq->vring_packed.vring.desc[*head].flags =3D head_flags;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -254,15 +289,36 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
struct iovec *out_sg,
>      unsigned ndescs =3D in_num + out_num;
>      bool ok;
>
> +    /* We need some descriptors here */
> +    if (unlikely(!ndescs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Guest provided element with no descriptors");
> +        return -EINVAL;
> +    }
> +
>      if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
>          return -ENOSPC;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head);
> +    g_autofree hwaddr *sgs =3D g_new(hwaddr, ndescs);
> +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
>
> +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num);
> +    if (unlikely(!ok)) {
> +        return -EINVAL;
> +    }
> +
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> +                             in_num, sgs, &qemu_head);
> +    } else {
> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                            in_num, sgs, &qemu_head);
> +    }
> +
>      svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
>      svq->desc_state[qemu_head].ndescs =3D ndescs;
> --
> 2.45.2
>


