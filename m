Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5358C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HtA-00030Q-Ln; Fri, 26 Apr 2024 05:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s0Ht6-0002zw-Mu
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:29:01 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1s0Ht4-0007w6-02
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:29:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 2DAE060BDA;
 Fri, 26 Apr 2024 12:28:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b594::1:3a] (unknown
 [2a02:6b8:b081:b594::1:3a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nSJCwH0IdGk0-ymISTKGv; Fri, 26 Apr 2024 12:28:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714123730;
 bh=Gzp96FDW8zkoTvEUJ7bt9kV5blZf10zcO2+8WatJc6Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=H6t2Qp62pz4zr+rCcMXsGer/oJRsKP6RaqrmWTjP7aUqs2AG0BK10yTxyZ0OOw5xS
 /WQzjnKHMPqwpYqb+wYP0qZezo8SxJl1Ngdr+T0+r6L0L4UHjrrBzEgJ2RLbeJOEMw
 tDUU/czB4FCO2tqSLyJgpDkuyeP4mYGNYAkHnmaM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <12428416-e2d6-435e-87fd-9c278b025898@yandex-team.ru>
Date: Fri, 26 Apr 2024 12:28:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <87v844y0ul.fsf@pond.sub.org>
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

On 4/26/24 11:39 AM, Markus Armbruster wrote:

> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>
>> This can be used to force-synchronize the time in guest after a long
>> stop-cont pause, which can be useful for serverless-type workload.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>   include/hw/rtc/mc146818rtc.h |  1 +
>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index f4c1869232..6980a78d5f 100644
>> --- a/hw/rtc/mc146818rtc.c
>> +++ b/hw/rtc/mc146818rtc.c
>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>       }
>>   }
>>   
>> +void qmp_rtc_notify(Error **errp)
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
> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
> devices.  Other kinds of RTC devices are silently ignored.  Just like
> qmp_rtc_reset_reinjection().
>
>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>   {
>>       kvm_reset_irq_delivered();
>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
>> index 97cec0b3e8..5229dffbbd 100644
>> --- a/include/hw/rtc/mc146818rtc.h
>> +++ b/include/hw/rtc/mc146818rtc.h
>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>   void qmp_rtc_reset_reinjection(Error **errp);
>> +void qmp_rtc_notify(Error **errp);
>>   
>>   #endif /* HW_RTC_MC146818RTC_H */
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 4e0a6492a9..20457b0acc 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -19,6 +19,22 @@
>     ##
>     # @rtc-reset-reinjection:
>     #
>     # This command will reset the RTC interrupt reinjection backlog.  Can
>     # be used if another mechanism to synchronize guest time is in effect,
>     # for example QEMU guest agent's guest-set-time command.
>     #
>     # Since: 2.1
>     #
>     # Example:
>     #
>     #     -> { "execute": "rtc-reset-reinjection" }
>     #     <- { "return": {} }
>     ##
>>   { 'command': 'rtc-reset-reinjection',
>>     'if': 'TARGET_I386' }
>>   
>> +##
>> +# @rtc-notify:
>> +#
>> +# Generate an RTC interrupt.
> Our QMP command to generate NMIs is called inject-nmi.  Call this one
> inject-rtc-irq for consistency?  rtc-inject-irq?

This makes sense, I'll rename in the next version. Thanks.

>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     -> { "execute": "rtc-notify" }
>> +#     <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'rtc-notify',
>> +  'if': 'TARGET_I386' }
>> +
> As noted above, both commands silently ignore RTCs other than
> mc146818rtc.
>
> They're only available with TARGET_I386.
>
> As long as all machines available with TARGET_I386 can only ever contain
> mc146818rtc RTCs, ignoring other RTCs is a non-problem in practice.
>
> Feels a bit fragile to me.  Thoughts?

Feels a bit fragile indeed, but this code has been there since 2.1, and 
I guess no one really found this to be a problem.

>>   ##
>>   # @SevState:
>>   #

