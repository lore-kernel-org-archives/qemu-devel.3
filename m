Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF1ACCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGywR-0004eg-Ul; Thu, 06 Nov 2025 07:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGywH-0004br-Ua
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:18:06 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGywF-0007Rb-Hi
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:18:05 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4441ccde23dso446526b6e.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 04:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762431481; x=1763036281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2kh+dJyZoz6ZQxr3aMW3mUfClrOHrvNvY1wKpBG1xhE=;
 b=P0oI3BuRNa9FmkirNA9L1+HdYPZ1DB7tBO4y5o14nnkMPH4DdkLTFjN5pp3J+SLSEZ
 HS4KJq8XZs+1CHzvmAumjN9WidhbucT+UspS9QEycG3jnSFzz0guB0I/0dY8q9N2W+tV
 8MDXzjzodCg+wW+cjG0HyHGTXNeie5AAXgCVRwZoJVwYcdvT4WRbFJmS+HOcMasXw+7G
 9V7Um7B4MMScebEZPKpP+1e5Zk1bF8ZpPogLvuv79Xafh8DRewTNdYxlb946UrtL38Wv
 5C9meI2VJO+ruAFcmZC9x8OKRlZuhrfJ35wvtVaXGAclw4YPJKfa5DK4lqrAfoSijtFm
 IIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762431481; x=1763036281;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2kh+dJyZoz6ZQxr3aMW3mUfClrOHrvNvY1wKpBG1xhE=;
 b=dFZYNIkRLTxfgtgRBN92ssmxvlFbhaWN94pQP14BdLqr9mHStGDZlB1Glp9WwLum08
 Vox43GDf0zkeUof1smH5Vw58hrKraA7EKOxl0+mOkj4elFfy121bHA9vRngg/bY4fclE
 EnD9SoVd6GjJy7/p6RCEZw/+L+z8QRfeEgpkzkvcNOvOauWGasKyTeSNva5MXxxKECc2
 ckOrKHSoSAGBR+eDr2njyW1DA5NjE9t0mmquJxQE0sWtd+1XJhBIgf7FWgpCmR87JU4/
 03Ywux8+sRdpl0yC0sY6wlKyGenoAT1uJguOHI5OGKPD65D3upbhQq3yqVurYBvlJo2A
 ve3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBoSt3vrwTAi48qRu1UGbH5/i/7KlzTtpz6SxNXq1RfpNu6syDvP4nOa1ZcOxLXUAbcaWm9wz0wlp8@nongnu.org
X-Gm-Message-State: AOJu0YytE9xsiUa44wf6XOyoTL/uuvkJp9B0J35a4LO+6Wnr6aS+xqTk
 MoL09gBNzehGIsIBM5FwDvahtmUo+Qh9542IqPqMTKNKhYvYyVzYqnFx/2kA4JWRV+4=
X-Gm-Gg: ASbGncvswKnRSY/IMTz6GprB3vrAXi+nPtEKUb2IdDjQkOZBAdWMEA7Cnr5jLWpuW3n
 VdU4NtcyA1h15npBQgBKjfZJi8qHehy/KffK7kaPtYdsCDSCdrULM6dTeg/xBmmA/WTid4XwgeC
 HhKM89K+SUdAPLFSoHFGR9tRpgbFgUsVREFC19dotqFnWXmQTOmzOSbBqdDrBlKda1V2y7G3HEX
 OFXSXqci6a64EnNC3ZlOGzkVe3hjmXi8hG5bbXC7AKXlj2J4cXHVmG3P3Ey78i7wjtE9ubdryFv
 g3hbk+vtqvJN+fTi92s2pbtVQUl5tx2r3sUHgVKaXf8EivJUoFYG9Xpb6q7pVNlztsgPaat03Fj
 naaeAv8X/aPYCL1dlIBzmz/myhoyf/FeIg5sSYXuS/aLugdGJTHLKjPyw6RsQa1E0cUQa23o5Nw
 tDYXt7L47lMG6v7w==
X-Google-Smtp-Source: AGHT+IFx+MIm9WQS8rpXF3WgwE1nqHZ9mB4wnjCI31xNvsnBxK0Ae8rNbs5Upmnwb0h0FRq9UIo6dg==
X-Received: by 2002:a05:6808:2288:b0:444:4086:4524 with SMTP id
 5614622812f47-44fed3442a7mr3016265b6e.31.1762431481352; 
 Thu, 06 Nov 2025 04:18:01 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002752ca9sm717014b6e.14.2025.11.06.04.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 04:17:59 -0800 (PST)
Message-ID: <710d9b96-ac43-4d51-b210-65917bf91aa0@ventanamicro.com>
Date: Thu, 6 Nov 2025 09:17:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add RISCV Zilsd extension
To: Roan Richmond <roan.richmond@codethink.co.uk>, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, alistair23@gmail.com
References: <20251104120012.194899-1-roan.richmond@codethink.co.uk>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251104120012.194899-1-roan.richmond@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x231.google.com
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



