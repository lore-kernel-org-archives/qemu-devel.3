Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D796FC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Co-0001od-BN; Wed, 16 Apr 2025 15:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Cn-0001oL-II
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:13:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Cl-0005cX-9H
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:13:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so359905ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830829; x=1745435629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxaMlnvFs3iGUNcGv9SXidYffNLt8o7i23jLHnA0ECA=;
 b=ZxS+2xYoAS1mW0GWOgFoqFiY+3/213Ly05pCmlX4w2iZuPcckqA7jgPVxyHpcArbjP
 x01vA04ORJCFHPL7c0m5DMPVxlj8TgZs1lvjssqyY7jjupWHB9Evi8tIglcgY+i2ky5I
 oyJaQLc57hMKHWuC8/jKGQBt2gAhJgr7vUmF7u7eC74BGbTFKyVCKNUuZ371EAEmUkGt
 L6aHaWInVBlWpv5tPJCRLIXLLFXJOEMmiIaaZvsM73sdYmD6YJ+eyRpme3R674+NkPFW
 aaDIrOigc/xZBzNicwleJGKnkWV+yGFHJbx0TcPTT+yET1hwZtxFg508gYClOLQ55qZ4
 4Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830829; x=1745435629;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxaMlnvFs3iGUNcGv9SXidYffNLt8o7i23jLHnA0ECA=;
 b=jkrF4vjIeYHXL/Mo+bXtllvp41WU1JYXsONZjtF2Po67y0QzG96W29Vbf1luKGXjWD
 jynHqubKT5ZcTY1+OkiDrWp4zk/NIX9bA6pASOgnGRrEC8e6vVkZQFWziom2RH2LJ9jh
 TttNjGBLtCXPERxBHYanXC3cVWiO22mOR4/l9wsHo4Gx45YK4jRbYYFIQ+hHHMs1YRe/
 3Ulv1NS+chMcpOeBR2fNWe7GSTMIfrZh3dr7F6SyOdltfQ/7MifKbdxNAZjb3V2zjgzr
 UbErBrmXKHJyIglbasnn1b9jrjwqaCptWcYpyCGUgBE4uxj4RfsSk0tLrxwMIzOnXLjF
 Sqmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjgkVAQF2FVUmUah313LZFSTCl9i59dxxpAayK1XYQVbboS3pcBsbhiidJh6PrHEhe+QsiX5RAnOHO@nongnu.org
X-Gm-Message-State: AOJu0Yw3+K5Y/riPVqvLV7pbnrEqPx2zND/Fgw6rgbq4FbILSA73+a0g
 qJ6NBGDNJSqJF+vKe3WIG7L2uv7IGqF1zFoV8XxjJJSHHwAxTfYyNm+zrsIr/eMim4D+F4iV75J
 +
X-Gm-Gg: ASbGncv8VGQxz75W40NDUmTWXmbjYr/zSE7pgsq983ZVVbi7RA5UqJI1/mXro1ZpAy7
 hWEzOjQez1kPzbRT6F/Vz8NjFhYrrhUe/VTDT6NnzxatZ5wRlrUlfBpKpUZK+xHttey0fVprRu5
 IQLgzDRVOSrQ2pkwbaqjEJT5lYDfPAs6OMaX2AL1Rk+7juHcQcjSweobhFu59sL4IgZqt7G0xYF
 k/whyjWd4bp+YfaitJwQEqpT/KaYSQ3HVnVf1lEIgjZ/+re0UbbIP3BokhojYajl6OPGGha8fPI
 2vJGbBBW4lhskEJL3lF7YOTJE+alwNZDrxfnufzk7rRtkqLP8uBGhTYL88oKNbHf
X-Google-Smtp-Source: AGHT+IGKQTmdSO46h1HatB5o8c2FewqcVCSRHOeklEsDLtUlC/h9Q5ntRy1PVWMWeBkKZJ0RetDzdg==
X-Received: by 2002:a17:903:2391:b0:223:6254:b4ba with SMTP id
 d9443c01a7336-22c358e21c4mr41839345ad.13.1744830829378; 
 Wed, 16 Apr 2025 12:13:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd219bf3dsm11180102b3a.16.2025.04.16.12.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:13:48 -0700 (PDT)
