Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465E3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2QuS-0004Hs-1z; Thu, 02 May 2024 03:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s2Qu4-0004E4-9B
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:30:59 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s2Qtz-0006Zc-3n
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:30:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C471660BF4;
 Thu,  2 May 2024 10:30:39 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:a] (unknown
 [2a02:6b8:b081:8910::1:a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cUNHom2IdCg0-yPOTIFRN; Thu, 02 May 2024 10:30:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714635039;
 bh=yKjIBp6lkkYGWypBc0uboZPDd/H0TET1EdgGHVSgUTI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VhV6IW2hYcXF+JFK+FdFMzEfA+lm04VtisgWdm69/luOcRvBi2smDae1cBo+71g4V
 8ZmfgcoyoQUFXZsEzNU7w8jgqk8X0t2Wf6mdU7iHPTiRPtk2QX8rsCjPk+TOthuab/
 RWKi9QeKoRU5f78LFlsGyaLzGaYWMM97T4yKMaRg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4942e46a-3ab0-46bd-8a21-90f9b3c1c592@yandex-team.ru>
Date: Thu, 2 May 2024 10:30:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
 <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
 <87plu8ieut.fsf@pond.sub.org>
 <40bee8cc-6cad-4c5b-a319-49dcbb2b82f1@linaro.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <40bee8cc-6cad-4c5b-a319-49dcbb2b82f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/29/24 4:39 PM, Philippe Mathieu-Daudé wrote:

> (+Peter who has more experience on such design).
>
> On 29/4/24 13:32, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Hi Daniil, Markus,
>>>
>>> On 26/4/24 10:39, Markus Armbruster wrote:
>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>
>>>>> This can be used to force-synchronize the time in guest after a long
>>>>> stop-cont pause, which can be useful for serverless-type workload.
>
> What is a "serverless-type workload"?

That's when your VM instance only runs on demand for a few seconds 
before going to sleep again
until the next user request comes in.

>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>> ---
>>>>>    hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>>>>    include/hw/rtc/mc146818rtc.h |  1 +
>>>>>    qapi/misc-target.json        | 16 ++++++++++++++++
>>>>>    3 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>>>> index f4c1869232..6980a78d5f 100644
>>>>> --- a/hw/rtc/mc146818rtc.c
>>>>> +++ b/hw/rtc/mc146818rtc.c
>>>>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>>>        }
>>>>>    }
>>>>>    +void qmp_rtc_notify(Error **errp)
>>>>> +{
>>>>> +    MC146818RtcState *s;
>>>>> +
>>>>> +    /*
>>>>> +     * See:
>>>>> +     * 
>>>>> https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>
> What part of this document explains why this change is required?
> I probably missed it. Explaining it here briefly would be more
> useful.

Sure, will do!

>
>>>>> +     */
>>>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>                                       // Update-ended interrupt enable
>
>>>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>                                       // interrupt request flag
>                                       //           update interrupt flag
>
>>>>> +        qemu_irq_raise(s->irq);
>>>>> +    }
>>>>> +}
>>>>> +
>>>> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
>>>> devices.  Other kinds of RTC devices are silently ignored. Just like
>>>> qmp_rtc_reset_reinjection().
>>>
>>> IMO to avoid any future ambiguity (in heterogeneous machines), this
>>> command must take a QOM device path (or a list of) and only notify
>>> those.
>>
>> Let's compare:
>>
>> • With QOM path:
>>
>>    · You need to know the machine's RTC device(s).
>>
>>      Unfortunately, this is bothersome, as the QOM path is not stable.
>
> But we'll need more of that with dynamic machines...
>
>>      For Q35, it's generally "/machine/unattached/device[N]/rtc", but N
>>      varies with configuration (TCG N=2, KVM N=3 for me), and it might
>>      vary with machine type version.  That's because the machine code
>>      creates ICH9-LPC without a proper name.  We do that a lot. I hate
>>      it.
>>
>>      Likewise for i440FX with PIIX3 instead of ICH9-LPC.
>>
>>      For isapc, it's /machine/unattached/device[3].  I suspect the 3
>>      isn't reliable there, either.
>>
>>      microvm doesn't seem to have an RTC by default.
>>
>>    · If the device so named doesn't support IRQ inject, the command
>>      should fail.
>
> Yes, why the management app would want to run this command if there
> are not RTC on the machine?
>
>>    · Could be generalized to non-RTC devices when that's useful.
>>
>> • Broadcast:
>>
>>    · You don't need to know the machine's RTC device(s).
>>
>>    · If there are multiple RTC devices that support IRQ inject, we 
>> inject
>>      for each of them.  There is no way to select specific RTCs.
>>
>>    · If there is no RTC device that supports IRQ inject, the command 
>> does
>>      nothing silently.
>>
>>      I don't like silent failures.  It could be made to fail instead.
>>
>> If it wasn't for the unstable QOM path problem, I'd advise against
>> the broadcast interface.
>>
>> Thoughts?
>
> Something bugs me in this patch but I couldn't figure out what I am
> missing. The issue is when migrated VM is restored. I don't get why
> the behavior depends on an external decision (via external management
> transport). Don't we have post_load() hooks for such tuning?
> This device implements it in rtc_post_load().

This isn't really related to migration though. Serverless is based on 
constantly stopping and resuming the VM on e.g. every HTTP request to an 
endpoint.

As far as Markus' comment goes, I propose we go the broadcast route, and 
just add the -broadcast suffix to the current command name.

If everyone is okay with that, I will submit a v3.

Thank you!

>
> Regards,
>
> Phil.
>
> PD: BTW tomorrow community call could be a good opportunity to discuss
> this.
>