On 11/4/25 8:59 AM, Roan Richmond wrote:
> This is based on v1.0 of the Zilsd extension [1].
> The specification is listed as in the Ratified state [2],
>   since Jan 30, 2025.
> 
> [1]: https://github.com/riscv/riscv-zilsd
> [2]: https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/RISC-V+Specs+Under+Development
> 
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> ---
>   target/riscv/cpu.c                      |  2 +
>   target/riscv/cpu_cfg_fields.h.inc       |  1 +
>   target/riscv/insn_trans/trans_rvi.c.inc | 56 ++++++++++++++++++++++++-
>   3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..6e0d37fb96 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_13_0, ext_zilsd),
>       ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>       ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1247,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>       MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>       MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc79..8d8e35e4cf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -41,6 +41,7 @@ BOOL_FIELD(ext_zicond)
>   BOOL_FIELD(ext_zihintntl)
>   BOOL_FIELD(ext_zihintpause)
>   BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zilsd)
>   BOOL_FIELD(ext_zimop)
>   BOOL_FIELD(ext_zcmop)
>   BOOL_FIELD(ext_ztso)
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 54b9b4f241..dcbb3811d9 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -370,6 +370,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a, MemOp memop)
>       return true;
>   }
>   
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
> +{
> +    TCGv dest_1 = dest_gpr(ctx, a->rd);
> +    TCGv dest_2 = dest_gpr(ctx, (a->rd)+1);
> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
> +    TCGv addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
> +
> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
> +
> +    /* If destination is x0 then result of the load is discarded */
> +    if (a->rd == 0) {
> +        return true;
> +    }

Can't we exit earlier in this case? We're doing 2 dst_gpr() calls, 2 get_address() and
2 ld_tl() loads before checking a->rd == 0. Maybe something like this:


> +    TCGv addr_1, addr_2, dest_1, dest_2;
> +
> +    /* If destination is x0 then result of the load is discarded */
> +    if (a->rd == 0) {
> +        return true;
> +    }
> +
> +    dest_1 = dest_gpr(ctx, a->rd);
> +    dest_2 = dest_gpr(ctx, (a->rd)+1);
> +    addr_1 = get_address(ctx, a->rs1, a->imm);
> +    addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
> +
> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);


Thanks,

Daniel



> +
> +    gen_set_gpr(ctx, a->rd, dest_1);
> +    gen_set_gpr(ctx, a->rd+1, dest_2);
> +    return true;
> +}
> +
>   /* Compute only 64-bit addresses to use the address translation mechanism */
>   static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>   {
> @@ -409,6 +430,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>       decode_save_opc(ctx, 0);
>       if (get_xl(ctx) == MXL_RV128) {
>           out = gen_load_i128(ctx, a, memop);
> +    } else if (memop == MO_SQ && get_xl(ctx) == MXL_RV32) {
> +        out = gen_load_zilsd(ctx, a);
>       } else {
>           out = gen_load_tl(ctx, a, memop);
>       }
> @@ -437,7 +460,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
>   
>   static bool trans_ld(DisasContext *ctx, arg_ld *a)
>   {
> -    REQUIRE_64_OR_128BIT(ctx);
> +    /* Check for Zilsd extension if 32bit */
> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
> +        return false;
> +    }
>       return gen_load(ctx, a, MO_SQ);
>   }
>   
> @@ -482,6 +508,27 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>       return true;
>   }
>   
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
> +{
> +    TCGv data_1 = tcg_temp_new();
> +    TCGv data_2 = tcg_temp_new();
> +    if (a->rs2 != 0) {
> +        data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
> +        data_2 = get_gpr(ctx, (a->rs2)+1, EXT_NONE);
> +    }
> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
> +    TCGv addr_2 = get_address(ctx, a->rs1, (a->imm)+4);
> +
> +    if (ctx->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +    }
> +
> +    tcg_gen_qemu_st_tl(data_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_st_tl(data_2, addr_2, ctx->mem_idx, MO_SL);
> +    return true;
> +}
> +
>   static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>   {
>       TCGv src1l = get_gpr(ctx, a->rs1, EXT_NONE);
> @@ -511,6 +558,8 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>       decode_save_opc(ctx, 0);
>       if (get_xl(ctx) == MXL_RV128) {
>           return gen_store_i128(ctx, a, memop);
> +    } else if (memop == MO_UQ && get_xl(ctx) == MXL_RV32) {
> +        return gen_store_zilsd(ctx, a);
>       } else {
>           return gen_store_tl(ctx, a, memop);
>       }
> @@ -533,7 +582,10 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>   
>   static bool trans_sd(DisasContext *ctx, arg_sd *a)
>   {
> -    REQUIRE_64_OR_128BIT(ctx);
> +    /* Check for Zilsd extension if 32bit */
> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
> +        return false;
> +    }
>       return gen_store(ctx, a, MO_UQ);
>   }
>   


