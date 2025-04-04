Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CEBC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0i25-0005ms-6B; Fri, 04 Apr 2025 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0i20-0005h2-6c
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0i1x-0000mI-Kl
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743776904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H6RnnYC3v9g45HLPJgt9FciXm16JPKf8o3J63kdDnBA=;
 b=Wbi+1jD7B7YJwp3WkH7uk9nGSBDC3YMtj3BLaKvdfqAhXnsyQEisxbjFh94/OPOawOphVr
 8bliN5tKJzOUhkVCH960QsiuzZ7SYrfmudiiheCp/hDXTJtTRTlNOBtczWhpQ1cBHFLUay
 zeN4/glXwQ4OFhjoOZ+IoKNOArkbJns=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-KVQuJiyFM3avwvo-m8aRhQ-1; Fri,
 04 Apr 2025 10:28:19 -0400
X-MC-Unique: KVQuJiyFM3avwvo-m8aRhQ-1
X-Mimecast-MFC-AGG-ID: KVQuJiyFM3avwvo-m8aRhQ_1743776898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BD1019560B0; Fri,  4 Apr 2025 14:28:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 233993001D0E; Fri,  4 Apr 2025 14:28:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8AC6E21E66C7; Fri, 04 Apr 2025 16:28:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  sgarzare@redhat.com,  dave@treblig.org,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  Denis Plotnikov
 <den-plotnikov@yandex-team.ru>
Subject: Re: [PATCH v5] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
In-Reply-To: <18763620-2bd9-47a6-a5d4-ff61663bae9a@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 4 Apr 2025 13:26:42 +0300")
References: <20250401170731.121336-1-vsementsov@yandex-team.ru>
 <878qogqv8u.fsf@pond.sub.org>
 <18763620-2bd9-47a6-a5d4-ff61663bae9a@yandex-team.ru>
