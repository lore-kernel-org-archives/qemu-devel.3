Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC9AE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 07:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLdi9-0003cy-2L; Thu, 12 Dec 2024 02:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tLdi2-0003bV-Vl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tLdhz-0002zt-2W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 02:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733988836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVevSU9feh6Hve6ilZBaE06WQYIZpxzPUakGsY52Uyg=;
 b=SqKfcGaca1DrUlla+HudBPVCQ8Bnp9STVejIlXQRrKdZN5PkVJmNSep3f0LHCqvG6IYtXH
 g8YnHWsu3CbnnkfYSJHE+G8V8FlMF4ZUVu6zCw4XZuLuoCus1y7nButcLV0NE1F5Ck6zEB
 4pdlGe2URwaPrttqarqdulPMEGPUXUo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-mhre9y8NOr6I76ZLMzkYYQ-1; Thu, 12 Dec 2024 02:33:53 -0500
X-MC-Unique: mhre9y8NOr6I76ZLMzkYYQ-1
X-Mimecast-MFC-AGG-ID: mhre9y8NOr6I76ZLMzkYYQ
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e391a40d431so432460276.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 23:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733988832; x=1734593632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVevSU9feh6Hve6ilZBaE06WQYIZpxzPUakGsY52Uyg=;
 b=IJPdbzDi14gF+3qJ8/bloLTgeGCcbV+6GnBN8b5JbH67GhgnRzrS1e8SGCrosX3IAq
 DyJsHF56G9b4F+kdggl6k7mQUToEJtnsDUvUhno+AbGYFtlh4+/q9hwLuVQiA40QgN9a
 G7Rtrpm1jle/lvQz3VtBSnpPqH37u73ZrgVFdkWhEAW/iQgY7h4O+IRjpLSea6niwyRs
 wqm1U+FoEL9uZfvixiV4OPz0ZgzRUBphzufG9Hma7kO6CHQPySu8oqZW/VghA54ZJaD/
 C/B4h0FHMp2G/eWWEtgql3GTbrKURfB0ozPE6f81JI9nZE3x1cPn/fQKIsJRmXk7FxYn
 S6uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2lOXlRAiVuMm3orSHCvmcyhNQiHs++o2btIGhpHqP4cLxrNGTkYmXde5Rk3zWEpW0+Bzf2prlPlAC@nongnu.org
X-Gm-Message-State: AOJu0YxK1oPt0Aj66VeqM9dxIhPGmoES4tvX7Yf5jLRlgcEVpDyh31ar
 2lviTzlwYtHSYdeWOQqYLX4WwXooBtnQX+KfJnEjeVAHC19Mdm/wetcy5GMdfai3oCtgfDb63V9
 Z6h0xETzm6FQwM9vd48fZL1ZkdctOgjXKjFIA7oDPyQ3ddPmGaw0QL3HAg+AF7qyI7JWlqb5xDD
 tguEWuDA77kkKj9bEz9cL1WbZDNvw=
X-Gm-Gg: ASbGncu56ydqEHqMwEE/qbnxqsdpM8sn9wAcP3LHEBRHh1cgV4oFlUg1Yy3bkKcCK6L
 kbKQr9XP24V+Z+mJbRipCLHgKuJDtIagUzonUlQ==
X-Received: by 2002:a05:6902:1245:b0:e39:7327:3100 with SMTP id
 3f1490d57ef6-e3d9042371fmr1886640276.26.1733988832698; 
 Wed, 11 Dec 2024 23:33:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxRz4EsncsWnWyssuGlU6heiOtdR8kqE+nPhh3r+SwoEH841b36TeKoG6Ysc0KitPUg12QxqDNn68bpvyplk=
X-Received: by 2002:a05:6902:1245:b0:e39:7327:3100 with SMTP id
 3f1490d57ef6-e3d9042371fmr1886632276.26.1733988832336; Wed, 11 Dec 2024
 23:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20241211123349.904-1-Wafer@jaguarmicro.com>
 <CAJaqyWcU8fN1ewYyZ1qDSdxWmr7SVbw8s+VKzO4_b63F8MS=Rg@mail.gmail.com>
 <PUZPR06MB47130AC6F169C17D9B833B74A23F2@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB47130AC6F169C17D9B833B74A23F2@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Dec 2024 08:33:16 +0100
Message-ID: <CAJaqyWecTOOrdZ8_XOj2ztx4mCKnx1Hmj_P-tKbVn-939Wyaqw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio: Fix check available index on virtio loading
To: Wafer <wafer@jaguarmicro.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Thu, Dec 12, 2024 at 3:30=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: 2024=E5=B9=B412=E6=9C=8811=E6=97=A5 20:45
> > To: Wafer <wafer@jaguarmicro.com>
> > Cc: mst@redhat.com; jasowang@redhat.com; qemu-devel@nongnu.org;
> > Angus Chen <angus.chen@jaguarmicro.com>
> > Subject: Re: [PATCH v2] hw/virtio: Fix check available index on virtio =
loading
> >
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless =
you
> > recognize the sender and know the content is safe.
> >
> >
> > On Wed, Dec 11, 2024 at 1:34=E2=80=AFPM Wafer <Wafer@jaguarmicro.com> w=
rote:
> > >
> > > From: Wafer Xie <wafer@jaguarmicro.com>
> > >
> > > The virtio-1.2 specification writes:
> > >
> > > 2.7.6 The Virtqueue Available Ring:
> > > "idx field indicates where the driver would put the next descriptor
> > > entry in the ring (modulo the queue size). This starts at 0, and incr=
eases"
> > >
> > > The idx will increase from 0 to 0xFFFF and repeat, So idx may be less
> > > than last_avail_idx.
> > >
> >
> > I don't get this change. If that happens the driver went buggy or malic=
ious
> > and the next check nheads > vring.num should mark the vq as buggy, isn'=
t it?
> >
>
> During the migration process, let's assume a scenario where:
> The depth of the avail ring is 0x10000, last_avail_index is 0xFFF0, and a=
vail->idx is 0xFFFFF.
> At this point, the guest VM driver sends a virtio data packet, and avail-=
>idx is updated to 0x0.
> The migration occurs, and last_avail_index is sent to the target QEMU.
> During the loading process of the target QEMU, it will check both last_av=
ail_index and avail->idx.
> In this case, last_avail_index is greater than avail->idx.
>

But (uint16_t)0x0 - (uint16_t)0xFFF0 is well defined to 0x10. So
nheads value is correct, isn't it?

> > > Fixes: 258dc7c96b ("virtio: sanity-check available index")
> > >
> > > Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> > >
> > > --
> > > Changes in v2:
> > >  -Modify the commit id of the fix.
> > > ---
> > >  hw/virtio/virtio.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c index
> > > a26f18908e..ae7d407113 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt
> > version_id)
> > >                  continue;
> > >              }
> > >
> > > -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> > > +            if (vring_avail_idx(&vdev->vq[i]) >=3D vdev->vq[i].last_=
avail_idx) {
> > > +                nheads =3D vring_avail_idx(&vdev->vq[i]) -
> > > +                         vdev->vq[i].last_avail_idx;
> > > +            } else {
> > > +                nheads =3D UINT16_MAX - vdev->vq[i].last_avail_idx +
> > > +                         vring_avail_idx(&vdev->vq[i]) + 1;
> > > +            }
> > >              /* Check it isn't doing strange things with descriptor n=
umbers. */
> > >              if (nheads > vdev->vq[i].vring.num) {
> > >                  virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x=
 "
> > > --
> > > 2.27.0
> > >
>


