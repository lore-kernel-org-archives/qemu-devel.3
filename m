Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0469AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKHz-0004pv-FD; Wed, 29 May 2024 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCKHx-0004pV-TI
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCKHw-0000xP-9m
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716992903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d6Sj/ib8QdQRsWAVAPhAAXnHH6zxQBYlRRVwrjudfj8=;
 b=P+cekUO6DlCUqwnB4tcCPX0GWyF3FBLPlFt49tJbBnLZEoAlbt5LEDP4ITAam0JbZtpjjZ
 8wp5s3+PpxyHYPKWh9DVVSOX38vcLDaUrWQlKchKoZ24xXOm8dFDa+xOjutO4z1LaJoQfy
 Szlbq0Wdm0K0Vp98lhCr5UshCURdAFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-2nI09N6tM0yLpUbtx6cm0A-1; Wed, 29 May 2024 10:28:19 -0400
X-MC-Unique: 2nI09N6tM0yLpUbtx6cm0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AA9D8058D1;
 Wed, 29 May 2024 14:28:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 239872026D6E;
 Wed, 29 May 2024 14:28:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E66721E668F; Wed, 29 May 2024 16:28:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael
 S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts
 via QMP
In-Reply-To: <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru> (Daniil
 Tatianin's message of "Wed, 29 May 2024 15:43:50 +0300")
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
 <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
 <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
Date: Wed, 29 May 2024 16:28:18 +0200
Message-ID: <878qzslmkd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniil Tatianin <d-tatianin@yandex-team.ru> writes:

> On 5/29/24 3:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> On 29/5/24 14:03, Markus Armbruster wrote:
>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>
>>>> This can be used to force-synchronize the time in guest after a long
>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>
>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>> command) only works for the MC146818 RTC controller.
>>>>
>>>> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

[...]

>>>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc=
.h
>>>> index 97cec0b3e8..e9dd0f9c72 100644
>>>> --- a/include/hw/rtc/mc146818rtc.h
>>>> +++ b/include/hw/rtc/mc146818rtc.h
>>>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int=
 base_year,
>>>> =C2=A0 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, i=
nt val);
>>>> =C2=A0 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>>> =C2=A0 void qmp_rtc_reset_reinjection(Error **errp);
>>>> +void qmp_rtc_inject_irq_broadcast(Error **errp);
>>>> =C2=A0 =C2=A0 #endif /* HW_RTC_MC146818RTC_H */
>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>> index 4e0a6492a9..7d388a3753 100644
>>>> --- a/qapi/misc-target.json
>>>> +++ b/qapi/misc-target.json
>>>> @@ -19,6 +19,25 @@
>>>> =C2=A0 { 'command': 'rtc-reset-reinjection',
>>>> =C2=A0=C2=A0=C2=A0 'if': 'TARGET_I386' }
>>>> =C2=A0 +##
>>>> +# @rtc-inject-irq-broadcast:
>>>> +#
>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>> +# The interrupt forces the guest to synchronize the time with RTC.
>>>> +# This is useful after a long stop-cont pause, which is common for
>>>> +# serverless-type workload.

[...]

>>> Make that "workloads".
>>>
>>> "For all existing RTCs" is a lie.=C2=A0 It's really just all mc146818s.=
=C2=A0 The
>>> command works as documented only as long as the VM has no other RTCs.
>>
>> @rtc-mc146818-force-sync-broadcast sounds clearer & safer;
>> IIUC the command goal, mentioning IRQ injection is irrelevant
>> (implementation detail).
>>
> I like this if Markus is okay with that. If we go with this, would it mak=
e sense to drop the "Bug" clause?

Putting "mc146818" right into the command name is fine with me.
Rephrasing the doc comment to say "all MC146818 RTC devices" then makes
sense, and removes the need for a "Bug: clause".

With "mc146818" in the command name, I don't see the need for
"-broadcast".  The fact that it applies to all MC146818 RTCs feels like
detail to me.  In particular since there's usually exactly one.  Still
important enough to spell out in documentation, but I doub't it's
important enough to warrant a mention in the command name.

I have doubts on replacing the commands action "inject-irq" by the
action's purpose "force-sync".  What the guest does with the IRQ is
entirely up to guest software.  Common guest software sets the system
clock from the RTC hardware clock.  But it's really up to the guest.

What about mc146818-inject-irq?

>> (I'm trying to not spread the problems we already have with
>> @rtc-reset-reinjection).

Well, we are adding to them no matter how we name the command.  We're
just more honest about it :)

[...]


