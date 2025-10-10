Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BADCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Fph-0003dz-2j; Fri, 10 Oct 2025 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7Fpe-0003ck-JF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:19:02 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7FpT-0003Ud-Jj
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:19:02 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBF233F853
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760113121;
 bh=M9eAGMyxZtd3bDcmjCb7hMbgQ+sQnLPU7iFbntpN8ls=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PHC4Yl46gkJ0nKe+bE/y01tdIKMEEAaRgWMPfiKvodLh2jpin0tbSDlHIF8fClxKN
 vN/BAutlSojH2MrzRjaQUMS650YrhcNU9af2HH3SasZrVniJ3DhfTd0Yk6RawgPqSH
 vMVzewbAzmKK62+KOiHW6qbZaLLTu9MIwDZxKeGQJH447WLNaZh7W6DXOrX1vlX6Jm
 r/3gcCCA7y/gNT6wpWN+8cuNkaeXdu1FfUOt5GY+BmZEok5piUwWno3rS1tsXQiVKM
 MJPdCjjGS/eHjBU5Cl7ipASUDaGFCfRywGhBBq+77gMAeGbWwcLx2aUU+iutbpDS0z
 YsIOfhITwLmnWOqwqmyCnDsGlmqS3wSX+XynPbpQhKyC1RiNfgxClvoaSJ9nahU1V6
 rrsCO4ZJTdv/GGRppGXstu+1FgthyPbml2JP3B5NCPyvJAK+Kz8o50d42u291sZwL3
 0CpyPQNxmzfdrsWt5AJpEcsYNcQZxyfzSBbXipbELbSC267V0xlsfgED8ccuIkU+Ix
 5To3vuNG1JteQB1J/bjoMbCScJO+rYVI2cHI0Cp+kBHGP+PVhGNxixfsjZJSzQVF+U
 XDgg5hu3E1FxrTrKBmnWHt7MC37uJDmato2klBxKBhkSs8RmQ8UuMO/cDMuFsRl8q1
 vX7i7+iHgNvh/T49QOdbWaKI=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426d2cd59e4so719267f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760113119; x=1760717919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9eAGMyxZtd3bDcmjCb7hMbgQ+sQnLPU7iFbntpN8ls=;
 b=d0gSuFnOXdaUv3xsVa5XRcekxWElbdLd/8zYUDTpgbUFhR8XTbeufn7qA6qMqtJZdS
 cMXsyaRICTWgppbSKrd2fxmHU14pu2bUMbwFef3RO1oF+tFCV8Gzz6+URWNxtTSCrppw
 deMAuk3IYvwivVEHkPfVtsdE78e07dKDIAiNGHOaTRJ5gE4xppnKMhocQQmuJBkU2m9t
 suaQvleZs3rG2ctXiS7cvHSQ4XJioWC2Kvq8tRr48QFRMFfB8oDa5aJL5xH2ojxoBZ8d
 WgNyOUTPCjr1QIdxSBwBSD8Kk9FrHyxtcB5u6JjcbcSPtFaJRhlVen/U0JeULEWPtj4u
 QR8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVa33VdbBuv1h//jhTKwBvdOKXeNxBJWRLij/QH/gEbwHhNF87eC4q9JIn3TWpdxVrbIy8Cfxw0vQ/@nongnu.org
X-Gm-Message-State: AOJu0YzcaCsfqUtsIqH9AH0nJSW0JyfwxDvmt2/0f0QSb+B1suL2X0TR
 nrIQteyNVIJrwnMxcsMROQbfbbBhvzexToTOIS4CwIws4fS5H9I3IOzZSnkvYkCCy3Y8cpNySXb
 vNUrTJ8gmlOmgBXYG2XpPodGyuBKhGzDffpoEat9tw/Y7ZYjym+Vq3kNIyEUjS+TdkmWmiFCe
X-Gm-Gg: ASbGncsPAhwQ4s5WXZfUhulLd7p8KrDbPOEonfE2g9z5+rvLAemum3FixuWcb0N7VTw
 SApAWo2y/LQfDcZLvQibe9ePzCTlOoYYObS/WXfmwq0n4u5BHo8izjWbJ0QJ8CzzKgEs5OafFhj
 02Ukl4k003z5waWDhKI1yXsCnfWvhUNQ2oJWd+ArI6pXVXKNPkbbSo1EqcjGi7lL8WJcVWi9kBz
 mKHRL2hI53Mo8McLE4+pElPQHePEMmw610mvRzuDENbODODT9wGatYbPup8jv0xFuXcbtu4fh5y
 6nPCVDoiAqjgI3M6ug/2EXSM19yn9VET6FCeN37iG3DbZcHejL2ufh1nOPuO4lWSvYy1bHFPav9
 KBVU+Y8AiVvT3b95iRdDh5NJd3BODB2Vz3U7ciQ==
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-4266e7ced08mr6264088f8f.9.1760113119447; 
 Fri, 10 Oct 2025 09:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiq1PHVsq29Kr6oTspw/6nxKgh+kxV/lJz+UwOmsXoMr2UgcIlUOajX8hZPRLrY2ShqzXsGw==
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-4266e7ced08mr6264062f8f.9.1760113118976; 
 Fri, 10 Oct 2025 09:18:38 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe69sm5027559f8f.32.2025.10.10.09.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:18:38 -0700 (PDT)
Message-ID: <b455449b-8ac4-4547-90db-e5b93b820772@canonical.com>
Date: Fri, 10 Oct 2025 18:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/riscv: Factor MemOp variable out when MO_TE
 is set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-12-philmd@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251010155045.78220-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/10/25 17:50, Philippe Mathieu-Daudé wrote:
