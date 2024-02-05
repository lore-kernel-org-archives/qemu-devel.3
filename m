Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3E7C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzLw-0008HK-8j; Mon, 05 Feb 2024 08:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rWzLh-0008EQ-Jx
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rWzLf-0006dX-M2
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707140962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/NQEiE7mYwx+I92YKVwwqv5jToYLXnS+1Ps4j2A5GA=;
 b=aWa3I7iqymz8UJhiss2842Y6oNm3XsrKRrvgZkZpQ/S2N9T5UB1/5SUVf5h+Q0g48Gfh1M
 yurwN1+NiIaEm1xT6aZtvQhijeKCsLHm9xzJthwRHLUmgIMrlXHR/RpVk8pkrSaZYWwxMG
 JGisZfl2OHkx3fU7SLCGXFb9svAKkxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-VZcNyiiEP6Cde9GsAxQ0MA-1; Mon, 05 Feb 2024 08:49:21 -0500
X-MC-Unique: VZcNyiiEP6Cde9GsAxQ0MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91CC88D581;
 Mon,  5 Feb 2024 13:49:20 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B43AA51D5;
 Mon,  5 Feb 2024 13:49:19 +0000 (UTC)
Date: Mon, 5 Feb 2024 14:49:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <ZcDnXpE_IGkSVzTu@redhat.com>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

Am 05.02.2024 um 13:22 hat Eugenio Perez Martin geschrieben:
> On Fri, Feb 2, 2024 at 2:25 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> > status flag is set; with the current API of the kernel module, it is
> > impossible to enable the opposite order in our block export code because
> > userspace is not notified when a virtqueue is enabled.
> >
> > This requirement also mathces the normal initialisation order as done by
> > the generic vhost code in QEMU. However, commit 6c482547 accidentally
> > changed the order for vdpa-dev and broke access to VDUSE devices with
> > this.
> >
> > This changes vdpa-dev to use the normal order again and use the standard
> > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> > used with vdpa-dev again after this fix.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/virtio/vdpa-dev.c   |  5 +----
> >  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > index eb9ecea83b..13e87f06f6 100644
> > --- a/hw/virtio/vdpa-dev.c
> > +++ b/hw/virtio/vdpa-dev.c
> > @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
> >
> >      s->dev.acked_features = vdev->guest_features;
> >
> > -    ret = vhost_dev_start(&s->dev, vdev, false);
> > +    ret = vhost_dev_start(&s->dev, vdev, true);
> >      if (ret < 0) {
> >          error_setg_errno(errp, -ret, "Error starting vhost");
> >          goto err_guest_notifiers;
> >      }
> > -    for (i = 0; i < s->dev.nvqs; ++i) {
> > -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> > -    }
> >      s->started = true;
> >
> >      /*
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 3a43beb312..c4574d56c5 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
> >      return r;
> >  }
> >
> > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
> > +{
> > +    struct vhost_vdpa *v = dev->opaque;
> > +    unsigned int i;
> > +    int ret;
> > +
> > +    for (i = 0; i < dev->nvqs; ++i) {
> > +        ret = vhost_vdpa_set_vring_ready(v, i);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> >                                         int fd)
> >  {
> > @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops = {
> >          .vhost_set_features = vhost_vdpa_set_features,
> >          .vhost_reset_device = vhost_vdpa_reset_device,
> >          .vhost_get_vq_index = vhost_vdpa_get_vq_index,
> > +        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
> >          .vhost_get_config  = vhost_vdpa_get_config,
> >          .vhost_set_config = vhost_vdpa_set_config,
> >          .vhost_requires_shm_log = NULL,
> 
> vhost-vdpa net enables CVQ before dataplane ones to configure all the
> device in the destination of a live migration. To go back again to
> this callback would cause the device to enable the dataplane before
> virtqueues are configured again.

Not that it makes a difference, but I don't think it would actually be
going back. Even before your commit 6c482547, we were not making use of
the generic callback but just called the function in a slightly
different place (but less different than after commit 6c482547).

But anyway... Why don't the other vhost backend need the same for
vhost-net then? Do they just not support live migration?

I don't know the code well enough to say where the problem is, but if
vhost-vdpa networking code relies on the usual vhost operations not
being implemented and bypasses VhostOps to replace it, that sounds like
a design problem to me. Maybe VhostOps needs a new operation to enable
just a single virtqueue that can be used by the networking code instead?

> How does VDUSE userspace knows how many queues should enable? Can't
> the kernel perform the necessary actions after DRIVER_OK, like
> configuring the kick etc?

Not sure if I understand the question. The vdpa kernel interface always
enables individual queues, so the VDUSE userspace will enable whatever
queues it was asked to enable. The only restriction is that the queues
need to be enabled before setting DRIVER_OK.

The interface that enables all virtqueues at once seems to be just
.vhost_set_vring_enable in QEMU.

Kevin


