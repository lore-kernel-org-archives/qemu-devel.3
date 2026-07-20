Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C6C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnLL-0005ZG-M4; Mon, 20 Jul 2026 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlnLJ-0005Yf-Id
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlnLG-0004BS-Ur
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784551409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KJ9NSPrkxe0KAdp3IHHX9DTL99yOGdvOCcxyTgnQMwo=;
 b=QgyTP3AViL/8GhNRT4Vemqjf34zaAXdemopQWt0BVAR7lLPkFLsaHUt6NICAMQUgk3xzmZ
 VqasL5ffeFbC5yGtdOa0ZIqIiIeo8F0jauuNGBpiJExe01SyblFD7saxH6yD3cplOenNM7
 PEqHOP8QvVHQ50hb80acAhSTmytfO0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-CibIR-dlN5eZ-LCRSl6FEg-1; Mon, 20 Jul 2026 08:43:28 -0400
X-MC-Unique: CibIR-dlN5eZ-LCRSl6FEg-1
X-Mimecast-MFC-AGG-ID: CibIR-dlN5eZ-LCRSl6FEg_1784551406
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f24a50f0cso9007236f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784551406; x=1785156206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KJ9NSPrkxe0KAdp3IHHX9DTL99yOGdvOCcxyTgnQMwo=;
 b=tYviWHXQNMAkeHGamaMedV2uQDT4bqPo30JFvm+iinXxszZk0s8YW5WQxv62PaBXPz
 ZQsD9r90nLihRcq8BCCsEeEb/0UUxOjxN2DDjQ/nEAJ/EXjQKZwrRXFtkWOcoxyoALsN
 2XepYenyYr+b2MW95HPY/ghJeeopfBVcaK3SvBOTcYG+miML4VrC3Pg2TE+p012VPaBG
 AIym/hB3A6gH7uU1NJrgk3VnUKUEufK3ETqh5DYDyhO7a3hpsDa4eUFyfka7xpHZlMcD
 dS2q8bIXwHKfPPGG79iHaRf2nFcwQqnH+VmsRSUJzwY3GyP0pEw2Ag0lzWzHQnWPK223
 B/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551406; x=1785156206;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KJ9NSPrkxe0KAdp3IHHX9DTL99yOGdvOCcxyTgnQMwo=;
 b=KBKbd+yzflzINCg5KO6wQMFHlHm+GGAbSkPYeZMi+GNOojm1D7qpui5Nps1RszjdDJ
 qpDDqaR9f1d3HgrUkiJQ4smWSJ/AX8OkYyHlpRHTSSWjjUEFu8lILgLPoTte4LqZTyWT
 S6LbLnqbz8ZmhTx4WQ897uWiicqIR8hfr8KU4Umr3FVRk9lG38F5/wya53anNhnOANET
 RLKKNCqQDHVjUjzn2PwdMicybJztvMyD1TStGOrNr0oWooowzZ/+aBvdEjnzcPRzoGpP
 j7Mf7ZCa+oeyYAynuOaa/y0xACTCKJ88XLlInpH9CkzsFVyiN/r9BmAg6OVARgF3Vbnz
 3VNw==
X-Gm-Message-State: AOJu0YyazR8G2+BO6qzt0XbCeXGCbTVHGRJ6dUpceluudYmN8SBPovnW
 PEMh5YOR7d3SQP3ZZa9FXBzzUd1hR2Y2vroShw4ONs5C/VelThODyA9b04STNFs66NlavgKieKA
 N3LIN/My6HD83EC9qzNJGI/lJRifpulREnmPNItp+4JGd/5MJiCYAMHTH
