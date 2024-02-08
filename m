Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C0AC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY85J-0005Oo-5e; Thu, 08 Feb 2024 12:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rY85I-0005OG-BZ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rY85C-0005vi-F1
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 12:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707412862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwPkgIwhjxqNoTvtR4tqncykXun4iSMo9v4a6YZ7ylw=;
 b=d2WY1V2trc5gESYH1R8ABi0DCzCz55TNk+8qMSlvYUQnSQSlTslNrzfcdtFIP5VbfETGt6
 BVeIGa7tfC2+PNJ5HgmuAzxBdqT7GH5uF9MC7uNTLrWp3GgquGZnKx9IbiIBZ5RRF8cDZd
 Q7KlG40wy3exlHw+a8SNUaYqAtFHIQE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-qLZJHWofP1SQ8MIXdIi7kw-1; Thu, 08 Feb 2024 12:21:01 -0500
X-MC-Unique: qLZJHWofP1SQ8MIXdIi7kw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5f6c12872fbso1922517b3.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 09:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707412860; x=1708017660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwPkgIwhjxqNoTvtR4tqncykXun4iSMo9v4a6YZ7ylw=;
 b=mJLX6Rq/WsqKWrfVzPugoAtmnwk+yx4j6MkWTKOYNlXwh+nxCwyCZkTh8VTkiuALJH
 5Eh1oZmj2PANnzaTkn7xDtW5P6aiCcYVl2mGcDrcOlj98ZQKam8GPaedYiuN6xmEScR6
 Vu0peYCCyXYdsZLQUY+ZQe2pSC223wvVqDAoOkq5/aChZKpMnkMQU2ow26GY0fAIW0hi
 bA3jKnLvDmX+M295fDHwmgBWsWnKI103PdfrGkbROIbU5hbgjeFXw35gVOFl8LnHEW5u
 0VjjW0zLWTWyOYqax7PlaL5AzIQuiT4DbBFps68XQTb7/DCiDUI6YUEJy6Qygh/Ehr/R
 dLzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfpz5mw62lh+wUNTOD8b6FX/CDLJuLmklOUxGwegCVYL8OtWV0QjD7Eb8aY18c69XLqXui4XLBfeWfCgNqXxpYtS5Tfw=
X-Gm-Message-State: AOJu0YzON0pNT115AZJYxYrScTXQmm4GEUmSixCMoQeM4xbz0Wf/1bZs
 hARzOFE889683Am1tXLq9v8n1kRLmdwwm4Sh1ybAJvHcQPsu/H78NspV2clKuilsPwS/eQvovl8
 68gySQ8IYCi1GRK6/9eanmBDtuuWuIgWGTNESae9q9C0Vi3A3ylyqCiDRaCAcTrLUbZTiDaQr4m
 oVBv6euEqaNa0cGgi/arvbG0UwRKs=
X-Received: by 2002:a81:e902:0:b0:604:800:f2b with SMTP id
 d2-20020a81e902000000b0060408000f2bmr8651074ywm.16.1707412860412; 
 Thu, 08 Feb 2024 09:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZGKqu66ruqvaMph8OhULxvUkwIjiAO8Qm0oxBWRibvUNOBSPCbS+B75hEuzfF9uGVwQKypbGVYXElu300A3U=
X-Received: by 2002:a81:e902:0:b0:604:800:f2b with SMTP id
 d2-20020a81e902000000b0060408000f2bmr8651042ywm.16.1707412859949; 
 Thu, 08 Feb 2024 09:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
 <ZcDnXpE_IGkSVzTu@redhat.com>
 <CAJaqyWenrGrE2Bjqw+TUy=WoMV56=4dY4rz5waN=rfrk7iAR2Q@mail.gmail.com>
 <ZcNZDgopo3WBhsyk@redhat.com>
