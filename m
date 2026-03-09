Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77936EF3718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQd-0002xh-VJ; Mon, 09 Mar 2026 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQd-0002pP-1c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQb-0001Uf-Mh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=es7Xc7F3mG6kJStM0oZAZ71Me2P0sNj94nhxxDdtrTc=;
 b=VuRMMyu0UNelbZrBq8UZ83JVGkg3KJ39feoKvydGJxXVQUkxSz867ch7dyDJyVMcFqevME
 4o1jCLP1Jw3YYyV1qQvzuGNouXnFvXH3JTpO8QRA86golaRkQXBCU64CP3EvrjaEeQcQGZ
 AIsPwHZKhq9gl2iifhipDPKEzKBdqXY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-C7fBTL01Prus42Bh-KCDvA-1; Mon, 09 Mar 2026 04:57:28 -0400
X-MC-Unique: C7fBTL01Prus42Bh-KCDvA-1
X-Mimecast-MFC-AGG-ID: C7fBTL01Prus42Bh-KCDvA_1773046647
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-359812e4fefso5543411a91.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046646; cv=none;
 d=google.com; s=arc-20240605;
 b=M91zHqntCgzMHQCQflsrPVHF7AdzxfGJqBBMzYPNbWrLLcLg3+oTgIdJYDYiR//Y03
 TpIvl9yBx4n4Iw/PCYYsg4D22PQj3mvVVNSZd51E7mTeBKi1mM1ssWMKdZFUmMI4pwO2
 UgYNQG10ZaVILpqKEiQDNKsWa0cK/dTN9GmAJ5DBomjZ7vOsDwzv97X+9tu3E0DZWt7C
 ISJ67lBnDo2+w7mywWHVjNMSZ2dtjiEBmentiESYpJMrLxKxZ5USnoUfwL2BmwlNiQe3
 Vg3c9TRY1BjUoEGpddK4uYtYEF3JPdy3qp+j09b18dIgw+DD2+51UUvkzcXqgeqEqof5
 KQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=es7Xc7F3mG6kJStM0oZAZ71Me2P0sNj94nhxxDdtrTc=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=Cw8FHMg+2AN3W4ZDA7LeFOP7kjjUk2x5ohYyQIblLvoVJNLEfC+ycTiICO2butYI8M
 sWuWybB4IemAU5svro4WQQInOxt5brvGAKmGS/Hd6ABv/jc2imWqg0kZNuBzZ+qHGK47
 huwfu187Pb0i7Di3ld3REflS1FEZHSoDzcOgMT/Kkg00lQTmvcyosJiIcSmk8aCF0Ua8
 ovA/GtFC8fB4UTu9Z5JY5fqeSEh9xHi28ZcoOAF8jw15S3GXwWy2sVCGYPldnSIAlCrf
 Jp8UZPTI1y2Mwv795DlD8B0hM5InGjsSdh6DKyATUwyGAFoWPWyUXJOO9gYDzeWYmnwD
 /jjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046646; x=1773651446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=es7Xc7F3mG6kJStM0oZAZ71Me2P0sNj94nhxxDdtrTc=;
 b=KMGEQQJ0+L0irYv5eEpb8UtlFSb93hnoV3q2FMMLkR/glqGVX4+XF/WJdDfxPysDj0
 tPOh7/iAZxsZoKgAn52ksrwJJDbEjoT91LKcjjkZuTqYS5P5LQEwxpvd44tEzVBQW32f
 PxNa5RG8/lmFvuNTsARlsRb3t7tToOEP7IB5NKANKgHvosFUT8hcxXBdsUkUjBWmWdEq
 i3Q7yThfknBBYgvuEyPpBE5g7bCATp9eQrY9p08+ANghiDJaABUEt94wXFwg54owvYOc
 yn92G7ixxxHYxFoUxxKSJkoY/YBQCu4XJb3ix2ck2imO/iyIeyRZvWh/3KrWFJEWMMXh
 JjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046646; x=1773651446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=es7Xc7F3mG6kJStM0oZAZ71Me2P0sNj94nhxxDdtrTc=;
 b=Er4DCpFA19viQx403WzdAzKWc0gkvepmHMxdhSJO/0XRn3+jVT1lr2YFbDwr317FFV
 uq04YNbuwpm8jpCQ5caS9RbYVxanAWmciOvdoTAQYQiTuLSsPyESVIGTsr6iH1xGHeBX
 KYnV6yRifRtzVReWZVxI3PVfXQTBpH9onLg9qXKq6cJE+OTaYo3VlRe7kCZpfnkVO6r5
 mUgpYDLAKL7/DNHnvN2FXHEVT+W/TCj08hObw5Mu8PFM0NdnrpvW8qxo/qcN1zld+Hf2
 1lInj5vjm9F5qBM/sUNvS2UetmYbd2pfEqb5qXKB9aRFSoSvts8xLwK1mR93ign3ESF8
 am+A==
