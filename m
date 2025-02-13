Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D654C021A7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 06:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiSxe-0008UY-Dx; Thu, 13 Feb 2025 01:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiSxc-0008UJ-24
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiSxa-0001hE-D6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 01:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739429067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6tNLnGy0Al5/VlurpifJuNzbcrmGD/p1KtGFr2TXJM=;
 b=EyNmAXEvnVUoqJknxijfht52n6KXiP6hW9sdrbF4pvP9EGuulBJJ+SWTh6Aoc6ptJxzIPX
 wElCKxmPhXBmrAZAPWoU+PhbMXXQayZ2+7FfWsX7hzqInTW6SKWYbQ/aae4JXiUo/sp2jV
 4dOGJ6ekGWmkbNEUyrWZNMa3WSBkgwg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-1UM8_iCINnmfLV5xg-4gRg-1; Thu, 13 Feb 2025 01:44:24 -0500
X-MC-Unique: 1UM8_iCINnmfLV5xg-4gRg-1
X-Mimecast-MFC-AGG-ID: 1UM8_iCINnmfLV5xg-4gRg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fa29b4614aso1211674a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 22:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739429063; x=1740033863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6tNLnGy0Al5/VlurpifJuNzbcrmGD/p1KtGFr2TXJM=;
 b=RaiZ6mTE8JVYhXudbU9zBBOho3XNHrPELrmnF/U4n5j0P6oL0Z505hX98A5cqkKQa6
 uHwKjOQRK+V+9AC2aUamifQeaOe46tra06C9igo2JfZ+GZsh/T8z+LDgrAaIIxSyPSHK
 xihTTKxBDrT0o4slcy/gyay4ugN9v7TowITd6/1f+IAf4Rj7MA0pHsQaB2wysZs2g8zD
 J1C0oLcwLQnf9xXQ2FHLpHkEuYO5DL7O84dD4sBsj/zaahc+uOJXeupU5yz7Y/xP8cVE
 n5fTkkaxH6KhJ3VcT+OYpIHTUdv3kx9obvda8p05+u4EYNtdLhSu/Zp8s58WOVUSaked
 9bPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfgQPp/uPnWQtTGRHHhuNsm8rwkw9bN8LHSBVm7xstLxgIg/EObnl3zUTqf5jouUehl+1+MiL6rLor@nongnu.org
X-Gm-Message-State: AOJu0YxSjReiWKTOdjQbyXxHgFOrl4UlOaHExiNFFQraPmO3wQ1XeO/S
 oNpGdptP+CkeDwYS+t+oQ0DVM6hB9K2sPR+GE+ClWGZ0ds1W25POsjB84SHTsy/HQ1wsYvH3ibP
 KO1V6OWWdg80Rq40OZz5ZfW0zHe61fl8UqEwoS7jEpGXun+GJnCWSArf6Nzbwa5PHhyObSa8J0S
 6w4qxrzrs5Ov7D+3iz963oe5RQrFk=
X-Gm-Gg: ASbGncvvqkXC9zrNWZlzg3/C0BYoJG7XXP3FrCE1p6/ckKvHF12VQyEASRjFEM95T4c
 Iu16gJmqBwXbgUZP2/N1yJPX5RtqWWCAXtbfF2F832bRqtOO5x7QD8j9Uvoct
X-Received: by 2002:a17:90b:1e4e:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fc0f97535cmr3328978a91.8.1739429063693; 
 Wed, 12 Feb 2025 22:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTqctYKQRYuHRbJSNMYrzq6jH3kVOTJf90b615k4ogZfgSy3YIvdsZi5A4LFqfFEUheQshKyiEC5dCBlK3rRA=
X-Received: by 2002:a17:90b:1e4e:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fc0f97535cmr3328944a91.8.1739429063028; Wed, 12 Feb 2025
 22:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <7a07090c-78d4-4d5a-9d8e-56fa41db06cc@linaro.org>
In-Reply-To: <7a07090c-78d4-4d5a-9d8e-56fa41db06cc@linaro.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 13 Feb 2025 07:43:47 +0100
X-Gm-Features: AWEUYZn3yRuTJG92jYApR5UOh0DzpWnQDQfLfm7R7_3qmGcwXrQNtGLuaJwic3Y
Message-ID: <CAJaqyWeOY9+UwyjokOJmFjabJpGvo=zDhyZPzYh2e_gEmzHpPg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, mst@redhat.com,
 sgarzare@redhat.com, mjrosato@linux.ibm.com, qemu-devel@nongnu.org
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

On Wed, Feb 12, 2025 at 7:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 12/2/25 17:49, Konstantin Shkolnyy wrote:
> > VDPA didn't work on a big-endian machine due to missing/incorrect
> > CPU<->LE data format conversions.
> >
> > Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> > ---
> > Changes in v2: Change desc_next[] from LE format to "CPU".
> >
> >   hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
> >   1 file changed, 10 insertions(+), 8 deletions(-)
>
>
> > @@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *=
svq)
> >       smp_mb();
> >
> >       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) =
{
> > -        uint16_t avail_event =3D *(uint16_t *)(&svq->vring.used->ring[=
svq->vring.num]);
> > +        uint16_t avail_event =3D le16_to_cpu(
> > +                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]))=
;
>
> Nitpicking, sometimes using the ld/st API is cleaner (here lduw_le_p).
>

I'm not sure if it is right in SVQ, as it is not accessing guest
memory but QEMU memory that has been mapped to a device. But if you
think it is still a valid use case for ld* and st* family I'd be
totally ok with that usage.

> >           needs_kick =3D vring_need_event(avail_event, svq->shadow_avai=
l_idx, svq->shadow_avail_idx - 1);
> >       } else {
> > -        needs_kick =3D !(svq->vring.used->flags & VRING_USED_F_NO_NOTI=
FY);
> > +        needs_kick =3D
> > +                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO=
_NOTIFY));
> >       }
>


