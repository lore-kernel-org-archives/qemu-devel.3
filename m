Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17ACE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkzY-0004jp-Cu; Thu, 12 Dec 2024 10:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkzJ-0004RC-2d
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:20:26 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkzC-0006Ri-UA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:20:24 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e3048970eso285588a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734016817; x=1734621617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+YIjhIymedfUy6rLt7WJQt3ZaZQVZKTAu2cfR72h1gQ=;
 b=Q2sLOff3laoTxfAZ79GNgi+7fAfE0Gr1VleqQWT2KozVwIaZBT+KpuB2ibxNqT3g3K
 2xNkhS2OtLLotF6zkat61gmel3KClAcH/GwUDhojWJ14AFyKr3Cbjt/QLz6Oei4WEX9h
 S5j03IFj9neCUcL9myWDXh1V4Zqd+MlP5r3lCQgu4Yuk771q4L8CwQzN6S4Fm0hfRRqu
 6Axjf8DDdZgsfpxCyfVC443MUJQu6eoZwqB7TTMRdOuIzgcFJWyREC+Y98WnThhJPPpk
 wi1zCAsCogAzCM55PXIi8VGnhKvu4hGSemIOyBG4/Q4ogLktCBqZh91RYC+zq3MwhL1m
 qX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016817; x=1734621617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+YIjhIymedfUy6rLt7WJQt3ZaZQVZKTAu2cfR72h1gQ=;
 b=a5+u4wqT3A84PF30GbOgbZkKBIGoVBI9NCxfmTCGwEP4QtwFkwZg5+Up10DL6nGUYs
 PsvLiXu6MVRVT8SU345OehFm/vg0VmBCeQD5I4WvFyTeEymcY+sLS7mxuZFhbq0BkgdW
 Ix35i59da9Szcxy0JJAY9O2lcNWcdeMytz1YUy9mJWLsVW6IpAAaDuXv1FjfLxaLkh/m
 VSZvGDt7Pv5GSL63gmwnUcVod1R8i8laV+JafIFYMX9js1ytrJumH+dNUYy9qDdLrO5V
 6OEQb3ELOhQBa6DS5QXazMguLuqd4RUZLDa4ce/blFIBQ8u+0Ua6/V50Lm0YpnzGE+ho
 i3iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5q0Y2kMnn7hg97o5MRzKW5nnLcwoUm4vbnvIqXbKryeI8jCPjbiNxuLdbM2y6saz/6EZH/T6pTq+h@nongnu.org
X-Gm-Message-State: AOJu0YwaypmtiW9Jigz6N3ifc5nwvZEo94Odq4LIjcNCeFOuud6kAFs9
 9oXsC1Vit52fAtmUbyXlXIdbC1b2jL7yahSrW3SjF5HsdfhlMt1MoJ0w6kTGNFHKm9aVEB70Xvv
 AdNb5Za/v
X-Gm-Gg: ASbGncvHR/QBTQjaOYouIyXTgFL64ChPZaPL5AgPlmgEi9taqhDh/k2R6eb4U0HGOA8
 4QfumKNRBzQEdcPscbaxn2MIU/8FV6CB+rE6XLmveOmtBqD2u7RR+1F0qk7ktEBJCxtpT6U3bst
 w5lHMBGY1fcIo8FEHd5vKbS5/hn13sHZ/DjFdmzBkOkXZCQLWdGeuspH83dNmfqW1jcHeoUhtr/
 lVLC0+ahtgze3jO+JXWLnMWVCJHfg1pcAM61JbFMHKxLgi+uewITAuuxHqHIQ1h0YWXTA4/XlEz
 jB/LQJW9Fe+CRMRcYL83Ggm+cRO1bqNWXN8=
X-Google-Smtp-Source: AGHT+IGBF35bA/wNExOk+FtVRUe4h5IjWJSEapfOGV19sdXATCoRui9jy29J184t5VuqSRKEkr44BQ==
X-Received: by 2002:a05:6830:6619:b0:710:f375:a6c9 with SMTP id
 46e09a7af769-71e36e27d15mr572121a34.7.1734016817193; 
 Thu, 12 Dec 2024 07:20:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e17a169c4sm980158a34.25.2024.12.12.07.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:20:16 -0800 (PST)
Message-ID: <9743dbdd-f722-4239-8b50-0f6215c36ccc@linaro.org>
Date: Thu, 12 Dec 2024 09:20:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qemu/atomic: Rename atomic128-cas.h headers using
 .h.inc suffix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241212141018.59428-1-philmd@linaro.org>
 <20241212141018.59428-2-philmd@linaro.org>
 <ee831fff-eb0a-4e56-8eee-99222e55d707@linaro.org>
 <8c52c730-cc87-466f-b36e-270d738b86f1@linaro.org>
 <5e8c7bd6-4afa-45bd-af79-3e03b9e6075a@linaro.org>
 <ad7c3026-e307-4ae0-a985-c447ffa68aa0@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ad7c3026-e307-4ae0-a985-c447ffa68aa0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 12/12/24 09:17, Philippe Mathieu-Daudé wrote:
> On 12/12/24 16:11, Richard Henderson wrote:
>> On 12/12/24 09:09, Philippe Mathieu-Daudé wrote:
>>> On 12/12/24 16:02, Richard Henderson wrote:
>>>> On 12/12/24 08:10, Philippe Mathieu-Daudé wrote:
>>>>> Since commit 139c1837db ("meson: rename included C source files
>>>>> to .c.inc"), QEMU standard procedure for included C files is to
>>>>> use *.c.inc.
>>>>>
>>>>> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
>>>>> about includes") this is documented in the Coding Style:
>>>>>
>>>>>    If you do use template header files they should be named with
>>>>>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>>>>>    being included for expansion.
>>>>>
>>>>> Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.
>>>>
>>>> But these are not templates, nor included multiple times, so...
>>>> I don't get it.
>>> I wanted to avoid including "qemu/atomic.h" in each of them due to:
>>>
>>>      host/include/generic/host/atomic128-cas.h:23:11: error: call to undeclared 
>>> function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function 
>>> declarations [-Wimplicit-function- declaration]
>>>         23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
>>>            |           ^
>>>      1 error generated.
>>
>> And why would you ever have that?
> 
> To have "not template" headers self-contained; but I'm fine discarding
> these 2 patches and keeping the last one of this series.

If you have another reason for the change, then that should be the reason in the commit 
message.  But what you copied from Coding Style isn't the reason.


r~

