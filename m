Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B52C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7bq-0006p0-Su; Tue, 21 Jul 2026 06:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm7bn-0006nj-JP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm7bl-0000hj-3w
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784629311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q14H4RVGnvbnd8VWU5V+2HPVEdy0qw8QUKqgxT6ep7U=;
 b=F6Cnyz6YUxv87ZGQvDHMVjnzvthDBCcGo7VcnsKUYuIEnLHPn7Ct90fEpFE/s6B0/pWz5l
 9i54KloEStWvNZl6hKmQhyVAccjAeJmLzC/pr9SNrHduAZM4/upMtfQQznsHUF5p23IpWo
 XLlo66wPVOArzez19T0Uf9oxSLJAPYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-23vf32k8Pe-vC1Fo-1O0yQ-1; Tue, 21 Jul 2026 06:21:50 -0400
X-MC-Unique: 23vf32k8Pe-vC1Fo-1O0yQ-1
X-Mimecast-MFC-AGG-ID: 23vf32k8Pe-vC1Fo-1O0yQ_1784629309
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49554715277so30512875e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784629309; x=1785234109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q14H4RVGnvbnd8VWU5V+2HPVEdy0qw8QUKqgxT6ep7U=;
 b=L8lIFwo4T0tlhjTdVag9NwwOcdAmU5/Aw1AY/e3Ian4r36r4IBcMqlDB4D0NriDLhB
 +zkG0mbSCTPe8XZT8PB+NIwruNvKS8LWThpJe0FshYbGOR2h1wi9NCUxy/LsAU2/R/3g
 U/XVD5g4wtUmKke7e5TNT5YQPlVGvlDto7jz8Rum4Y0ony8V65B4neIFD/HGkagLlzBZ
 pu6CXvq73YTWHA54YWGGeu2RGQvX2caC6e/9euGFZwmR7O04K4lAplMBVO7cGmQ0kc+C
 9AuSuvdMnU3xL4fHrq9d1fOdGtYUIpVOEuT0vkFk55V9BESAZE1PoNGTK2XkZZepGUGw
 OM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629309; x=1785234109;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q14H4RVGnvbnd8VWU5V+2HPVEdy0qw8QUKqgxT6ep7U=;
 b=bAenigWocftSyC2/yIuaWdMEajBKiB66s8g9sgQeZJrN5cLcNK+bxNG+kzwWch1Q+M
 g6LLyiOH9CuhhRtcLybxzO+qcVN19dTVjapzBKw7hNRYRcZLoK12aTK4vV47AJJpCU0H
 5VplqwVXWqTUcqLE7heD3zrO5OTHwVzyTN05v/79RcVZFFKT4fb4spEJpsPUHL8D4MyW
 GS7uTB1tDOPfveK/v0QMjrdEc+pYRSSX4Zi7nfWNvyt87ZAbEis3uzFwFMh4e8hFTwoc
 RYb1uKOf8FerWSmkxvcrz1jc+UjcbJXGuN1MeK5YVm0uDebiRjfU0EcaC1cn9UOsziEw
 UBxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmmUadhXdxloPxjbOtbsN3F/f3FH1Ib1oH66tZC+rCKCHziCoidYKU5bu9+DDqDuC/Y4IT9fcKCPGj@nongnu.org
X-Gm-Message-State: AOJu0YyJu5yIPDbm6xcSoUpnUSTpt7bALz/pzdYx4Mt2vOSarUOCxy5b
 E6scX/2k6DpQD2jMHj5mDHW5Zn6vVxy5GXbl3zseV8tIZndujC0O9ggT3nhCd17zuasu7vVx8B4
 IFtKIO6O5W9gD5OFRRRXJmmx3GM8GJpcZK/hDInsGn8zSoKDYk9EKS4lO
X-Gm-Gg: AfdE7cmq4tg9FtCgthj8aLfYKDoR61w7lBFXZ25u/W2PHk8/0uo66V76Vh12LDEQe9E
 Y4D5awXZ3IZ8/M89WaY8DRTc/jNHnhadxWi9n/Sr1a7cqSnKRyJWhxFUKn5EcQ/YeWPCzOsO3o2
 chWCxDEFyg0eMlz0/lFb4T4wNn4gUp5ryILaV1bWOsaIMRpTCphUJMPOAVpQa8kstbE/SUg2jv2
 CkHM9rE9aw2TEmWF+3uBBrdlM1OmIZMC4xTOnLomNCGha3XhbUfOJ4G4xn2ZOaC5iEq4dxUCmqH
 nzZFcpYDBvEbBrTia/eQKKG0CHP65KfZJCvmc7GGZ11EHQ/qjJb1XWgQ1xgoCBkqrdUpccvtDA=
 =
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49564829df7mr51887305e9.37.1784629309298; 
 Tue, 21 Jul 2026 03:21:49 -0700 (PDT)
