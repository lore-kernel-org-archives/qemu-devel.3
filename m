Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A020C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9VS5-0006LB-Ay; Mon, 28 Apr 2025 16:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1u9VRV-0006Id-D3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:51:10 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1u9VRM-0007DQ-NU
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ku9E4GpCdRfon8DV9VGqDBNaG2D0ZFtLp4vkbzOshHQ=; b=qBXfIS50c46lPfv
 81JI9ipmGj7rzn390cjLimOeN91eM7D147Ily0x/Q4/AmJn5bQ3rp55liRyhKnNciTO9yogxLUe+q
 LY7DuOC0SOoR5fUcJY1Wp8R1x3TrD6G7WR/iSSHedj3jZsXJGtGdad4pX8cqxRq7dXTaE/LMkK5d4
 hk=;
Date: Mon, 28 Apr 2025 22:52:08 +0200
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 11/13] physmem: Restrict TCG IOTLB code to TCG accel
Message-ID: <jsiwadpzlgeafczqgqg64hzi5qtl45ulrobxmkevt66dmesi5g@cjtlgne3csps>
References: <20250424202412.91612-1-philmd@linaro.org>
 <20250424202412.91612-12-philmd@linaro.org>
 <cao656ggvonu2gwwcrpu5n23nfa2epmdr6v2str4pwofhzoypo@mmbjpmvzkdxe>
 <1f6c0738-6bbe-4608-956e-d94ca89b53d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f6c0738-6bbe-4608-956e-d94ca89b53d0@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/04/25, Richard Henderson wrote:
> On 4/28/25 11:51, Anton Johansson wrote:
> > On 24/04/25, Philippe Mathieu-Daudé wrote:
> > > Restrict iotlb_to_section(), address_space_translate_for_iotlb()
> > > and memory_region_section_get_iotlb() to TCG. Declare them in
> > > the new "accel/tcg/iommu.h" header. Declare iotlb_to_section()
> > > using the MemoryRegionSection typedef.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   MAINTAINERS               |  2 +-
> > >   include/accel/tcg/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++
> > >   include/exec/exec-all.h   | 26 -------------------------
> > >   accel/tcg/cputlb.c        |  1 +
> > >   system/physmem.c          |  5 +++++
> > >   5 files changed, 48 insertions(+), 27 deletions(-)
> > >   create mode 100644 include/accel/tcg/iommu.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 661a47db5ac..3a37cc73af7 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -168,7 +168,7 @@ F: include/exec/helper*.h.inc
> > >   F: include/exec/helper-info.c.inc
> > >   F: include/exec/page-protection.h
> > >   F: include/system/tcg.h
> > > -F: include/accel/tcg/cpu-ops.h
> > > +F: include/accel/tcg/
> > >   F: host/include/*/host/cpuinfo.h
> > >   F: util/cpuinfo-*.c
> > >   F: include/tcg/
> > > diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> > > new file mode 100644
> > > index 00000000000..90cfd6c0ed1
> > > --- /dev/null
> > > +++ b/include/accel/tcg/iommu.h
> > > @@ -0,0 +1,41 @@
> > > +/*
> > > + * TCG IOMMU translations.
> > > + *
> > > + * Copyright (c) 2003 Fabrice Bellard
> > > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > > + */
> > > +#ifndef ACCEL_TCG_IOMMU_H
> > > +#define ACCEL_TCG_IOMMU_H
> > > +
> > > +#ifdef CONFIG_USER_ONLY
> > > +#error Cannot include accel/tcg/iommu.h from user emulation
> > > +#endif
> > > +
> > > +#include "exec/hwaddr.h"
> > > +#include "exec/memattrs.h"
> > 
> > Missing qemu/typedefs.h include
> 
> No, that's always done by qemu/osdep.h in the c file.
> 
> 
> r~

Oh alright then! Thanks:)

-- 
Anton Johansson
rev.ng Labs Srl.

