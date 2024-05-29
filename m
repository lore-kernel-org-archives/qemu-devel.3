Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368D5C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKO6-0001NN-Qo; Wed, 29 May 2024 10:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCKO4-0001L5-IN
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCKO2-0001qz-Qz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716993282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tbmm0b0IxMJdUEUhFD3+xi87OTMUHeROW/rrSw+Zwg=;
 b=QJ1lYFTolyHJTHZrpMbUk+P3z4WfcSdK9/Sz3zVN/yJbTypvZpzF6XolvyozPNEJqfc4I1
 HIgVhW5Cs1mOPcrkVoytSqLzGRXihFoVfQkDnERANg3sgK2guzuNyQ9mIsaO1HnCvopzPx
 5bKhKz9FsY2TDQ6k4ca5SXdsnqv3sPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-BQxl-r11OXSlQYjap0TxpA-1; Wed, 29 May 2024 10:34:35 -0400
X-MC-Unique: BQxl-r11OXSlQYjap0TxpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BB3B812296;
 Wed, 29 May 2024 14:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 435B5200B3A1;
 Wed, 29 May 2024 14:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34DB321E681D; Wed, 29 May 2024 16:34:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus
 Armbruster
 <armbru@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts
 via QMP
In-Reply-To: <bbe49906-26b5-4443-9be1-c621a76c53d8@yandex-team.ru> (Daniil
 Tatianin's message of "Wed, 29 May 2024 16:51:42 +0300")
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
 <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
 <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
 <079a43b9-52db-4428-9ae4-52a31fbf5e74@linaro.org>
 <bbe49906-26b5-4443-9be1-c621a76c53d8@yandex-team.ru>
Date: Wed, 29 May 2024 16:34:34 +0200
Message-ID: <874jaglm9x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On 5/29/24 4:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> On 29/5/24 14:43, Daniil Tatianin wrote:
>>> On 5/29/24 3:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>>> On 29/5/24 14:03, Markus Armbruster wrote:
>>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>>
>>>>>> This can be used to force-synchronize the time in guest after a long
>>>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>>>
>>>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>>>> command) only works for the MC146818 RTC controller.
>>>>>>
>>>>>> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>>> ---
>>>>>>
>>>>>> Changes since v0:
>>>>>> - Rename to rtc-inject-irq to match other similar API
>>>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>>>
>>>>>> Changes since v1:
>>>>>> - Added a description below the QMP command to explain how it can be
>>>>>> =C2=A0=C2=A0 used and what it does.
>>>>>>
>>>>>> Changes since v2:
>>>>>> - Add a 'broadcast' suffix.
>>>>>> - Change the comments to explain the flags we're setting.
>>>>>> - Change the command description to fix styling & explain that it's =
a broadcast command.
>>>>>>
>>>>>> Changes since v3:
>>>>>> - Fix checkpatch complaints about usage of C99 comments
>>>>>>
>>>>>> ---
>>>>>> =C2=A0 hw/rtc/mc146818rtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 20 ++++++++++++++++++++
>>>>>> =C2=A0 include/hw/rtc/mc146818rtc.h |=C2=A0 1 +
>>>>>> =C2=A0 qapi/misc-target.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 19 +++++++++++++++++++
>>>>>> =C2=A0 3 files changed, 40 insertions(+)
>>
>>
>>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>>> index 4e0a6492a9..7d388a3753 100644
>>>>>> --- a/qapi/misc-target.json
>>>>>> +++ b/qapi/misc-target.json
>>>>>> @@ -19,6 +19,25 @@
>>>>>> =C2=A0 { 'command': 'rtc-reset-reinjection',
>>>>>> =C2=A0=C2=A0=C2=A0 'if': 'TARGET_I386' }
>>>>>> =C2=A0 +##
>>>>>> +# @rtc-inject-irq-broadcast:
>>>>>> +#
>>>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>>>> +# The interrupt forces the guest to synchronize the time with RTC.
>>>>>> +# This is useful after a long stop-cont pause, which is common for
>>>>>> +# serverless-type workload.
>>>>
>>>> In previous version you said:
>>>>
>>>> =C2=A0 > This isn't really related to migration though. Serverless is =
based
>>>> =C2=A0 > on constantly stopping and resuming the VM on e.g. every HTTP
>>>> =C2=A0 > request to an endpoint.
>>>>
>>>> Which made some sense. Maybe mention HTTP? And point to that use case
>>>> (possibly with QMP commands) in the commit description?
>>>
>>> Hmm, maybe it would be helpful for people who don't know what serverles=
s means.
>>>
>>> How about:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 This is useful after a long stop-const pause, =
which is common for serverless-type workloads,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 e.g. stopping/resuming the VM on every HTTP re=
quest to an endpoint, which might involve
>>> =C2=A0=C2=A0=C2=A0=C2=A0 a long pause in between the requests, causing =
time drift in the guest.
>>
>> Please help me understand your workflow. Your management layer call
>> @stop and @cont QMP commands, is that right?
>
> Yes, that is correct.
>
>> @cont will emit a @RESUME event.
>>
>> If we could listen to QAPI events from C code, we could have the
>> mc146818rtc device automatically sync on VM resume, and no need for
>> this async command.
>
> Perhaps? I'm not sure how that would be implemented, but let's see what M=
arkus has to say.

You can't listen on an event in QEMU itself.  You can only hook into the
place that generates the event.

The RESUME event is sent from vm_prepare_start() in system/cpus.c.

>> I'll let our QAPI expert enlighten me on this :)


