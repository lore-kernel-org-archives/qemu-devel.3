Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6815CED241
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvAS-00055i-3o; Mon, 07 Oct 2024 17:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAK-00054t-KZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvAI-0001gL-L7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:21:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b90984971so50771915ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336072; x=1728940872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbs7g7pKN0azl4wjF7esQMSxCGT5yGYvgL2s/yoMCts=;
 b=QgjJiTbFYJP/Wvm7rNBiGTm2o7+U12XYXmXPAHdqW5KP9Z0Uh2ifsSm8rW9FFYZhf4
 SM8i6IL2dmpyVO+QgJ3Utua/ti+EXTvaILVPKXMEipN9dWMj6KJ5ShLsFvQxW833fcZQ
 nkURWm9DGCsPZBXYtudIqcC+NQf/EdWje/735C1vtoiu9P+URAErNwS1hRSrP2AHoYdR
 7YrkTy3DzReQSyP6juom+G3vD1dQMlMjva1k4AcHMBelxVFKvJMz6dZt2WXHHasFEIS7
 ajH/XGCwii97nXxnNRjQY54KAQRx+2cyj8OCCZZuzjhDsmVbCqaGyqw+lJ91YUywa6Tu
 Q29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336072; x=1728940872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nbs7g7pKN0azl4wjF7esQMSxCGT5yGYvgL2s/yoMCts=;
 b=tqKN+QO4BuyBT4OAa0E8CoD1ZW/D4uYddY8X+E6p0v8a2s2i4L46qSWa5L9mKQWabG
 M4i9FopfvBSTlGY/935VF7j2j3obpiCvWRM9fgMm1FqzfrEoLzRlI6yiIRxUb6tNqR4l
 s5EizGKqUBBQVp8rH8w7JBH8vxVMUHvV3zeCScCg/PEZ5mYVYe/tST534dJITmGHembo
 XhsnVPKKiF2XarUjVFLgTxeCzWE44IrZ/FA82CZ2P22lIJeNEJQYNYLDCdQhXotTWAhv
 CzaH8Hjkb/XS3JI6kbaGtJHroj6SkzdrqUpkLHKjajO//x1OP3x1UIKOoPPbsYTfBcoP
 j3Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqhcsx2ml0HsVFdx3nfYO0zjOCMGs/+za2ERruGi4CWhgPSgWzdnjdcV6G5LLB3K5kBoR/rxtiI8J@nongnu.org
X-Gm-Message-State: AOJu0YwK/nb7PnmBoIwEXPS14Yk0KN4uxiu7xFVTlJgkmphB8LolDGeL
 vTZs7I5XpjZT4M16ZRTIyeT51eg0MuBu5cgXNDuK+Vbawf8lDMfGh17waMlgb3I=
X-Google-Smtp-Source: AGHT+IF4M96uWhBFmpYxzsV8/xioZOTo4p5LmH83ChcNBWKxusaQtdWL+kwvVRtzM6Fzm3Kql/qg3g==
X-Received: by 2002:a17:902:c941:b0:20b:937e:ca34 with SMTP id
 d9443c01a7336-20bfe05d555mr136152035ad.34.1728336072552; 
 Mon, 07 Oct 2024 14:21:12 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cec9dsm43790165ad.103.2024.10.07.14.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:21:12 -0700 (PDT)
Message-ID: <19da4a11-1d0f-4c9e-932d-2dd150e33d7e@linaro.org>
Date: Mon, 7 Oct 2024 18:21:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] target/arm: Pass MemOp to get_phys_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Zero is the safe do-nothing value for callers to use.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      | 3 ++-
>   target/arm/ptw.c            | 2 +-
>   target/arm/tcg/m_helper.c   | 8 ++++----
>   target/arm/tcg/tlb_helper.c | 2 +-
>   4 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


