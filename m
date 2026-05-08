Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3670CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 21:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSKA-00088x-V3; Fri, 08 May 2026 17:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSK9-00088Q-4y
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:01:29 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSK7-0007El-0p
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:01:28 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-42fdab683a9so1782736fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778274086; x=1778878886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRgvLOFvS9dswi79OAqTiA4VHBUd4SKbysaKUsTluSY=;
 b=UXtt3eWT8AzxeqyHlCmTpp2nF9ktL4ZbMagtAwBbnpnkItBJoRZAyCb1TXMTtqa3UP
 4h68OHgGHLB6X2OT+B8JofC+dkj1+BlVruuJFOIWEEUQAtfYKy8E7klL8EHultCmXEQW
 qQicngd9ok85b4ojQw0N7d5vgLy53tCvgF3is/o6CNACK08/8gUha4UgevZ9bTXvHlTF
 MWlOg6gKGcTkcm9EeTPqZTFoCbN2Ob0bH2NGjQC5EDDK3XnJGDfsoMCme2XX/5jjcYQa
 upugFRQmWJ6VYIbzCczcKGXsBsx29IuHLnAFeNlgSFo/ZheXdm3mEe8D1LOKuHqB4m4C
 f/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778274086; x=1778878886;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRgvLOFvS9dswi79OAqTiA4VHBUd4SKbysaKUsTluSY=;
 b=FTycOZcuTLHpVOrEelM0r49rsCFimN/utx3/SxrEZWuF//hYHQ15fP2CWIHTq+JXWv
 EEVrMsZloQB0O294eck91vFd0qWPJAvyEs2/nCF3Yzogy9Azi39U4mnmE0tcRQKJj11g
 aW+KxdkjyDinnH4mkDPUyhuzaVW7hL9S7G1yf/JEdTmVaQ+2Cg3HKyJNjGA6PhcrmNTL
 L2KUneJTU45EPjIbMIucUIehaFivzMHzLYqdVwDO8dtYJpchIIWa+5AZ3stKnL3pXA90
 ixT1bf6LA+Id7gCxmtFCqB1khPihfnT1oz/77KOcz4XSFDpYFLLmzfzXtLE9uO92d/uf
 RRvA==
X-Gm-Message-State: AOJu0YyTYRKXdTIR3ff6/yAFHw7oEnf1aPSGidTZacWTxhQ43Z2SO8jH
 t/BVagmNslqHRNVmdjGNqqB9EmVkyra0DKdwCGEZqcF/crbSGTrd3E6oeA7VyAYLqUsFNPMCoRa
 qbPeT
X-Gm-Gg: AeBDiesETzV6QcwPX7c0OraTELczOtf8fdjCOf6Z3j+m5c3JvCCyhT4rrelvi3PRcPA
 6h2JlS4gkp7G5TNDPO3Y2sBL+egy969GN5ifQkJcreestP3U3tfUtccB0a5AjumxtdBYIaXZYYl
 fbX/4WIWTouXoQevqlrr4o41Dn7hBe4PnnDDFYPSuULb6tc2zOE/HxpMIYAMzhd7bs8CfnORV+N
 D/GzYHnwAWiRirJ0DAoC3anTPo+BVZItCnyrYYsBHJLP+KpuXMFQo0N/Ixoa4R6lsD/cF/yMjh7
 h+Or2N5apSACdn2yNbnhQ8KfoWaZZGCrt7nrjKZu4uGy2JuX+VgUK+OCNlu9xEiX5qZd+O6Z1Is
 oTtviMLcAfJN9z8j9QSdfaBFzZhwOoczZW7MyFpJVITZ51RwYENQxzMUzCg+PCnuLHGIsWLuE5z
 jE5htC+FrUGUx4/euhfM6aupFnNk9bNFHSsKpNeHZFVNMUrKkB4oDDITKlWtzi2r8GaAU79PDQl
 Kf5FxI=
X-Received: by 2002:a05:6870:4687:b0:41c:ccd1:78b4 with SMTP id
 586e51a60fabf-434f615fbd8mr8866196fac.10.1778274085427; 
 Fri, 08 May 2026 14:01:25 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ad8f4sm2682516fac.4.2026.05.08.14.01.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 14:01:24 -0700 (PDT)
