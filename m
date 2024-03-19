Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB22DC54F7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmacr-0000ex-VG; Tue, 19 Mar 2024 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmacq-0000du-08
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmaco-0001bl-6Y
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710859173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgG0NZ+0z0biH2pbA6OYlxjpwUaDcFiE13+7TcVLAyY=;
 b=icT1w0QlFEClmbWZVnIZZH/LJSohJT1cZv7DJ26JRQmHECBHVPGGiRIi8Zf7mYB12KxMPx
 TGAs50mx4bjEJznXHgktZykUKE/vEhkecOTaWB/JL14sU530NzCXIJtOJFZ9IMB1X58Srl
 HyR7Ey3FzCjfdHqzZb4Rm9GFP5DS+QA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-i7BHK4_bN62p6u14cFCYGQ-1; Tue, 19 Mar 2024 10:39:31 -0400
X-MC-Unique: i7BHK4_bN62p6u14cFCYGQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcc4563611cso8006754276.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859171; x=1711463971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgG0NZ+0z0biH2pbA6OYlxjpwUaDcFiE13+7TcVLAyY=;
 b=vzket4hX9BtJxnGHT9PpiqFqP19EHTyAYTvPZd0MOyaQhUPoeYx/32KdVVMI05aN3E
 Km5kK1GeCxy5JpkoUPiwFb1qgUykTVW64UzDFUAwTk/XbiZo5HXLM8Ud2iKfK8w65m/C
 q8DwHLxn0DIai7YCkNg32+mlxIQ5B88A6stpruhkOYxOTjgcA7uLkYW4JlRGOTUA3LG5
 IYe7M0E/A5GIxR5o+UL6eZ2qIzsIfRHqdO4RCTpwfdOCIMfGE6SxLFQFQRmmhS0Agpy3
 fg5BfEatlMjsW2+738QgZvcwstBcrxPt3w1aKcM/uODGYU01J1d1vJOAolZfIFhU5yYP
 jD6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0sKtSIaRrkniiTgHSkA1Vvt1S24fiqnTXsLA/6mSmZq+yL0gGmZh0nGG4KwwE9Y7nqyE49Y94ecxcNWyUAfQVL9OQeTI=
X-Gm-Message-State: AOJu0Yy9txYYf2LJihBC9uhzrE6LRkmLIZ2q96fxeOsemsNOzhZQilV/
 qBkWfjpzTejjVKMWrYTcNItfYKMxsPvvE+/0tT7IX4XFb65nrll8pvvgvghjVTp+r1VG8wSwoME
 87QDrwbg4RIVoDuLQtn2ieKCJgvGYwqAduB6jzKYwE1fdJ6wJ9gRMO2NJkWmgLyYiNwDOUBM98r
 xna74z0zDrXEG5+LvW2SAdf4CdXx0=
X-Received: by 2002:a5b:444:0:b0:dc6:9daf:35c7 with SMTP id
 s4-20020a5b0444000000b00dc69daf35c7mr9839589ybp.28.1710859171238; 
 Tue, 19 Mar 2024 07:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENO5Yw+aZRHZQbHRR4Kmy3/AKFsggJXKrUySF1WYoat5fuiDQBrER6zFnfGYex050q6CtMy04wrbdPEj+Gcqo=
X-Received: by 2002:a5b:444:0:b0:dc6:9daf:35c7 with SMTP id
 s4-20020a5b0444000000b00dc69daf35c7mr9839573ybp.28.1710859170981; Tue, 19 Mar
 2024 07:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240315155949.86066-1-kwolf@redhat.com>
 <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
 <20240318050212-mutt-send-email-mst@kernel.org>
 <CAJaqyWc5_T=c+i0EvoYJ4Ly9XOaRBLvUE8w0n6duhm-b2Si0FA@mail.gmail.com>
 <ZfliRJ-7ueG0_OlJ@redhat.com>
In-Reply-To: <ZfliRJ-7ueG0_OlJ@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 19 Mar 2024 15:38:54 +0100
Message-ID: <CAJaqyWd+aafjz02NdwSKWZZ_1=4OzKbaAsNb-DP3PWt9RSY_Mg@mail.gmail.com>
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, 
 sgarzare@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> Am 18.03.2024 um 20:27 hat Eugenio Perez Martin geschrieben:
