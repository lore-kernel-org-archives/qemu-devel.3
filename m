Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A716E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 12:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQnHH-0003vh-Rs; Thu, 26 Dec 2024 07:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnHA-0003vG-5m
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:47:41 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tQnH7-0008Qm-Tq
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 07:47:39 -0500
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so6287126a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1735217255; x=1735822055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c36H+Rj6SLZOlaG4b2OZo4vrgYeDEU6thfwUTL/iJc8=;
 b=nE28lf/p/p0RiigOZvOlo2CWU1l7r7Ao0R2RFQt648YGqljR49AhBqt6GzAwRQY+4S
 6LBxuJwRtSuMhCcHtycYz0IHkhM6urbNnTPmHeZS+Tuea96qieArA/BNuutmPykvMpSX
 1ACwfvfDX9iPA6aZahOWEY+3KBClbZmTyZpRKsAOvEaYqt8uJT6yb/Xkh7/GZdavUPRc
 2y4QHOvkg9U8shWhxdPjXY9Uhv9jMcLx7Fv18eAWnKL8CnueWWjHiZQxxQk+FQpXLkSZ
 NJ1OdgWRT3QWWiRQNoOAbh9RW1Mryq+9tpFgVe9g41XnFtft1J33QmiIXxQMp1JeURML
 V/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735217255; x=1735822055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c36H+Rj6SLZOlaG4b2OZo4vrgYeDEU6thfwUTL/iJc8=;
 b=RTjIHiyjGzKJoG9Yd7d4jVX85//ZSZONK25pEDgReNbV/1s3urnHaI9OrMW8x15l8a
 CKvKo4RYREiZEXk9PGuupR/G1SCBf7E7nHmn1Mu3GNkzx1n/YiBf8quqZNfRcQsA3MPG
 9huafWOWehH2eAyBGOmWULvRN4DA39ST5cXYKws3Jp0HbTpq18OTyC22ZoVatf4UW4s+
 Gafe7YXIjHoXnsE1893HknBij6bcxKWHaKJm53mdRaV/lM3CDS2P/sjUcc7WsJSHKHNS
 zCw82LsGlUpPzVUnBqtCqynVu6bC6WefRNRJ85weDJ7nPJEUK0ivQgg4pwjs72ZDVdaw
 fzcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2QH+nV2Vxj6fk78e83sKCgos2qafAj7LnFF96xBatrt8IJTsE9dkIxKtBuM0pgky3Vkt/dccGHNjF@nongnu.org
X-Gm-Message-State: AOJu0YyPfQvDKWX2VdjZFAF+1NF7ksxnLbITJpVUwoG2vc1YO9cOi2XY
 TX9GvsaWZRjXT2KbvFlZKvRQVKTPDhquheR6nnGM4qPOYr2m8d/P/q4f6D30hX+ONtD0udPGRau
 mHNBRCoX5
X-Gm-Gg: ASbGncsp7I5EjKQWU46QZM47whFBQoNJzYQqIjiEFd8XVvF8kXCoXh/E72a2VCYP9Dk
 heuUnArlcrqilwdr5eDHSs+R2gO/KCQMhAliXUBuqK/JC22GB1NLdZ8RyQgPYch3rXR2AkD5NuG
 feD6kVdS7SArRm8zFB1trGBUutsibLwTs0u50LpFcMTHhFNdFDag9+T/riAZavReTwAnYV/04J9
 zmDc+qkYa5kK5+2RNDVC6T4vsApBw6UoUsHXba/bIOS3V7vl0flllqfZDQfSy8fsdS/CA==
X-Google-Smtp-Source: AGHT+IEHpNKwj3GI2euCUawfMWYspgeFtg8r9NN/Dn0lDUzIGEoNLxdanSB2fZKAGku1pzQnYNkYxw==
X-Received: by 2002:a17:90b:3ccc:b0:2ef:3192:d280 with SMTP id
 98e67ed59e1d1-2f452dfaed8mr36024410a91.5.1735217255417; 
 Thu, 26 Dec 2024 04:47:35 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c4cc5sm15364265a91.12.2024.12.26.04.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 04:47:34 -0800 (PST)
