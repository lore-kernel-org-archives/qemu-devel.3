Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE339C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEHo-0003Hh-P0; Wed, 30 Jul 2025 17:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEGm-0001Dt-Oe
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:23:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEGk-0001Y8-DS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:23:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76b36e6b9ddso211828b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910605; x=1754515405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BFGy9NrK9pvXAIOHSataagHdALqFKL74LCum85+/wR4=;
 b=QvXuYKClu1Y8YvjjocMpgVphU6Vovb0Gf7ink98FMHVJhVNhSjfCUybkpcDO02a3H7
 DDQZO3wVdjKmhwE0yib4Fi1z53QT0VcR+S3JQ++jfwCvh+2dj2LUvuimo8NKkrtaKCLc
 WeGUkEqkAjmhWe+eaPdaYBcq6Mqz70cZrdT1CVHvkUYg4oKGe8LLHyhC3TTOWLjfInhY
 1fctsbniMnHq3wjGhO8LNa++En1YICagCinXvx74BTNgL/7D73TQ2NQk2pUER6qq9g7X
 uuiS/GqYbvajDjc0r22vwM+xKed5UswF76p9Rfd5eWCiR7HQcUqApfVrp1h9aHtG4Cn9
 UhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910605; x=1754515405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFGy9NrK9pvXAIOHSataagHdALqFKL74LCum85+/wR4=;
 b=NZqDaOyOpHEEl2h0CMzkKTZJT4RO+SiSNgduLv2d8R3krscnOAAStPvae3aWo+CVg5
 QeJXF/pvs/vfy0TjpKEWk1mTcsLYcahSZLl4T+OUG8NrY7x0Olf/gxUbVX6kwaZrDKuL
 rMpiKVwEgEmS+8Rt0T1c2N/BcYqXBnhALh4DVOEX+OADYwBMfhU+/KUNRRvp+8zn2uoa
 tY79+fP1VCnK0m1J7jJ3SBhyuXjR2UmiPfqCQOjkX15Kqbu+gg+MdZ52/cFdTW6DUIa2
 UjKf3EMU96B9KbzmvIXZYNo4qihRdoee0RnwlNXks5FhffggLcvIlP67o9ARYFu8v+hw
 cWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWypXzkmQciMXDQcrLf33UgTPKzXtXdt1aD+1o6NK4P0ZcfN+gk/vpMIP0b4t1Ys3LWIojFBml/2acs@nongnu.org
X-Gm-Message-State: AOJu0Yx7239hTPiR9aX9fxsANZYPiYGL1BEISnWuc6SexrqthG/oEMH5
 rP0oes6T8tmmlJgu+7eMgn2IXdpFBBGGCgO8EkrokbYxqGOw9stS29t/qN58RkE0ifE=
X-Gm-Gg: ASbGncuN9EauaNEQ/2504KbjbadogT8/YKKmhGFYUb3J5OpLqngZHvkchIiNbOL/crU
 vWJPWI/+Ae5OnrtWI4ak7xZUW1/z0MHCbpmYf4dUyy3DsmytF7YfGfRNkjkXpMQJt8Z6t8TXTkz
 syFzdBkX2/IKCBh2D7ez59VXG4Mt6ZV+Z2X9uNGcXwNNs3qtA8on3Bs4FK8I0U6xgJjUg91jMr6
 VrBXZ/dz5UcfrrV1e598/KC0BdxQNE5yt0wKd9HiWPH7cAo3HBwK08c9Jj+P+wqaHSCzcGc4gIW
 4PmUgum2rOHUyfcE/xy1joTk0vJ3XQ0DNEN4IZWmJ4fhEf6EKP9WTRawUm3SGIeDZULxK3UAl0e
 yoqj0Is9JOfQPooc9yapHHzQjLUhCjWjw+m8=
X-Google-Smtp-Source: AGHT+IEdVAsY0qc6XGQMbDFrJuiTT+Qeb3V0NjYhmaJpJ0RgNUIE9wRdjU2r1DCEtksM5Q86/ZRcAw==
X-Received: by 2002:a05:6a21:514:b0:23d:c9ce:8863 with SMTP id
 adf61e73a8af0-23dc9ce88d3mr5736508637.46.1753910604804; 
 Wed, 30 Jul 2025 14:23:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfe5absm10725894b3a.69.2025.07.30.14.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:23:24 -0700 (PDT)
Message-ID: <0d162634-f6a5-4896-be8d-f6495ebe07be@linaro.org>
Date: Wed, 30 Jul 2025 14:23:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/82] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-39-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 19 -------------------
>   target/arm/mmuidx-internal.h |  8 ++++++++
>   target/arm/mmuidx.c          |  7 ++++---
>   3 files changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


