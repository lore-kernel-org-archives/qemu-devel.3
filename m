Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E135C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5wc-0006fy-O1; Tue, 21 Jul 2026 04:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm5wT-0006fC-B1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wm5wL-0003vL-K1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784622898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x5AFX9pM+RH0AIAqTsx2Af+rjvpTDZ5t0QOnnoX46Gg=;
 b=TwDgctOwhIUO2qjELHHohHD+L6NUWnUptgMXKr33q3o5AOniePJVOy0ZmQsPai81KOa1ay
 0K6YF5HWf4YiltPaEn2VRJhVUxbEwS4rj6HNKpmgzMT7hpc5kuIWg1dqDiY+YQ6QfP5WLD
 3BOr2JiTL4aeOwN9DxD+ZuA1vZXNfQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-IWiQKbzMPoOsaBwQGuDnUw-1; Tue, 21 Jul 2026 04:34:57 -0400
X-MC-Unique: IWiQKbzMPoOsaBwQGuDnUw-1
X-Mimecast-MFC-AGG-ID: IWiQKbzMPoOsaBwQGuDnUw_1784622896
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955edc851aso9469695e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784622896; x=1785227696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x5AFX9pM+RH0AIAqTsx2Af+rjvpTDZ5t0QOnnoX46Gg=;
 b=Tj3oI2gGfZerNBNvEoQA+R6WvG8Hyki1R34f+4bfnrRqHfkqnJtA/BL1GJJoKUIWoD
 cO9HM7eTC9Nv/8kAzzKXiW1zhsmzXU5OgS74qFhUtxPHI0p1JEWVK9AJp6H9ntY6JDrs
 Rf+LoYxbO4Fzb76sY1sBILfwk9JQ6uXe6HqagVRWltNa4dWYBcgSLj0GOTnHdVqTMCHY
 riWPKGhlVMSweQC2rzp00oMUi4Vhe1wZOBJqbLhgWgmFcYF5XOpWFE7DG7jOmZn4I2AY
 4VQkxaWGrB1yxu9RRVzbYKT+QASnTx9AhPYnIO67YKtJ6RADmVVbC2acRGQe3Rmo9bzN
 pteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622896; x=1785227696;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x5AFX9pM+RH0AIAqTsx2Af+rjvpTDZ5t0QOnnoX46Gg=;
 b=ght4QgPReWH9RtpOvn3HCQSSEL7CgPdmzcQFgsjWUrmIZ7GfgWFCiK2Kyp+HzZHcgS
 ly+eZyDmMW2SYhiwxjrtdtVjsi2teiG+h7fovNdgVkJ7VgWT+VFW7VTqAvHf65aassEg
 dIf8AaluKXDDm5CagSNXr0zytL3oEJgsW/N0L6RzCdiCJXbX522txWeWfq+8XLnkr4YP
 AuA6c56zyMN/EqhtpbZbsZqJQTg1/UYwsYtKPX21xOcxxl99n6GBD35+GA7KFiL8xVC9
 xqblIlgLOE4KPgDltTDp2TMVRi3/HkH3VeCVpDk1zbK5ssMcQcuu1FWUccx99ZSDlweD
 jT9A==
X-Gm-Message-State: AOJu0YzbQUpiW/Nl85QGDXlq3CvL6tu0VrjZIh3I64Ns8coJiAIyQxDf
 Ye1vV+IXBeazxEFTeXxwtoqqR1d6pp/o/ifxqfQH8MGb/Z9l1kra33bSGXKCEkapRq7cbbKdaIt
 9r2C9OGDc9CHTjRGzFV3+Bw0cHl5FaTb95RZvCapgG99Vr/ordCvb/fS/
X-Gm-Gg: AfdE7cmFzBUrYhsX4GisLkbB68X+KgXQtSaobOMHRYySJy+59Nmu3MaQ8TGzOmYHWpC
 5Qrlt3F1zGn4EGjOD975b/nDdF8F+kTj8Q1jYBC/WyFSWXpbKzW4nOowyaa4WQwOsTZo2Ck+Gi/
 qLkSGjr4dUSGQc0tjOl9AD8/If079H0YrCisuIZLCjZF+tn9ZIH3/vwFCreX6JeRCorOP7erkTV
 WxlOpyNRtG03goCgE6m/7x/gjVSA7LbK6J1gTEbCjebZBjEkkzUebSQl4N/fPZyClZ+Z+Flxyp5
 X0aah1RUy5uthxpX3rWDG8taWCsyE/KobQh+DQj3r0eFGXEqKY7VEwoX+y78Y3aBekBAxQadYw=
 =
X-Received: by 2002:a05:600c:4708:b0:495:518a:d95a with SMTP id
 5b1f17b1804b1-495518adb95mr160539735e9.29.1784622896109; 
 Tue, 21 Jul 2026 01:34:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:495:518a:d95a with SMTP id
 5b1f17b1804b1-495518adb95mr160539405e9.29.1784622895591; 
 Tue, 21 Jul 2026 01:34:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm45973395e9.13.2026.07.21.01.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 01:34:54 -0700 (PDT)
