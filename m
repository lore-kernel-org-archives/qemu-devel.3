Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E677C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2SzM-0000Y6-Im; Wed, 09 Apr 2025 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2SzL-0000Xw-Ks
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2SzJ-0007UQ-NL
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744195735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bApCIjPDb7rE6jneUbjBXg2x2UuQ8rEQgogaE+eQ554=;
 b=GXAOITcjk3bGlOokI4lnn6r9Iwyk/N9FfE4mMPIO6C8x3hOL6lbVfxnjK9G09jJQYs5NR+
 PMw2JAgZANREmlBD/QmVvb8z1PMqn/NwUVPQtPffCX6N7yK4csp4hH+Mrf/qxnWRGAhjV8
 +DA3Mq0RDnKWTZlWfiJ6PahOJCnkt88=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-mgagX8wCOkKv6YUrlRAqMw-1; Wed,
 09 Apr 2025 06:48:52 -0400
X-MC-Unique: mgagX8wCOkKv6YUrlRAqMw-1
X-Mimecast-MFC-AGG-ID: mgagX8wCOkKv6YUrlRAqMw_1744195731
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC0211955BC5; Wed,  9 Apr 2025 10:48:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A1A1955BC1; Wed,  9 Apr 2025 10:48:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CAB021E675E; Wed, 09 Apr 2025 12:48:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  eblake@redhat.com,
 eduardo@habkost.net,  berrange@redhat.com,  pbonzini@redhat.com,
 dave@treblig.org,  armbru@redhat.com,  sgarzare@redhat.com,
 den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v6] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
In-Reply-To: <20250409094758.58232-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 9 Apr 2025 12:47:58 +0300")
References: <20250409094758.58232-1-vsementsov@yandex-team.ru>
Date: Wed, 09 Apr 2025 12:48:46 +0200
Message-ID: <87plhlbofl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
>
>  - collect statistics of such errors
>  - make immediate actions: take core dumps or do some other debugging
>  - inform the user through a management API or UI, so that (s)he can
>   react somehow, e.g. reset the device driver in the guest or even
>   build up some automation to do so
>
> Note that basically every inconsistency discovered during virtqueue
> processing results in a silent virtqueue stop.  The guest then just
> sees the requests getting stuck somewhere in the device for no visible
> reason.  This event provides a means to inform the management layer of
> this situation in a timely fashion.
>
> The event could be reused for some other virtqueue problems (not only
> for vhost devices) in future. For this it gets a generic name and
> structure.
>
> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
> here, it's not the only call to VHOST_OPS_DEBUG in the file.

Likely should be tracepoints.  Not this patch's problem, though.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> v6: rename path to qom-path, and improve throttling of the event
>     improve wording
>
>  hw/virtio/vhost.c | 12 +++++++++---
>  monitor/monitor.c | 14 ++++++++++++++
>  qapi/qdev.json    | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..0b205cef73 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-qdev.h"
>  #include "hw/virtio/vhost.h"
>  #include "qemu/atomic.h"
>  #include "qemu/range.h"
> @@ -1442,11 +1443,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
>      struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
>                                                error_notifier);
>      struct vhost_dev *dev = vq->dev;
> -    int index = vq - dev->vqs;
>  
>      if (event_notifier_test_and_clear(n) && dev->vdev) {
> -        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
> -                        dev->vq_index + index);
> +        int ind = vq - dev->vqs + dev->vq_index;
> +        DeviceState *ds = &dev->vdev->parent_obj;
> +
> +        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
> +        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
> +                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
> +                                        "vhost reported failure through vring "
> +                                        "error fd");
>      }
>  }
>  
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c5a5d30877..11c8859703 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>      [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>      [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>      [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
> @@ -499,6 +500,12 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>      }
>  
> +    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        uint64_t virtqueue = qdict_get_int(evstate->data, "virtqueue");
> +        hash += g_str_hash(qdict_get_str(evstate->data, "qom-path")) ^
> +            g_int64_hash(&virtqueue);
> +    }
> +
>      return hash;
>  }
>  
> @@ -527,6 +534,13 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                         qdict_get_str(evb->data, "qom-path"));
>      }
>  
> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        return !strcmp(qdict_get_str(eva->data, "qom-path"),
> +                       qdict_get_str(evb->data, "qom-path")) &&
> +            (qdict_get_int(eva->data, "virtqueue") ==
> +             qdict_get_int(evb->data, "virtqueue"));
> +    }
> +
>      return TRUE;
>  }
>  

Rate-limiting is now per virt queue.  It was per device in previous
revisions.  Worth it?

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 25cbcf977b..ddfae18761 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -187,3 +187,35 @@
>  { 'command': 'device-sync-config',
>    'features': [ 'unstable' ],
>    'data': {'id': 'str'} }
> +
> +##
> +# @VirtqueueError:
> +#
> +# @vhost-vring-error: the vhost device has communicated failure via
> +#     the vring error file descriptor
> +#
> +# Since: 10.1
> +##
> +{ 'enum': 'VirtqueueError',
> +  'data': [ 'vhost-vring-error' ] }
> +
> +##
> +# @VIRTQUEUE_ERROR:
> +#
> +# Emitted when a device virtqueue fails at runtime.
> +#
> +# @device: the device's ID if it has one
> +#
> +# @qom-path: the device's QOM path
> +#
> +# @virtqueue: the index of the virtqueue that failed
> +#
> +# @error: error identifier
> +#
> +# @description: human readable description
> +#
> +# Since: 10.1
> +##
> +{ 'event': 'VIRTQUEUE_ERROR',
> + 'data': { '*device': 'str', 'qom-path': 'str', 'virtqueue': 'int',
> +            'error': 'VirtqueueError', 'description': 'str'} }

Standard question for events: can a management application poll for the
information as well?

I might have asked this before, I don't remember.  If you already
answered it, feel free to point me to your answer.

Why is this a standard question for events?  Say, a management
application wants to track the state of X.  Two ways: poll the state
with a query command that returns it, listen for events that report a
change of X.

Listening for an event is more efficient.

However, if the management application connects to a QEMU instance, X
could be anything, so it needs to poll once.

Special case: the management application restarts for some reason.


