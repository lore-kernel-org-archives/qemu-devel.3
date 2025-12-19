Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE19AD74967
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVbs-0006SM-MX; Fri, 19 Dec 2025 03:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbr-0006S6-7s
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbp-0005cX-6v
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766131988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6sbY5sby1vFYEN1zB7J303W7ugyqHML0BkctnlaIXM=;
 b=ToOa4zUTl+2qO3HuPzL2MKBOOIXWYn6pXRWp5rX4LGDzzmKlAmKnOdLM3kgaCr2kDfBHFl
 8sbdECg0Dvx219a5R2f4N9ESTdLYpwUku5zG3rklzWxNBnOCrt+SXwtAMrEECavmp13iRu
 Mk8SK3L3DpKZFqfV/18mAbfuNCwFedw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-qAg2M9BZO9ebWBfLxYdhug-1; Fri, 19 Dec 2025 03:13:06 -0500
X-MC-Unique: qAg2M9BZO9ebWBfLxYdhug-1
X-Mimecast-MFC-AGG-ID: qAg2M9BZO9ebWBfLxYdhug_1766131985
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64558391a78so2172850d50.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766131985; x=1766736785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6sbY5sby1vFYEN1zB7J303W7ugyqHML0BkctnlaIXM=;
 b=GaujZqE44kJetBVuxUw51WkkrLRi4lUYH0uAky4vZ6pkZir0t1e1CwfgshabzlL5kc
 +9dGb7lJqmaEHIqVNGFqJnkiSJ8Pu2LSuhP9aknBwUtqLdFD8WZbIpnQPPs/PlBFxkiW
 KB7pyry1lvP4ZoZMwibjfuB8V+TV6dA6+V3vqw1dXFeC0dtS4jmMeYsrCpcYS/jY8Pvr
 zJ7D7gGaTmaOhat75HR1oSP+ZMOH4jy10VAMqPNA7bqxokFOYr5WXQvLYXLXnxx59i2f
 vb12LZ3sME8fqfsFpK3u9LtHukfR6UMtWqTXliRjiyOX+1YAWGkgiC5aha68oNZt4hVm
 BLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766131985; x=1766736785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6sbY5sby1vFYEN1zB7J303W7ugyqHML0BkctnlaIXM=;
 b=B1vsT9xT3+Qt6SyaM/hRAY9FIzHNg2V/iB/QnUvNFmYknAMPSvNy/ZSx0A1mHm+kYA
 ge54kpuN5wvTwDeS8ADk+kz3eTdiuvHwRpvSSVObLSYr3Yixi8LgsiAH9DPJtIt6xZ1A
 8L6PGTgPHY3K0IMeJmpa5YIOxsNU2Ol91WBMBuxeapK6ZNlaa+qPJ5kgYVQBim9LuGYJ
 oJKapGlzcPBd1vtN/fgW4nReZ3nFVrje/OreJUpnBPic3UxZnebNCHyPb40YUzlI6OSQ
 lFaPoYdRFok8JEutYFOKxIInm21JisHXmLhni+CrotKEmMDTJyY3hSXh4srZLdxLOkrH
 g4uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT+MgDGsgXTC/Z3edKw5+Q6D8ltT14WlYZtpgQeEVEOGcLk0BzGS0KneiJAeElsgGcKkp1x4eMHZdB@nongnu.org
X-Gm-Message-State: AOJu0YxH2es7v0+LcbjClb1Ox8U5wsYiaQ6plee4EXvLXI9f4tB9vAi7
 XqxC4jsvl/3uUhEz5Ok+8qjnHrK+9ax4NTnlwtLmfrlUiSdiMlmAYXvGEmRsejbJ1Sh6Kr3MMzF
 +vSu0giMWE9l+Lz+KWA7gYygjkXwE/S5FPJYZrh/sWy9l2vIhWSqqfJO5lAaAldZl9D4XdZQg/I
 p3Cu+OkIMz1XupwHcfUzfnACm8Bk63vp0=
X-Gm-Gg: AY/fxX5ETQYHcbWdFqpbIo2ZQG33gIJUbxrVuJCMQ2K9+SMM4+xjX5ntu4oaBJMijw7
 BC6gpWLw9+9Y9jsrrspdtFnt7RkC9JHynZPyiADPEsXrluzLrMn2AOht2QyU26pVVGieuf7FdD/
 FKNAcq2cRAWES+Of6X3YuEKhb+fTJnaDbZczC66ral73KA8s9Aco2RsXKxlJcNIqUTDIU=
