Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EABDC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdip-0006yU-Tj; Mon, 27 May 2024 13:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdim-0006xI-5B
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:01:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdih-0002KD-9M
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:01:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-354fb2d9026so4032604f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716829268; x=1717434068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TaDTkn9X7EzAM/xcmIyhmWytkn48PFBowMu7OydxW1U=;
 b=PevrROFHFRtJF3suy1HlrpYQsu9pVBTuHmDl4BbM2bs2T9SvPUWkHd3RTKy+o/JJK8
 Unc3B4qzS/FM/dgd5sNhH6tZ3cRN1NZx1xo1s2y1xaYkbnef19pWHRGO3YMUcknCI25+
 5+yEDpL5jz/P4U/qZljls83jFrXmNz+aP41eBFLe+73lFcsoVyhWCtyVCPcrZExyYmHB
 JflTVZle545wpI2mcf8uCrodMipwrNsdTPWK/FvbvNJzrPJswZhN6rSmg3BAl0ZXszYv
 5BxxzvQr+JoQ728XRTGeUMmQ4JqLew91T02POc5b6wauzCDWGsUZYZlkOPJuQCP4jFNP
 nWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829268; x=1717434068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TaDTkn9X7EzAM/xcmIyhmWytkn48PFBowMu7OydxW1U=;
 b=W11VNUXY9IvLfn6+aaQj04yB1Zaod4LOA8BYCQLI8tbpAe+bz9i7q/UKBJ9hKVvq6S
 yw4eLujqt2/De+7j6a7I9ShanzSfRgiDDcNNIbJnBb1Bgwbo0a4DXjuBVUojn5Y7jsRT
 cD3jyzkuTJyZX6YtJtNiknXwPJvo49wv4UUFmdBbsHGJA17wSqf63MYBTF7fzPR0IFRo
 SHNd4lT1K96CmCWxeU/0XMAfkybyDaxCRaXiimGpa1R87+lIKuvHp7xPQRsOGAD0L257
 dayux062ZIzlMPdjtxGSEnqyXpCMNOCLy5tosrgNpveK2nQ2sOXtn9JMvMvGVwr6bwT2
 Cu+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ME+vqhuV6EqfgZDAsfGQY1wp5aHGrD9WBE6q22+/jkCSo4Q9a8ondh4cEmyAZ3oWGiwO1kkZYPtWF8B2lQLa45vj7dI=
X-Gm-Message-State: AOJu0Yw9xZIwgaJbdtN4/fYIZTpbLkPgLiMckrubz4u6jjm3k2qW55bj
 +MQJxen6/6gOG00Rl/OiktlciTTjHyVjqXp0Qqvj6jOOEg1oo3zYRw9Ys441dkc=
X-Google-Smtp-Source: AGHT+IFfq/JwbtmR0mwtS375LzEyKAWBqNyMLN6x6zP39BcsxIMeCXG+OyCSLhWSVdBSEwl2w46y9Q==
X-Received: by 2002:adf:a183:0:b0:354:f9b5:dc6d with SMTP id
 ffacd0b85a97d-35526c2ba03mr6284384f8f.24.1716829267924; 
 Mon, 27 May 2024 10:01:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dd73sm9437481f8f.18.2024.05.27.10.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 10:01:07 -0700 (PDT)
Message-ID: <e7492475-94db-4408-8d25-175b18fefec2@linaro.org>
Date: Mon, 27 May 2024 19:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240506083420.557726-1-d-tatianin@yandex-team.ru>
 <123481715669864@mail.yandex-team.ru>
 <42ad8fe7-0de8-4284-9d37-ff6b5f66acdf@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <42ad8fe7-0de8-4284-9d37-ff6b5f66acdf@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Daniil,

On 21/5/24 10:08, Daniil Tatianin wrote:
> Could you please take a look at this revision? I think I've taken 
> everyone's feedback into account.

Sorry for the delay, I missed your patch since you didn't Cc me
(Markus asked me to look at this).

Thanks for addressing the previous requests.

