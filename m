Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D07C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsDI-0002RO-Qz; Tue, 27 May 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uJsDG-0002RF-BZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:11:18 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uJsDB-00076V-HB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:11:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b68zZ4SFTz6JB72;
 Tue, 27 May 2025 19:09:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4CBF2140146;
 Tue, 27 May 2025 19:10:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 May
 2025 13:10:56 +0200
Date: Tue, 27 May 2025 12:10:54 +0100
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
Message-ID: <20250527121054.000027fd@huawei.com>
In-Reply-To: <20250524144031.49810-1-richard.henderson@linaro.org>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 24 May 2025 15:40:31 +0100
Richard Henderson <richard.henderson@linaro.org> wrote:

> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
> we failed to update atomic_mmu_lookup to properly reconstruct flags.
> 
> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I've run basic tests (the ones that were tripping over this 100% of the time)
and all looks good.  Thanks!  I'll run some more comprehensive testing this afternoon
but looking good.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Way outside my comfort zone so not appropriate for me to say more than
I tested it!

> ---
>  accel/tcg/cputlb.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5f6d7c601c..86d0deb08c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1871,8 +1871,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>          goto stop_the_world;
>      }
>  
> -    /* Collect tlb flags for read. */
> +    /* Finish collecting tlb flags for both read and write. */
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>      tlb_addr |= tlbe->addr_read;
> +    tlb_addr &= TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
> +    tlb_addr |= full->slow_flags[MMU_DATA_STORE];
> +    tlb_addr |= full->slow_flags[MMU_DATA_LOAD];
>  
>      /* Notice an IO access or a needs-MMU-lookup access */
>      if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
> @@ -1882,13 +1886,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>      }
>  
>      hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>  
>      if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
>          notdirty_write(cpu, addr, size, full, retaddr);
>      }
>  
> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
>          int wp_flags = 0;
>  
>          if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
> @@ -1897,10 +1900,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>          if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
>              wp_flags |= BP_MEM_READ;
>          }
> -        if (wp_flags) {
> -            cpu_check_watchpoint(cpu, addr, size,
> -                                 full->attrs, wp_flags, retaddr);
> -        }
> +        cpu_check_watchpoint(cpu, addr, size,
> +                             full->attrs, wp_flags, retaddr);
>      }
>  
>      return hostaddr;