> > On Mon, Mar 18, 2024 at 10:02=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 12:31:26PM +0800, Jason Wang wrote:
> > > > On Fri, Mar 15, 2024 at 11:59=E2=80=AFPM Kevin Wolf <kwolf@redhat.c=
om> wrote:
> > > > >
> > > > > VDUSE requires that virtqueues are first enabled before the DRIVE=
R_OK
> > > > > status flag is set; with the current API of the kernel module, it=
 is
> > > > > impossible to enable the opposite order in our block export code =
because
> > > > > userspace is not notified when a virtqueue is enabled.
> > > > >
> > > > > This requirement also mathces the normal initialisation order as =
done by
> > > > > the generic vhost code in QEMU. However, commit 6c482547 accident=
ally
> > > > > changed the order for vdpa-dev and broke access to VDUSE devices =
with
> > > > > this.
> > > > >
> > > > > This changes vdpa-dev to use the normal order again and use the s=
tandard
> > > > > vhost callback .vhost_set_vring_enable for this. VDUSE devices ca=
n be
> > > > > used with vdpa-dev again after this fix.
> > > > >
> > > > > vhost_net intentionally avoided enabling the vrings for vdpa and =
does
> > > > > this manually later while it does enable them for other vhost bac=
kends.
> > > > > Reflect this in the vhost_net code and return early for vdpa, so =
that
> > > > > the behaviour doesn't change for this device.
> > > > >
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > - Actually make use of the @enable parameter
> > > > > - Change vhost_net to preserve the current behaviour
> > > > >
> > > > > v3:
> > > > > - Updated trace point [Stefano]
> > > > > - Fixed typo in comment [Stefano]
> > > > >
> > > > >  hw/net/vhost_net.c     | 10 ++++++++++
> > > > >  hw/virtio/vdpa-dev.c   |  5 +----
> > > > >  hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
> > > > >  hw/virtio/vhost.c      |  8 +++++++-
> > > > >  hw/virtio/trace-events |  2 +-
> > > > >  5 files changed, 45 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > > index e8e1661646..fd1a93701a 100644
> > > > > --- a/hw/net/vhost_net.c
> > > > > +++ b/hw/net/vhost_net.c
> > > > > @@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *n=
c, int enable)
> > > > >      VHostNetState *net =3D get_vhost_net(nc);
> > > > >      const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> > > > >
> > > > > +    /*
> > > > > +     * vhost-vdpa network devices need to enable dataplane virtq=
ueues after
> > > > > +     * DRIVER_OK, so they can recover device state before starti=
ng dataplane.
> > > > > +     * Because of that, we don't enable virtqueues here and leav=
e it to
> > > > > +     * net/vhost-vdpa.c.
> > > > > +     */
> > > > > +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > > +        return 0;
> > > > > +    }
> > > >
> > > > I think we need some inputs from Eugenio, this is only needed for
> > > > shadow virtqueue during live migration but not other cases.
> > > >
> > > > Thanks
> > >
> > >
> > > Yes I think we had a backend flag for this, right? Eugenio can you
> > > comment please?
> > >
> >
> > We have the VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend flag,
> > right. If the backend does not offer it, it is better to enable all
> > the queues here and add a migration blocker in net/vhost-vdpa.c.
> >
> > So the check should be:
> > nc->info->type =3D=3D VHOST_VDPA && (backend_features &
> > VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK).
> >
> > I can manage to add the migration blocker on top of this patch.
>
> Note that my patch preserves the current behaviour for vhost_net. The
> callback wasn't implemented for vdpa so far, so we never called anything
> even if the flag wasn't set. This patch adds an implementation for the
> callback, so we have to skip it here to have everything in vhost_net
> work as before - which is what the condition as written does.
>
> If we add a check for the flag now (I don't know if that's correct or
> not), that would be a second, unrelated change of behaviour in the same
> patch. So if it's necessary, that's a preexisting problem and I'd argue
> it doesn't belong in this patch, but should be done separately.
>

Right, that's a very good point. I'll add proper checking on top of
your patch when it is merged.

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


