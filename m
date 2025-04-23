Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E53C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WSQ-0002gw-GM; Wed, 23 Apr 2025 05:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WSO-0002V8-Ke
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:31:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WSM-0007N0-Oj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:31:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3850514f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400709; x=1746005509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0UM9N2JzXDM3LGT40Mx6Ja2m09eP6TaqWpKCMRdMsM=;
 b=H1pfpZ1CSFKAZqfoJF/3z8Vs0pQ5uuu6+sanPRigXb8m200WCX6e27RcuFP1hRBxZl
 a50Uewsr2NvN3K9G+bGCqCKUqRWlmPsIt7Volaue0UvFsZk56dx2w7wudxCk4UjdG4MN
 AXkJRoH4FulJEHq0m2yYCsWw1Z8qS6nsW/UdjpqZX2KtJxtcULymmgYTg1KIZfQdVHYb
 +mXsOnXeqmi7Sy18D+mzszZyO/P4mslz+Pupkl1DAkXd04d6JkoiVdo4I8ro7LYbwaNe
 hC/5jjJyFbXXoCDo4xbKrcHEs/08WBdZHhHZayEvxZ+rYEUdhVHiai8/LRgmiYCpqmQS
 EnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400709; x=1746005509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0UM9N2JzXDM3LGT40Mx6Ja2m09eP6TaqWpKCMRdMsM=;
 b=BxoOPFWMztlAfWhzZKiMZa7nFRLc8gqning5s3L7p/C2WW5RfnomOnlFYf9Mdl3mKp
 7k1fi6oNo1UAIrfOdT4i/nuqYJ6WVauENfP+wPHXjdEsuxGM4W2swv44nHHqRHDaAtwY
 5FMo7lAXbfV//HInR0kctQ/sj1Q5bPTX00vfQvCm3vGkYkDhyyxEgeWA6wPsnmi8M1e9
 y4t1aCDGa648N4HYls65aGmRtkb3nT6hGSalUzEhoI/L+KUMzZ+5Y/nBtQ6qjvER6stz
 UvxvR9q6f9CuSd1k5s7Rvn6/GXLWr1vFxJb8UhMD+4LjwoWDWoNTixO1xk3CycmfFa96
 xQhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoZ6a0rcdFTGuj2y814Le9x1dQeRQczbAPeKpc6rsC4nwO+mmSNsVKAxZY34M2ZAajyPaM2S7brQI2@nongnu.org
X-Gm-Message-State: AOJu0YzcQRlXi1kptmgYgyDo5WvR6xKydt53qtBAOLNFzIN/yaneAh0Y
 Y+6zi0f6IaR6nc84z4ePoabMsFj2Bq1ThTmqpBU57JgEe6j8ka0H+7/BqXKw4oiN0B6icBcZyKd
 Z
X-Gm-Gg: ASbGncsfGMj2azWcfxwYJkfqwmY+iY2zgkdIqyr+iWDMOcsH8/JCaqRcMMyz0pFkGaA
 gSNkNKTZ1O4kE97NaGSU4nrM+F7sQ5y36tHog23py4h/95zgCZhII4xs6ILfS2NNR1gx2g3Rzft
 UDyEI+STBNa91/oHNP725dObig9kMvpzaSUHr73oNF3rIYNy8i7r3Vanh2auXqJ+Ye8hKl2Vbtr
 p4Fuq9rxcM/bXWtHE8ooGsaVTa7WtWADaR4Y5cxB0ALpvBz2pAIWxHEfTvbZcfdVL+wQDJENGPL
 j1tRaqjUo+UhuM/IXq0Da2MWUyS1jmHD1zUNwVi0E2BnVMPti46Jbo7GqzHdzoH4CA1IfXfL/47
 U67z/I/ar0Sn+AKjhnC4=
X-Google-Smtp-Source: AGHT+IGPWVag9a0Kg1eC1l3DisxoeSu2PpBe+eSzHuVUOkxDziSr+zHQp9b4QD35UVHU16hiqLKIrA==
X-Received: by 2002:a05:6000:4310:b0:39c:119f:27c4 with SMTP id
 ffacd0b85a97d-39efba5b778mr13623971f8f.30.1745400708796; 
 Wed, 23 Apr 2025 02:31:48 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d369f1sm19032655e9.29.2025.04.23.02.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:31:48 -0700 (PDT)
Message-ID: <2f063821-a8cc-4180-a601-baa96b097ca6@linaro.org>
Date: Wed, 23 Apr 2025 11:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 033/147] include/exec: Split out mmap-lock.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-34-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Split out mmap_lock, et al from page-protection.h
> to a new header.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-target.h    |  1 +
>   bsd-user/bsd-mem.h             |  1 +
>   include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
>   include/exec/page-protection.h | 22 ----------------------
>   accel/tcg/cpu-exec.c           |  1 +
>   accel/tcg/tb-maint.c           |  1 +
>   accel/tcg/translate-all.c      |  1 +
>   bsd-user/mmap.c                |  1 +
>   linux-user/arm/cpu_loop.c      |  1 +
>   linux-user/elfload.c           |  1 +
>   linux-user/flatload.c          |  1 +
>   linux-user/mmap.c              |  1 +
>   linux-user/syscall.c           |  1 +
>   target/arm/helper.c            |  1 +
>   14 files changed, 45 insertions(+), 22 deletions(-)
>   create mode 100644 include/exec/mmap-lock.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


