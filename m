Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02745CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7G69-0001ZA-Ij; Fri, 10 Oct 2025 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7G67-0001YY-BT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:36:03 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1v7G5v-0000cC-Ks
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:36:03 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1750B3F856
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760114146;
 bh=QaVtz2NggfnfOX88S3WaJFIqZE/kNbMv9KPKHmYvMY8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=MaGJPwW5Mhw+fdNhpzpfLzdjsWBjhdkQbTGTmFglNXBxtXoM9Xh7lRpajsFShkyZf
 NZFhzP8zftayd25AI3HyL+KZD3uXqppwHlJFD6cnxGKIzY6ND4y/NdZbNr3z1y4ml7
 hFDJFunEm6Ed5UdWsy7w/3hp9DhIQwBSUsTdd6uP78ukojhWD1tnrPnQAMPk389b7k
 rJfvJxESnPGKoHk0xQ3tu2bjW8Y5IqBilvseeUAWj8KrhaqjdetiVHZzKMz087L2Qm
 o+0fQ0QrdPrnzhzE36M1T8c2yl+3yvd7h7DuZh9PzIQnTAwA87QALVTwSLMqtOpTwe
 UfAx1/FEILwarmPwJgLc8nSuxVoy5MlTvUwGsglxVmOriE44ExFChq/WndX1e5hTqu
 xhWwryd6A5dfdAQhx1uhRVcAXtP1HAbmFIiZUegJjjX56vv3j7olurpLf+6Y5NmVKh
 mQHxmeCpfchM4BCaatuRf43URHDxTmw6i3dtbWNRy/0U1Md9lJ1bonJQxaD7ZCFsSt
 xI3XBDuzDbHQnRBOsx5Bkv94xGuZraWuoFnKFw/t6Bg7knBc1bCx3JaiaKtWr1LxUu
 pt8GOBIX6QFnt5S9dcs9SvvvWT/rZ1pw6U0Yo3R/aWQsjuXFqaP9RpXv1z/7eHBPGP
 vTGBiz/PRD4Fk72GT0qclLfc=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e31191379so16284645e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760114145; x=1760718945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QaVtz2NggfnfOX88S3WaJFIqZE/kNbMv9KPKHmYvMY8=;
 b=J2qflEHPggBQVV9ncv6kvQrWiOy+JMe6zWAzgygFECTrUUA/bwRlhVr9C4MeVb5wEb
 UtvqRxOIkNBtMy2wZWgg55KuxBQlamoUriILT6WDGsBB7Om5y9iP267bTPtbrZ5KlE5r
 78fLPecPz7csIXLL3ywCY7+zilwqxZk3cpieaXMMoM3Uf4HtylZcZ+dQyFQ4GtcmSmXU
 /cbtCTC8SDSKfrCYsMNO+8oGVOTQCx6SR6U5joXZ9K74KSfsCHFe6EaPIdPJOE1tkBkx
 WOtl4QvVcQIQmHpSAS9Q5RxtCWDKLhgsImU7mJGYjJridvL34HLJpr8r6tlfjqMRLz9D
 /qCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU33nHYquyln8/QeZmdkHNmOEV9UCAfL8gFa6lKIb85MmfOYHKXk13gmVpWcZzcGzeA1Xl5x6X1hK72@nongnu.org
X-Gm-Message-State: AOJu0YxQCGsTqebYebNLtzD5jU8dkieYxw52A3tZQPZkFgiGqAUX3TS3
 1oHdeYpv5+gpEfqeMSvLf2HF6jLsQ1AmQftzz1lDuNI7Db2rvBF9gLPhZTqBEodLm28Ahpndze2
 XaVXjm7hmG4zafqdjW1ix/CAh8BlbcPY9+9ZirAmNz3Ruo3I4txrZML4MbpAVb1AT49nYlugb
X-Gm-Gg: ASbGncuG0K5Djo3DQHt7WIWjXkHko1pjUlwkRd9jH4NjNKLqga09Eyg0tPTKXeE4Ykt
 MU9csVcOPyIUAkKFU/60fNHtQTsnvwoyXpEnIvQyGUXxCgTpr75/2sf+9JsDzoANgDjmwOHEAxu
 BAY+bD6lpsDd/e4W2XbOzca5tEeZrDHUeaUguklpBnLqLZJQzN4IHLmKCjv1jcoUh283/LIcmcq
 PfWiJe+Zzkxhw3/foSObhFKavLZ0alKxfGXxwwZ/E1bZT9C5jjPwm7SJADBrxwyldCG6OzpxpEJ
 UFsE4PylnMvIRixLDd8pWA4wjAD+U1B2u7iF6RAEMj6xgH4oCLlPfsF6K4M9K42rW4SVbYBZMiJ
 q47j3eDOupkOMgt8+LCaeeWrlgdikLK/fsBPHkA==
X-Received: by 2002:a05:600c:1d18:b0:46e:4c02:c2f9 with SMTP id
 5b1f17b1804b1-46fa9b18e0emr91219565e9.36.1760114144803; 
 Fri, 10 Oct 2025 09:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq1jeN58U8h5TTRGrIVxqrLszuLlxV0cwv7qK0wlXC4jVtfkB1NoCzNADOwuLSfjAjTdD6KQ==
X-Received: by 2002:a05:600c:1d18:b0:46e:4c02:c2f9 with SMTP id
 5b1f17b1804b1-46fa9b18e0emr91219375e9.36.1760114144345; 
 Fri, 10 Oct 2025 09:35:44 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm62544555e9.9.2025.10.10.09.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:35:43 -0700 (PDT)