Date: Fri, 04 Apr 2025 16:28:12 +0200
Message-ID: <8734eongqr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 04.04.25 09:46, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> For now we only log the vhost device error, when virtqueue is actually
>>> stopped. Let's add a QAPI event, which makes possible:
>>>
>>>   - collect statistics of such errors
>>>   - make immediate actions: take core dumps or do some other debugging
>>>   - inform the user through a management API or UI, so that (s)he can
>>>    react somehow, e.g. reset the device driver in the guest or even
>>>    build up some automation to do so
>>>
>>> Note that basically every inconsistency discovered during virtqueue
>>> processing results in a silent virtqueue stop.  The guest then just
>>> sees the requests getting stuck somewhere in the device for no visible
>>> reason.  This event provides a means to inform the management layer of
>>> this situation in a timely fashion.
>>>
>>> The event could be reused for some other virtqueue problems (not only
>>> for vhost devices) in future. For this it gets a generic name and
>>> structure.
>>>
>>> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
>>> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
>>> ---
>>>
>>> v5: resend, update version in QAPI to 10.1
>>>     drop a-b by Markus (too much time passed, the context could
>>>     changed. Markus, is the patch still OK?)
>> 
>> Happy to take another look :)
>> 
>>>  hw/virtio/vhost.c | 12 +++++++++---
>>>  monitor/monitor.c | 10 ++++++++++
>>>  qapi/qdev.json    | 32 ++++++++++++++++++++++++++++++++
>>>  3 files changed, 51 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 6aa72fd434..0b205cef73 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -15,6 +15,7 @@
>>>   
>>>  #include "qemu/osdep.h"
>>>  #include "qapi/error.h"
>>> +#include "qapi/qapi-events-qdev.h"
>>>  #include "hw/virtio/vhost.h"
>>>  #include "qemu/atomic.h"
>>>  #include "qemu/range.h"
>>> @@ -1442,11 +1443,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
>>>      struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
>>>                                                error_notifier);
>>>      struct vhost_dev *dev = vq->dev;
>>> -    int index = vq - dev->vqs;
>>>  
>>>      if (event_notifier_test_and_clear(n) && dev->vdev) {
>>> -        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
>>> -                        dev->vq_index + index);
>>> +        int ind = vq - dev->vqs + dev->vq_index;
>>> +        DeviceState *ds = &dev->vdev->parent_obj;
>>> +
>>> +        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
>>> +        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
>>> +                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
>>> +                                        "vhost reported failure through vring "
>>> +                                        "error fd");
>>>      }
>>>  }
>>>   
>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>> index c5a5d30877..1296a9207e 100644
>>> --- a/monitor/monitor.c
>>> +++ b/monitor/monitor.c
>>> @@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>>>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>>>      [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>>> +    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
>>>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>>>      [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>>>      [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
>>> @@ -499,6 +500,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>>>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>>>      }
>>>   
>>> +    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>>> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
>> 
>> Isn't @device optional?  Should you use @qom-path instead?
>
> Yes, I'm thinking about it too.

This function and the next one together enable fine-grained event
throttling.  I figure the intent of your patch is to rate-limit this
event per device.  For that, you must use qom-path.  If you wanted to
rate-limit per virtqueue, you'd have to throw in @virtqueue.

As is, you have a crash bugL g_str_hash() expects a non-null argument.

>                                 Maybe, drop the "device" field from the event at all, and keep only qom-path? Years passed since movement to use qom paths..

Possible justifications for having @device: consistency with other
events, convenience for users.  I can't judge the latter.

>
>> 
>>> +    }
>>> +
>>>      return hash;
>>>  }
>>>   
>>> @@ -527,6 +532,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>>>                         qdict_get_str(evb->data, "qom-path"));
>>>      }
>>>   
>>> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>>> +        return !strcmp(qdict_get_str(eva->data, "device"),
>>> +                       qdict_get_str(evb->data, "device"));
>> 
>> Likewise.
>> 
>>> +    }
>>> +
>>>      return TRUE;
>>>  }
>>>   
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index 25cbcf977b..2d20f4777e 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -187,3 +187,35 @@
>>>  { 'command': 'device-sync-config',
>>>    'features': [ 'unstable' ],
>>>    'data': {'id': 'str'} }
>>> +
>>> +##
>>> +# @VirtqueueError:
>>> +#
>>> +# @vhost-vring-error: Vhost device reported failure through
>>> +#     through vring error fd.
>> 
>> One "through" too many.
>> 
>> I'm not quite sure I understand what you're trying to express.  Is it
>> "the vhost device has communicated failure via the vring error file
>> descriptor"?
>
> Yes. Will use your wording.
>
>> 
>> I know next to nothing about vhost devices...
>> 
>>> +#
>>> +# Since: 10.1
>>> +##
>>> +{ 'enum': 'VirtqueueError',
>>> +  'data': [ 'vhost-vring-error' ] }
>>> +
>>> +##
>>> +# @VIRTQUEUE_ERROR:
>>> +#
>>> +# Emitted when a device virtqueue fails in runtime.
>> 
>> I think it's "at runtime".
>> 
>> Can a device have more than one virtqueue?
>
> Yes. And event has "virtqueue": "int" for it.

Got it, thanks!

>>> +#
>>> +# @device: the device's ID if it has one
>>> +#
>>> +# @path: the device's QOM path
>> 
>> I agree with your follow-up: name it @qom-path.
>> 
>>> +#
>>> +# @virtqueue: virtqueue index
>> 
>> Bear with me...  What's a virtqueue index?
>
> sequence number of virtqueue of the vhost device

Maybe something like "the index of the virtqueue that failed".

>>> +#
>>> +# @error: error identifier
>>> +#
>>> +# @description: human readable description
>>> +#
>>> +# Since: 10.1
>>> +##
>>> +{ 'event': 'VIRTQUEUE_ERROR',
>>> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
>>> +            'error': 'VirtqueueError', 'description': 'str'} }
>> 


