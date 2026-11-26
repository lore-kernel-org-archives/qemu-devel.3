Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=GDFbEp14
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQhg-0002wb-JZ; Wed, 25 Nov 2026 23:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWQhf-0002wO-0a; Wed, 25 Nov 2026 23:03:23 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWQhc-0006Bu-Sm; Wed, 25 Nov 2026 23:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795665786; bh=xnP0f7+tzQHd4V1uhtUR/JwihFtQlsGAVQW8PkjzPtc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GDFbEp14P+e1ekIZRl9Yl7lMwmh48fSNUbvg+irboT/PcznRppBDTlvF/A1NcN85I
 0hiGrXleS6NxN/25VhlqLQBFxED56sGwPPyNuxMoD3EyjKJRsYHhMIORdEomb3/V8h
 MIUPVIXWtmx6fLT/dQy2lcKBE6q9h13BzN5C/PT0=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id DF1AC20219;
 Thu, 26 Nov 2026 05:03:05 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EBA821E6A04; Thu, 26 Nov 2026 05:03:14 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev"
 <den@openvz.org>,  qemu-devel@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] monitor: fix abort when a rate-limited event races with
 its timer
In-Reply-To: <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com> (Denis
 V. Lunev's message of "Wed, 25 Nov 2026 17:58:54 +0100")
References: <20261123212957.242482-1-den@openvz.org>
 <dec9aea7-8fc9-419b-8178-8e61917f02e2@oss.qualcomm.com>
 <87o6be4o8f.fsf@pond.sub.org>
 <d9137705-39f0-4a72-bafc-ea483183cecf@oss.qualcomm.com>
 <5b13cf6f-0222-4029-96de-0464299f6bab@virtuozzo.com>
Date: Thu, 26 Nov 2026 05:03:14 +0100
Message-ID: <87ik1k6xz1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 11/24/26 10:57, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 24/11/26 09:39, Markus Armbruster wrote:
>>> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>>>
>>>> On 23/11/26 22:29, Denis V. Lunev wrote:

[...]

>>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>>> index 2654b81890..22c00b6195 100644
>>>>> --- a/monitor/monitor.c
>>>>> +++ b/monitor/monitor.c
>>>>> @@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent e=
vent, QDict *qdict)
>>>>>          MonitorQAPIEventState key =3D { .event =3D event, .data =3D =
data };
>>>>>
>>>>>          evstate =3D g_hash_table_lookup(monitor_qapi_event_state, &k=
ey);
>>>>> -        assert(!evstate || timer_pending(evstate->timer));
>>>>>
>>>>>          if (evstate) {
>>>>>              /*
>>>>>               * Timer is pending for (at least) evconf->rate ns after
>>>>> -             * last send.  Store event for sending when timer fires,
>>>>> -             * replacing a prior stored event if any.
>>>>> +             * last send, or it has expired and its handler has not
>>>>> +             * taken monitor_lock yet. Either way the handler will
>>>>> +             * send what is stored here. Store event for sending
>>>>> +             * then, replacing a prior stored event if any.
>>>>
>>>> How about:
>>>>
>>>>  +             * last send, or its handler has not taken monitor_lock
>>>>  +             * yet (the timer may have fired, or not been armed yet).
>>>>  +             * Either way the handler will send what is stored here.
>>>>  +             * Store event for sending then, replacing a prior stored
>>>>  +             * event if any.
>>>>
>>>> ?
>>>
>>> I find this version harder to understand.  What scenario exactly is
>>> missing from Denis's version?  And is it important here?
>>
>> The issue Denis fixed also exists in the gap before the first
>> timer_mod_ns() under monitor_lock and between timer_mod_ns() calls
>> after later sends, now described as "or has not been armed yet":
>>
>> "the timer has fired [, or has not been armed yet], and its handler has=
=20
>> not taken monitor_lock."
>
> We hold monitor_lock from the hash insertion through the first
> timer_mod_ns(), so another thread can't see the entry before the timer is
> armed. The handler holds the same lock while it sends the event and rearms
> the timer.
>
> Another thread can see the entry with the timer no longer pending only af=
ter
> the timer fires and before the handler takes monitor_lock. I'd keep the
> posted wording.

This makes sense, thank you!

Reviewed-by: Markus Armbruster <armbru@redhat.com>

