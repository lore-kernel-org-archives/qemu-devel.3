Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F79C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3Vq-0003aA-DJ; Mon, 03 Mar 2025 05:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp3Vo-0003ZY-9X; Mon, 03 Mar 2025 05:59:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp3Vj-0002p9-07; Mon, 03 Mar 2025 05:59:03 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B94CA4E6014;
 Mon, 03 Mar 2025 11:58:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id blv0oRQU-hBk; Mon,  3 Mar 2025 11:58:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C0D154E6010; Mon, 03 Mar 2025 11:58:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BED1574577C;
 Mon, 03 Mar 2025 11:58:54 +0100 (CET)
Date: Mon, 3 Mar 2025 11:58:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] target/ppc: Do not set HPTE R/C bits on !guest_visible
 xlate
In-Reply-To: <20250303104755.584897-1-npiggin@gmail.com>
Message-ID: <caad84f0-d3dc-dd89-14d0-498a9246772b@eik.bme.hu>
References: <20250303104755.584897-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 3 Mar 2025, Nicholas Piggin wrote:
> Perform !guest_visible memory accesses without modifying R/C bits.
>
> It's arguable whether !guest_visible memory accesses should modify
> R/C bits. i386 seems to set accessed/dirty bit updates for "probe"
> accesses, but ppc with radix MMU does not. Follow the ppc/radix
> lead and perform the accesses without updating R/C bits.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> target/ppc/mmu-hash32.c | 27 ++++++++++++++-------------
> target/ppc/mmu-hash64.c | 27 ++++++++++++++-------------
> 2 files changed, 28 insertions(+), 26 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 1f791a7f2f7..b8d7f87507b 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -410,19 +410,20 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>
>     /* 8. Update PTE referenced and changed bits if necessary */
> -
> -    if (!(pte.pte1 & HPTE32_R_R)) {
> -        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
> -    }
> -    if (!(pte.pte1 & HPTE32_R_C)) {
> -        if (access_type == MMU_DATA_STORE) {
> -            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
> -        } else {
> -            /*
> -             * Treat the page as read-only for now, so that a later write
> -             * will pass through this function again to set the C bit
> -             */
> -            prot &= ~PAGE_WRITE;
> +    if (guest_visible) {

Are these unlikely() ? Not sure if that makes a difference but if we know 
it may help some compilers.

Regards,
BALATON Zoltan

> +        if (!(pte.pte1 & HPTE32_R_R)) {
> +            ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
> +        }
> +        if (!(pte.pte1 & HPTE32_R_C)) {
> +            if (access_type == MMU_DATA_STORE) {
> +                ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
> +            } else {
> +                /*
> +                 * Treat the page as read-only for now, so that a later write
> +                 * will pass through this function again to set the C bit
> +                 */
> +                prot &= ~PAGE_WRITE;
> +            }
>         }
>     }
>     *protp = prot;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 5ca4faee2ab..de5eb5fb221 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1183,19 +1183,20 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>
>     /* 6. Update PTE referenced and changed bits if necessary */
> -
> -    if (!(pte.pte1 & HPTE64_R_R)) {
> -        ppc_hash64_set_r(cpu, ptex, pte.pte1);
> -    }
> -    if (!(pte.pte1 & HPTE64_R_C)) {
> -        if (access_type == MMU_DATA_STORE) {
> -            ppc_hash64_set_c(cpu, ptex, pte.pte1);
> -        } else {
> -            /*
> -             * Treat the page as read-only for now, so that a later write
> -             * will pass through this function again to set the C bit
> -             */
> -            prot &= ~PAGE_WRITE;
> +    if (guest_visible) {
> +        if (!(pte.pte1 & HPTE64_R_R)) {
> +            ppc_hash64_set_r(cpu, ptex, pte.pte1);
> +        }
> +        if (!(pte.pte1 & HPTE64_R_C)) {
> +            if (access_type == MMU_DATA_STORE) {
> +                ppc_hash64_set_c(cpu, ptex, pte.pte1);
> +            } else {
> +                /*
> +                 * Treat the page as read-only for now, so that a later write
> +                 * will pass through this function again to set the C bit
> +                 */
> +                prot &= ~PAGE_WRITE;
> +            }
>         }
>     }
>
>

