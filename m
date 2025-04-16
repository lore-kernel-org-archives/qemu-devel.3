Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD782C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56FQ-0004cC-6k; Wed, 16 Apr 2025 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56FN-0004bS-6l
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:08:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56FK-00051Q-L3
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:08:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7376e311086so9417376b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744823301; x=1745428101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQoTD3tKMtH0l8BCQfU7olFRZN32fTRxdjslpFq9tGA=;
 b=jZNsB2RQpRHfzOP1xydIdgleSbb6prbazGJSNe713BgBs3ohxGwtNCeLZTASnF+qcK
 bpw/3i2zRg72ATEi6qKsh7rCko3zVHeKKTodVB4bjQYxBA8NaQVEZp0s6+V1+34u7Qcx
 osz9fkxSvspr3vsjl7/dFjpvlEN0dJ+DkH/l+550O9Y4wQCrRHufLdk+5jHZu0AEH0yQ
 J5aif5gERlp6ZHi0EuPbzJuaX7Y6rUaD1b+wDvkvdA11VWzwizhMwxP2a0LUCMlb+8Et
 ZRnTvny+cGZUyF8S763kpaFURueeqtug5Efk3Qr34Rj1Ry1QsIP3bTstwHvLSg3zhT1I
 oSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744823301; x=1745428101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQoTD3tKMtH0l8BCQfU7olFRZN32fTRxdjslpFq9tGA=;
 b=XxWQwIOmyMFjen4mCiSMXMIh3rlroumhGd2+eD1xXUe5raERU9/EOyey8VBNFptaE/
 65ryudVUHnAXTCM65G2GJR9kl+GQwvNwTE2R46JGvk+oTjS+yClSn1nWzRf6bUm0ee5m
 cCvJJeddU9lp1upJvSajt/wKxdK3+MiJd6P0Jrxg7mwUiMSdb7NLepki8T8phtcYYTQ9
 ttf+Q1pIgsE8lqWw7j+L9dlE2f3wsi+wHrR8Hy4mw+LLggw53Zgp/kKHqq1rWiZZYzLA
 opkzODqj1rLY1o1kEV1Wvf6a3C4dRHI/QV4UcWsCT2Kz9NENC5KNKZRMpNfDRKKfl0Ve
 ZVqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJD+osXDgSVBWSWj2qaFfAcTUz69CN9fMpaU+0gdjRnH8jwSfOlASsXY7v4PQ5VqKP4kZobffhXEF@nongnu.org
X-Gm-Message-State: AOJu0Yys4LgR8nWn8DwHmX7Mux0NePuni94Pez+gwBh7h9IPqgBgi6Ne
 viOF9RHazDoxvqfvCMZJ2WBfV7oQYHtUihFD5aQq8KFvyiqoO24UafGbpDdYJNU=
X-Gm-Gg: ASbGncuyhdctWGUcmMOZT4J068XrH0HQiMDRxcP3Uqq7PAQOO6voKo7jpkakkIMDEMP
 QrQO4FdglxopTj/GqUqOvl723L4dccNR//WHFBcvFhEEmBxFJepVz4An2ncD80J5/kniHO/Hk+b
 plDG6TeehbTVmNWVvYdJQA792ZLkUXLwmFdr7POhRB5gbtR6Ant1YTDbDmsvgOj0bWD6GYxho5E
 SAMQ441tCdOMWB4g00tuggMdCY7nQJhDd6C7nSvMnByBA6+QUZOrS3LQ180rCyyvp9KRW20hNMr
 rM6igCT4pNwKPkEjRTPXKq9F0q9Ou169TV9o9A2yNrOE1ma6UMYdnQBkyBisS4XZMDdnl4sEKu6
 1iYRzLcY=
X-Google-Smtp-Source: AGHT+IH+OiFcivuJ9446T0NBjp8Z/Dl2RTt/UAbKeXMgd0fK6ufDgHHntGwC+jXCxstc0EeYHeDQZA==
X-Received: by 2002:a05:6a00:8d93:b0:737:6fdf:bb69 with SMTP id
 d2e1a72fcca58-73c26732ed4mr3436627b3a.13.1744823300758; 
 Wed, 16 Apr 2025 10:08:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c2102sm10647294b3a.46.2025.04.16.10.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:08:19 -0700 (PDT)
Message-ID: <7ba14f43-3f64-42ab-b274-3fc4a367410c@linaro.org>
Date: Wed, 16 Apr 2025 10:08:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] target/arm: Replace target_ulong -> vaddr for
 CPUWatchpoint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250415172246.79470-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/15/25 10:22, Philippe Mathieu-Daudé wrote:
> CPUWatchpoint::vaddr/len are of type vaddr.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/internals.h   | 9 +++++----
>   target/arm/hyp_gdbstub.c | 8 ++++----
>   2 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

