Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91EBC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 21:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYBNr-0000AN-PV; Wed, 15 Jan 2025 16:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYBNq-0000A7-1g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:57:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYBNn-0001jh-KK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:57:05 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso264757f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 13:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736978222; x=1737583022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fq1vlsBPUj22Cj9Ts8kjOrLtYgi9FojWR4XTk16tFOg=;
 b=Tcq/qx1Hk5I1pXm02lQdCCkELkSktZ5R0mKeuH/2Qg8R5f2nrRyGuelmJ3wGJMCx1t
 HyNxefMFVrzGQlUPryr48iH5XvvXmXghdYMgmo0QRcS2R0yXNHxGXM0b3Q+YLq0Q6R9w
 /TWUaU6VixqhOFWeH/rCOB2pog6NSnRxHDpo7K3dcrl03KO4+LsUFUWLlunF0djxXZIF
 w5cgbQ9UwisxQQqJooAdHi0I86jVSFeH4tNG3nexre7XMA2CGLadLsiAe5GcVR4MTgVG
 SxI5Q8q2evkSecofF6UdAiB8ar7Mq1wmY9tUUX20iZou/j20PqR7jQXxjrqt2BlaAVdD
 NXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736978222; x=1737583022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq1vlsBPUj22Cj9Ts8kjOrLtYgi9FojWR4XTk16tFOg=;
 b=nvEKmtkMuMbmGuQHWSRHb4PRQtViaF3xEZaVoMfuCbwHwlP/xYIc17/HWJvUzUPmwm
 ovwaZCHAzp6wZIz5xRBVxmpZwxF2wAVB9qQdp2Dv+eecWivcrtoGgOZHUJJ5btsL6wn5
 CxFAKcSRypDY0a62G/ZweYXsSv4xkl5kMzddLSeqs2atHNnyJwHzqHVRTeCc4HYv8Dt/
 R3mvMlGh0ZB9RrKyYvHZNG/5e9Fy8FWnMKPpyP/gOvYq8E6FDEOKQKA4hluJdEt21X/y
 iFvZZpB2rgKkbPs4PpOkhNRBKrHHRrrz+XNRXh8db+cjjC7ccwIzSAG8BBy1uRqfCmGL
 p3fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2hg3WTJXCcp38fIoL+2DY7sc2TSTchlIxu4n3+SUq7chtdV57pU9FAG/PWUvDsW81ZWgFRb5DHeCx@nongnu.org
X-Gm-Message-State: AOJu0Yw9V3HSkA+EHqLO/mSH00TbZ2FIjkA85vdDhMclO3rbFR6m1G0L
 GQE6cHq/MRJKPiCJFkhv8HiBLEQ6DbiNZE56CTt7QI8Y9cNJm0rJHan4JrNqyjM=
X-Gm-Gg: ASbGncvZ3rU0Wh4lJvMTh1/wfoGTNx5x2UBmtjk5Y4WUH4loM2DWMzXS0bHG3E7rOsw
 hMnk/D6N12hdO0YcOr9ZxTVA4hEAmu8pLZQn34EZgtzgfIW9dBY1CyqEXfHxewo6xasqLKzRXOA
 81f0m9Yc3AlPDPfCxjtBayW9nrZXOxQVLhlgRD4tj/Fl9H5ZOTXkUBaIV+wbybP02coj13wRuHW
 sjbZGj4Yhas/SQlBob0+HMWHuNPmNjUAV3o/PEAa51vIt6RHkNidd7hTM2OqMWaZMJfFllbH6lA
 +znhszhVh275THdGYnM3/7fF
X-Google-Smtp-Source: AGHT+IEqOzSoE/uJECAtHbOYVg7wIqHApcRyZd+//+8Ua8GeXfs0JjtzWslSP+a5Qe4rGnqYgW6A9g==
X-Received: by 2002:a5d:598d:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38a873240c8mr30102696f8f.33.1736978221956; 
 Wed, 15 Jan 2025 13:57:01 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38be66b01c7sm3370782f8f.22.2025.01.15.13.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 13:57:00 -0800 (PST)
