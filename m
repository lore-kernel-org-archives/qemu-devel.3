Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C909FEA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnq8T-0005Jq-VI; Wed, 04 Feb 2026 22:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq8T-0005JY-57
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:34:29 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq8R-00051X-Fi
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:34:28 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3532aa9a77eso181497a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770262466; x=1770867266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hyOnQ7dOiOMn7BXxCQ4LSW7EVqMgxa/BBy+rQ/7QIfc=;
 b=a4gBvvl3RU26E8uAdnCRmBtetIARoC9tUQsnalTZjLWW9hDpexvTfNMkZRl62irbk3
 X5PhVUy0a4H2aCBy5HfO/tkrBDhjCzCsjBzheTBDwZsO0jjXUVAPN84JIlH4hq5i9rVd
 sdsEfd1IdjZwIKYcVWZQlPa9p3m8PjSZoFlSoV/KD8ic0kzWaRWHeeMBx6IMHc1f9OLk
 f4K+F1lgePpA9DQIGyb5sGnHMwuC0lRAZwA7Gv/1cVqxpI6QSCs2I6yBTP2p0n7BxTTQ
 ew2lXEXT7xKNICjSSIvKyD3WdSgmi18YQRtQZcsgFV3zCQO6CNW1yAOfd4UUUz2p9MSC
 TTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770262466; x=1770867266;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyOnQ7dOiOMn7BXxCQ4LSW7EVqMgxa/BBy+rQ/7QIfc=;
 b=KWuhCRZ7s5rwriqgFExNwDEN0BYU9xvYLyt17K0V4s9TtpQc6kIy5bqURbDJOc2NcM
 7vtNNpeFZsKB9f6yv5T45qxQ4T4wwELGyobcFr7Z0Q7rMq8vegyWH6Ht2i2rLUYN99Oq
 HfSCXJu/pM1AWJUiMB/5NUulwAGA0n/Ke0EaRAxJxo3bJctywZwaWF30l+NNZsK7dN+p
 Vb7ws7NbTMt/C7JwuokvJqSb/YSeUeKDsivkvmDz443hTXf9N/Y/qyGem+ooCrMR/2Xc
 f9RgaKy4IYIArDV53h51cVkXlzWuz1dfe9R101KhhhxC7tMLmo00sCqp3yxNmuEcgISF
 ilnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVykUR3TOW6izSbWoaNNw78BFym1ChtA/wugJ29oPHyKDE7ev1WOAzMOXOpKA0Q1ZrZNrM+p5MyH2Nr@nongnu.org
X-Gm-Message-State: AOJu0YyzPc2IbVWPgwqsYxYV+Eu8327FnzwcCD3Cndb+JNuyrPD8z/kR
 6FBIkOqn0ZIOf1PH23pJ82Rilt6nXbOloyDs3oGzm8VmEXHWoYmv1uaHeGAqQEMXqI4=
X-Gm-Gg: AZuq6aLRwxpJb576ebk9GKNH59dB86m9BmQgLPEoMcIDQsyi1Z2dCf+lsCeuTd4nYR0
 XD5jgaJy4j6hfwEIx8/MKnS7gNZ1PR0bbK7L6yzUMEKiS+qqIfa7ivbbH46eSd/BphZ8FqEesGh
 IYnLIuET7IojpWjImCK2IlV3pw+6KN9cMyYrVtOlOUL/wDu0JouYS2Owmix1AYtALk86vrm3B1l
 l6GFJGNqS/LMeLQUNCKHiE9M2+PtND+b6fipfXv5oUU3X+pnV7xMH6RqWBO6sUxoRYXAYQK19PY
 dblb+41+GkK7/zlscDk+ywPYSw7xh8+VX4ESbcJyafZ7EPsWpf9+fau+Ha32hEqH4jjHIwO+Dr+
 FybsPrRfZLpepIrK8+pvPl+cNKwh6GKxtV9vszwRMFnlW6nTwOXudnXPG1G2xK8WPLLq20GsEoN
 cjPbcavjTI345y9RWgCetRTGSz2QdjyxndA7y+Z+h12CoRGv/Xn0od1JpBXb389gxSXOcxBiH7r
 KE6t7VtfoiZuW8Y2CezZ1QxYbOOZ1VAlFKzVlWOaA==
X-Received: by 2002:a17:90b:5188:b0:354:9c20:83e5 with SMTP id
 98e67ed59e1d1-3549c208652mr1484874a91.15.1770262465726; 
 Wed, 04 Feb 2026 19:34:25 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c239c67sm825542a91.16.2026.02.04.19.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 19:34:25 -0800 (PST)
Message-ID: <9db1d65f-5363-49bf-b135-bd3cb9d640b9@linaro.org>
Date: Thu, 5 Feb 2026 13:34:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/19] target/i386: Fix pseudo-NaN handling in
 FPATAN/FYL2XP1/FYL2X helpers
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-5-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204051756.667397-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 15:17, Max Chou wrote:
> According to Intel's x87 FPU specification (Table 8-10, Vol. 1), arithmetic
> operations on operands in unsupported formats (including pseudo-NaNs) must
> return the QNaN floating-point indefinite value.
> 
> The helper functions for FPATAN, FYL2XP1, and FYL2X incorrectly check for
> signaling NaN before checking for invalid encodings. This causes pseudo-NaNs
> to be treated as valid signaling NaNs and silenced, rather than being
> rejected as unsupported formats.
> 
> Reorder the checks to test floatx80_invalid_encoding before
> floatx80_is_signaling_nan, matching the correct behavior already
> implemented in helper_fscale.
> 
> Signed-off-by: Max Chou<max.chou@sifive.com>
> ---
>   target/i386/tcg/fpu_helper.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Good catch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

