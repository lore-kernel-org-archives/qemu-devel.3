Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUimv-0004R4-B3; Fri, 19 Jul 2024 04:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUimt-0004Pp-1K
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUimr-0005v6-5v
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721376979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJpIx2XBoaEsitljLaEzptRNjAJGUtpl7F88FtPC4TQ=;
 b=A1YhXy/sJwR/c0mjaXvB4ZUgteL6K4nItOWTRIhfl2znxZlek3gjPuF4ZbmlT9N3EQK5Eh
 3Mjd9457BFNvfVctMDKJTePYbbzZFVDYS+kjYx95zwsyYdg1txaBooKico7IUYUxB04FmQ
 QJF7ayfNvD+CYEuneoHaGxPzcZyEcDQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-6BDHLqSYPbmOupD8kI5b6A-1; Fri,
 19 Jul 2024 04:16:17 -0400
X-MC-Unique: 6BDHLqSYPbmOupD8kI5b6A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A778F1955D54; Fri, 19 Jul 2024 08:16:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.130])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2DE2195605A; Fri, 19 Jul 2024 08:16:10 +0000 (UTC)
Date: Fri, 19 Jul 2024 10:16:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 hreitz@redhat.com, zeil@yandex-team.ru, yc-core@yandex-team.ru,
 dave@treblig.org, Leonid Kaplan <xeor@yandex-team.ru>
Subject: Re: [PATCH v2] block-backend: per-device throttling of
 BLOCK_IO_ERROR reports
Message-ID: <ZpogyBq9yKoQOoLW@redhat.com>
References: <20240109131308.455371-1-vsementsov@yandex-team.ru>
 <Zplo5VsG-q-e643H@redhat.com> <87ikx2j81u.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikx2j81u.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 19.07.2024 um 06:54 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 09.01.2024 um 14:13 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> From: Leonid Kaplan <xeor@yandex-team.ru>
> >> 
> >> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
> >> We still want per-device throttling, so let's use device id as a key.
> >> 
> >> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> ---
> >> 
> >> v2: add Note: to QAPI doc
> >> 
> >>  monitor/monitor.c    | 10 ++++++++++
> >>  qapi/block-core.json |  2 ++
> >>  2 files changed, 12 insertions(+)
> >> 
> >> diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> index 01ede1babd..ad0243e9d7 100644
> >> --- a/monitor/monitor.c
> >> +++ b/monitor/monitor.c
> >> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
> >>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> >>      /* Limit guest-triggerable events to 1 per second */
> >>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> >> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
> >>      [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
> >>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
> >>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> >> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
> >>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
> >>      }
> >>  
> >> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
> >> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> >> +    }
> >
> > Using "device" only works with -drive, i.e. when the BlockBackend
> > actually has a name. In modern configurations with a -blockdev
> > referenced by -device, the BlockBackend doesn't have a name any more.
> >
> > Maybe we should be using the qdev id (or more generally, QOM path) here,
> > but that's something the event doesn't even contain yet.
> 
> Uh, does the event reliably identify the I/O error's node or not?  If
> not, then that's a serious design defect.
> 
> There's @node-name.  Several commands use "either @device or @node-name"
> to identify a node.  Is that sufficient here?

Possibly. The QAPI event is sent by a device, not by the backend, and
the commit message claims per-device throttling. That's what made me
think that we should base it on the device id.

But it's true that the error does originate in the backend (and it's
unlikely that two devices are attached to the same node anyway), so the
node-name could be good enough if we don't have a BlockBackend name. We
should claim per-block-node rather then per-device throttling then.

Kevin


