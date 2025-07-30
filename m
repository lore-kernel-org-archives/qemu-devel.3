Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371EEC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDpY-0002Ib-Ff; Wed, 30 Jul 2025 16:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDg6-0008K8-JM
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:45:39 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDg4-0000lq-Uf
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:45:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so242183b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908330; x=1754513130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSQwQrazVrb7QrEaMK2OF+bb6EdKxid2Sc4F6hTjS+E=;
 b=t0QE+UVcQeplvaV4Y5KZJ4U+KgzXf1mUsOU4W/rUiRra4eq36zSk2wggS5tN8P3KOv
 IpvNgeimKeXrRfDRj/CIsDqPhOSkgZ2mytTh19eFQm3EKGRvyFzZb1RnQ2MA0bhceejB
 z4urBtLUDbsxjKS1wITtuT3SyqAyxtEneyjpp3mept3J1wA17K0mDEyefdGcPcopkQm2
 Aa9SyxTYrsacW+VnLBxnyvM+Dfuhl4AOuNrV8BqK4gJT8HcQ36UboWZN7af2iCeoeMyf
 OMHMv4P+TaJmLt0fbrFwxxZCNGy6nifoo0QfCF/9MtqeXh21fJCqolhW5F7M14m+dEVT
 hLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908330; x=1754513130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSQwQrazVrb7QrEaMK2OF+bb6EdKxid2Sc4F6hTjS+E=;
 b=eaAJR+EfaSmcs+1cxo8ixHEL+nFmWy2S0sQOurEXxyzzSZlsGC4kjU6hchIqgdh1AM
 uZr8QHk70x8XR+6rncfmF3a2j0TO+FdkbWZzCY7PTA02dq4m6jU5bL9tkIf6DpZZe6xK
 DWBJU1M/J8zduhspr16yuCtBNkMFJiP7mPF8/5vkszMELwBZp6h6skpMxFJuwc3oqmUp
 eDaqqZweeaMCNzGAwLJzYcz7MGwSolWV3Di7AqrW/I+asn9+iKvw9MkRjtmBcq9IqUWK
 fWklM+ZVuJ1iIw9zZAz+056F1fdU/Jlxsl0WDg4FhMK0/R0GBUIMBcwcuQ5pOYeIAmiU
 YeUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKEzhJygI0/AaJMt9SUIp6ismw8gwc6wICv7XpC9paWAi2FEJ/esxEI/4RczmsI8Vd4F5y5boxKLfA@nongnu.org
X-Gm-Message-State: AOJu0Yyrr1QJpEYKgQZ7xC+a0gbPurPOz2W4VoQbKcqzw2kyUvqL/Mu8
 0pz3B//J1tWBW3kvY/T2xqCgQ/fSfUUJDIWzuIajTBkZ2eKFze2lrBtp4aONd+kqR7w=
X-Gm-Gg: ASbGncvDcg+R/UhlBmnh8bVXvzhIOBF7+N+eqTtxUYhpLGmjv3lKX7ATYVAj1GJuUWs
 hp7UHqLzBAFLPwBoU8xBZbVvrD68p/NEDrgAPJup1JffeavMPpXNu3+wga9cLrKVLQMbMGefRrb
 /6xSibTty8lkPYLl5458kvnZqcuJIwh2MvwABgsU+s0u3pQJbEKJ2zWSpHEuwuljH+73kvnYrkq
 oWEKLhLls9622lhB6R1wdqwYnUy8uSdc6AaqctQTJxcELvr9Yt7rKrgrbAQQyrZwBv9kkIpyk9T
 CQ4+vZh/DtLu6nVFc/dbVFKomymtOGf/ggYPlyTUgk9VnrGHpTPY5wbecY+CHgBaczXerTFk+7+
 HqFc6Xg5R6EYYxkk+QpWhe6XrlcPsC7+G3u0=
X-Google-Smtp-Source: AGHT+IF3RCoD/7Tj65zBjNe5TftCcxtDadzd2LI8BrT6bWFDJHCaEDtXB6bafW+bOzkLy5FSE8BVyQ==
X-Received: by 2002:a05:6a20:7d9a:b0:238:3f54:78ec with SMTP id
 adf61e73a8af0-23dc0f6348emr7623892637.46.1753908330401; 
 Wed, 30 Jul 2025 13:45:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640872a180sm11396410b3a.29.2025.07.30.13.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:45:30 -0700 (PDT)
Message-ID: <4ae46690-34d2-4d89-8394-160ff215ada0@linaro.org>
Date: Wed, 30 Jul 2025 13:45:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/82] target/arm: Populate PIE in aa64_va_parameters
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Select the PIE bit for the translation regime.
> With PIE, the PTE layout changes, forcing HPD.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h |  3 ++-
>   target/arm/helper.c    | 19 ++++++++++++++++++-
>   2 files changed, 20 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


