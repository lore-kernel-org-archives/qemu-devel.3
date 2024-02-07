Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3662C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXf1D-0007MU-Fd; Wed, 07 Feb 2024 05:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXf1B-0007Lq-OE
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 05:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXf19-0005lD-Nk
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 05:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707301138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZf8k+91Qspbr6pYSeSsZcxyzJkkhPrJMNNHQ2if0lU=;
 b=VWMC/rP+7pK6eawF/R4Q5apBrqaiullb1y1KK56zpyaeahXA9+mhVNHHtexRIFsGMHJ47J
 pnPZy8dFnsB9hzlia5nv9bbvyh2U1bE0BLpUIztqosLT4hG8Ilf93N953WEJKtOW3qj6mT
 p49QOKZ+Cn5Rn0ceNjR1tjZ7wxn/JK8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-bX8WxYUQPbSoH-cWtkPYpQ-1; Wed,
 07 Feb 2024 05:18:56 -0500
X-MC-Unique: bX8WxYUQPbSoH-cWtkPYpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18A383CBDFAA;
 Wed,  7 Feb 2024 10:18:56 +0000 (UTC)
Received: from redhat.com (pixel-6a.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA552026D09;
 Wed,  7 Feb 2024 10:18:54 +0000 (UTC)
Date: Wed, 7 Feb 2024 11:18:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <ZcNZDgopo3WBhsyk@redhat.com>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
 <ZcDnXpE_IGkSVzTu@redhat.com>
 <CAJaqyWenrGrE2Bjqw+TUy=WoMV56=4dY4rz5waN=rfrk7iAR2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWenrGrE2Bjqw+TUy=WoMV56=4dY4rz5waN=rfrk7iAR2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 06.02.2024 um 17:44 hat Eugenio Perez Martin geschrieben:
> On Mon, Feb 5, 2024 at 2:49 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 05.02.2024 um 13:22 hat Eugenio Perez Martin geschrieben:
> > > On Fri, Feb 2, 2024 at 2:25 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> > > > status flag is set; with the current API of the kernel module, it is
> > > > impossible to enable the opposite order in our block export code because
> > > > userspace is not notified when a virtqueue is enabled.
> > > >
> > > > This requirement also mathces the normal initialisation order as done by
> > > > the generic vhost code in QEMU. However, commit 6c482547 accidentally
> > > > changed the order for vdpa-dev and broke access to VDUSE devices with
> > > > this.
> > > >
> > > > This changes vdpa-dev to use the normal order again and use the standard
> > > > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> > > > used with vdpa-dev again after this fix.
> > > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > >  hw/virtio/vdpa-dev.c   |  5 +----
> > > >  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> > > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > > > index eb9ecea83b..13e87f06f6 100644
> > > > --- a/hw/virtio/vdpa-dev.c
> > > > +++ b/hw/virtio/vdpa-dev.c
> > > > @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
> > > >
> > > >      s->dev.acked_features = vdev->guest_features;
> > > >
> > > > -    ret = vhost_dev_start(&s->dev, vdev, false);
> > > > +    ret = vhost_dev_start(&s->dev, vdev, true);
> > > >      if (ret < 0) {
> > > >          error_setg_errno(errp, -ret, "Error starting vhost");
> > > >          goto err_guest_notifiers;
> > > >      }
> > > > -    for (i = 0; i < s->dev.nvqs; ++i) {
> > > > -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > > > -    }
> > > >      s->started = true;
> > > >
> > > >      /*
> > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > > index 3a43beb312..c4574d56c5 100644
> > > > --- a/hw/virtio/vhost-vdpa.c
> > > > +++ b/hw/virtio/vhost-vdpa.c
> > > > @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
> > > >      return r;
> > > >  }
> > > >
> > > > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
> > > > +{
> > > > +    struct vhost_vdpa *v = dev->opaque;
> > > > +    unsigned int i;
> > > > +    int ret;
> > > > +
> > > > +    for (i = 0; i < dev->nvqs; ++i) {
> > > > +        ret = vhost_vdpa_set_vring_ready(v, i);
> > > > +        if (ret < 0) {
> > > > +            return ret;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> > > >                                         int fd)
> > > >  {
> > > > @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops = {
> > > >          .vhost_set_features = vhost_vdpa_set_features,
> > > >          .vhost_reset_device = vhost_vdpa_reset_device,
> > > >          .vhost_get_vq_index = vhost_vdpa_get_vq_index,
> > > > +        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
> > > >          .vhost_get_config  = vhost_vdpa_get_config,
> > > >          .vhost_set_config = vhost_vdpa_set_config,
> > > >          .vhost_requires_shm_log = NULL,
> > >
> > > vhost-vdpa net enables CVQ before dataplane ones to configure all the
> > > device in the destination of a live migration. To go back again to
> > > this callback would cause the device to enable the dataplane before
> > > virtqueues are configured again.
> >
> > Not that it makes a difference, but I don't think it would actually be
> > going back. Even before your commit 6c482547, we were not making use of
> > the generic callback but just called the function in a slightly
> > different place (but less different than after commit 6c482547).
> >
> > But anyway... Why don't the other vhost backend need the same for
> > vhost-net then? Do they just not support live migration?
> 
> They don't support control virtqueue. More specifically, control
> virtqueue is handled directly in QEMU.

So the network device already has to special case vdpa instead of using
the same code for all vhost backends? :-/

> > I don't know the code well enough to say where the problem is, but if
> > vhost-vdpa networking code relies on the usual vhost operations not
> > being implemented and bypasses VhostOps to replace it, that sounds like
> > a design problem to me.
> 
> I don't follow this. What vhost operation is expected not to be implemented?

You were concerned about implementing .vhost_set_vring_enable in
vdpa_ops like my patch does. So it seems that the networking code
requires that it is not implemented?

On the other hand, for vhost-vdpa, the callback seems to be called in
exactly the right place where virtqueues need to be enabled, like for
other vhost devices.

> > Maybe VhostOps needs a new operation to enable
> > just a single virtqueue that can be used by the networking code instead?
> >
> > > How does VDUSE userspace knows how many queues should enable? Can't
> > > the kernel perform the necessary actions after DRIVER_OK, like
> > > configuring the kick etc?
> >
> > Not sure if I understand the question. The vdpa kernel interface always
> > enables individual queues, so the VDUSE userspace will enable whatever
> > queues it was asked to enable. The only restriction is that the queues
> > need to be enabled before setting DRIVER_OK.
> >
> > The interface that enables all virtqueues at once seems to be just
> > .vhost_set_vring_enable in QEMU.
> 
> It enables all virtqueues of the same vhost device in QEMU, but QEMU
> creates one vhost_dev per each vhost-net virtqueue pair and another
> one for CVQ. This goes back to the time where mq vhost-kernel net
> devices were implemented by mergin many tap devices. net/vhost-vdpa.c
> only enables the last one, which corresponds to CVQ, and then enables
> the rest once all messages have been received.

So it's less about the granularity of .vhost_set_vring_enable, which
would just be right, but about the order in which it is called for the
different vhost_devs?

Can we influence the order in another way than just not implementing the
callback at all? I think net specific weirdness should be contained in
the net implementation and not affect generic vdpa code.

> On the other hand, .vhost_set_vring_enable is also used for queue
> reset (vhost_net_virtqueue_reset and vhost_net_virtqueue_restart). In
> other words, it is called after the set DRIVER_OK. I guess it is fine
> for VDUSE as long as it does not offer vring reset capabilities, but
> future wise should we start going in that direction?

I don't actually know VDUSE very well, but that would probably make
sense.

Though for the moment, I just tried to simply attach a VDUSE device and
failed, so I'm just trying to fix the regression from your commit.

> But kernels without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK should be
> supported, right. Maybe we can add vhost_vdpa_set_vring_enable and
> call vhost_dev_start with vrings parameters conditional to the feature
> flag? That way the caller can enable it later or just enable all the
> rings altogether.

Which specific caller do you mean here?

For vdpa-dev, I don't see any problem with just passing vrings=true
unconditionally. That is clearly the least problematic order even if
another order may in theory be allowed by the spec.

For vhost_net, I don't know. As far as I am concerned, there is no
reason to change its call and it could continue to pass vrings=false.

So vhost_dev_start() seems entirely unproblematic.

The only part that changes for net is that vhost_set_vring_enable() now
does something where it didn't do anything before. If that is a problem
for vdpa based network code, maybe we can just special case vdpa there
to not call vhost_ops->vhost_set_vring_enable? (Despite its name, it's a
network specific function; it should probably be called something like
vhost_net_set_vring_enable.)

With something like the below, net shouldn't see any difference any
more, right? (Happy to add a comment before it if you write it for me.)

Kevin

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e8e1661646..fb6d13bd69 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -543,6 +543,10 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)

     nc->vring_enable = enable;

+    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        return 0;
+    }
+
     if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
         return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
     }