X-Received: by 2002:a05:600c:5246:b0:495:6482:9d8c with SMTP id
 5b1f17b1804b1-49564829df7mr51887035e9.37.1784629308884; 
 Tue, 21 Jul 2026 03:21:48 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955a9e5f26sm149767235e9.0.2026.07.21.03.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:21:48 -0700 (PDT)
Message-ID: <06ede776-5505-4154-a4d4-a74b77d5cb90@redhat.com>
Date: Tue, 21 Jul 2026 12:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/core: Fix possible crash via NULL pointer in
 ide_cancel_dma_sync()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org
References: <20260721070216.82984-1-thuth@redhat.com>
 <3f8027d5-f7db-4fb5-8386-1d5f93974a10@nutanix.com>
 <563e1a3e-1420-4f6b-9244-9ad4360c207f@oss.qualcomm.com>
 <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e705d648-eaa2-404a-b654-a15b1648e0a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21/07/2026 11.58, Philippe Mathieu-Daudé wrote:
> On 21/7/26 11:51, Philippe Mathieu-DaudÃ© wrote:
>> On 21/7/26 10:29, Mark Cave-Ayland wrote:
>>> On 21/07/2026 08:02, Thomas Huth wrote:
>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
>>>> two IDE drives on a bus (primary or secondary drive) to cancel all
>>>> pending DMA transfers on the drive. The code then checks
>>>> s->bus->dma->aiocb to see whether there is any IO in flight on the
>>>> *bus* and then calls blk_drain(s->blk) to wait for its completion.
>>>> However, s->bus->dma->aiocb might belong to the other drive on the
>>>> bus, and if there is no disk attached to the current drive, s->blk
>>>> is NULL. Since blk_drain() does not check its parameter for a NULL
>>>> pointer, QEMU can crash in such a case.
>>>>
>>>> To fix the problem, we have to check that "blk" is not NULL before
>>>> calling blk_drain(). And we have to call blk_drain() for both drives,
>>>> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
>>>> the blk_drain() might trigger if the IO in flight belongs to the
>>>> the other drive.
>>>>
>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
>>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
>>>> Reported-by: dong ling
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   v2: Drain both drives
>>>>
>>>>   hw/ide/core.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>> index f78b00220b8..f43ab95b07b 100644
>>>> --- a/hw/ide/core.c
>>>> +++ b/hw/ide/core.c
>>>> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>>>>        * In the future we'll be able to safely cancel the I/O if the
>>>>        * whole DMA operation will be submitted to disk with a single
>>>>        * aio operation with preadv/pwritev.
>>>> +     *
>>>> +     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
>>>> +     * so we have to drain both drives to get it cleared.
>>>>        */
>>>>       if (s->bus->dma->aiocb) {
>>>>           trace_ide_cancel_dma_sync_remaining();
>>>> -        blk_drain(s->blk);
>>>> +        for (int i = 0; i < 2; i++) {
>>>> +            if (s->bus->ifs[i].blk) {
>>>> +                blk_drain(s->bus->ifs[i].blk);
>>>> +            }
>>>> +        }
>>>>           assert(s->bus->dma->aiocb == NULL);
>>>>       }
>>>>   }
>>>
>>> Doesn't ide_bus_active_if() do the right thing here for in-flight requests?
>>
>> bmdma_cmd_writeb() already calls ide_bus_active_if().
>>
>> Is the issue in the caller, bmdma_cmd_writeb(), instead of
>> here in ide_cancel_dma_sync()?
> 
> i.e.:
> 
> -- >8 --
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 7ce1ae67ab2..e7c6af9a49e 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -384,7 +384,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>       /* Ignore writes to SSBM if it keeps the old value */
>       if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
>           if (!(val & BM_CMD_START)) {
> -            ide_cancel_dma_sync(ide_bus_active_if(bm->bus));
> +            ide_cancel_dma_sync(bmdma_active_if(bm));
>               bm->status &= ~BM_STATUS_DMAING;
>           } else {
>               bm->cur_addr = bm->addr;
No, I don't think this will fix all cases. While 
https://gitlab.com/qemu-project/qemu/-/work_items/905 has a call trace with 
bmdma_cmd_writeb() in it, 
https://gitlab.com/qemu-project/qemu/-/work_items/4052 is slightly 
different: The backtrace shows ide_bus_perform_srst() ->  ide_perform_srst() 
-> ide_cancel_dma_sync() here instead. I'd say let's play safe and always 
drain both interfaces. WDYT?

  Thomas


