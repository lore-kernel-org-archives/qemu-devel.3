Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF27D1D48A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKOk-0003uF-Tn; Fri, 09 Jan 2026 16:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKOh-0003tV-Q5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:51:56 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKOg-0000zt-5K
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:51:55 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso4841538b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995512; x=1768600312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJUwt/ZasMbcgESAihKpWrAM06/EMJWaUzEEIYq2bo4=;
 b=XDb5ZP5WxHPWB+YIJwiLBnuaKIC7im77saVMqZUFhllCqLsBzM9aEuSwgojJBDKuNx
 AI2bWaXlxzg1lr9Hif5acIu3/bl2aqJrA6UZNQzBkLzJfGfmyW5mRPuFfCLi/eHBGgAw
 Eys/a1wBwBzoi/z5/2TK+pMmqJ7LImtxrONr3h+Y5jrXmUuNqPU24H2JHyiWB7qfOyux
 CtIk3tJnB0Dvtdh+Zv1dtC5PXypp1asMJAc1EB9GF1gkXagcDLsBBGKrqzN3R3VOkRyj
 UWEDqq92GFrHVp2vxYvoIDZcsVydiGTZi7nEKoGe/mKwZD71pnTfPU5CnuzhMShBSOdm
 VILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995512; x=1768600312;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJUwt/ZasMbcgESAihKpWrAM06/EMJWaUzEEIYq2bo4=;
 b=kosgXragLLEI5cAr1lO2NgSRKB0de6tlEtvuudT4lBkd5uEzjdtgcOZheoHs/8dQ+s
 wen0GCsd7in18zZK1dLtN5XJfl7E6WmkZSbT2hto7yEOfSzoQIRM7Z0HIIkEJp83z1Ou
 NKGkuXdSIEE+H7jq7PPVR6R15pJDCaPAsEsixLVlXhUGErTuzbO1uKVxdQEwPZiVyeSE
 5saf73+RlhDoebdy6SCdztsKeXW7ONFj/TXrxwxdFDdqG/sZfzgBhIjDOF3q5r8JBFl5
 KBQsVLWBVRrrpju/SUB/4edygyrBmEbwcemsf92l5QFwJDHNs7eBjiJ9NHh6OKA+wsjd
 GXBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgsuFuHLxowUo077WFzCvgdQTzJYJt+cinJ3+AJFcoLqPRbEYgx3i4Njv9l6MJOZilF1BUommpCc7B@nongnu.org
X-Gm-Message-State: AOJu0YzFNl86D84Lgf7QBIzj3hTM0IRaVoa42NOs13yyAArCIiVQR+SO
 9J1mzyqO4dDgyhgd3O/eRdqIbklAc/kXHqvhDtbXbK5hAxOuUOQ0bWIrfLBsLP9UZF8=
X-Gm-Gg: AY/fxX7R9btfqVRDRtqI+htiv2OEQcWBOIXxYlTJA79wX0A0fL9RHLL+mPgP2INz+tD
 oI0EoseYAvlqhh+YiYKIyC2UScYWAfwZIlbYFlLvPJGvy1U8X+Wc0r8TCd+JHiUNAqs/2zdxQA0
 D2Sd761Xr/sAmoIm3oQB9STNkU7B3nYugIt7Ih/wxZShqCuZ1U1iBA4V0roywtpU9jQzK2O15xG
 MGw72m8g4YyswFbQ1sfJrMQcyoFYNiTef0EmASfeXp8iH8FsJrrwhMa178JdGG9q/BfYWrQfUtG
 qO4+YueQjv+3GBJTsprjEUHuJweHwaGLGauxAcUL4lg6q3W41r2dKJN0IpvGIHew57gF2rue2gq
 LPHFuUOgMPPKuyZmQfgnbFBpHdvh208yWKPMZronF7ZAvkky9WvfCX5XxFhzR8G1hsUHsMHIWdT
 EeO0+rNT/34pEA9j6ERS5G7nBucg==
X-Google-Smtp-Source: AGHT+IGXYV6snTzyAAFh0CHnF+/UEch3HAPHQpdF+KWEXbGjpjpgSLmemAdlPiYNEGeue6nTpaFfvQ==
X-Received: by 2002:a05:6a20:3d93:b0:34e:7bef:e820 with SMTP id
 adf61e73a8af0-3898f997696mr10868106637.41.1767995511804; 
 Fri, 09 Jan 2026 13:51:51 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc8d29516sm11414689a12.19.2026.01.09.13.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:51:50 -0800 (PST)
