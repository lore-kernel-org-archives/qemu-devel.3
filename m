Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CF0C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWJk-0007bX-Di; Wed, 10 Jul 2024 08:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWJi-0007Xa-4K; Wed, 10 Jul 2024 08:21:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWJg-0007uG-G5; Wed, 10 Jul 2024 08:21:01 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E40BA4E6005;
 Wed, 10 Jul 2024 14:20:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pxwWvReYOXsD; Wed, 10 Jul 2024 14:20:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 028624E601B; Wed, 10 Jul 2024 14:20:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 00C79746E3B;
 Wed, 10 Jul 2024 14:20:55 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:20:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v2 08/13] target/ppc: Merge helper_{dcbz,dcbzep}
In-Reply-To: <20240710032814.104643-9-richard.henderson@linaro.org>
Message-ID: <e5887250-eabd-f04b-e95f-0ea27ad8876a@eik.bme.hu>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-9-richard.henderson@linaro.org>
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
> Merge the two and pass the mmu_idx directly from translation.
> Swap the argument order in dcbz_common to avoid extra swaps.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> target/ppc/helper.h     |  3 +--
> target/ppc/mem_helper.c | 14 ++++----------
> target/ppc/translate.c  |  4 ++--
> 3 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index afc56855ff..4fa089cbf9 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -46,8 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> -DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
> -DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
> #ifdef TARGET_PPC64
> DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)

Why only dcbz but not dcbzl as well to make them uniform?

Regards,
BALATON Zoltan

> #endif
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index d4957efd6e..24bae3b80c 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,7 +271,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
> }
>
> static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
> +                        int mmu_idx, int dcbz_size, uintptr_t retaddr)
> {
>     target_ulong mask = ~(target_ulong)(dcbz_size - 1);
>     void *haddr;
> @@ -296,15 +296,9 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>     }
> }
>
> -void helper_dcbz(CPUPPCState *env, target_ulong addr)
> +void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
> {
> -    dcbz_common(env, addr, env->dcache_line_size,
> -                ppc_env_mmu_index(env, false), GETPC());
> -}
> -
> -void helper_dcbzep(CPUPPCState *env, target_ulong addr)
> -{
> -    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
> +    dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
> }
>
> #ifdef TARGET_PPC64
> @@ -320,7 +314,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
>         dcbz_size = 32;
>     }
>
> -    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
> +    dcbz_common(env, addr, ppc_env_mmu_index(env, false), dcbz_size, GETPC());
> }
> #endif
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2664c94522..285734065b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4458,7 +4458,7 @@ static void gen_dcbz(DisasContext *ctx)
>     }
> #endif
>
> -    gen_helper_dcbz(tcg_env, tcgv_addr);
> +    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
> }
>
> /* dcbzep */
> @@ -4468,7 +4468,7 @@ static void gen_dcbzep(DisasContext *ctx)
>
>     gen_set_access_type(ctx, ACCESS_CACHE);
>     gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbzep(tcg_env, tcgv_addr);
> +    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
> }
>
> /* dst / dstt */
>

