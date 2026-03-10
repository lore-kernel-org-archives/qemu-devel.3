Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7359EB105B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxxs-0006JY-9p; Tue, 10 Mar 2026 10:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzxxp-0006Iz-D8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzxxm-0008Mn-0L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773152493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPDNQB22OH1icWGTv0aradCc9IgBGx5DXINS//ejKek=;
 b=QbP9RseLJgWm026qPyU10MzwiQMAssXWGgxqtCak0UbyxN5cXT54RrW9NDu2N/xIgEzKgI
 gPSmTOdXqe2CkKGomLSLtocgnkuFdRB09H5fbVyz9A125e/cpbfQchv1DU5BiAEZtnoFmA
 5ngTFkqeHNwL/zA4zaXsmcRKDvFxoh0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-a7TdJ_XjOJqlpaILKeAqRA-1; Tue,
 10 Mar 2026 10:21:28 -0400
X-MC-Unique: a7TdJ_XjOJqlpaILKeAqRA-1
X-Mimecast-MFC-AGG-ID: a7TdJ_XjOJqlpaILKeAqRA_1773152486
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0235018005B2; Tue, 10 Mar 2026 14:21:26 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41EBD19560A6; Tue, 10 Mar 2026 14:21:23 +0000 (UTC)
Date: Tue, 10 Mar 2026 15:21:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, xeor@yandex-team.ru,
 vsementsov@yandex-team.ru, pkrempa@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
Message-ID: <abAo4NCbVN0PejkM@redhat.com>
References: <20260304122800.51923-1-kwolf@redhat.com>
 <87y0jzresf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0jzresf.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 10.03.2026 um 14:32 hat Markus Armbruster geschrieben:
> This is now commit 544ddbb6373d61292a0e2dc269809cd6bd5edec6.  I'm not
> objecting.  Just a few remarks.  I dropped qemu-stable@ from cc.
> 
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
> > event only once a second. This makes sense for cases in which the guest
> > keeps running and can submit more requests that would possibly also fail
> > because there is a problem with the backend.
> >
> > However, if the error policy is configured so that the VM is stopped on
> > errors, this is both unnecessary because stopping the VM means that the
> > guest can't issue more requests and in fact harmful because stopping the
> > VM is an important state change that management tools need to keep track
> > of even if it happens more than once in a given second. If an event is
> > dropped, the management tool would see a VM randomly going to paused
> > state without an associated error, so it has a hard time deciding how to
> > handle the situation.
> >
> > This patch disables rate limiting for action=stop by not relying on the
> > event type alone any more in monitor_qapi_event_queue_no_reenter(), but
> > checking action for BLOCK_IO_ERROR, too. If the error is reported to the
> > guest or ignored, the rate limiting stays in place.
> >
> > Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json |  2 +-
> >  monitor/monitor.c    | 21 ++++++++++++++++++++-
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b66bf316e2f..da0b36a3751 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5794,7 +5794,7 @@
> >  # .. note:: If action is "stop", a `STOP` event will eventually follow
> >  #    the `BLOCK_IO_ERROR` event.
> >  #
> > -# .. note:: This event is rate-limited.
> > +# .. note:: This event is rate-limited, except if action is "stop".
> >  #
> >  # Since: 0.13
> >  #
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 1273eb72605..37fa674cfe6 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -367,14 +367,33 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
> >  {
> >      MonitorQAPIEventConf *evconf;
> >      MonitorQAPIEventState *evstate;
> > +    bool throttled;
> >  
> >      assert(event < QAPI_EVENT__MAX);
> >      evconf = &monitor_qapi_event_conf[event];
> >      trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> > +    throttled = evconf->rate;
> > +
> > +    /*
> > +     * Rate limit BLOCK_IO_ERROR only for action != "stop".
> > +     *
> > +     * If the VM is stopped after an I/O error, this is important information
> > +     * for the management tool to keep track of the state of QEMU and we can't
> > +     * merge any events. At the same time, stopping the VM means that the guest
> > +     * can't send additional requests and the number of events is already
> > +     * limited, so we can do without rate limiting.
> > +     */
> > +    if (event == QAPI_EVENT_BLOCK_IO_ERROR) {
> > +        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
> > +        const char *action = qdict_get_str(data, "action");
> > +        if (!strcmp(action, "stop")) {
> > +            throttled = false;
> > +        }
> > +    }
> 
> Having event-specific logic in the general event emission function is
> ugly.
> 
> Before the patch, the "throttle this event?" logic is coded in one
> place: table monitor_qapi_event_conf[].
> 
> The table maps from event kind (enum QAPIEvent) to the minimum time
> between two events.  Non-zero specifies a rate limit, zero makes it
> unlimited.
> 
> Aside: as far as I can tell, we've only ever used one
> MonitorQAPIEventConf: { .rate = 1000 * SCALE_MS }.  Could be dumbed down
> to bool.
> 
> This is insufficient for QAPIEvent QAPI_EVENT_BLOCK_IO_ERROR, where the
> desired rate depends on event data, not just the QAPIEvent.
> 
> The patch gives us the desired rate, but it splits the logic between the
> map and the map's user.
> 
> I think the cleaner solution is to make the map more capable: have it
> maps from the entire event, not just its kind.
> 
> An obvious way to do that would be a table of function pointers
> 
>     bool (*)(QAPIEvent, QDict *)
> 
> Null means unlimited.
> 
> The table entry for BLOCK_IO_ERROR returns false for unlimited when
> "action" is "stop", else true.
> 
> The table entries for the other rate-limited events simply return true.
> 
> Thoughts?

Like you, I often prefer data to code. However, if the data becomes just
a table of function pointers to trivial functions, wouldn't it be better
to just have it as code in the first place?

It could be a helper function with the same signature as you proposed
above and it would simply be a switch statement returning true for a few
event types, looking at the QDict for BLOCK_IO_ERROR and returning false
for default. Seems a lot simpler than an explicit table of function
pointers.

Kevin


