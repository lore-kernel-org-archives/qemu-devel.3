Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192C8C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5Z9-0004iv-NP; Mon, 17 Feb 2025 13:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5Z7-0004iS-2s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:09:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5Z5-0005m6-BP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:09:56 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2212a930001so32595045ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739815793; x=1740420593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JF4pXfMh5kfmGZUTEkbTcW2kIa3fO1pwQ5jP3VYExmM=;
 b=A6SkT+febfb5EBHNWGXDNHYrd3Y2pqR5F9x3SYFXeEJjEJu7cQqrYdxoXvIQuNumxZ
 VVcnoLE+00f+op3TGuIGA3qOVKOxUNOMQy5zxOZmDzA3aM7OUJ9vzH0tK3TGmGpEay2p
 fvQSe5Uc68apnfaBAEkT9EhDmdu6aZu7gtaabl9e6kj4ef3QB1/NR8v8QJpKctUMBljb
 b7Dhr+MJNkzC/8zIlCin31Nroc7mUw5qLvDh/Jgpr+O5qSZqweDv75+jw68CjzDw10d4
 tlRacYsGi5S8E+h0THh1E/amW48Z2pGBipEm+mgS9NWr0iNchLjgOyyiTQVqmOSmH7i2
 jCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815793; x=1740420593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JF4pXfMh5kfmGZUTEkbTcW2kIa3fO1pwQ5jP3VYExmM=;
 b=tW1+vFL7I6feKXbJ+BLGS/9cVEc/sm0i1YiM+S5GJOxk01BmTg7+OkXUk0iy19Q5TM
 yCToTLlVF3Z0HywHXdbXiffJn5L5miI5mo5X9I804sp750wqWGcpumbb4dZNJ9Wb4c2U
 IIW8MqejLah/KykEIB2+ot/AQ0ygaxMA+7epBLBpRV8RnN2vm+rLW4rAUYAqt77vklZv
 xRfxoHFM869Bgr0MlPqok7rtE/hrwNMJkF1IIMn2Vwh0AH4MOFCGHgWulWoSCzVo+hYI
 KbAn+2c1IN4pDzzCOomfWzUJ23sJLSZjLaQbhy6ZXNQjlzEW94WTjBnwieET+2ctb2r6
 cu4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc1r5cgUXTRzRxkmJTr/VqfAbJG0Lp6bJ67AzlDDwQZhJyXbfz7hFeN82xIMmXGPoT5aIbg/TaUagr@nongnu.org
X-Gm-Message-State: AOJu0YybnQrBW+tVD2LKr7OHxnkHmW5YxeHROlylnkxU3hwb7SnohY2v
 O1e3zRuqoOhFwzWEjRpQtM8odLGjbLO5+PD0NMghXPq+4rOpD0c+ScxuV+1GD70=
X-Gm-Gg: ASbGncta9/WXfrrC3TFN1osQNyIf+qW+Gqunk/Lp33keBMFcxKPzGRe4W75odUJJsLn
 UNdmUW2ykck7vddWXaeeNr/LjwhIgVtIisTNKSRTvZFGNnY+y8I9PCMHale9Yd9sEAj0xxz5kAl
 vFXHPRZDJpPQVwhv3j1eIkfH0EsYPBULNZEc/AIFrGAOkzC2wEa0cQUDJpfm2D8Eh+9SHx1RZ26
 EA5JlKjZm+jU8aWYMVoLzud4BqeIq/PN5gF0EYAAaWTNgwb8dphf0DTkb6zaGxVyTg+8fPQs60B
 T0QDpVYHznYkK6Ld6ru44gojRByhD5PqX+ltLSM5LvinQjka/NjYy6w=
X-Google-Smtp-Source: AGHT+IHIujYbeOX/8+kQ88BahA7EF9lDJtDNbH9gCjOyTYL0u8Supow9DhXoAeSLjw8gI6IECNPfIA==
X-Received: by 2002:a05:6a00:2d0b:b0:72a:9ddf:55ab with SMTP id
 d2e1a72fcca58-732617b5545mr14602814b3a.10.1739815793331; 
 Mon, 17 Feb 2025 10:09:53 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273e2dbsm8682021b3a.98.2025.02.17.10.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:09:52 -0800 (PST)
Message-ID: <59212e7e-f284-4046-86fb-edf1770470fd@linaro.org>
Date: Mon, 17 Feb 2025 10:09:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] fpu: Make targets specify floatx80 default Inf at
 runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-2-peter.maydell@linaro.org>
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

On 2/17/25 04:50, Peter Maydell wrote:
> Currently we hardcode at compile time whether the floatx80 default
> Infinity value has the explicit integer bit set or not (x86 sets it;
> m68k does not).  To be able to compile softfloat once for all targets
> we'd like to move this setting to runtime.
> 
> Define a new FloatX80Behaviour enum which is a set of flags that
> define the target's floatx80 handling.  Initially we define just one
> flag, for whether the default Infinity has the Integer bit set or
> not, but we will expand this in future commits to cover the other
> floatx80 target specifics that we currently make compile-time
> settings.
> 
> Define a new function floatx80_default_inf() which returns the
> appropriate default Infinity value of the given sign, and use it in
> the code that was previously directly using the compile-time constant
> floatx80_infinity_{low,high} values when packing an infinity into a
> floatx80.
> 
> Since floatx80 is highly unlikely to be supported in any new
> architecture, and the existing code is generally written as "default
> to like x87, with an ifdef for m68k", we make the default value for
> the floatx80 behaviour flags be "what x87 does".  This means we only
> need to change the m68k target to specify the behaviour flags.
> 
> (Other users of floatx80 are the Arm NWFPE emulation, which is
> obsolete and probably not actually doing the right thing anyway, and
> the PPC xsrqpxp insn.  Making the default be "like x87" avoids our
> needing to review and test for behaviour changes there.)
> 
> We will clean up the remaining uses of the floatx80_infinity global
> constant in subsequent commits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 12 ++++++++++++
>   include/fpu/softfloat-types.h   | 13 +++++++++++++
>   include/fpu/softfloat.h         |  1 +
>   fpu/softfloat.c                 |  7 +++----
>   target/m68k/cpu.c               |  6 ++++++
>   fpu/softfloat-specialize.c.inc  | 10 ++++++++++
>   6 files changed, 45 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

