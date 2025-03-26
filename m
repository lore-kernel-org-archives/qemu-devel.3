Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92456C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOtR-0005ZX-GN; Wed, 26 Mar 2025 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txOtN-0005ZH-Bu
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txOtL-0006ED-Gx
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742988349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD/7nvPVW9fep+uEZMyWP3w9EGMOQduv4LVRjkhbt1Q=;
 b=ezl6iHuUmsGoVQmtFjhcuPcpRdIMqMlAXxBiql5X9bOzhrO88oDXWrxlbK4duL0GkR9UeM
 ANbqIc+T8tGVR/PSsR3WJD9+Fj7Ao1ua47PhkvvJbsnJlQuuUp0PTjj56W2JnkYduH2lj/
 /EcJDnrCfLOGTFf7r7CLd/R71fVVTmE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-fcKJhLxgNHG5O73DqHr0xQ-1; Wed, 26 Mar 2025 07:25:47 -0400
X-MC-Unique: fcKJhLxgNHG5O73DqHr0xQ-1
X-Mimecast-MFC-AGG-ID: fcKJhLxgNHG5O73DqHr0xQ_1742988346
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2254e500a73so83433895ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988346; x=1743593146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jD/7nvPVW9fep+uEZMyWP3w9EGMOQduv4LVRjkhbt1Q=;
 b=hZn3Jzvsn0CFcsV6/ob6sjqMnTaHmv/AqnSfV0GhTR8hsvX+T6gCNxwLyyWsVaZzy2
 oD4d+ZRj2vbSXE18j0C0C6KNSAPdOVvL7EI/MRdVmvrsIhNZJD9rkThrra1SMI6rYYXI
 L+n5SvPEznjL4/3bR9MN/KPGTZJA3vX3KZPKZ2y9tTscgZX/ebZUjY70uKQLMzNkAS6t
 0oInoHTbQ2WJVzVJ9qH+k6dnaXlS5QJyWX6ZadP/yoobfmWUwa4OW4I4PAU2OmjQ3e1U
 PnJgSedeGjq/wdxsSzR90ulf/mR8vFFfnQIIPIljiVrkeCJ1jF7HvYwpz0EkYW0g5spi
 0ZIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV15w5OnspRFeeT0MuNzzJuS3PeQM9kO7t9UcLs06faohPqDTOdrGnQ3iS30sX2hiRgdKsQwmGjZD8P@nongnu.org
X-Gm-Message-State: AOJu0YxoR52ZKn0nDKlOaPzA4Qj/KK9gzGiCg5CG4WTM/yakjBKZ/Bxq
 JHRbMoWO96xBHmCnUhrDS5Z2pjE+9JVr3CGBL2sMFxQmbcFIIH4g1kK12jYe6S9KDQE32b8rpt5
 hMFD6nnmZ1KZ8de/ak1yat5Gab0eO7DuC7cWy6dKqa5pXQPAhLw9zRl9QilbX0JMZM77MD9apxw
 SS3iX7TAuWdiyxtBe/vJFk5wYmm90=
X-Gm-Gg: ASbGncvreftmhN42GpWWdzLRKWb1kwzGAgAASCT5FqOxW+K5IB1s8EMiGrovzywHjya
 IWJo7MtTtsvtoyN7N/clQ5ahPSmvbftk/zlOTkWcN4QjHf0a5DWf54vW09AAqsQwApUY3qCs=
X-Received: by 2002:a17:903:2346:b0:223:fb3a:8631 with SMTP id
 d9443c01a7336-22780da4870mr340373255ad.24.1742988345946; 
 Wed, 26 Mar 2025 04:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBQRwQHxU00hROnZIyGH1xtGjZao7lg/C1G7Ptdld8iDPGtO4tnW/KcOX0AwIVBCKq3jgbVmUo5SPRUKWzt48=
X-Received: by 2002:a17:903:2346:b0:223:fb3a:8631 with SMTP id
 d9443c01a7336-22780da4870mr340372525ad.24.1742988345324; Wed, 26 Mar 2025
 04:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-2-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-2-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 12:25:07 +0100
X-Gm-Features: AQ5f1JqE_rUx9zXXx6oYVbJeEhjaMSodp_fYFctOmgfPmu9T7zIxqWATwNUeSI8
Message-ID: <CAJaqyWc0sH0o9MnnJPO8jLbpQVyec+QeG_TE2hnWxoiBqmivFA@mail.gmail.com>
Subject: Re: [RFC v5 1/7] vhost: Refactor vhost_svq_add_split
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

On Mon, Mar 24, 2025 at 2:59=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> This commit refactors vhost_svq_add_split and vhost_svq_add to simplify
> their implementation and prepare for the addition of packed vqs in the
> following commits.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> No changes from v4 -> v5.
>

You can carry the Acked-by from previous series if you make no changes
(or even small changes).

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  hw/virtio/vhost-shadow-virtqueue.c | 107 +++++++++++------------------
>  1 file changed, 41 insertions(+), 66 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 2481d49345..4f74ad402a 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -139,87 +139,48 @@ static bool vhost_svq_translate_addr(const VhostSha=
dowVirtqueue *svq,
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
> - * @addr: Descriptors' GPAs, if backed by guest memory
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
> -                                        const hwaddr *addr, bool more_de=
scs,
> -                                        bool write)
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
> -    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, addr);
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
>          i =3D svq->desc_next[i];
>      }
>
>      svq->free_head =3D svq->desc_next[last];
> -    return true;
> -}
> -
> -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> -                                const struct iovec *out_sg, size_t out_n=
um,
> -                                const hwaddr *out_addr,
> -                                const struct iovec *in_sg, size_t in_num=
,
> -                                const hwaddr *in_addr, unsigned *head)
> -{
> -    unsigned avail_idx;
> -    vring_avail_t *avail =3D svq->vring.avail;
> -    bool ok;
> -    g_autofree hwaddr *sgs =3D g_new(hwaddr, MAX(out_num, in_num));
> -
> -    *head =3D svq->free_head;
> -
> -    /* We need some descriptors here */
> -    if (unlikely(!out_num && !in_num)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "Guest provided element with no descriptors");
> -        return false;
> -    }
> -
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_ad=
dr,
> -                                     in_num > 0, false);
> -    if (unlikely(!ok)) {
> -        return false;
> -    }
> -
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,=
 false,
> -                                     true);
> -    if (unlikely(!ok)) {
> -        return false;
> -    }
>
>      /*
>       * Put the entry in the available array (but don't update avail->idx=
 until
> @@ -233,7 +194,6 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue =
*svq,
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
>
> -    return true;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -276,16 +236,31 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
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
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in=
_num,
> -                             in_addr, &qemu_head);
> +    g_autofree hwaddr *sgs =3D g_new(hwaddr, ndescs);
> +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num, out_addr)=
;
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
>
> +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num, i=
n_addr);
> +    if (unlikely(!ok)) {
> +        return -EINVAL;
> +    }
> +
> +    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                        in_num, sgs, &qemu_head);
> +
>      svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
>      svq->desc_state[qemu_head].ndescs =3D ndescs;
> --
> 2.48.1
>


