Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0612CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnGu-0005uH-5T; Thu, 23 Oct 2025 00:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnovikov@NB-7271.syntacore.com>)
 id 1vBehX-0005Mu-PB; Wed, 22 Oct 2025 15:40:52 -0400
Received: from ppp91-77-168-124.pppoe.mtu-net.ru ([91.77.168.124]
 helo=NB-7271.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnovikov@NB-7271.syntacore.com>)
 id 1vBehU-0003O2-VE; Wed, 22 Oct 2025 15:40:51 -0400
Received: from NB-7271.syntacore.com (localhost [127.0.0.1])
 by NB-7271.syntacore.com (8.18.1/8.18.1) with ESMTP id 59MJAiER038149;
 Wed, 22 Oct 2025 22:10:44 +0300
Received: (from nnovikov@localhost)
 by NB-7271 (8.18.1/8.18.1/Submit) id 59MJ0AOp035115;
 Wed, 22 Oct 2025 22:00:10 +0300
Date: Wed, 22 Oct 2025 21:59:09 +0300
From: Nikita Novikov <nnovikov@NB-7271.syntacore.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: n.novikov@syntacore.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH] accel/tcg: Pass actual memop_size to tlb_fill instead of 0
Message-ID: <busf3stsde5y7hq7zslr2kfyibp5ve2wrvrrawik3xbfpmsr7f@2nr5m4kdlltn>
References: <20251022115213.91457-1-n.novikov@syntacore.com>
 <79beaf9a-9558-40e7-a01d-5f80d8931eba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79beaf9a-9558-40e7-a01d-5f80d8931eba@linaro.org>
Received-SPF: none client-ip=91.77.168.124;
 envelope-from=nnovikov@NB-7271.syntacore.com; helo=NB-7271.syntacore.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 KHOP_HELO_FCRDNS=0.399, NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 00:49:54 -0400
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

On Wed, Oct 22, 2025 at 10:32:31AM -0500, Richard Henderson wrote:
> On 10/22/25 06:52, Nikita Novikov wrote:
> > Recent debugging of misaligned access handling on RISC-V revealed that we
> > always call `tlb_fill` with `memop_size == 0`. This behavior effectively
> > disables natural alignment checks in `riscv_tlb_fill_align()`, because we
> > have to fall back from `memop_size` to `size` when computing the alignment bits.
> > 
> > With `memop_size == 0`, misaligned cross-page stores end up reported as
> > `store access fault` (AF, cause=7) instead of the expected
> > `store page fault` (PF, cause=15), since the “misalign” path triggers before
> > the second page translation can fault. This breaks misaligned accesses at
> > page boundaries.
> > 
> > After switching to pass the real `l->memop` into `tlb_fill`, the cross-page
> > faults are no longer mis-classified as AF.
> > 
> > Fixes: ec03dd972378 ("accel/tcg: Hoist first page lookup above pointer_wrap")
> > 
> > Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> > ---
> >   accel/tcg/cputlb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 631f1fe135..271c061be1 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -1782,7 +1782,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
> >            * If the lookup potentially resized the table, refresh the
> >            * first CPUTLBEntryFull pointer.
> >            */
> > -        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
> > +        if (mmu_lookup1(cpu, &l->page[1], l->memop, l->mmu_idx, type, ra)) {
> >               uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
> >               l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
> >           }
> 
> How is the memop really applicable to the second half of a split-page operation?
> 
Because the second half is still part of the same guest memory operation. It must obey
the same size, alignment, and atomicity rules. Passing the real memop ensures correct
alignment and atomic checks even if the access crosses a page boundary.
> 
> r~
> 

