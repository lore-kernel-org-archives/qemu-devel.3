Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C1CEACCC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0fY-0004Sd-Gb; Fri, 14 Nov 2025 15:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0fF-0004Ov-6D
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:45:07 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0fC-0008LY-ST
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:45:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso1284715f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763153096; x=1763757896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mCraogRz/NshD3T1vJx9zheS6wOPe67fpRVQp0MAVBs=;
 b=gbOwk+AERUOLf2kJpJ5Gx7pmRJ64sSN3P7z/WoxuIMWyBi2X7vVCCA10DxHjyDwUqg
 DHmB0QvEJnfzXXqOrln3WLcyWkQKDElK5M59rcmgVGGhCR2ayh3vVEPE4HPAPrfwIjhD
 iUrZetIPVE9SKFyWRqfh3c0f6+JHzGlXVbYsAg/fdAE+KKZTMc07Wq6QVfGbG+FK6/7X
 8Fvwlf7SXvLpbEKfQSw0J3/SVoo0Mrdz1ztrQKFf9Z+eDO4xJ82GAz0kVrRXrhc/ayjv
 u9weKUmhKhwZAqw1TKRKHoPWj65foQbvibwQPfbGKLLSTTOMogI4/gUJEfo5eu+EZYa1
 P8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763153096; x=1763757896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCraogRz/NshD3T1vJx9zheS6wOPe67fpRVQp0MAVBs=;
 b=Z2+3WtDh79hHx8x94jVth34Qo3JI1YZmCh++49nw7WeFxuBq2X73VZ/mE0EL2ddJZN
 Fnm6b/mOYDE7g2aD1LInuhdrcrK93Lsn4R7hRLk+zLXsHVahp/7+QKMdKpr5aTLwU2vy
 ZU2reTM8ih4xLcMvzg3OmDCk2Vprf+smbvJ/+M8ALo8/Mm+WNs97VNy7zmXxmh4vJAdq
 f0u34mK+DRxdtlgQNMNX1Ojn7jBOz+xsq2goiUVr/GN4hSZCNpOU7xWJWvl7OwgJa8pS
 LS5JALTV8Opp02O6fJr0lz6mERtmAbrBkPOBLz42dhuqUUywshAQX5STCqNxDpO41WYA
 NAEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3rumnP5uo/MHEzDi/jW7MwSx9WI2/34e0enFkPq84SsfSMLGS4LH9hEjfn5wI835PHcoBfUbGKLgM@nongnu.org
X-Gm-Message-State: AOJu0YyLBw5wNROmqFhtWYFLniN5fz/RZloP9yqVBd/I/WBOMfg/o+0S
 ZfU4eQYZPiGrNoMvd5gjAUKBflgJCijcWW/RYNYVvcJSUnz3K5gMEbY6IZ53DiOQHBU=
X-Gm-Gg: ASbGncvdHPZqlBhRr4cHqvOvWCfbBBkowe4wu222wM4DOUSlU9Jjm0NZSBV/6H5nP0l
 3FN21MjQRfq3byVEqhGVJyKBTAgYrZogHiMKghmv6V76Fflif+7bFhcflqGPz0kEIsfH0fKoOQ+
 z9scMRJCfUPTrZPJi2QdYdf9FqkpXLyk4/nWAAvNKRq8QN34USoNRLhZXUE4iaOvQyXc6baChAJ
 LK5aa/FWGTJvWVnAxzudLOW5DXIE2tCFJU46NEZJKS5w7lfbJxg7TLHn0YYmNU/VOyBT8IlN+1J
 HBubXRY9GVfTU5kAZATIFp5GUtLEyCga44Y5iGvukSHO35JDdyqUH4qp4cgFO7vA+l1rVVJ6Wu0
 kxs3vhonPzkbnTai4YKr4cZ8CpgOWG9IsgpbWtgULjTzPskTT//uXj0OKt36zVFnvXGka4GInic
 DF63qOdJ0lPiFz27ZsdxW0LruHhN3cLS/TReG/GjgDocc=
