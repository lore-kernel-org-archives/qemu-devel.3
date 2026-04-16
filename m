Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFECF8D758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOVI-0003HP-6u; Thu, 16 Apr 2026 11:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOVF-0003Gw-Iz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:19:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOVD-0003UY-Tb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:19:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so107531865e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352774; x=1776957574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cm9DhN9qeOqvJmzp7A+inBp61xXu7ErgVFtYcoKtPOk=;
 b=CV6dtYYAxrfO3ZPc9PzRQHABskxmY3Pl5rrTMqLR7W797JH2/nV1ZhbVD3RyeZsV5g
 yuKLmuSSPmaaEj27DSUXlAp8dYtY3j/pY7Xq3tfIejhNTACgTLRhtg35vSWZ0gP45i8+
 JqTJUuEWCFWk+t4PXRkTm0Cez3GeDGr+sxz8ED7ficuFNySqJmiCMDhQrF7hS5iwSJcv
 rG/UNZ5Oc21aZ8XXf8YDZ42bFXhpVOXF+Zl6u0DqyeE70X4/gR7+9RWdUySutBd9D303
 8yim55hPLK19wdoOi+O1W0dysk6TuFVyWM5D7P6PllmU3iGzEWlHUywd10oChvvOpLN0
 ISGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352774; x=1776957574;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cm9DhN9qeOqvJmzp7A+inBp61xXu7ErgVFtYcoKtPOk=;
 b=SoKziJrKIBr/yCq8etyWkeEwG3wqsaj4W55YpvvaqcfCtiVJdKuJLn3OYC7Op0tKcv
 OWpMoo07rLEnKzfnuLbgBxRlCAnJwFPeKksE/0R17BlyhquUP7z2gpKGQ7VcwalRczC6
 /0DuSfnu5myQrGXlnKcU7rdU9xHtkHc0j2V3aRYH3ca6CbaEGGLSPjR0REencdJ6hKJW
 qMmd4R/GhU+enAhIZRtZ2f4zsWUDpycmXglfBr2RQGAdeYhxXg6g99XMnzdU3jAna2xE
 SBgkrI3osNxO+MdwYbUk63BJP1p+BNJJD/AT80ZZJSR4LZb5LHXZqIWDLysuft1p6P3I
 FxVg==
X-Gm-Message-State: AOJu0YzJjs4FMlHX4zaZZ2QKe0gdhlb0Kd8ClctB7M5uY3setSHebshX
 Fe7oHlFRU10+UWAcFEppo40m+Ew0oGgvgEupH6LZ3pvfaDJ+LXB1AV37VuB4Abz8lCwFbYEqjk4
 toXKyIdo=
X-Gm-Gg: AeBDieuCGd7T1XspiN+ryugTff7T4tF+26ZUZRWf6ruW5tgry14FLC1CP6A4CoSU28b
 9rwdTQ2VllXh7GMiG0ct3FRDc//0xnykw6EIB+BAhBGADfKwFwFu/1OGGaalc9b5G1SEzt4ShIN
 cX5Xp6FKqVc6JlEbc26svMxrYC0dfBR24zzG1FBEOlYEmsW9zAs2aqe7MPueawrI0ut9JxXnlXZ
 2cM5sBRk0mdkHGkuK7A1+q1067iT2rUvctvuG3QfzHADXz8TIOD7TfUZEr6t5cljVqHZsCBoeVg
 n0LPSRHlsN0MGrHsl0vg0PGUU5CmrIeCk/VpKGnLkmTJVlCJKd7eNCo3qtdKdnW4Bmk4fa9KtNl
 bnMtdSiGHyIiFnyuEHSxDY1F1RHNyAfL1c/qtJCu2Zsp6GPtNnVF9RVB51nu0ByhWgWlLgpgJZ6
 ul6nWvYu5E2BPVZQhWcPr0wVsE+q8EI65BcM9O/vLqHsvAdGiLt8i0y8X3OXRSuk1vUA==
X-Received: by 2002:a05:600c:8904:b0:488:c257:a73b with SMTP id
 5b1f17b1804b1-488d67effd0mr248706635e9.9.1776352773647; 
 Thu, 16 Apr 2026 08:19:33 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f095ceeesm60522105e9.8.2026.04.16.08.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 08:19:32 -0700 (PDT)
Message-ID: <725334d3-4990-4d16-98b3-4aeac073478f@linaro.org>
Date: Thu, 16 Apr 2026 17:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260416150649.23671-1-philmd@linaro.org>
 <20260416150649.23671-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416150649.23671-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 17:06, Philippe Mathieu-Daudé wrote:
> In preparation of using the MemOp content in the next commit
> (thus stopping ignoring it), pass it as MemOpIdx.
> 
> The helper prototype declaration always took a TCGv_i32 as
> last argument, correct that.
> 
> Rename the ignored 'mem_idx' argument on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/helper.h          | 4 ++--
>   target/mips/tcg/ldst_helper.c | 5 ++++-
>   target/mips/tcg/translate.c   | 7 ++++---
>   3 files changed, 10 insertions(+), 6 deletions(-)


> -#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
> +#define OP_LD_ATOMIC(insn, memop)                                          \
>   static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
>                                   DisasContext *ctx)                         \
>   {                                                                          \
> -    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
> +    MemOpIdx oi = make_memop_idx(memop | MO_ALIGN, mem_idx);               \

Oops, MO_ALIGN is part of the following patch.

> +    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
>   }
>   #endif
>   OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);