> In preparation of automatically replacing the MO_TE flag
> in the next commit, use an local @memop variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc       |  6 ++++--
>   target/riscv/insn_trans/trans_rvf.c.inc       |  6 ++++--
>   target/riscv/insn_trans/trans_rvzacas.c.inc   |  5 +++--
>   target/riscv/insn_trans/trans_rvzce.c.inc     |  6 ++++--
>   target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++++++--
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 ++++++----
>   6 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index 33858206788..62b75358158 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -42,7 +42,7 @@
>   static bool trans_fld(DisasContext *ctx, arg_fld *a)
>   {
>       TCGv addr;
> -    MemOp memop = MO_TE | MO_UQ;
> +    MemOp memop = MO_UQ;

Thank you for the series which makes the introduction of big-endian 
support easier. I really like how you have split it up into logical steps.

The change in trans_fld() looks correct but is not fully covered by the 
commit description message: This function already uses a local memop 
variable.

Here you are factoring out setting the endian bit which makes 
'mechanically' replacing the setting of the bit easier.

Consider updating the commit message.

Otherwise the patch looks good to me.

Best regards

Heinrich

>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
> @@ -60,6 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>       } else {
>           memop |= MO_ATOM_IFALIGN;
>       }
> +    memop |= MO_TE;
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> @@ -72,7 +73,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>   static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>   {
>       TCGv addr;
> -    MemOp memop = MO_TE | MO_UQ;
> +    MemOp memop = MO_UQ;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
> @@ -84,6 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>       } else {
>           memop |= MO_ATOM_IFALIGN;
>       }
> +    memop |= MO_TE;
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
> index 150e2b9a7d4..878417eae92 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -43,11 +43,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>   {
>       TCGv_i64 dest;
>       TCGv addr;
> -    MemOp memop = MO_TE | MO_UL;
> +    MemOp memop = MO_UL;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> +    memop |= MO_TE;
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> @@ -65,11 +66,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>   static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>   {
>       TCGv addr;
> -    MemOp memop = MO_TE | MO_UL;
> +    MemOp memop = MO_UL;
>   
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> +    memop |= MO_TE;
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
> index d850b142642..6458ac4f241 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -119,12 +119,13 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
>       TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
>       TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
>       TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
> +    MemOp memop = MO_ALIGN | MO_UO;
>   
> +    memop |= MO_TE;
>       tcg_gen_concat_i64_i128(src2, src2l, src2h);
>       tcg_gen_concat_i64_i128(dest, destl, desth);
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
> -                                (MO_ALIGN | MO_TE | MO_UO));
> +    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
>   
>       tcg_gen_extr_i128_i64(destl, desth, dest);
>   
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> index c8dc102c8e3..172c2c19c17 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -175,7 +175,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
>           return false;
>       }
>   
> -    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
> +    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
>       int reg_size = memop_size(memop);
>       target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
>                                a->spimm;
> @@ -185,6 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
>   
>       tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
>   
> +    memop |= MO_TE;
>       for (i = X_Sn + 11; i >= 0; i--) {
>           if (reg_bitmap & (1 << i)) {
>               TCGv dest = dest_gpr(ctx, i);
> @@ -228,7 +229,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
>           return false;
>       }
>   
> -    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
> +    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
>       int reg_size = memop_size(memop);
>       target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
>                                a->spimm;
> @@ -238,6 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
>   
>       tcg_gen_subi_tl(addr, sp, reg_size);
>   
> +    memop |= MO_TE;
>       for (i = X_Sn + 11; i >= 0; i--) {
>           if (reg_bitmap & (1 << i)) {
>               TCGv val = get_gpr(ctx, i, EXT_NONE);
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
> index eec478afcb0..5355cd46c3d 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -42,12 +42,14 @@
>   
>   static bool trans_flh(DisasContext *ctx, arg_flh *a)
>   {
> +    MemOp memop = MO_UW;
>       TCGv_i64 dest;
>       TCGv t0;
>   
>       REQUIRE_FPU;
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
> +    memop |= MO_TE;
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {
> @@ -57,7 +59,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>       }
>   
>       dest = cpu_fpr[a->rd];
> -    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TE | MO_UW);
> +    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, memop);
>       gen_nanbox_h(dest, dest);
>   
>       mark_fs_dirty(ctx);
> @@ -66,11 +68,13 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>   
>   static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>   {
> +    MemOp memop = MO_UW;
>       TCGv t0;
>   
>       REQUIRE_FPU;
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
> +    memop |= MO_TE;
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {
> @@ -79,7 +83,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>           t0 = temp;
>       }
>   
> -    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TE | MO_UW);
> +    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, memop);
>   
>       return true;
>   }
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> index c5555966175..89eed007587 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -100,12 +100,13 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>   
>       TCGv dest = dest_gpr(ctx, a->rd);
>       TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    MemOp memop = MO_ALIGN | MO_SL;
>   
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       src1 = get_address(ctx, a->rs1, 0);
>   
> -    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> -                           (MO_ALIGN | MO_TE | MO_SL));
> +    memop |= MO_TE;
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
>   }
> @@ -129,12 +130,13 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>   
>       TCGv dest = dest_gpr(ctx, a->rd);
>       TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    MemOp memop = MO_ALIGN | MO_SQ;
>   
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       src1 = get_address(ctx, a->rs1, 0);
>   
> -    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
> -                           (MO_ALIGN | MO_TE | MO_SQ));
> +    memop |= MO_TE;
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
>   }