Message-ID: <6f9ddb0c-c4dd-4206-99fe-55d8feb44124@redhat.com>
Date: Tue, 21 Jul 2026 10:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: replace assert with proper error handling
To: Fiona Ebner <f.ebner@proxmox.com>, jsnow@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sdl.qemu@linuxtesting.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250116111600.2570490-1-anasonov@astralinux.ru>
 <CAFEAcA_S1COmR=_t8Q7mXoEoAwYSbxUNRSvZmp35LiH9JSbtPg@mail.gmail.com>
 <90110e6f-55ec-4006-aa3a-22137dab631d@astralinux.ru>
 <5bb78ad4-51ca-4d10-82fe-561309dfab95@proxmox.com>
 <dd5f1d4d-2f18-489c-b8e1-7b1de8872fd6@proxmox.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <dd5f1d4d-2f18-489c-b8e1-7b1de8872fd6@proxmox.com>
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

On 20/05/2026 10.27, Fiona Ebner wrote:
> Am 19.05.26 um 3:52 PM schrieb Fiona Ebner:
>> Dear Maintainers,
>>
>> Am 16.01.25 um 1:30 PM schrieb Артем Насонов:
>>> 16/01/25 14:32, Peter Maydell пишет:
>>>> On Thu, 16 Jan 2025 at 11:17, Artem Nasonov <anasonov@astralinux.ru>
>>>> wrote:
>>>>> This assert was found during fuzzing and can be triggered with some
>>>>> qtest commands.
>>>>> So instead of assert failure I suggest to handle this error and abort
>>>>> the command.
>>>>> This patch is required at least to improve fuzzing process and do not
>>>>> spam with this assert.
>>>>> RFC.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
>>>>>
>>>>> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in
>>>>> ide_dma_cb()")
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2777
>>>>> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
>>>>> ---
>>>>>    hw/ide/core.c | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>>> index f9baba59e9..baca7121ec 100644
>>>>> --- a/hw/ide/core.c
>>>>> +++ b/hw/ide/core.c
>>>>> @@ -931,7 +931,10 @@ static void ide_dma_cb(void *opaque, int ret)
>>>>>        s->io_buffer_size = n * 512;
>>>>>        prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s-
>>>>>> io_buffer_size);
>>>>>        /* prepare_buf() must succeed and respect the limit */
>>>>> -    assert(prep_size >= 0 && prep_size <= n * 512);
>>>>> +    if (prep_size < 0 || prep_size > n * 512) {
>>>>> +        ide_dma_error(s);
>>>>> +        return;
>>>>> +    }
>>>> Now the comment and the code disagree (the comment
>>>> says that the callback must never do the thing that we
>>>> now have code to handle).
>>>>
>>>> What's the actual situation when the prepare_buf callback hits
>>>> this assertion? Is the problem in this code, or is it in the
>>>> callback implementation? Which IDEDMAOps is involved?
>>>>
>>>> thanks
>>>> -- PMM
>>>
>>> Steps to reproduse are described in related issue:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/issues/2777 In this case,
>>> function ahci_dma_prepare_buf() from hw/ide/ahci.c stands for s->bus-
>>>> dma->ops->prepare_buf. It is called and returns -1. This is because of
>>> call to ahci_populate_sglist() function, which returns -1 due to check
>>> if (!prdtl), where prdtl is one of the fields of AHCIDevice cmd header.
>>> So we have a situation: prepare_buf() must succeed, but returns -1 for
>>> some reason and application fails (which is harmful for fuzzing too). We
>>> may solve it in two ways: patch callback or patch caller. I don't see
>>> any possible way to handle error of populating sglist inside
>>> ahci_dma_prepare_buf() function: it fails to prepare buf, but has to
>>> return something. Since then, we should catch this error and interrupt
>>> operation or maybe other action. Thanks, Artem
>>
>> I'd like to ping this patch, since we got a report from a user hitting
>> this issue in production now [0].
>>
>> I suppose we could keep the assert for the latter half, since not
>> respecting the limit would be an implementation error inside QEMU AFAIU.
> 
> I got a mail bounce for the original author's address, so please let me
> know if I should send a v2 with the code comment updated and optionally
> my suggestion with keeping the latter half of the assert folded in.
  Hi Fiona,

seems like AI tools can find this problem, too:

  https://gitlab.com/qemu-project/qemu/-/work_items/3901

so we should definitely fix this before we get swamped with more bug tickets 
about this problem. Thus: Yes, please pick up the patch and send a v2 with 
doing the ide_dma_error() for prep_size < 0 and doing the assert() for 
prep_size > n * 512.

  Thanks,
   Thomas


