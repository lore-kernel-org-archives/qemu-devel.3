Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PFK-0001jV-Ks; Mon, 29 Apr 2024 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1PFI-0001iz-3B
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1PFG-0006JZ-Dk
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714390349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBVpLm3jvO/mJQAtmby+Y0r8Hl61Y109EcKFsoMWi9Y=;
 b=VghfCg2WXZ70U3OSwjyhENqvh7NhC6lV/jorBWpPlSesRmViJz6utoIM0kq7e3Of6J2G4K
 rFzZKpnwSrVTYL9C9W8Zb1PG6eR3NNOKaDl989B05DkCHkiJx3hmzr5O9CfkJR1twzW5ln
 p7YXZV0ZgIC9ooIANHHOqZ2wCu8VlZA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-rkiV8AO3NLaQiE0zI7TsoQ-1; Mon,
 29 Apr 2024 07:32:28 -0400
X-MC-Unique: rkiV8AO3NLaQiE0zI7TsoQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95FF38000AC;
 Mon, 29 Apr 2024 11:32:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F1040C5C2;
 Mon, 29 Apr 2024 11:32:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A17BD21E66E5; Mon, 29 Apr 2024 13:32:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
In-Reply-To: <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 26 Apr 2024 11:48:12
 +0200")
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
 <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
Date: Mon, 29 Apr 2024 13:32:26 +0200
Message-ID: <87plu8ieut.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Daniil, Markus,
>
> On 26/4/24 10:39, Markus Armbruster wrote:
>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>=20
>>> This can be used to force-synchronize the time in guest after a long
>>> stop-cont pause, which can be useful for serverless-type workload.
>>>
>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> ---
>>>   hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>>   3 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>> index f4c1869232..6980a78d5f 100644
>>> --- a/hw/rtc/mc146818rtc.c
>>> +++ b/hw/rtc/mc146818rtc.c
>>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>       }
>>>   }
>>>   +void qmp_rtc_notify(Error **errp)
>>> +{
>>> +    MC146818RtcState *s;
>>> +
>>> +    /*
>>> +     * See:
>>> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeepin=
g.txt
>>> +     */
>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>> +        s->cmos_data[RTC_REG_B] |=3D REG_B_UIE;
>>> +        s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF | REG_C_UF;
>>> +        qemu_irq_raise(s->irq);
>>> +    }
>>> +}
>>> +
>> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
>> devices.  Other kinds of RTC devices are silently ignored.  Just like
>> qmp_rtc_reset_reinjection().
>
> IMO to avoid any future ambiguity (in heterogeneous machines), this
> command must take a QOM device path (or a list of) and only notify
> those.

Let's compare:

=E2=80=A2 With QOM path:

  =C2=B7 You need to know the machine's RTC device(s).

    Unfortunately, this is bothersome, as the QOM path is not stable.

    For Q35, it's generally "/machine/unattached/device[N]/rtc", but N
    varies with configuration (TCG N=3D2, KVM N=3D3 for me), and it might
    vary with machine type version.  That's because the machine code
    creates ICH9-LPC without a proper name.  We do that a lot.  I hate
    it.

    Likewise for i440FX with PIIX3 instead of ICH9-LPC.

    For isapc, it's /machine/unattached/device[3].  I suspect the 3
    isn't reliable there, either.

    microvm doesn't seem to have an RTC by default.

  =C2=B7 If the device so named doesn't support IRQ inject, the command
    should fail.

  =C2=B7 Could be generalized to non-RTC devices when that's useful.

=E2=80=A2 Broadcast:

  =C2=B7 You don't need to know the machine's RTC device(s).

  =C2=B7 If there are multiple RTC devices that support IRQ inject, we inje=
ct
    for each of them.  There is no way to select specific RTCs.

  =C2=B7 If there is no RTC device that supports IRQ inject, the command do=
es
    nothing silently.

    I don't like silent failures.  It could be made to fail instead.

If it wasn't for the unstable QOM path problem, I'd advise against
the broadcast interface.

Thoughts?


