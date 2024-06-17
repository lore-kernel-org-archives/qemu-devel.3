Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DF9C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ7iH-00034G-TI; Mon, 17 Jun 2024 04:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sJ7iF-00032S-UP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:27:40 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sJ7iC-0006LG-Ps
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:27:39 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 73DEA60B3B;
 Mon, 17 Jun 2024 11:27:28 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5239:4476:3612:5752] (unknown
 [2a02:6b8:0:419:5239:4476:3612:5752])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RRCbDS1RrSw0-XxtxMn5O; Mon, 17 Jun 2024 11:27:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1718612847;
 bh=yU+7XVx1G5+P55A0lxd5C21zkOVKlRPtPwaKy+ez7aI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PnLtPzG0fyaaMcQqy/dlfwRSQBTovpLp60hZs5Rc0pMGnmFfLzBokP3wY22k7LhBH
 XKqifc62RYXNDV4PCVS/jIX8NMO+TekxCLOuuSz4kzfOvMcDVjqViWEPHBVB1VuXZe
 I6SG4x7IeifLGw9KA6bmPgg6osMEmWMSg8N3ORLY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7d9da58f-71cc-4693-89b2-9ea30d490a00@yandex-team.ru>
Date: Mon, 17 Jun 2024 11:27:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
 <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
 <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
 <079a43b9-52db-4428-9ae4-52a31fbf5e74@linaro.org>
 <bbe49906-26b5-4443-9be1-c621a76c53d8@yandex-team.ru>
 <874jaglm9x.fsf@pond.sub.org>
 <a585832f-87ff-4416-be3c-9f5513e99876@linaro.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <a585832f-87ff-4416-be3c-9f5513e99876@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/29/24 6:27 PM, Philippe Mathieu-Daudé wrote:

> On 29/5/24 16:34, Markus Armbruster wrote:
>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>
>>> On 5/29/24 4:39 PM, Philippe Mathieu-Daudé wrote:
>>>
>>>> On 29/5/24 14:43, Daniil Tatianin wrote:
>>>>> On 5/29/24 3:36 PM, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>>> On 29/5/24 14:03, Markus Armbruster wrote:
>>>>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>>>>
>>>>>>>> This can be used to force-synchronize the time in guest after a 
>>>>>>>> long
>>>>>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>>>>>
>>>>>>>> Also add a comment to highlight the fact that this (and one 
>>>>>>>> other QMP
>>>>>>>> command) only works for the MC146818 RTC controller.
>>>>>>>>
>>>>>>>> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Changes since v0:
>>>>>>>> - Rename to rtc-inject-irq to match other similar API
>>>>>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>>>>>
>>>>>>>> Changes since v1:
>>>>>>>> - Added a description below the QMP command to explain how it 
>>>>>>>> can be
>>>>>>>>     used and what it does.
>>>>>>>>
>>>>>>>> Changes since v2:
>>>>>>>> - Add a 'broadcast' suffix.
>>>>>>>> - Change the comments to explain the flags we're setting.
>>>>>>>> - Change the command description to fix styling & explain that 
>>>>>>>> it's a broadcast command.
>>>>>>>>
>>>>>>>> Changes since v3:
>>>>>>>> - Fix checkpatch complaints about usage of C99 comments
>>>>>>>>
>>>>>>>> ---
>>>>>>>>    hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>>>>>    include/hw/rtc/mc146818rtc.h |  1 +
>>>>>>>>    qapi/misc-target.json        | 19 +++++++++++++++++++
>>>>>>>>    3 files changed, 40 insertions(+)
>>>>
>>>>
>>>>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>>>>> index 4e0a6492a9..7d388a3753 100644
>>>>>>>> --- a/qapi/misc-target.json
>>>>>>>> +++ b/qapi/misc-target.json
>>>>>>>> @@ -19,6 +19,25 @@
>>>>>>>>    { 'command': 'rtc-reset-reinjection',
>>>>>>>>      'if': 'TARGET_I386' }
>>>>>>>>    +##
>>>>>>>> +# @rtc-inject-irq-broadcast:
>>>>>>>> +#
>>>>>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>>>>>> +# The interrupt forces the guest to synchronize the time with 
>>>>>>>> RTC.
>>>>>>>> +# This is useful after a long stop-cont pause, which is common 
>>>>>>>> for
>>>>>>>> +# serverless-type workload.
>>>>>>
>>>>>> In previous version you said:
>>>>>>
>>>>>>    > This isn't really related to migration though. Serverless is 
>>>>>> based
>>>>>>    > on constantly stopping and resuming the VM on e.g. every HTTP
>>>>>>    > request to an endpoint.
>>>>>>
>>>>>> Which made some sense. Maybe mention HTTP? And point to that use 
>>>>>> case
>>>>>> (possibly with QMP commands) in the commit description?
>>>>>
>>>>> Hmm, maybe it would be helpful for people who don't know what 
>>>>> serverless means.
>>>>>
>>>>> How about:
>>>>>       This is useful after a long stop-const pause, which is 
>>>>> common for serverless-type workloads,
>>>>>       e.g. stopping/resuming the VM on every HTTP request to an 
>>>>> endpoint, which might involve
>>>>>       a long pause in between the requests, causing time drift in 
>>>>> the guest.
>>>>
>>>> Please help me understand your workflow. Your management layer call
>>>> @stop and @cont QMP commands, is that right?
>>>
>>> Yes, that is correct.
>>>
>>>> @cont will emit a @RESUME event.
>>>>
>>>> If we could listen to QAPI events from C code, we could have the
>>>> mc146818rtc device automatically sync on VM resume, and no need for
>>>> this async command.
>>>
>>> Perhaps? I'm not sure how that would be implemented, but let's see 
>>> what Markus has to say.
>>
>> You can't listen on an event in QEMU itself.  You can only hook into the
>> place that generates the event.
>
> Apparently "qemu/notify.h" could be use for QAPI events (currently
> only used by migration). Big change, to be discussed later.
>
>> The RESUME event is sent from vm_prepare_start() in system/cpus.c.
>
> Good spot, it is where we call synchronize_pre_resume() for vCPUs,
> which is exactly what Daniil wants for RTC devices.
>
> I'd rather we call here rtc_synchronize_pre_resume(), which would
> mostly be qmp_rtc_inject_irq_broadcast() content, without using QMP
> at all.
>
> But for back-compat we need some CLI option "sync-rtc-on-resume"
> default to false. Preferably a mc146818rtc property to KISS.
>
> That would solve Daniil problem and make Markus/myself happier.
>
> Paolo, any objection?
>
Hey there!

Since Paolo never replied I'm going to take that as a no then. Is 
everyone else okay with this idea?

If there are no objections I'm going to try and implement this.

Thanks!

> Regards,
>
> Phil.

