Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E212C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWGp-0001sd-Ly; Wed, 10 Jul 2024 08:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWGn-0001qs-BK; Wed, 10 Jul 2024 08:18:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWGc-0007DY-Sh; Wed, 10 Jul 2024 08:17:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E6BC4E601B;
 Wed, 10 Jul 2024 14:17:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id djzZqR-pUrO3; Wed, 10 Jul 2024 14:17:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8B4354E6005; Wed, 10 Jul 2024 14:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8983A746E3B;
 Wed, 10 Jul 2024 14:17:45 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:17:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v2 07/13] target/ppc: Split out helper_dbczl for 970
In-Reply-To: <20240710032814.104643-8-richard.henderson@linaro.org>
Message-ID: <66e91236-02d1-5e81-20df-5db4146b624b@eik.bme.hu>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 9 Jul 2024, Richard Henderson wrote:
> We can determine at translation time whether the insn is or
> is not dbczl.  We must retain a runtime check against the
> HID5 register, but we can move that to a separate function
> that never affects other ppc models.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> target/ppc/helper.h     |  7 +++++--
> target/ppc/mem_helper.c | 34 +++++++++++++++++++++-------------
> target/ppc/translate.c  | 24 ++++++++++++++----------
> 3 files changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 76b8f25c77..afc56855ff 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -46,8 +46,11 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> -DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
> -DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
> +DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
> +#ifdef TARGET_PPC64
> +DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
> +#endif
> DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
> DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 5067919ff8..d4957efd6e 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -296,26 +296,34 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>     }
> }
>
> -void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +void helper_dcbz(CPUPPCState *env, target_ulong addr)
> {
> -    int dcbz_size = env->dcache_line_size;
> -
> -#if defined(TARGET_PPC64)
> -    /* Check for dcbz vs dcbzl on 970 */
> -    if (env->excp_model == POWERPC_EXCP_970 &&
> -        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
> -        dcbz_size = 32;
> -    }
> -#endif
> -
> -    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
> +    dcbz_common(env, addr, env->dcache_line_size,
> +                ppc_env_mmu_index(env, false), GETPC());
> }
>
> -void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> +void helper_dcbzep(CPUPPCState *env, target_ulong addr)
> {
>     dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
> }
>
> +#ifdef TARGET_PPC64
> +void helper_dcbzl(CPUPPCState *env, target_ulong addr)
> +{
> +    int dcbz_size = env->dcache_line_size;
> +
> +    /*
> +     * The translator checked for POWERPC_EXCP_970.
> +     * All that's left is to check HID5.
> +     */
> +    if (((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
> +        dcbz_size = 32;
> +    }
> +
> +    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
> +}
> +#endif
> +
> void helper_icbi(CPUPPCState *env, target_ulong addr)
> {
>     addr &= ~(env->dcache_line_size - 1);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0bc16d7251..2664c94522 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -200,6 +200,7 @@ struct DisasContext {
>     uint32_t flags;
>     uint64_t insns_flags;
>     uint64_t insns_flags2;
> +    powerpc_excp_t excp_model;
> };
>
> #define DISAS_EXIT         DISAS_TARGET_0  /* exit to main loop, pc updated */
> @@ -4445,27 +4446,29 @@ static void gen_dcblc(DisasContext *ctx)
> /* dcbz */
> static void gen_dcbz(DisasContext *ctx)
> {
> -    TCGv tcgv_addr;
> -    TCGv_i32 tcgv_op;
> +    TCGv tcgv_addr = tcg_temp_new();
>
>     gen_set_access_type(ctx, ACCESS_CACHE);
> -    tcgv_addr = tcg_temp_new();
> -    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
>     gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
> +
> +#ifdef TARGET_PPC64
> +    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 0x00200000)) {
> +        gen_helper_dcbzl(tcg_env, tcgv_addr);
> +        return;
> +    }
> +#endif
> +
> +    gen_helper_dcbz(tcg_env, tcgv_addr);
> }
>
> /* dcbzep */
> static void gen_dcbzep(DisasContext *ctx)
> {
> -    TCGv tcgv_addr;
> -    TCGv_i32 tcgv_op;
> +    TCGv tcgv_addr = tcg_temp_new();
>
>     gen_set_access_type(ctx, ACCESS_CACHE);
> -    tcgv_addr = tcg_temp_new();
> -    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
>     gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
> +    gen_helper_dcbzep(tcg_env, tcgv_addr);
> }
>
> /* dst / dstt */
> @@ -6480,6 +6483,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>     ctx->hv = (hflags >> HFLAGS_HV) & 1;
>     ctx->insns_flags = env->insns_flags;
>     ctx->insns_flags2 = env->insns_flags2;
> +    ctx->excp_model = env->excp_model;
>     ctx->access_type = -1;
>     ctx->need_access_type = !mmu_is_64bit(env->mmu_model);
>     ctx->le_mode = (hflags >> HFLAGS_LE) & 1;
>

