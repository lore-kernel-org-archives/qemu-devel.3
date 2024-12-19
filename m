Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438E5E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGn-0003ZK-03; Thu, 19 Dec 2024 11:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOHRc-0001dx-Ux
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOHRb-0007NG-6k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734618241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNHwBXHWEGQ6K3D4TEZBS4BdyLRsyYlRDVLQl3aWPsM=;
 b=QlWAylu1Xb4Dy5MME3sfL2JFCmH2OAngfysATDVOA5ruCjndiUSv1KhErSCsWf4cB4qMiy
 ONkLCRMznGgTLbf8LK4tGGxqazwuCVVNdMNbvs9/WMLBdoYFBsFggT4z2/4U/KH6Ke7/U8
 Nzmk2PRWO1cpaimcZP+tWUVAiXvpPBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-URR_6VBbO-yNOXaf_475bg-1; Thu,
 19 Dec 2024 09:24:00 -0500
X-MC-Unique: URR_6VBbO-yNOXaf_475bg-1
X-Mimecast-MFC-AGG-ID: URR_6VBbO-yNOXaf_475bg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49D22195608C
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 14:23:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EF1F1956053; Thu, 19 Dec 2024 14:23:57 +0000 (UTC)
Date: Thu, 19 Dec 2024 14:23:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/virtio: reset virtio balloon stats on machine reset
Message-ID: <Z2QsebYwZ51ohas7@redhat.com>
References: <20241218172912.4170899-1-berrange@redhat.com>
 <d2730488-8468-4639-876c-18a860c6469e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2730488-8468-4639-876c-18a860c6469e@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 19, 2024 at 02:51:21PM +0100, David Hildenbrand wrote:
> On 18.12.24 18:29, Daniel P. Berrangé wrote:
> > When a machine is first booted, all virtio balloon stats are initialized
> > to their default value -1 (18446744073709551615 when represented as
> > unsigned).
> > 
> > They remain that way while the firmware is loading, and early phase of
> > guest OS boot, until the virtio-balloon driver is activated. Thereafter
> > the reported stats reflect the guest OS activity.
> > 
> > When a machine reset is performed, however, the virtio-balloon stats are
> > left unchanged by QEMU, despite the guest OS no longer updating them,
> > nor indeed even still existing.
> > 
> > IOW, the mgmt app keeps getting stale stats until the guest OS starts
> > once more and loads the virtio-balloon driver (if ever). At that point
> > the app will see a discontinuity in the reported values as they sudden
> > jump from the stale value to the new value. This jump is indigituishable
> > from a valid data update.
> > 
> > While there is an "last-updated" field to report on the freshness of
> > the stats, that does not unambiguously tell the mgmt app whether the
> > stats are still conceptually relevant to the current running workload.
> > 
> > It is more conceptually useful to reset the stats to their default
> > values on machine reset, given that the previous guest workload the
> > stats reflect no longer exists. The mgmt app can now clearly identify
> > that there are is no stats information available from the current
> > executing workload.
> > 
> > The 'last-updated' time is also reset back to 0.
> > 
> > IOW, on every machine reset, the virtio stats are in the same clean
> > state they were when the macine first powered on.
> > 
> > A functional test is added to validate this behaviour with a real
> > world guest OS.
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > One side-thought I have, is whether it makes sense to add a
> > 'reset-count' field in the virtio stats, alongside the
> > 'last-updated' field. While apps can infer a reset from seeing
> > the stats all go back to their defaults, an explicit flag is
> > simpler...
> > 
> >   MAINTAINERS                             |   1 +
> >   hw/virtio/virtio-balloon.c              |  30 ++++-
> >   include/hw/virtio/virtio-balloon.h      |   4 +
> >   tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++
> >   4 files changed, 195 insertions(+), 1 deletion(-)
> >   create mode 100755 tests/functional/test_virtio_balloon.py
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 822f34344b..1380d53d03 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2234,6 +2234,7 @@ F: include/hw/virtio/virtio-balloon.h
> >   F: system/balloon.c
> >   F: include/sysemu/balloon.h
> >   F: tests/qtest/virtio-balloon-test.c
> > +F: tests/functional/test_virtio_balloon.py
> >   virtio-9p
> >   M: Greg Kurz <groug@kaod.org>
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index ab2ee30475..fe0854e198 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -31,7 +31,7 @@
> >   #include "trace.h"
> >   #include "qemu/error-report.h"
> >   #include "migration/misc.h"
> > -
> > +#include "sysemu/reset.h"
> >   #include "hw/virtio/virtio-bus.h"
> >   #include "hw/virtio/virtio-access.h"
> > @@ -910,6 +910,8 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
> >       }
> >       reset_stats(s);
> > +    s->stats_last_update = 0;
> > +    qemu_register_resettable(OBJECT(dev));
> >   }
> >   static void virtio_balloon_device_unrealize(DeviceState *dev)
> > @@ -917,6 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
> >       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >       VirtIOBalloon *s = VIRTIO_BALLOON(dev);
> > +    qemu_unregister_resettable(OBJECT(dev));
> >       if (s->free_page_bh) {
> >           qemu_bh_delete(s->free_page_bh);
> >           object_unref(OBJECT(s->iothread));
> > @@ -987,6 +990,27 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> >       }
> >   }
> 
> Using qemu_register_resettable() can have unfortunate side effects that this
> code is triggered when the device is reset, not necessarily when the
> complete machine.
> 
> For virtio-mem at least that's an issue, and here is how I'll fix it:
> 
> https://lore.kernel.org/qemu-devel/20241218105303.1966303-2-david@redhat.com/

IIUC, the scenario wrt kDump on s390x will be OK in this scenario. If
you're resetting the balloon device across a kDump, I think it is likely
desirable for the virtio balloon stats to be reset. The OS which populated
those stats no longer exists, and has been replaced by the kExec kernel
performing the kDump IIUC.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


