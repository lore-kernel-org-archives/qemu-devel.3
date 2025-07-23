Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A46C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ued3g-00010r-M3; Wed, 23 Jul 2025 13:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ued3J-0000tB-Le
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ued3H-00064g-AU
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:14:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2350b1b9129so453965ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753290884; x=1753895684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b3NQ66Lm4+2LuFm+m6Dwy1BQvFbQAqY356PRByRv0oE=;
 b=dhzOdRWINIJwx63WYToMlc5nr5ZmxuHO4bsrLGEzWBY8v2KczQVfEFCRkUUIfaP79l
 kp+FQJtwptipbo/NDQ868EwdM9sff9Zbo/w0hEenT4V+oPkxJ3HwrCsC5yIeiTIe1pqx
 hyCtbCE7mZQ4wAIr3TUQcgn8WS82u2DuOp51QnSfl4CMQnXnVcPvAPQMj5z2jOrU4fMR
 it+AG5I0nT38m0HRPBHLbtEFSrZnOBgvhW9XCjHW6Vu32E7/o2zvWPpE2lmCp/gDnf6g
 bYab3Z44LaXodtcfM+WRTUWltPBYEcV5tMmu7nR+BFkHGip4EEjLVqFyEuWUDLZ6QvzA
 1kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753290884; x=1753895684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3NQ66Lm4+2LuFm+m6Dwy1BQvFbQAqY356PRByRv0oE=;
 b=TmDO2y485KhQ2g+ZGfXfLeSrFMl3zHl7uaQxnLRGgRtS/LqVuJOH9z/168Oma70fjU
 S+aDYCPQLZH4LIC5vtgFdrwOrFmQFNg6HNuC+8KFImLm3aB85w5YVkOBZd7eb5Kf7I6P
 w3l17fPhx/O51Ztf/TbHsGffL2eeWsYYGjEEDs+O0s63m8zFN8aX8FXbNbtfoEQjd3vY
 XcltjfU2MSlhe6GDLtF47wMBiPg6ctveFaXV0joGcOXZ/d62ePhOV3pnHpuORck14Mi9
 U1avfl/7YGksqEj6qypNxnM0p5WaK7gz+Fy3PJjTCbESw7nUC1FOvtqK9IGlrH5I2lJM
 kryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQadrcTftsm3FbBILbYTvFCdn+eKvexM3xwqrlVCSO2Ha7FjK5NndPpszTMan2zr3HQ8gqX5pShKD@nongnu.org
X-Gm-Message-State: AOJu0YxURkV7tKPa6s6Cllph6Q+ybu1ThjlQMwv3Njaxx9pEPwAbdEov
 owi/qS8YT1L94WxL7K1e9Cx33cBtgel+d767Q6d+vjL1n2JjddujDCUBl1Do1Mo/VBY=
X-Gm-Gg: ASbGncsGm8ArJyxJMjQbfsKIG/zqK/Y8juGFAsE1mVNLqNEC508lS1rCvWqp3qlu0TB
 b03gS1CDbet/cDAtVwovht+TrmnrZfRKjwpXYI/hIXVjXZa1vYFej7fijw4SQRB3ByMlc7vI4Qo
 VjHdh+uxVPgkmqa0BNvEc+UO/4euuptRucWEyLmgzYhjw0QamoCQ1ENQOhzn7HAbgb2WTCZ3rha
 X1INopjXLVd/s6EJDp3eUbc5r9K3o7Do+i0jQVImTAYpEiaonNhmnIi6TiY/kEXHDaZ3WaclrOv
 25+J4uWLbgRhIYJ2CXE5y+4Ee4CzENj4MO6T4WoLu1gKzPm3fTtapFPjJPQmtNPkXw0cOQs/c69
 Llw3MZ8j/tAYQhs3rLGb6AKduVLjiU/Jdun0I
X-Google-Smtp-Source: AGHT+IE8wxLIfp3rAQjBzSMqfX2Xq529U895go12B6ppt6wIiSAHXgQzqRzhrhEO76Asbs0rliXADA==
X-Received: by 2002:a17:903:46ce:b0:234:c5c1:9b7a with SMTP id
 d9443c01a7336-23f9816414dmr43298435ad.8.1753290884390; 
 Wed, 23 Jul 2025 10:14:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4ae8sm100469745ad.95.2025.07.23.10.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 10:14:44 -0700 (PDT)
Message-ID: <a534ea08-1f3b-4dff-9544-303342b20f49@linaro.org>
Date: Wed, 23 Jul 2025 10:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 6/6] target/arm: Fix LD1W, LD1D to 128-bit
 elements
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
 <20250723165458.3509150-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250723165458.3509150-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/25 09:54, Peter Maydell wrote:
> In our implementation of the SVE2p1 contiguous load to 128-bit
> element insns such as LD1D (scalar plus scalar, single register), we
> got the order of the arguments to the DO_LD1_2() macro wrong.  Here
> the first argument is the element size and the second is the memory
> size, and the element size is always the same size or larger than
> the memory size.
> 
> For the 128-bit versions, we want to load either 32-bit or 64-bit
> values from memory and extend them to the 128-bit vector element, but
> were trying to load 128 bit values and then stuff them into 32-bit or
> 64-bit vector elements.  Correct the macro ordering.
> 
> Fixes: fc5f060bcb7b ("target/arm: Implement {LD1, ST1}{W, D} (128-bit element) for SVE2p1")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Double oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

