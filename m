Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E209CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0e7-0003Zi-As; Tue, 23 Jun 2026 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc0e3-0003Yd-FB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc0e1-0007xj-Bj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782219263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7V9PL7zCAcweGLXmcxQ/fNoFeWh0IqSpwFLRTYBkKw=;
 b=GkTmx0lRMXwNru2oXR1JjP/BtgG/lY5jy4UxJqDi7oJU/27aEdwgPKCGPVmi2uQnY50JTk
 //HSza0kwCSpH4ZjQg2T7iUCqs/3QEdELDm3tgWtpReEk6tZ3p/CEOwvd26KcB5rp9tGxU
 yw0a1XaHgtO07PM7fIh2h3Xz/eBv5ug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-oRyNwv9uM-eVgZ9WV1JJGw-1; Tue,
 23 Jun 2026 08:54:22 -0400
X-MC-Unique: oRyNwv9uM-eVgZ9WV1JJGw-1
X-Mimecast-MFC-AGG-ID: oRyNwv9uM-eVgZ9WV1JJGw_1782219261
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AB4F1800370; Tue, 23 Jun 2026 12:54:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3C5E195604D; Tue, 23 Jun 2026 12:54:17 +0000 (UTC)
Date: Tue, 23 Jun 2026 13:54:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <ajqB9ujvC6MXSRpG@redhat.com>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
 <20260623083557-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623083557-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 23, 2026 at 08:36:30AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 22, 2026 at 05:30:33PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > > A malicious guest can craft virtqueue descriptors with arbitrary lengths.
> > > control_out() calls iov_size() on the guest-supplied scatter-gather list
> > > and passes the result directly to g_malloc(), allowing a guest to force
> > > QEMU to attempt multi-gigabyte allocations and crash the host process.
> > > 
> > > Fix this by copying at most sizeof(struct virtio_console_control) into a
> > > stack-local variable instead of allocating a buffer sized by the guest.
> > > handle_control_message() only accesses the fixed-size id, event, and
> > > value fields, so no data beyond the struct was ever needed.
> > 
> > Does anyone have thoughts on whether we should treat guest initiated
> > unbounded allocs as a security issue ?
> > 
> > IIUC, this flaw would require root in the guest OS in order to craft
> > the malicious virtqueue descriptors.
> > 
> > A self-initiated crash triggered by root would not historically
> > be enough justification for CVE. We would require it to be triggered
> > by unprivileged user.
> > 
> > Nested virt with device assignment could change that equation though
> > as the L2 guest could be considered an unpriv user from the L1 POV.
> > 
> > Also in theory the large alloc might be large enough to consume all
> > host RAM but not large enough to trigger OOM kill of QEMU. This might
> > impact operation of other co-located VMs on the same host.
> 
> Don't see why not. We can treat it as low priority and no embargo.

Is there any point in assigning "low" severity  CVEs ? I'm not
convinced downstream vendors have capacity to deal with "low"
CVEs anymore even if we published them.

> 
> > Anyone think this is bad enough to justify a CVE ? Or should we treat
> > these OOM scenarios maerely as "hardening" bugs, where they require
> > 'root' in the L1 guest ?
> 
> 
> > > Cc: qemu-stable@nongnu.org
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >  hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
> > >  1 file changed, 7 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > index cd234dc6db1d..c1973f0248fc 100644
> > > --- a/hw/char/virtio-serial-bus.c
> > > +++ b/hw/char/virtio-serial-bus.c
> > > @@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle)
> > >  }
> > >  
> > >  /* Guest wants to notify us of some event */
> > > -static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
> > > +static void handle_control_message(VirtIOSerial *vser,
> > > +                                   struct virtio_console_control *gcpkt)
> > >  {
> > >      VirtIODevice *vdev = VIRTIO_DEVICE(vser);
> > >      struct VirtIOSerialPort *port;
> > >      VirtIOSerialPortClass *vsc;
> > > -    struct virtio_console_control cpkt, *gcpkt;
> > > +    struct virtio_console_control cpkt;
> > >      uint8_t *buffer;
> > >      size_t buffer_len;
> > >  
> > > -    gcpkt = buf;
> > > -
> > > -    if (len < sizeof(cpkt)) {
> > > -        /* The guest sent an invalid control packet */
> > > -        return;
> > > -    }
> > > -
> > >      cpkt.event = virtio_lduw_p(vdev, &gcpkt->event);
> > >      cpkt.value = virtio_lduw_p(vdev, &gcpkt->value);
> > >  
> > > @@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQueue *vq)
> > >  
> > >  static void control_out(VirtIODevice *vdev, VirtQueue *vq)
> > >  {
> > > +    struct virtio_console_control cpkt;
> > >      VirtQueueElement *elem;
> > >      VirtIOSerial *vser;
> > > -    uint8_t *buf;
> > >      size_t len;
> > >  
> > >      vser = VIRTIO_SERIAL(vdev);
> > >  
> > > -    len = 0;
> > > -    buf = NULL;
> > >      for (;;) {
> > > -        size_t cur_len;
> > > -
> > >          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > >          if (!elem) {
> > >              break;
> > >          }
> > >  
> > > -        cur_len = iov_size(elem->out_sg, elem->out_num);
> > > -        /*
> > > -         * Allocate a new buf only if we didn't have one previously or
> > > -         * if the size of the buf differs
> > > -         */
> > > -        if (cur_len > len) {
> > > -            g_free(buf);
> > > -
> > > -            buf = g_malloc(cur_len);
> > > -            len = cur_len;
> > > +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, sizeof(cpkt));
> > > +        if (len == sizeof(cpkt)) {
> > > +            handle_control_message(vser, &cpkt);
> > >          }
> > > -        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
> > >  
> > > -        handle_control_message(vser, buf, cur_len);
> > >          virtqueue_push(vq, elem, 0);
> > >          g_free(elem);
> > >      }
> > > -    g_free(buf);
> > >      virtio_notify(vdev, vq);
> > >  }
> > >  
> > > -- 
> > > 2.54.0
> > > 
> > > 
> > 
> > With regards,
> > Daniel
> > -- 
> > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


