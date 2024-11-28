Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC194D690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcZE-000707-At; Thu, 28 Nov 2024 06:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGcZB-0006yp-JR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:20:13 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGcZ4-0003rD-20
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:20:12 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21262a191a5so6236255ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732792801; x=1733397601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=48kKt2x0m14yXAy8h7rcAnrIA91wZgYVwmvhCtb9YnQ=;
 b=Ni1Mmcs87pk+o4sVQa1TIJwp0TDXrZ90ltJ7DqC8j2Gowud6nSWQ5tosrTGUFdg5sd
 OQff7M4BCEzinLDJddi10AvIPMG8GSb4HceVcJVLjucGMKAfX6eakefcdfSqfTxYnY7U
 c0iPH3xApaO1KUGxZmz3C1Vg5IIAXcRdU838SSmc0fyf90AMXXJWkqkfKuPtsos5JGDl
 v7+38kUZ5e8LSufxS79WATb2vxJS8e7GhkjwOO36cO1HYmLaRrNhMZVkBJEZMm+w+lt8
 trvg0GSA/hPvSqUe+nFI6Wv/j2Qmd8HSDYMKVFLqvtYssGE0AIG946A6asFsG8Mvr9ij
 iVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732792801; x=1733397601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=48kKt2x0m14yXAy8h7rcAnrIA91wZgYVwmvhCtb9YnQ=;
 b=nNEXsa5JcH0ITZWFrN+o1XbkS8yXZMwNpZbqaIXXgRNbDzw3s2vH+tJFvWPwIFiLNo
 7BrOWWUvp/sHATP/YUOswQBYdiO7I+KNa7fn+eQXocE8MVxZXsUfDxWZRmasSTonqotp
 Jw5HKQkz+Bobda/jp9ZM6aOXcsw9zf9l1Uyx65NpXt+YKHE/xIXZSGIJ4KBE9LE+m2fX
 Ui8xOSrQnSbO/wJFH+wgjKXIE82LlCr1aQ+cv+TCpqwb+0fbkTHrY6dLVpUvXfIgYOY2
 9F51N/lgod/dsmNBdycKShgzRSthCyDM0ihZhOBTETrSVkJpPuwCDITigRkjjynU2tKE
 IPvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlj9CwrIM7pgtNjZLZEzci/2nVxCs8GSRpJ27KT+V3iLtiIO64SSyWH89AzBzeFGUJHUtwAU5yooM7@nongnu.org
X-Gm-Message-State: AOJu0YzVbcpfepTxcO9A25Saz3kp3wMo+4NpBGnL6vZstxIUL3ufChxM
 C43wekdZahsYxf+xKLI8r28FO2+jBVPhVJgyK9DsoMTu9+7ZGJ/0MCo7eZwieSQ=
X-Gm-Gg: ASbGncuzL5Uv92ShoR4Pt/mz6DOcIIOUUhNqaEz4D2yuWBJvLH8OAuCfx1iIUQZ2Qyl
 eknFTTJxy0HV6WB9Om27mMJ96c0SrNk1EN4SEubYNNlRXJo/ArvVsArAdfauD1tCOSK4QaC19pv
 O3DzlbHHyQme6nQvAN7ucGO6bUPdCU0HhUNmgTVdEkvMeO0PNYMk0LQfSAYh3Ljc/sGfrO55WGV
 5iOP8gvL/6FIrIyz4ipjoYp5+kTk1VF6r9crlVj1w6TyAFQbBSU0iwCeWK98Iw=
X-Google-Smtp-Source: AGHT+IGwe9jX/8GaJmN9W8P7Qg8y/rRX6rTJE1cqCts6nDBOM2HHiL5TIKJpJQ7G6VkPLmya0RwZoQ==
X-Received: by 2002:a17:902:cec7:b0:20c:b052:7e14 with SMTP id
 d9443c01a7336-21501e6d06dmr68705605ad.50.1732792801466; 
 Thu, 28 Nov 2024 03:20:01 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f574bsm11314085ad.49.2024.11.28.03.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 03:20:00 -0800 (PST)
Message-ID: <2355b5f7-ea66-443b-9cab-24bbe1a18849@ventanamicro.com>
Date: Thu, 28 Nov 2024 08:19:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241128103831.3452572-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 11/28/24 7:38 AM, Peter Maydell wrote:
> In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> cs->exception as a shift value.  However this value can be larger
> than 31, which means that "1 << cause" is undefined behaviour,
> because we do the shift on an 'int' type.
> 
> This causes the undefined behaviour sanitizer to complain
> on one of the check-tcg tests:
> 
> $ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
> ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
>      #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
>      #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
> 
> In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
> 
> Use 1ULL instead to ensure that the shift is in range.



I believe we can add:

Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69eab..45806f5ab0f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1802,10 +1802,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
>       target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>       uint64_t deleg = async ? env->mideleg : env->medeleg;
> -    bool s_injected = env->mvip & (1 << cause) & env->mvien &&
> -        !(env->mip & (1 << cause));
> -    bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
> -        !(env->mip & (1 << cause));
> +    bool s_injected = env->mvip & (1ULL << cause) & env->mvien &&
> +        !(env->mip & (1ULL << cause));
> +    bool vs_injected = env->hvip & (1ULL << cause) & env->hvien &&
> +        !(env->mip & (1ULL << cause));
>       target_ulong tval = 0;
>       target_ulong tinst = 0;
>       target_ulong htval = 0;


