Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C2BC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWU5-0001RF-Vx; Thu, 01 May 2025 12:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWRS-0007bO-1b
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:07:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWRQ-0005xS-68
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:07:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so7343865ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115634; x=1746720434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSXwYMiQVgtQIFcXTd9RPepSmBTBe17hr85/w9CNRtA=;
 b=cr8U6PE7uaouNYvClOBpv7iWROf+3CJyZ27+DzqPI7cLUiIUXF+bitiSkjc97ES4DX
 meyotWSXnL2xYOMwgvml6f5ykuNnZcDNK8GanQ/MnzWp8Mmo1lSANJIf0sRdYvVwSwF2
 9FVleEWyhh/qvCf3so5pJyA3rhsX+a0nY8whMnq/V44fQ9S6nW67JKneGH5UuUR8tYLc
 vW//Mm6BX5kaC85siTV+jmoFvCAJ4RJIHROBWXRBfACd4rb2aruv8lapJivZXPd9SV/O
 nA2EKr5z4lMV2s+H7mHT+xi2wlt2EUBaUqr9PUqwOEiJGK5TuA398M7bZQfKMz8g0cFd
 2xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115634; x=1746720434;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSXwYMiQVgtQIFcXTd9RPepSmBTBe17hr85/w9CNRtA=;
 b=B+MjkULRJRfkwZn6cZerBl99dZp9fUaY0pgQp7MS/qD9Dz2fbLO/xqX0sHfsRL1w3P
 LN6WDhPDlgl2a0vVVQxd875dlyV21zQLP6nZpok4U/M1HwhTBY2vOsPMsMw2t0BSyuLb
 nUY/XPs5s+X5b+QAi1E5QQq8eq7/HSDUdU1cXduRhgRQMhKsiZ9A8ttu0bpRW0nwcL+2
 tpfEk7xuOSWSajL58lvZOGc3P8pssBtmSyORsCWCYu7u7rnNeQDxxBwrfRviShXgjctb
 KfwELJ4PS4YUObtfnxAJNgJIaBJ/Uxs1FA4KRafx8of+ktOpV7/CEzGZ+ID3YaXzGOye
 0l1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiri+7zOk6gCGBj3XijJyq0z8jWZ2G6S2DeC1hhLfZthoPDjYzrj0VNobu4Qum1TwsXC496FjIw/0R@nongnu.org
X-Gm-Message-State: AOJu0Yx71hfJCrCKM8TdvutM0R0D9tGKalVU8K9ersdQu9c0/B0Cr4k0
 eJBjAKVAPFW6oFdqne1TT8zZUB5aLRpwp0HNNn/NzM+lB6GZfRXSQ21L5TPIzZU=
X-Gm-Gg: ASbGncvYR9Q/OLzFuww6E2SV6bxSDaRAPi1zqDP2ygeUN+UD+VxY1Znf7GQt0Af7WYx
 6byp4r5owplkW+1oAs0uj5VNR6qpdGjm5KCordc3/SOJcp11RmC9J6rfnMpPPRRoczwvbeRymDA
 IW2mmxlkztoDhOBEkbnRXzw4FpW+s47XuHVzR3leM5OaiCGdn/Mj5HFQ/WJZdps/gOKDUp2gInl
 85BYAJynXNliqANSghxF1Ndl+b9kkATNr+TX1H/4oEBmsN6SpVzqpZBt58qEzmW5jMrvAtVOhIc
 P8DWbqejYM0d5LBkYqZGt6Yzwdklfr1Xc21njapi+WdBVvW6GV+VjQ==
X-Google-Smtp-Source: AGHT+IHeXvhcY9XW5df0XVfafeBtOu9lWrL+GSTBkzm8cSJ3N5cwUvLAkvhEPxylBVoNBQkgdQEdqw==
X-Received: by 2002:a17:902:e54c:b0:215:44fe:163d with SMTP id
 d9443c01a7336-22e087f77femr46392925ad.17.1746115634536; 
 Thu, 01 May 2025 09:07:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc7baa7sm8415515ad.190.2025.05.01.09.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:07:14 -0700 (PDT)
Message-ID: <f0750224-e291-4d40-8fa7-77c65e2a13a8@linaro.org>
Date: Thu, 1 May 2025 09:07:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Finish building once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Based-on: 20250430230631.2571291-1-richard.henderson@linaro.org
> ("[PATCH 0/6] accel/tcg: Build translate-all, tcg-all twice")
> 
> Adjust the final two files in accel/tcg/ to build once.
> 

Congrats!

> 
> r~
> 
> 
> Richard Henderson (11):
>    accel/tcg: Move user-only tlb_vaddr_to_host out of line
>    accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
>    accel/tcg: Use target_long_bits() in cputlb.c
>    accel/tcg: Use vaddr for plugin_{load,store}_cb
>    accel/tcg: Build cputlb.c once
>    include/user: Convert GUEST_ADDR_MAX to a variable
>    include/user: Use vaddr in guest-host.h
>    accel/tcg: Move TARGET_TAGGED_ADDRESSES to TCGCPUOps.untagged_addr
>    accel/tcg: Remove TARGET_PAGE_DATA_SIZE
>    accel/tcg: Avoid abi_ptr in user-exec.c
>    accel/tcg: Build user-exec.c once
> 
>   include/accel/tcg/cpu-ldst.h   | 24 -------------
>   include/accel/tcg/cpu-ops.h    |  7 ++++
>   include/accel/tcg/probe.h      | 16 +++++++++
>   include/user/guest-host.h      | 49 ++++++++++----------------
>   include/user/page-protection.h |  8 +++--
>   target/arm/cpu-param.h         |  7 +---
>   target/arm/cpu.h               | 36 +------------------
>   accel/tcg/cputlb.c             | 28 ++++++++-------
>   accel/tcg/user-exec.c          | 63 ++++++++++++++++++++++------------
>   bsd-user/main.c                |  8 +++++
>   linux-user/main.c              |  8 +++++
>   target/arm/cpu.c               | 27 ++++++++++++++-
>   target/arm/tcg/mte_helper.c    |  4 +--
>   accel/tcg/ldst_common.c.inc    |  4 +--
>   accel/tcg/meson.build          | 10 ++----
>   15 files changed, 154 insertions(+), 145 deletions(-)
> 


