Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7362DD70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGieS-0005t4-Vx; Thu, 28 Nov 2024 12:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGieR-0005sW-KF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:50:03 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGieQ-0003ST-8q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:50:03 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6882c33acso38431385a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816201; x=1733421001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Il86g7favyiV4mzRUzJ1MkQP3ZltQBmZOtmp6q9wD3Q=;
 b=Z8LHcoDH3rUHSfgBqjAuiu2boL0fJm52P1fOCMur+HfvFujzwVhbjNUXNBytsgxFpM
 s0QUVnIZJ323iVvUwxLntwfhAsuQhoxQpf3Y1IFD2SNkl9f0LLDbj8Rlo5d8n+P7NE4X
 sZOZaTXxbQ1rNvm9v3QVDCN8xQoUrxmHFf8mTvuFUBYUfbnBvMh8r61sMQIe0kyMYx7B
 wcJUa0kCIAvGfhMXUgmC1Q5bb+F7ZigeEDrCrDSE8YBXUP2+8uEChcdtO+bry1VIXjpY
 9jjWqUTk+YvVxqhF3r91t5Ui9QUSMO6dN+4QfZNl7m/PxV/yZCnMBIT7asibnHGwGH1A
 fs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816201; x=1733421001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Il86g7favyiV4mzRUzJ1MkQP3ZltQBmZOtmp6q9wD3Q=;
 b=Q6VKrOWJDshpo5pp2nKe2fHvuBBij7TIpryug1R0YDQNiSkAIO8kjI5V1wcPVYnOjx
 zuf43aZIhcXxaHCxf9HJczsMG8D6fHUEv/AX4XIjjMiUbdPxx5RE+oGeRTLEgvrHgkit
 xiW4l02fjc45iB9Y37F3RO3ZXcxIObko+Lu0nfpR8LmV/lAdRM07VxQFKqgnzsMI5oe3
 x6bXYzWdeTY2fuC9ufWkm0fV3pViLEaMPErHmbGC8++lwQY1JWYpkpq5vqv7LHyCoKPX
 rIhVZD+qENe94Ya+gboI5Q+/kxNnxn4Tu4/4FPGLCNNkQqZ7vD5jCbjExR+cac9d27Ns
 K9uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgyerddsU+o8Ou3C5ymvcXTyR5FuJYPUbQFPeSABF6ueoB6l0M1wPKcmrl+KddI6mRfsJZmhTceuH@nongnu.org
X-Gm-Message-State: AOJu0YyO0Zui6TaClwKr+E27fmj+rsIDu9mDmIsK/NciqFz/Rt5wLQMq
 QEhgnlA/TBiKGS5SE7BuYgw06gZRDjny/opEQXG3zH+bKMpmTlciOXevZZzphQ17XiZq3WgAuhK
 SoLE=
X-Gm-Gg: ASbGncuj29v0YqQsof/FdAkU61q/eK36Bv8qY6hwM69RYiwjYrheWcxFxDEOThDd5Yp
 CWZBZ9aNI7F+OZoO9UUjseGdiQmv2UyJClk9wy15e+5S6oOGVlVKI1wsjgqsOyT1DFKWK65xIfZ
 XieJIxLT6DAjmZbV38dfrbBLNxt6g/edTs7MtOaE4TZnj+ufa3hAH6emZLuWxGzdj/yLLLzq5/T
 A/1ExTLHcwmzE2cbr+lLjauBp6H1GbVi2qaShpg03kEgfRyawGvUbS2tIvxC/gw38o=
X-Google-Smtp-Source: AGHT+IEe9OxZLuEYb3C9t7wnfyIhn8PHLBRUSXPrYjNQN5c6GBUT45mF1nfPnoi0IyXWU3KZ8i9Mxw==
X-Received: by 2002:a05:6214:130f:b0:6d4:2910:7f12 with SMTP id
 6a1803df08f44-6d864dabbc7mr102345656d6.41.1732816201208; 
 Thu, 28 Nov 2024 09:50:01 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d875221e88sm8503396d6.110.2024.11.28.09.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:50:00 -0800 (PST)
Message-ID: <41d8860a-04b7-4d1e-b242-87b5c9d0f8a7@linaro.org>
Date: Thu, 28 Nov 2024 11:49:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 15/25] tests/fp: Explicitly set 3-NaN propagation
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-16-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:43, Peter Maydell wrote:
> Explicitly set a rule in the softfloat tests for propagating NaNs in
> the muladd case.  In meson.build we put -DTARGET_ARM in fpcflags, and
> so we should select here the Arm rule of float_3nan_prop_s_cab.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/fp/fp-bench.c | 1 +
>   tests/fp/fp-test.c  | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

