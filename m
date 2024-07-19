Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DD0C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjcT-0001Kz-4q; Fri, 19 Jul 2024 05:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUjcR-0001Hx-6Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUjcO-0004st-R3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721380175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PUJk/0MkZcaZCDrEgB01nwWkVPstR0jttRuGV8mw84=;
 b=OZ4CYdRh0DS6QwSknsBs8VaYphcPhn0w5DWOapHIiRi5OPYl20w9gmWIKvfsw0v4qk9w2F
 d1fck7JjrOEvmEnkY58ltF+LppOIjOcACfOwN6xUj763w/b+hP6Y7XEmxW9X7FHRpxltL9
 5EY6lB6XATXuhHEWeGPPbFdb1tKxPu8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-uCDvJZCYP-elC5V1ogGT-A-1; Fri,
 19 Jul 2024 05:09:29 -0400
X-MC-Unique: uCDvJZCYP-elC5V1ogGT-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF081955D4F; Fri, 19 Jul 2024 09:09:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B3BF195605A; Fri, 19 Jul 2024 09:09:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6349E21E668A; Fri, 19 Jul 2024 11:09:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  zeil@yandex-team.ru,  yc-core@yandex-team.ru,
 dave@treblig.org,  Leonid Kaplan <xeor@yandex-team.ru>
Subject: Re: [PATCH v2] block-backend: per-device throttling of
 BLOCK_IO_ERROR reports
In-Reply-To: <ZpogyBq9yKoQOoLW@redhat.com> (Kevin Wolf's message of "Fri, 19
 Jul 2024 10:16:08 +0200")
References: <20240109131308.455371-1-vsementsov@yandex-team.ru>
 <Zplo5VsG-q-e643H@redhat.com> <87ikx2j81u.fsf@pond.sub.org>
 <ZpogyBq9yKoQOoLW@redhat.com>
Date: Fri, 19 Jul 2024 11:09:24 +0200
Message-ID: <87cyn9vjcr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.07.2024 um 06:54 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 09.01.2024 um 14:13 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> >> From: Leonid Kaplan <xeor@yandex-team.ru>
>> >> 
>> >> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
>> >> We still want per-device throttling, so let's use device id as a key.
>> >> 
>> >> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
>> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> >> ---
>> >> 
>> >> v2: add Note: to QAPI doc
>> >> 
>> >>  monitor/monitor.c    | 10 ++++++++++
>> >>  qapi/block-core.json |  2 ++
>> >>  2 files changed, 12 insertions(+)
>> >> 
>> >> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> >> index 01ede1babd..ad0243e9d7 100644
>> >> --- a/monitor/monitor.c
>> >> +++ b/monitor/monitor.c
>> >> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
>> >>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>> >>      /* Limit guest-triggerable events to 1 per second */
>> >>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
>> >> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
>> >>      [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>> >>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>> >>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>> >> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>> >>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>> >>      }
>> >>  
>> >> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
>> >> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
>> >> +    }
>> >
>> > Using "device" only works with -drive, i.e. when the BlockBackend
>> > actually has a name. In modern configurations with a -blockdev
>> > referenced by -device, the BlockBackend doesn't have a name any more.
>> >
>> > Maybe we should be using the qdev id (or more generally, QOM path) here,
>> > but that's something the event doesn't even contain yet.
>> 
>> Uh, does the event reliably identify the I/O error's node or not?  If
>> not, then that's a serious design defect.
>> 
>> There's @node-name.  Several commands use "either @device or @node-name"
>> to identify a node.  Is that sufficient here?
>
> Possibly. The QAPI event is sent by a device, not by the backend, and
> the commit message claims per-device throttling. That's what made me
> think that we should base it on the device id.

This is an argument for having the event point at the device.  Events
that already point at the device carry a mandatory @qom-path, and some
also carry an optional qdev @id for backward compatibility.

As far as I can tell, not all devices implement this event.  If that's
true, then documentation should spell it out.

> But it's true that the error does originate in the backend (and it's
> unlikely that two devices are attached to the same node anyway), so the
> node-name could be good enough if we don't have a BlockBackend name. We
> should claim per-block-node rather then per-device throttling then.

Yes.


