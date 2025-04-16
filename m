Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF314C369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58ZZ-000825-BL; Wed, 16 Apr 2025 15:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58ZU-0007z8-2Z
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:37:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58ZR-0000vP-VD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:37:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so5845328b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744832236; x=1745437036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTKan+8+pF41jDPNwrNV2PQks5CJwO1i+JD4FENEsFA=;
 b=pG2ih5GdGI3leVB7vaahJbsqb9j5lNxRkIJcTtQJ3LN+QA21ILW5UrgoTZIeVwBiFL
 8gHdJWIMZ2THT8sZv7gQ5aXAv9JMmwCZDF4UMikACux6IhClC8yu44Ps14lAlR2oG28p
 wTTImoDM4EgHcVuL3abpH9wXpanl/icuLdByDvFyDUZiYFCGvqhW+VI9sWK8iRu0HaRc
 fxtHLqDBUNq2hTatLI3d++O/kuxLr/DIPhtOZMQNyecvHUvynOeJgwakMxChQRgzIzpd
 oWUW3SLzS/vUvpZEU6Yq75T34Pzcma/QCCUqZ2Wnqo+xoCOClvf6vVmJxkjKjnaJ4HOG
 K5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744832236; x=1745437036;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTKan+8+pF41jDPNwrNV2PQks5CJwO1i+JD4FENEsFA=;
 b=oLReGrf9u42JHWDA1EPwxg4Apde6ize//Ljs5EwrN2WUIvA5TodROBZqG7BnfXebCz
 oUvIsUXC8KHdgJB1MbQmdYy7vAtaLcdiIZaW6xchgB5CK/pFFfVz5iHea+zHOSwO1VhB
 so4ibUBtbj6SVO7JbiFBXh4Dqw0EdhoKQZsORZznjn885DZ4nVQeDgY5QgI3x+5eV7QV
 frkHe4DVwgltdOEbITaAbREXGmdaai/GpTkCgUuvwONhy4kRlUC8ja5LURhD6NDNN39m
 z5MexND32sMpsQydJXyXR/2o5GVnB4FP1TblFjuPyFDModf8miM6u2/i7My64GLmgc2F
 AsRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YWcLVMaDaO6hi+ELnR6K2mzL7Vkv9nkl1gJ9JzR+beHutqd2fsKKfKos2rnaVmpG2BZol4+85MCn@nongnu.org
X-Gm-Message-State: AOJu0YyxMInkZZ5NZ3Ijwzp/Ss4WsYfJY9CSMieMNxY5C+fHAsL3bHCB
 Yh1yeIr9iLvsMJnnyHMZBY18nMTx2p0k6S6TkZE2g0Ygq6tSWw0rMP1qtUPapaM=
X-Gm-Gg: ASbGncvYXKQACaLVfdYW5QD+fQgFHwbvJdQ+kuhEeewwCrqOTFjCQ+xXOYGOG+HGCDi
 wtT3czz04055oCCEWkRxvzIGVFib1+Q7iE9hj3FshM6VcNyQtF+qjmP4oqNegahRsZ2jl+mYuvK
 rSQuf3vJHnz6wh2zIO4lixi+LYAWhBe0jX66HtoihTal2NqKCGk9E75Rq7hL6zgaE0Rzi0CrPKf
 RnyLLngYXlRyl4DvJNABYBjifSjmXqLpT932uynSqA4XM2Wthdbzz951POQePIckXISkAG0Ei6D
 +0cYmbFRNzqPg5MBiR02p/u2Veqd/H0GEOxaHqXnecvhKUHI0JCyyQ==
X-Google-Smtp-Source: AGHT+IHuKOmJPnChiKF9nlT0swelGWVH9V2LEeaI6inwIPirblnV0+F/OBb2ol+WxvEWkzM+CnVAzQ==
X-Received: by 2002:a05:6a00:3920:b0:736:3c77:31fd with SMTP id
 d2e1a72fcca58-73c267ecd0bmr4074683b3a.23.1744832235993; 
 Wed, 16 Apr 2025 12:37:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198bd9sm10776554b3a.7.2025.04.16.12.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:37:15 -0700 (PDT)
