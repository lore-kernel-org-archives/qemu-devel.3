Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3A1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx2T-00041G-7u; Wed, 18 Dec 2024 11:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx22-0003WB-6p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:36:22 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx1y-000333-Hw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:36:17 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30033e07ef3so11064461fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734539769; x=1735144569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rrSzl/ZANxSpzGhPycCpYwWwoO6roHsVBOPDc7jLSe0=;
 b=y+B1rUjNkO7Q4RNrET7h03SrRcjOn23jCzyntzlLIT+T+q5S0tY2I7y4RjvJ9VG4OB
 8ZjmRyPB/k5QJEl4MWxYARlmyDW7DJmbsEPKAYGco2FXejIQ4r5q+hNtlDv3KQlHq29C
 7XOW00oL+c8DvylSX7AFq5xfx+VIXRzp9O7MIRJopzknjY0lO1rtZTTuQ+u0X6Z4MVzy
 LzZJ5hylv1W7PUM783WJt8PUgiaWhO8Cruvv6jNAJBvqKMb/0MRoecriVKIPPt7WmD8Z
 /UBvdiYASbRab6DcYhWi9aytWu9BnAMMUXkCdA00GaL9oGrst0euUxM6bsgrDQXaXsqC
 wrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539769; x=1735144569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rrSzl/ZANxSpzGhPycCpYwWwoO6roHsVBOPDc7jLSe0=;
 b=tCl96uXflMZ7LzYvVRQ3CcMLIm//S6eoQHnt22gqXfu3l2xdI54/A9eDDPf0AozOkm
 HKaGAm1fq5IWZsB5Y8mmj0A6+IREwAOaGidYWzlzfk85CyuXT8N+aUhleeJ+/1DaBzZc
 W1cpK+HT13KoDYz54pYJbkK7roHqw4yBVOA2zGfUSyp0104yzKd2FwQ95nLNjqZES7dU
 QiNZT9RB0N/LYwlbKNtpEJDt8qDtDCy1zLxs0if2ytIqngpGkurWJp5xYcX5lZ0TiqUD
 yISCvLmlInJXVE9NuQQ/ppnuDTBmHRZRd6ehR/00VYXs7r24eSz4C2sHboL6Ne+quYxF
 RaGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc5Sovho/g8kFhXmchSDMlLEZatOq4ZpbYQf/cl+EHPqPop+Yky6WQDq8QYTQH3wdH1DlVmP9N5ZGs@nongnu.org
X-Gm-Message-State: AOJu0YxgonM0W/ph5uhRJuZ9Zh5mpwu1fM5jKAKsKLrkGXy98DBJzObK
 1YCYmmdlcJDvNuxRAg4/5FGpnRkdmvbYzYpbXz+KQJvXVh9gQxzVKdf+VYN2C+w=
X-Gm-Gg: ASbGncuvDWM85tMl3IGLiZ9GO68xDJwmGWpmJhzXRpfPEutmJq6FC0YskUuKrgmS/q7
 VF/GCrPbvlpM11ktF8IrUz3WXZRtGAsYFwDLaaYKq1T8SWDZjJpf/HTg0Yt4QoDupCMq2knLPca
 H5c0a8eL7FTWtC+57VIhmIyUFxrsdDYqcJ9wuYiI5Y1Ep0mkYwBIkz2QfnHCb+oGq/y3KcMVaGI
 1Tce0HP1l5t8vlVo78zc1DC+wPl2XpASobT59q5DuN82UHUqyHPreqZQa/72jzFOd56LhVAAlo=
X-Google-Smtp-Source: AGHT+IH6o7g3vLCPAlgQgYZtqUBD0Njc5xJA3GMfaxdFtCFJ5/uURHsO1CqCnpPPemk8lhMsG63DQQ==
X-Received: by 2002:a2e:a715:0:b0:300:1f5f:e24f with SMTP id
 38308e7fff4ca-3044e6f7593mr9553541fa.15.1734539769106; 
 Wed, 18 Dec 2024 08:36:09 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30344176152sm16151791fa.81.2024.12.18.08.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:36:07 -0800 (PST)
Message-ID: <b1561e17-63a7-42d4-9d8c-3cbb3c9dc60f@linaro.org>
Date: Wed, 18 Dec 2024 10:36:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Un-inline translator_is_same_page()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218154145.71353-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218154145.71353-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

On 12/18/24 09:41, Philippe Mathieu-Daudé wrote:
> Remove the single target-specific definition used in
> "exec/translator.h" (TARGET_PAGE_MASK) by un-inlining
> is_same_page().
> Rename the method as translator_is_same_page() and
> improve its documentation.
> Use it in translator_use_goto_tb().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Richard, I'll merge this myself once reviewed.
> ---
>   include/exec/translator.h    | 15 +++++++--------
>   accel/tcg/translator.c       |  7 ++++++-
>   target/i386/tcg/translate.c  |  6 +++---
>   target/riscv/translate.c     |  4 ++--
>   target/s390x/tcg/translate.c |  4 ++--
>   5 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