X-Received: by 2002:a05:690e:2545:b0:645:51b2:8042 with SMTP id
 956f58d0204a3-6466a83297bmr1232117d50.9.1766131985427; 
 Fri, 19 Dec 2025 00:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7DoXRIqJZCK6EBmSoQi6mm0+xPIfYP31jUTjfPBDZVswQZdh6rDxka/enAOy28fS1azgw1RRtIENSWXI6INA=
X-Received: by 2002:a05:690e:2545:b0:645:51b2:8042 with SMTP id
 956f58d0204a3-6466a83297bmr1232105d50.9.1766131985073; Fri, 19 Dec 2025
 00:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20251216015907.6662-1-wafer@jaguarmicro.com>
In-Reply-To: <20251216015907.6662-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 09:12:28 +0100
X-Gm-Features: AQt7F2p9YSKuO0ZRMr5oELO6FoFjb3bVeesRyYR8NGRzLBIYd2zhor20AKCmA9o
Message-ID: <CAJaqyWfFiNbi74q+zk99iNkQn4C-czxAOrK3CsyDVmBKkqThSA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vhost: SVQ add the indirect descriptors to
 available ring
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Dec 16, 2025 at 2:59=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> From: wafer Xie <wafer@jaguarmicro.com>
>
> Retrieve the target buffer from the indirect buffers by index,
> add the elements sent by the guest into the buffer=E2=80=99s indirect des=
criptors,
> and update freed_head and freed_number. If freed_number is zero,
> or if the current buffer=E2=80=99s freed_number is less than the number o=
f elements,
> update the buffer state to SVQ_INDIRECT_BUF_FREEING.
>
> Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 257 ++++++++++++++++++++++++++---
>  1 file changed, 235 insertions(+), 22 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index adee52f50b..c6064fb839 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -189,36 +189,246 @@ static bool vhost_svq_vring_write_descs(VhostShado=
wVirtqueue *svq, hwaddr *sg,
>      return true;
>  }
>
> -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> +/**
> + * Write descriptors to indirect descriptor table
> + *
> + * @svq: The shadow virtqueue
> + * @sg: Cache for hwaddr
> + * @iovec: The iovec from the guest
> + * @num: iovec length
> + * @addr: Descriptors' GPAs, if backed by guest memory
> + * @buf: The indirect descriptor buffer
> + * @offset_idx: Offset for write position
> + * and next field (0 for out, out_num for in)
> + * @more_descs: True if more descriptors come in the chain
> + * @write: True if they are writeable descriptors
> + *
> + * Return true if success, false otherwise and print error.
> + */
> +static bool vhost_svq_vring_write_indirect_descs(VhostShadowVirtqueue *s=
vq,
> +                                                  hwaddr *sg,
> +                                                  const struct iovec *io=
vec,
> +                                                  size_t num,
> +                                                  const hwaddr *addr,
> +                                                  SVQIndirectDescBuf *bu=
f,
> +                                                  size_t offset_idx,
> +                                                  bool more_descs,
> +                                                  bool write)
> +{
> +    bool ok;
> +    uint16_t flags =3D write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
> +    vring_desc_t *descs =3D buf->desc;
> +    uint16_t i =3D buf->freed_head + offset_idx;
> +
> +    if (num =3D=3D 0) {
> +        return true;
> +    }
> +
> +    ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, addr);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    for (size_t n =3D 0; n < num; n++) {
> +        descs[i].addr =3D cpu_to_le64(sg[n]);
> +        descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
> +        if (more_descs || (n + 1 < num)) {
> +            descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_NEXT);
> +            descs[i].next =3D cpu_to_le16(offset_idx + n + 1);
> +        } else {
> +            descs[i].flags =3D flags;
> +        }
> +        i++;
> +    }
> +
> +    return true;

Most of this function is the same as current
vhost_svq_vring_write_descs in master. Why not make a common one that
accepts vring_desc_t * as a parameter and make the two of them call
it?

