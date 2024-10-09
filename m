Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0001DCEE330
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 16:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syZXB-0000zH-F8; Wed, 09 Oct 2024 12:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1syZX8-0000z1-EN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:27:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1syZX6-0001Cz-Bp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:27:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3E144E6000;
 Wed, 09 Oct 2024 18:27:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id vd2uOlJQosNS; Wed,  9 Oct 2024 18:27:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EB4BE4E600E; Wed, 09 Oct 2024 18:27:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E9720746F60;
 Wed, 09 Oct 2024 18:27:18 +0200 (CEST)
Date: Wed, 9 Oct 2024 18:27:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/23] accel/tcg: Convert victim tlb to
 IntervalTree
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
Message-ID: <2d59794c-ae72-a3c5-85fa-01f0354c1e4c@eik.bme.hu>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
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

On Wed, 9 Oct 2024, Richard Henderson wrote:
> Based-on: 20241009000453.315652-1-richard.henderson@linaro.org
> ("[PATCH v3 00/20] accel/tcg: Introduce tlb_fill_align hook")
>
> The initial idea was: how much can we do with an intelligent data
> structure for the same cost as a linear search through an array?
>
> This is an initial installment along these lines.  This is about
> as far as I can go without first converting all targets to the
> new tlb_fill_align hook.  Indeed, the final two patches will not
> compile with all targets enabled, but hint at the direction of
> the next steps.
>
> I do not expect large perf changes with this patch set.  I will
> be happy if performance comes out even.

Then what's the point? Diffstat below does not show it's less code and if 
it's also not more efficient then what's the reason to change it? I'm not 
opposed to any change just don't see an explanation of what motivates this 
series.

Regards,
BALATON Zoltan

>
> r~
>
> Richard Henderson (23):
>  util/interval-tree: Introduce interval_tree_free_nodes
>  accel/tcg: Split out tlbfast_flush_locked
>  accel/tcg: Split out tlbfast_{index,entry}
>  accel/tcg: Split out tlbfast_flush_range_locked
>  accel/tcg: Fix flags usage in mmu_lookup1, atomic_mmu_lookup
>  accel/tcg: Early exit for zero length in tlb_flush_range_by_mmuidx*
>  accel/tcg: Flush entire tlb when a masked range wraps
>  accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
>  accel/tcg: Populate IntervalTree in tlb_set_page_full
>  accel/tcg: Remove IntervalTree entry in tlb_flush_page_locked
>  accel/tcg: Remove IntervalTree entries in tlb_flush_range_locked
>  accel/tcg: Process IntervalTree entries in tlb_reset_dirty
>  accel/tcg: Process IntervalTree entries in tlb_set_dirty
>  accel/tcg: Replace victim_tlb_hit with tlbtree_hit
>  accel/tcg: Remove the victim tlb
>  include/exec/tlb-common: Move CPUTLBEntryFull from hw/core/cpu.h
>  accel/tcg: Delay plugin adjustment in probe_access_internal
>  accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
>  accel/tcg: Always use IntervalTree for code lookups
>  accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
>  accel/tcg: Remove CPUTLBDesc.fulltlb
>  accel/tcg: Drop TCGCPUOps.tlb_fill -- NOTYET
>  accel/tcg: Unexport tlb_set_page*
>
> include/exec/cpu-all.h        |   3 +
> include/exec/exec-all.h       |  57 ----
> include/exec/tlb-common.h     |  68 +++-
> include/hw/core/cpu.h         |  75 +----
> include/hw/core/tcg-cpu-ops.h |  10 -
> include/qemu/interval-tree.h  |  11 +
> accel/tcg/cputlb.c            | 599 +++++++++++++++++++---------------
> util/interval-tree.c          |  20 ++
> util/selfmap.c                |  13 +-
> 9 files changed, 431 insertions(+), 425 deletions(-)
>
>