Message-ID: <24e41e24-1ca8-4a96-a727-a329acc9691a@ventanamicro.com>
Date: Thu, 26 Dec 2024 09:47:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/7] target/riscv: Add Smrnmi mnret instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tommy Wu <tommy.wu@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
 <20241217062440.884261-5-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241217062440.884261-5-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1043.google.com
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



On 12/17/24 3:24 AM, frank.chang@sifive.com wrote:
> From: Tommy Wu <tommy.wu@sifive.com>
> 
> This patch adds a new instruction 'mnret'. 'mnret' is an M-mode-only
> instruction that uses the values in `mnepc` and `mnstatus` to return to the
> program counter, privilege mode, and virtualization mode of the
> interrupted context.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/helper.h                         |  1 +
>   target/riscv/insn32.decode                    |  3 ++
>   .../riscv/insn_trans/trans_privileged.c.inc   | 20 +++++++++
>   target/riscv/op_helper.c                      | 45 ++++++++++++++++---
>   4 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 451261ce5a..16ea240d26 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(sret, tl, env)
>   DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(wfi, void, env)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e9139ec1b9..942c434c6e 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>   sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
> +# *** NMI ***
> +mnret       0111000    00010 00000 000 00000 1110011
> +
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
>   {
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index ecd3b8b2c9..73f940d406 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -18,6 +18,12 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#define REQUIRE_SMRNMI(ctx) do {     \
> +    if (!ctx->cfg_ptr->ext_smrnmi) { \
> +        return false;                \
> +    }                                \
> +} while (0)
> +
>   static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
>   {
>       /* always generates U-level ECALL, fixed in do_interrupt handler */
> @@ -106,6 +112,20 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   #endif
>   }
>   
> +static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMRNMI(ctx);
> +    decode_save_opc(ctx, 0);
> +    gen_helper_mnret(cpu_pc, tcg_env);
> +    tcg_gen_exit_tb(NULL, 0); /* no chaining */
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..63ec53e992 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -321,24 +321,30 @@ target_ulong helper_sret(CPURISCVState *env)
>       return retpc;
>   }
>   
> -target_ulong helper_mret(CPURISCVState *env)
> +static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
> +                                  target_ulong prev_priv)
>   {
>       if (!(env->priv >= PRV_M)) {
>           riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>       }
>   
> -    target_ulong retpc = env->mepc;
>       if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
>           riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>       }
>   
> -    uint64_t mstatus = env->mstatus;
> -    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> -
>       if (riscv_cpu_cfg(env)->pmp &&
>           !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
>           riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
>       }
> +}
> +
> +target_ulong helper_mret(CPURISCVState *env)
> +{
> +    target_ulong retpc = env->mepc;
> +    uint64_t mstatus = env->mstatus;
> +    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> +
> +    check_ret_from_m_mode(env, retpc, prev_priv);
>   
>       target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
>                                (prev_priv != PRV_M);
> @@ -370,6 +376,35 @@ target_ulong helper_mret(CPURISCVState *env)
>       return retpc;
>   }
>   
> +target_ulong helper_mnret(CPURISCVState *env)
> +{
> +    target_ulong retpc = env->mnepc;
> +    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
> +    target_ulong prev_virt;
> +
> +    check_ret_from_m_mode(env, retpc, prev_priv);
> +
> +    prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
> +                (prev_priv != PRV_M);
> +    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
> +
> +    /*
> +     * If MNRET changes the privilege mode to a mode
> +     * less privileged than M, it also sets mstatus.MPRV to 0.
> +     */
> +    if (prev_priv < PRV_M) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
> +    }
> +
> +    if (riscv_has_ext(env, RVH) && prev_virt) {
> +        riscv_cpu_swap_hypervisor_regs(env);
> +    }
> +
> +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
> +
> +    return retpc;
> +}
> +
>   void helper_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);


