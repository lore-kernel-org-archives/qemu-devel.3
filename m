Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283FBCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsrQ-0007N0-V3; Mon, 08 Apr 2024 13:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rtsrM-0007MO-NP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rtsrJ-0001Lm-7S
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712597559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl+qZ8vxYDtq1eIM5Wd1GYKDIlOJCcTfnOxXRffMWHE=;
 b=Bgz4Xs3f7Zl2tPD/FeEi6jFmzXq19ymap7ciVvPbWfMlEbk+BrFeBpbbllAwjohvUOcWow
 a+gKsyiLwKDGZMUvNEFnfBNcwbAkXUjQ4ioNB7nLm8Lu4B87GecxusNH0koBbewIkBCi4G
 j4f7MtC31oh9TvFOMGP/Pb875Btlezg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-doaeiZ7ePqiu5LDummSymg-1; Mon, 08 Apr 2024 13:32:37 -0400
X-MC-Unique: doaeiZ7ePqiu5LDummSymg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6156b93c768so83693467b3.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712597557; x=1713202357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zl+qZ8vxYDtq1eIM5Wd1GYKDIlOJCcTfnOxXRffMWHE=;
 b=hhQNkgq+DZtLSIP+zQxuKd4BZ3aM//1twCdCERFuzQBFWihQVSx4juL9HibzN9sUX/
 IGb+CJvdxdZvpYPdVxk0dNJXG816Qh6zGKPXENDk4jwjyKEkIV1cCOT4NVAgVU0S/Cwz
 9Z9hIHQhgq390rPs5nDpP3QgBHNip3d0ZnLiibo1qb3OTcJMhqZMiitwx8iO1Nonfntx
 r8Naixm2Gn54OjAeA4XMNLyoaKw04MHGve5NbA2rtG+xog9QUZzfrDpwnfX6sdmAHsZx
 ulH2ljJpliGlGasSyJsq077RBwAlChXl1DHy5IN6DR69/etXy7Wdu4Pb77W8Zjio2zZs
 q3sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcTS5SJcqSoxeiNCJV8Vf9nQzyKRoGf/87egAq9LG0OHwUmEuWTvqKddJTK9TtjlZSPv8pjn0XCZ6gUDB+HuYpORVsUeA=
X-Gm-Message-State: AOJu0YzgSncPAEiOdq/wNRl1WzWGd75hIG42v3L5UQbc3a29Bs1nvdzl
 FkprEH9xA+H66W3/EHdk4xFNTpufy+v+mtU7H7de+BcbmFDUcyMtTsjj0gxEY8ecTwQhRPjWc7+
 04tx+eu45a92NzYpDH+kRpKAPoOWTtdT4aD+tsKqL7RDgwrU7k/9AThyMGvgdoGqRN1tSJRSV1O
 jfnddbjfQyANHwRCZ6u8rQwal3A+k=
X-Received: by 2002:a05:6902:f88:b0:dc6:52ec:7ff8 with SMTP id
 ft8-20020a0569020f8800b00dc652ec7ff8mr9935871ybb.4.1712597557368; 
 Mon, 08 Apr 2024 10:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE++TPPm5Q5E9HXdoD6vQ/crQ4LCcvA62XmIS1nGHMmUePex8e6tW58wuueyD+6tlpXhG+5F6SKyyBAmJzpkic=
X-Received: by 2002:a05:6902:f88:b0:dc6:52ec:7ff8 with SMTP id
 ft8-20020a0569020f8800b00dc652ec7ff8mr9935856ybb.4.1712597557122; Mon, 08 Apr
 2024 10:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240407015451.5228-2-wafer@jaguarmicro.com>
In-Reply-To: <20240407015451.5228-2-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 8 Apr 2024 19:32:01 +0200
Message-ID: <CAJaqyWeMbpp_HFLm+jweCE_y70arcUKa58Jg3VXoRQV04MWA=w@mail.gmail.com>
Subject: Re: [PATCH v4] hw/virtio: Fix packed virtqueue flush used_idx
To: Wafer <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 jonah.palmer@oracle.com, leiyang@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

On Sun, Apr 7, 2024 at 3:56=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote:
>

Let me suggest a more generic description for the patch:

In the event of writing many chains of descriptors, the device must
write just the id of the last buffer in the descriptor chain, skip
forward the number of descriptors in the chain, and then repeat the
operations for the rest of chains.

Current QEMU code writes all the buffers id consecutively, and then
skip all the buffers altogether. This is a bug, and can be reproduced
with a VirtIONet device with _F_MRG_RXBUB and without
_F_INDIRECT_DESC...
---

And then your description, particularly for VirtIONet, is totally
fine. Feel free to make changes to the description or suggest a better
wording.

Thanks!

> If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
> but not the VIRTIO_RING_F_INDIRECT_DESC feature,
> 'VirtIONetQueue->rx_vq' will use the merge feature
> to store data in multiple 'elems'.
> The 'num_buffers' in the virtio header indicates how many elements are me=
rged.
> If the value of 'num_buffers' is greater than 1,
> all the merged elements will be filled into the descriptor ring.
> The 'idx' of the elements should be the value of 'vq->used_idx' plus 'nde=
scs'.
>
> Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
>
> ---
> Changes in v4:
>   - Add Acked-by.
>
> Changes in v3:
>   - Add the commit-ID of the introduced problem in commit message.
>
> Changes in v2:
>   - Clarify more in commit message.
> ---
>  hw/virtio/virtio.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index fb6b4ccd83..cab5832cac 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, u=
nsigned int count)
>          return;
>      }
>
> +    /*
> +     * For indirect element's 'ndescs' is 1.
> +     * For all other elemment's 'ndescs' is the
> +     * number of descriptors chained by NEXT (as set in virtqueue_packed=
_pop).
> +     * So When the 'elem' be filled into the descriptor ring,
> +     * The 'idx' of this 'elem' shall be
> +     * the value of 'vq->used_idx' plus the 'ndescs'.
> +     */
> +    ndescs +=3D vq->used_elems[0].ndescs;
>      for (i =3D 1; i < count; i++) {
> -        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
> +        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false=
);
>          ndescs +=3D vq->used_elems[i].ndescs;
>      }
>      virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
> -    ndescs +=3D vq->used_elems[0].ndescs;
>
>      vq->inuse -=3D ndescs;
>      vq->used_idx +=3D ndescs;
> --
> 2.27.0
>


