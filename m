Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B9CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKvoC-0001tO-Gm; Tue, 10 Dec 2024 03:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKvoA-0001sw-Pc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKvo8-0002nF-F6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733820084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NjwMjuY+2pkiqrA57IjL2SpBxulohpGIoPPjxRZ6Ik=;
 b=V2jmPXZSX80tdZ+MUHKBM6KtXQhYs9EAuUROXm65UkC2Ud0iGfQPHQykYmYJmcS5rkomHp
 PW4vXxNkBi8JCrxKqeJEMqRRKu4yXVKAgVXNvQZY7yCQnUQThg0MoqHOWhoHKX/TMjlD2h
 ztVMNgexsflPo7++F4kuRwLQ6PtCG2A=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-p2n-bM9RPXe6l7yCX4wkbg-1; Tue, 10 Dec 2024 03:41:22 -0500
X-MC-Unique: p2n-bM9RPXe6l7yCX4wkbg-1
X-Mimecast-MFC-AGG-ID: p2n-bM9RPXe6l7yCX4wkbg
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6ef55459400so13789427b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820081; x=1734424881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NjwMjuY+2pkiqrA57IjL2SpBxulohpGIoPPjxRZ6Ik=;
 b=vpPi0kRyGaDh7KQgDWXIrmL1GDXSHoK2Hwv0xoQqJ3Yfywi2GVwWogqRRxhDnjEk3w
 poOW+Xnz0oUtVznv054FaVevwN65Gnmvay09U2C1TI3KLQv7q93NdVh+C0oJywsE8HZ9
 D7qDoAejlxOs5iAyFXPHpUOzQy6QMi94qKGvP543/7H3hunRGo9zi5/41VCsNBtX7FIK
 WGKhW6h2WTMaDP9Tf3qPyYC07v2d10TZmX8Mef+mrhNLPi8vHsRBm60q8hCRAkR8R4jE
 LmwmP87SNwRzqJE74+8xp8DsQXgA0wzcuzFKvlgNpGoJzScs1eyVjuY93Q5Y7oZ20UTt
 uJGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd+A9BARHmDT3v36v51lhceRTxx2Zens01p1KforYxXaIsPtohL3JOASWRfmRHaRxi4ehowYweuJnD@nongnu.org
X-Gm-Message-State: AOJu0Yy/6i8vnQk0FwByJH+D89b6sj9V/zKGO2w966nfPKtereRbZVeY
 T861KMAz/h1e5tSKcGtbFkgIwpAW1/K+n8FP7cOwO6B1M0sM9vvsRy0sD6xROcy0gguhXoIHJV8
 nY559CLwG8aXh0qNjGTRSQQSOAzGDI/9EBVDjmiSu0cKXSBf2aDWPy9swmu48k4yZSwJBTXEiNl
 XjN14s9vnaJd7zWSQaF1inz9GF1Jg=
X-Gm-Gg: ASbGncuwMv9grIulbQwFpziuNqHmPmVh8ZDdItRDC7XyxwmZfG0EsD8YQGR7m0/2wh5
 v//jf3XfsUlrfSD1CY28DmraEXtVaGKMX26U=
X-Received: by 2002:a05:690c:6485:b0:6ee:bcdd:b1fb with SMTP id
 00721157ae682-6f022eb1248mr33948597b3.19.1733820081704; 
 Tue, 10 Dec 2024 00:41:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAlxLdVVp28kAU4q1X4/m32DHGMTJrCI1dzmqDzaWAArU7u2bTD7GehxAZieM/c44yGhM62oTjzlf++8NC2j8=
X-Received: by 2002:a05:690c:6485:b0:6ee:bcdd:b1fb with SMTP id
 00721157ae682-6f022eb1248mr33948527b3.19.1733820081430; Tue, 10 Dec 2024
 00:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <20241205203430.76251-2-sahilcdq@proton.me>
In-Reply-To: <20241205203430.76251-2-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Dec 2024 09:40:45 +0100
Message-ID: <CAJaqyWc5Lqe36A1cvJF767uWO2dHZZX17gX4CxzmjSLYnp8cmQ@mail.gmail.com>
Subject: Re: [RFC v4 1/5] vhost: Refactor vhost_svq_add_split
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> This commit refactors vhost_svq_add_split and
> vhost_svq_add to simplify their implementation
> and prepare for the addition of packed vqs in
> following commits.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v3 -> v4:
> - Split commit #1 in v3 into 2 commits.
> - Changes related to "vhost_svq_add_packed" are
>   now in commit #2.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 102 ++++++++++++-----------------
>  1 file changed, 41 insertions(+), 61 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 37aca8b431..bb7cf6d5db 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -124,83 +124,48 @@ static bool vhost_svq_translate_addr(const VhostSha=
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
> -}
> -
> -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> -                                const struct iovec *out_sg, size_t out_n=
um,
> -                                const struct iovec *in_sg, size_t in_num=
,
> -                                unsigned *head)
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
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num=
 > 0,
> -                                     false);
> -    if (unlikely(!ok)) {
> -        return false;
> -    }
> -
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, t=
rue);
> -    if (unlikely(!ok)) {
> -        return false;
> -    }
>
>      /*
>       * Put the entry in the available array (but don't update avail->idx=
 until
> @@ -214,7 +179,6 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue =
*svq,
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
>
> -    return true;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -254,15 +218,31 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
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
> +    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                        in_num, sgs, &qemu_head);
> +
>      svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
>      svq->desc_state[qemu_head].ndescs =3D ndescs;
> --
> 2.47.0
>