> +}
> +
> +/**
> + * Add descriptors to SVQ vring using indirect descriptors (dual-buffer)
> + *
> + * @svq: The shadow virtqueue
> + * @out_sg: The out iovec from the guest
> + * @out_num: The out iovec length
> + * @out_addr: The out descriptors' GPAs
> + * @in_sg: The in iovec from the guest
> + * @in_num: The in iovec length
> + * @in_addr: The in descriptors' GPAs
> + * @sgs: Cache for hwaddr
> + * @buf_idx: Index of the indirect buffer to use
> + *
> + * Return true if success, false otherwise and print error.
> + */
> +static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue *svq,
> +                                         const struct iovec *out_sg,
> +                                         size_t out_num,
> +                                         const hwaddr *out_addr,
> +                                         const struct iovec *in_sg,
> +                                         size_t in_num,
> +                                         const hwaddr *in_addr,
> +                                         hwaddr *sgs, int buf_idx)
> +{
> +    SVQIndirectDescBuf *buf =3D &svq->indirect_bufs[buf_idx];
> +    uint16_t start_idx =3D buf->freed_head;
> +    size_t total_descs =3D out_num + in_num;
> +    hwaddr indirect_iova;
> +    bool ok;
> +
> +    /* Populate indirect descriptor table for out descriptors */
> +    ok =3D vhost_svq_vring_write_indirect_descs(svq, sgs, out_sg, out_nu=
m,
> +                                               out_addr, buf, 0,
> +                                               in_num > 0, false);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    /* Populate indirect descriptor table for in descriptors */
> +    ok =3D vhost_svq_vring_write_indirect_descs(svq, sgs, in_sg, in_num,
> +                                               in_addr, buf, out_num,
> +                                               false, true);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    /* Calculate IOVA for this indirect descriptor range */
> +    indirect_iova =3D buf->iova + start_idx * sizeof(vring_desc_t);
> +
> +    /* Add a single descriptor pointing to the indirect table */
> +    svq->vring.desc[svq->free_head].addr =3D cpu_to_le64(indirect_iova);
> +    svq->vring.desc[svq->free_head].len =3D
> +            cpu_to_le32(total_descs * sizeof(vring_desc_t));
> +    svq->vring.desc[svq->free_head].flags =3D cpu_to_le16(VRING_DESC_F_I=
NDIRECT);
> +
> +    /* Store indirect descriptor info in desc_state */
> +    svq->desc_state[svq->free_head].indirect_buf_idx =3D buf_idx;
> +
> +    /* Update buffer state */
> +    buf->freed_head =3D start_idx + total_descs;
> +    buf->freed_descs -=3D total_descs;
> +
> +    /* Move free_head forward */
> +    svq->free_head =3D svq->desc_next[svq->free_head];
> +
> +    return true;

Same here, most logic is duplicated in vhost_svq_add_split even when
vhost_svq_add_split calls vhost_svq_add_split_indirect.

> +}
> +
> +/**
> + * Try to get a freed indirect buffer for use
> + *
> + * @svq: The shadow virtqueue
> + * @total_descs: Number of descriptors needed
> + *
> + * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1)
> + * if available, -1 if none available.
> + */
> +static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq,
> +                                      size_t total_descs)
> +{
> +    int cur =3D svq->current_indirect_buf;
> +    SVQIndirectDescBuf *buf;
> +
> +    if (!svq->indirect_enabled) {
> +        return -1;
> +    }
> +
> +    /* Try current buffer first if it's in FREED state */
> +    if (cur >=3D 0) {
> +        buf =3D &svq->indirect_bufs[cur];
> +        if (buf->state =3D=3D SVQ_INDIRECT_BUF_FREED) {
> +            /* Check if we have enough free descriptors */
> +            if (buf->freed_descs >=3D total_descs) {
> +                return cur;
> +            }
> +            /* Not enough space, switch to FREEING and try next buffer *=
/
> +            buf->state =3D SVQ_INDIRECT_BUF_FREEING;
> +        }
> +    }
> +
> +    /* Try all other buffers */
> +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> +        if (i =3D=3D cur) {
> +            continue;
> +        }
> +        buf =3D &svq->indirect_bufs[i];
> +        if (buf->state =3D=3D SVQ_INDIRECT_BUF_FREED &&
> +            buf->freed_descs >=3D total_descs) {
> +            svq->current_indirect_buf =3D i;
> +            return i;
> +        }
> +    }
> +

Why not store the free indirect descriptors as a linked list instead
of a circular buffer, the same way as regular descriptors? That way we
don't need to traverse all the circular buffer. Also, we reduce the
complexity as you don't need to keep the state in each descriptor or
the SVQ_INDIRECT_BUF_FREEING state.


> +    /* All buffers unavailable, fallback to chain mode */
> +    return -1;
> +}
> +
> +static int vhost_svq_add_split(VhostShadowVirtqueue *svq,
>                                  const struct iovec *out_sg, size_t out_n=
um,
>                                  const hwaddr *out_addr,
>                                  const struct iovec *in_sg, size_t in_num=
,
> -                                const hwaddr *in_addr, unsigned *head)
> +                                const hwaddr *in_addr, unsigned *head,
> +                                bool *used_indirect)
>  {
>      unsigned avail_idx;
>      vring_avail_t *avail =3D svq->vring.avail;
>      bool ok;
>      g_autofree hwaddr *sgs =3D g_new(hwaddr, MAX(out_num, in_num));
> +    size_t total_descs =3D out_num + in_num;
> +    int indirect_buf_idx =3D -1;
>
>      *head =3D svq->free_head;
> +    *used_indirect =3D false;
>
>      /* We need some descriptors here */
>      if (unlikely(!out_num && !in_num)) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Guest provided element with no descriptors");
> -        return false;
> +        return -EINVAL;
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_ad=
dr,
> -                                     in_num > 0, false);
> -    if (unlikely(!ok)) {
> -        return false;
> +    /* Try to use indirect descriptors if feature is negotiated and tota=
l > 1 */
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_INDIRECT_DESC) =
&&
> +        total_descs > 1) {
> +        indirect_buf_idx =3D vhost_svq_get_indirect_buf(svq, total_descs=
);
>      }
>
> -    ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,=
 false,
