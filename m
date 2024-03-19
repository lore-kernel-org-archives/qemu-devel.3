Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA559C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmWH6-00028L-M4; Tue, 19 Mar 2024 06:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmWH3-00024T-TI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmWH2-0003Oo-CV
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710842447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxU9TAxJqArYd1ToK6WlrtMRtJVrxJsqlXh6eoxj84E=;
 b=V2YRUmvd/bl47GqIQh1+JqnAqX10W1I9oNGS/oMdDr7gIAgU+GEemsVCigTFgCoRXMRcQU
 26UkRjd0SMn7F9p9Q0jplaRiEf/WunMGK0xN6p4ZLc1vj575fD6MpN8pdDr0EWI/k33Fg1
 7CHwmJ9q9rkm/BcD8AKiUWcJNbgPUy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-z9x40SIxPQOBV8wehQ4vkQ-1; Tue,
 19 Mar 2024 06:00:43 -0400
X-MC-Unique: z9x40SIxPQOBV8wehQ4vkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23BDC1C041A1;
 Tue, 19 Mar 2024 10:00:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9661C1576F;
 Tue, 19 Mar 2024 10:00:41 +0000 (UTC)
Date: Tue, 19 Mar 2024 11:00:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, sgarzare@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <ZfliRJ-7ueG0_OlJ@redhat.com>
References: <20240315155949.86066-1-kwolf@redhat.com>
 <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
 <20240318050212-mutt-send-email-mst@kernel.org>
 <CAJaqyWc5_T=c+i0EvoYJ4Ly9XOaRBLvUE8w0n6duhm-b2Si0FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWc5_T=c+i0EvoYJ4Ly9XOaRBLvUE8w0n6duhm-b2Si0FA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 18.03.2024 um 20:27 hat Eugenio Perez Martin geschrieben:
> On Mon, Mar 18, 2024 at 10:02 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 12:31:26PM +0800, Jason Wang wrote:
> > > On Fri, Mar 15, 2024 at 11:59 PM Kevin Wolf <kwolf@redhat.com> wrote:
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
> > > > vhost_net intentionally avoided enabling the vrings for vdpa and does
> > > > this manually later while it does enable them for other vhost backends.
> > > > Reflect this in the vhost_net code and return early for vdpa, so that
> > > > the behaviour doesn't change for this device.
> > > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > > v2:
> > > > - Actually make use of the @enable parameter
> > > > - Change vhost_net to preserve the current behaviour
> > > >
> > > > v3:
> > > > - Updated trace point [Stefano]
> > > > - Fixed typo in comment [Stefano]
> > > >
> > > >  hw/net/vhost_net.c     | 10 ++++++++++
> > > >  hw/virtio/vdpa-dev.c   |  5 +----
> > > >  hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
> > > >  hw/virtio/vhost.c      |  8 +++++++-
> > > >  hw/virtio/trace-events |  2 +-
> > > >  5 files changed, 45 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > index e8e1661646..fd1a93701a 100644
> > > > --- a/hw/net/vhost_net.c
> > > > +++ b/hw/net/vhost_net.c
> > > > @@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
> > > >      VHostNetState *net = get_vhost_net(nc);
> > > >      const VhostOps *vhost_ops = net->dev.vhost_ops;
> > > >
> > > > +    /*
> > > > +     * vhost-vdpa network devices need to enable dataplane virtqueues after
> > > > +     * DRIVER_OK, so they can recover device state before starting dataplane.
> > > > +     * Because of that, we don't enable virtqueues here and leave it to
> > > > +     * net/vhost-vdpa.c.
> > > > +     */
> > > > +    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > +        return 0;
> > > > +    }
> > >
> > > I think we need some inputs from Eugenio, this is only needed for
> > > shadow virtqueue during live migration but not other cases.
> > >
> > > Thanks
> >
> >
> > Yes I think we had a backend flag for this, right? Eugenio can you
> > comment please?
> >
> 
> We have the VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend flag,
> right. If the backend does not offer it, it is better to enable all
> the queues here and add a migration blocker in net/vhost-vdpa.c.
> 
> So the check should be:
> nc->info->type == VHOST_VDPA && (backend_features &
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK).
> 
> I can manage to add the migration blocker on top of this patch.

Note that my patch preserves the current behaviour for vhost_net. The
callback wasn't implemented for vdpa so far, so we never called anything
even if the flag wasn't set. This patch adds an implementation for the
callback, so we have to skip it here to have everything in vhost_net
work as before - which is what the condition as written does.

If we add a check for the flag now (I don't know if that's correct or
not), that would be a second, unrelated change of behaviour in the same
patch. So if it's necessary, that's a preexisting problem and I'd argue
it doesn't belong in this patch, but should be done separately.

Kevin


