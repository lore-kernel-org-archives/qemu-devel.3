Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45910C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmIeh-00041b-DK; Mon, 18 Mar 2024 15:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmIed-0003y4-BU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmIea-0000Hq-0i
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710790090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5thT1Ym/hbl8f5Mbq1rU87om0GJoVjSqRhDD6eXEXo=;
 b=iymclq6xcJNZ3iVlihX3VcAjowYeLHLkDTjbwiXGdJrWJD5lsXKwDeijZMkcO8TOM6lhM1
 QcakoFBLNZ/Xg9Z7x6Bc+hUp0JQeq53/rvmyGUiTj3VYLIyh+G+e330L8VY5QPX5ED5lf7
 qGJbuWz2mvUmF9UPcbOYYdIgnVyJIJA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-EkaxMRRiPZ6BX8hkh3ruUQ-1; Mon, 18 Mar 2024 15:28:08 -0400
X-MC-Unique: EkaxMRRiPZ6BX8hkh3ruUQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60cc8d4e1a4so88897247b3.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710790088; x=1711394888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5thT1Ym/hbl8f5Mbq1rU87om0GJoVjSqRhDD6eXEXo=;
 b=a9b7Tsv2/BSFSPVtvT8cztVTgYhUziHFLbGL0KPdoXt+dqM+b9Hhv1GjUn2ohCmgvB
 ZYQBBxbtUVFuPEWPemBaCZHky2x+dQPL8aRZ46Z2Jh8nOsGRx8aTKsdnuOofBnzV9o5m
 kZf+HtnTGcqzvn7TjBL+XUIe6OIVMnkhTAfjINeuVoWujmMEza4rZBW0gavY7e9TYbWw
 vtFyAt/IIoVveyw0+hUy/m8J0XKwyEAhCpgX04xeZeiff82QzCY+VJnUmwnawu0MsAue
 lvQG2fLd1gKvHtIwrh51jm7B8IApycfnXNb3K/y94V3dzPxSgRP6nN3jjHK0unRBHMsV
 ds9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbeI0tEHoF6zRx4/os2pXDSNngSsf6RP+LonXqrT+aknvBW3Q9lhLw8a5plHQZ2FhamphUxhW4G/SrrSlVrbn8vjKsbWY=
X-Gm-Message-State: AOJu0YwGLSEuLJxuzrLXD/sDk6wLoKPxtAjftgBGSDb0yd1FN7z5Bi1P
 db6WxsQ188IMVNn/QAY7egmw4kZxsa+QD+1lWPjhmLrFNTv7cEZpO9W75pr9oAPB+Or33S9k/dt
 R1pSP8PwwLsRDaEzT5yJWZB4VdU/fXESh3fEeLETsu+LD7WkVu0e0nJdPrnUJ1kSvMEORjEH8W5
 W5Es05YcTBuVrDRV9OVNhyNNtahQI=
X-Received: by 2002:a81:524f:0:b0:610:b259:9fa7 with SMTP id
 g76-20020a81524f000000b00610b2599fa7mr696574ywb.36.1710790087909; 
 Mon, 18 Mar 2024 12:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCcpDp3A2u95J15hdFL+unqJiYtF3gPN/tTS5MNX0C3Z25WfnLusbp3Ndthr3QZsM8hZXUu5iIBuoaQwRSwBY=
X-Received: by 2002:a81:524f:0:b0:610:b259:9fa7 with SMTP id
 g76-20020a81524f000000b00610b2599fa7mr696555ywb.36.1710790087612; Mon, 18 Mar
 2024 12:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240315155949.86066-1-kwolf@redhat.com>
 <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
 <20240318050212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240318050212-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 18 Mar 2024 20:27:31 +0100
Message-ID: <CAJaqyWc5_T=c+i0EvoYJ4Ly9XOaRBLvUE8w0n6duhm-b2Si0FA@mail.gmail.com>
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, sgarzare@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 18, 2024 at 10:02=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 12:31:26PM +0800, Jason Wang wrote:
> > On Fri, Mar 15, 2024 at 11:59=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> =
wrote:
> > >
> > > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> > > status flag is set; with the current API of the kernel module, it is
> > > impossible to enable the opposite order in our block export code beca=
use
> > > userspace is not notified when a virtqueue is enabled.
> > >
> > > This requirement also mathces the normal initialisation order as done=
 by
> > > the generic vhost code in QEMU. However, commit 6c482547 accidentally
> > > changed the order for vdpa-dev and broke access to VDUSE devices with
> > > this.
> > >
> > > This changes vdpa-dev to use the normal order again and use the stand=
ard
> > > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> > > used with vdpa-dev again after this fix.
> > >
> > > vhost_net intentionally avoided enabling the vrings for vdpa and does
> > > this manually later while it does enable them for other vhost backend=
s.
> > > Reflect this in the vhost_net code and return early for vdpa, so that
> > > the behaviour doesn't change for this device.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > > v2:
> > > - Actually make use of the @enable parameter
> > > - Change vhost_net to preserve the current behaviour
> > >
> > > v3:
> > > - Updated trace point [Stefano]
> > > - Fixed typo in comment [Stefano]
> > >
> > >  hw/net/vhost_net.c     | 10 ++++++++++
> > >  hw/virtio/vdpa-dev.c   |  5 +----
> > >  hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
> > >  hw/virtio/vhost.c      |  8 +++++++-
> > >  hw/virtio/trace-events |  2 +-
> > >  5 files changed, 45 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > index e8e1661646..fd1a93701a 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, i=
nt enable)
> > >      VHostNetState *net =3D get_vhost_net(nc);
> > >      const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> > >
> > > +    /*
> > > +     * vhost-vdpa network devices need to enable dataplane virtqueue=
s after
> > > +     * DRIVER_OK, so they can recover device state before starting d=
ataplane.
> > > +     * Because of that, we don't enable virtqueues here and leave it=
 to
> > > +     * net/vhost-vdpa.c.
> > > +     */
> > > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > +        return 0;
> > > +    }
> >
> > I think we need some inputs from Eugenio, this is only needed for
> > shadow virtqueue during live migration but not other cases.
> >
> > Thanks
>
>
> Yes I think we had a backend flag for this, right? Eugenio can you
> comment please?
>

We have the VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend flag,
right. If the backend does not offer it, it is better to enable all
the queues here and add a migration blocker in net/vhost-vdpa.c.

So the check should be:
nc->info->type =3D=3D VHOST_VDPA && (backend_features &
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK).

I can manage to add the migration blocker on top of this patch.

Thanks!