> -                                     true);
> -    if (unlikely(!ok)) {
> -        return false;
> +    if (indirect_buf_idx >=3D 0) {
> +        /* Indirect mode: only need 1 main descriptor slot */
> +        if (unlikely(vhost_svq_available_slots(svq) < 1)) {
> +            return -ENOSPC;
> +        }
> +
> +        /* Use indirect mode */
> +        ok =3D vhost_svq_add_split_indirect(svq, out_sg, out_num, out_ad=
dr,
> +                                          in_sg, in_num, in_addr,
> +                                          sgs, indirect_buf_idx);
> +        if (unlikely(!ok)) {
> +            error_report("indirect error, out_num %zu in_num %zu "
> +                         "avail index %u head %u",
> +                         out_num, in_num, svq->shadow_avail_idx, *head);
> +            return -EINVAL;
> +        }
> +        *used_indirect =3D true;
> +    } else {
> +        /* Chain mode: need total_descs descriptor slots */
> +        if (unlikely(vhost_svq_available_slots(svq) < total_descs)) {
> +            return -ENOSPC;
> +        }
> +
> +        /* Use direct (chain) mode */
> +        svq->desc_state[svq->free_head].indirect_buf_idx =3D -1;
> +
> +        ok =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, ou=
t_addr,
> +                                         in_num > 0, false);
> +        if (unlikely(!ok)) {
> +            return -EINVAL;
> +        }
> +
> +        ok =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_a=
ddr,
> +                                         false,
> +                                         true);
> +        if (unlikely(!ok)) {
> +            return -EINVAL;
> +        }
>      }
>
>      /*
> @@ -233,7 +443,7 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue =
*svq,
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
>
> -    return true;
> +    return 0;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -249,7 +459,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>          uint16_t avail_event =3D le16_to_cpu(
>                  *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
> -        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail_i=
dx, svq->shadow_avail_idx - 1);
> +        needs_kick =3D vring_need_event(avail_event, svq->shadow_avail_i=
dx,
> +                                      svq->shadow_avail_idx - 1);
>      } else {
>          needs_kick =3D
>                  !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_N=
OTIFY));
> @@ -274,19 +485,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
struct iovec *out_sg,
>  {
>      unsigned qemu_head;
>      unsigned ndescs =3D in_num + out_num;
> -    bool ok;
> +    int r;
> +    bool used_indirect =3D false;
>
> -    if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
> -        return -ENOSPC;
> +    r =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_=
num,
> +                             in_addr, &qemu_head, &used_indirect);
> +    if (unlikely(r !=3D 0)) {
> +        return r;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in=
_num,
> -                             in_addr, &qemu_head);
> -    if (unlikely(!ok)) {
> -        return -EINVAL;
> +    /* If using indirect, only 1 main descriptor is used; otherwise ndes=
cs */
> +    if (used_indirect) {
> +        svq->num_free -=3D 1;
> +    } else {
> +        svq->num_free -=3D ndescs;
>      }
> -
> -    svq->num_free -=3D ndescs;
>      svq->desc_state[qemu_head].elem =3D elem;
>      svq->desc_state[qemu_head].ndescs =3D ndescs;
>      vhost_svq_kick(svq);
> --
> 2.48.1
>


