Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEEC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 04:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUfdd-0007EC-Oe; Fri, 19 Jul 2024 00:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUfdc-0007Ce-9A
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUfdZ-0004gI-Qs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721364872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d830vxLYwKHdqqlLDLomsTm3dMWC3fRKAUKF/2lv/x8=;
 b=P8ufKmUW+0KREnKKoXb8F164iIXVIKIDyjNGM3GwFgvv2XfjWoq+aXb+djxJHIwjjRTC2T
 g1Js0leTicLHzphPBdEu1ipkZL53/XKEG6CUQ5bHQJzmhG/K817RoEYVudkZjcYZwPIa9e
 KCS+P8HVs4L44fOC7J6L6D6XA9gQNis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-ktfONHf_OjOHiDS8EL1zOA-1; Fri,
 19 Jul 2024 00:54:29 -0400
X-MC-Unique: ktfONHf_OjOHiDS8EL1zOA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 994A01955D44; Fri, 19 Jul 2024 04:54:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E509619560B2; Fri, 19 Jul 2024 04:54:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBE8821E66A3; Fri, 19 Jul 2024 06:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  zeil@yandex-team.ru,  yc-core@yandex-team.ru,
 dave@treblig.org,  Leonid Kaplan <xeor@yandex-team.ru>
Subject: Re: [PATCH v2] block-backend: per-device throttling of
 BLOCK_IO_ERROR reports
In-Reply-To: <Zplo5VsG-q-e643H@redhat.com> (Kevin Wolf's message of "Thu, 18
 Jul 2024 21:11:33 +0200")
References: <20240109131308.455371-1-vsementsov@yandex-team.ru>
 <Zplo5VsG-q-e643H@redhat.com>
Date: Fri, 19 Jul 2024 06:54:21 +0200
Message-ID: <87ikx2j81u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> Am 09.01.2024 um 14:13 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> From: Leonid Kaplan <xeor@yandex-team.ru>
>> 
>> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
>> We still want per-device throttling, so let's use device id as a key.
>> 
>> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>> 
>> v2: add Note: to QAPI doc
>> 
>>  monitor/monitor.c    | 10 ++++++++++
>>  qapi/block-core.json |  2 ++
>>  2 files changed, 12 insertions(+)
>> 
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 01ede1babd..ad0243e9d7 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
>>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>      /* Limit guest-triggerable events to 1 per second */
>>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
>> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
>>      [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>>          hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>>      }
>>  
>> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
>> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
>> +    }
>
> Using "device" only works with -drive, i.e. when the BlockBackend
> actually has a name. In modern configurations with a -blockdev
> referenced by -device, the BlockBackend doesn't have a name any more.
>
> Maybe we should be using the qdev id (or more generally, QOM path) here,
> but that's something the event doesn't even contain yet.

Uh, does the event reliably identify the I/O error's node or not?  If
not, then that's a serious design defect.

There's @node-name.  Several commands use "either @device or @node-name"
to identify a node.  Is that sufficient here?

[...]


