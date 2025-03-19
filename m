Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08802C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwQF-0003Nq-9n; Wed, 19 Mar 2025 12:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwQC-0003N3-0d
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuwQ8-00075W-7y
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:37:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225e3002dffso84466235ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742402250; x=1743007050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FBQ4RbacdNlIWVlAWfxFdZUCRxHPOx6BatCtIsFEyNM=;
 b=ICCFqhvxmOzCsHuqlwwpt/xoWrfCPrCqZN+HpP61Nb5ySNPWOedoNpNtqt297rTDdL
 WFEHubQBZycRNPYkzcntqzBtJBphs5fYeAoTTBmA8JwsMoGH+ByTi1Q4E/wQxzsSi6CW
 kS1pDgeJkYc+VLhoBQks1jZYBveVtzsv/tsiqFpPIq0gBZ8RVXPTi/+Ab+GYfdm+fsn6
 Zug+S7Ozay2s7Q/NteZ17H8WysDfo2J+Jy6tvdNagf2t04z2TCEdC+cKqxnm9jxBdGE0
 d3F0FJ8E6bWio+++nYVYqw/CNTdR06auZWkcLjc7DsypolDrqXOkIRHoBpPql/r0Dc8m
 xPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402250; x=1743007050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FBQ4RbacdNlIWVlAWfxFdZUCRxHPOx6BatCtIsFEyNM=;
 b=PcfoU7a+Z8Mxx8WJUBmW+9fMbjDHFAvLc+ACYko2EqD6z1GVMZPxjOyxjPViS3rLsS
 jLgADeh1AIptcePnWpNEkSSULYuuZXumMoaQYlAKFqt4Y4h3BryCK9jKJxULhNwTqNZK
 gpsm3PU9SK3/bLUyda3yGiU2bps9PE7zuw17LDRw50BF6dm22dISaBXAsXCaC1/AN2e8
 ckXXhnUeKQAIi1M50WqmNmygBi8O2TIbBzQDBC1Vsc+vf2mVPjOu6YwiKd4OfKDxkGeg
 9oIP1XWHGMcCJ7s/VMaFUjndKXOI8j9tdq8+xOf/BDwEKXss/iJjWGtkrg5F5HrD2+uV
 H7Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI/KOWB12kqnJ/itCms/b5azqS0Efi7AIJh+LsRcivmgnvdGWzpeuzBSW28vAVf6TTXc6y5PFFZ3nO@nongnu.org
X-Gm-Message-State: AOJu0YzAvmiQCMzOCFac9ZQoQSaew4A+9UxbBwZhHjWdIlX25y/5APU/
 vZeRKCCuDsxit13atF68I+u/60Jj2EkrPtOUSudDf82wLhUXJ654AZUUbYrXlP8=
X-Gm-Gg: ASbGncuDGccxdEUmoQQPwXqbJRFetQWkfX4p9avP1n4OFkPrkdaHY05+61G0Jnp4S9h
 t9p+XroiE6s6qawgqXlgNWpjO8FRND6ergxZGha5LPG1sDA2iG1F2EYCoGZalTjHz+jSx6X9SM+
 vgCgcUYRSgsusTuroe1R4HzH9bXWik4fP5tDIxhdnUYNpAKjwX14vH9EXfDrhcVOd3y0N9S9pPz
 zf+700BpaQ0AwTGOtY0VGbaZDTP7eCGqrHUXtFp+FQgvbXUbgzBFA5si7wBapDyCEuXc8hwV+jZ
 F4rWGbpEhU91+0uBbYVW5HEByK/werwQaWk41MK1aMWCxgw4r6wt+CWMG71GngSK5PMnHV7SZMG
 UCueFm5Sp
X-Google-Smtp-Source: AGHT+IEGDOlPx8t49e49zKBojmqH/b0jKa+Av41VFyt8fDS5Txihz+2drltcmixmlnJHYd+pzDX7GA==
X-Received: by 2002:a05:6a00:228a:b0:736:4e67:d631 with SMTP id
 d2e1a72fcca58-7376d6ff97dmr4831230b3a.23.1742402249600; 
 Wed, 19 Mar 2025 09:37:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167da28sm11882337b3a.89.2025.03.19.09.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:37:29 -0700 (PDT)
Message-ID: <a96a4e89-3cb4-4dbf-9b3f-c53480606e73@linaro.org>
Date: Wed, 19 Mar 2025 09:37:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 10/12] tcg: Unify tcg_gen_insn_start() to handle
 1 or 2 arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/19/25 06:45, Philippe Mathieu-Daudé wrote:
> Merge the tcg_gen_insn_start() definition using 1 extra word
> with the definition using 2, using a2=0 in callers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op.h          | 16 ++++------------
>   target/i386/tcg/translate.c   |  2 +-
>   target/m68k/translate.c       |  2 +-
>   target/microblaze/translate.c |  2 +-
>   target/openrisc/translate.c   |  2 +-
>   target/sh4/translate.c        |  2 +-
>   target/sparc/translate.c      |  2 +-
>   7 files changed, 10 insertions(+), 18 deletions(-)

Nack.

> @@ -50,7 +40,9 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
>   
>       tcg_set_insn_start_param(op, 0, pc);
>       tcg_set_insn_start_param(op, 1, a1);
> -    tcg_set_insn_start_param(op, 2, a2);
> +    if (insn_start_words > 2) {
> +        tcg_set_insn_start_param(op, 2, a2);
> +    }

Not this, where you're passing unused arguments but for some reason are not storing them.

If you want to unify all callers on 3 arguments, that's one thing.
But conditionally not storing them?  That's just weird.

If you *do* want to unify all callers on 3 arguments, then you can dispense with 
TARGET_INSN_START_EXTRA_WORDS entirely.  Just define TCG_INSN_START_WORDS == 3 generically 
and drop everything else.


r~