X-Google-Smtp-Source: AGHT+IFcnoW/aOvV5+z08pdghgBuJqaQwfFOCb4/pJ3t0EtkAUgS53yW0GwQVqtPiVGFYrocurQcNQ==
X-Received: by 2002:a05:6000:40cd:b0:427:580:998c with SMTP id
 ffacd0b85a97d-42b5938832emr3842345f8f.43.1763153095745; 
 Fri, 14 Nov 2025 12:44:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85627sm12796787f8f.16.2025.11.14.12.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 12:44:55 -0800 (PST)
Message-ID: <fdb4bf0d-421c-4aaa-aae2-5eed18b0616b@linaro.org>
Date: Fri, 14 Nov 2025 21:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: bmeng.cn@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
 <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
 <b083940f-8d50-4aab-a4ac-a88d1988fd07@siemens.com>
 <e6606f0d-f9b7-46f6-b0a8-36c80ee1ae2c@linaro.org>
 <d9c56d6c-5560-487c-8cd4-3d2c54cfcb90@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d9c56d6c-5560-487c-8cd4-3d2c54cfcb90@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 14/11/25 21:42, Jan Kiszka wrote:
> On 14.11.25 21:34, Philippe Mathieu-Daudé wrote:
>> On 14/11/25 21:27, Jan Kiszka wrote:
>>> On 14.11.25 21:26, Philippe Mathieu-Daudé wrote:
>>>> Hi Zhao, Peter,
>>>>
>>>> On 14/11/25 14:39, Peter Maydell wrote:
>>>>> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>>>>>
>>>>>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>>>>
>>>>>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>>>>>
>>>>>> CID 1642869: Out-of-bounds read (OVERRUN)
>>>>>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>>>>>> pointer &frame->data[256].
>>>>>>
>>>>>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>>>>>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>>>>>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>>>>>
>>>>>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>>>> ---
>>>>>>     hw/sd/sd.c | 3 ++-
>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>> index 9c86c016cc9d..bc2e9863a534 100644
>>>>>> --- a/hw/sd/sd.c
>>>>>> +++ b/hw/sd/sd.c
>>>>>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>>>>> RPMBDataFrame *frame,
>>>>>>
>>>>>>             assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>>>>>
>>>>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>>>>> data[RPMB_DATA_LEN],
>>>>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>>>>>> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>>>>>>                    RPMB_HASH_LEN - RPMB_DATA_LEN);
>>>>>>             offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
>>>>>> sd_part_offset(sd);
>>>>>>             do {
>>>>>
>>>>> What is this code even trying to do ? We define a RPMBDataFrame
>>>>> which is a packed struct, but now we're randomly memcpying
>>>>> a lump of data out of the middle of it ??
>>>>>
>>>>> The start of the struct is
>>>>>        uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>>>>>        uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>>>>>        uint8_t data[RPMB_DATA_LEN];          // offset 228
>>>>>        uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
>>>>>
>>>>> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
>>>>> array; and then we're copying 28 bytes of data?
>>>>>
>>>>> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
>>>>> sense either, as that's a weird way to write frame->nonce,
>>>>> and the RPMB_NONCE_LEN doesn't have the same length as what
>>>>> we're copying either.
>>>>
>>>> Indeed.
>>>>
>>>>> Can somebody who understands this explain what this code
>>>>> is intended to be doing ?
>>>>
>>>> We hash the frame data[] + nonce[], and work on the card block buffer
>>>> ('buf'), filling it before hashing.
>>>>
>>>> This change should clarify:
>>>>
>>>> -- >8 --
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index 9c86c016cc9..e60311e49a6 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -125 +125,2 @@ typedef struct SDProto {
>>>> -#define RPMB_HASH_LEN       284
>>>> +
>>>> +#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
>>>> @@ -1164,2 +1165 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>>> RPMBDataFrame *frame,
>>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>>> data[RPMB_DATA_LEN],
>>>> -               RPMB_HASH_LEN - RPMB_DATA_LEN);
>>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN, frame->nonce,
>>>> RPMB_NONCE_LEN);
>>>
>>> Also broken.
>>
>> Sorry, long day :)
>>
> 
> Yeah, me too :)
> 
>> We really should add a functional test covering RPMB (I'd have
>> run it mechanically before posting my reply).
>>
> 
> I don't disagree. I have to re-run my full image test for that. A qemu
> test just needs a bit time to work it out.

I also have a u-boot test from Ilias I plan to add.

