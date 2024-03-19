Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1374C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTCW-0006n0-1r; Tue, 19 Mar 2024 02:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmTCR-0006jp-Sx
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:43:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmTCQ-0008DU-11
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:43:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso6660328a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710830627; x=1711435427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xV0hVgZJ9TvKR7Mra9EFKINgPQ1sLswvRxNXudXdlKg=;
 b=SQz9PaeGWKFsRI0+vm6Fx8hlWJT4sUD9PIxSRWZhLNuYX2mmjDLXfFBMWUhlgXQZrn
 2dbtz2gcRrXH2TNxIahFlOZDIEGAPtjaZuIuJz9FTFYdBHy54xsTKy2nhKOZ3AjcbUY8
 /IX8hW/tFnHieyN7LheEMVrUz6zQWGCK4Cs/StA85GdV87hZ67e0DJB3pzV5ZV8kCbCq
 hw5EIRXtjFTrW/50KJgc90hrG5qPkdcP4D6ULY5ppU3B41zuGfqpXC/OfOZmFGQ8bFVx
 H5asYL2tVREwggmJqDiEXrzv7NkRzdE+mfomlHKpYNX9e0YbKzBe4nINTZwyNZ3kxMNi
 rvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710830627; x=1711435427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xV0hVgZJ9TvKR7Mra9EFKINgPQ1sLswvRxNXudXdlKg=;
 b=Jc3HbhB9npMpSzkZ8YDRVHEwRu2j90bmzKucdDzroyfGjZ709fIQwGIfz5X0Y3sC9U
 0ff/qfOxmfqx+1YIe81vPlpNOnIX0219fpAIhdpXBxXE8/3VUFGTC1SGDQrEyF4N6Pi3
 9tO2faA8wtqnnY75MjzW5BTlwmlNMd9bgm+k1Qy3m8+A4hSh27/mY1NQvEYQewS3kp/U
 ePfbdmRIR5X1pV2Fcou+XYWy6MVtvyh9u8q3dFLWT8dyrPTVdth7+Qr4qzqvAxbPf9JC
 3u2d4wxeKDIi22DlLS8Kc0E+XDrSN8iZnV7jgyH4ah0WS7IU9NuGKMan8YNS8pU4iOnx
 cA+A==
X-Gm-Message-State: AOJu0YxK6SeFLmYyuAr1qhX+1hXqzjokC7fuLSIMmEwX//W5GAo0oR9m
 uCbFnlVuomp+8f9Apl+YaP+xCEwu8VYrsC8+PCmdwJm0U5jiUX/iQ/8LI5eQ/uY=
X-Google-Smtp-Source: AGHT+IGqCBbt8K67jxrj3e9ReMofU00d6CIIbBlCMxtaRBVHOGpdKpDkUBTSGGgySK5GD+A7EqOPWA==
X-Received: by 2002:a05:6402:3648:b0:568:1b94:fb88 with SMTP id
 em8-20020a056402364800b005681b94fb88mr11563424edb.23.1710830627598; 
 Mon, 18 Mar 2024 23:43:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 a89-20020a509ee2000000b00568c299eaedsm3384332edf.81.2024.03.18.23.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 23:43:47 -0700 (PDT)
Message-ID: <fca8ecfc-f6b0-48f2-9590-867b0f8e4d9f@linaro.org>
Date: Tue, 19 Mar 2024 07:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Tomoyuki HIROSE
 <tomoyuki.hirose@igel.co.jp>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp> <ZfholB7fuWEbuBss@x1n>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZfholB7fuWEbuBss@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 18/3/24 17:15, Peter Xu wrote:
