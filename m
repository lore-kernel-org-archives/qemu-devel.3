Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22316CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uto7B-0005z6-TH; Wed, 03 Sep 2025 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uto77-0005wy-7w; Wed, 03 Sep 2025 10:05:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uto6x-0006Ze-Up; Wed, 03 Sep 2025 10:05:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EA2A56F3A0;
 Wed, 03 Sep 2025 16:05:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TKnWAS9mFcFS; Wed,  3 Sep 2025 16:05:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7EC1056F39E; Wed, 03 Sep 2025 16:05:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7C75456F3A9;
 Wed, 03 Sep 2025 16:05:12 +0200 (CEST)
Date: Wed, 3 Sep 2025 16:05:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>
cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH v2 3/4] target/ppc: Add support for LE pages on PowerPC
 booke206 mmu
In-Reply-To: <20250903134146.1487794-4-d.zhebryakov@yandex.ru>
Message-ID: <87b5780b-9cb4-6de6-faab-c0629449d3b7@eik.bme.hu>
References: <20250903134146.1487794-1-d.zhebryakov@yandex.ru>
 <20250903134146.1487794-4-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 3 Sep 2025, Danila Zhebryakov wrote:
> Add support for passing TLB_BSWAP flag from powerpc booke206 MMU
> Fix instruction fetches from LE pages being treated as MMIO
> This change should not affect SPARC, as its instruction fetches are always BE
>
> Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
> ---
> accel/tcg/cputlb.c     | 26 +++++++++++++++-----------
> target/ppc/mmu-booke.c |  4 ++++
> target/ppc/translate.c | 42 +++++++++++++++++++++++++++++++++++++-----
> 3 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d5b94c384c..deb9f9ad24 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1401,7 +1401,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>     flags |= full->slow_flags[access_type];
>
>     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
> -    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> +    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY
> +                           | TLB_CHECK_ALIGNED | TLB_BSWAP))
>         || (access_type != MMU_INST_FETCH && force_mmio)) {
>         *phost = NULL;
>         return TLB_MMIO;
> @@ -1792,12 +1793,19 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>             mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
>         }
>
> -        /*
> -         * Since target/sparc is the only user of TLB_BSWAP, and all
> -         * Sparc accesses are aligned, any treatment across two pages
> -         * would be arbitrary.  Refuse it until there's a use.
> -         */
> -        tcg_debug_assert((flags & TLB_BSWAP) == 0);
> +        if (unlikely(flags & TLB_BSWAP)) {
> +            /*
> +             * TLB_BSWAP is relevant to SPARC and powerPC e500.
> +             * SPARC never ends up here, as all its accesses are aligned
> +             * cross-page accesses do work for e500, but crossing boundary
> +             * between different endian pages should generate an exception
> +             * Adding this would require another callback for a cpu for
> +             * *just* this case, and such accesses are not correct anyway,
> +             * so it just fails.
> +             */
> +            assert(!(TLB_BSWAP & (l->page[0].flags ^ l->page[1].flags)));
> +            l->memop ^= MO_BSWAP;
> +        }
>     }
>
>     return crosspage;
> @@ -1895,10 +1903,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>     }
>
>     if (unlikely(tlb_addr & TLB_BSWAP)) {
> -        assert(!( (  full->slow_flags[MMU_DATA_STORE]
> -            ^ full->slow_flags[MMU_DATA_LOAD ])
> -            & TLB_BSWAP));
> -
>         mop ^= MO_BSWAP;
>     }
>
> diff --git a/target/ppc/mmu-booke.c b/target/ppc/mmu-booke.c
> index 10ba8052d4..172e9604e0 100644
> --- a/target/ppc/mmu-booke.c
> +++ b/target/ppc/mmu-booke.c
> @@ -362,6 +362,10 @@ found_tlb:
>     uint8_t *prot = &(full->prot);
>     *prot = 0;
>
> +    if (tlb->mas2 & MAS2_E) {
> +        full->tlb_fill_flags |= TLB_BSWAP;
> +    }
> +
>     if (pr) {
>         if (tlb->mas7_3 & MAS3_UR) {
>             *prot |= PAGE_READ;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 27f90c3cc5..2ebb862b69 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -24,7 +24,9 @@
> #include "exec/target_page.h"
> #include "tcg/tcg-op.h"
> #include "tcg/tcg-op-gvec.h"
> +#include "accel/tcg/probe.h"
> #include "qemu/host-utils.h"
> +#include "exec/tlb-flags.h"
>
> #include "exec/helper-proto.h"
> #include "exec/helper-gen.h"
> @@ -171,7 +173,7 @@ struct DisasContext {
>     target_ulong cia;  /* current instruction address */
>     uint32_t opcode;
>     /* Routine used to access memory */
> -    bool pr, hv, dr, le_mode;
> +    bool pr, hv, dr, le_mode, insn_le_mode;
>     bool lazy_tlb_flush;
>     bool need_access_type;
>     int mem_idx;
> @@ -209,16 +211,42 @@ struct DisasContext {
> #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
> #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
>
> -/* Return true iff byteswap is needed in a scalar memop */
> +/* Return true if byteswap is needed in instruction fetch */

This is likely not a typo but short for if and only if. Leave it 
unchanged.

Regards,
BALATON Zoltan

