Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FE2C369B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oGQ-0006l9-La; Tue, 15 Apr 2025 17:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oGF-0006Yn-JT
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:56:09 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oGD-0005sL-9D
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:56:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-227c7e57da2so54378105ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754163; x=1745358963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=70t6kEoyzZfp+jZA3xS0L2o29MbPdHQGEqz7p2ljxWE=;
 b=sCMvHNPFpX4ngvwMl+PNeF6dyDvtGtfiO++w9n1DRMWJBGspvepDXN9Lrzfgc0inOL
 OZBozcH7v5z6bq5SzacHCNZWlCmdJSAB9djPHOdr46pDuUJUJ6aQ0jUIzw7uA10JM8ci
 866JsQ3Z2nOY9TYVvBGRMMJZScJLfY13c3N+EDV9/V845gG5ayW1llw5TYFRioQrVPzO
 96uDHED4ZQg+j6gmauLrKc7JnENfDfNxUcXHiesG0AEES9QDFSifUIx6IiJMZzMhgsEA
 oZFN7YyzY0p6urhqaSIEGGmYoi680UCUgHA1CWoeV2pEf9F3m6tNH1UVSZgpKz8iHV69
 YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754163; x=1745358963;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70t6kEoyzZfp+jZA3xS0L2o29MbPdHQGEqz7p2ljxWE=;
 b=lOY9vymKLtt3IeTFqxwjbiqhiBD6HNMwIccprcsF58iXfvAn8f4uEv3yZVdI3Som6q
 RreqxvmNKf5xRxZKLxaGAEtryPkqlsZNUkg0kBYx63KWErHZVvSz9sWQj1EY5KmC2kXS
 d7bXIG/qTGwSu1um42pMr+8VLNjxceFXSKqMgzjGTTLDIC8aBa4gbKsASoA4GgaaUxiE
 dxFY6WLd649v4RJAndW4sKaJBcl25BQ7EBrRl7+G921LAvhuyCzqDhOwmxlh+dapji9/
 ddHqAStBlf1O5si+VPoUmWEUbwIy3vF6YnYeHpqVnchT987Z6YtcnIH7b+Ys5KplC/Fi
 fChg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPxp24axhpG8igNsb0RauUsT9XIvh8FGIzH5VLXPOeato8pYWLDmsuNEjm49IDIPVlTZCPSapzLaOw@nongnu.org
X-Gm-Message-State: AOJu0YwnjTwzOdJ24zbcImXh80a67ifYbv6ux8xCAbyEhw351WFgB6No
 9ZgFGTqU9XMSQY5PD9CtIV/1i5b5JtCBc20L73ptGPwzyQ9TcirUEVLObJSfwuHUwAwOqlugg0a
 XUx8=
X-Gm-Gg: ASbGnct1JRlQ4rMup0ammuQkyQphBtScm4aKcHpeIfF93QgY1eZ89iWG8UFAlC7B5jq
 QpBYgZdDxOeZKhv6hL1/XZwAZ8pgxoxcJaOBaetRzWagivQMlu+jQ49uZsChL1A9d7yhIF62KtI
 aJxGCRr+dDCR2HJPJ+ASSWwyv3EYHg6CjHCAtzwt+c3ustsqn//w0FdAO/BU59bwWzK1YTBQ1mv
 GbsYUfzOIxH5nA81ZwZRoFhhfBdPSCmdEO0bMVJmAhy5f9KPPGTjDfBD65cGSLr5Db03QDH3800
 4Z+xQM/JM538UDYlKbKmixnkCYBdL7K7Hcz59tD8+Dp3ohZur/h+Jw==
X-Google-Smtp-Source: AGHT+IF3GX9Fe3751LAsbMu++SHdWBpwa0JlNcBUvAq47oDf4/Jm2Qnqn5M4yzjfYBEuo03sNCqH6w==
X-Received: by 2002:a17:902:f791:b0:21c:fb6:7c3c with SMTP id
 d9443c01a7336-22c318d5332mr12806695ad.17.1744754163520; 
 Tue, 15 Apr 2025 14:56:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d14asm247105ad.92.2025.04.15.14.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:56:03 -0700 (PDT)
