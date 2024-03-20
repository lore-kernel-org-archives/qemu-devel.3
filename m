Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B990BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn3yT-0007OH-Ry; Wed, 20 Mar 2024 17:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rn3yR-0007NO-Re; Wed, 20 Mar 2024 17:59:52 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rn3yM-0000Lb-0x; Wed, 20 Mar 2024 17:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXcp6nmYQiOnkyo3239WHF4QCUPILYG3e0Ystupic7U=; b=OCN7BK/Uc6HGM5dW/cbK0m1ioN
 zQ1IUSCI1QBaEfh0CiWfAQQb1YhAyhVzmhyNu4YNzW0hzX65FjovxdiVscQnD7PfBozAzjy4Loz13
 VDSdH+wRFP/B9hCpb0J93Xc5GGhMf/8LOzjuShW16Nv/nBPNVelERIsbMz2hLxZY3cNpsPeidbosq
 kdgNHOU3q12LMfETPo9ZV+eBkSHv/41gOXFFlj0AZdIF3r+M50Q567lqxQs+qpM8fxL2eMDlP/rRH
 r4YQZrPoilcEpdwwQQ7APFv3eoYssXrVjwCyesfBpLH/jcnusMprgQ6EVrixmG0qwn7OZYSWi3tZ6
 pxUSZ0bQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rn3yH-00DZue-13;
 Wed, 20 Mar 2024 21:59:41 +0000
Date: Wed, 20 Mar 2024 21:59:41 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH-for-9.0 0/2] target/monitor: Deprecate 'info tlb/mem' in
 favor of 'info mmu'
Message-ID: <ZftcTb2_O8zHPd3Z@gallifrey>
References: <20240320164055.60319-1-philmd@linaro.org>
 <CAFEAcA81u9J9iijs-CNDbsANb6c0Cdb4qQKmBd=DiQAoFA4U=w@mail.gmail.com>
 <5deec986-7a22-402d-abe1-4e40f5bb427a@linaro.org>
 <CAFEAcA_4J32gpUgxXxND8ZVhrEEhFK=gPG2SF8xsVJ+jpkV0WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_4J32gpUgxXxND8ZVhrEEhFK=gPG2SF8xsVJ+jpkV0WA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 21:59:13 up 78 days, 48 min,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Wed, 20 Mar 2024 at 17:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > +Alex/Daniel
> >
> > On 20/3/24 17:53, Peter Maydell wrote:
> > > On Wed, 20 Mar 2024 at 16:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > >>
> > >> 'info tlb' and 'info mem' commands don't scale in heterogeneous
> > >> emulation. They will be reworked after the next release, hidden
> > >> behind the 'info mmu' command. It is not too late to deprecate
> > >> commands, so add the 'info mmu' command as wrapper to the other
> > >> ones, but already deprecate them.
> > >>
> > >> Philippe Mathieu-Daudé (2):
> > >>    target/monitor: Introduce 'info mmu' command
> > >>    target/monitor: Deprecate 'info tlb' and 'info mem' commands
> > >
> > > This seems to replace "info tlb" and "info mem" with "info mmu -t"
> > > and "info mmu -m", but it doesn't really say anything about:
> > >   * what the difference is between these two things
> >
> > I really don't know; I'm only trying to keep the monitor interface
> > identical.
> 
> You don't, though: you change it from "info tlb" to "info mmu -t" etc.
> 
> > >   * which targets implement which and why
> >
> > This one is easy to answer:
> >
> > #if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC)
> > || \
> >      defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
> >      {
> >          .name       = "tlb",
> >
> > #if defined(TARGET_I386) || defined(TARGET_RISCV)
> >      {
> >          .name       = "mem",
> >
> > >   * what the plan is for the future
> >
> > My problem is with linking a single QEMU binary, as these two symbols
> > (hmp_info_mem and hmp_info_tlb) clash.
> 
> Yes, but they both (implicitly) operate on the current HMP CPU,
> so the problem with linking into a single binary is that they're
> not indirected through a method on the CPU object, not the syntax
> used in the monitor to invoke them, presumably.
> 
> > I'm indeed only postponing the problem, without looking at what
> > this code does. I did it adding hmp_info_mmu_tlb/mem hooks in
> > TCGCPUOps ("hw/core/tcg-cpu-ops.h"), so the command can be
> > dispatched per target vcpu as target-agnostic code in
> > monitor/hmp-cmds.c:
> >
> > +#include "hw/core/tcg-cpu-ops.h"
> > +
> > +static void hmp_info_mmu_tlb(Monitor *mon, CPUState *cpu)
> > +{
> > +    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> > +
> > +    if (tcg_ops->hmp_info_mmu_tlb) {
> > +        tcg_ops->hmp_info_mmu_tlb(mon, cpu_env(cpu));
> > +    } else {
> > +        monitor_puts(mon, "No per-CPU information available on this
> > target\n");
> > +    }
> > +}
> 
> These aren't TCG specific though, so why TCGCPUOps ?
> 
> > > I am definitely not a fan of either of these commands, because
> > > (as we currently implement them) they effectively require each
> > > target architecture to implement a second copy of the page table
> > > walking code. But before we can deprecate them we need to be
> > > pretty sure that "info mmu" is what we want to replace them with.
> >
> > An alternative is to just deprecate them, without adding "info mmu" :)
> >
> > It is OK to un-deprecate stuff if we realize its usefulness.
> 
> The commands are there because some users find them useful.
> I just dislike them because I think they're a bit niche and
> annoying to implement and not consistent across target
> architectures and not very well documented...
> 
> By the way, we have no obligation to follow the deprecate-and-drop
> process for HMP commands; unlike QMP, we give ourselves the
> license to vary it when we feel like it, because the users are
> humans, not programs or scripts.

Right, so no rush to get the deprecation in; change it when you agree
what you'd like a replacement to look like.

Dave

> -- PMM
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

