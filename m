Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B0EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzK7-0008T8-W5; Wed, 02 Jul 2025 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzK6-0008RJ-48
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:24:34 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzJy-0001QK-Tz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:24:33 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ef493de975so2884683fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469862; x=1752074662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WN82otSd6d+eUty35a75HdJnpf9rzmI2T0VyK38+M8=;
 b=W3R9GWV9P34ZnHfoy3rq8y1ss+P3hUELVZtS0WhNWqAedIY2SxUBpaLSgotFkoJHc3
 61NA2Ws4FCYB8PjFSPERJFszrTZwBQQocYWv6ofEnGRFfYfbaGvgjsFgfDYdJ3iparvO
 FKdUl5XbfQ78KYcwSoDgtopMYO+AygoCpXX2D80iCmcYNYLI+Ay+tuJYcQqOhNJy11mW
 HPA43/r+lw7bwABy1p3FvFPI364DEmtEQQ2X71orF2ysyDHQ7RA8KmRSyqZOoURxEGjs
 KzZIR8MYO0+t5rY8+twxzxS8EPUbl9UfYJD9ApyNpWyNrpPCmYbqsRcSmavkJGD4OUw8
 /H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469862; x=1752074662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WN82otSd6d+eUty35a75HdJnpf9rzmI2T0VyK38+M8=;
 b=IGd3C82uEajM7PTuN/kYEr4ngE8hbbz7aaKAkhDjXRTziWLCqf7Wt60WR8Mmefctpz
 ITG4S2fdDbgnkDjYdtsWXaVSnlh0Oni/Or3eiEXs8IJei5LbVP57ByVjxk/bnafraX2y
 w2RYfbhTtiVgrC0w0AEVOQp+jyRD8z9N79x9WOoSG373f1pbq8AyxEpiNmCcWEHlcwfq
 gqCREk7wmmiAEw5yJe7AH3XYWhRmbMsXTzmPolbVZVTdaOqbsU5zV1acCLrVrXdnc1er
 ZJOEWLVBje1ShA7ZqKi6BEBBEEn6C+3U4KgYttDLmKqV96DNxqv18qsg8j228LhnLsgV
 LuBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSOwDF9dvhIWu/GWcTzGVhgSIx+AqFXDm9kuXGyZqKigsnV4ZLRzdoEQxxTB+6mJN3pimi9gLR/gt@nongnu.org
X-Gm-Message-State: AOJu0YydrLyg6IxaXUHCfpNiythgwwCBzw46E4f+O1tLa6KrLmvRW8Vu
 BtMkmcz5KqCo0DdsrDbZKphefCYLb4BmUm/W8twGFwUFO7L3HJpBlApSXFgfXVVJK40=
X-Gm-Gg: ASbGncvWxhejVYTnBXwBAn8vfKfmkje+z27CuINfUni37GPWNd0ZOCO2FZEKcaDrHkq
 Zlim0k2UrN+dT1D+41+Rc7ZkY8c5TCaXNXqwc4+spafZ17RV3NGKEGFy/pAAR6OUKZw4P1i/ba7
 niqsV4lzZ+hqRhpoGKgEImVLWzEhV7dMM14hhWoyFKLGCBwU/nDgeNG6aDCgy2PAzTEBix2XpwW
 Ngvrez1dtdkm82sz81fwaG4foY5CLmOx11PDwKY6vxz9/INYishf0mmVD0/V6Pb7LARAgiWdTnm
 H6k2/pffeiEBi2o+w6L03N2E6Ye8FqQYv3a5UQx5a33+yywm9iM4txAT0rRkkWrZ7fCatXYtODJ
 w
X-Google-Smtp-Source: AGHT+IHwQ1w8gux3jF4Olo9mqGbjmsRmd7X77ev4gxEyyDxkBy4D0kFqji32H2WoJwjiksOKZfaE1g==
X-Received: by 2002:a05:6870:7092:b0:2d4:d9d6:c8cf with SMTP id
 586e51a60fabf-2f5a8d299bbmr2670439fac.5.1751469862551; 
 Wed, 02 Jul 2025 08:24:22 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50fa38asm3872586fac.40.2025.07.02.08.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:24:22 -0700 (PDT)
Message-ID: <b4db90e6-c6a5-481c-bd87-4b55792cb6ca@linaro.org>
Date: Wed, 2 Jul 2025 09:24:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 59/68] accel/tcg: Expose vcpu_[un]register() for RR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-60-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-60-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Allocate ForceRcuNotifier on the Heap.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-icount.h |  4 ++--
>   include/hw/core/cpu.h            |  2 ++
>   accel/tcg/tcg-accel-ops-icount.c |  8 +++----
>   accel/tcg/tcg-accel-ops-rr.c     | 36 +++++++++++++++++++++++---------
>   4 files changed, 34 insertions(+), 16 deletions(-)

Again, motivation?

As before, the structure is still not accessible from anywhere outside of the function, 
and has the same lifetime as the function.

Also, this is doing two things:

> +++ b/include/hw/core/cpu.h
> @@ -498,6 +498,8 @@ struct CPUState {
>      int singlestep_enabled;
>      int64_t icount_budget;
>      int64_t icount_extra;
> +    int64_t cpu_budget; /* FIXME TCG specific */

also moving cpu_budget.


r~



