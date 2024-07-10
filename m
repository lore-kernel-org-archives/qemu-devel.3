Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48987C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 12:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWAW-0000A3-7Z; Wed, 10 Jul 2024 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWAQ-00006H-9M; Wed, 10 Jul 2024 08:11:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sRWAN-0005zs-BZ; Wed, 10 Jul 2024 08:11:26 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 714CE4E600F;
 Wed, 10 Jul 2024 14:11:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id OXSFRbNrVm4M; Wed, 10 Jul 2024 14:11:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 76BEF4E6005; Wed, 10 Jul 2024 14:11:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74E99746E3B;
 Wed, 10 Jul 2024 14:11:14 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:11:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v2 06/13] target/ppc: Hoist dcbz_size out of
 dcbz_common
In-Reply-To: <20240710032814.104643-7-richard.henderson@linaro.org>
Message-ID: <aedda59d-2a8f-94bd-246d-d32ee6cf19be@eik.bme.hu>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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
> The 970 logic does not apply to dcbzep, which is an e500 insn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

As all callers pass GETPC() to retaddr maybe that could be moved into 
dcbz_common() as i had in my patch.

Regards,
BALATON Zoltan

> ---
> target/ppc/mem_helper.c | 30 +++++++++++++++---------------
> 1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 361fd72226..5067919ff8 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,22 +271,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
> }
>
> static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
> +                        int dcbz_size, int mmu_idx, uintptr_t retaddr)
> {
> -    target_ulong mask, dcbz_size = env->dcache_line_size;
> -    uint32_t i;
> +    target_ulong mask = ~(target_ulong)(dcbz_size - 1);
>     void *haddr;
>
> -#if defined(TARGET_PPC64)
> -    /* Check for dcbz vs dcbzl on 970 */
> -    if (env->excp_model == POWERPC_EXCP_970 &&
> -        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
> -        dcbz_size = 32;
> -    }
> -#endif
> -
>     /* Align address */
> -    mask = ~(dcbz_size - 1);
>     addr &= mask;
>
>     /* Check reservation */
> @@ -300,7 +290,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>         memset(haddr, 0, dcbz_size);
>     } else {
>         /* Slow path */
> -        for (i = 0; i < dcbz_size; i += 8) {
> +        for (int i = 0; i < dcbz_size; i += 8) {
>             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
>         }
>     }
> @@ -308,12 +298,22 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>
> void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> {
> -    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());
> +    int dcbz_size = env->dcache_line_size;
> +
> +#if defined(TARGET_PPC64)
> +    /* Check for dcbz vs dcbzl on 970 */
> +    if (env->excp_model == POWERPC_EXCP_970 &&
> +        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
> +        dcbz_size = 32;
> +    }
> +#endif
> +
> +    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
> }
>
> void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
> {
> -    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
> +    dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
> }
>
> void helper_icbi(CPUPPCState *env, target_ulong addr)
>

