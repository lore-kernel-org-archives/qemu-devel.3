Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2FFC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAArk-0006GV-Ve; Wed, 30 Apr 2025 13:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAre-0006F0-Jx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:04:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAArc-0003a1-MC
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:04:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73972a54919so158012b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032691; x=1746637491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4oYbClUa3EHzux4u/nV7UowneiwN1qzbn56i177Q24=;
 b=AIlXpfEm5OK4/OpsykW4DZR6tnHj0t3ECHsSi1L6TSRZPdIafhgI/nWKva4NVacTwg
 QoNefLJsNa8NF/3YMSUXIW5kFWD7OckKen1zru1vMTan1UcPuKMrP4NmIVUz33xQ1eL1
 c+N30oT2O/mMEKAxdT2rxktx7KWH6khzK6aEHlgJR0lfiWPuBnR/ooRCTsjDryUP/vrm
 WARBHGA+uo24+8Wm0cK8iKNXlP9nOgV7LGo08K97cfv1V23x9Tuvn6JMJrL8MTSQ2tz+
 jiMtsH6QOlgbs2p/upT1L5J38V8vsStfLzX7VwUWVJCAyE5ZnTi7TBcazVcLIRQNSNTz
 BepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032691; x=1746637491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4oYbClUa3EHzux4u/nV7UowneiwN1qzbn56i177Q24=;
 b=PHE4XxWqiYQ+YfnJSmQRy5q5uGTezJHfHZI7hB7XhOwCL/ltwdePuXN0cdloz35T0/
 ruMk+XBLA4lBw8n5ie0klM470c7V6cQyvvpPaHdiSstfEm0OvLeKDiJgqapjdv2A+1AQ
 q7T7pYQsd+YBe6JOz9cwF5na3TN1AphbeFHWh4nwMJ/RxTxlcWV+KzxtNv1XxobmhNiu
 y/xVF3Eur0y4EF5k7L+IkGmN8TajMr5rz8mLUVYtFQWLTtUH22GqaukAB99QxDhaBNoZ
 uZhdr0DbY5JaEFTNkF/jssRq2VLJgxlM8crC/e2n7elw/klG1HoYz/hGU76eqjffkHnt
 RA9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoBRZKbIY+wuulWrF6APVAAtefgKMGPuFz27UmBCqctIt3uymAuXN6SGFkHsau0/rXPfuS4RlE8W2f@nongnu.org
X-Gm-Message-State: AOJu0YxQvi4/mTKHlvEWvrVExTLxiOBAV714WSztSZffaOwmGKxfMerk
 Ul6w8OT6ZwNl4FV9aVO/YtRXblJoqAYt63aIKFJKZdffQ32H2XukXnTaAl5FnmA=
X-Gm-Gg: ASbGncsdZ1eDblESCKslD0pspbzvpxXXHja2HK5u4LZIRwDY0LFfCkSbXW4sjfb2oua
 OeZ4lCcrI3K5rkDlCL1iatmHU0jOi+sHLGsxP/hDtHm4elTZmFwlKx4+8oUhk6ux9HPvBjxizBS
 1Q893WaOj9WgE5nTjI26jb+h++7zd6GYM7hvFQ5cH1G0gQHDHFdXBNu/AeNUiMHCfOwrN/6HHIf
 BqnBPfRvgdLCzUMJv61eykM624pnkvRaXHA3nk1sRbr+yvCrk+xQ0LJhCtXdBybTMY+V8isDeTD
 FbxVnWRrVJeJ6zj7fCLZ0WVlEMmb85NjTUA1NjYlcrYor3tzIuWacg==
X-Google-Smtp-Source: AGHT+IENy/64g5rsTi9BOrTNeCBtS4guiwVxh0uwuucoUGvZLoP9qV7AwctIFs+z8S0Mbc3o/BYKmA==
X-Received: by 2002:a05:6a00:21c7:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-74038abf64amr5799520b3a.20.1746032690916; 
 Wed, 30 Apr 2025 10:04:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a3109esm1957705b3a.93.2025.04.30.10.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:04:50 -0700 (PDT)
Message-ID: <86ccfe98-a6ea-4778-990e-4c62eff6a9d5@linaro.org>
Date: Wed, 30 Apr 2025 10:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> Combine 3 different pointer returns into one structure return.
> 
> Include a cflags field in TCGTBCPUState, not filled in by
> cpu_get_tb_cpu_state, but used by all callers.  This fills
> a hole in the structure and is useful in some subroutines.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h      |  4 +--
>   include/accel/tcg/tb-cpu-state.h | 18 ++++++++++
>   accel/tcg/cpu-exec.c             | 56 +++++++++++++-------------------
>   accel/tcg/translate-all.c        |  8 ++---
>   target/alpha/cpu.c               | 13 ++++----
>   target/arm/tcg/hflags.c          | 17 ++++++----
>   target/avr/cpu.c                 |  9 ++---
>   target/hexagon/cpu.c             | 15 +++++----
>   target/hppa/cpu.c                | 10 +++---
>   target/i386/tcg/tcg-cpu.c        | 19 +++++++----
>   target/loongarch/cpu.c           | 20 +++++++-----
>   target/m68k/cpu.c                | 21 +++++++-----
>   target/microblaze/cpu.c          | 13 +++++---
>   target/mips/cpu.c                | 14 ++++----
>   target/openrisc/cpu.c            | 16 +++++----
>   target/ppc/helper_regs.c         |  8 ++---
>   target/riscv/tcg/tcg-cpu.c       | 12 +++----
>   target/rx/cpu.c                  | 14 ++++----
>   target/s390x/cpu.c               | 14 ++++----
>   target/sh4/cpu.c                 | 22 +++++++++----
>   target/sparc/cpu.c               | 17 ++++++----
>   target/tricore/cpu.c             | 14 ++++----
>   target/xtensa/cpu.c              | 40 +++++++++++++----------
>   23 files changed, 218 insertions(+), 176 deletions(-)
>   create mode 100644 include/accel/tcg/tb-cpu-state.h
> 

[...]

> +    return (TCGTBCPUState){
> +        .pc = env->pc,
> +        .flags = flags,
> +        .cs_base = cs_base,
> +    };

This is a quite neat way to write it.

>   }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