Message-ID: <70ef91e3-1022-4ff6-a671-5f08f3268aa0@linaro.org>
Date: Sat, 10 Jan 2026 08:51:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> We simply define the 3 variants and call the correct one per arch.
> Since all arch have a single call site (in translate.c), this is as
> good documentation as having a single define.
> 
> The notable exception is target/arm, which has two different translate
> files for 32/64 bits. Since it's the only one, we accept to have two
> call sites for this.
> 
> This is much simpler and safer than trying to define a common functions
> with variadic or unused parameters. The only risk is calling two
> different variants for a single arch, but as mentioned in first
> paragraph, there is no real reason for this to happen.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op.h             | 16 ++++++----------
>   target/alpha/cpu-param.h         |  2 --
>   target/arm/cpu-param.h           |  7 -------
>   target/avr/cpu-param.h           |  2 --
>   target/hexagon/cpu-param.h       |  2 --
>   target/hppa/cpu-param.h          |  2 --
>   target/i386/cpu-param.h          |  2 --
>   target/loongarch/cpu-param.h     |  2 --
>   target/m68k/cpu-param.h          |  2 --
>   target/microblaze/cpu-param.h    |  2 --
>   target/mips/cpu-param.h          |  2 --
>   target/openrisc/cpu-param.h      |  2 --
>   target/ppc/cpu-param.h           |  2 --
>   target/riscv/cpu-param.h         |  7 -------
>   target/rx/cpu-param.h            |  2 --
>   target/s390x/cpu-param.h         |  2 --
>   target/sh4/cpu-param.h           |  2 --
>   target/sparc/cpu-param.h         |  2 --
>   target/tricore/cpu-param.h       |  2 --
>   target/xtensa/cpu-param.h        |  2 --
>   target/alpha/translate.c         |  4 ++--
>   target/arm/tcg/translate-a64.c   |  2 +-
>   target/arm/tcg/translate.c       |  2 +-
>   target/avr/translate.c           |  2 +-
>   target/hexagon/translate.c       |  2 +-
>   target/hppa/translate.c          |  2 +-
>   target/i386/tcg/translate.c      |  2 +-
>   target/loongarch/tcg/translate.c |  2 +-
>   target/m68k/translate.c          |  2 +-
>   target/microblaze/translate.c    |  2 +-
>   target/mips/tcg/translate.c      |  4 ++--
>   target/openrisc/translate.c      |  4 ++--
>   target/ppc/translate.c           |  2 +-
>   target/riscv/translate.c         |  2 +-
>   target/rx/translate.c            |  2 +-
>   target/s390x/tcg/translate.c     |  2 +-
>   target/sh4/translate.c           |  4 ++--
>   target/sparc/translate.c         |  2 +-
>   target/tricore/translate.c       |  2 +-
>   target/xtensa/translate.c        |  2 +-
>   40 files changed, 30 insertions(+), 82 deletions(-)
> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index f3fe2d9386a..bf76749d1c5 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -28,8 +28,7 @@
>   # error Mismatch with insn-start-words.h
>   #endif
>   
> -#if TARGET_INSN_START_EXTRA_WORDS == 0
> -static inline void tcg_gen_insn_start(uint64_t pc)
> +static inline void tcg_gen_insn_start0(uint64_t pc)
>   {
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
> @@ -37,8 +36,8 @@ static inline void tcg_gen_insn_start(uint64_t pc)
>       tcg_set_insn_start_param(op, 1, 0);
>       tcg_set_insn_start_param(op, 2, 0);
>   }
> -#elif TARGET_INSN_START_EXTRA_WORDS == 1
> -static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
> +
> +static inline void tcg_gen_insn_start1(uint64_t pc, uint64_t a1)
>   {
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
> @@ -46,9 +45,9 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>       tcg_set_insn_start_param(op, 1, a1);
>       tcg_set_insn_start_param(op, 2, 0);
>   }
> -#elif TARGET_INSN_START_EXTRA_WORDS == 2
> -static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
> -                                      uint64_t a2)
> +
> +static inline void tcg_gen_insn_start2(uint64_t pc, uint64_t a1,
> +                                       uint64_t a2)
>   {
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
> @@ -56,9 +55,6 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
>       tcg_set_insn_start_param(op, 1, a1);
>       tcg_set_insn_start_param(op, 2, a2);
>   }
> -#else
> -#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
> -#endif
>   

Eh.  If you're going to change anything here, we might as well force the targets to supply 
zeros for the unused parameters and move the last 3-argument tcg_gen_insn_start to 
tcg-op-common.h.


r~

