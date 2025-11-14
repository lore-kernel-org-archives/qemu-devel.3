Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC2ACEACD2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0VN-0006jd-Tx; Fri, 14 Nov 2025 15:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0V1-0006dO-6s
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:34:32 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK0Uw-0005vI-30
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:34:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so17300325e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763152460; x=1763757260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08GEHXeYjcx59aylF6zc1raMv9uDNKTZoYGKu5Vf7Fk=;
 b=eTdDpTLvMOmSLZ/32Ex0t7LoLvTtuvcv9TrlV6DHh6lmc/BVGaGKjqsnm6mfwc3E+A
 fBxqhUzZyZ1tOUEC2ZQGDWGsaceBIDiPODxwgCx19BrHEzI5H2eFZa0/CzQ89RP0Za/Q
 HIUAScMfTdwT5qDcfRMkZbUI09AyyC1hLmA2OtBl9KV+A+3/N2RZ+anGC/c/ql3ZEc3m
 TLI/Q7bHBM336m3R2g2cyBAfsWxij5CwzImCDbLAB+cIuuIroB47G74X2Gs6xyaTRxvg
 U8HePp/e4JIYPImFDlLCRiGHThvdVZkkUNrs4QcDZJTbEC8Oj7GWclItgURSkegvt8mU
 /hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763152460; x=1763757260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08GEHXeYjcx59aylF6zc1raMv9uDNKTZoYGKu5Vf7Fk=;
 b=RGKh5/KZjHaafUwrhhYYZIUrwsFMdp19iYdVEL1Dhj8PPXZgFsiXtOC36D1kaBd8OC
 Qn/xMVMR8tGaYTdfoHBQkLyM28b0U5BsUQvC+A8KDasisXgbCQYzQfQyfg8fv6w6vxNC
 bkROFxqiCzxmCrNdmm+7z95JY6M0kyJ+q3KQR7Q9+kX0ZPh+lJyt1iQfEh7tsX/9ZaKu
 Rn6PoC7AHre25WKdfdsinF/2pS/SjKA6SKzlQ494jJdAJow6+C7qfKzpuPEzIZZx1q94
 bwhU52ZTIb73vFNz6fy49mfpBEFxx7WiQI87bwyYUnxVexmTT4GxcJNNZSxkBtaHyVbN
 XAew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDg2HwIcvhzM2zqAuvlVz0qrxt9Gv2Cd7hQkw6x5EZ16v/9BrAivseckWjiR60//hAE/5WF9n+fqTc@nongnu.org
X-Gm-Message-State: AOJu0YzHcFLoWS35lygLfmg5+QBDa+o9+sSJrJjMFKgmqWUQl9g5j8U7
 cSL4BDh7A/QoUF94ve1xAbJ8So6os8xtSBeYWOYHlnAKoT5PwjtrtXhjeLwxY9Ps8Ko=
X-Gm-Gg: ASbGncsSnmZCdNJBkcxI+3BWmqNfqw6RqEvWI3nrHIyYA7iixyIP7eRXC4DcSjbWgLU
 0V8dxlwN2iJaRfecaNmHlXz5KWTUBIXkea/UQnkXoLAO9Inp/ueibGO2+sfkPMgUBksD+daLW0O
 Ntx8rYsxQ8oEUFXcadpE5LpuEV04IjZkxzsL8ewOlm0rkxozQ8s7krdZpzqjZMGdxja4LTCESNZ
 Cj9eSaPZOHQEdPq02kASVWXswtoDcDOJiIfNn8SCxHeWzEcNkl1WkoUj8qhNMx3PFPZSxEheg7U
 woCvdgy+N3VwCSkWLALeA9HgaPx680IXya9tvOk2tLTaz6OGuIzGamqUCmiGyzNFucZhwulaT1Z
 J6alBNI1ZsWXoxGhSE1K3MwTtq6RwLjEO0zHLK1Y51ockyZeAJT1aX0i9mIZyc8OG2kgF0I1UQx
 6oZKdaczN186cuSPWbG3U2oU7whWnFYxU1pAM11T98kC6Jccqw5wruWQ==
X-Google-Smtp-Source: AGHT+IHZaJIK5hZ/ihmJb7sM7yHc+3WpzfDxMRERjptPh5IW2vzu4TB0QuZsnYWC+VkvFSrMQr2TJw==
X-Received: by 2002:a05:6000:26ce:b0:42b:3dbe:3a55 with SMTP id
 ffacd0b85a97d-42b59339bbfmr4396254f8f.14.1763152459679; 
 Fri, 14 Nov 2025 12:34:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85cc0sm12435586f8f.17.2025.11.14.12.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 12:34:18 -0800 (PST)
Message-ID: <e6606f0d-f9b7-46f6-b0a8-36c80ee1ae2c@linaro.org>
Date: Fri, 14 Nov 2025 21:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: bmeng.cn@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
 <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
 <b083940f-8d50-4aab-a4ac-a88d1988fd07@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b083940f-8d50-4aab-a4ac-a88d1988fd07@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 14/11/25 21:27, Jan Kiszka wrote:
> On 14.11.25 21:26, Philippe Mathieu-Daudé wrote:
>> Hi Zhao, Peter,
>>
>> On 14/11/25 14:39, Peter Maydell wrote:
>>> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>>>
>>>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>>
>>>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>>>
>>>> CID 1642869: Out-of-bounds read (OVERRUN)
>>>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>>>> pointer &frame->data[256].
>>>>
>>>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>>>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>>>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>>>
>>>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>> ---
>>>>    hw/sd/sd.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index 9c86c016cc9d..bc2e9863a534 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>>> RPMBDataFrame *frame,
>>>>
>>>>            assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>>>
>>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>>> data[RPMB_DATA_LEN],
>>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>>>> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>>>>                   RPMB_HASH_LEN - RPMB_DATA_LEN);
>>>>            offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
>>>> sd_part_offset(sd);
>>>>            do {
>>>
>>> What is this code even trying to do ? We define a RPMBDataFrame
>>> which is a packed struct, but now we're randomly memcpying
>>> a lump of data out of the middle of it ??
>>>
>>> The start of the struct is
>>>       uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>>>       uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>>>       uint8_t data[RPMB_DATA_LEN];          // offset 228
>>>       uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
>>>
>>> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
>>> array; and then we're copying 28 bytes of data?
>>>
>>> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
>>> sense either, as that's a weird way to write frame->nonce,
>>> and the RPMB_NONCE_LEN doesn't have the same length as what
>>> we're copying either.
>>
>> Indeed.
>>
>>> Can somebody who understands this explain what this code
>>> is intended to be doing ?
>>
>> We hash the frame data[] + nonce[], and work on the card block buffer
>> ('buf'), filling it before hashing.
>>
>> This change should clarify:
>>
>> -- >8 --
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 9c86c016cc9..e60311e49a6 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -125 +125,2 @@ typedef struct SDProto {
>> -#define RPMB_HASH_LEN       284
>> +
>> +#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
>> @@ -1164,2 +1165 @@ static bool rpmb_calc_hmac(SDState *sd, const
>> RPMBDataFrame *frame,
>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>> data[RPMB_DATA_LEN],
>> -               RPMB_HASH_LEN - RPMB_DATA_LEN);
>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN, frame->nonce,
>> RPMB_NONCE_LEN);
> 
> Also broken.

Sorry, long day :)

We really should add a functional test covering RPMB (I'd have
run it mechanically before posting my reply).


