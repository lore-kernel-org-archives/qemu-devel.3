Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC4FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO5B-0002yd-7s; Sat, 30 Aug 2025 12:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkOe-0006WB-7Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:43:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkOZ-0003Sm-VH
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:43:01 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-327ceef65afso824133a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756417377; x=1757022177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QW+nLvV4rvtIb0C8gUiXVzNmuir38ZsWsYpP2QF+NY4=;
 b=jKxy2noa9Y0ASybyhhDYZ9uU+WvaidHiHtRuduVmn3Ksye2fK9gJ1N5oaEk9t92bYl
 0IjYuPvh+//+ZIo+moo0sTuwvomHh+zeIVRqhIPFYKA0UCEEadBd6+86sMWcMLikSG4E
 SIQfKIDJFTVlfL1TYjzGl7p5lRlbLeY/PKoYGU1zh+O6SSrN/OpEACh5zdCjiaX1F9wX
 10F5ytQWr/35yIYScU1+wfb/FXGfzesWjbJw+ONWCVxkw/N2K4acqgXII037C7IvIxTz
 w53hUArEtPYy6UCyzCr0LqGdVkbrQh9ykoHg3nha6KhozDL9ufHSRwmhXq+LeVYUllPR
 mBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417377; x=1757022177;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QW+nLvV4rvtIb0C8gUiXVzNmuir38ZsWsYpP2QF+NY4=;
 b=om6cu4CHRMm0wRI9nHwG4fSr116U+sPi/2GphutEbUvezhTjKn+3YHlQbOxX6qVqCV
 ACndopFDHCRKtLvACTcYZUHq+LKw/PwB3aiK0qzXIg52B8Ed8geOtsV/YgNHqOb92tfw
 7uVA0CzyPhrJo1UaA3mAnx4CFDRbwFebOn6JVAMuD9R+RhSQ38mb8rKSUy0a88Sgpnwq
 WaQy2dkpKEYqSm4KWH5Sd17OnN6GZ28T9rn+RgSWx378TgycrwiBm4jvoL2FoyO/L9Sm
 AqKyPKaSCkpl7spbCFUpOUUC1FQHWeZJpP/xZGRhuZwDEq14YobpSvEClirv9MzkLuPq
 tCcg==
X-Gm-Message-State: AOJu0YxPjh3e1UOXGYnfGaKRMFDDy9vUsDINZ5G9UjIHyJmEoMHctYQf
 qiL150DPgk3OhEv1qnHI62p2brU1ngYQlpXHKg9Hh1b4inwqCQBNRmpeREIDmYSz6shtuI6C8s8
 YZZDQIa0=
X-Gm-Gg: ASbGnctjcIAXpfyZCE1ZPhxLdZjRel54B5UFSc2MRq8vCMLNitzVB/BIQlA978aWsRr
 ceqm3E2V45mmVE/Vagh5fvPtQVdJW6tY6dRfsaWehSJ8/0006xkMHgkMOBYOfgjDGZFlmm7ieFL
 rQ4DILtIOum4Z/gXH7B1q6Px0rjG5kAxenvCOfxGZzy44jaQqOs33OSnxkhiC+UjqjZPCVVRcks
 g+fSRXRGtOel7zakJ7bOtOUV9mySu8B6pr6xyztGlfofWuSXBxcoPG+jwCUR52GfaDHxQf3IOKy
 h9s5oqPaRcfzMClfaDMmr5UZtQHS8aP5/fOxdgqvjGLrUXOjQ0Xw4QTIGH1zQ9+cYrxqRDaIPI1
 lUblJkw24UPz6Hyfl44GVM8QANDNpYjeOjeOlxLarZ9ZOPUA=
X-Google-Smtp-Source: AGHT+IFta4sbssUWjclhW0AnBw7v04jEm0iVW4n+S5HG2ogxJt23VGK3Izlx/CXPxZCKLunLdMUcqA==
X-Received: by 2002:a17:90b:4fd0:b0:325:c92:4a89 with SMTP id
 98e67ed59e1d1-32515e3cad8mr28783004a91.5.1756417377428; 
 Thu, 28 Aug 2025 14:42:57 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327da90ecd1sm642429a91.21.2025.08.28.14.42.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:42:57 -0700 (PDT)
Message-ID: <de5dd7bc-647f-4783-a747-ff392d880c68@linaro.org>
Date: Fri, 29 Aug 2025 07:42:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/32] target/arm: Rename isar_feature_aa64_atomics
To: qemu-devel@nongnu.org
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
 <20250828113430.3214314-30-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828113430.3214314-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 8/28/25 21:34, Peter Maydell wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> This is FEAT_LSE -- rename the predicate to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20250815122653.701782-6-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h      |  2 +-
>   linux-user/aarch64/elfload.c   |  2 +-
>   target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
>   3 files changed, 14 insertions(+), 14 deletions(-)

Doh.  I failed to rename the usage in bsd-user.

../bsd-user/aarch64/target_arch_elf.h:117:5: error: call to undeclared function 
'isar_feature_aa64_atomics'; ISO C99 and later do not support implicit function 
declarations [-Werror,-Wimplicit-function-declaration]
   117 |     GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);

Sorry about that.


r~

