Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52366C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJie-0006SD-RU; Wed, 29 May 2024 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sCJic-0006Ri-6M
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:51:54 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sCJiX-00037A-JD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:51:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4495:0:640:1311:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E220B60CDE;
 Wed, 29 May 2024 16:51:42 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b733::1:10] (unknown
 [2a02:6b8:b081:b733::1:10])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fpR6WH0Ib0U0-lfvzYYfQ; Wed, 29 May 2024 16:51:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716990702;
 bh=fFGH9OzDe10QkAY9LLFssfuNyIAg3RuHWHlOQ9k7/8c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vMUT37k6vewzhwBrm4jkb3ElfD2MrNWNNcbpeOCOZyPrOyIVfGCsnQ6o8Z3FWb1LB
 PVQLp/TjnIu4Wi33oMeYfNKP5vqtbEp8iuAgJsPRtkwMowIcNaqqyEid5z7ziCLUG1
 wujW9tQ98A2/O9BAkUxymMsGNyh9pGAHCbzZUi/A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bbe49906-26b5-4443-9be1-c621a76c53d8@yandex-team.ru>
Date: Wed, 29 May 2024 16:51:42 +0300
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
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <079a43b9-52db-4428-9ae4-52a31fbf5e74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/24 4:39 PM, Philippe Mathieu-Daudé wrote:

> On 29/5/24 14:43, Daniil Tatianin wrote:
>> On 5/29/24 3:36 PM, Philippe Mathieu-Daudé wrote:
>>
>>> On 29/5/24 14:03, Markus Armbruster wrote:
>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>
>>>>> This can be used to force-synchronize the time in guest after a long
>>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>>
>>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>>> command) only works for the MC146818 RTC controller.
>>>>>
>>>>> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>> ---
>>>>>
>>>>> Changes since v0:
>>>>> - Rename to rtc-inject-irq to match other similar API
>>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>>
>>>>> Changes since v1:
>>>>> - Added a description below the QMP command to explain how it can be
>>>>>    used and what it does.
>>>>>
>>>>> Changes since v2:
>>>>> - Add a 'broadcast' suffix.
>>>>> - Change the comments to explain the flags we're setting.
>>>>> - Change the command description to fix styling & explain that 
>>>>> it's a broadcast command.
>>>>>
>>>>> Changes since v3:
>>>>> - Fix checkpatch complaints about usage of C99 comments
>>>>>
>>>>> ---
>>>>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>>>   qapi/misc-target.json        | 19 +++++++++++++++++++
>>>>>   3 files changed, 40 insertions(+)
>
>
>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>> index 4e0a6492a9..7d388a3753 100644
>>>>> --- a/qapi/misc-target.json
>>>>> +++ b/qapi/misc-target.json
>>>>> @@ -19,6 +19,25 @@
>>>>>   { 'command': 'rtc-reset-reinjection',
>>>>>     'if': 'TARGET_I386' }
>>>>>   +##
>>>>> +# @rtc-inject-irq-broadcast:
>>>>> +#
>>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>>> +# The interrupt forces the guest to synchronize the time with RTC.
>>>>> +# This is useful after a long stop-cont pause, which is common for
>>>>> +# serverless-type workload.
>>>
>>> In previous version you said:
>>>
>>>   > This isn't really related to migration though. Serverless is based
>>>   > on constantly stopping and resuming the VM on e.g. every HTTP
>>>   > request to an endpoint.
>>>
>>> Which made some sense. Maybe mention HTTP? And point to that use case
>>> (possibly with QMP commands) in the commit description?
>>
>> Hmm, maybe it would be helpful for people who don't know what 
>> serverless means.
>>
>> How about:
>>      This is useful after a long stop-const pause, which is common 
>> for serverless-type workloads,
>>      e.g. stopping/resuming the VM on every HTTP request to an 
>> endpoint, which might involve
>>      a long pause in between the requests, causing time drift in the 
>> guest.
>
> Please help me understand your workflow. Your management layer call
> @stop and @cont QMP commands, is that right?

Yes, that is correct.

> @cont will emit a @RESUME event.
>
> If we could listen to QAPI events from C code, we could have the
> mc146818rtc device automatically sync on VM resume, and no need for
> this async command.

Perhaps? I'm not sure how that would be implemented, but let's see what 
Markus has to say.

>
> I'll let our QAPI expert enlighten me on this :)

