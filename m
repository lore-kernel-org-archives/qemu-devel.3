Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E86D59D78
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU65a-0002qw-1A; Fri, 12 Dec 2025 11:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU65X-0002pz-NM
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:33:51 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU65U-0000Aj-BZ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:33:50 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ec5df386acso1038429fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765557227; x=1766162027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krN2Tytn3j5xWWSYAqK2+ttDpirASyHYRJe3Wa2c/c4=;
 b=R2edfKCX47eSdF14mE3n/vEZKZ8MF+Hzmh9XVCBx8zH1UZLF4HFLlxZYdJ+/iD+Pe7
 gwU50QWCu1DnK2bKTYDGRWZRnsYhKMpqzzLownYk2lQ0yGTRSX2zO8vpBRN9TfpLvjGP
 mluj+nX/eheuyetKb2D/uj21U/lR2Cz3VKkhxnsdtfTQ8qwu7Slxp9QOkPxjKSIx3zeR
 qat3ZzOjLR7m3X4s/TyUv9jndms138VaECYwXbikB0b8OdrQrpngfz+VPMUsL7diQs4Q
 57Bk8LuYsRGTIdvPaxdlEuYQOsQmV4214CG3ydHmobeE8lFjEIED2GO+sc8aGsdqKUlz
 5DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765557227; x=1766162027;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krN2Tytn3j5xWWSYAqK2+ttDpirASyHYRJe3Wa2c/c4=;
 b=N7yw/vdyvf9fWz3w7/VW8uPkGn4DtgsqhzILv8cpEzZ6M8X9vddL5F3+n+wwYKH+z8
 +hlp3WCyASzrVTaQRqd7WLbBqR8lpRYq6GaaM1k5za3rK+IfXsN38+OiN3nh2AmuivuU
 U/pK8oBmOhzD61UOokr0mGL3D7VNxCOUon1JNJsktLuN2PudbPELM8CJQUuwFfPxRujK
 BNnpGN9BD6W7LHTuISwHutRmSDakEpyrV2b21z2+AHtF5ukvW4yGmVS3ngLyGyUiwpbz
 2KSCzGARx0CKA+WaH93YpJ2w1OWPW8lFzVigb9i9iLOF1iPtwI4NlefT/rAVUJD2qOLy
 LK4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9CrSDGKZUkZCjpsuNZfYfxlLXDksDJSpNahR9TfHx+qVeZ6XqZMMG3zBdlU6IWpOxHW+IMLBa49Ar@nongnu.org
X-Gm-Message-State: AOJu0YzmY7FsaKynLeh57PfVrSYdSKtI1bc8sxvXi8STJFjTbqwnz2oZ
 /e4swjyOxoMtd/k/s6s3/evD6LrB1UBjiSLze73f0gc0C0Ww9zwrlE/uJxsSE/I6cKI=
X-Gm-Gg: AY/fxX7RP0wypZ0AJSuCgE0gVQcy0lvK3EnvDCeq+I2756mY9j3+4+wtiys+eIBRf2g
 sBnkja0D+VLWrW2Yyp8lnbNXd07fEbMkvnFFSW5AdWNhTRrgOXUmA8YbOdKZ6uBlDM/wdYx4t8y
 k/ol4zPS8p1n3908Md864ZKtomuDOtEfWbyYrUt18Kshx+vp7JvavDyATAbE4/oGYELcVIB7xza
 58iyckh6Aq2rOfrX0H1N20/F9XT6IfEq46K0xv50nIsqg5mIJhlChteH3IMgw8F2F6E9lLyiuSs
 O+J2dDVG6hS0mke5+2dyXGcOZMIEwAnr1nKlocPrHaAdd2UpxBfBKrczDgGlkPdUpz+mNWwSk5d
 G8YxVyyVMB1yFiHreRZ/bjpOZePeMuToCwJ51t8gXNItME2WhQnqHVhCFRVvGj0zTVNeKZcuxfv
 /4KH6milYhQ7V0+h88qM2el9mevBdy
X-Google-Smtp-Source: AGHT+IF7nqbiz9++ARvviEOycN3HTif6L1kK1RoOGyVPoHz3eeVEANj2TTyQqM+yQbZY3Loo1WY11w==
X-Received: by 2002:a05:6820:16a7:b0:65b:2795:cb1e with SMTP id
 006d021491bc7-65b451b101cmr1187364eaf.30.1765557226942; 
 Fri, 12 Dec 2025 08:33:46 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe287f66sm1265533fac.1.2025.12.12.08.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:33:46 -0800 (PST)
Message-ID: <017fe7a0-cd5d-4195-9cde-704a80d63dc5@linaro.org>
Date: Fri, 12 Dec 2025 10:33:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 13/22] target/mips: Pass MemOpIdx to atomic
 load helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> Pass a full MemOpIdx at translation, then recover the
> MMU index calling get_mmuidx() in the helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 4 +++-
>   target/mips/tcg/translate.c   | 9 +++++----
>   2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index c1c4a60cf3f..013cd825dac 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -30,8 +30,10 @@
>   #ifndef CONFIG_USER_ONLY
>   
>   #define HELPER_LD_ATOMIC(name, almask, cpu_load)                              \
> -target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
> +target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
>   {                                                                             \
> +    MemOpIdx oi = memop_idx;                                                  \
> +    unsigned mem_idx = get_mmuidx(oi);                                        \
>       if (arg & almask) {                                                       \
>           if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
>               env->CP0_BadVAddr = arg;                                          \
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 54849e9ff1a..c476271d6d5 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -1932,16 +1932,17 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
>       tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
>   }
>   #else
> -#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
> +#define OP_LD_ATOMIC(insn, mop)                                            \
>   static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
>                                   DisasContext *ctx)                         \
>   {                                                                          \
> -    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
> +    MemOpIdx oi = make_memop_idx(mop | mo_endian(ctx), mem_idx);           \
> +    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
>   }
>   #endif
> -OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
> +OP_LD_ATOMIC(ll, MO_SL);
>   #if defined(TARGET_MIPS64)
> -OP_LD_ATOMIC(lld, mo_endian(ctx) | MO_UQ);
> +OP_LD_ATOMIC(lld, MO_UQ);
>   #endif
>   #undef OP_LD_ATOMIC
>   


