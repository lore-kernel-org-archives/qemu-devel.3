Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD93C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8Kp-0006Z0-DG; Tue, 21 Jul 2026 07:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm8Ko-0006Y1-51
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm8Kj-0007sJ-QH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784632100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dJZQpjtbQOAf2kKABhk4WOD4fgFP3KDWBVhai1BHmQw=;
 b=Zcgmr4rtA/KZtt50lirJq4zN6okdpS9f9Rt0jf9g4/90H1g+NCiDYSNCUKT5ssZTKUn/Ew
 FF7Fv23QXt2eXWpGnLNs5HYLdZZVyodG8pHtDrPQmII7uiwRPhM6C99lrTn56+i1egxKWX
 X2OW1L/neQavirQoXFevb+cxWHL2Qk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--5FeJYBoMNO0gKlNmFc-tw-1; Tue, 21 Jul 2026 07:08:19 -0400
X-MC-Unique: -5FeJYBoMNO0gKlNmFc-tw-1
X-Mimecast-MFC-AGG-ID: -5FeJYBoMNO0gKlNmFc-tw_1784632098
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so5783525e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784632098; x=1785236898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dJZQpjtbQOAf2kKABhk4WOD4fgFP3KDWBVhai1BHmQw=;
 b=KVYkiOLxsvsEXEUomaLCVJn1reOSwA5QEcv+K2X+qhAml3jxKI+HGiS9ujQcGGNFO+
 H2/HowpWMDLfNOZUDmJKP73tMxVDDw/7FEoCPveGM4u0yI375CEG0n5fP0DDi22REtBB
 g9DuqDdSPho8pF7OcMRosbEyzPX5EgOHXWtIxJZr3fp/p7yAumbnUjGyVR7qtnvY4Id7
 36LB/NmCwCYdzvXnKA4Nu4ywM8mSnjb7/QcOz1xxoVjLs8y0yORMla+HKPrQmlbk9Z+6
 xTf9lNQdVQe4/fjyzsJb5ZUKvnDTelSVtziDWehWDTEKVIea+qhWiwoAaUT/GRVdXLob
 DViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632098; x=1785236898;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dJZQpjtbQOAf2kKABhk4WOD4fgFP3KDWBVhai1BHmQw=;
 b=o/Mfzs6/QQ83jEYDPdlc2DGMrS7s9Ky96KUi9MqB72H8OKbevSvMhxbvXtYs1SLeQN
 6LqJn+jxd8acInbYZNyhY/yqja2gqPALLmDQqO54cL/uDn1P6VkyYvMqXufXdpx87I11
 2AFV0SXhhav9zT+6llujPbE0Dc20nm20caGevtaBX1wxMJxvgmrGYKAHez/y9oApaBAN
 F5E1O4bYc1ST1IjrUARGiF5QfR5XCSsY3100515mgNYc+M4RheawaennFxfb7RjsMN5o
 K/FZ03pST09sNZUo5lEuk0MtDsXI/y/PckWFFytCXu/PgLfalSt1i9aLkweC88alG8oZ
 j26Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXioyTZbP99LnKGZvS4qQzjyt4qBwFio5oNjED+rR8tiMC1lmxXVF0y8ILA1hoIuBv8B6Oe8beiduR@nongnu.org
X-Gm-Message-State: AOJu0YzWRHt4li0tzNhpuTVDmfm1bzpwzT6KA3intgxTOI2QV7nMzQkH
 LZuejXPWEWqLf/yksZJxV/nMCb00mAOUXCD5AMzzzkV/yM7CAnkUh5RrDAo92DDJMZh7WOb8X5o
 mimYBuw11+ef+3tL3J2X0hhjnzQYr0QsizrotS5j01Buy6HyWzI7lgDab
X-Gm-Gg: AfdE7ckym8w1yEMgHfiIfsybE5AMa2pkRLh7a4JZ8idKoM220FZ/a/qTy1dSOsTPw+x
 PMppY2qFDVf3uPQi8SYUMPPfuQnGU01cDtHgnGrUgj7RrI1JY1A+PpjpWeHCC//OJyHrKWBkvEE
 uSDtOy7bi9U6gcZrb4HD+zCyeXThh6f1IKecZbZGNUJIHfDluwHdChFaLzu6Ia9Wr1f9eHVGG8H
 mu8XxFNfftMr6kXalb4qwcSkJGTfQ5Pe0v9aL+q4euj5UeX/HrCRpIxTjr7oCbRu+nOAqqXY91h
 WFBdNW337CmFxo91lvjST/cYQADqa1B2vAPdsRgAycFUR4IB7FBpBa1vHg52noV+9UIIaYgbhw=
 =
X-Received: by 2002:a05:600c:4694:b0:495:6713:9aa3 with SMTP id
 5b1f17b1804b1-4956713a11bmr26497395e9.30.1784632097837; 
 Tue, 21 Jul 2026 04:08:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4694:b0:495:6713:9aa3 with SMTP id
 5b1f17b1804b1-4956713a11bmr26496885e9.30.1784632097397; 
 Tue, 21 Jul 2026 04:08:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565304aefsm57061665e9.0.2026.07.21.04.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:08:15 -0700 (PDT)
