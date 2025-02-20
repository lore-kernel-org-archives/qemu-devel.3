Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DDDC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlErq-0003fm-ML; Thu, 20 Feb 2025 17:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlErj-0003fW-Lo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:17:55 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlErh-0003cT-JN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:17:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so9471415e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740089871; x=1740694671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yF+fopmllaap59CY6h5GAJdIBfkLucbbvQLWnvjA0mg=;
 b=xnh7P2oNuzIl74Sy1QHDSoj1hIfT10ljeXOmCz892LedIggQSpUtoSzrAK/neVTdo6
 yspcUePpXlCs8mSdb75JmzJ5m+dbSU+8glnHWYq/wI4g3F3Ti1JEA1d+hyQpv0NB9U2X
 TGyhiY2NSu0OI/tXEwrl+7vqzHyP45qsqDmDkGABA5nlINfbbmktQStjPBePI74WBtH3
 xbxDYOXMrVMSQjiy2aBQnOkjsoTRGjEPCohXlrmT6trQb+911FVHOHjc4ViOJRDJ5VEz
 UYttIZ1SF/HYLsRWzY0lMobwDV//ZLjFH8xVaIx+Lpirtpo/dt9PoAN+Aiop5c5eCfSR
 8CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740089871; x=1740694671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yF+fopmllaap59CY6h5GAJdIBfkLucbbvQLWnvjA0mg=;
 b=qLyH8rUDZZuBD1P6fPyK29X8lX8upZALMOU+9hTkIPRa9SuQKIMnpK/HpDsWj7AcVk
 Qndm29hX1JN3jgnkR3qoXeczkJQrrJQ4oR/FBgmZgjFJds3F1x6UbT/Q7zAR1oRbln6l
 OdTsxvBIQQw5wCfz3hlFUbbQOk0vKC4QMjj0ZwNQX9iHeUBCZW8Actfg86yA9TPzwnYu
 OFdSeeCtPHv6MAsINL1tNoQIYtqR32xV+++iF38lMDiqyUpUjQXag+uNmJhAi6FAGWAB
 9z+UkYwsSG5JG/0+9aa4vYNvsQ4bcUi7tfkHyFUIKHawkBuOriYa2zMExpobXUTsSfLu
 OZbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVafm/IHZGvkdsq6Y2Eh3kJAOA/aIbVxDAVuFNcRyhtgB6Bmgria1OCcyS5Nd5PEHUa7vzn/eD1CFE8@nongnu.org
X-Gm-Message-State: AOJu0Yzu8UxJyldAK8Z4p/7QaD9Z+2rbIInyn2Ogu+QXY8HNoGOltMv1
 5a6cH8lAIU+PheUHjjyc1q5A7xauAycqLx6AVO1aXjpPbspktiE+eAojdOQPpMneVYuFGwzy+U0
 JMUc=
X-Gm-Gg: ASbGncv4n/H4NX5QQqF/7IMxVYjRBnVAubetzjl3RbwH0YiyZxW0S9cjcDaUl6Y1X76
 HZNBnDJrrgu024eoZ9Yn56LilqROuaiowOuYeuLJqcV0uf/eMQ7A6z7i9dMxR2u5cVREZj4UkX2
 sHIxYLfBVykpsHIXJ52s75qnUG8+ZLnMEiSNZPQhyVhMCw8RuerBsHd3zXAPcsuwMxL0C/B4Lnp
 7xF1K9fCdT1V0s0abyOBw2v7ISVSsBMDBlRp5jsviTeElqGYoAJpbfvrtRJ8310XJrPSL8C5Etf
 84Q8wstAouf5T/fUogUvJ6YWSlX1EU2QlLZtQSIvvHoikdkC9qxG8Zvm5pI=
X-Google-Smtp-Source: AGHT+IFaPjUIQPXi0Ep1e8gQUwpRuJ4u4AhFSlM9As3NjMO0jMS89xTHA3kUkJocfH9eC9tbL91WXg==
X-Received: by 2002:a05:6000:1543:b0:38d:b610:190b with SMTP id
 ffacd0b85a97d-38f6f0bec4emr772844f8f.46.1740089871271; 
 Thu, 20 Feb 2025 14:17:51 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4344sm21995672f8f.13.2025.02.20.14.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 14:17:50 -0800 (PST)
