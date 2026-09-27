Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0800FC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAt7h-0000LC-GI; Sun, 27 Sep 2026 13:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAt7f-0000Kh-CT
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:57:11 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAt7d-0006TK-Pn
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:57:11 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso1158771a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790531828; x=1791136628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=18F/S+HH9vVdedRwNwUQ/+8qnowflupyJ6j5ZEejJu0=;
 b=aqerPASq0TtnQOCBxJ5JtP2KHyGfdBRdO+DUKjeS12J7kWe2+Wo6ZZf+h4VzzfX8C/
 KKOK+EBX8+0O7zR6egpGWUwrXaiBI72P9pidcWPZ91dnIoP10Yci9qTzCqYAcoJqJcBH
 UeM/edR8FX7XjpYKE+cIy0tkzxCpZ3/3+awI8XcM42HiDf20v58s2hwPXN8nm0xyr0Xs
 wA9jgKVvT3UaLPoGCqAvT5oy4yuU61qNe1kGTIb/1d9fAUeCg+sU7qV462gfsJRWTFRb
 7tqlss5LDle9hn0MpN9ZfvlhxQG+74R8kYB0JDZsvBvd8mwPlbWaRfq8hXKm2xFflULc
 bZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790531828; x=1791136628;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=18F/S+HH9vVdedRwNwUQ/+8qnowflupyJ6j5ZEejJu0=;
 b=2OKC3EVX9tIZ12/HTRQZlJkjCEnthlFVsdC1oZ5WPzPNPZ9hwhaFzkbUWH0hJLWt++
 VR0GWaMaaKIDt1/T0Y37nMbiLAsIA8GD+S+NfK5DDtPrEcVzz5RFSVz0saO6k3CP2PUP
 SPO0BC4FpKIoBW0aiGMBqpTJ2TCGIBq0l8DORRTdLtwZGJ/ESLpt747fZClyf7ja+w+C
 6pZr8/S5vSlXwmsU4EqqLTRfhdtQmXg4tvUU1D4dD7Qpptg10C5PLUAp8da3SV/0Ur4o
 WOStSI24pUdkTd5IsVg8BpDLLeWG1NU8Y84szOiWC6tSaj574gCM9d+ilDh4B7mhe/do
 kCDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrDRT9+fTjzpIec0cKTkZmUMpLMsEFnTl+fIeffFJPop1rXixtA9R0dpafwGtVQ82eO50BA8uOYOIj@nongnu.org
X-Gm-Message-State: AFq9FYJBiD4/fZyP5jLyabcxxGJlrHB1E6SoJULobK3xwGxIAnbKet6u
 L16G/ClNQAGRiNs7jQfpiowGNBFZ2xn/uI9HVJOEWjIdYMp/Wq4b0hU5wzsuqCJbKCs=
X-Gm-Gg: AYBFou1z7m/0rHWeSxGUpBkaN+UcoSOvXYsYj/6NLUX/6u5NodsNMesPQvuozBN84Ui
 zxdPMhGxF6F3MzT9XeR9y8RL/fOBHTywqafA69SRLVsLH8h9JO3B9zHHFxUO6VvfcvbEj1tuLbz
 6c2Slzl63VEp0wR8kfxXBw1efN12wdQEFAOJPBc9SMuocqHVR5CJ0giB5imBD8Z7RlWtB581fwl
 vv0rd9unMg6Q+ZUfB6hoUsyJBBabizzz+XBofImyUlYQ7tSp78e4Gy1roPCDc2702TAJdbzpIsF
 Q1GXL+j8lWSElavuIOfWHN3drmH666D8UIDP+faFbNLKDdHl6NjNUYv3XqDhYUcOrH0ZmlRlLmx
 owzHA274+9aZt3JspnHw7kBuGS5p+jjQ/VuoYwjlkI+5J7BENvKQKk5Pxzvh/i4fO06xvrmZ6Px
 v8U2+xjcbWLfoBRy6dAXieHAy1jZOPK0D1dfekN/o2lk+zMkoGgzTKCJNH9UdGwA7qvOOGqRHe0
 XsXe92j8v/nVR2BlXznNoW2vQ+ckyOYixt2vB7n
X-Received: by 2002:a17:90a:ec83:b0:39e:6c6a:4b77 with SMTP id
 98e67ed59e1d1-3a098e43948mr8054541a91.65.1790531827702; 
 Sun, 27 Sep 2026 10:57:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b4f5f917sm6215484a91.1.2026.09.27.10.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 10:57:07 -0700 (PDT)
Message-ID: <aa750bd3-39b0-4409-9fe2-802098b356f4@linaro.org>
Date: Sun, 27 Sep 2026 10:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-11-richard.henderson@linaro.org>
 <5f762124-6163-433d-b8df-90ad0ae76353@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5f762124-6163-433d-b8df-90ad0ae76353@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

On 9/27/26 08:31, Philippe Mathieu-Daudé wrote:
> On 27/9/26 10:58, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h  |  2 --
>>   include/tcg/tcg-op-def.h.inc |  1 +
>>   tcg/tcg-op.c                 | 15 +++++----------
>>   3 files changed, 6 insertions(+), 12 deletions(-)
> 
> 
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index 77ed34fcb8f..b2fa509cd1f 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, 
>> TCGTemp *src)
>>       }
>>   }
>> +void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
> 
> Maybe this commit (the first converting opcode with an integer arg)
> could have a description explaining / reminding now all args are
> passed as int64_t.
Where would you place such a comment that would be useful?
I can't see how or where.

r~

