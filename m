Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C652C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyBg-0002L8-VS; Wed, 02 Jul 2025 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyBd-0002K4-UL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:11:46 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyBV-0001qq-O4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:11:45 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40b54ee16ddso2205341b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751465495; x=1752070295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ax92OI6M4WzJiJxDk5o5mfpOIrq8GmFb/DsxeWoDlBA=;
 b=NAVoPos4vIkjRmT2t3jZi8U5ZKWTfDnPKcN6bLQdq0yCTTumqnvF1W9Wh/J9Yu7bIc
 AxAsIvDzdTWwZ7sIE/8s1yWkC4qJ8F/M0Ysf1nuLLEkI6dqxh8pV68aTjKFnHZ2lYGKt
 ICiJ+y01tBDxxIX71a2X8PIDsNwyyF27dnUEKjlDz+IxQy9QA1OueupDghKb6d0n/1Ux
 UmSbr7gwG7HyR/4fF+TOk3L1A8G8DbHAUG3jZhb4EgHR6eKxy69pSfezGxj4u+pw1OPB
 1lmBRJae+nWknnOSFe/6X0iL2RkL7KGZ5gumJFy7fyG+wZ5dmpzgz9K3JZXqMxwsKqIi
 EQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751465495; x=1752070295;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ax92OI6M4WzJiJxDk5o5mfpOIrq8GmFb/DsxeWoDlBA=;
 b=FPwoP4xBjfoevgUwZXHtH5KikBw5My9BMzESVHE/i9476fLn3SaFtoLesG8iyVvSxg
 9zZHg+JkRVJAGqd9TRaSluK23TBs2NVj17dlpJ0G/y80I+YF0auEmBFux5rB29Jx3g3W
 HX1J80O+3uLEEOAsJxxtni33VjCbAE0Sdby3EppMWC7Q7eFbXnXEkcuOyINYLHI4Fhd+
 LxIcvY2klZ06k4ijPl+GSmB6gjZM1p3pD09/FgnWXVBgi1YuE8alowDn9whGnYgBIA7y
 +fj8qe8kzSlnP5xKt9885vCl9KRX37+byic11XTuruSqn7j9BLPxoIhmpYfdYzN2rxkF
 ofoA==
X-Gm-Message-State: AOJu0YxNuUEI9da4x+S5EmKuR7ZUrJkgapmLd1KVwf1etSQojj3T6Xo3
 qvAO8/JuMlHGfj993NRjbfFAa3ru8eWzuAFk1ulL8t728lobT1/O8ncTzUnqxT/7deIctKCCCl0
 1DiYf31M=
X-Gm-Gg: ASbGnct8itHyU7BDYvkNaVg78yO0XMeIZ2itv39QOUO3nQSiuf+km2Ew98FiOxTl3pa
 +zvS2xZDb0p0VbWhhk3r8OB6U02hrq7XcH5a2zT+Sohib2c88SOHKwP5gPr6Pl9Co8eN2biQw9m
 ckCx9qFlE28vZIIPxkmhlcabds96syn0Cv9WV94bBFGbNmo49gxb0Q+tKzZZyKS/cMQAwGt1Z7M
 p64/MSWjSygFH8mWuAY9tc/E6znG0/oTaNu+rbzqbweAZjTCmh05zmULjswFz57Idbkkd4rGUFj
 fNG90Du3B1D7X+08KpFGm8nQHf6rHGFFs3R9uzyZgNwv4nvZWdL4sO1X27hUkNIa4MKjTxmPm5k
 o
X-Google-Smtp-Source: AGHT+IH5UoVE8xyds01gdt7tMXN1stjbJydW/TpzWhl/7fv8J5ZaOBN8FjgeIA5sY1nCGOQfTKNQKg==
X-Received: by 2002:a05:6808:1823:b0:3fa:7909:2716 with SMTP id
 5614622812f47-40b89521769mr2288942b6e.39.1751465494894; 
 Wed, 02 Jul 2025 07:11:34 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322ae397sm2537119b6e.11.2025.07.02.07.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:11:34 -0700 (PDT)
Message-ID: <c350ae1c-e2ad-41be-8b49-e532adeb964c@linaro.org>
Date: Wed, 2 Jul 2025 08:11:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] target/arm: Replace @rda_rn_rm_e0 in sve.decode
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-5-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250702122213.758588-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 7/2/25 06:22, Richard Henderson wrote:
> Replace @rda_rn_rm_e0 with @rda_rn_rm_ex, and require
> users to supply an explicit esz.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sve.decode | 48 +++++++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)

Bah.  Sorting error with too many patches.
This is not a SME1 bug fix, merely a code reorg for SME2.


r~

