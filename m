Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924AEC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Wj6-0000bY-1n; Wed, 09 Apr 2025 10:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Wir-0000MK-TH
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Wiq-0006w8-7H
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744210090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HC9D5jMLOekyJpmVbLEL8XSl99hum9JYY5zwwG6Bf6U=;
 b=WU2i1IVqE52aHNRX26wrE5CxvXi/8o3B1QLUnBSC4UHAeqoh2eUteA8Gx+Y1mzKxIupd8S
 gVRPbX+459u2wALLheuSH3FeNISme0aQD0tNXqNM7Tm8oVHSN9kDR3wuEgwD71PLweOQSl
 5mf7OPEfjCQKSn/QWd9ptEXsKoBgvdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-biEY0xTEPjmvgUwkaJ7Etg-1; Wed,
 09 Apr 2025 10:48:06 -0400
X-MC-Unique: biEY0xTEPjmvgUwkaJ7Etg-1
X-Mimecast-MFC-AGG-ID: biEY0xTEPjmvgUwkaJ7Etg_1744210085
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D471180AF56; Wed,  9 Apr 2025 14:48:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C78E8180B486; Wed,  9 Apr 2025 14:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30F1221E66C5; Wed, 09 Apr 2025 16:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  eblake@redhat.com,
 eduardo@habkost.net,  berrange@redhat.com,  pbonzini@redhat.com,
 dave@treblig.org,  sgarzare@redhat.com,  den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v6] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
In-Reply-To: <556a58ac-7a71-47ef-8f00-312b027955bf@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 9 Apr 2025 17:04:01 +0300")
References: <20250409094758.58232-1-vsementsov@yandex-team.ru>
 <87plhlbofl.fsf@pond.sub.org>
 <556a58ac-7a71-47ef-8f00-312b027955bf@yandex-team.ru>
Date: Wed, 09 Apr 2025 16:48:02 +0200
Message-ID: <87a58p75nh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 09.04.25 13:48, Markus Armbruster wrote:
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
>> 
>> Likely should be tracepoints.  Not this patch's problem, though.
>> 
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>
>>> v6: rename path to qom-path, and improve throttling of the event
>>>      improve wording
>>>
>
> [..]
>
>>> @@ -527,6 +534,13 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>>>                          qdict_get_str(evb->data, "qom-path"));
>>>       }
>>>   
>>> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
>>> +        return !strcmp(qdict_get_str(eva->data, "qom-path"),
>>> +                       qdict_get_str(evb->data, "qom-path")) &&
>>> +            (qdict_get_int(eva->data, "virtqueue") ==
>>> +             qdict_get_int(evb->data, "virtqueue"));
>>> +    }
>>> +
>>>       return TRUE;
>>>   }
>>>   
>> 
>> Rate-limiting is now per virt queue.  It was per device in previous
>> revisions.  Worth it?
>> 
>
> Hmm. Probably not. If we have 2 virtqueue, seems good to see both event
> (or only one, if only one virtqueue failed).
> If we have 256 virtqueues, 256 immediate events seems too much.
> So, better is to drop virtqueue here and consider only qom-path for throttling.
>
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index 25cbcf977b..ddfae18761 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -187,3 +187,35 @@
>>>   { 'command': 'device-sync-config',
>>>     'features': [ 'unstable' ],
>>>     'data': {'id': 'str'} }
>>> +
>>> +##
>>> +# @VirtqueueError:
>>> +#
>>> +# @vhost-vring-error: the vhost device has communicated failure via
>>> +#     the vring error file descriptor
>>> +#
>>> +# Since: 10.1
>>> +##
>>> +{ 'enum': 'VirtqueueError',
>>> +  'data': [ 'vhost-vring-error' ] }
>>> +
>>> +##
>>> +# @VIRTQUEUE_ERROR:
>>> +#
>>> +# Emitted when a device virtqueue fails at runtime.
>>> +#
>>> +# @device: the device's ID if it has one
>>> +#
>>> +# @qom-path: the device's QOM path
>>> +#
>>> +# @virtqueue: the index of the virtqueue that failed
>>> +#
>>> +# @error: error identifier
>>> +#
>>> +# @description: human readable description
>>> +#
>>> +# Since: 10.1
>>> +##
>>> +{ 'event': 'VIRTQUEUE_ERROR',
>>> + 'data': { '*device': 'str', 'qom-path': 'str', 'virtqueue': 'int',
>>> +            'error': 'VirtqueueError', 'description': 'str'} }
>> 
>> Standard question for events: can a management application poll for the
>> information as well?
>
> Oh. that's a good shot.
>
> I'm afraid it can't. And this makes me to dig into history of this patch
> - no, we didn't discussed it before.
>
> And before trying to implement something new here (a way to get a kind of
> virtqueues status by a new QMP command), I check that:
> - our mgmt tool still doesn't use VIRTQUEUE_ERROR event (which we've
> merged to downstream QEMU long ago, of course)
> - the original problem that led us to introducing such event doesn't
> bother us for a long time
>
> It seems wiser to stop here for now. I should have considered these aspects
> before beginning the process of reviving this series. Sorry for your time.

Well, *I* could've remembered the standard question at the beginning!
So, sorry for your time, too :)

> Still, if we (or someone other) need such event in future - good, we have
> a modern patch in mailing list to start from.

Yes.  Thank you!

>> I might have asked this before, I don't remember.  If you already
>> answered it, feel free to point me to your answer.
>> 
>> Why is this a standard question for events?  Say, a management
>> application wants to track the state of X.  Two ways: poll the state
>> with a query command that returns it, listen for events that report a
>> change of X.
>> 
>> Listening for an event is more efficient.
>> 
>> However, if the management application connects to a QEMU instance, X
>> could be anything, so it needs to poll once.
>> 
>> Special case: the management application restarts for some reason.


