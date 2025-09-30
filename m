Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A7CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 02:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Pj0-0004e7-Fm; Mon, 29 Sep 2025 22:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Piv-0004de-Mx
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 22:04:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Pim-0005yo-7S
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 22:04:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso28337445e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759197833; x=1759802633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWTbNIEKHo87HKqvMVExJQRzq5yll43k7IaOlhCDeNQ=;
 b=QaBiAcTQTSflDT9tV/sUeCtjGFzXO4cSiy/wQUWC/rX3eJ473iAFZIxBiVTjeNmCIk
 jWwqhuqX0Ifhz+thAC9mbR+/OjXZO1pyCdxvIzo8AI80uzWyAo41SybrvXHMYRevN6F0
 yZub5WnY1Vk+E5rgrwvV9FsA3H171VK9ZflWRKWyHVmQr49rApcKghX9aUla5f+SbgFN
 g7sDdR/veGP1y8jgT4nfNN1oGS22c+i+oFnJqqVr0Av6znoKppeSrQKUZMA2JukwKQ5Z
 HciKcQsUpGCwl8+yVQOGClixPswsd4YILkVuWJ9rv9PDIpzzupqjQ9MjPlE0N4GXC9aF
 2ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759197833; x=1759802633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWTbNIEKHo87HKqvMVExJQRzq5yll43k7IaOlhCDeNQ=;
 b=V8jeseURtaY9FNMlNSIjbRBoemdFStroSOO5fK2J5gbZCsmvZBevUIBRQfaHYRM6MZ
 go7WHLG1Gjod5dUD7ehthwA1bA8ggpu1PvL7UeiFz9K+bci5vZblkvXZfF7z520QJrU2
 87ld+4+Q8NAZvR1cNgfe3PuNmTPZXlG3l2AB9n7qR32/m2kwLpSgRqbX6AmxHHvNgryE
 4LPYGlCREmg9aaT2099bfZohV3VMtJf2mqwH85nsPMcSllIbiiFETnAgK33eFrvyGI6S
 EyWjK5bDpWyxgwIj72v99iwO7w9NgZoHXloLIO4Tlx1xSHRa3fkzR1QK0D98FdgWRUsR
 HhWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnwlnNdw2ImtXUPYYcbSmcEWc0FiheMy5vO4IL+C+9LUPYYoiAk/fRgKfphtTv4mizHrPjeQMEtjLq@nongnu.org
X-Gm-Message-State: AOJu0YxcOFz8JmE7xRrvKaQrsGXL0nJSg6rWAs6lgt0+mVCVcz/SeXQH
 fNV7VRTmrvz9o08lZm2arjsLShgiEcGzskxCs15qVnfDu0QUuQEfAko9lBHk1k5Fu6g=
X-Gm-Gg: ASbGncvOpfh6ykc7UzsyCpba5C7C9CIi9gZcxM7KdHdwOHZZOEVUZXBs3UW2oqt+9BG
 lYLY4NaocIgs/IccA0hnPsU6GcCloC/rEr6oWXxvk5Q7j7sRGHj0olP7cARZUMc1jYywTW9B71O
 x9Pg0XXsCQiNpzztZIY3V5QTW0KClI7bFSbzgzFVp92p6RnlVuUe5u49agmVyocRMAQ3jH2vwT0
 i4/r/3mIkMh2/DKRXGEs3rtow8D8zRH0BK3a2tcppQnpPmIa66r+pmVaxiur9vK/6QeqYbckeNB
 TL+QEbz3MeDlv2lXnAQn3ggK7vgq2JhED6HMxdKfu1hAd5q6JYW1ESuEfGH7GvqqSYUr9s4ybdc
 0Ws/nWN9lRTIX0gwwCrSh0zG87irPPfdHlAu59BhWOqTJzfjGqv7+dZJP5vXlRRYKsdUukGyG8x
 iAaD62cQQ+VqHe5pobgEi1aV17
X-Google-Smtp-Source: AGHT+IECFDwLPnpMeVb9SforN7Yim+2uSjxE1rj9coWLF3OuDaB0rnlESTlQ2911dfKWYyUgs181VA==
X-Received: by 2002:a05:600c:4213:b0:45b:8adf:cf2b with SMTP id
 5b1f17b1804b1-46e32a30f5dmr100757145e9.21.1759197833498; 
 Mon, 29 Sep 2025 19:03:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e46de67e1sm114958975e9.6.2025.09.29.19.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 19:03:53 -0700 (PDT)
Message-ID: <6c899106-ca29-4165-8769-2376f5eb5b07@linaro.org>
Date: Tue, 30 Sep 2025 04:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/34] single-binary: Make riscv cpu.h target
 independent
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20250924072124.6493-1-anjo@rev.ng>
 <427722cf-c91c-4c2f-b5a0-8d127c3dddea@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <427722cf-c91c-4c2f-b5a0-8d127c3dddea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 30/9/25 00:44, Pierrick Bouvier wrote:

> On 9/24/25 12:20 AM, Anton Johansson wrote:

>> Quick question to correct my understanding. AFAICT riscv64-softmmu is a
>> superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
>> concerning single-binary do we for the time being only need to support
>> riscv64-softmmu?

You are correct in that they are all part of the same architecture,
the register bits accessed being a mode of a CPU.

IMO The "superset" view comes from QEMU historical development, and
I suspect a generic riscv-softmmu could be sufficient here.


> Overall, most of the changes you do are correct, widening types, and 
> combining low/high part in single 64 bits integer. For this last part, 
> I'll let Riscv maintainers decide if they agree with the approach.
> 
> However, the main issue is that changing size impacts migration 
> (VMSTATE_UINT.*), which would suddenly create a breaking change when 
> importing 32 bits machines.
> 
> We have two ways to deal with it:
> 1. call it a day and make a breaking change.
> On Arm side, we were lucky to not have cpu structure defined with any 
> target type, so the problem was not found yet. But we observed that 
> other architectures would need a solution.
> If Riscv maintainers are ok for a breaking change, this is the easiest/ 
> fastest solution.
> 
> 2. introduce a backward compatibility change, to selectively import size 
> if we import from a past QEMU version. In this case, we would keep the 
> VMSTATE_UINTTL but adapt it to do the right thing when restoring, either 
> writing 32 or 64 bits.
> I didn't dive deep enough in migration restore code to see if it's 
> easily doable, or not.
IMHO we should really avoid (2). The only problematic architectures (wrt
migration) are PPC and X86.

