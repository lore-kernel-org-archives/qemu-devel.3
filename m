Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B54C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9Gd-0006PH-0d; Sat, 21 Jun 2025 21:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Gb-0006P6-QM
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:13:05 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Ga-0005fD-6d
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:13:05 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af51596da56so2434291a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750554782; x=1751159582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r4SCYDeAD3qhB/+1mEnoENGO7aehhkF+bPLo9spop4E=;
 b=KfAg72xJtHB4OexQdg6vS+EleF8+CMf9Z7ijdfZv7lgk86dLPbq8LaaG9ntImZEzwo
 kAxme3UYZAKhqcxePPjc5S+Ufdj8pdhQONLlen32Rm76i3GygFFh9VbkXTQ8t260Tyik
 5UJsQfGoPLnJgeEIxUEptf59+Ds5TYf872gDy+bBMl5tW1D1u4Jhqn0mKjbAO7qWNsoX
 zLuldU7ET0Lq4ZAervWcOPWPnzCAokECKpBNo1wnXpjOsGUbl8cTNxgX99usNRgtfrGi
 iHKpkuGAvNIu5jwfcWuzPmbqEc/e9BG4uq5eEHHvG9+XzgT11xgQRqhx83Xov9y6DYVV
 o2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750554782; x=1751159582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r4SCYDeAD3qhB/+1mEnoENGO7aehhkF+bPLo9spop4E=;
 b=t6GNK86VUjpPaFkBBLUf+qyqCTc3oZWWcy/0Yl5iJ4zvpslcxFVpqRUmhzSnQZmD/9
 LOn6HuWPp/lq581SdhgUx9+8VYBC6quAZUVdVDED7vWTii5R3Ce1jkqg7vFKXCrmAKtK
 FKVeunvCEjJFAY2Q+kPrrlsCZ3UxhKBP1BBrMvvTJBnQPuo15tvo79mlfmsbp5kiqAYJ
 z6Xu0cK+1W06m14Th31vBI7UR9u0d8ipO+BWp8pGfmsqzJPTz9CGjifUQp4IKSpsHCeq
 x2+iWCTMgdl1wPbHZz5GUT8HAdpLBopCvHVoWjYLuweERFJtU95EMg5gbvL14HSv+igQ
 nyvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ5FMxB0BvuaEpgQIMImZupA4zENhLEMAMh7yMA4TIlNqjzC4vlNn33bOwgkB0vc8hfKqQ4b4t8ysf@nongnu.org
X-Gm-Message-State: AOJu0Yx/j8kkQxLt+8eiS1+D5uJ7IWD1K0HipEp9mK7ZKdBhM3MEyAoF
 MCJySxt6O0PLntfLnBk6opocs9y1KBsvdhFEBJMCNV41Vo+tb3aIJGHhxlrAgGDyPxOgD/dlJ3V
 15eFHI7A=
X-Gm-Gg: ASbGncvo8Uo2cdH5I86stb3j2LCLOaysx4a8H2kRB7m1NLjIU5d+VQ2V99DH4JMYVsX
 weYjerK+elYdGAYefyPUVQoDjWJl3KkYhK3vdjfRbi3KXeRdTf4vS5m9hFM+93MgGqZgEQGHVTx
 Q3pKeYjHrAcRutHCIUpH/ubmIlPJ1y0Dz9HX/Iemg5sTUSXK0JNSRIMSYz/DxmAzcDqJqQBdrrp
 u9S+rZFTwoVuVu5LOmqXYnX1vPiTjE9CAc1h7YCxcQvbAUVcZNnufszybN1ri3Np9EF5j5yFE6/
 J00LPiDDKH2OywT/Ux1r1Er2bDNrOLwe2PVI6VMm6wsdE1yuSTw1VfBJZ5t8//ybwJSSTEO06Ph
 F85BKMNwxcEOLNdUg+pX+3oOR2ICt
X-Google-Smtp-Source: AGHT+IHvXHQSr2jVmAdFXDbgo52yAh4xJaWQXN6xsH422WM6b3gsIwsupWLIKsPuLK+26amRxRlT9Q==
X-Received: by 2002:a17:902:eb8a:b0:234:c86d:4572 with SMTP id
 d9443c01a7336-237d9a42e01mr106178275ad.30.1750554781757; 
 Sat, 21 Jun 2025 18:13:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860a410sm49528695ad.108.2025.06.21.18.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:13:01 -0700 (PDT)
Message-ID: <07ed385e-3726-4de4-bc5a-32ea1d8aa772@linaro.org>
Date: Sat, 21 Jun 2025 18:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/48] system/cpus: Assert interrupt handling is
 done with BQL locked
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 6/20/25 10:12, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 2 --
>   system/cpus.c             | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index da2e22a7dff..37b4b21f882 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
>   /* mask must never be zero, except for A20 change call */
>   void tcg_handle_interrupt(CPUState *cpu, int mask)
>   {
> -    g_assert(bql_locked());
> -
>       cpu->interrupt_request |= mask;
>   
>       /*
> diff --git a/system/cpus.c b/system/cpus.c
> index d16b0dff989..a43e0e4e796 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
>   
>   void cpu_interrupt(CPUState *cpu, int mask)
>   {
> +    g_assert(bql_locked());
> +
>       if (cpus_accel->handle_interrupt) {
>           cpus_accel->handle_interrupt(cpu, mask);
>       } else {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