X-Gm-Gg: AR+sD10Ycke8+zZf1myjRXtmpasUyqxLxqO7kXa+D4xr9bnram1rNA9iQuSjwbO/M1/
 dq2D9+oQD3bKTv+PZ/UzvhcJTjIdUwTxGToxpRH1IPZLsd5zDts+51y2vS4nsInm1DsqO28ICcL
 i11J5I0lAVEsXj5Alyka12ZND3oLqXuJNixuTjHC6T1WUWW1omkem1NhF3bPCRo+T67b4SAmIIK
 yvUHRzDusEcxjUjehQPwaFYXPH7B0bvuepuyXreKzElM/8I+ObL5WoWxyHB62BnW3gOdKyzHAcw
 Yb89ejQGUKn6IHLXVsVeZZ+5mPtP4aJd5XwcvhTs8741pFTeIsUyCtmtWl1R4BRx23MNLXFr+g=
 =
X-Received: by 2002:a05:6000:25f7:b0:47f:4fbf:7b21 with SMTP id
 ffacd0b85a97d-47f622fcd69mr16725603f8f.12.1784551406008; 
 Mon, 20 Jul 2026 05:43:26 -0700 (PDT)
X-Received: by 2002:a05:6000:25f7:b0:47f:4fbf:7b21 with SMTP id
 ffacd0b85a97d-47f622fcd69mr16725542f8f.12.1784551405474; 
 Mon, 20 Jul 2026 05:43:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ce4sm30467655f8f.8.2026.07.20.05.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:43:24 -0700 (PDT)
Message-ID: <e1ebb262-3419-4a87-8f13-54bada56beef@redhat.com>
Date: Mon, 20 Jul 2026 14:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260716193321.256391-1-thuth@redhat.com>
 <CAFEAcA_s8pZmJu9GW5Kqkg=7UZjKcMOGCrQNz=n_z8vY45doaA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_s8pZmJu9GW5Kqkg=7UZjKcMOGCrQNz=n_z8vY45doaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/07/2026 13.05, Peter Maydell wrote:
> On Thu, 16 Jul 2026 at 20:33, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The stream ID is under control of the guest, so we must not use
>> it for indexing into the status3[] array without checking it for
>> being in range.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/usb/dev-uas.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
>> index 8576dfec96f..7df58cdeee7 100644
>> --- a/hw/usb/dev-uas.c
>> +++ b/hw/usb/dev-uas.c
>> @@ -383,8 +383,15 @@ static void usb_uas_send_status_bh(void *opaque)
>>
>>   static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
>>   {
>> -    USBPacket *p = uas_using_streams(uas) ?
>> -        uas->status3[st->stream] : uas->status2;
>> +    USBPacket *p = NULL;
>> +
>> +    if (!uas_using_streams(uas)) {
>> +        p = uas->status2;
>> +    } else if (st->stream <= UAS_MAX_STREAMS) {
>> +        p = uas->status3[st->stream];
>> +    } else {
>> +        warn_report_once(TYPE_USB_UAS ": bad stream ID 0x%x", st->stream);
>> +    }
>>
>>       st->length += length;
>>       QTAILQ_INSERT_TAIL(&uas->results, st, next);
> 
> Doesn't this just postpone the problem? This function puts the
> UASStatus struct (with the out-of-range stream value) oto the
> uas->results queue. Later on we will end up in the
> usb_uas_send_status_bh function, which picks USBStatus structs
> off the queue and uses the same "assume st->stream is in bounds"
> logic for finding a USBPacket for them.
> 
> Also, once we put this UASStatus into the results queue we
> will never take it off again -- the code for handling reads
> on the status pipe will only remove and process UASStatus
> entries where st->stream matches the stream ID used for
> the read on the status pipe (which must be in-bounds, we
> check that).
> 
> The copy of the USB attached storage spec I found is not very
> clear about error handling. But I think there is no way for us
> to report back the "invalid stream ID" case. So I think:
> 
> (1) in usb_uas_command() we should check the tag for being
> in bounds first, before any other error check; if it is not
> then LOG_GUEST_ERROR and return (do not call
> usb_uas_queue_fake_sense(); have comment about why not)
> 
> (2) is usb_uas_queue_status() and usb_uas_send_status_bh(),
> assert() that st->stream is in bounds before using it
Yes, after staring at the code for a while, I think you're right. I'll send 
a v2 with those changes.

  Thomas


