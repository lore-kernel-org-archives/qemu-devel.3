Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BB1D4116C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgL2T-0001e4-6a; Thu, 15 Jan 2026 05:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vgL2K-0001aK-8T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vgL2H-0007kV-PR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768474621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLhI+vqx7S3bTTod1vZ41rrRGMbgZVgw7nX1pjEfkyE=;
 b=FD3OrcnoMBRoAC1LJsE1PWhSPSMkBBCuZ+b9x/VstzEVJGmQBx1dCHDR+cMp7eVBdym0iX
 dFKN8BySCxxt7XEUIqglRQgSvY2xOE+ySMeC9ve2MUMI7hDZQvsfH16+NSu9XM49DypSWz
 MaFr/tnBgat+ZxUGOnqeu9xLG75v5fw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-3GPNdnVnN2y4eMuxBD54gg-1; Thu, 15 Jan 2026 05:56:58 -0500
X-MC-Unique: 3GPNdnVnN2y4eMuxBD54gg-1
X-Mimecast-MFC-AGG-ID: 3GPNdnVnN2y4eMuxBD54gg_1768474618
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-78fa4ffdf74so9885507b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768474618; x=1769079418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLhI+vqx7S3bTTod1vZ41rrRGMbgZVgw7nX1pjEfkyE=;
 b=tTrTDyPogFQgTZ6X4Ou1Y9Eq5+mbbA7BQXoylWEdPY834VlGTU1JLXsQyNrVoORhIV
 ayxVhHhVq6DrlXOn8WT680dCtbDH/T28YLoDPtQwUeF9UnjkWdkGmupA3K8onjOZUfkm
 znh5EJEd2+/JN4oBY2hhPxmEpvyumZakMhKlKxDAUb42XXtEEL5N5RXFW7c+sUDqRyIE
 yKHclOv44BO41UeYjGfawQTmOJvBX6jE1AEt32XBVuhFs34W4wF8tyAwZ/vSVDoMA5td
 hCMqsveluP2XpQNlXw9U98O6TjJIcTueb+85b9wcU1i1ovt7TNgwMtkSu5q8GgJkPvtn
 xHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768474618; x=1769079418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vLhI+vqx7S3bTTod1vZ41rrRGMbgZVgw7nX1pjEfkyE=;
 b=rr0ycvccC0vZH8GZWJkd0S8pfjOJiG3r1vX45TzvXWZafpEcfvM9mmEuj5ndpY7igW
 UWVnJEhr+sw3sRdRPHQtEVLmLXNsI1ASoirjWjUnWLWOPIECM76ApTChiQMbTZy15lSN
 ZdtRMwxViSbpXP3+2VUyjkOV5glZnfgm/FbI+YnyQK/QmFi4kSJ7j7o8X0nxLVXPi7qd
 aQ4rMpmzw0WkiznOw1c3OwO9Mp8Q6wAKd7ugLhmE5P2gBjWjjBJcw1Y5h6RWJDhj25/3
 jIBzN8Z3xmORAyMXEpiU9cjrHDFFI/nrryBEEbviGvd+UCWqvfaxk2oPzttbU3xd0Dmu
 UZbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3hEwl/JTuvISR0af0N3CIirG0tIK8yZzC6b4tQ3+7rSdv7MOfh8o76LoI4YPZDIvF+rFJ7qYByZYw@nongnu.org
X-Gm-Message-State: AOJu0Ywp2Lg7Rl3rtPraGgVqHootnLPOzf8GYP/DVOsBFKi3x6mOei1Z
 KwuciPp1iXoumhhe26mMA1MjmA/VzGcaumTE2FXTUf+4Z7zEglHR5CGZJdpfncT15L3QnOXUIDF
 CJGSS94UfuYNSIlofuXLJUjCNa7IAwZSgBExmvceIzRZwmCfOKHJ7RfmEqPc38u/z3yIDcoxKVv
 fVQgC4rRDXwqExeTNYvwwTLiRQVSO0AYE=
X-Gm-Gg: AY/fxX5qEP6CoLacExz/fH/Hd0nBc6PJNvLzDbmrriDdXTGorccGg/XwGoBpEnzBxCW
 jBhRtocFHrcGvX1S8O/Ja1LpG6hb0kUkC5J0KXOhLlBDIxABAXQsGAwU9lyiwj0tDWfAFxgGGhC
 MoFmtp2b9zZwQ7mdWXXU631qTqFpypXRJEdXRaBRx7VxJUlEbSCl79xivB9n2d76KxPA==
