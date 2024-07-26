Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C118FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLJn-0007As-8w; Fri, 26 Jul 2024 09:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLJm-00076b-7j
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLJk-0004bn-Cm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqS7CiXc8N0LIqwQd+gbdnx528hyBPh9Uq4YNKy1kDI=;
 b=FN4Pf3UGO/3w09Kq0+Tu7ww4u2Y57hxHztwMm3+ZuaXdDA9eYSsDtWyJL7c3WS4rwWhkr3
 /TznNHBLuVicNkLAFW7Ff+CYUcP87EyYOTBMXioBv6w5LepMHpCZZArxxBAAnl5GaSD6Q9
 fhyRmTfq9ITE+RuX45iNbpWUxx7zojA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-AkSOVbFWMqiblggWb98EPA-1; Fri, 26 Jul 2024 09:49:05 -0400
X-MC-Unique: AkSOVbFWMqiblggWb98EPA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-654d96c2bb5so52061127b3.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001745; x=1722606545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqS7CiXc8N0LIqwQd+gbdnx528hyBPh9Uq4YNKy1kDI=;
 b=IXjTY/Lc8eanDQcLqtuPrb4l8/t4JjOPyPCkPd6ozg3DrL6Rlj5YVacm75lbcGYs/F
 RDvdhBist2v5aWW2HU/VK18Wqz+X4p93gp/wqqy2pKAt2O3pXZ/FPufUXIYySTFUnqMw
 S7XRKhFD9fJ9tNMtP1Rgk1BL0iqU4LzGwGuXpwS+GCxjKnYviO/rY/UMx/N8KO1Gy68C
 KMODyiMeFG+/cc4Jpel/Lt1C80YLWa8qcdbtMZFPbKPO1GGu7/TCXU98i0xgnYi/ehQR
 Rk8erBwN0wxfLHEo9ceDO8AnDEPEYdhKRoSODrkuWPU97lGcA4RrG0WzR1OsO4S31Ayz
 E6Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhgqEMmLFLtAQBa7CcPar0K3IzlN4Km8NycjDVfE3FKGxvASDBW7pyr97s5Pj8iWcaI0Ei1jBaLjg/9jm70HZ2XE3pQ1I=
X-Gm-Message-State: AOJu0Yyd2N51F5W86HqlkJ/8K1dR7ckgn1eoH43M+nWfjLNnuVfoYpiq
 a0eCsSsYuApo//xXY2SgvqszuFhEJjAeG1ErcVmE574c4rfunKKFyNVDCcXSqZq83g85cFSWrPp
 ARJEfCEp9ltIAINuXt6yNcYgI6pd6YlVk4whu3MuQt2t8ZxqU/ao1ptZV/zQ9jHMb8JNh7m9I0l
 mFBjdPTQKG4PrT8t0U+0hWYXVmWBU=
X-Received: by 2002:a81:b40f:0:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-67514c47bfdmr63724797b3.32.1722001745062; 
 Fri, 26 Jul 2024 06:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8vBd22fnxJgzkkHdDFiRSXUvgp2nYCLW9sIpyGbZvCBNE27oWg5c4AjdN5B9yRtDjmDxvScGm8KgMhr0ME5I=
X-Received: by 2002:a81:b40f:0:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-67514c47bfdmr63724577b3.32.1722001744700; Fri, 26 Jul 2024
 06:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <20240726095822.104017-2-sahilcdq@proton.me>
In-Reply-To: <20240726095822.104017-2-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jul 2024 15:48:28 +0200
Message-ID: <CAJaqyWdkbPd-zjbtn2JE9B-p6wx5f-sK1Ziv6bTqwSosLMpZfA@mail.gmail.com>
Subject: Re: [RFC v2 1/3] vhost: Introduce packed vq and add buffer elements
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> This is the first patch in a series to add support for packed
> virtqueues in vhost_shadow_virtqueue. This patch implements the
> insertion of available buffers in the descriptor area. It takes
> into account descriptor chains, but does not consider indirect
> descriptors.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v1 -> v2:
> * Split commit from RFC v1 into two commits.
> * vhost-shadow-virtqueue.c
>   (vhost_svq_add_packed):
>   - Merge with "vhost_svq_vring_write_descs_packed()"
>   - Remove "num =3D=3D 0" check
>
>  hw/virtio/vhost-shadow-virtqueue.c | 93 +++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..c7b7e0c477 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -217,6 +217,91 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue=
 *svq,
>      return true;
>  }
>
> +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                const struct iovec *out_sg, size_t out_n=
um,
> +                                const struct iovec *in_sg, size_t in_num=
,
> +                                unsigned *head)
> +{
> +    bool ok;
> +    uint16_t head_flags =3D 0;
> +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> +
> +    *head =3D svq->vring_packed.next_avail_idx;
> +
> +    /* We need some descriptors here */
> +    if (unlikely(!out_num && !in_num)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Guest provided element with no descriptors");
> +        return false;
> +    }
> +
> +    uint16_t id, curr, i;
> +    unsigned n;
> +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> +
> +    i =3D *head;
> +    id =3D svq->free_head;
> +    curr =3D id;
> +
> +    size_t num =3D out_num + in_num;
> +
> +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +
> +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num);
> +    if (unlikely(!ok)) {
> +        return false;
> +    }
> +

(sorry I missed this from the RFC v1) I think all of the above should
be in the caller, isn't it? It is duplicated with split.

Also, declarations should be at the beginning of blocks per QEMU
coding style [1].

The rest looks good to me by visual inspection.

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
> +    }
> +
> +    if (i <=3D *head) {
> +        svq->vring_packed.avail_wrap_counter ^=3D 1;
> +    }
> +
> +    svq->vring_packed.next_avail_idx =3D i;
> +    svq->free_head =3D curr;
> +
> +    /*
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
> +     */
> +    smp_wmb();
> +    svq->vring_packed.vring.desc[*head].flags =3D head_flags;
> +
> +    return true;
> +}
> +
>  static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>  {
>      bool needs_kick;
> @@ -258,7 +343,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const s=
truct iovec *out_sg,
>          return -ENOSPC;
>      }
>
> -    ok =3D vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qem=
u_head);
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> +        ok =3D vhost_svq_add_packed(svq, out_sg, out_num,
> +                                  in_sg, in_num, &qemu_head);
> +    } else {
> +        ok =3D vhost_svq_add_split(svq, out_sg, out_num,
> +                                 in_sg, in_num, &qemu_head);
> +    }
>      if (unlikely(!ok)) {
>          return -EINVAL;
>      }
> --
> 2.45.2
>

[1] https://www.qemu.org/docs/master/devel/style.html#declarations