Message-ID: <70fbca1d-847e-4f94-9ca8-694efae0f37c@redhat.com>
Date: Tue, 21 Jul 2026 13:08:14 +0200
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
 <06ede776-5505-4154-a4d4-a74b77d5cb90@redhat.com>
 <500f7d75-f8a5-4152-bf5b-17cf047ad24a@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <500f7d75-f8a5-4152-bf5b-17cf047ad24a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 21/07/2026 12.55, Philippe Mathieu-Daudé wrote:
> On 21/7/26 12:21, Thomas Huth wrote:
>> On 21/07/2026 11.58, Philippe Mathieu-Daudé wrote:
>>> On 21/7/26 11:51, Philippe Mathieu-DaudÃ© wrote:
>>>> On 21/7/26 10:29, Mark Cave-Ayland wrote:
>>>>> On 21/07/2026 08:02, Thomas Huth wrote:
>>>>>
>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>
>>>>>> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
>>>>>> two IDE drives on a bus (primary or secondary drive) to cancel all
>>>>>> pending DMA transfers on the drive. The code then checks
>>>>>> s->bus->dma->aiocb to see whether there is any IO in flight on the
>>>>>> *bus* and then calls blk_drain(s->blk) to wait for its completion.
>>>>>> However, s->bus->dma->aiocb might belong to the other drive on the
>>>>>> bus, and if there is no disk attached to the current drive, s->blk
>>>>>> is NULL. Since blk_drain() does not check its parameter for a NULL
>>>>>> pointer, QEMU can crash in such a case.
>>>>>>
>>>>>> To fix the problem, we have to check that "blk" is not NULL before
>>>>>> calling blk_drain(). And we have to call blk_drain() for both drives,
>>>>>> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
>>>>>> the blk_drain() might trigger if the IO in flight belongs to the
>>>>>> the other drive.
>>>>>>
>>>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
>>>>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>>>>> Resolves: https://urldefense.proofpoint.com/v2/url? 
>>>>>> u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
>>>>>> Reported-by: dong ling
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>   v2: Drain both drives
>>>>>>
>>>>>>   hw/ide/core.c | 9 ++++++++-
>>>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>>>> index f78b00220b8..f43ab95b07b 100644
>>>>>> --- a/hw/ide/core.c
>>>>>> +++ b/hw/ide/core.c
>>>>>> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>>>>>>        * In the future we'll be able to safely cancel the I/O if the
>>>>>>        * whole DMA operation will be submitted to disk with a single
>>>>>>        * aio operation with preadv/pwritev.
>>>>>> +     *
>>>>>> +     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
>>>>>> +     * so we have to drain both drives to get it cleared.
>>>>>>        */
>>>>>>       if (s->bus->dma->aiocb) {
>>>>>>           trace_ide_cancel_dma_sync_remaining();
>>>>>> -        blk_drain(s->blk);
>>>>>> +        for (int i = 0; i < 2; i++) {
>>>>>> +            if (s->bus->ifs[i].blk) {
>>>>>> +                blk_drain(s->bus->ifs[i].blk);
>>>>>> +            }
>>>>>> +        }
>>>>>>           assert(s->bus->dma->aiocb == NULL);
>>>>>>       }
>>>>>>   }
>>>>>
>>>>> Doesn't ide_bus_active_if() do the right thing here for in-flight 
>>>>> requests?
>>>>
>>>> bmdma_cmd_writeb() already calls ide_bus_active_if().
>>>>
>>>> Is the issue in the caller, bmdma_cmd_writeb(), instead of
>>>> here in ide_cancel_dma_sync()?
>>>
>>> i.e.:
>>>
>>> -- >8 --
>>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>>> index 7ce1ae67ab2..e7c6af9a49e 100644
>>> --- a/hw/ide/pci.c
>>> +++ b/hw/ide/pci.c
>>> @@ -384,7 +384,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>>>       /* Ignore writes to SSBM if it keeps the old value */
>>>       if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
>>>           if (!(val & BM_CMD_START)) {
>>> -            ide_cancel_dma_sync(ide_bus_active_if(bm->bus));
>>> +            ide_cancel_dma_sync(bmdma_active_if(bm));
>>>               bm->status &= ~BM_STATUS_DMAING;
>>>           } else {
>>>               bm->cur_addr = bm->addr;
>> No, I don't think this will fix all cases. While https://gitlab.com/ qemu- 
>> project/qemu/-/work_items/905 has a call trace with bmdma_cmd_writeb() in 
>> it, https://gitlab.com/qemu-project/qemu/-/ work_items/4052 is slightly 
>> different: The backtrace shows ide_bus_perform_srst() ->  
>> ide_perform_srst() -> ide_cancel_dma_sync() here instead. I'd say let's 
>> play safe and always drain both interfaces. WDYT?
> 
> I dunno I'm kind of lost. Can't blk_bs() handle NULL blk?
> 
> -- >8 --
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc40..b5d84c9789a 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -760,7 +760,7 @@ BlockBackend *blk_by_name(const char *name)
>   BlockDriverState *blk_bs(BlockBackend *blk)
>   {
>       IO_CODE();
> -    return blk->root ? blk->root->bs : NULL;
> +    return (blk && blk->root) ? blk->root->bs : NULL;
>   }
That would maybe help with the NULL pointer crash, but it would not prevent 
the assert(s->bus->dma->aiocb == NULL) from triggering.

Simply draining both drives seems to be the only solution that I see right 
now, unless we want to remove the assert() statement?

  Thomas