X-Gm-Message-State: AOJu0YygonzxuCv/Z0aB8jnMc+doZEgSSPDjjmZcpAnrUXHbgYP7GfOa
 dnrwxBDgLqfSvrKl6qSgU0JT4I2w1OF+U9vb75XBUkxtAtk30aoIBHNkGhe4454AVkFRhpuPMl+
 zaafz8Hm4Hf77aAq6I3bMZmijFFyJVmCrR0nb2MEf26HFkcq8omIMBwlb8HlCPtAiupIrWyMNUQ
 KoLkJMpEUtg2XAlXwGnDvhkdHWSvzU8ZSv8C5yXlY=
X-Gm-Gg: ATEYQzzqLKtH2S0zT4LMQ3DnDSN9OWsAk4X5KgbjJdGzoVnTTLDPZx1++28JCTCcx8+
 f5OW7lbA4E6uv2bkZHdaqgYO9RZVyi7CD4aAaTojl1w6/XyvHAdMmh6moACm6GqfEgsZm62j9+P
 DNIzGtuEmmRpuGEBbAaxf/gFSdm2xMEk/exX/5Y5RELSvqq7amFpKJnASxB5JynbzLwmeRpCisS
 WCOaUJI
X-Received: by 2002:a05:6300:2288:b0:398:9a45:9cb5 with SMTP id
 adf61e73a8af0-3989a45bcb5mr1290645637.32.1773046646405; 
 Mon, 09 Mar 2026 01:57:26 -0700 (PDT)
X-Received: by 2002:a05:6300:2288:b0:398:9a45:9cb5 with SMTP id
 adf61e73a8af0-3989a45bcb5mr1290613637.32.1773046645947; Mon, 09 Mar 2026
 01:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-6-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:57:13 +0800
X-Gm-Features: AaiRm53CLDOMqDJZqBBpvW-woCgEAzm0xvXHEYDA6KNmyxAC5stJ5MeRluzVLzk
Message-ID: <CACGkMEsCDDSV1m9-2cz3SGEh=MB0viA6h5a9vF5BCHPEhadfUQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] vhost: factor out the detach buf logic in SVQ
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> This code path is modified to handle in order devices.  Abstract here so
> we can generalize on the caller.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index e7e3c9155cd0..2d8fc82cc06f 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(const =
VhostShadowVirtqueue *svq,
>      return i;
>  }
>
> +G_GNUC_WARN_UNUSED_RESULT
> +static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
> +                                              uint16_t id)
> +{
> +    uint16_t num =3D svq->desc_state[id].ndescs;
> +    uint16_t last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, =
id);
> +
> +    svq->desc_state[last_used_chain].next =3D svq->free_head;
> +    svq->free_head =3D id;
> +
> +    return g_steal_pointer(&svq->desc_state[id].elem);
> +}
> +
>  G_GNUC_WARN_UNUSED_RESULT
>  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>                                             uint32_t *len)
>  {
> -    uint16_t last_used, last_used_chain, num;
> +    uint16_t last_used;
>
>      if (!vhost_svq_more_used(svq)) {
>          return NULL;
> @@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShad=
owVirtqueue *svq,
>          return NULL;
>      }
>
> -    num =3D svq->desc_state[last_used].ndescs;
> +    svq->num_free +=3D svq->desc_state[last_used].ndescs;
>      svq->desc_state[last_used].ndescs =3D 0;

Any reason we don't factor those two lines?

> -    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, last_used=
);
> -    svq->desc_state[last_used_chain].next =3D svq->free_head;
> -    svq->free_head =3D last_used;
> -    svq->num_free +=3D num;
> -
> -    return g_steal_pointer(&svq->desc_state[last_used].elem);
> +    return vhost_svq_detach_buf(svq, last_used);
>  }
>
>  /**
> --
> 2.53.0
>

Thanks


