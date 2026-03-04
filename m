Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643AAE67A8A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxlWq-0005s1-AE; Wed, 04 Mar 2026 07:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxlWh-0005q1-7F
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxlWe-0004ZJ-G0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772628026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wXgpZHmqrmykMYuioUb5WDstfmLdu4Eg9IrCF/WQyX0=;
 b=Q7qmsT+g3/kyAeFHvHiyUxP2BCMKKzyhCW7aRlKgqFqgxuILDmg/fxLbldQVNju0hE29Gm
 T6pwpgb8UwIrcZC2hMe7I9weqwnsnblgrWS5ZHCZ/puVz0MWoeSuPZ5lbxuRZ2QJ5TXmbH
 sfuV/TSYDrvo/QXawHRiosQP+FOsVWI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-dKSiDhGSPM2YeadbRneASw-1; Wed,
 04 Mar 2026 07:40:23 -0500
X-MC-Unique: dKSiDhGSPM2YeadbRneASw-1
X-Mimecast-MFC-AGG-ID: dKSiDhGSPM2YeadbRneASw_1772628021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B5A618005B4; Wed,  4 Mar 2026 12:40:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28170195608E; Wed,  4 Mar 2026 12:40:17 +0000 (UTC)
Date: Wed, 4 Mar 2026 12:40:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, xeor@yandex-team.ru,
 vsementsov@yandex-team.ru, pkrempa@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] block: Never drop BLOCK_IO_ERROR with action=stop for
 rate limiting
Message-ID: <aagoLvb3zpLlVtED@redhat.com>
References: <20260304122800.51923-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304122800.51923-1-kwolf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 04, 2026 at 01:28:00PM +0100, Kevin Wolf wrote:
> Commit 2155d2dd introduced rate limiting for BLOCK_IO_ERROR to emit an
> event only once a second. This makes sense for cases in which the guest
> keeps running and can submit more requests that would possibly also fail
> because there is a problem with the backend.
> 
> However, if the error policy is configured so that the VM is stopped on
> errors, this is both unnecessary because stopping the VM means that the
> guest can't issue more requests and in fact harmful because stopping the
> VM is an important state change that management tools need to keep track
> of even if it happens more than once in a given second. If an event is
> dropped, the management tool would see a VM randomly going to paused
> state without an associated error, so it has a hard time deciding how to
> handle the situation.
> 
> This patch disables rate limiting for action=stop by not relying on the
> event type alone any more in monitor_qapi_event_queue_no_reenter(), but
> checking action for BLOCK_IO_ERROR, too. If the error is reported to the
> guest or ignored, the rate limiting stays in place.
> 
> Fixes: 2155d2dd7f73 ('block-backend: per-device throttling of BLOCK_IO_ERROR reports')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  2 +-
>  monitor/monitor.c    | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b66bf316e2f..da0b36a3751 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5794,7 +5794,7 @@
>  # .. note:: If action is "stop", a `STOP` event will eventually follow
>  #    the `BLOCK_IO_ERROR` event.
>  #
> -# .. note:: This event is rate-limited.
> +# .. note:: This event is rate-limited, except if action is "stop".
>  #
>  # Since: 0.13
>  #
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 1273eb72605..37fa674cfe6 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -367,14 +367,33 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
>  {
>      MonitorQAPIEventConf *evconf;
>      MonitorQAPIEventState *evstate;
> +    bool throttled;
>  
>      assert(event < QAPI_EVENT__MAX);
>      evconf = &monitor_qapi_event_conf[event];
>      trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> +    throttled = evconf->rate;
> +
> +    /*
> +     * Rate limit BLOCK_IO_ERROR only for action != "stop".
> +     *
> +     * If the VM is stopped after an I/O error, this is important information
> +     * for the management tool to keep track of the state of QEMU and we can't
> +     * merge any events. At the same time, stopping the VM means that the guest
> +     * can't send additional requests and the number of events is already
> +     * limited, so we can do without rate limiting.
> +     */
> +    if (event == QAPI_EVENT_BLOCK_IO_ERROR) {
> +        QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
> +        const char *action = qdict_get_str(data, "action");
> +        if (!strcmp(action, "stop")) {
> +            throttled = false;
> +        }
> +    }

Can this be handled in the same way as other events viat he
qapi_event_throttle_hash & qapi_event_throttle_equal methods ?

eg if action is "stop", then ensure "equal" is always false ?
Possibly add a random token to the hash but might not be needed
if 'equal' is always false

>  
>      QEMU_LOCK_GUARD(&monitor_lock);
>  
> -    if (!evconf->rate) {
> +    if (!throttled) {
>          /* Unthrottled event */
>          monitor_qapi_event_emit(event, qdict);
>      } else {
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