In-Reply-To: <ZcNZDgopo3WBhsyk@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 8 Feb 2024 18:20:23 +0100
Message-ID: <CAJaqyWfSPit0p1YbEA69y6DKb83agsCQD2nuk8LqmOj37di5Tg@mail.gmail.com>
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Wed, Feb 7, 2024 at 11:18=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 06.02.2024 um 17:44 hat Eugenio Perez Martin geschrieben:
> > On Mon, Feb 5, 2024 at 2:49=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wr=
ote:
> > >
> > > Am 05.02.2024 um 13:22 hat Eugenio Perez Martin geschrieben:
> > > > On Fri, Feb 2, 2024 at 2:25=E2=80=AFPM Kevin Wolf <kwolf@redhat.com=
> wrote:
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
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > > ---
> > > > >  hw/virtio/vdpa-dev.c   |  5 +----
> > > > >  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> > > > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > > > > index eb9ecea83b..13e87f06f6 100644
> > > > > --- a/hw/virtio/vdpa-dev.c
> > > > > +++ b/hw/virtio/vdpa-dev.c
> > > > > @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODe=
vice *vdev, Error **errp)
> > > > >
> > > > >      s->dev.acked_features =3D vdev->guest_features;
> > > > >
> > > > > -    ret =3D vhost_dev_start(&s->dev, vdev, false);
> > > > > +    ret =3D vhost_dev_start(&s->dev, vdev, true);
> > > > >      if (ret < 0) {
> > > > >          error_setg_errno(errp, -ret, "Error starting vhost");
> > > > >          goto err_guest_notifiers;
> > > > >      }
> > > > > -    for (i =3D 0; i < s->dev.nvqs; ++i) {
> > > > > -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > > > > -    }
> > > > >      s->started =3D true;
> > > > >
> > > > >      /*
> > > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > > > index 3a43beb312..c4574d56c5 100644
> > > > > --- a/hw/virtio/vhost-vdpa.c
> > > > > +++ b/hw/virtio/vhost-vdpa.c
> > > > > @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_=
vdpa *v, unsigned idx)
> > > > >      return r;
> > > > >  }
> > > > >
> > > > > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, in=
t enable)
> > > > > +{
> > > > > +    struct vhost_vdpa *v =3D dev->opaque;
> > > > > +    unsigned int i;
> > > > > +    int ret;
> > > > > +
> > > > > +    for (i =3D 0; i < dev->nvqs; ++i) {
> > > > > +        ret =3D vhost_vdpa_set_vring_ready(v, i);
> > > > > +        if (ret < 0) {
> > > > > +            return ret;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> > > > >                                         int fd)
> > > > >  {
> > > > > @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops =3D {
> > > > >          .vhost_set_features =3D vhost_vdpa_set_features,
> > > > >          .vhost_reset_device =3D vhost_vdpa_reset_device,
> > > > >          .vhost_get_vq_index =3D vhost_vdpa_get_vq_index,
> > > > > +        .vhost_set_vring_enable =3D vhost_vdpa_set_vring_enable,
> > > > >          .vhost_get_config  =3D vhost_vdpa_get_config,
> > > > >          .vhost_set_config =3D vhost_vdpa_set_config,
> > > > >          .vhost_requires_shm_log =3D NULL,
> > > >
> > > > vhost-vdpa net enables CVQ before dataplane ones to configure all t=
he
> > > > device in the destination of a live migration. To go back again to
> > > > this callback would cause the device to enable the dataplane before
> > > > virtqueues are configured again.
> > >
> > > Not that it makes a difference, but I don't think it would actually b=
e
> > > going back. Even before your commit 6c482547, we were not making use =
of
> > > the generic callback but just called the function in a slightly
> > > different place (but less different than after commit 6c482547).
> > >
> > > But anyway... Why don't the other vhost backend need the same for
> > > vhost-net then? Do they just not support live migration?
> >
> > They don't support control virtqueue. More specifically, control
> > virtqueue is handled directly in QEMU.
>
> So the network device already has to special case vdpa instead of using
> the same code for all vhost backends? :-/
>
> > > I don't know the code well enough to say where the problem is, but if
> > > vhost-vdpa networking code relies on the usual vhost operations not
> > > being implemented and bypasses VhostOps to replace it, that sounds li=
ke
> > > a design problem to me.
> >
> > I don't follow this. What vhost operation is expected not to be impleme=
nted?
>
> You were concerned about implementing .vhost_set_vring_enable in
> vdpa_ops like my patch does. So it seems that the networking code
> requires that it is not implemented?
>

Kind of. vdpa_net requires that the enable calls on the dataplane
vrings are done after DRIVER_OK. So as you say in your mail, we're
good with vhost_dev_start, and changes may be focused to vhost_net.c

Vhost vdpa enable / disable semantics is just different from
vhost-user, the one that originally implemented
.vhost_set_vring_enable. That is the reason why the vhost vDPA enable
was called at vhost_vdpa_dev_start originally.

Vhost-user also calls that function to enable and disable queues. And
the vhost kernel does not even implement the vhost_op, but relies on
vhost_net_set_backend (not sure about other kinds of devices).

This patch is moving toward making them equal, which is not correct.
But maybe it is ok to do that tiny step in that direction to fix
generic vhost-vdpa generic dev and fix that later.

Just for completion, I tried to implement it using the vhost_op but it
was rejected already [1]. It was before Stefano's patch for
selectively disable vrings enable.

> On the other hand, for vhost-vdpa, the callback seems to be called in
> exactly the right place where virtqueues need to be enabled, like for
> other vhost devices.
>
> > > Maybe VhostOps needs a new operation to enable
> > > just a single virtqueue that can be used by the networking code inste=
ad?
> > >
> > > > How does VDUSE userspace knows how many queues should enable? Can't
> > > > the kernel perform the necessary actions after DRIVER_OK, like
> > > > configuring the kick etc?
> > >
> > > Not sure if I understand the question. The vdpa kernel interface alwa=
ys
> > > enables individual queues, so the VDUSE userspace will enable whateve=
r
> > > queues it was asked to enable. The only restriction is that the queue=
s
> > > need to be enabled before setting DRIVER_OK.
> > >
> > > The interface that enables all virtqueues at once seems to be just
> > > .vhost_set_vring_enable in QEMU.
> >
> > It enables all virtqueues of the same vhost device in QEMU, but QEMU
> > creates one vhost_dev per each vhost-net virtqueue pair and another
> > one for CVQ. This goes back to the time where mq vhost-kernel net
> > devices were implemented by mergin many tap devices. net/vhost-vdpa.c
> > only enables the last one, which corresponds to CVQ, and then enables
> > the rest once all messages have been received.
>
> So it's less about the granularity of .vhost_set_vring_enable, which
> would just be right, but about the order in which it is called for the
> different vhost_devs?
>
> Can we influence the order in another way than just not implementing the
> callback at all? I think net specific weirdness should be contained in
> the net implementation and not affect generic vdpa code.
>
> > On the other hand, .vhost_set_vring_enable is also used for queue
> > reset (vhost_net_virtqueue_reset and vhost_net_virtqueue_restart). In
> > other words, it is called after the set DRIVER_OK. I guess it is fine
> > for VDUSE as long as it does not offer vring reset capabilities, but
> > future wise should we start going in that direction?
>
> I don't actually know VDUSE very well, but that would probably make
> sense.
>
> Though for the moment, I just tried to simply attach a VDUSE device and
> failed, so I'm just trying to fix the regression from your commit.
>

Understandable.

> > But kernels without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK should be
> > supported, right. Maybe we can add vhost_vdpa_set_vring_enable and
> > call vhost_dev_start with vrings parameters conditional to the feature
> > flag? That way the caller can enable it later or just enable all the
> > rings altogether.
>
> Which specific caller do you mean here?
>
> For vdpa-dev, I don't see any problem with just passing vrings=3Dtrue
> unconditionally. That is clearly the least problematic order even if
> another order may in theory be allowed by the spec.
>
> For vhost_net, I don't know. As far as I am concerned, there is no
> reason to change its call and it could continue to pass vrings=3Dfalse.
>
> So vhost_dev_start() seems entirely unproblematic.
>

Yes I think the same.

> The only part that changes for net is that vhost_set_vring_enable() now
> does something where it didn't do anything before. If that is a problem
> for vdpa based network code, maybe we can just special case vdpa there
> to not call vhost_ops->vhost_set_vring_enable? (Despite its name, it's a
> network specific function; it should probably be called something like
> vhost_net_set_vring_enable.)
>
> With something like the below, net shouldn't see any difference any
> more, right? (Happy to add a comment before it if you write it for me.)
>

Early return should work but I'm not sure if that is the most
sustainable way. We should remove peer->type conditionals as much as
possible :).

To split vhost_ops would be better, yes. But these should be split
between the virtio vring enable vs vhost vring enable. The first one
does not accept a boolean, as it is only one direction. But this
option requires more changes, so I'm happy with the early return for
now. Not sure about Jason or MST.

As a draft for the comment:

Net vhost-vdpa devices need to dataplane virtqueues after DRIVER_OK,
so it can recover device state before starting dataplane. Because of
that, not enabling virtqueues here and leaving it to net/vhost-vdpa.c.
---

And maybe we can add another comment at vhost_dev_start doc? Something
in the line of:
* vring =3D yes means vhost_dev_start will start all vrings. vring =3D
false delegates vring initialization to the caller.

Does that make sense to you?

Thanks!

[1] https://lore.kernel.org/qemu-devel/0aae4d77-2c03-7ba2-8496-024b5a683449=
@redhat.com/

> Kevin
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..fb6d13bd69 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -543,6 +543,10 @@ int vhost_set_vring_enable(NetClientState *nc, int e=
nable)
>
>      nc->vring_enable =3D enable;
>
> +    if (nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        return 0;
> +    }
> +
>      if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>          return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>      }
>