Message-ID: <f959b833-d3c4-4196-bf72-29a1e17b6531@linaro.org>
Date: Wed, 16 Apr 2025 12:37:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 148/163] tcg/tci: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-149-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-149-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
>   tcg/tci/tcg-target-has.h |  8 ++---
>   tcg/tci.c                | 66 +++-------------------------------------
>   tcg/tci/tcg-target.c.inc | 28 -----------------
>   3 files changed, 9 insertions(+), 93 deletions(-)
> 
> diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
> index 6063f32f7b..310d45ba62 100644
> --- a/tcg/tci/tcg-target-has.h
> +++ b/tcg/tci/tcg-target-has.h
> @@ -8,13 +8,13 @@
>   #define TCG_TARGET_HAS_H
>   
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0
>   
>   #if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   #endif /* TCG_TARGET_REG_BITS == 64 */
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/tci.c b/tcg/tci.c
> index d65ff2b8f1..a18478a07a 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -179,17 +179,6 @@ static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
>       *c5 = extract32(insn, 28, 4);
>   }
>   
> -static void tci_args_rrrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
> -                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGReg *r5)
> -{
> -    *r0 = extract32(insn, 8, 4);
> -    *r1 = extract32(insn, 12, 4);
> -    *r2 = extract32(insn, 16, 4);
> -    *r3 = extract32(insn, 20, 4);
> -    *r4 = extract32(insn, 24, 4);
> -    *r5 = extract32(insn, 28, 4);
> -}
> -
>   static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
>   {
>       bool result = false;
> @@ -370,13 +359,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>       for (;;) {
>           uint32_t insn;
>           TCGOpcode opc;
> -        TCGReg r0, r1, r2, r3, r4, r5;
> +        TCGReg r0, r1, r2, r3, r4;
>           tcg_target_ulong t1;
>           TCGCond condition;
>           uint8_t pos, len;
>           uint32_t tmp32;
>           uint64_t tmp64, taddr;
> -        uint64_t T1, T2;
>           MemOpIdx oi;
>           int32_t ofs;
>           void *ptr;
> @@ -445,9 +433,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>   #if TCG_TARGET_REG_BITS == 32
>           case INDEX_op_setcond2_i32:
>               tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
> -            T1 = tci_uint64(regs[r2], regs[r1]);
> -            T2 = tci_uint64(regs[r4], regs[r3]);
> -            regs[r0] = tci_compare64(T1, T2, condition);
> +            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
> +                                     tci_uint64(regs[r4], regs[r3]),
> +                                     condition);
>               break;
>   #elif TCG_TARGET_REG_BITS == 64
>           case INDEX_op_setcond:
> @@ -717,22 +705,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>                   tb_ptr = ptr;
>               }
>               break;
> -#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_add2_i32
> -        case INDEX_op_add2_i32:
> -            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> -            T1 = tci_uint64(regs[r3], regs[r2]);
> -            T2 = tci_uint64(regs[r5], regs[r4]);
> -            tci_write_reg64(regs, r1, r0, T1 + T2);
> -            break;
> -#endif
> -#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_sub2_i32
> -        case INDEX_op_sub2_i32:
> -            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> -            T1 = tci_uint64(regs[r3], regs[r2]);
> -            T2 = tci_uint64(regs[r5], regs[r4]);
> -            tci_write_reg64(regs, r1, r0, T1 - T2);
> -            break;
> -#endif
>           case INDEX_op_bswap16:
>               tci_args_rr(insn, &r0, &r1);
>               regs[r0] = bswap16(regs[r1]);
> @@ -786,24 +758,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
>               break;
> -#if TCG_TARGET_HAS_add2_i64
> -        case INDEX_op_add2_i64:
> -            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> -            T1 = regs[r2] + regs[r4];
> -            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
> -            regs[r0] = T1;
> -            regs[r1] = T2;
> -            break;
> -#endif
> -#if TCG_TARGET_HAS_add2_i64
> -        case INDEX_op_sub2_i64:
> -            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> -            T1 = regs[r2] - regs[r4];
> -            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
> -            regs[r0] = T1;
> -            regs[r1] = T2;
> -            break;
> -#endif
>   
>               /* Shift/rotate operations (64 bit). */
>   
> @@ -952,7 +906,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>       const char *op_name;
>       uint32_t insn;
>       TCGOpcode op;
> -    TCGReg r0, r1, r2, r3, r4, r5;
> +    TCGReg r0, r1, r2, r3, r4;
>       tcg_target_ulong i1;
>       int32_t s2;
>       TCGCond c;
> @@ -1125,16 +1079,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
>                              str_r(r2), str_r(r3));
>           break;
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> -        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
> -                           op_name, str_r(r0), str_r(r1), str_r(r2),
> -                           str_r(r3), str_r(r4), str_r(r5));
> -        break;
> -
>       case INDEX_op_qemu_ld_i64:
>       case INDEX_op_qemu_st_i64:
>           if (TCG_TARGET_REG_BITS == 32) {
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 947aa1aada..35c0c91f3e 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -66,12 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        return C_O2_I4(r, r, r, r, r, r);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
>       case INDEX_op_qemu_ld_i64:
> @@ -346,22 +340,6 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
>       tcg_out32(s, insn);
>   }
>   
> -static void tcg_out_op_rrrrrr(TCGContext *s, TCGOpcode op,
> -                              TCGReg r0, TCGReg r1, TCGReg r2,
> -                              TCGReg r3, TCGReg r4, TCGReg r5)
> -{
> -    tcg_insn_unit insn = 0;
> -
> -    insn = deposit32(insn, 0, 8, op);
> -    insn = deposit32(insn, 8, 4, r0);
> -    insn = deposit32(insn, 12, 4, r1);
> -    insn = deposit32(insn, 16, 4, r2);
> -    insn = deposit32(insn, 20, 4, r3);
> -    insn = deposit32(insn, 24, 4, r4);
> -    insn = deposit32(insn, 28, 4, r5);
> -    tcg_out32(s, insn);
> -}
> -
>   static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
>                            TCGReg base, intptr_t offset)
>   {
> @@ -1182,12 +1160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, opc, args[0], args[1], args[2]);
>           break;
>   
> -    CASE_32_64(add2)
> -    CASE_32_64(sub2)
> -        tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
> -                          args[3], args[4], args[5]);
> -        break;
> -
>       case INDEX_op_qemu_ld_i64:
>       case INDEX_op_qemu_st_i64:
>           if (TCG_TARGET_REG_BITS == 32) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


