Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FFDC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Krv-00052q-3a; Thu, 03 Apr 2025 09:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Krl-00051s-QA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:44:23 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0KrF-0005eo-9K
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:44:21 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso972612a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743687825; x=1744292625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+yXjRhQMpbMgiVFkixQPejj1MnySrVmgaJPqDMdbZQ=;
 b=apwBrf8ZtnG4qYbTmWnBNuzLuanU3H4XnekIDrDJOpcYpX/0Zb1R4fKVtUeuWjGesM
 4KpCZ9fQ6+9ohWaVgOVpwoUoRtzm4PSsKRbYttJJ2SJv8T83/Vycg/Hbxq4esQgo/3UN
 CsWcMo8J3belwLyq1W8BfbehvcayWMMfFXPWs5jC6NnO1fEiRM8tw8TFrOl4PEU9EYBX
 aH/+YqD1X04xBWBIgH5T+8Ggdm1/9hr+pHdA2JNWQnvmkAvZsvxP8BWQPCwj4YquxDLb
 ZFHS9WQlYvqM+rjzHYZGIL6BKLLZobf/0yTekn9LAZA4Xf6lbVX1QX1DTLEhF27eHuD/
 tckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743687825; x=1744292625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r+yXjRhQMpbMgiVFkixQPejj1MnySrVmgaJPqDMdbZQ=;
 b=nViqnTawOwNtOCe3Kiz1lAi//j0zUgdDKsnJ/wUmjM3sPL0cUSQDyIfsGknkY9kOYO
 nGU6bM3bphmuoeVP6nGwEP7fpOCnKxTfSkII3Vg7D4Q6sRXcJCvwJ9TD4tK24Fi8dBDJ
 L/OiHWICS3u7nuglKZ28b/yc1YEzcF2GOH1i2ApuUumYkNg5SyA+ydlrxw120RL9Asrs
 k8IFOotIgTl0vRImYJzZi8dfysICGM5p/kVAc4Z0/V4RFyasEYmJli20/6oD1fiCqXGl
 xPvHykiECHU7IGLFvi5cRCmCAV88pEzqBExvuXIcpbvpCZSUmM9p4PwSjblinx1h3GMa
 ZN8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZN4UJfqh8OZemlfT/XTZAgt8hACHX4gJdIhGvD3Dzo1Z1+HAiFWAp15QgJrkhAn8ReyAck38HGHVj@nongnu.org
X-Gm-Message-State: AOJu0YwDZNq/Eq+Mb9LNVEJfOpE8GPOvivauZDuSrosFY1mzUakhwBGs
 9VquYZDfc9zJ3ziPQE9RfnlTpbpEfM/U8TzD6gVLliIsEmgxM8xSwdBSKatbuKk=
X-Gm-Gg: ASbGncsmwQMHj4krFhueG1PYg1Xbzar3bL0n/G6+5JPADNYREVDBMEnILGdgwDMVzHL
 AZQiUCzwUqJgI6E8F4C4CcwvUQLb/r/pKKRgV/LeHIbmFRPn6FJQnsU1oBYbg129Fg7LiC4g0PQ
 +75fs71taX6T62MCQvYpN4zPqyIA3tqcpjA0f7f962XfTcAvUIkC7mx8mmFTcPODd2rfW+FGmso
 NstOINUd/AZ6P9tdFk5wc1iX2nlbeOssdEqy53mZt3iqh/vPfJ9BhvejMSHGOcbKWKHQTcZWWWX
 P0RdvCmZiaNW4sfQUNWC4n30ORewPuPcYf5PVKLrI3XT0jwcKJdBQe1fd2IBifYgqGCEkKmaBqF
 e/aC52pvs
X-Google-Smtp-Source: AGHT+IHhifGi5jLzUT5Z+4NsMnK/Nc4WzIqys4McexeHhPyj2xlme9PxKGmqly0kBJIjPUlbVs+PKg==
X-Received: by 2002:a17:903:1a03:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22977d74765mr32690495ad.8.1743687825202; 
 Thu, 03 Apr 2025 06:43:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865c251sm14140585ad.145.2025.04.03.06.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 06:43:44 -0700 (PDT)
Message-ID: <3debe9d2-ca02-4a62-87a3-0b54f28c05b4@linaro.org>
Date: Thu, 3 Apr 2025 06:43:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/23] include/exec: Split out exec/cpu-interrupt.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
 <20250308225902.1208237-6-richard.henderson@linaro.org>
 <b240dea4-082c-4bdd-8dfb-45d444ae12ef@linaro.org>
 <6b3e4490-781f-4337-837c-3ed38483332a@linaro.org>
 <aae2c395-4649-4281-bf08-4104917aa3c6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aae2c395-4649-4281-bf08-4104917aa3c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 4/2/25 13:13, Philippe Mathieu-Daudé wrote:
> On 2/4/25 20:46, Richard Henderson wrote:
>> On 4/2/25 03:17, Philippe Mathieu-Daudé wrote:
>>> Hi Richard,
>>>
>>> On 8/3/25 23:58, Richard Henderson wrote:
>>>> Some of these bits are actually common to all cpus; while the
>>>> reset have common reservations for target-specific usage.
>>>> While generic code cannot know what the target-specific usage is,
>>>> common code can know what to do with the bits, e.g. single-step.
>>>>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   include/exec/cpu-all.h       | 53 +--------------------------
>>>>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>>>>   include/exec/poison.h        | 13 -------
>>>>   3 files changed, 71 insertions(+), 65 deletions(-)
>>>>   create mode 100644 include/exec/cpu-interrupt.h
>>>
>>>
>>>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>>>> index 35721366d7..8ed04b3108 100644
>>>> --- a/include/exec/poison.h
>>>> +++ b/include/exec/poison.h
>>>> @@ -46,19 +46,6 @@
>>>>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>>>> -#pragma GCC poison CPU_INTERRUPT_HARD
>>>> -#pragma GCC poison CPU_INTERRUPT_EXITTB
>>>> -#pragma GCC poison CPU_INTERRUPT_HALT
>>>> -#pragma GCC poison CPU_INTERRUPT_DEBUG
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
>>>> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_2
>>>
>>> If I understood correctly yesterday's discussion, these
>>> definitions are internal to target/ and shouldn't be used
>>> by hw/ at all. If this is right, then we need to keep them
>>> poisoned for hw/ code.
>>
>> No.  They are used by generic code to mask CPU_INTERRUPT_TGT_EXT_* during single- 
>> stepping.  We don't know what they mean, but they're all external interrupts.
> 
> I'm wondering about CPU_INTERRUPT_HARD ... CPU_INTERRUPT_DEBUG.

HARD is probably akin to TGT_EXT_n, but EXITTB, HALT and DEBUG are completely generic.


r~