Message-ID: <3f5ee83e-7b2a-40fa-b5c4-5bfbe27f3a84@linaro.org>
Date: Tue, 15 Apr 2025 14:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 098/163] tcg: Convert extu_i32_i64 to TCGOutOpUnary
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-99-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-99-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 15 ++++++++++++---
>   tcg/aarch64/tcg-target.c.inc     |  2 --
>   tcg/i386/tcg-target.c.inc        |  2 --
>   tcg/loongarch64/tcg-target.c.inc |  2 --
>   tcg/mips/tcg-target.c.inc        |  2 --
>   tcg/ppc/tcg-target.c.inc         |  2 --
>   tcg/riscv/tcg-target.c.inc       |  2 --
>   tcg/s390x/tcg-target.c.inc       |  4 ----
>   tcg/sparc64/tcg-target.c.inc     |  2 --
>   tcg/tci/tcg-target.c.inc         |  2 --
>   10 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 35f192e483..b6c1efa828 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1083,6 +1083,16 @@ static const TCGOutOpUnary outop_exts_i32_i64 = {
>       .base.static_constraint = C_O1_I1(r, r),
>       .out_rr = tgen_exts_i32_i64,
>   };
> +
> +static void tgen_extu_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
> +{
> +    tcg_out_extu_i32_i64(s, a0, a1);
> +}
> +
> +static const TCGOutOpUnary outop_extu_i32_i64 = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out_rr = tgen_extu_i32_i64,
> +};
>   #endif
>   
>   /*
> @@ -1140,6 +1150,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>   #else
>       OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
>       OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
> +    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
>   #endif
>   };
>   
> @@ -5427,9 +5438,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>       /* emit instruction */
>       TCGType type = TCGOP_TYPE(op);
>       switch (op->opc) {
> -    case INDEX_op_extu_i32_i64:
> -        tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
> -        break;
>       case INDEX_op_extrl_i64_i32:
>           tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
>           break;
> @@ -5490,6 +5498,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>   
>       case INDEX_op_bswap64:
>       case INDEX_op_ext_i32_i64:
> +    case INDEX_op_extu_i32_i64:
>           assert(TCG_TARGET_REG_BITS == 64);
>           /* fall through */
>       case INDEX_op_ctpop:
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 68f7a1cec2..44314f6a0f 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -3176,7 +3175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 14b912beb7..8371cfaf5a 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -4000,7 +3999,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, 0);
>   
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>           return C_O1_I1(r, r);
>   
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index e2dbd08e12..3a85b6f4ba 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -2458,7 +2457,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(r, r, r);
>   
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>       case INDEX_op_ld8s_i32:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index e992a468eb..b6b7070fbb 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -2390,7 +2389,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index fea767573c..e1767f1d6c 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -4269,7 +4268,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index e5fe15c338..48d4325097 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -2873,7 +2872,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       case INDEX_op_extrh_i64_i32:
>           return C_O1_I1(r, r);
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 5c5a38c2c8..d81b8fb8f4 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();
> @@ -3470,9 +3469,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_extu_i32_i64:
> -        return C_O1_I1(r, r);
> -
>       case INDEX_op_qemu_ld_i32:
>       case INDEX_op_qemu_ld_i64:
>           return C_O1_I1(r, r);
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index e93ef8e7f2..d52907f7e3 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       default:
>           g_assert_not_reached();
>       }
> @@ -1908,7 +1907,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_qemu_ld_i32:
>       case INDEX_op_qemu_ld_i64:
>           return C_O1_I1(r, r);
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index ecff90404f..3cf2913acd 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_ld32u_i64:
>       case INDEX_op_ld32s_i64:
>       case INDEX_op_ld_i64:
> -    case INDEX_op_extu_i32_i64:
>           return C_O1_I1(r, r);
>   
>       case INDEX_op_st8_i32:
> @@ -1108,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>       case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
>       case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
> -    case INDEX_op_extu_i32_i64:
>       case INDEX_op_extrl_i64_i32:
>       default:
>           g_assert_not_reached();

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


