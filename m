Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD40DC0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 18:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdCsf-0002ky-H2; Wed, 29 Jan 2025 13:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdCse-0002kq-AO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:33:40 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdCsb-0003lR-OP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:33:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E4134E6019;
 Wed, 29 Jan 2025 19:33:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SK_CBcdKJroa; Wed, 29 Jan 2025 19:33:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA3654E6014; Wed, 29 Jan 2025 19:33:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D811F74577C;
 Wed, 29 Jan 2025 19:33:30 +0100 (CET)
Date: Wed, 29 Jan 2025 19:33:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, imp@bsdimp.com, 
 kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu, 
 npiggin@gmail.com
Subject: Re: [PATCH 5/6] Revert "tcg/cputlb: remove other-cpu capability from
 TLB flushing"
In-Reply-To: <20250129134436.1240740-6-imammedo@redhat.com>
Message-ID: <82142340-a80e-49f0-8e45-aa043932e026@eik.bme.hu>
References: <20250129134436.1240740-1-imammedo@redhat.com>
 <20250129134436.1240740-6-imammedo@redhat.com>
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

On Wed, 29 Jan 2025, Igor Mammedov wrote:
> 1)
> This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
>  ("tcg/cputlb: remove other-cpu capability from TLB flushing")
>
> The commit caused a regression which went unnoticed due to
> affected being disabled by default (DEBUG_TLB_GATE 0)
> Previous patch moved switched to using tcg_debug_assert() so that

The verb "moved" not needed and left from editing?

Regards,
BALATON Zoltan

> at least on debug builds assert_cpu_is_self() path would be exercised.
>
> And that lead to exposing regression introduced by [1] with abort during tests.
> to reproduce:
>  $ configure  --target-list=x86_64-softmmu --enable-debug
>  $ make && ./qemu-system-x86_64
>
>  accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
>    Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.
>
> which is triggered by usage outside of cpu thread:
>    x86_cpu_new -> ... ->
>      x86_cpu_realizefn -> cpu_reset -> ... ->
>          tcg_cpu_reset_hold
>
> Drop offending commit for now, until a propper fix that doesn't break
> 'make check' is available.
>
> PS:
> fixup g_memdup() checkpatch error s/g_memdup/g_memdup2/
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I'll leave it upto TCG folz to fix it up propperly.
>
> CC: npiggin@gmail.com
> CC: richard.henderson@linaro.org
> ---
> accel/tcg/cputlb.c | 42 +++++++++++++++++++++++++++++++++---------
> 1 file changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 71207d6dbf..db1713b3ca 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -416,9 +416,12 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
> {
>     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>
> -    assert_cpu_is_self(cpu);
> -
> -    tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> +    if (cpu->created && !qemu_cpu_is_self(cpu)) {
> +        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
> +                         RUN_ON_CPU_HOST_INT(idxmap));
> +    } else {
> +        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> +    }
> }
>
> void tlb_flush(CPUState *cpu)
> @@ -607,12 +610,28 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
> {
>     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
>
> -    assert_cpu_is_self(cpu);
> -
>     /* This should already be page aligned */
>     addr &= TARGET_PAGE_MASK;
>
> -    tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
> +    if (qemu_cpu_is_self(cpu)) {
> +        tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
> +    } else if (idxmap < TARGET_PAGE_SIZE) {
> +        /*
> +         * Most targets have only a few mmu_idx.  In the case where
> +         * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
> +         * allocating memory for this operation.
> +         */
> +        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
> +                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
> +    } else {
> +        TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
> +
> +        /* Otherwise allocate a structure, freed by the worker.  */
> +        d->addr = addr;
> +        d->idxmap = idxmap;
> +        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
> +                         RUN_ON_CPU_HOST_PTR(d));
> +    }
> }
>
> void tlb_flush_page(CPUState *cpu, vaddr addr)
> @@ -775,8 +794,6 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
> {
>     TLBFlushRangeData d;
>
> -    assert_cpu_is_self(cpu);
> -
>     /*
>      * If all bits are significant, and len is small,
>      * this devolves to tlb_flush_page.
> @@ -797,7 +814,14 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>     d.idxmap = idxmap;
>     d.bits = bits;
>
> -    tlb_flush_range_by_mmuidx_async_0(cpu, d);
> +    if (qemu_cpu_is_self(cpu)) {
> +        tlb_flush_range_by_mmuidx_async_0(cpu, d);
> +    } else {
> +        /* Otherwise allocate a structure, freed by the worker.  */
> +        TLBFlushRangeData *p = g_memdup2(&d, sizeof(d));
> +        async_run_on_cpu(cpu, tlb_flush_range_by_mmuidx_async_1,
> +                         RUN_ON_CPU_HOST_PTR(p));
> +    }
> }
>
> void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
>