Message-ID: <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
Date: Thu, 20 Feb 2025 23:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Use the fully general extract opcodes instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  10 -
>   tcg/aarch64/tcg-target-has.h     |  10 -
>   tcg/arm/tcg-target-has.h         |   4 -
>   tcg/i386/tcg-target-has.h        |  10 -
>   tcg/loongarch64/tcg-target-has.h |  10 -
>   tcg/mips/tcg-target-has.h        |  13 -
>   tcg/ppc/tcg-target-has.h         |  12 -
>   tcg/riscv/tcg-target-has.h       |  10 -
>   tcg/s390x/tcg-target-has.h       |  10 -
>   tcg/sparc64/tcg-target-has.h     |  10 -
>   tcg/tcg-has.h                    |   6 -
>   tcg/tci/tcg-target-has.h         |  10 -
>   tcg/optimize.c                   |  61 +----
>   tcg/tcg-op.c                     | 430 ++++++++-----------------------
>   tcg/tcg.c                        |  46 ----
>   tcg/tci.c                        |  36 ---
>   docs/devel/tcg-ops.rst           |  14 -
>   tcg/aarch64/tcg-target.c.inc     |  22 +-
>   tcg/arm/tcg-target.c.inc         |   7 -
>   tcg/i386/tcg-target.c.inc        |  24 +-
>   tcg/loongarch64/tcg-target.c.inc |  22 +-
>   tcg/mips/tcg-target.c.inc        |  20 +-
>   tcg/ppc/tcg-target.c.inc         |  17 +-
>   tcg/riscv/tcg-target.c.inc       |  22 +-
>   tcg/s390x/tcg-target.c.inc       |  22 +-
>   tcg/sparc64/tcg-target.c.inc     |  14 +-
>   tcg/tci/tcg-target.c.inc         | 102 +++-----
>   27 files changed, 147 insertions(+), 827 deletions(-)


> @@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>       case -1:
>           tcg_gen_mov_i64(ret, arg1);
>           return;
> -    case 0xff:
> -        /* Don't recurse with tcg_gen_ext8u_i64.  */
> -        if (TCG_TARGET_HAS_ext8u_i64) {
> -            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
> -            return;
> -        }
> -        break;
> -    case 0xffff:
> -        if (TCG_TARGET_HAS_ext16u_i64) {
> -            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
> -            return;
> -        }
> -        break;
> -    case 0xffffffffu:
> -        if (TCG_TARGET_HAS_ext32u_i64) {
> -            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
> -            return;
> +    default:
> +        /*
> +         * Canonicalize on extract, if valid.  This aids x86 with its
> +         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
> +         * which does not require matching operands.  Other backends can
> +         * trivially expand the extract to AND during code generation.
> +         */

Could also use s/0/ofs/ like for 32-bit.

> +        if (!(arg2 & (arg2 + 1))) {
> +            unsigned len = ctz64(~arg2);
> +            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
> +                tcg_gen_extract_i64(ret, arg1, 0, len);
> +                return;
> +            }
>           }
>           break;
>       }


> @@ -2720,54 +2592,20 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,

I note deposit_z_i32/i64 are not documented.


> @@ -2787,10 +2625,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
>           tcg_gen_shri_i64(ret, arg, 64 - len);
>           return;
>       }
> -    if (ofs == 0) {
> -        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
> -        return;
> -    }
>   
>       if (TCG_TARGET_REG_BITS == 32) {
>           /* Look for a 32-bit extract within one of the two words.  */
> @@ -2804,39 +2638,34 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
>               tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
>               return;
>           }
> -        /* The field is split across two words.  One double-word
> -           shift is better than two double-word shifts.  */
> -        goto do_shift_and;
> +
> +        /* The field is split across two words. */
> +        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg),
> +                             TCGV_HIGH(arg), ofs);
> +        if (len <= 32) {
> +            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(ret), 0, len);
> +            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
> +        } else {
> +            tcg_gen_extract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg),
> +                                ofs, len - 32);
> +        }
> +        return;

This change would look better in a preliminary patch.

Otherwise, chapeau! 🎩

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }
>   
>       if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
>           tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
>           return;
>       }
> +    if (ofs == 0) {
> +        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
> +        return;
> +    }
>   
>       /* Assume that zero-extension, if available, is cheaper than a shift.  */
> -    switch (ofs + len) {
> -    case 32:
> -        if (TCG_TARGET_HAS_ext32u_i64) {
> -            tcg_gen_ext32u_i64(ret, arg);
> -            tcg_gen_shri_i64(ret, ret, ofs);
> -            return;
> -        }
> -        break;
> -    case 16:
> -        if (TCG_TARGET_HAS_ext16u_i64) {
> -            tcg_gen_ext16u_i64(ret, arg);
> -            tcg_gen_shri_i64(ret, ret, ofs);
> -            return;
> -        }
> -        break;
> -    case 8:
> -        if (TCG_TARGET_HAS_ext8u_i64) {
> -            tcg_gen_ext8u_i64(ret, arg);
> -            tcg_gen_shri_i64(ret, ret, ofs);
> -            return;
> -        }
> -        break;
> +    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
> +        tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, 0, ofs + len);
> +        tcg_gen_shri_i64(ret, ret, ofs);
> +        return;
>       }
>   
>       /* ??? Ideally we'd know what values are available for immediate AND.
> @@ -2844,7 +2673,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
>          so that we get ext8u, ext16u, and ext32u.  */
>       switch (len) {
>       case 1 ... 8: case 16: case 32:
> -    do_shift_and:
>           tcg_gen_shri_i64(ret, arg, ofs);
>           tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
>           break;


