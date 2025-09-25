Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4647BCAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 18:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1qoe-0000QD-G6; Thu, 25 Sep 2025 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1qoM-0000Ne-SW
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 14:35:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1qoF-0007s2-Lc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 14:35:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77f198bd8eeso1041067b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758825310; x=1759430110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcRFeK7kGXar/AA5fzv9TbIC+eZRMD9qpjob31CaZO8=;
 b=t0LzZPilLs0tXtK0cqWwmetL6R2DgH/ZfaC6I5riGk2FOw8dZ75pjC6X12rrHBKFG5
 U2yA19qPxl/UMRmzpPDu2nzyndKMtLUho3yqGE7EUjPZwrdueSc8GsYg36JtzIfT9TUG
 JXG9t7A5+JFx4RQvrILkZ1mVin/NK6JACsqaF2OSNn6SQZj+GPnr2eKCbj4xsT6axD9A
 n1GIAR+0lVETlx5i3X35fe801cUGYR8LuigCIo3mYugut3nL43LsT9i0D5PyWPbmql1r
 K7N3qIYA2989VxcjWADkykq6VZq442lSd2/58NnhHP3kAEdOqMsTGsKxnoa5DbtMu3cj
 5PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825310; x=1759430110;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IcRFeK7kGXar/AA5fzv9TbIC+eZRMD9qpjob31CaZO8=;
 b=AgPKoFOgtpth4ARUV5U52h6a8wyO2pLsWppL8JHKav4uV9JafRcXqogJFAMxrBymLe
 3yVYFefN8XHITE9rBfekyla9iAjdMwa0Ctsk741AKjOgOOYESub1N5pIBfWI9+q11B3K
 UCz3F2l5XJE8Fl5DK+CaN4f7o7leGmoS7y/h+wC1gOIA7uWr8Xq1z6qOhSpSy+5AQvFh
 cjXbfsubXXUM4e5/gG+DVj1wxkm2SaIqTSYjfzeeVnFdczxLXQsVwk55L7ZizzpbMzZJ
 5996uMupcFiOL65aknUT0Ub3Cn5TnXiZLRdh/p5Fj2VBXfmGtRv2qm7QuYzCc45zq9xk
 4mGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7FSzhxASrY9xfnNxN6Gh9kUduF/D0bFUrEh2G5PCevHQqr5vtwKiRNfkcrcp2dBtZVlask0sfYgGZ@nongnu.org
X-Gm-Message-State: AOJu0YyH7wqXtx4FGCmODdeXt6Z/5chS/1VpAFpJEZwcOA2GVlwACMf0
 r/Cojl2BUkyqMg0fpmjrw36y0Nxa+Bq/VIFyqZYoJCrzH/KAfKmr7ZssHPC9xpUOn8U+jUjh6VD
 p6Dkd
X-Gm-Gg: ASbGncsjuVm9PmLYydCaO6bASisXxoK3/32tVI2wyKMkPL++IkykebANDSnClIevejA
 3e0suobNRL6w5JytuSelKDQtL981VgEWnMJTtcE+uLIgdEy3UKQ1/7Tjhf96dteQ3ef/7q2nf0Y
 Txkq1q2R9dgrihb46exR+lW5HNb7D18c4yGGOL80rkLRoR6t9k+pWj8Pvg4p0bQwvrGCWcGta2M
 vEy5915zL4yM6sgZbA0Rz6RF23z5tm/jizmsiqBu6NjoRTLjiUe9B5DrOmbJmoRRD9brFjpRyey
 sGhLyHliyMROlnUq6Bp6Hj2gDy8xPd18mQhGK6/m66TNnpY/yIK3ZUGfB9oyXsNRrA6DjvoUhVS
 95grz/RsmsQimRiWKiPpjjaa3SuzHZWCUW3ei
X-Google-Smtp-Source: AGHT+IGmRcQ1UgqGq4dO9MmHrjdPgEUidrLYx4l3SCQpuEh0eR3hwfdiVYWl5meuzjucrxVakpwbow==
X-Received: by 2002:a05:6a20:94c7:b0:249:f8ac:2e6e with SMTP id
 adf61e73a8af0-2e7c5090e25mr5297272637.5.1758825309646; 
 Thu, 25 Sep 2025 11:35:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102b23634sm2596568b3a.66.2025.09.25.11.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 11:35:09 -0700 (PDT)
Message-ID: <ce690dcf-14c0-4448-8013-0a5ae1d377b2@linaro.org>
Date: Thu, 25 Sep 2025 11:35:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Remove pointless @cpu_halted TCGv
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250925012454.60602-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925012454.60602-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/24/25 18:24, Philippe Mathieu-Daudé wrote:
> Avoid registering a TCGv to write the generic CPUState::halted
> field. Access it directly via @env in both STOP / HALT opcodes.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250924171308.53036-1-philmd@linaro.org>
> ---
>   target/m68k/translate.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 0cee54f4900..eb1ba150745 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -44,8 +44,6 @@
>   #undef DEFO32
>   #undef DEFO64
>   
> -static TCGv_i32 cpu_halted;
> -
>   static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
>   static TCGv cpu_dregs[8];
>   static TCGv cpu_aregs[8];
> @@ -77,9 +75,6 @@ void m68k_tcg_init(void)
>   #undef DEFO32
>   #undef DEFO64
>   
> -    cpu_halted = tcg_global_mem_new_i32(tcg_env,
> -                                        -offsetof(M68kCPU, env) +
> -                                        offsetof(CPUState, halted), "HALTED");
>       p = cpu_reg_names;
>       for (i = 0; i < 8; i++) {
>           sprintf(p, "D%d", i);
> @@ -4506,7 +4501,8 @@ DISAS_INSN(halt)
>           gen_exception(s, s->pc, EXCP_SEMIHOSTING);
>           return;
>       }
> -    tcg_gen_movi_i32(cpu_halted, 1);
> +    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
> +                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
>       gen_exception(s, s->pc, EXCP_HLT);
>   }
>   
> @@ -4522,7 +4518,8 @@ DISAS_INSN(stop)
>       ext = read_im16(env, s);
>   
>       gen_set_sr_im(s, ext, 0);
> -    tcg_gen_movi_i32(cpu_halted, 1);
> +    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
> +                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
>       gen_exception(s, s->pc, EXCP_HLT);
>   }
>   