X-Received: by 2002:a05:690e:189d:b0:647:101f:cc80 with SMTP id
 956f58d0204a3-64903b5d17cmr3502111d50.81.1768474618066; 
 Thu, 15 Jan 2026 02:56:58 -0800 (PST)
X-Received: by 2002:a05:690e:189d:b0:647:101f:cc80 with SMTP id
 956f58d0204a3-64903b5d17cmr3502094d50.81.1768474617544; Thu, 15 Jan 2026
 02:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20251231110110.18201-1-wafer@jaguarmicro.com>
In-Reply-To: <20251231110110.18201-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Jan 2026 11:56:21 +0100
X-Gm-Features: AZwV_Qgtgj8OKDNquzCxTEf1N5bOubnRbZSUhPISmFfOPAa5HaabB2gL9-h4pQs
Message-ID: <CAJaqyWerEFbYXuRZaRhit0vS5WZCgj5vfxwXCTxcvUuYEvOR+w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to
 available ring
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 31, 2025 at 12:01=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com> =
wrote:
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
> If the current indirect buffer does not have enough freed descriptors
> to accommodate the SVQ descriptors,
> descriptors can be borrowed from the next indirect buffer.
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 341 +++++++++++++++++++++++++----
>  1 file changed, 299 insertions(+), 42 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 4f564f514c..02a238548c 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -139,86 +139,340 @@ static bool vhost_svq_translate_addr(const VhostSh=
adowVirtqueue *svq,
>  }
>
>  /**
> - * Write descriptors to SVQ vring
> + * Add a single descriptor to a descriptor table
> + *
> + * @desc: The descriptor to write to
> + * @addr: IOVA address
> + * @len: Length of the buffer
> + * @flags: Descriptor flags (VRING_DESC_F_WRITE, VRING_DESC_F_NEXT)
> + * @next: Next descriptor index (only used if VRING_DESC_F_NEXT is set)
> + */
> +static void vhost_svq_vring_add_desc(vring_desc_t *desc,
> +                                       hwaddr addr,
> +                                       uint32_t len,
> +                                       uint16_t flags,
> +                                       uint16_t next)
> +{
> +    desc->addr =3D cpu_to_le64(addr);
> +    desc->len =3D cpu_to_le32(len);
> +    desc->flags =3D flags;
> +    if (flags & cpu_to_le16(VRING_DESC_F_NEXT)) {
> +        desc->next =3D cpu_to_le16(next);
> +    }
> +}
> +
> +/**
> + * Write descriptors to a descriptor table (chain or indirect)
>   *
>   * @svq: The shadow virtqueue
>   * @sg: Cache for hwaddr
>   * @iovec: The iovec from the guest
>   * @num: iovec length
>   * @addr: Descriptors' GPAs, if backed by guest memory
> + * @descs: The descriptor table to write to
> + * @start_idx: Starting index in the descriptor table
> + * @offset_idx: Offset for next field calculation (used for indirect)
>   * @more_descs: True if more descriptors come in the chain
>   * @write: True if they are writeable descriptors
> + * @indirect: True if writing to indirect descriptor table
>   *
> - * Return true if success, false otherwise and print error.
> + * Return the next free descriptor index if success, -1 on error.
>   */
> -static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwadd=
r *sg,
> -                                        const struct iovec *iovec, size_=
t num,
> -                                        const hwaddr *addr, bool more_de=
scs,
> -                                        bool write)
> +static int vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq,
> +                                       hwaddr *sg,
> +                                       const struct iovec *iovec,
> +                                       size_t num,
> +                                       const hwaddr *addr,
> +                                       vring_desc_t *descs,
> +                                       uint16_t start_idx,
> +                                       size_t offset_idx,
> +                                       bool more_descs,
> +                                       bool write,
> +                                       bool indirect)
>  {
> -    uint16_t i =3D svq->free_head, last =3D svq->free_head;
> -    unsigned n;
> +    uint16_t i =3D start_idx, last =3D start_idx;
>      uint16_t flags =3D write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
> -    vring_desc_t *descs =3D svq->vring.desc;
>      bool ok;
>
>      if (num =3D=3D 0) {
> -        return true;
> +        return start_idx;
>      }
>
>      ok =3D vhost_svq_translate_addr(svq, sg, iovec, num, addr);
>      if (unlikely(!ok)) {
> -        return false;
> +        return -1;
>      }
>
> -    for (n =3D 0; n < num; n++) {
> -        if (more_descs || (n + 1 < num)) {
> -            descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_NEXT);
> -            descs[i].next =3D cpu_to_le16(svq->desc_next[i]);
> +    for (size_t n =3D 0; n < num; n++) {
> +        uint16_t desc_flags =3D flags;
> +        uint16_t next;
> +
> +        if (indirect) {
> +            next =3D offset_idx + n + 1;
>          } else {
> -            descs[i].flags =3D flags;
> +            next =3D svq->desc_next[i];
>          }
> -        descs[i].addr =3D cpu_to_le64(sg[n]);
> -        descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
>
> +        if (more_descs || (n + 1 < num)) {
> +            desc_flags |=3D cpu_to_le16(VRING_DESC_F_NEXT);
> +        }
> +        vhost_svq_vring_add_desc(&descs[i], sg[n],
> +                                   iovec[n].iov_len, desc_flags, next);
>          last =3D i;
> -        i =3D svq->desc_next[i];
> +        if (indirect) {
> +            i++;
> +        } else {
> +            i =3D next;
> +        }
> +    }
> +
> +    /* Return the next free index */
> +    if (!indirect) {
> +        i =3D svq->desc_next[last];
> +    }
> +    return i;
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
> +    SVQIndirectDescBuf *buf =3D &svq->indirect.bufs[buf_idx];
> +    uint16_t start_idx =3D buf->start_idx + buf->freed_head;
> +    size_t total_descs =3D out_num + in_num;
> +    hwaddr indirect_iova;
> +    int ret;
> +
> +    /* Populate indirect descriptor table for out descriptors */
> +    ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_a=
ddr,
> +                                      svq->indirect.desc, start_idx,
> +                                      0, in_num > 0, false, true);
> +    if (unlikely(ret < 0)) {
> +        return false;
> +    }
> +
> +    /* Populate indirect descriptor table for in descriptors */
> +    ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr=
,
> +                                      svq->indirect.desc, start_idx + ou=
t_num,
> +                                      out_num, false, true, true);
> +    if (unlikely(ret < 0)) {
> +        return false;
>      }
>
> -    svq->free_head =3D svq->desc_next[last];
> +    /* Calculate IOVA for this indirect descriptor range */
> +    indirect_iova =3D svq->indirect.iova + start_idx * sizeof(vring_desc=
_t);
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
> +    buf->freed_head +=3D total_descs;
> +    buf->freed_descs -=3D total_descs;
> +
> +    /* Move free_head forward */
> +    svq->free_head =3D svq->desc_next[svq->free_head];
> +
>      return true;
>  }
>
> -static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
> +/**
> + * Try to borrow descriptors from the next buffer segment
> + *
> + * @svq: The shadow virtqueue
> + * @buf_idx: Current buffer index
> + * @needed: Number of additional descriptors needed
> + *
> + * Returns true if successfully borrowed, false otherwise.
> + * Note: Last buffer cannot borrow from first buffer (IOVA not contiguou=
s).
> + */
> +static bool vhost_svq_borrow_from_next(VhostShadowVirtqueue *svq,
> +                                       int buf_idx, size_t needed)
> +{
> +    SVQIndirectDescBuf *cur_buf =3D &svq->indirect.bufs[buf_idx];
> +    SVQIndirectDescBuf *next_buf;
> +    int next_idx;
> +
> +    /* Last buffer cannot borrow from first - IOVA would not be contiguo=
us */
> +    if (buf_idx =3D=3D SVQ_NUM_INDIRECT_BUFS - 1) {
> +        return false;
> +    }
> +
> +    next_idx =3D buf_idx + 1;
> +    next_buf =3D &svq->indirect.bufs[next_idx];
> +
> +    /* Can borrow if next buffer is in FREED state and has freed_head at=
 0 */
> +    if (next_buf->state !=3D SVQ_INDIRECT_BUF_FREED ||
> +        next_buf->freed_head !=3D 0) {
> +        return false;
> +    }
> +
> +    /* Check if next buffer has enough free descriptors to lend */
> +    if (next_buf->freed_descs < needed) {
> +        return false;
> +    }
> +    /* Borrow descriptors: expand current buffer, shrink next buffer */
> +    cur_buf->num_descs +=3D needed;
> +    cur_buf->borrowed_descs +=3D needed;
> +    cur_buf->freed_descs +=3D needed;
> +
> +    next_buf->start_idx +=3D needed;
> +    next_buf->num_descs -=3D needed;
> +    next_buf->freed_descs -=3D needed;
> +

I don't think I understand the algorithm for indirect tables
allocation and freeing. Let me know what I'm missing.

We can have at max SVQ_NUM_INDIRECT_BUFS (4) indirect tables, as the
information we use to locate the indirect table itself is
svq->desc_state[used_elem.id].indirect_buf_idx. This is used to access
the svq->indirect.bufs, whose size is SVQ_NUM_INDIRECT_BUFS.

These tables could grow until the maximum descriptors allowed, which
is the size of the vring per VirtIO standard. The function
virtqueue_pop already checks this. But this code does not allow more
than 4 indirect tables anyway, even if they were smaller than vq size
and there is contiguous space in the mapped buffer for the indirect
tables.

The code allocates a buffer big enough for 8 indirect tables in
vhost_vdpa_svq_init_indirect, as they can only be svq->vring.num big,
so half of it will never be allocated under any circumstance.

Now let's say the driver allocates 4 indirect tables (IT). The shared
buffer now looks like:

[
  [1st IT],
  [2nd IT],
  [3rd IT],
  [4th IT],
  [free size for at least 4 indirect tables more]
]

Now the device starts freeing indirect descriptors and the dance of
reallocating could start. The condition for borrowing and returning
descriptors may be met at 2*vq_size boundaries. But, by that time, it
is guaranteed that you can allocate an indirect table of vq_num
descriptors at some position N*vq_num, with N between 0 and 7.

Why complicate the code with this dance of resizing
svq->indirect.bufs[j] then? Why not divide all the mapped buffer in 8
chunks of vq size and never move them?

I would prefer to remove the 4 (or any number) indirect tables
limitation and use something like the IOVA allocator or the buddy
allocator to find contiguous space though.

Thanks!

> +    return true;
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
> +    int cur =3D svq->indirect.current_buf;
> +    SVQIndirectDescBuf *buf;
> +
> +    if (!svq->indirect.enabled) {
> +        return -1;
> +    }
> +
> +    if ( cur < 0) {
> +        cur =3D 0;
> +    }
> +    /* Start from current or first buffer, try all buffers in order */
> +    for (int i =3D 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
> +        int idx =3D (cur + i) % SVQ_NUM_INDIRECT_BUFS;
> +        buf =3D &svq->indirect.bufs[idx];
> +
> +        if (buf->state !=3D SVQ_INDIRECT_BUF_FREED) {
> +            continue;
> +        }
> +
> +        /* Check if we have enough free descriptors */
> +        if (buf->freed_descs >=3D total_descs) {
> +            svq->indirect.current_buf =3D idx;
> +            return idx;
> +        }
> +
> +        /* Try to borrow from next buffer */
> +        size_t needed =3D total_descs - buf->freed_descs;
> +        if ((buf->freed_descs > 0) &&
> +            vhost_svq_borrow_from_next(svq, idx, needed)) {
> +            svq->indirect.current_buf =3D idx + 1;
> +            return idx;
> +        }
> +
> +        /* Not enough space, mark as FREEING if it's the current buffer =
*/
> +        buf->state =3D SVQ_INDIRECT_BUF_FREEING;
> +    }
> +
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
> +    int ret;
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
> +        ret =3D vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, o=
ut_addr,
> +                                          svq->vring.desc, svq->free_hea=
d, 0,
> +                                          in_num > 0, false, false);
> +        if (unlikely(ret < 0)) {
> +            return -EINVAL;
> +        }
> +        svq->free_head =3D ret;
> +
> +        ret =3D vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_=
addr,
> +                                          svq->vring.desc, svq->free_hea=
d, 0,
> +                                          false, true, false);
> +        if (unlikely(ret < 0)) {
> +            return -EINVAL;
> +        }
> +        svq->free_head =3D ret;
>      }
>
>      /*
> @@ -233,7 +487,7 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue =
*svq,
>      smp_wmb();
>      avail->idx =3D cpu_to_le16(svq->shadow_avail_idx);
>
> -    return true;
> +    return 0;
>  }
>
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> @@ -249,7 +503,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
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
> @@ -274,19 +529,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const =
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
> 2.34.1
>


