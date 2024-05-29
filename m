Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B56C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIXy-0007CR-8i; Wed, 29 May 2024 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCIXw-0007Bq-1x
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:36:48 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCIXu-00067b-2U
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:36:47 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52961b77655so2338018e87.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716986204; x=1717591004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqg2JzGUhgWUhAFaiputSjjSKAZ0odJavNOfbsJvLxk=;
 b=jxHyc1p5KCiBjUuGyhrP5XXHG/7+tsvX0+NY23le9wXFEwVVUzgMkt/nJOq4fuWDIc
 3QhyU/qq6KHqFGApWzwaSvV5/p6gFSToyCqoClZC+Z0bg16eqtAaQJ/8SZzZr8XlljbE
 vjKXiiBLC1rh24PLphf4cOanaude8N+4Nkp6zKn0phite9LBRqh+d4ieEF6tPY2etWG0
 fLOwZi/D5Hd/6cGs9iCUSExIlmAH4wakewr22ziYEFjalcu+BumKn+GlNvDqspIz/gzA
 Sge0u+p2CwF9PYovbRK9CgG4waGhtEVOPhQ6QC/Of4xxNE1fG8jfKhozS71tBtpsR5bb
 6DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716986204; x=1717591004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqg2JzGUhgWUhAFaiputSjjSKAZ0odJavNOfbsJvLxk=;
 b=XMc2Rp/Xn7y/3zcbcZI0KudhXaLLjFbc5pK3P7X/uto3R0PbXbv8E6OoIFQLKJDAAf
 D2w43yD3WYtqGCIw9EpSbknQMRrr+1KVH3S2kOxwuTLWUst3WHgIRNhGCwJ8LdRKBsD6
 ah5DjAV8/Xle4EyTP5HgbQGsWxNGoLGha7otbkTG7idb1SWmMCyfffgE/VTrvl6zEHqY
 y1qOwBc20VnoFt+Cw6rwyvzfGZSNzmDcfRmJmZ78t0gmP0qpMB8aW3AC56S6Bu69Tm8p
 YNYU+qD8DwnaVxko0k5PbsZytgdRNA5OiUGTz4swMGw3owEpoyRMlyHeusAcmMnciZXh
 5Q/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQdGWPj8TsJ9K1b9DjOd1y1sU8fCb60TYD0WtZoWJBnqB1IZMceogUDPW9L2BjPDY6DY9Hu+GIrzrVb9m5S3ydwZ1XW2s=
X-Gm-Message-State: AOJu0YxWye+/raL2xtxqRQvOhRB1/GKGYMRzlsXCLhPV4wiVUERrEbef
 QRNIwMwv1eHOOiIDBVknouKlPsTJuNFqgtKCo8T97v7qxSWnTAmSkOk5kt5Rayc=
X-Google-Smtp-Source: AGHT+IFhanoyYHYYuUiIJju8RVNxlqdHa8oCt+n/3gvlhjMtZzmSxkKbUcsM/iecAWMOK76rAgrBpw==
X-Received: by 2002:a19:6448:0:b0:52a:fbcc:b358 with SMTP id
 2adb3069b0e04-52afbccb3ebmr957488e87.13.1716986203808; 
 Wed, 29 May 2024 05:36:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f55264sm205840505e9.21.2024.05.29.05.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 05:36:43 -0700 (PDT)
Message-ID: <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
Date: Wed, 29 May 2024 14:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Markus Armbruster <armbru@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mso8n7tw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 29/5/24 14:03, Markus Armbruster wrote:
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

In previous version you said:

   > This isn't really related to migration though. Serverless is based
   > on constantly stopping and resuming the VM on e.g. every HTTP
   > request to an endpoint.

Which made some sense. Maybe mention HTTP? And point to that use case
(possibly with QMP commands) in the commit description?

> Make that "workloads".
> 
> "For all existing RTCs" is a lie.  It's really just all mc146818s.  The
> command works as documented only as long as the VM has no other RTCs.

@rtc-mc146818-force-sync-broadcast sounds clearer & safer;
IIUC the command goal, mentioning IRQ injection is irrelevant
(implementation detail).

(I'm trying to not spread the problems we already have with
@rtc-reset-reinjection).

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
> 
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
> 


