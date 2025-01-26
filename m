Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6970DC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcA08-0002Im-An; Sun, 26 Jan 2025 16:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA06-0002HE-Vh
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:17:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA04-0008Ez-9S
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:17:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso62490895ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737926219; x=1738531019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMRLOGE6yrO6E+licLk956mV4oo4UqHJMRzU5NR3n4c=;
 b=r6gi5A0Nq+L5cNH6U2LTlGVeV5xjkXRMbrktouad8bAZd9Q8z7129n0Wuuh8PtGjMa
 raKbSH2rDHKenkKX0hFvYFp4lngQ4z6IN1TJ46DOJ3xN7h3hTabuIe/KS89P3zHchbI9
 aT/R39xZ1wjHkwF7tP4B3zm49Nyc/j8hYe+/lfQbeL/oIbe68t7IhfFPoEFkUtkdR+oJ
 m8sFnZ1FUh9+MRttE37ImzhGZgSP0rLGHkPkjRxKBR1sx8RytaCuyT3zGbVgqXCNAp6Z
 g55OLolb8J5Sb82BJkivZ6i3LFG9xRrY0ZcaIdYZ957iULOJAVr0g8guOmiNN0jyhm1K
 0uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737926219; x=1738531019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMRLOGE6yrO6E+licLk956mV4oo4UqHJMRzU5NR3n4c=;
 b=INat4s94H19GPp+hzaZtASB0xdvDgcR9kcMqbiplkf3ENwZRgrAQ0G2f2YTACdFVtV
 +1FDBV4PeVSjH3SQcsAvsfLwgUPTciYCYMfak1tTO6+kzq08lM0oENeOiqCiFz5b56Ax
 IQ+T8X8lg6dxAhNq/meCcjwx0asbxnlrcR1gFpP0zetM1IRB+yRyNSMbITnGvA1KhxPw
 G+xbvk3BLBEmVV2W1J9xDe2vntGui9uLhCUvq9TJoMxCzLpAcp1wSqTvoJkOYCQucsGS
 NP+x4gBQ/zouEn0niXPryeutmKPwIGv1okPCG+3LPmLMB+IFzjv5Ps+dtXPOSTyZ2OlA
 DfAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH+us0+awOgxztBNdxfSVRbWwIFXCFIY7z5SooMZlmMGrCI88NJfzVSv99T2gtfncTJomstsacoLBR@nongnu.org
X-Gm-Message-State: AOJu0YzcnJAcp4ndhDeiZpdGMt5oZNJaMbIsznKXeZuV/W5oesMZtovZ
 8cSnky2Kso+6e5tjBwq7r9+tBYi8ERFuoQ4cgMszG/p9z3uwVZFZEUDihrBWjA0ibs7g+nxgbg3
 y
X-Gm-Gg: ASbGncth0fjNv9FcaXqGRKU/AijfzsCmVR+/4tFULXB4DxTuJpKrT9WR6hoaL/dIvRO
 YFQY7+XO0Otz0zHn47cJe+ywOpWrQHrhGik6Wri63IV3g++z4IqNbCQLxasmI1grKq9YIJ2iJma
 wbxzKDvVA38ebuBrKrS6FqtF1PIDmW/fcRVXFO162PBWbQ+fQq6q53gzYSChgc8IFNiTk3DUueD
 P+dwqMPeaZ1IzepVjMOGdt1gJhUQztWypMNalj8Ffm0TqKrBTnh+5uAwwtxPodj6ENwqGhG6hAL
 0G5uQg9eaUH60mr95afncggwqSW4a1FKazeU5H2+zwyG0xk=
X-Google-Smtp-Source: AGHT+IFBHji7Q02DuNHRJzVlNXhJjAx8HDsMis8mrPSUngwfhLK6I5AlZnoO5BvEYdWLX8kF5J4JkA==
X-Received: by 2002:a17:90b:2243:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2f782d9ee8emr55346160a91.35.1737926218792; 
 Sun, 26 Jan 2025 13:16:58 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa75bafsm5669849a91.31.2025.01.26.13.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:16:57 -0800 (PST)
Message-ID: <e52485c5-122a-4a95-928f-08fcd17cd772@linaro.org>
Date: Sun, 26 Jan 2025 13:16:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] cpus: Restrict cpu_common_post_load() code to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> CPU_INTERRUPT_EXIT was removed in commit 3098dba01c7
> ("Use a dedicated function to request exit from execution
> loop"), tlb_flush() and tb_flush() are related to TCG
> accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c | 33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index a2999e7c3c0..c05ef1ff096 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -45,22 +45,27 @@
>   #ifndef CONFIG_USER_ONLY
>   static int cpu_common_post_load(void *opaque, int version_id)
>   {
> -    CPUState *cpu = opaque;
> +#ifdef CONFIG_TCG
> +    if (tcg_enabled()) {

Why do you need both ifdef and tcg_enabled()?  I would have thought just tcg_enabled().

Are there declarations that are (unnecessarily?) protected?


r~

