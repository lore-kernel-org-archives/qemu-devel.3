Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5A6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEKO-00073r-Pn; Wed, 12 Feb 2025 10:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiEKM-0006y9-Sq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiEKK-0005dg-UN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739372819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmT3ViS/hRIX/Pegz02aI819p+Yj8+MUuiyduSoXqnY=;
 b=VRneWrRKBunoTfT3N+qm4xRbYRd/VXGXVd6s2OuQ9Y271I101pWbnKpSwV2pvi5AKD5r7t
 S5B6Nqg2hSfpnXS53u1SVRNHn3iKH5EomdzqAuAWWAC+J1EvEIlloskr/Bd4d7oymAZjI5
 UhhFXUvolpf9UQr+BeEbxWn/afONZ84=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-H_ueTADlMhOsZ5y2GnAH-Q-1; Wed, 12 Feb 2025 10:06:57 -0500
X-MC-Unique: H_ueTADlMhOsZ5y2GnAH-Q-1
X-Mimecast-MFC-AGG-ID: H_ueTADlMhOsZ5y2GnAH-Q_1739372816
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fa3b466245so9580703a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372816; x=1739977616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmT3ViS/hRIX/Pegz02aI819p+Yj8+MUuiyduSoXqnY=;
 b=VAN8ruIJqgmGI3rVNNPDNQPQSIFOEH32K/tNvTNC+RKZYPvZSZsaRJVVTbbCfAGUrl
 TATpkYOTgkbfuFDJH8pHBtn+UyHGKihlMYc7fhTu8UZ8C6wEvlzIkIswHjBgeDiK6VeD
 672OKRMTEuytMsLFbkzkJPiqH0yrrrE7r7WU1J2Dq6E4PcCPt6ufVmATLbFdpWb1CEG4
 Y5MGEt/HhhT21lQSC0R+UplFMrRSHfiNUlDhuP5lVumLXMziEMYew5id4FMUfYnM2KxG
 HtusZIcGBpXcuq1h/4Uw/3rNCC47QejfMSR2C6UYpfgaF/C4sG3fICuz5E7P5AjtIHeU
 wW6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5taPM0BeDfZWPd82NU5UN6Wn8DGQdEV3kKt1wA29iiISVoS2NZZ3L6uI6FS7E4yB2rTK8Fv2fJJOU@nongnu.org
X-Gm-Message-State: AOJu0YyjLkkSln5ieb8tsDVdECMR47IpAW53pWLuMfJfA9Rdvznt1bZY
 PZMS9c8XqR7YNonyA4w/sR9EAHYDwtpybKQTu0yLjmwUKKbeh7zlxz4j/fzGdQC92Pb5RcjJ/g1
 O9zSLFSsGnGl3CVfR9RPNe5fHXLnb7TU4b+IM+T6dNrke5uGkSkiqeSx2muy50qTVDcW6vnUfAg
 mToimBDrnkqKVesEI2yWhf8pRXRrk=
X-Gm-Gg: ASbGncvL1KVXDOcXJDo47QnEnN5Nq6frKgS3KAIognpwRg0Cv6vRMTkTaCyc5teNZ40
 F4DyR0GoA6nowQF9a9zvZ7N4cfzpYqlMsE5NYXQnbMsl4fKS6Za4Rs13H6DOx
X-Received: by 2002:a17:90b:544c:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2fbf5c1564cmr6295504a91.18.1739372815864; 
 Wed, 12 Feb 2025 07:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfXXNCBMwp14YsSvi8N2hLMU+bgjd+Fw8CYtbTnOizVhEIZvG7Yk9gmF2a5BixQsRPGuJO1k3ht011OkCm2bc=
X-Received: by 2002:a17:90b:544c:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2fbf5c1564cmr6295462a91.18.1739372815500; Wed, 12 Feb 2025
 07:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20250211162010.1478402-1-kshk@linux.ibm.com>
In-Reply-To: <20250211162010.1478402-1-kshk@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 12 Feb 2025 16:06:19 +0100
X-Gm-Features: AWEUYZkBoY7Y4iIJUmhrczYlrizGv8k8MYuOLLoXzzmy-4SzB739oVXgKsUqDJA
Message-ID: <CAJaqyWd60RFTugxxu8NNYxHKTX3vEGZ-Za2Z=BLwVPYde8EgwA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On Tue, Feb 11, 2025 at 5:20=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> VDPA didn't work on a big-endian machine due to missing/incorrect
> CPU<->LE data format conversions.
>

Thank you very much for this!

> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 37aca8b431..b3c83f0dfa 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -157,7 +157,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVi=
rtqueue *svq, hwaddr *sg,
>      for (n =3D 0; n < num; n++) {
>          if (more_descs || (n + 1 < num)) {
>              descs[i].flags =3D flags | cpu_to_le16(VRING_DESC_F_NEXT);
> -            descs[i].next =3D cpu_to_le16(svq->desc_next[i]);
> +            descs[i].next =3D svq->desc_next[i];
>          } else {
>              descs[i].flags =3D flags;
>          }
> @@ -165,7 +165,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVi=
rtqueue *svq, hwaddr *sg,
>          descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
>
>          last =3D i;
> -        i =3D cpu_to_le16(svq->desc_next[i]);
> +        i =3D le16_to_cpu(svq->desc_next[i]);

Both svq->desc_next and "i" are in QEMU. We can skip the conversion
and assign directly.

>      }
>
>      svq->free_head =3D le16_to_cpu(svq->desc_next[last]);
> @@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *sv=
q)
>      smp_mb();
>
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> -        uint16_t avail_event =3D *(uint16_t *)(&svq->vring.used->ring[sv=
q->vring.num]);
> +        uint16_t avail_event =3D le16_to_cpu(
> +                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
>          needs_kick =3D vring_need_event(avail_event, svq->shadow_avail_i=
dx, svq->shadow_avail_idx - 1);
>      } else {
> -        needs_kick =3D !(svq->vring.used->flags & VRING_USED_F_NO_NOTIFY=
);
> +        needs_kick =3D
> +                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_N=
OTIFY));
>      }
>
>      if (!needs_kick) {
> @@ -365,7 +367,7 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue =
*svq)
>          return true;
>      }
>
> -    svq->shadow_used_idx =3D cpu_to_le16(*(volatile uint16_t *)used_idx)=
;
> +    svq->shadow_used_idx =3D le16_to_cpu(*(volatile uint16_t *)used_idx)=
;
>
>      return svq->last_used_idx !=3D svq->shadow_used_idx;
>  }
> @@ -383,7 +385,7 @@ static bool vhost_svq_enable_notification(VhostShadow=
Virtqueue *svq)
>  {
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>          uint16_t *used_event =3D (uint16_t *)&svq->vring.avail->ring[svq=
->vring.num];
> -        *used_event =3D svq->shadow_used_idx;
> +        *used_event =3D cpu_to_le16(svq->shadow_used_idx);
>      } else {
>          svq->vring.avail->flags &=3D ~cpu_to_le16(VRING_AVAIL_F_NO_INTER=
RUPT);
>      }
> @@ -449,7 +451,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShado=
wVirtqueue *svq,
>      num =3D svq->desc_state[used_elem.id].ndescs;
>      svq->desc_state[used_elem.id].ndescs =3D 0;
>      last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, used_elem=
.id);
> -    svq->desc_next[last_used_chain] =3D svq->free_head;
> +    svq->desc_next[last_used_chain] =3D cpu_to_le16(svq->free_head);

And skip this one too.

With that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