Message-ID: <4554869f-2daf-4a3d-bcdb-eeb66f9953eb@linaro.org>
Date: Wed, 15 Jan 2025 22:56:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/81] tcg/i386: Fold the ext{8,16,32}[us] cases into
 {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-35-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Accept byte and word extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target-has.h | 49 +++++++++++++++++++++++++++----
>   tcg/tcg-has.h             | 12 +++++---
>   tcg/optimize.c            |  8 +++--
>   tcg/tcg-op.c              | 12 +++-----
>   tcg/i386/tcg-target.c.inc | 62 +++++++++++++++++++++++++++++----------
>   5 files changed, 107 insertions(+), 36 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
> index 3ea2eab807..ad69f957a7 100644
> --- a/tcg/i386/tcg-target-has.h
> +++ b/tcg/i386/tcg-target-has.h
> @@ -80,7 +80,7 @@
>   #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
>   #define TCG_TARGET_HAS_deposit_i64      1
>   #define TCG_TARGET_HAS_extract_i64      1
> -#define TCG_TARGET_HAS_sextract_i64     0
> +#define TCG_TARGET_HAS_sextract_i64     1
>   #define TCG_TARGET_HAS_extract2_i64     1
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
> @@ -130,10 +130,47 @@
>        (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
>   #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
>   
> -/* Check for the possibility of high-byte extraction and, for 64-bit,
> -   zero-extending 32-bit right-shift.  */
> -#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
> -#define TCG_TARGET_extract_i64_valid(ofs, len) \
> -    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
> +/*
> + * Check for the possibility of low byte/word extraction, high-byte extraction
> + * and zero-extending 32-bit right-shift.
> + *
> + * We cannot sign-extend from high byte to 64-bits without using the
> + * REX prefix that explicitly excludes access to the high-byte registers.
> + */
> +static inline bool
> +tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
> +{
> +    switch (ofs) {
> +    case 0:
> +        switch (len) {
> +        case 8:
> +        case 16:
> +            return true;
> +        case 32:
> +            return type == TCG_TYPE_I64;
> +        }
> +        return false;
> +    case 8:
> +        return len == 8 && type == TCG_TYPE_I32;
> +    }
> +    return false;
> +}
> +#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
> +
> +static inline bool
> +tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
> +{
> +    if (type == TCG_TYPE_I64 && ofs + len == 32) {
> +        return true;
> +    }
> +    switch (ofs) {
> +    case 0:
> +        return len == 8 || len == 16;
> +    case 8:
> +        return len == 8;
> +    }
> +    return false;
> +}
> +#define TCG_TARGET_extract_valid  tcg_target_extract_valid
>   
>   #endif
> diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
> index 65b6a0b0cf..8ed35be8c3 100644
> --- a/tcg/tcg-has.h
> +++ b/tcg/tcg-has.h
> @@ -56,11 +56,15 @@
>   #ifndef TCG_TARGET_deposit_i64_valid
>   #define TCG_TARGET_deposit_i64_valid(ofs, len) 1
>   #endif
> -#ifndef TCG_TARGET_extract_i32_valid
> -#define TCG_TARGET_extract_i32_valid(ofs, len) 1
> +#ifndef TCG_TARGET_extract_valid
> +#define TCG_TARGET_extract_valid(type, ofs, len) \
> +    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_extract_i32 \
> +     : TCG_TARGET_HAS_extract_i64)
>   #endif
> -#ifndef TCG_TARGET_extract_i64_valid
> -#define TCG_TARGET_extract_i64_valid(ofs, len) 1
> +#ifndef TCG_TARGET_sextract_valid
> +#define TCG_TARGET_sextract_valid(type, ofs, len) \
> +    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_sextract_i32 \
> +     : TCG_TARGET_HAS_sextract_i64)
>   #endif
>   
>   /* Only one of DIV or DIV2 should be defined.  */
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index c363c5c04b..cd8ad712c4 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2362,8 +2362,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
>           xor_opc = INDEX_op_xor_i32;
>           shr_opc = INDEX_op_shr_i32;
>           neg_opc = INDEX_op_neg_i32;
> -        if (TCG_TARGET_extract_i32_valid(sh, 1)) {
> +        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
>               uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
> +        }
> +        if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
>               sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
>           }
>           break;
> @@ -2373,8 +2375,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
>           xor_opc = INDEX_op_xor_i64;
>           shr_opc = INDEX_op_shr_i64;
>           neg_opc = INDEX_op_neg_i64;
> -        if (TCG_TARGET_extract_i64_valid(sh, 1)) {
> +        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
>               uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
> +        }
> +        if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
>               sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
>           }
>           break;
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index ab5ccd8dcb..d813a7f44e 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1014,8 +1014,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
>           return;
>       }
>   
> -    if (TCG_TARGET_HAS_extract_i32
> -        && TCG_TARGET_extract_i32_valid(ofs, len)) {
> +    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
>           tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
>           return;
>       }
> @@ -1077,8 +1076,7 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
>           }
>       }
>   
> -    if (TCG_TARGET_HAS_sextract_i32
> -        && TCG_TARGET_extract_i32_valid(ofs, len)) {
> +    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
>           tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
>           return;
>       }
> @@ -2811,8 +2809,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
>           goto do_shift_and;
>       }
>   
> -    if (TCG_TARGET_HAS_extract_i64
> -        && TCG_TARGET_extract_i64_valid(ofs, len)) {
> +    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
>           tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
>           return;
>       }
> @@ -2917,8 +2914,7 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
>           return;
>       }
>   
> -    if (TCG_TARGET_HAS_sextract_i64
> -        && TCG_TARGET_extract_i64_valid(ofs, len)) {
> +    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
>           tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
>           return;
>       }
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 047c5da81c..afff56956f 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3036,6 +3036,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>   
>       case INDEX_op_extract_i64:
>           if (a2 + args[3] == 32) {
> +            if (a2 == 0) {
> +                tcg_out_ext32u(s, a0, a1);
> +                break;
> +            }
>               /* This is a 32-bit zero-extending right shift.  */
>               tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
>               tcg_out_shifti(s, SHIFT_SHR, a0, a2);
> @@ -3043,28 +3047,53 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           /* FALLTHRU */
>       case INDEX_op_extract_i32:
> -        /* On the off-chance that we can use the high-byte registers.
> -           Otherwise we emit the same ext16 + shift pattern that we
> -           would have gotten from the normal tcg-op.c expansion.  */
> -        tcg_debug_assert(a2 == 8 && args[3] == 8);
> -        if (a1 < 4 && a0 < 8) {
> -            tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
> -        } else {
> +        if (a2 == 0 && args[3] == 8) {
> +            tcg_out_ext8u(s, a0, a1);
> +        } else if (a2 == 0 && args[3] == 16) {
>               tcg_out_ext16u(s, a0, a1);
> -            tcg_out_shifti(s, SHIFT_SHR, a0, 8);
> +        } else if (a2 == 8 && args[3] == 8) {
> +            /*
> +             * On the off-chance that we can use the high-byte registers.
> +             * Otherwise we emit the same ext16 + shift pattern that we
> +             * would have gotten from the normal tcg-op.c expansion.
> +             */
> +            if (a1 < 4 && a0 < 8) {
> +                tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
> +            } else {
> +                tcg_out_ext16u(s, a0, a1);
> +                tcg_out_shifti(s, SHIFT_SHR, a0, 8);
> +            }
> +        } else {
> +            g_assert_not_reached();
> +        }
> +        break;
> +
> +    case INDEX_op_sextract_i64:
> +        if (a2 == 0 && args[3] == 8) {
> +            tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
> +        } else if (a2 == 0 && args[3] == 16) {
> +            tcg_out_ext16s(s, TCG_TYPE_I64, a0, a1);
> +        } else if (a2 == 0 && args[3] == 32) {
> +            tcg_out_ext32s(s, a0, a1);
> +        } else {
> +            g_assert_not_reached();
>           }
>           break;
>   
>       case INDEX_op_sextract_i32:
> -        /* We don't implement sextract_i64, as we cannot sign-extend to
> -           64-bits without using the REX prefix that explicitly excludes
> -           access to the high-byte registers.  */
> -        tcg_debug_assert(a2 == 8 && args[3] == 8);
> -        if (a1 < 4 && a0 < 8) {
> -            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
> -        } else {
> +        if (a2 == 0 && args[3] == 8) {
> +            tcg_out_ext8s(s, TCG_TYPE_I32, a0, a1);
> +        } else if (a2 == 0 && args[3] == 16) {
>               tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
> -            tcg_out_shifti(s, SHIFT_SAR, a0, 8);
> +        } else if (a2 == 8 && args[3] == 8) {
> +            if (a1 < 4 && a0 < 8) {
> +                tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
> +            } else {
> +                tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
> +                tcg_out_shifti(s, SHIFT_SAR, a0, 8);
> +            }
> +        } else {
> +            g_assert_not_reached();
>           }
>           break;
>   
> @@ -3747,6 +3776,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extract_i32:
>       case INDEX_op_extract_i64:
>       case INDEX_op_sextract_i32:
> +    case INDEX_op_sextract_i64:
>       case INDEX_op_ctpop_i32:
>       case INDEX_op_ctpop_i64:
>           return C_O1_I1(r, r);

To the best of my knowledge,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


