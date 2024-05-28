Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE433C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqmK-0002pS-0G; Tue, 28 May 2024 02:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sBqmH-0002p7-GP; Tue, 28 May 2024 02:57:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sBqmE-00032g-BX; Tue, 28 May 2024 02:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716879453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=gRw/eSq2LPDM9ogXGYpeYnLMy9GVHC6TUNR9QdwCuoI=;
 b=ya+O3fn66rV+851cWg4pzrFj+ymEBAx0RmMXcTg3tNg/UYLVtfaxu3SSaRIRvdoxjARIQ7McJwDD+737rme84yjPT8GNKH5qQlGTt8Mk67CqUVOB48Ot1avfAx+utjcTOu8U8bc5LRv20355eAjbovAPHpGfgaFDxi6C9YB1G6E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W7OoUtj_1716879450; 
Received: from 30.166.64.174(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W7OoUtj_1716879450) by smtp.aliyun-inc.com;
 Tue, 28 May 2024 14:57:32 +0800
Message-ID: <80fb43eb-0e24-4fc3-9aaa-77e040317b0d@linux.alibaba.com>
Date: Tue, 28 May 2024 14:56:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] targer/riscv: Implement Zabha extension
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Gianluca Guida <gianluca@rivosinc.com>
References: <20240528054535.290953-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240528054535.290953-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Alexandre,

I have sent the patch set about Zabha before last week.

https://lore.kernel.org/all/fed99165-58da-458c-b68f-a9717fc15034@linux.alibaba.com/T/

Welcome to review it and give comments.

Thanks,
Zhiwei

On 2024/5/28 13:45, Alexandre Ghiti wrote:
> From: Gianluca Guida <gianluca@rivosinc.com>
>
> Add Zabha implementation.
>
> Signed-off-by: Gianluca Guida <gianluca@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   target/riscv/cpu.c                          |   2 +
>   target/riscv/cpu_cfg.h                      |   1 +
>   target/riscv/insn32.decode                  |  22 +++
>   target/riscv/insn_trans/trans_rvzabha.c.inc | 149 ++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c                  |   5 +
>   target/riscv/translate.c                    |   1 +
>   6 files changed, 180 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 70d1a527a1..b01f82002b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -116,6 +116,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>       ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>       ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> +    ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_12_0, ext_zabha),
>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>       ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> @@ -1464,6 +1465,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>       MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
>       MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>       MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>       MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index d36c416ef0..7f614da4e2 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -81,6 +81,7 @@ struct RISCVCPUConfig {
>       bool ext_svvptc;
>       bool ext_zdinx;
>       bool ext_zaamo;
> +    bool ext_zabha;
>       bool ext_zacas;
>       bool ext_zalrsc;
>       bool ext_zawrs;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..6d7726120f 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1010,3 +1010,25 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
>   amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
>   # *** RV64 Zacas Standard Extension ***
>   amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
> +
> +# *** Zabha Standard Extension ***
> +amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoadd_b   00000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoxor_b   00100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoand_b   01100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoor_b    01000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomin_b   10000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomax_b   10100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amominu_b  11000 . . ..... ..... 000 ..... 0101111 @atom_st
> +amomaxu_b  11100 . . ..... ..... 000 ..... 0101111 @atom_st
> +amocas_b   00101 . . ..... ..... 000 ..... 0101111 @atom_st
> +amoswap_h  00001 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoadd_h   00000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoxor_h   00100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoand_h   01100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amoor_h    01000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
> +amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
> +amocas_h   00101 . . ..... ..... 001 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
> new file mode 100644
> index 0000000000..74f43bb95a
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
> @@ -0,0 +1,149 @@
> +/*
> + * RISC-V translation routines for the Zabha Standard Extension.
> + *
> + * Copyright (c) 2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZABHA(ctx) do {                 \
> +        if (!ctx->cfg_ptr->ext_zabha) {         \
> +            return false;                       \
> +        }                                       \
> +    } while (0)
> +
> +#define REQUIRE_ZABHA_AND_ZACAS(ctx) do {                               \
> +        if (!ctx->cfg_ptr->ext_zabha || !ctx->cfg_ptr->ext_zacas) {     \
> +            return false;                                               \
> +        }                                                               \
> +    } while (0)
> +
> +static bool trans_amoswap_b(DisasContext *ctx, arg_amoswap_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SB);
> +}
> +
> +static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amoadd_b(DisasContext *ctx, arg_amoadd_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SB);
> +}
> +
> +static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amoxor_b(DisasContext *ctx, arg_amoxor_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SB);
> +}
> +
> +static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amoand_b(DisasContext *ctx, arg_amoand_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SB);
> +}
> +
> +static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amoor_b(DisasContext *ctx, arg_amoor_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SB);
> +}
> +
> +static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amomin_b(DisasContext *ctx, arg_amomin_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SB);
> +}
> +
> +static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amomax_b(DisasContext *ctx, arg_amomax_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SB);
> +}
> +
> +static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amominu_b(DisasContext *ctx, arg_amominu_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SB);
> +}
> +
> +static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SB);
> +}
> +
> +static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
> +{
> +    REQUIRE_ZABHA(ctx);
> +    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
> +{
> +    REQUIRE_ZABHA_AND_ZACAS(ctx);
> +    return gen_cmpxchg(ctx, a, MO_SB);
> +}
> +
> +static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
> +{
> +    REQUIRE_ZABHA_AND_ZACAS(ctx);
> +    return gen_cmpxchg(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b5b95e052d..25a57bac0f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -456,6 +456,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if ((cpu->cfg.ext_zabha) && !riscv_has_ext(env, RVA)) {
> +        error_setg(errp, "Zabha extension requires A extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zawrs) && !riscv_has_ext(env, RVA)) {
>           error_setg(errp, "Zawrs extension requires A extension");
>           return;
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ff09ebdb6..1e128711db 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1097,6 +1097,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "insn_trans/trans_rvb.c.inc"
>   #include "insn_trans/trans_rvzicond.c.inc"
>   #include "insn_trans/trans_rvzacas.c.inc"
> +#include "insn_trans/trans_rvzabha.c.inc"
>   #include "insn_trans/trans_rvzawrs.c.inc"
>   #include "insn_trans/trans_rvzicbo.c.inc"
>   #include "insn_trans/trans_rvzfa.c.inc"