Message-ID: <911ff888-2188-48c7-b347-9705d859e2c3@canonical.com>
Date: Fri, 10 Oct 2025 18:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/riscv: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 Ben Dooks <ben.dooks@codethink.co.uk>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-13-philmd@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251010155045.78220-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> mo_endian() returns the target endianness from DisasContext.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/translate.c                      | 18 +++++++++++++++---
>   target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvi.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
>   target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
>   target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
>   target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
>   10 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2e6f39aa02d..e1f4dc5ffd0 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -126,6 +126,18 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>       return ctx->misa_ext & ext;
>   }
>   
> +static inline MemOp mo_endian(DisasContext *ctx)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.

CCing Ben as he is interested in big-endian RISC-V emulation.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> +     */
> +    return MO_TE;
> +}
> +
>   #ifdef TARGET_RISCV32
>   #define get_xl(ctx)    MXL_RV32
>   #elif defined(CONFIG_USER_ONLY)
> @@ -142,7 +154,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>   #define get_address_xl(ctx)    ((ctx)->address_xl)
>   #endif
>   
> -#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
> +#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
>   
>   /* The word size for this machine mode. */
>   static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
> @@ -1135,7 +1147,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>       TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>       MemOp size = mop & MO_SIZE;
>   
> -    mop |= MO_TE;
> +    mop |= mo_endian(ctx);
>       if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
>           mop |= MO_ATOM_WITHIN16;
>       } else {
> @@ -1156,7 +1168,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGv src1 = get_address(ctx, a->rs1, 0);
>       TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>   
> -    mop |= MO_TE;
> +    mop |= mo_endian(ctx);
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
>   
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index 8737e8d60d1..a7a3278d242 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGv src1;
>   
>       mop |= MO_ALIGN;
> -    mop |= MO_TE;
> +    mop |= mo_endian(ctx);
>   
>       decode_save_opc(ctx, 0);
>       src1 = get_address(ctx, a->rs1, 0);
> @@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGLabel *l2 = gen_new_label();
>   
>       mop |= MO_ALIGN;
> -    mop |= MO_TE;
> +    mop |= mo_endian(ctx);
>   
>       decode_save_opc(ctx, 0);
>       src1 = get_address(ctx, a->rs1, 0);
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index 62b75358158..ffea0c2a1f9 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>       } else {
>           memop |= MO_ATOM_IFALIGN;
>       }
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> @@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>       } else {
>           memop |= MO_ATOM_IFALIGN;
>       }
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>   
>       decode_save_opc(ctx, 0);
>       addr = get_address(ctx, a->rs1, a->imm);
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
> index 878417eae92..89fb0f604ad 100644
> --- a/target/riscv/insn_trans/trans_rvf.c.inc
> +++ b/target/riscv/insn_trans/trans_rvf.c.inc
> @@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> @@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVF);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 8db3e78baab..a6fe912b30c 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -404,7 +404,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>   {
>       bool out;
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> @@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>   
>   static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
>   {
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       if (ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
> index 6458ac4f241..8d94b83ce94 100644
> --- a/target/riscv/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
> @@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
>       TCGv src1 = get_address(ctx, a->rs1, 0);
>       TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
>   
> -    mop |= MO_TE;
> +    mop |= mo_endian(ctx);
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
>   
> @@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
>       TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
>       MemOp memop = MO_ALIGN | MO_UO;
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_concat_i64_i128(src2, src2l, src2h);
>       tcg_gen_concat_i64_i128(dest, destl, desth);
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> index 172c2c19c17..0d3ba40e52a 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
>   
>       tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       for (i = X_Sn + 11; i >= 0; i--) {
>           if (reg_bitmap & (1 << i)) {
>               TCGv dest = dest_gpr(ctx, i);
> @@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
>   
>       tcg_gen_subi_tl(addr, sp, reg_size);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       for (i = X_Sn + 11; i >= 0; i--) {
>           if (reg_bitmap & (1 << i)) {
>               TCGv val = get_gpr(ctx, i, EXT_NONE);
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
> index 5355cd46c3d..791ee51f652 100644
> --- a/target/riscv/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
> @@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
>       REQUIRE_FPU;
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {
> @@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
>       REQUIRE_FPU;
>       REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       decode_save_opc(ctx, 0);
>       t0 = get_gpr(ctx, a->rs1, EXT_NONE);
>       if (a->imm) {
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> index 89eed007587..0b6ad57965c 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       src1 = get_address(ctx, a->rs1, 0);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
> @@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>       decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
>       src1 = get_address(ctx, a->rs1, 0);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
>       gen_set_gpr(ctx, a->rd, dest);
>       return true;
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
> index 2f31842791e..f8b95c6498b 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
>       TCGv_i64 rd = cpu_fpr[a->rd];
>       TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
>       if ((memop & MO_SIZE) == MO_32) {
>           gen_nanbox_s(rd, rd);
> @@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
>       TCGv_i64 rd = cpu_fpr[a->rd];
>       TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
>   
>       return true;
> @@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
>       TCGv rd = dest_gpr(ctx, a->rd);
>       TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>       tcg_gen_addi_tl(rs1, rs1, imm);
>       gen_set_gpr(ctx, a->rd, rd);
> @@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
>       TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
>       TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>       tcg_gen_addi_tl(rs1, rs1, imm);
>       gen_set_gpr(ctx, a->rs1, rs1);
> @@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
>       TCGv rd = dest_gpr(ctx, a->rd);
>       TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
>       gen_set_gpr(ctx, a->rd, rd);
>   
> @@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
>       TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
>       TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
>   
>       return true;
> @@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
>       addr1 = get_address(ctx, a->rs, imm);
>       addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
>       tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
>       gen_set_gpr(ctx, a->rd1, t1);
> @@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
>       addr1 = get_address(ctx, a->rs, imm);
>       addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
>   
> -    memop |= MO_TE;
> +    memop |= mo_endian(ctx);
>       tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
>       tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
>       return true;


