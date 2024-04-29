Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450A3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NPY-00014i-4H; Mon, 29 Apr 2024 05:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NPW-00014Y-AR
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:34:58 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s1NPS-0006UU-BB
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:34:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7E6ED608F4;
 Mon, 29 Apr 2024 12:34:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b491::1:d] (unknown
 [2a02:6b8:b081:b491::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hYMjvB11OiE0-ZnQPHZzh; Mon, 29 Apr 2024 12:34:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714383284;
 bh=wO7nwVxaKAO467tpwejPH1Tf+DK7fTXWdxP1CDckjWo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LuI7/ehJmlHDZ4cQLGghU9AiwAQwjqKSrwU5sjl9HS5aqI9C3vo0gLfPBKXC4odXM
 O6cKtgwSLDOiASgvIO8ADmvISxw2zBPA7REvPLgwQrKhHES00xpLjqDyWBdFx9YDIk
 t9W4LpwXCoVLzc6fbLKe1JBsHrtBhK1JNtfSjGDY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4353bf37-af68-4e80-a8ff-1737603682de@yandex-team.ru>
Date: Mon, 29 Apr 2024 12:34:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240427075801.491673-1-d-tatianin@yandex-team.ru>
 <87v840mtzv.fsf@pond.sub.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <87v840mtzv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/29/24 11:51 AM, Markus Armbruster wrote:

> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>
>> This can be used to force-synchronize the time in guest after a long
>> stop-cont pause, which can be useful for serverless-type workload.
>>
>> Also add a comment to highlight the fact that this (and one other QMP
>> command) only works for the MC146818 RTC controller.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>
>> Changes since v0:
>> - Rename to rtc-inject-irq to match other similar API
>> - Add a comment to highlight that this only works for the I386 RTC
>>
>> ---
>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>   include/hw/rtc/mc146818rtc.h |  1 +
>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index f4c1869232..8501b55cbd 100644
>> --- a/hw/rtc/mc146818rtc.c
>> +++ b/hw/rtc/mc146818rtc.c
>> @@ -107,6 +107,11 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
>>   static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>       QLIST_HEAD_INITIALIZER(rtc_devices);
>>   
>> +/*
>> + * NOTE:
>> + * The two QMP functions below are _only_ implemented for the MC146818.
>> + * All other RTC devices ignore this.
>> + */
>>   void qmp_rtc_reset_reinjection(Error **errp)
>>   {
>>       MC146818RtcState *s;
>> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>       }
>>   }
>>   
>> +void qmp_rtc_inject_irq(Error **errp)
>> +{
>> +    MC146818RtcState *s;
>> +
>> +    /*
>> +     * See:
>> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>> +     */
>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>> +        qemu_irq_raise(s->irq);
>> +    }
>> +}
>> +
>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>   {
>>       kvm_reset_irq_delivered();
>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
>> index 97cec0b3e8..6cd9761d80 100644
>> --- a/include/hw/rtc/mc146818rtc.h
>> +++ b/include/hw/rtc/mc146818rtc.h
>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>   void qmp_rtc_reset_reinjection(Error **errp);
>> +void qmp_rtc_inject_irq(Error **errp);
>>   
>>   #endif /* HW_RTC_MC146818RTC_H */
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 4e0a6492a9..d84a5d07a2 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -19,6 +19,22 @@
>>   { 'command': 'rtc-reset-reinjection',
>>     'if': 'TARGET_I386' }
>>   
>> +##
>> +# @rtc-inject-irq:
>> +#
>> +# Inject an RTC interrupt.
> Your cover letter explains what this could be good for.  Would it make
> sense to explain it here, too?

Sure, sounds useful. I'll add a description in the next version.

Thanks

>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     -> { "execute": "rtc-inject-irq" }
>> +#     <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'rtc-inject-irq',
>> +  'if': 'TARGET_I386' }
>> +
>>   ##
>>   # @SevState:
>>   #

