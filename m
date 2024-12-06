Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC6E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJNBm-0003FN-G2; Thu, 05 Dec 2024 20:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJNBj-0003F3-GM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:31:23 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJNBi-0006a2-0j
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:31:23 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ea4f9825f6so481128b6e.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733448680; x=1734053480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GnEYhcml5UWVpnIefmzzVe9HES3yWRFsa/RIrskuy0Y=;
 b=C4oFrVSEOXqL+BST2IOYWiGPwR087Y5/t0AembPnbuBsMYECVQA53tsQZFnUnjagMy
 bl8zZAWO1O8WRvPx64hcgB42MVXo5U8Z8X/cojOJJloZ3M3cJCW8kSc8m7Zw0AEbQz0l
 ySGvQkl5VKfy/A3np9+H8IIP5IVXegVjVgZNUyHb3jMU4Wpaieczg+PBNxSa+gFmvLjH
 orhKfxuVDua+u7do7apRe3kNNQY/UnA4hyvNtc7u6Qz8NZK5+K9fs0xv/7iA77jNRcmI
 X541sO2SAGoCsD9k1hFaQmtJfW+eGwtkSpICIezuVzuPX0DpN5z+aX+qxEXvjSDsv9Zs
 WQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733448680; x=1734053480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnEYhcml5UWVpnIefmzzVe9HES3yWRFsa/RIrskuy0Y=;
 b=S+UzsyYrHq1VpkIpS7Ar4wM9AU2z3AaMuXIeJIxjcJtrY53nLzvgGHMX8Ar0XR/mUz
 uylIB04RFk5Nf41V2uDRCTI/ezQ3WhL3Zr7iQjdKlc3qwNlnROWDf9cIr+SQgfOp3g9n
 39VIIC91F6sd125jqr0URemxCe3iBuRdhqbgbnPm9cctzRFRTNbcQAlFOCdOrF0+yF5V
 WM4uAUtJPc6ecMrpByHDl9tTLKH9BWVFNLYqO4S1jICFoBVCzEuIeUpqFZntgIqxPvpV
 EZa6D1HCT28hVG6X8eTy836rq6kh4X+QG1m0pRhfQW2pkg6Y+TaKXiW14G6YS0q9p4h6
 va0g==
X-Gm-Message-State: AOJu0YxqnuxVc4X4jSaBEkulgNHGdi+Pw00W3tQjWonnxXE9Y+ND9aAP
 2yNusJCHJh5J1LV6Sn5LJZ198/BFpJQnLvnqKHpf9zTTbwluwL+4SZbUHsyqvNbGu2yLZiMsm/W
 4uHr4gggU
X-Gm-Gg: ASbGncu7vwW4MFrzj4/6AxhiJjj0l/fzzaFrEjiyJIqLPRlMpww73oS4FelFmKPW93s
 osK3ZW5oGsSh/mX9hQ4vwvfkMS+4Do4PJz+sGkp7ucNV4AX8+ta0GnJRWW7LXgCy3AHBnJLEMRr
 +e9AFFHJJ+m47VcyPFute/secZgySk6q7d9CX8B9zKt2JpHAPL5ote6+grxfoRvBmJYMhIT+kSx
 +M+UpjX1oVuGhXKNfUTDDSlTu1qeHHUDfdAg8eOQ3XlHOv4sVStVAPe4GgReTUTLbHQThFKhj3V
 jvqgvc7oKACHLme1mEDmoh62tyhT
X-Google-Smtp-Source: AGHT+IERrr+YSfYdPLLttAZJRdaHhgS7MG1N7GRzXYmxkkXrGR9K2F3iI9rHsyuWrD5TQrbN7WPLFg==
X-Received: by 2002:a05:6808:e86:b0:3e5:fd5a:c39b with SMTP id
 5614622812f47-3eb19c08616mr606628b6e.4.1733448680510; 
 Thu, 05 Dec 2024 17:31:20 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb077fb103sm563754b6e.41.2024.12.05.17.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 17:31:19 -0800 (PST)
Message-ID: <98336171-866a-4204-abef-c29d05073d15@linaro.org>
Date: Thu, 5 Dec 2024 19:31:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/67] target/arm: Convert FCMP, FCMPE, FCCMP, FCCMPE to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-23-richard.henderson@linaro.org>
 <CAFEAcA-2nA_UYVt+U5hkngxxNEEUmLa6EBkt18v2=zv6PUMMnA@mail.gmail.com>
 <CAFEAcA_aaioxN2_ePCcMBLkaXVoUx1mR8-MmAar9tVNJMtAa1Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_aaioxN2_ePCcMBLkaXVoUx1mR8-MmAar9tVNJMtAa1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/5/24 15:27, Peter Maydell wrote:
> On Thu, 5 Dec 2024 at 21:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sun, 1 Dec 2024 at 15:17, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/tcg/translate-a64.c | 287 +++++++++++++--------------------
>>>   target/arm/tcg/a64.decode      |   8 +
>>>   2 files changed, 116 insertions(+), 179 deletions(-)
>>
>>
>>> +/* FCMP, FCMPE */
>>> +static bool trans_FCMP(DisasContext *s, arg_FCMP *a)
>>> +{
>>> +    int check;
>>> +
>>> +    if (a->z && a->rm != 0) {
>>> +        return false;
>>
>> We did not check this case before, and the pseudocode in the
>> Arm ARM doesn't check it either (there's a comment for the rm
>> field that says "ignored when opc<0> == '1'").
> 
> ...this probably falls under the "RES0 UNPREDICTABLE" handling,
> but "ignore the field" is permitted for that. If we really want
> to change our choice of UNPREDICTABLE here I think we should do
> it separately from this refactoring.

Fair.  I've removed it for now.

r~