> Hi,
> 
> On Thu, Feb 01, 2024 at 05:13:12PM +0900, Tomoyuki HIROSE wrote:
>> The previous code ignored 'impl.unaligned' and handled unaligned accesses
>> as is. But this implementation cannot emulate specific registers of some
>> devices that allow unaligned access such as xHCI Host Controller Capability
>> Registers.
>> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
>> unaligned access with multiple aligned access.
> 
> This patch looks mostly good to me.  Just a few trivial comments.
> 
> Firstly, can we provide the USB example here (or also the bug link) so that
> we can still pick up the context of why this will start to be useful when
> people read about this commit separately?
> 
>>
>> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
>> ---
>>   system/memory.c | 38 +++++++++++++++++++++++++-------------
>>   1 file changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index a229a79988..a7ca0c9f54 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -535,10 +535,17 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>>                                         MemTxAttrs attrs)
>>   {
>>       uint64_t access_mask;
>> +    unsigned access_mask_shift;
>> +    unsigned access_mask_start_offset;
>> +    unsigned access_mask_end_offset;
>>       unsigned access_size;
>> -    unsigned i;
>>       MemTxResult r = MEMTX_OK;
>>       bool reentrancy_guard_applied = false;
>> +    bool is_big_endian = memory_region_big_endian(mr);
>> +    signed start_diff;
>> +    signed current_offset;
>> +    signed access_shift;
>> +    hwaddr current_addr;
>>   
>>       if (!access_size_min) {
>>           access_size_min = 1;
>> @@ -560,19 +567,24 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>>           reentrancy_guard_applied = true;
>>       }
>>   
>> -    /* FIXME: support unaligned access? */
>>       access_size = MAX(MIN(size, access_size_max), access_size_min);
>> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>> -    if (memory_region_big_endian(mr)) {
>> -        for (i = 0; i < size; i += access_size) {
>> -            r |= access_fn(mr, addr + i, value, access_size,
>> -                        (size - access_size - i) * 8, access_mask, attrs);
>> -        }
>> -    } else {
>> -        for (i = 0; i < size; i += access_size) {
>> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
>> -                        access_mask, attrs);
>> -        }
>> +    start_diff = mr->ops->impl.unaligned ? 0 : addr & (access_size - 1);
>> +    current_addr = addr - start_diff;
>> +    for (current_offset = -start_diff; current_offset < (signed)size;
>> +         current_offset += access_size, current_addr += access_size) {
>> +        access_shift = is_big_endian
>> +                          ? (signed)size - (signed)access_size - current_offset
>> +                          : current_offset;
>> +        access_mask_shift = current_offset > 0 ? 0 : -current_offset;
>> +        access_mask_start_offset = current_offset > 0 ? current_offset : 0;
>> +        access_mask_end_offset = current_offset + access_size > size
>> +                                     ? size
>> +                                     : current_offset + access_size;
> 
> Maybe this looks slightly easier to read?
> 
>          if (current_offset < 0) {
>              access_mask_shift = -current_offset;
>              access_mask_start_offset = 0;
>          } else {
>              access_mask_shift = 0;
>              access_mask_start_offset = current_offset;
>          }
>          access_mask_end_offset = MIN(current_offset + access_size, size);
> 
> But I confess this can be pretty subjective..
> 
> Since PeterM used to comment, please remember to copy PeterM too in the
> future post in case this got overlooked.
> 
> Peter, do you still have any other comments or concerns?

See also this thread:
https://lore.kernel.org/qemu-devel/20200331144225.67dadl6crwd57qvi@sirius.home.kraxel.org/
->
https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html

Also I guess remembering Richard mentioning we should unify this
code for softmmu / physmem, but I might be wrong ...

> 
> Thanks,
> 
>> +        access_mask = MAKE_64BIT_MASK(access_mask_shift * 8,
>> +            (access_mask_end_offset - access_mask_start_offset) * 8);
>> +
>> +        r |= access_fn(mr, current_addr, value, access_size, access_shift * 8,
>> +                       access_mask, attrs);
>>       }
>>       if (mr->dev && reentrancy_guard_applied) {
>>           mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>> -- 
>> 2.39.2
>>
> 


