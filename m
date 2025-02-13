Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE91DC021A7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 06:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiT3M-00014a-Mp; Thu, 13 Feb 2025 01:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiT3K-00014H-PS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiT3J-0002dY-7P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739429424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opUmvTp+UCBYV1on5+jqn0jS/f7/ki05rM+7Bgazd1s=;
 b=Z0hb2T6PUuFipNaT25KHy1gjIAMJMlCq0GtvZkQAHoZ3IKOMFPEeRSMWndtOMQ67Cybt3J
 2BdzHqYSlvf3QrqWjbtxHooNJXMHJ751rX3OZYsUb3JhEbFfQLCBTy7YyTJJLs0v1GKS8C
 SD8DXomFhnZ8VtNuPEotsPmCuGvo/jc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-0ronhXdZML-o85v1wmIHkw-1; Thu, 13 Feb 2025 01:50:20 -0500
X-MC-Unique: 0ronhXdZML-o85v1wmIHkw-1
X-Mimecast-MFC-AGG-ID: 0ronhXdZML-o85v1wmIHkw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fa6793e8b8so1426721a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 22:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739429419; x=1740034219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opUmvTp+UCBYV1on5+jqn0jS/f7/ki05rM+7Bgazd1s=;
 b=etsVcSD81ggY1QO3TpNyuCEjYwg1b/VyzT5BbQ+fEydns2P7DukOPBO2O1iXIgkQlC
 VQWfCwL1MirWa/qq/WlSMof7CXe0kpmLfBWWLJWbJYBgfQJc/1gALGTmku/hvL53y4rC
 54OAjx3LIgm1OfLgxFS4gMb3AI0fTwNtvlDaZLmblOm2UGl35mHDOGwCBZXXJnLYWeEu
 2qscsxMRfI0NmliLPWhtEw7/sCKDYEY/5ctgkCslq1f0Om49qdn40XcLRqOESVwshWvC
 l2OMhAifnHWlrRrIHLCJK2H5lZQUkMSh1S/IupyagMZ86B7v4m19D5JZKG7clS864I6v
 pgvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWtz3ExhlWDRd9wYqlogi9CHs2CINvmFj8E8whthZjDDX5kmAqe11f0rAhI31qNpUWKxrod4UuXOEk@nongnu.org
X-Gm-Message-State: AOJu0Yxjx2UnK612mjvBSozQWFshnDf0yf6LNrLeSGEMyiinjL72r8WU
 Z6sGnYKYcemJcBYsNzj8ndeMqIWQJhIzXw0hf/9GOJbeHtJRb/qx5ENidY4ozVi+1EiQ02dAxSV
 mL0X5I7MbjvlYmADN4BRfnaY29QdkGEBDjw93gvVPsADPI+a3Ehk98+5f/TJmhpMstiiHS1B8xL
 M332tv4MZembuTu+6VO0/1AvXmALQ=
X-Gm-Gg: ASbGncsk6UmkxO/FlIW831L8N+4bwA/yA8WeOGGFoZP1p7rOxt+lxzcVdrZtjLmUxiC
 vvHBat5Ds/Cak2XPof12W8UJPq4R25EuKuJzvU/cKAVdh96rY+tTC0MeXq4E+
X-Received: by 2002:a17:90b:4c84:b0:2fa:a58a:4c5f with SMTP id
 98e67ed59e1d1-2fbf9133970mr7564765a91.29.1739429419159; 
 Wed, 12 Feb 2025 22:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUBOdchgE7R57erDkeegKPxO8roE2Ms7JrHlsN1niYfbqgI/WfNH6bQoVilHCsvI3738DsR82aR01/tB42MS8=
X-Received: by 2002:a17:90b:4c84:b0:2fa:a58a:4c5f with SMTP id
 98e67ed59e1d1-2fbf9133970mr7564750a91.29.1739429418925; Wed, 12 Feb 2025
 22:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
In-Reply-To: <20250212164923.1971538-1-kshk@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 13 Feb 2025 07:49:42 +0100
X-Gm-Features: AWEUYZl6JyuOXN8C4tcgHkw4UYU7bTxN6rdEZQoRWjXPKP624bnH3JxNV0V6SGA
Message-ID: <CAJaqyWeHB_+ATn3cvtVrpiFp4NjNLoKpPP1ijs4C7eyRL7gpKQ@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com, 
 qemu-devel@nongnu.org, Sahil <icegambit91@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
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

On Wed, Feb 12, 2025 at 5:49=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> VDPA didn't work on a big-endian machine due to missing/incorrect
> CPU<->LE data format conversions.
>

Fixes: 10857ec0ad ("vhost: Add VhostShadowVirtqueue")

> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
> Changes in v2: Change desc_next[] from LE format to "CPU".
>
>  hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 37aca8b431..4af0d7c669 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -165,10 +165,10 @@ static bool vhost_svq_vring_write_descs(VhostShadow=
Virtqueue *svq, hwaddr *sg,
>          descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
>
>          last =3D i;
> -        i =3D cpu_to_le16(svq->desc_next[i]);
> +        i =3D svq->desc_next[i];
>      }
>
> -    svq->free_head =3D le16_to_cpu(svq->desc_next[last]);
> +    svq->free_head =3D svq->desc_next[last];
>      return true;
>  }
>
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
> @@ -408,7 +410,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const Vh=
ostShadowVirtqueue *svq,
>                                               uint16_t num, uint16_t i)
>  {
>      for (uint16_t j =3D 0; j < (num - 1); ++j) {
> -        i =3D le16_to_cpu(svq->desc_next[i]);
> +        i =3D svq->desc_next[i];
>      }
>
>      return i;
> @@ -683,7 +685,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtI=
ODevice *vdev,
>      svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
>      svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
>      for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> -        svq->desc_next[i] =3D cpu_to_le16(i + 1);
> +        svq->desc_next[i] =3D i + 1;
>      }
>  }
>
> --
> 2.34.1
>


