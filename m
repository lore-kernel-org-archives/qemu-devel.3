Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D5C0218F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 16:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tedAq-0004GQ-Bk; Sun, 02 Feb 2025 11:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedAn-0004Et-4L
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:50:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tedAl-0006z1-Bz
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:50:16 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216728b1836so58451685ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738515014; x=1739119814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfWR6CCUkfvwBhowYkTquNCMryS0fJ3GxILx53oTXlk=;
 b=CmlKM1DpFO7kToZbrhP81roILtdVnIXalO+8vQqg+6V3OqXyu/wJDuTW+pklPCxOyq
 Bb9Z4s4dSlvMCqCeeVmLtwaK08CzY0u7Ne2OIhtt+a1BHGechwCQuNy9en0dU1Egcg5t
 9ezwv63iajBheFrI8LMxXwt+wzA1BAdSVtOiPAYsTR3p13rT29l673qz4zXkOrj9kcZJ
 WoIR5DYy1BGpmeVktnFvQ9y1bm0tk2cmrNBa3nSfjjdTC9gzs7bBtqs2aIgI/rqqG1L7
 kfn008rzszkSpBb/Q6BtkZgclcppkLIzZF2V/v9mZCkoPkB6n1N/rDIm3Bkq/KkdN2Jm
 lqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738515014; x=1739119814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LfWR6CCUkfvwBhowYkTquNCMryS0fJ3GxILx53oTXlk=;
 b=oZwDORjaM+juWm6bZCYwK+1CrkegQnSuOE23G5oTOLS5cDGvlYKOiZ5QM2VigFmA/Q
 HYyvBNpO6stQKKsoozeUYO7zPRu44PoRF1CGqVEqKS1EqGyJciVk6MvCCXKGnGbTlVls
 fxYZFfJvvQa3HYvTfj9LRIcFKOxHo6UYBlWWhSDDZWRf10IwCOCChSNCM5AzIU4csCk0
 YEn6GIpt27TrG6C2jPz0gn4DYMZwq/omXmJ98WxB7lsdvbafLP41XXzqjtQxzfo+iXlc
 ClLgXee5HK1mqM6P+kbehd8ScmgH5WmUfhi2OQ4YCGpm8mNLZjkgu6LDPVbhqydWD5jY
 P71A==
X-Gm-Message-State: AOJu0YxU1lpnaz6q6to6JcVJDiaWxAQVKomS1RH60RWusPl3v0f0xd1L
 Umkp+tka9vaSbh5g3hYugKjAkxl/8ykEzQguSlKj53fIchqxryDLU+a24jz6WHyp5Z7hAi0geZw
 j
X-Gm-Gg: ASbGncs4SMznZ+zfdgSCtLvg63jkc6ny2H3sjdzYWIvF1qWOypeWDwm/VUDerq+jAqC
 1MGrYfY+CTcp6Sc3yPSaL4Xm8L/3xODgAzTY5Tn6Ii1gtYkx+CMnQp8O8d+BZtA5lIjxxIdelIB
 OUDSb8DJNiF9dvvVliMzGljP6mQ/bwjaB9fZGkZNv4W7U1Q3Rpir4HPQOhAoZFs81rPFRB2vnuO
 rk1fk9Qp9acFqGv++67MTAIHkis7nXanoPHbib/ZkRAkPlU7sqYgrb7Nhz9MZ/EGul3yKXx+fhH
 8tmx+hV+i22DI67KpFwsq0pVTP4/texTqjomjjAFxnHk0Do5E0tneHc=
X-Google-Smtp-Source: AGHT+IHjDsWKL3ijKU2EFd3fWxErFgbCnyfqRjsGf0lJEgyUYi9WDNxND/mlPt3EpfNHQ+hXA07EqQ==
X-Received: by 2002:a17:902:cece:b0:216:282d:c69b with SMTP id
 d9443c01a7336-21dd7dd8116mr286888405ad.50.1738515013687; 
 Sun, 02 Feb 2025 08:50:13 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f8489aefc4sm7244647a91.12.2025.02.02.08.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 08:50:13 -0800 (PST)
Message-ID: <f912995b-9fdd-4177-b86b-5eb6b5ef03ac@linaro.org>
Date: Sun, 2 Feb 2025 08:50:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/69] fpu: allow flushing of output denormals to be
 after rounding
To: qemu-devel@nongnu.org
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
 <20250201164012.1660228-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250201164012.1660228-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/1/25 08:39, Peter Maydell wrote:
> Currently we handle flushing of output denormals in uncanon_normal
> always before we deal with rounding.  This works for architectures
> that detect tininess before rounding, but is usually not the right
> place when the architecture detects tininess after rounding.  For
> example, for x86 the SDM states that the MXCSR FTZ control bit causes
> outputs to be flushed to zero "when it detects a floating-point
> underflow condition".  This means that we mustn't flush to zero if
> the input is such that after rounding it is no longer tiny.
> 
> At least one of our guest architectures does underflow detection
> after rounding but flushing of denormals before rounding (MIPS MSA);
> this means we need to have a config knob for this that is separate
> from our existing tininess_before_rounding setting.
> 
> Add an ftz_detection flag.  For consistency with
> tininess_before_rounding, we make it default to "detect ftz after
> rounding"; this means that we need to explicitly set the flag to
> "detect ftz before rounding" on every existing architecture that sets
> flush_to_zero, so that this commit has no behaviour change.
> (This means more code change here but for the long term a less
> confusing API.)
> 
> For several architectures the current behaviour is either
> definitely or possibly wrong; annotate those with TODO comments.
> These architectures are definitely wrong (and should detect
> ftz after rounding):
>   * x86
>   * Alpha
> 
> For these architectures the spec is unclear:
>   * MIPS (for non-MSA)
>   * RX
>   * SH4
> 
> PA-RISC makes ftz detection IMPDEF, but we aren't setting the
> "tininess before rounding" setting that we ought to.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 11 +++++++++++
>   include/fpu/softfloat-types.h   | 18 ++++++++++++++++++
>   target/mips/fpu_helper.h        |  6 ++++++
>   target/alpha/cpu.c              |  7 +++++++
>   target/arm/cpu.c                |  1 +
>   target/hppa/fpu_helper.c        | 11 +++++++++++
>   target/i386/tcg/fpu_helper.c    |  8 ++++++++
>   target/mips/msa.c               |  9 +++++++++
>   target/ppc/cpu_init.c           |  3 +++
>   target/rx/cpu.c                 |  8 ++++++++
>   target/sh4/cpu.c                |  8 ++++++++
>   target/tricore/helper.c         |  1 +
>   tests/fp/fp-bench.c             |  1 +
>   fpu/softfloat-parts.c.inc       | 21 +++++++++++++++------
>   14 files changed, 107 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

