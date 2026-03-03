Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B52FEC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO4h-00034F-BE; Tue, 03 Mar 2026 06:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxO4d-00033k-M7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:37:59 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxO4b-0000am-OE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+QQrrQJ3BHy9VRXmgfSlftbT+ZLLPlnPfejxYpeCOc4=; b=kO0ClAWqt66p8S0
 WcnGFIOlVoumFld2dxP+5qVxNQRO/09bOj2guct3InhMQh2jiq/c01OoCRzJRVdRES+bCXBno3Vu3
 mSI6G9htdzAgQZNuF3NIhfhlE6Dmr8SSF62uB/cWIVviD790+bf6YfwkGv2fHx0NLv9X1wNd3nNCb
 DA=;
Date: Tue, 3 Mar 2026 12:41:31 +0100
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 3/4] hppa: Get physical address space bits from
 HPPACPUDef
Message-ID: <aabIfQAZhxbGeXur@hive.localdomain>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-3-447a800da8cc@rev.ng>
 <82aa1b68-3504-4276-ba5b-862b7bcbd7bb@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82aa1b68-3504-4276-ba5b-862b7bcbd7bb@gmx.de>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/03/26, Helge Deller wrote:
> On 3/2/26 12:56, Anton Johansson wrote:
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/hppa/cpu.h        | 11 ++++++++---
> >   hw/hppa/machine.c        |  4 ++--
> >   hw/pci-host/astro.c      |  2 +-
> >   target/hppa/mem_helper.c | 40 ++++++++++++----------------------------
> >   4 files changed, 23 insertions(+), 34 deletions(-)
> > 
> > ...
> > diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> > index 9199d1e06a..4bd806a53f 100644
> > --- a/target/hppa/mem_helper.c
> > +++ b/target/hppa/mem_helper.c
> > @@ -29,29 +29,12 @@
> >   #include "hw/core/cpu.h"
> >   #include "trace.h"
> > -/*
> > - * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
> > - * machines 7300LC.  This should give 44 and 32 bits of physical address
> > - * space respectively.
> > - *
> > - *   CPU model        Physical address space bits
> > - *   PA-7000--7300LC  32
> > - *   PA-8000--8600    40
> > - *   PA-8700--8900    44
> > - *
> > - * FIXME: However, the SeaBIOS firmware that is that tested against
> > - * uses 40-bit physical addresses, despite supposedly running a C3700
> > - * with a PA-8700 cpu, so use 40-bits for 64-bit.
> > - */
> > -#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
> > -#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
> > -
> > -hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
> > +hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr)
> >   {
> > -    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
> > +    return extract64(addr, 0, hppa_phys_addr_bits(env));
> >   }
> > -hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
> > +hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr)
> >   {
> >       /*
> >        * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" describes
> > @@ -64,11 +47,12 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
> >        * Since the supported physical address space is below 54 bits, the
> >        * H-8 algorithm is moot and all that is left is to truncate.
> >        */
> > -    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
> > -    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
> > +    const uint8_t pa = hppa_phys_addr_bits(env);
> > +    g_assert(pa <= 54);
> 
> This g_assert() is now a runtime check which adds cycles for every hppa_abs_to_phys_pa2_w1() call,
> while the previous QEMU_BUILD_BUG_ON() was a cheap compile-time check.
> Can we change it, or simply drop it, because hppa_phys_addr_bits() anyways return a constant?

Good point, I think having the sanity check somewhere still makes sense
since we are assuming that it's less than 54.  I'll move it to the
initialization of the CPU base class, so it's only ran once.

> Other than that:
> Reviewed-by: Helge Deller <deller@gmx.de>

Thanks!

