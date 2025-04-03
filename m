Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50FCC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NjI-0003Q2-9i; Thu, 03 Apr 2025 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0NjC-0003Pn-Lh
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:47:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Nj9-0000Ea-FG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:47:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso996489b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743698858; x=1744303658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4daXjJj4yFHeTHHxzQqRr4tpyY3Od5qPC9BQ29K08Kw=;
 b=yT2gnA/F9nd8Eted1h+/0olnZ8Mf+7DhSjSQefis4W7jQ9CJM3pjSC+8LWf/1iqOja
 H96eYREvHU78LuxDGkNSaKG0FteD8shT00TYAtULbta+S9F/Dil9q3U3Lmm6Gt1fvwLe
 Jtqq3Mem5qjVCk+eK6mqJnZNQlMTgykGN/SOKZUR0r5X+lnNUDQaIQj9JqPvT7N0vfQS
 PywFvFb0CnqadrZqn506yWYsElZfGJmitvUKpXKiNF5bSDeluylPV/x76DUXNsXnbMzh
 mxLOcWydfdq+ODCDIqBcHAWckj6eJixNO+OYStBiOdVAhvj0oJYQ1Z3GmztO61Nkebdf
 xG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743698858; x=1744303658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4daXjJj4yFHeTHHxzQqRr4tpyY3Od5qPC9BQ29K08Kw=;
 b=XC4yRey29cCjfC5UsQ6oFVxESMrsF2lHKEfqkNw8z6+1ANIalzhn8ogmWsFQbWxb+s
 RLfNoA0eNcCj3+QxVy569ZH6rIXSxyX/yqzWEPNk6oh25kCoCy1Vu33muEP0p7lPRxde
 SOfGYAr6TtZMkXkvinx2a59jKq+gPwD6Ol4k04hlvS/cPyUxUHB+kUo0BUf06giGxM8a
 ZP301I4nLqbqU+qT0XenTeNeAu/VQK/nIEVQJfEH55eYMGwTQGC9/7NOdphMzBQawoho
 ovKPbKU3SbWfA7DcfKZttVGl1d5kn5OSLW0VVs5Vp91RwkH3xiFjp91LxdxD0wLTI9VP
 4g6Q==
X-Gm-Message-State: AOJu0YwKnaMl1uUYaIHUznl0ruxax9cNkmHu9ZqiGjW72RCdG4Oodwcc
 p04CCXRYqQSWITFCIv2to1Ph3GaEiO+Y1k3m1c6Xrgz7VP9iH8tHDbupSVj3F5zhT7d4z+AR8Df
 A
X-Gm-Gg: ASbGncvDsyktkSwFy/W4ek5PJLGhm0R0EP4vPBUoOBaFk20jlW2POQ7NHqFdm6E6Jzj
 p4vVtst3Uv5fPd9VC3RAWPlHTnqimpsAx+09gLIYbQyijVRQuGHwjrFAEqoLOUGLriY4uPSa7MQ
 GD63acPnlkqmei8Du1sum/rYk7D2L9SwoxTs+p8OipH8fPR4IVkCknzUxDoxaG4DMLJYb38sxqT
 jo7r3UmEU8enOaXa9EEx5p68iJv4jkV9AAKzZmTfmJPEcYRFH4XYleb7LPhzIp+FLvXhl9/eIp8
 bZ18W4Z580gNhz7fT3TW7nwdoYHMqG8rOy3UkFmglAg3mnvh+MQt8HfICQBi4tdj4u48nnPJ6z6
 2bhpq6Bko
X-Google-Smtp-Source: AGHT+IEAtfSC6XOET9zv5Xpo9QzBNZpofcKg7aTVTo5NDXuFEqP5ZLMmENJbla47x4PuWTUX6iwnOg==
X-Received: by 2002:a05:6a21:999e:b0:1f5:77bd:ecbc with SMTP id
 adf61e73a8af0-201045a726dmr201145637.16.1743698857632; 
 Thu, 03 Apr 2025 09:47:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc2d51e9sm1444493a12.11.2025.04.03.09.47.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:47:37 -0700 (PDT)
Message-ID: <d917e09a-fad4-46c2-9984-200d59b519fe@linaro.org>
Date: Thu, 3 Apr 2025 09:47:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/rx: Fix copy/paste typo (riscv -> rx)
To: qemu-devel@nongnu.org
References: <20250401072052.25892-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401072052.25892-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/1/25 00:20, Philippe Mathieu-Daudé wrote:
> Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().
> 
> Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 65e26e7a6b6..723262f4b54 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -67,7 +67,7 @@ static bool rx_cpu_has_work(CPUState *cs)
>           (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
>   }
>   
> -static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
> +static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
>   {
>       return 0;
>   }
> @@ -228,7 +228,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
>                                          &rcc->parent_phases);
>   
>       cc->class_by_name = rx_cpu_class_by_name;
> -    cc->mmu_index = riscv_cpu_mmu_index;
> +    cc->mmu_index = rx_cpu_mmu_index;
>       cc->dump_state = rx_cpu_dump_state;
>       cc->set_pc = rx_cpu_set_pc;
>       cc->get_pc = rx_cpu_get_pc;

Queued to tcg-next, thanks.

r~

