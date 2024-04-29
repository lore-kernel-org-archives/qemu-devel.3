Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD0C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NYO-0005xv-9r; Mon, 29 Apr 2024 05:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NYI-0005xA-Ey
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:44:06 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NYG-0008BY-FJ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:44:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 04BE160C3F;
 Mon, 29 Apr 2024 12:43:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b491::1:d] (unknown
 [2a02:6b8:b081:b491::1:d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uhMLib1Rq4Y0-CwVppMUZ; Mon, 29 Apr 2024 12:43:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714383837;
 bh=KsuBiryYCPjWHinWqTOLi0dU2Zq6bBm9u1Nqwko0M3Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g7/ofFjU6AhbLCqcTTpahfJPab0p8tHY5dgYpJrRP6o0FCbRF317IBTsreTZrfLcG
 WQGG7H4O1h6sbbRbwINfXgaor671IlflRjyqevaTjAOXB7KUEk1/84pBiuSjvrMYZv
 u/hosQAS/7ZAeiRD37cXOpaAutyM8jyumce9U5IE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d1568767-ee03-4fc4-a498-2143dd7b4fbe@yandex-team.ru>
Date: Mon, 29 Apr 2024 12:43:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240427075801.491673-1-d-tatianin@yandex-team.ru>
 <87v840mtzv.fsf@pond.sub.org>
 <4353bf37-af68-4e80-a8ff-1737603682de@yandex-team.ru>
 <b8429aa8-f5d5-4f6e-a817-e41cf090adc9@linaro.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <b8429aa8-f5d5-4f6e-a817-e41cf090adc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/29/24 12:40 PM, Philippe Mathieu-Daudé wrote:

> On 29/4/24 11:34, Daniil Tatianin wrote:
>> On 4/29/24 11:51 AM, Markus Armbruster wrote:
>>
>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>
>>>> This can be used to force-synchronize the time in guest after a long
>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>
>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>> command) only works for the MC146818 RTC controller.
>>>>
>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>> ---
>>>>
>>>> Changes since v0:
>>>> - Rename to rtc-inject-irq to match other similar API
>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>
>>>> ---
>>>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>>>   3 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>>> index f4c1869232..8501b55cbd 100644
>>>> --- a/hw/rtc/mc146818rtc.c
>>>> +++ b/hw/rtc/mc146818rtc.c
>>>> @@ -107,6 +107,11 @@ static void 
>>>> rtc_coalesced_timer_update(MC146818RtcState *s)
>>>>   static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>>>       QLIST_HEAD_INITIALIZER(rtc_devices);
>>>> +/*
>>>> + * NOTE:
>>>> + * The two QMP functions below are _only_ implemented for the 
>>>> MC146818.
>>>> + * All other RTC devices ignore this.
>>>> + */
>>>>   void qmp_rtc_reset_reinjection(Error **errp)
>>>>   {
>>>>       MC146818RtcState *s;
>>>> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>>       }
>>>>   }
>>>> +void qmp_rtc_inject_irq(Error **errp)
>>>> +{
>>>> +    MC146818RtcState *s;
>>>> +
>>>> +    /*
>>>> +     * See:
>>>> +     * 
>>>> https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>>>> +     */
>>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>>> +        qemu_irq_raise(s->irq);
>>>> +    }
>>>> +}
>>>> +
>>>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>>>   {
>>>>       kvm_reset_irq_delivered();
>>>> diff --git a/include/hw/rtc/mc146818rtc.h 
>>>> b/include/hw/rtc/mc146818rtc.h
>>>> index 97cec0b3e8..6cd9761d80 100644
>>>> --- a/include/hw/rtc/mc146818rtc.h
>>>> +++ b/include/hw/rtc/mc146818rtc.h
>>>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, 
>>>> int base_year,
>>>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int 
>>>> val);
>>>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>>>   void qmp_rtc_reset_reinjection(Error **errp);
>>>> +void qmp_rtc_inject_irq(Error **errp);
>>>>   #endif /* HW_RTC_MC146818RTC_H */
>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>> index 4e0a6492a9..d84a5d07a2 100644
>>>> --- a/qapi/misc-target.json
>>>> +++ b/qapi/misc-target.json
>>>> @@ -19,6 +19,22 @@
>>>>   { 'command': 'rtc-reset-reinjection',
>>>>     'if': 'TARGET_I386' }
>>>> +##
>>>> +# @rtc-inject-irq:
>>>> +#
>>>> +# Inject an RTC interrupt.
>>> Your cover letter explains what this could be good for.  Would it make
>>> sense to explain it here, too?
>>
>> Sure, sounds useful. I'll add a description in the next version.
>
> Please also see my comments on the previous patch:
> https://lore.kernel.org/qemu-devel/11c78645-e87b-4a43-8191-a73540c364a9@linaro.org/ 
>
>
I think this makes sense, but there's already a similar command, which 
doesn't do it. Should that one be changed as well then? Or do we only 
change the interface for this one?