Message-ID: <bec76749-0ad9-4609-87bb-ee1a8264909b@linaro.org>
Date: Fri, 8 May 2026 16:01:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/32] target/mips: add Octeon LA* atomic instructions
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-25-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-25-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> Implement the Octeon LA* read-modify-write atomic instruction family:
> LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.
> 
> These operations are architecturally distinct from SAA/SAAD and are used
> by existing Octeon user-mode code for atomic counters, bit operations,
> and exchange-style updates.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Keep LA* atomics naturally aligned per Octeon L2 transaction
>      semantics.
>    - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
>      Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
>      (suggested by Richard Henderson)
>    - Group LA* translator wrappers by argument shape instead of adding one
>      wrapper per instruction.  (suggested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  17 ++++++
>   target/mips/tcg/octeon_translate.c | 118 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 135 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 54ca92a654..6f4102044f 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -59,6 +59,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
>   SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
> +&la          base rd
> +&laa         base add rd
> +@la          ...... base:5 ..... rd:5 ........... &la
> +@laa         ...... base:5 add:5 rd:5 ........... &laa
> +LAI          011100 ..... 00000 ..... 00010 011111 @la
> +LAID         011100 ..... 00000 ..... 00011 011111 @la
> +LAD          011100 ..... 00000 ..... 00110 011111 @la
> +LADD         011100 ..... 00000 ..... 00111 011111 @la
> +LAA          011100 ..... ..... ..... 10010 011111 @laa
> +LAAD         011100 ..... ..... ..... 10011 011111 @laa
> +LAS          011100 ..... 00000 ..... 01010 011111 @la
> +LASD         011100 ..... 00000 ..... 01011 011111 @la
> +LAC          011100 ..... 00000 ..... 01110 011111 @la
> +LACD         011100 ..... 00000 ..... 01111 011111 @la
> +LAW          011100 ..... ..... ..... 10110 011111 @laa
> +LAWD         011100 ..... ..... ..... 10111 011111 @laa
> +
>   &zcb         base
>   ZCB          011100 base:5 00000 00000 11100 011111 &zcb
>   ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index fe1ddeb973..cdaa926389 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -189,6 +189,112 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>       return true;
>   }
>   
> +static bool trans_la_common(DisasContext *ctx, int base, int add_reg, int rd,
> +                            int64_t imm, bool dw)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (dw) {
> +        TCGv_i64 value = tcg_temp_new_i64();
> +        TCGv_i64 old = tcg_temp_new_i64();
> +        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
> +
> +        if (add_reg >= 0) {
> +            gen_load_gpr(value, add_reg);
> +        } else {
> +            tcg_gen_movi_i64(value, imm);
> +        }
> +
> +        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
> +        gen_store_gpr(old, rd);
> +    } else {
> +        TCGv_i64 old = tcg_temp_new_i64();
> +        TCGv_i32 value32 = tcg_temp_new_i32();
> +        TCGv_i32 old32 = tcg_temp_new_i32();
> +        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
> +
> +        if (add_reg < 0) {
> +            tcg_gen_movi_i32(value32, imm);
> +        } else {
> +            TCGv_i64 value = tcg_temp_new_i64();
> +
> +            gen_load_gpr(value, add_reg);
> +            tcg_gen_extrl_i64_i32(value32, value);
> +        }
> +
> +        tcg_gen_atomic_fetch_add_i32(old32, addr, value32, ctx->mem_idx, amo);
> +        tcg_gen_ext_i32_i64(old, old32);
> +        gen_store_gpr(old, rd);
> +    }

Always use tcg_gen_atomic_fetch_add_i64.

The correct memop for 32-bit is MO_SL, so that you automatically get the sign-extension 
for the 32-bit operation.

Which means that it'd be cleaner to replace the 'bool dw' parameter with 'MemOp mop'.

> +static bool trans_law_common(DisasContext *ctx, int base, int add_reg, int rd,
> +                             int64_t imm, bool dw)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (dw) {
> +        TCGv_i64 value = tcg_temp_new_i64();
> +        TCGv_i64 old = tcg_temp_new_i64();
> +        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
> +
> +        if (add_reg >= 0) {
> +            gen_load_gpr(value, add_reg);
> +        } else {
> +            tcg_gen_movi_i64(value, imm);
> +        }
> +
> +        tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
> +        gen_store_gpr(old, rd);
> +    } else {
> +        TCGv_i64 old = tcg_temp_new_i64();
> +        TCGv_i32 value32 = tcg_temp_new_i32();
> +        TCGv_i32 old32 = tcg_temp_new_i32();
> +        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
> +
> +        if (add_reg >= 0) {
> +            TCGv_i64 value = tcg_temp_new_i64();
> +
> +            gen_load_gpr(value, add_reg);
> +            tcg_gen_extrl_i64_i32(value32, value);
> +        } else {
> +            tcg_gen_movi_i32(value32, imm);
> +        }
> +
> +        tcg_gen_atomic_xchg_i32(old32, addr, value32, ctx->mem_idx, amo);
> +        tcg_gen_ext_i32_i64(old, old32);
> +        gen_store_gpr(old, rd);
> +    }

Similarly.


r~