Message-ID: <88e3297d-92c3-4a6d-a35c-dfb7e3d73a82@linaro.org>
Date: Wed, 16 Apr 2025 12:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 134/163] tcg/aarch64: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-135-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-135-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
>   tcg/aarch64/tcg-target-con-set.h |  1 -
>   tcg/aarch64/tcg-target-has.h     |  8 ++--
>   tcg/aarch64/tcg-target.c.inc     | 75 --------------------------------
>   3 files changed, 4 insertions(+), 80 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
> index 02a0be66fd..d0622e65fb 100644
> --- a/tcg/aarch64/tcg-target-con-set.h
> +++ b/tcg/aarch64/tcg-target-con-set.h
> @@ -36,4 +36,3 @@ C_O1_I2(w, w, wZ)
>   C_O1_I3(w, w, w, w)
>   C_O1_I4(r, r, rC, rz, rz)
>   C_O2_I1(r, r, r)
> -C_O2_I4(r, r, rz, rz, rA, rMZ)
> diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
> index 011a91c263..695effd77c 100644
> --- a/tcg/aarch64/tcg-target-has.h
> +++ b/tcg/aarch64/tcg-target-has.h
> @@ -13,13 +13,13 @@
>   #define have_lse2   (cpuinfo & CPUINFO_LSE2)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_extr_i64_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   
>   /*
>    * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 9dc6bf3e3d..75cf490fd2 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1575,56 +1575,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
>       tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
>   }
>   
> -static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
> -                            TCGReg rh, TCGReg al, TCGReg ah,
> -                            tcg_target_long bl, tcg_target_long bh,
> -                            bool const_bl, bool const_bh, bool sub)
> -{
> -    TCGReg orig_rl = rl;
> -    AArch64Insn insn;
> -
> -    if (rl == ah || (!const_bh && rl == bh)) {
> -        rl = TCG_REG_TMP0;
> -    }
> -
> -    if (const_bl) {
> -        if (bl < 0) {
> -            bl = -bl;
> -            insn = sub ? I3401_ADDSI : I3401_SUBSI;
> -        } else {
> -            insn = sub ? I3401_SUBSI : I3401_ADDSI;
> -        }
> -
> -        if (unlikely(al == TCG_REG_XZR)) {
> -            /* ??? We want to allow al to be zero for the benefit of
> -               negation via subtraction.  However, that leaves open the
> -               possibility of adding 0+const in the low part, and the
> -               immediate add instructions encode XSP not XZR.  Don't try
> -               anything more elaborate here than loading another zero.  */
> -            al = TCG_REG_TMP0;
> -            tcg_out_movi(s, ext, al, 0);
> -        }
> -        tcg_out_insn_3401(s, insn, ext, rl, al, bl);
> -    } else {
> -        tcg_out_insn_3502(s, sub ? I3502_SUBS : I3502_ADDS, ext, rl, al, bl);
> -    }
> -
> -    insn = I3503_ADC;
> -    if (const_bh) {
> -        /* Note that the only two constants we support are 0 and -1, and
> -           that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.  */
> -        if ((bh != 0) ^ sub) {
> -            insn = I3503_SBC;
> -        }
> -        bh = TCG_REG_XZR;
> -    } else if (sub) {
> -        insn = I3503_SBC;
> -    }
> -    tcg_out_insn_3503(s, insn, ext, rh, ah, bh);
> -
> -    tcg_out_mov(s, ext, orig_rl, rl);
> -}
> -
>   static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
>   {
>       static const uint32_t sync[] = {
> @@ -2895,25 +2845,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
> -                        (int32_t)args[4], args[5], const_args[4],
> -                        const_args[5], false);
> -        break;
> -    case INDEX_op_add2_i64:
> -        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
> -                        args[5], const_args[4], const_args[5], false);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
> -                        (int32_t)args[4], args[5], const_args[4],
> -                        const_args[5], true);
> -        break;
> -    case INDEX_op_sub2_i64:
> -        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
> -                        args[5], const_args[4], const_args[5], true);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;
> @@ -3407,12 +3338,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(rz, rz, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        return C_O2_I4(r, r, rz, rz, rA, rMZ);
> -
>       case INDEX_op_add_vec:
>       case INDEX_op_sub_vec:
>       case INDEX_op_mul_vec:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


