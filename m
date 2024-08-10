Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A436CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 11:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sckQY-0002dx-DY; Sat, 10 Aug 2024 07:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckQX-0002c8-1E
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:38:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckQV-0006I7-0s
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:38:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so2573867b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 04:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723289905; x=1723894705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFc8Sxs1W/r5mzfQK+iP1Okx2ROhixQYGlB++ayF+KA=;
 b=ZfeRtLQbQljo5ESj+MlFTEj+8tBgNkFhfoPvD52PS++ij9oEtzMpEMzWP3rEt5mClK
 VBz+yd572NvNAvIVqmfs2QqQgkdqpE+mfM8g5B/ftfO+xSRXYcT4FSopUUN1lbB35zxo
 7ShjpMVSCaMSATEFP6Ibio7s0WbPg39Nl4FyZZTGiAEVQ+CB00bWmy07R+YmhzYoKv8I
 GmHo0HT0QjEs4TDn5Li6M0bkXm4zoZpIkfAKBrb6YUsDKhlmCwAuDkEFyRporQFndDbo
 ndKEQG0oRO4GUujcZiijh/6IgXtO2vAin2csSjQy1gZ07AD+NUjiabCmPqMVaqvwpSRE
 u9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723289905; x=1723894705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uFc8Sxs1W/r5mzfQK+iP1Okx2ROhixQYGlB++ayF+KA=;
 b=UXBp9Q5ya9jgLGgVsqbHuQNXYspV5YoVIJ6nXDM482GM2OK9M5noexTegPAU+FsVY4
 0KjHrs9UmCi4QZ+N7GcuzwAHjxibkGFfpvuhtOjjyAelOd4+cCQQca7H3EW20bynskif
 Wcw3ueWj245w4ecZhnMwo78jZE2nBkqG4ajwWltABzHm7pCSGYuw/z56ek9xW8c7wy5B
 ZiPY/iqnGLifktKeojRi3HFrMEzBffcKi4asaRhCoR5mCf714d9fQN4OpbLSZ6p2MJf0
 wwgHRyJ0UeuxoHC+6+lryB0DPmM1bS9YS/eWWM5FPhjEPdi2kgyhbwuolJLSHefqjzBy
 4hNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDmWk7zfttgAV71GyEtXdnTlSt+tOy9j9TMAM/ERJU4LuCOpNntR/VXT7wMCoOkRA8oAlsik23Qs8l@nongnu.org
X-Gm-Message-State: AOJu0YxIrbAHHlw14me9FZEcR4Z8DE1k5KMSbil0wYcu7RKYhysSIQQi
 Fx7toKg1bW3iZK0p1WraV9ZjKPPhVwj0i5ethsVRlxQygbQFfD2Ttmru3YZd1OE=
X-Google-Smtp-Source: AGHT+IFydxl6S85QYyWLPBt+xXpjMNO2OnQ72h1T1PK1NuefIiWXcSqoB2Zzi1ODmuiV4ky3YUg9Qw==
X-Received: by 2002:a17:902:e54f:b0:1ff:5135:131f with SMTP id
 d9443c01a7336-200ae5ee46emr80933685ad.25.1723289904677; 
 Sat, 10 Aug 2024 04:38:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb9b16a2sm10391955ad.172.2024.08.10.04.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 04:38:24 -0700 (PDT)
Message-ID: <f0838b3c-8cc8-4333-a240-ecc8395555f9@linaro.org>
Date: Sat, 10 Aug 2024 21:38:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Fix usage of MMU indexes when EL3 is
 AArch32
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>
References: <20240809160430.1144805-1-peter.maydell@linaro.org>
 <20240809160430.1144805-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240809160430.1144805-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/10/24 02:04, Peter Maydell wrote:
> Our current usage of MMU indexes when EL3 is AArch32 is confused.
> Architecturally, when EL3 is AArch32, all Secure code runs under the
> Secure PL1&0 translation regime:
>   * code at EL3, which might be Mon, or SVC, or any of the
>     other privileged modes (PL1)
>   * code at EL0 (Secure PL0)
> 
> This is different from when EL3 is AArch64, in which case EL3 is its
> own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
> have their own regime.
> 
> We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
> do anything special about Secure PL0, which meant it used the same
> ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
> where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
> controlling register when in Secure PL0, which meant we were
> spuriously generating alignment faults because we were looking at the
> wrong SCTLR control bits.
> 
> The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
> we wouldn't honour the PAN bit for Secure PL1, because there's no
> equivalent _PAN mmu index for it.
> 
> We could fix this in one of two ways:
>   * The most straightforward is to add new MMU indexes EL30_0,
>     EL30_3, EL30_3_PAN to correspond to "Secure PL1&0 at PL0",
>     "Secure PL1&0 at PL1", and "Secure PL1&0 at PL1 with PAN".
>     This matches how we use indexes for the AArch64 regimes, and
>     preserves propirties like being able to determine the privilege
>     level from an MMU index without any other information. However
>     it would add two MMU indexes (we can share one with ARMMMUIdx_EL3),
>     and we are already using 14 of the 16 the core TLB code permits.
> 
>   * The more complicated approach is the one we take here. We use
>     the same MMU indexes (E10_0, E10_1, E10_1_PAN) for Secure PL1&0
>     than we do for NonSecure PL1&0. This saves on MMU indexes, but
>     means we need to check in some places whether we're in the
>     Secure PL1&0 regime or not before we interpret an MMU index.
> 
> The changes in this commit were created by auditing all the places
> where we use specific ARMMMUIdx_ values, and checking whether they
> needed to be changed to handle the new index value usage.
> 
> Note for potential stable backports: taking also the previous
> (comment-change-only) commit might make the backport easier.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2326
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This fixes the bug with the repro case in the bug report, and it
> also passes "make check", but I don't have a huge range of
> Secure AArch32 test images to test with. I guess it ought to go
> into 9.1 as a bugfix, but the nature of the patch means it's
> not very easy to be confident it doesn't introduce any new bugs...
> ---
>   target/arm/cpu.h               | 31 ++++++++++++++++++-------------
>   target/arm/internals.h         | 27 +++++++++++++++++++++++----
>   target/arm/tcg/translate.h     |  2 ++
>   target/arm/helper.c            | 34 +++++++++++++++++++++++-----------
>   target/arm/ptw.c               |  6 +++++-
>   target/arm/tcg/hflags.c        |  4 ++++
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     |  9 +++++----
>   8 files changed, 81 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

