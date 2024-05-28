Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD087C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBr73-0004s9-7L; Tue, 28 May 2024 03:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sBr71-0004rw-N5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:19:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sBr6y-0007b7-AU
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:19:10 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C9B9460D74;
 Tue, 28 May 2024 10:18:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b72a::1:2c] (unknown
 [2a02:6b8:b081:b72a::1:2c])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uIKdVS2IfKo0-grveF4dl; Tue, 28 May 2024 10:18:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716880737;
 bh=1lLVjRpHHSDSwUmkDYdLInTkL8Bc85PGNkkClmw9TCk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HSNb6kyYqN4sCkqjKosTpodyhcNT/XYpZl5NK2/Gm2NlRe0gpUqBsLNE+jqztarcs
 qV52G8oPJKy+KzRhxwUysusSK3tbJ8HoiC+1oSOtPRdsr6rph2j30H1GSjEs+S8g7H
 8LnaYgCJa+bpwkg8El3WDpuQKTIALCKHlq9uiaDU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2b37aa67-5636-43f1-a991-559fd7ebe2b0@yandex-team.ru>
Date: Tue, 28 May 2024 10:18:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240506083420.557726-1-d-tatianin@yandex-team.ru>
 <123481715669864@mail.yandex-team.ru>
 <42ad8fe7-0de8-4284-9d37-ff6b5f66acdf@yandex-team.ru>
 <e7492475-94db-4408-8d25-175b18fefec2@linaro.org>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <e7492475-94db-4408-8d25-175b18fefec2@linaro.org>
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

On 5/27/24 8:01 PM, Philippe Mathieu-Daudé wrote:

> Hi Daniil,
>
> On 21/5/24 10:08, Daniil Tatianin wrote:
>> Could you please take a look at this revision? I think I've taken 
>> everyone's feedback into account.
>
> Sorry for the delay, I missed your patch since you didn't Cc me
> (Markus asked me to look at this).

Oops, my bad for forgetting to Cc you!

>
> Thanks for addressing the previous requests.
>
>> Thank you!
>>
>> On 5/14/24 9:57 AM, Daniil Tatianin wrote:
>>> ping :)
>>> 06.05.2024, 11:34, "Daniil Tatianin" <d-tatianin@yandex-team.ru>:
>>>
>>>     This can be used to force-synchronize the time in guest after a 
>>> long
>>>     stop-cont pause, which can be useful for serverless-type workload.
>>>
>>>     Also add a comment to highlight the fact that this (and one 
>>> other QMP
>>>     command) only works for the MC146818 RTC controller.
>>>
>>>     Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>     ---
>>>
>>>     Changes since v0:
>>>     - Rename to rtc-inject-irq to match other similar API
>>>     - Add a comment to highlight that this only works for the I386 RTC
>>>
>>>     Changes since v1:
>>>     - Added a description below the QMP command to explain how it 
>>> can be
>>>       used and what it does.
>>>
>>>     Changes since v2:
>>>     - Add a 'broadcast' suffix.
>>>     - Change the comments to explain the flags we're setting.
>>>     - Change the command description to fix styling & explain that
>>>     it's a broadcast command.
>>>
>>>     ---
>>>      hw/rtc/mc146818rtc.c | 20 ++++++++++++++++++++
>>>      include/hw/rtc/mc146818rtc.h | 1 +
>>>      qapi/misc-target.json | 19 +++++++++++++++++++
>>>      3 files changed, 40 insertions(+)
>>>
>>>     diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>>     index 3379f92748..2b3754f5c6 100644
>>>     --- a/hw/rtc/mc146818rtc.c
>>>     +++ b/hw/rtc/mc146818rtc.c
>>>     @@ -107,6 +107,11 @@ static void
>>>     rtc_coalesced_timer_update(MC146818RtcState *s)
>>>      static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>>          QLIST_HEAD_INITIALIZER(rtc_devices);
>>>
>>>     +/*
>>>     + * NOTE:
>>>     + * The two QMP functions below are _only_ implemented for the
>>>     MC146818.
>>>     + * All other RTC devices ignore this.
>>>     + */
>>>      void qmp_rtc_reset_reinjection(Error **errp)
>>>      {
>>>          MC146818RtcState *s;
>>>     @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>          }
>>>      }
>>>
>>>     +void qmp_rtc_inject_irq_broadcast(Error **errp)
>>>     +{
>>>     + MC146818RtcState *s;
>>>     +
>>>     + QLIST_FOREACH(s, &rtc_devices, link) {
>>>     + // Update-ended interrupt enable
>
> This doesn't pass the checkpatch script because it isn't QEMU coding
> style:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style 
>
>
Looks like // comments are not allowed, will fix.

>>>     + s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>>     +
>>>     + // Interrupt request flag | update interrupt flag
>>>     + s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>>     +
>>>     + qemu_irq_raise(s->irq);
>>>     + }
>>>     +}
>>>     +
>>>      static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>>      {
>>>          kvm_reset_irq_delivered();
>>>     diff --git a/include/hw/rtc/mc146818rtc.h
>>>     b/include/hw/rtc/mc146818rtc.h
>>>     index 97cec0b3e8..e9dd0f9c72 100644
>>>     --- a/include/hw/rtc/mc146818rtc.h
>>>     +++ b/include/hw/rtc/mc146818rtc.h
>>>     @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus,
>>>     int base_year,
>>>      void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int
>>>     val);
>>>      int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>>      void qmp_rtc_reset_reinjection(Error **errp);
>>>     +void qmp_rtc_inject_irq_broadcast(Error **errp);
>>>
>>>      #endif /* HW_RTC_MC146818RTC_H */
>>>     diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>     index 4e0a6492a9..7d388a3753 100644
>>>     --- a/qapi/misc-target.json
>>>     +++ b/qapi/misc-target.json
>>>     @@ -19,6 +19,25 @@
>>>      { 'command': 'rtc-reset-reinjection',
>>>        'if': 'TARGET_I386' }
>>>
>
> Your new command doesn't make my life harder than the current
> 'rtc-reset-reinjection' command, so if this is useful to you,
> I'm OK to:
> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> (assuming the comment style is fixed).
>
> I'll see later how to deal with that with heterogeneous
> emulation.
>
> Regards,
>
> Phil.

Thank you!

>>>     +##
>>>     +# @rtc-inject-irq-broadcast:
>>>     +#
>>>     +# Inject an RTC interrupt for all existing RTCs on the system.
>>>     +# The interrupt forces the guest to synchronize the time with RTC.
>>>     +# This is useful after a long stop-cont pause, which is common for
>>>     +# serverless-type workload.
>>>     +#
>>>     +# Since: 9.1
>>>     +#
>>>     +# Example:
>>>     +#
>>>     +# -> { "execute": "rtc-inject-irq-broadcast" }
>>>     +# <- { "return": {} }
>>>     +#
>>>     +##
>>>     +{ 'command': 'rtc-inject-irq-broadcast',
>>>     + 'if': 'TARGET_I386' }
>>>     +
>>>      ##
>>>      # @SevState:
>>>      #
>>>
>>>     --
>>>     2.34.1
>>>
>

