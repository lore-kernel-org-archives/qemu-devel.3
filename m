Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2437C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWhv-0007vb-Oa; Thu, 01 May 2025 12:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWhu-0007vL-Qy
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:18 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWht-00026b-BO
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:18 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso813102a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746116656; x=1746721456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8shYTt0huEPDIa1HB4ziLet0D+S6VQEydJTXu8w/URY=;
 b=nusnSe2T7hHvpaNYFUH7kzNhOwVX2WDve9LCOgJWGqwUeXN1KxwhjG/wU7vrB8t/bw
 9WqEIq16fxW6J8AmJY98BhMs8Dsn0YnoGx8nGpdDKUI/A6CnAX8MONcu467+sJqbhq9a
 Elkl4594y0dmFcIgRPjbPP54tWjz5UWFDbZgTtptVntPsZAIwx1iSWE9y/WR8JUgPXjv
 2lD/DELQlFuvOvBj0PusSf7RiUlY/P+CfaESu/7npCQWRpQGJBD5tFP6ORw5OATAfU5N
 9AaivqNPFgGaWswRG+XuxbiA9Gubjw4TqsZ0tE6HVhIqF9fl4XDlZiwGRus5fjX8zJEP
 oF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746116656; x=1746721456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8shYTt0huEPDIa1HB4ziLet0D+S6VQEydJTXu8w/URY=;
 b=EiEKZ5ScvpS+W6D1ojPxv/YjBTuvNrgALLJx+tHA5trFT0cJpkgo4+M32GWyK6PnZR
 3EOdp8eaSrlbmjN0lLWcW1T+gV75O285afvaGUay3qADX/TLByFaQAgJ1gcRXd6J6Dj4
 trb/jFmZ/LNucj55fpSV3FjBnn6aju6NtV1L6h1DBXjltllBWF8noqDhMHsSPqVMgU/8
 tMqI9HAaK3SdIvnGXfXlMIli0+IXTKqOSlocXR5BteagMhmlcRcnNWfg4jMMdH1MGld7
 mxA1l5ROt0eL1LuvJ4czxUCYQqObnpeZxJTVzPl9poFMOBig+4awsDOlhv9Jos41JcyI
 Sixw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDYRoTs5g+nTjUL18KoNnAC0JbML99OsyGNR9lIi4nLWimaefo5MryfsxtgIX33Pu/PvoLnd6ZBFX@nongnu.org
X-Gm-Message-State: AOJu0YyQRojbPR8C5Zirb312Dp4yEn9NWI/8FiiQ3U+dH6SGk800ID6t
 jiPh3vmCZTC2jNqzcUQS3iix++MLlH8MZnNxh2gPntIxVjQIyOBEV5d7rWPHFlg=
X-Gm-Gg: ASbGncvixuOKTQC1a0iesCNyiB2K9LDuhoCBAkyMYMPjk8fcIBLfiV4G3OWyL0F7eqb
 K04N6bvzfmc8kr7pFmmleiD+9U4sdNr/CFbluNKZmRU2lSaVjMzSyHyIH76XwI8sfQxFNqvlXh9
 SkscgXdrfxiUttbaghrQ81DuqtInGJdNfJKFIJjoqOt3cMU6lzbrmbAnxS4sL5dIiW7BzAnKbLh
 +7JcY0uHxMdyJG9ACI21SkbFepuEu8JAUfM8nE/bm57MWOKvpVv4tz9/C9rA+1xucX9Z4UnxowU
 A0sJ4T0e0v7qpu2Q55+4LObGJGM4BGwIqgqbiINwf9eNqS9QiQDY4rWN2d1cZXmwVtdquKgtPLG
 GIFGEebMH7jxCEt4HsQ==
X-Google-Smtp-Source: AGHT+IFp9RYUi3DTgZBnQQd1bJeJF3D8RFCuafFxfdL4LtCEbdgaydTH3sWqG75vv9BY+KKGRU4EGA==
X-Received: by 2002:a05:6a21:6d8c:b0:206:a9bd:ad7b with SMTP id
 adf61e73a8af0-20bd6556ebbmr5219945637.7.1746116655846; 
 Thu, 01 May 2025 09:24:15 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d6432aasm908860a12.50.2025.05.01.09.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:24:15 -0700 (PDT)
Message-ID: <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
Date: Thu, 1 May 2025 09:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/33] target/arm/ptw: remove TARGET_AARCH64 from
 arm_casq_ptw
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 424d1b54275..f428c9b9267 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -737,7 +737,14 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>                                uint64_t new_val, S1Translate *ptw,
>                                ARMMMUFaultInfo *fi)
>   {
> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
> +#ifndef CONFIG_TCG
> +    /* non-TCG guests only use debug-mode. */
> +    g_assert_not_reached();
> +#endif
> +
> +    /* AArch32 does not have FEAT_HADFS */
> +    g_assert(arm_feature(env, ARM_FEATURE_AARCH64));
> +

I don't think we need an assert here.

The ifdef for aarch64 also protects the qatomic_cmpxchg__nocheck below, because aarch64 
guest can only be built with a 64-bit host.

Are we still able to build qemu-system-arm on a 32-bit host with these changes?  It may be 
tricky to check, because the two easiest 32-bit hosts (i686, armv7) also happen to have a 
64-bit cmpxchg.  I think "make docker-test-build@debian-mipsel-cross" will be the right test.

If that fails, I think you could s/TARGET_AARCH64/CONFIG_ATOMIC64/ here.


r~