> Thank you!
> 
> On 5/14/24 9:57 AM, Daniil Tatianin wrote:
>> ping :)
>> 06.05.2024, 11:34, "Daniil Tatianin" <d-tatianin@yandex-team.ru>:
>>
>>     This can be used to force-synchronize the time in guest after a long
>>     stop-cont pause, which can be useful for serverless-type workload.
>>
>>     Also add a comment to highlight the fact that this (and one other QMP
>>     command) only works for the MC146818 RTC controller.
>>
>>     Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>     ---
>>
>>     Changes since v0:
>>     - Rename to rtc-inject-irq to match other similar API
>>     - Add a comment to highlight that this only works for the I386 RTC
>>
>>     Changes since v1:
>>     - Added a description below the QMP command to explain how it can be
>>       used and what it does.
>>
>>     Changes since v2:
>>     - Add a 'broadcast' suffix.
>>     - Change the comments to explain the flags we're setting.
>>     - Change the command description to fix styling & explain that
>>     it's a broadcast command.
>>
>>     ---
>>      hw/rtc/mc146818rtc.c | 20 ++++++++++++++++++++
>>      include/hw/rtc/mc146818rtc.h | 1 +
>>      qapi/misc-target.json | 19 +++++++++++++++++++
>>      3 files changed, 40 insertions(+)
>>
>>     diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>     index 3379f92748..2b3754f5c6 100644
>>     --- a/hw/rtc/mc146818rtc.c
>>     +++ b/hw/rtc/mc146818rtc.c
>>     @@ -107,6 +107,11 @@ static void
>>     rtc_coalesced_timer_update(MC146818RtcState *s)
>>      static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>          QLIST_HEAD_INITIALIZER(rtc_devices);
>>
>>     +/*
>>     + * NOTE:
>>     + * The two QMP functions below are _only_ implemented for the
>>     MC146818.
>>     + * All other RTC devices ignore this.
>>     + */
>>      void qmp_rtc_reset_reinjection(Error **errp)
>>      {
>>          MC146818RtcState *s;
>>     @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>          }
>>      }
>>
>>     +void qmp_rtc_inject_irq_broadcast(Error **errp)
>>     +{
>>     + MC146818RtcState *s;
>>     +
>>     + QLIST_FOREACH(s, &rtc_devices, link) {
>>     + // Update-ended interrupt enable

This doesn't pass the checkpatch script because it isn't QEMU coding
style:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style

>>     + s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>     +
>>     + // Interrupt request flag | update interrupt flag
>>     + s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>     +
>>     + qemu_irq_raise(s->irq);
>>     + }
>>     +}
>>     +
>>      static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>      {
>>          kvm_reset_irq_delivered();
>>     diff --git a/include/hw/rtc/mc146818rtc.h
>>     b/include/hw/rtc/mc146818rtc.h
>>     index 97cec0b3e8..e9dd0f9c72 100644
>>     --- a/include/hw/rtc/mc146818rtc.h
>>     +++ b/include/hw/rtc/mc146818rtc.h
>>     @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus,
>>     int base_year,
>>      void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int
>>     val);
>>      int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>      void qmp_rtc_reset_reinjection(Error **errp);
>>     +void qmp_rtc_inject_irq_broadcast(Error **errp);
>>
>>      #endif /* HW_RTC_MC146818RTC_H */
>>     diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>     index 4e0a6492a9..7d388a3753 100644
>>     --- a/qapi/misc-target.json
>>     +++ b/qapi/misc-target.json
>>     @@ -19,6 +19,25 @@
>>      { 'command': 'rtc-reset-reinjection',
>>        'if': 'TARGET_I386' }
>>

Your new command doesn't make my life harder than the current
'rtc-reset-reinjection' command, so if this is useful to you,
I'm OK to:
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(assuming the comment style is fixed).

I'll see later how to deal with that with heterogeneous
emulation.

Regards,

Phil.

>>     +##
>>     +# @rtc-inject-irq-broadcast:
>>     +#
>>     +# Inject an RTC interrupt for all existing RTCs on the system.
>>     +# The interrupt forces the guest to synchronize the time with RTC.
>>     +# This is useful after a long stop-cont pause, which is common for
>>     +# serverless-type workload.
>>     +#
>>     +# Since: 9.1
>>     +#
>>     +# Example:
>>     +#
>>     +# -> { "execute": "rtc-inject-irq-broadcast" }
>>     +# <- { "return": {} }
>>     +#
>>     +##
>>     +{ 'command': 'rtc-inject-irq-broadcast',
>>     + 'if': 'TARGET_I386' }
>>     +
>>      ##
>>      # @SevState:
>>      #
>>
>>     --
>>     2.34.1
>>


