Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4296C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCITE-0005X2-JJ; Wed, 29 May 2024 08:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sCIT4-0005TJ-6g
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:31:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sCISz-0004s2-JC
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:31:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B45AB60D34;
 Wed, 29 May 2024 15:31:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7214::1:2e] (unknown
 [2a02:6b8:b081:7214::1:2e])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TVQUXG0iCSw0-cqLukbxd; Wed, 29 May 2024 15:31:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716985891;
 bh=idTG4nXLoq1ecpE2FByiKf7lSYTMSavvRJSma+N5zIA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EqiNJ5/cjyJEc4X6i+3wFekRiwwH142KYkIgMqqzkNgWGNGzFAX9UXSw0IkrSuU0t
 qLnkNm5x3P49kPO4gHMfNxK5OlzKHb8lTLS0yrIe4qTYWhcMUb0GslJzeE9U+z1Ab/
 4XR/TUTH17ZRJMovMh/nna/eHCCPEhyF4927CvjU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <adf92e81-623d-41a7-9f17-13596077e873@yandex-team.ru>
Date: Wed, 29 May 2024 15:31:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, philmd@linaro.org
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <87mso8n7tw.fsf@pond.sub.org>
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

Thanks for the review Markus!

I will fix the wording and add a "Bug:" clause for the next revision.

On 5/29/24 3:03 PM, Markus Armbruster wrote:
> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>
>> This can be used to force-synchronize the time in guest after a long
>> stop-cont pause, which can be useful for serverless-type workload.
>>
>> Also add a comment to highlight the fact that this (and one other QMP
>> command) only works for the MC146818 RTC controller.
>>
>> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>
>> Changes since v0:
>> - Rename to rtc-inject-irq to match other similar API
>> - Add a comment to highlight that this only works for the I386 RTC
>>
>> Changes since v1:
>> - Added a description below the QMP command to explain how it can be
>>    used and what it does.
>>
>> Changes since v2:
>> - Add a 'broadcast' suffix.
>> - Change the comments to explain the flags we're setting.
>> - Change the command description to fix styling & explain that it's a broadcast command.
>>
>> Changes since v3:
>> - Fix checkpatch complaints about usage of C99 comments
>>
>> ---
>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>   include/hw/rtc/mc146818rtc.h |  1 +
>>   qapi/misc-target.json        | 19 +++++++++++++++++++
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index 3379f92748..96ecd43036 100644
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
>> +void qmp_rtc_inject_irq_broadcast(Error **errp)
>> +{
>> +    MC146818RtcState *s;
>> +
>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>> +        /* Update-ended interrupt enable */
>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>> +
>> +        /* Interrupt request flag | update interrupt flag */
>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>> +
>> +        qemu_irq_raise(s->irq);
>> +    }
>> +}
>> +
>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>   {
>>       kvm_reset_irq_delivered();
>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
>> index 97cec0b3e8..e9dd0f9c72 100644
>> --- a/include/hw/rtc/mc146818rtc.h
>> +++ b/include/hw/rtc/mc146818rtc.h
>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>   void qmp_rtc_reset_reinjection(Error **errp);
>> +void qmp_rtc_inject_irq_broadcast(Error **errp);
>>   
>>   #endif /* HW_RTC_MC146818RTC_H */
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index 4e0a6492a9..7d388a3753 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -19,6 +19,25 @@
>>   { 'command': 'rtc-reset-reinjection',
>>     'if': 'TARGET_I386' }
>>   
>> +##
>> +# @rtc-inject-irq-broadcast:
>> +#
>> +# Inject an RTC interrupt for all existing RTCs on the system.
>> +# The interrupt forces the guest to synchronize the time with RTC.
>> +# This is useful after a long stop-cont pause, which is common for
>> +# serverless-type workload.
> Make that "workloads".
>
> "For all existing RTCs" is a lie.  It's really just all mc146818s.  The
> command works as documented only as long as the VM has no other RTCs.
>
>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     -> { "execute": "rtc-inject-irq-broadcast" }
>> +#     <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'rtc-inject-irq-broadcast',
>> +  'if': 'TARGET_I386' }
> The conditional kind-of-sort-of ensures "VM has no other RTCs":
> TARGET_I386 compiles only this file in hw/rtc/, and therefore can't have
> other RTCs (unless they're hiding in some other directory).  Brittle.
>
> When we move to single binary, we will compile in other RTCs.  How can
> we ensure "VM has no nother RTCs" then?  What if one of these other RTCs
> can be added with -device or device_add?
>
> When this falls apart because the VM does have other RTCs, it can only
> do so silently: the command can't tell us for which RTCs it actually
> injected an interrupt.
>
> Documentation making promises the implementation doesn't actually
> deliver can only end in tears.  The only reason I'm not rejecting this
> patch out of hand is the existing and similarly broken
> rtc-reset-reinjection.
>
> I'm willing to reluctantly accept it with honest documentation.
> Perhaps: "Bug: RTCs other than mc146818rtc are silently ignored."
>
> Much, much better would be an interface that's actually usable with
> multiple RTCs.  We'd have to talk how interrupt injection could be used
> with such a machine.
>
> Anything less will likely need to be replaced later on.
>
>> +
>>   ##
>>   # @SevState:
>>   #

