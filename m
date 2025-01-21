Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F4DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taItO-0006sV-E4; Tue, 21 Jan 2025 13:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taItF-0006nh-9i
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:22:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taItC-0000S1-H0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:22:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso69017795e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737483732; x=1738088532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrPZQDzms8mBGEhRALhXb1qTfXO5XhH+ZdNL3PgKFa0=;
 b=zX9HnhOusO/Ax8yrJqyEH3h2gaEO+BHYWXxGg96FrwukLHPId7yh9IxiJpqT5FOxLg
 lQWJQk6z+Z/3Zvrh1yZevhO70bRs3iq5FAvvDRcTTKiwrxA6q3XtycKFkgTqHZqK1nVq
 AJq8bqVx8w7aedJg+cPKOnpMFZMiTjdD6IJ0usxMGV0Gf0pZzUVCNkG5Qk/V7tJs5A8D
 8eV5YjVzk7UfsVsLyVk0FXaFrazPl7mLiFhbgoNelNHI/rCXRL17viP6tBHsoEMeEw4S
 rvEDWKqM6SdSTfmLm7ctSwVfhhoIDOP1NtrhRhexYdx9n0zm82bFayHQaf056WMhuwNZ
 K99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737483732; x=1738088532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrPZQDzms8mBGEhRALhXb1qTfXO5XhH+ZdNL3PgKFa0=;
 b=LXN8144CO8psWU2A0O2exnH3qld5c1QcqIRoklXBNlRefOzcLoLfsQec2IAYTKq+3X
 dUbldgPr9pF9VWlycK6f7KI3l+fHyx0kHoj+TT9KFYminC6N9igt/mnDq7atqh7SLiTq
 fcrP1nnRG1SYkJdMfTTtJLhdT5S+6rBoTw3YafVtVRZ/r+iPTBuTiFVzb9i29bG7y4BV
 CTxa2JYnZ327BALVCBq4JN0cXEdT5Q2sTY7VFI+njnoXtSqs7q+y/XdVit1L6l6jB2HI
 0KX9HH3Nwb/tzwySLivW6pYWwIRNRjBShPwtajuH1aNbEIeu+4lf91t39mgIxplcT5nB
 nUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxQZQiCnvOiClCN8i8bBII2FK5rNvOtboZTa2p0gPSbRmRMAd1iIOllKcaf7uuQgEkCB8uMlprlbJQ@nongnu.org
X-Gm-Message-State: AOJu0YxMWxYk6/s9ChWz9lTc23NiKgyJSvCr0S+9C2Ctgkgp1eoWHCBI
 lFSkAynxfzF0xLFQeAFNNzhLX2wgBM0rxMiupo6BYpxFbL866t+Nestt12wVfQA=
X-Gm-Gg: ASbGncvfZ/iTZ2/qdfGrlBN6wPyCjtVOe5qs33+JTiRSubuEIZRcNFngUwuDz8BNlfm
 LWDHP6d/cpx35Q+KsibweJEVREckwUE4t5VtoHfZ3nC32FSH8lHvQZOD+SCVrjukXHtGbr2KhHN
 1Du6yaU4BknNGr3Kx4Y4PY+cWPCa0N8g7BhaagxkLKhG1mGfTGY1iODqSCOtGNgNeztA/WA3skE
 qeKbozrqtO2c51Jwuc7EU+k/A101VmuZ4ArUT+cbaw1hmU7Cg+LYWORbHSGbWR4MQ5zleT3wLC3
 H5LCHe1N9xOEAlCMQStrLgzsHa2YmRoZWJNH4w==
X-Google-Smtp-Source: AGHT+IGOUjAg7lHe1XSgaS53ATmwTHEppR1Rhy9SaB4yEw6eDuKOJmxDboSWjFPRyeVawAGT4+edUw==
X-Received: by 2002:a05:600c:1da1:b0:434:a202:7a0d with SMTP id
 5b1f17b1804b1-4389141c227mr153198725e9.22.1737483731964; 
 Tue, 21 Jan 2025 10:22:11 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890408a66sm191775905e9.5.2025.01.21.10.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 10:22:11 -0800 (PST)
Message-ID: <93f508f5-d38c-4565-be45-eeec3428208a@linaro.org>
Date: Tue, 21 Jan 2025 19:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit
 CPUs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
 <20250121170626.1992570-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121170626.1992570-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/1/25 18:06, Daniel Henrique Barboza wrote:
> The mcontrol select bit (19) is always zero, meaning our triggers will
> always match virtual addresses. In this condition, if the user does not
> specify a size for the trigger, the access size defaults to XLEN.
> 
> At this moment we're using def_size = 8 regardless of CPU XLEN. Use
> def_size = 4 in case we're running 32 bits.
> 
> Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/debug.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index f6241a80be..9db4048523 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>       bool enabled = type2_breakpoint_enabled(ctrl);
>       CPUState *cs = env_cpu(env);
>       int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> -    uint32_t size;
> +    uint32_t size, def_size;
>   
>       if (!enabled) {
>           return;
> @@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>               cpu_watchpoint_insert(cs, addr, size, flags,
>                                     &env->cpu_watchpoint[index]);
>           } else {
> -            cpu_watchpoint_insert(cs, addr, 8, flags,
> +            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


