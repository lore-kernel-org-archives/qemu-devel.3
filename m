Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F337BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhE6-0000Yh-FZ; Mon, 10 Mar 2025 13:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhDx-0000Xw-LR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:47:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhDv-00066a-Hv
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:47:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22548a28d0cso18328095ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741628849; x=1742233649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vsbUvRy2E8ihEsWBlGsSCiTTWpxpzjkP8pjgwFQvLc=;
 b=PXiiQLMKv6dpyl90GDyqd+otaY0BPS9Q1C0QK46YCeshuXMoxffsh1vhLHceBQqQ+3
 AgQeZl+89Pl3SqZ/XwuvJgrk3T9NNl7pJgDlNEnJT1tcyrfM3AlYQ4fqAm6ylw65S1Rz
 ZCOv/WPej0AZbg3ZUUeV9glff33R0oArGiuX2o+JhNbUzhT7IefXwXQjq+fz+fDi/3YE
 x+Kzh2S+a5OaLhx6/JSRs7gzDUadVaaQ7SfnJBXAKKwtjTo8xb1Gkgm4jnzaIgnIli39
 f9WNvCq4W6+wYxb5cTmWiamIM83ynreMGCJIAwQOEiZPaCdb0sDJkdxUpqBfkwhYtryb
 ov9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628849; x=1742233649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vsbUvRy2E8ihEsWBlGsSCiTTWpxpzjkP8pjgwFQvLc=;
 b=jr588MR0Ks3jcMtP2jDiuvncoIxv1pAJI4HMA/LmadBIPsFUV0EpFBNe4E75CVpRA2
 7d70CIpRf4vV9eOqS3JtS/dRxzW09BRDCZULwJEd6MuhvNSWSwUlHGnuC4sdWzsAhBmC
 RIyQJb+/Jxn+NpLHSYZSNpWmCTVR4nP7eJp48BFl9YrerbEikCpUfVTzxv3WIWSWySYc
 7Re2ZvONbSg+Mye3BETisL24Eijmu/edBFWTEM0YmlKFgPODnfObBwZHTal2CcX39eez
 uqbVWJIqqk7D2WNhBy9LBKGZUCaTdHq2hEckDhOpWSYBi09eNwx/S411wQrIOyiGYytq
 5LLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6HKWoDbVQ3RnjF9fNvThkwCfchm1diUV0tYNLjyS0nJD7l2G/QzzS//KQ9AtyaVQVj40+f6XekuL4@nongnu.org
X-Gm-Message-State: AOJu0Yx0W2IWFMYyUBhDH/Hk46AH9uA7MghqnLWiyopSRNG84bm/eXe4
 IkkQ+IrMMe2MRNtPA16sWpHnlCsGSpxLOKoVnpSmLnvpvecBWfTC8KLntXMqgimnXpwngVPz6kk
 qAJc=
X-Gm-Gg: ASbGncutzN2b4OKsUBE9tv5XFIxco3ndsSgT+DXvJRsZPp0ne2CEuUwqCB65YrcaLLb
 /rSt7Ght7+doQPr2di8tx3xqA7ACLp0Rcv2wjm8Iy2aOs4pQB9nVbeyQ4LsYTGU+aHdvvp7XvKK
 u3l3tTh0U9TS3xru5Ma2VMz0KPRGv1zZ8KguKZbatPjFmP77QZHk0e2EG3fnlaSp48E+2/ZGVO6
 8ZdXIPKwz22ZjLAsxXLcRwRBN/lGkGHNv/A6MPB0kqwKQlphZRJozng89CHWfI0dGkeiuINxD+Y
 RQcmc2v1K64Evwam8oEgvorGVRn9ltlX2CsEOikGgUJHaEFhJ5vaU1iN/g==
X-Google-Smtp-Source: AGHT+IFZ5LgNFzuY6Tj46fepG2FZ0kezQ1BO+V4MjwLORuvn50iHhXl1xjHdTPc9CGD5IjNW6pB1sQ==
X-Received: by 2002:a17:903:1788:b0:220:f87d:9d5b with SMTP id
 d9443c01a7336-22428a8ca41mr245314135ad.24.1741628849113; 
 Mon, 10 Mar 2025 10:47:29 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa4cc5sm81277835ad.220.2025.03.10.10.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:47:28 -0700 (PDT)
Message-ID: <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
Date: Mon, 10 Mar 2025 10:47:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/10/25 10:43, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    system/memory.c    | 22 +++++++++++++++-------
>>    system/meson.build |  2 +-
>>    2 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c829793a0a..b401be8b5f1 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -355,11 +355,11 @@ static void flatview_simplify(FlatView *view)
>>    
>>    static bool memory_region_big_endian(MemoryRegion *mr)
>>    {
>> -#if TARGET_BIG_ENDIAN
>> -    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
>> -#else
>> -    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
>> -#endif
>> +    if (target_words_bigendian()) {
>> +        return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
>> +    } else {
>> +        return mr->ops->endianness == DEVICE_BIG_ENDIAN;
>> +    }
>>    }
> 
> This should use the same expression as for patch 4:
> 
>       return (end == DEVICE_NATIVE_ENDIAN
>               ? target_words_bigendian()
>               : end == DEVICE_BIG_ENDIAN);
> 
> Which perhaps ought to be split out to it's own inline function?
> 

Good point, I'll add this.

>>    
>>    static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
>> @@ -2584,7 +2584,11 @@ void memory_region_add_eventfd(MemoryRegion *mr,
>>        unsigned i;
>>    
>>        if (size) {
>> -        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
>> +        if (target_words_bigendian()) {
>> +            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_BE);
>> +        } else {
>> +            adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_LE);
>> +        }
> 
> Maybe better as
> 
>       MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
>       adjust_endianness(mr, &mrfd.data, size_memop(size), mop);
> 

Do you think defining MO_TE as this expression is a good idea?

I'm afraid it's a bit too much implicit though, but it would save us 
from the hassle to change a lot of code using MO_BE, MO_LE (and all 
other variants defined in MemOp enum).

> 
> r~


