Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57D606A68C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=n4HJijlR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVm49-0003uw-K8; Tue, 24 Nov 2026 03:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVm47-0003ud-MW; Tue, 24 Nov 2026 03:39:51 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVm45-0003XT-L8; Tue, 24 Nov 2026 03:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795509576; bh=xzFCshCz1rK+8cgG47oxCDIeBJrZSvHc2zU0HDMSrhE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=n4HJijlRXPjeohGxZ04ir+3mi6oVvgYpdDLSNJA/9/GDXEddG/FPctRBrq3mUye6a
 py2kM+w/PrXcRWspJWFWvlY8za2pDgZ+9ZP00XpUS+hsmW6pB9HtgXGVLbSDxJ2aYp
 xabXSEKBLfavRU67+Hme+p51ex1/fT2+cV6SG6xc=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 7029D203B0;
 Tue, 24 Nov 2026 09:39:36 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 746D121E6A04; Tue, 24 Nov 2026 09:39:44 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: "Denis V. Lunev" <den@openvz.org>,  qemu-devel@nongnu.org,  Markus
 Armbruster <armbru@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
In-Reply-To: <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 24 Nov 2026
 00:03:02 +0100")
References: <20261123212957.242482-1-den@openvz.org>
 <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:39:44 +0100
Message-ID: <87o6be4o8f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 23/11/26 22:29, Denis V. Lunev wrote:
>> From: Denis V. Lunev <den@openvz.org>
>> Rate-limited events can be raised from iothreads, outside the BQL.
>> QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
>> rate limited too, and any disk on an iothread raises it.
>> The rate-limit timer runs in the main loop. timerlist_run_timers()
>> takes it off the active list before it calls the handler, and only then
>> does the handler take monitor_lock. An iothread raising the same event
>> for the same device in between finds the rate-limit entry with a timer
>> that is no longer pending, and QEMU aborts with:
>>    Assertion `!evstate || timer_pending(evstate->timer)' failed.
>> This hits virtio-blk on an iothread with an error policy other than
>> stop when the storage goes away and every guest request fails.
>> The state is fine, the assert is wrong. Once the timer has fired, the
>> handler is committed to run: it takes the lock as soon as the iothread
>> drops it, sends the stored event and re-arms the timer, exactly as for
>> an event stored while the timer was pending. The event goes out at the
>> same moment it would have had the iothread come in after the handler.
>> The entry is only created, re-armed and freed under monitor_lock, so it
>> cannot go away under the iothread. Drop the assert.
>> Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a ha=
sh table")
>> Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_E=
RROR reports")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>   monitor/monitor.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 2654b81890..22c00b6195 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent even=
t, QDict *qdict)
>>          MonitorQAPIEventState key =3D { .event =3D event, .data =3D dat=
a };
>>
>>          evstate =3D g_hash_table_lookup(monitor_qapi_event_state, &key);
>> -        assert(!evstate || timer_pending(evstate->timer));
>>
>>          if (evstate) {
>>              /*
>>               * Timer is pending for (at least) evconf->rate ns after
>> -             * last send.  Store event for sending when timer fires,
>> -             * replacing a prior stored event if any.
>> +             * last send, or it has expired and its handler has not
>> +             * taken monitor_lock yet. Either way the handler will
>> +             * send what is stored here. Store event for sending
>> +             * then, replacing a prior stored event if any.
>
> How about:
>
>  +             * last send, or its handler has not taken monitor_lock
>  +             * yet (the timer may have fired, or not been armed yet).
>  +             * Either way the handler will send what is stored here.
>  +             * Store event for sending then, replacing a prior stored
>  +             * event if any.
>
> ?

I find this version harder to understand.  What scenario exactly is
missing from Denis's version?  And is it important here?

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>
>>                */
>>               qobject_unref(evstate->qdict);
>>               evstate->qdict =3D qobject_ref(qdict);
>> base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e

