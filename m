Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C7C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkEH-0004Gn-6h; Sat, 25 Jan 2025 12:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkEE-0004G3-3n
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:45:54 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkEC-0008GW-GL
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:45:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216426b0865so51768085ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737827151; x=1738431951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cXQRTV+4296A75OEz0xZDE0twsLGhzoV9BTZyMcZ1OI=;
 b=WzdPmka9NMYQFf+gyxym51pNzp4MiJaUqAV/mwEORoEokyJ4oGamv1m+BjmUCgbcg7
 wRNZAoFUraM0dkbqMny9Q2xZzd6R2NSJHFFaOuCEP8cxQ3uS9FYthJG8Ab6Qss5Es6AF
 n0mW/U/pVDrpWB0ZlOZ3OXKZehFSOXyWgf9lDSL6Ef5GXWKFmItKQKjtOvDsKFWm/BkM
 hJH0NzB+IM2RrZDuFDSevFXuqA4Z8+cohq29Jo5tHjjpCzqrKzCn8Hjv/AGgct08dRD/
 TMzdKWk0bptsShAtvICcDHZSkvIX0aG0uUojGVh+IusjrKLn2d4ie+2YZ3UK+nCwrfn8
 TPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737827151; x=1738431951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXQRTV+4296A75OEz0xZDE0twsLGhzoV9BTZyMcZ1OI=;
 b=LsUgx5rV4tGAdLM8oDXCF/bI6PXYlp0fNhN97da2j5Lxt6f8s+WaRedQFcN3nRM5/z
 GQDGU5AwsBtqIE9Py321iGlKnGj/XDzeCOmgcV/zomyDZQlvUKyCQ/df0mGq21pZnMJx
 9kMINYO8Sb58fkQSZkTQKOidf+FiqlpeuWYRp+2fv37QcTMsTKBY8ehzvQCXMjBJtsme
 KidUCxeoeZVQo0gy/SOdjllAaMEBPI4SHw5Jooj3q2hXwOVSyeWvN+OR2bXVamjO9za1
 hBRfMBp8c9VVqD1FSZ7IV0RyxCN7BnkoKXR+yowIP0i3jfPheCojtBzEw6a9IQM2Ah14
 F2QA==
X-Gm-Message-State: AOJu0YxHXdNDr7NZIoCt9DZFSqoqgsEKoPE/xBBjSoh2OrJD8M+v4Hsj
 yxbOg+NMFMMi+sxEL/XtTFcYLimDopG9nhKDJGqnlOPEgKGswENEAS3CLAioV2EpgmFVGPubzqj
 Y
X-Gm-Gg: ASbGncthY1I+btWCMfy7Jddr7AJXkEltYRp6nIF1KpNxSjzoVrqGT6kmpIFfoKV9CV3
 wFyG2S8doc/KGLsbmJzMamoqJLbyWsY5We2yxsUg7+7AD8jshFyvPjHUlNFwe3tE6jTt/rIcFy2
 66Xh0qBc5SDXDNKjR7M/+bSN5DuDUFP4+eJNaUgbJfiewAj+x650YOmmbmk91Fkzg4D8RDrjd+G
 X0aMBEeg71NxU5djLwt8WGGE2XBt7BnBPW38zv1TUimykKgTquF5LN8KgATk4/ADXsSXTcEYKnR
 qn4p4iKAQcj89vO+2AipCg==
X-Google-Smtp-Source: AGHT+IHukeSWwvXC9QSbpOWCPAs3zzCV3zqpaMQExVeYgWP9Q+7TYin5FyIFZPFtQ4+MOUB/jEVDJg==
X-Received: by 2002:a05:6a00:1813:b0:725:4109:5b5f with SMTP id
 d2e1a72fcca58-72daf946097mr56874863b3a.8.1737827150798; 
 Sat, 25 Jan 2025 09:45:50 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b3f86sm4105577b3a.67.2025.01.25.09.45.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:45:50 -0800 (PST)
Message-ID: <f02b820a-19c5-461a-a4c7-9d5631d8c182@linaro.org>
Date: Sat, 25 Jan 2025 09:45:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/76] target/arm: Add FPCR.NEP to TBFLAGS
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-37-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-37-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> For FEAT_AFP, we want to emit different code when FPCR.NEP is set, so
> that instead of zeroing the high elements of a vector register when
> we write the output of a scalar operation to it, we instead merge in
> those elements from one of the source registers.  Since this affects
> the generated code, we need to put FPCR.NEP into the TBFLAGS.
> 
> FPCR.NEP is treated as 0 when in streaming SVE mode and FEAT_SME_FA64
> is not implemented or not enabled; we can implement this logic in
> rebuild_hflags_a64().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               | 1 +
>   target/arm/tcg/translate.h     | 2 ++
>   target/arm/tcg/hflags.c        | 9 +++++++++
>   target/arm/tcg/translate-a64.c | 1 +
>   4 files changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

