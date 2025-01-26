Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607CC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1lg-0007fD-JY; Sun, 26 Jan 2025 07:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1lX-0007Rx-E9
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:29:31 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1lS-0005Kc-7J
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:29:26 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso58017635ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894561; x=1738499361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnLXUl3zoRK59m5l8YIfMTgBJaOnw5bnhh2S/SJODFs=;
 b=JJCVoZJDWqjq9Q7OMSKynifwLZg1BYRZDSgpBtCWu57S6EuY5O1jlm5KNxNG3wn4FN
 5RrWgymJxVigt4RbSP3OfKFViw+VQcfx1wUVqFezbPZiuctY9fBG6mGugIVnQxeaCLIE
 C8X40GQCAhj/t8HvwyqyYwdEKV0sleFPwEwajonRQo/ct+W5GYFysOhqGSDyx435YiVO
 mUG7HzdpJ1BBlBbrMyIHXU3QqJK07IJ/2QJ+3gvQTolqta2woIIO0wwB9DS4cLzslvEm
 7gowILuwg29n36ZABGqFM+zfgBk10IhKjuC+1OtohAdsm9G6qVfkg578LNwZXFL2WfKo
 AleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894561; x=1738499361;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnLXUl3zoRK59m5l8YIfMTgBJaOnw5bnhh2S/SJODFs=;
 b=WM9S7FEoxHmt4I1/tl4S8xuC0/PQ5sknsKdPuZSIUEIDoc9LxxxW3WOSyBLGLcJeIO
 7UBDcYknd+WX1WmuVHq/dqOysHTZVmpWF4CdR+NDXii5vaR3R6ADzyuYIJayQCFo7D2W
 9+pMBlDODZz+vPFNHozFtmEo0heWwV7BpQl6s4WNKTHTFwXH1KAW+7gJ79JGpCokLuFn
 Wf4CSanJzfh0FHcZxKPoLtn4RLapZk2/2RRKVgeo7pXZxeIkKHAE1sfgt/ZkilOCme2J
 wUEFY2W94INSLi4oiALJ6h5sN8/u6liEicTOMgSeOcbF6t0nS5YjUYF1KtgZf072OAt0
 p+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWobXGFB1UG+g76nnNYb+LsOh42zD1MwhLJZWLKoH3vZ9gTSY6TAzfrWg3kSBqU4V5P90giqNKahlp@nongnu.org
X-Gm-Message-State: AOJu0Yx/aFKb4hyvmURYe7JOjTox1uj055MF4Dx8rk9jwQAjT8ySDS8i
 5Iiq5yFs1rEN6UI/UJoUhTi8MXiB6eHbMOxYIAMyDpf1Z8updEqv9vypz7+yfuo=
X-Gm-Gg: ASbGnculQPh+dpDyZlb72cB0/P3Bp6rsT9ly+37HLHgeBpu9Ap7tQWl40cC+MSC9Eo+
 Xj5PBFANHscJP9ddHH87yBpckfrLpbs0ZOmX9f0fLKW89Iifrgjrpcdu4+R6+DnroyubMF7tvVt
 uhV9+lSQuULPF49zYgqz8u6RpoPJZR+3nc2AkArhVfm7JI5PDedbwM+V9XEY5CNTPNbsSMqe9UK
 HJuES8jCIIZZ0SFFLAH/CTaLwhWZnXPL04zQMa/ZtRyBTDIdkGTOzzJPB0MGFrfb/ndpDIoNlmv
 6FaFnq5KUv8koq8bWQPOfJw=
X-Google-Smtp-Source: AGHT+IGMaZ3ONy4scd/MC+T7FJz0TYZA+FrOO7AmFy5cQ/4jQc61L5AtioGvq6SSBs5m2jQH1fJqag==
X-Received: by 2002:a05:6a20:6a93:b0:1e1:a693:d5fd with SMTP id
 adf61e73a8af0-1eb214f0f54mr43569292637.25.1737894560931; 
 Sun, 26 Jan 2025 04:29:20 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f897f33sm4650131a12.23.2025.01.26.04.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:29:20 -0800 (PST)
Message-ID: <85ee66a1-45ae-45a7-aaaa-d72add84be62@linaro.org>
Date: Sun, 26 Jan 2025 04:29:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/24] target/riscv: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20250125170125.32855-1-philmd@linaro.org>
 <20250125170125.32855-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125170125.32855-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 09:01, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Cc:qemu-riscv@nongnu.org
> ---
>   target/riscv/internals.h | 4 +++-
>   target/riscv/cpu.c       | 8 +++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

