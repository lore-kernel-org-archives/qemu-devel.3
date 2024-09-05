Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342ACCD5BCA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDXW-0003rk-EB; Thu, 05 Sep 2024 10:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mps@arvanta.net>) id 1smDXU-0003qe-Jy
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:32:48 -0400
Received: from 93-87-244-166.static.isp.telekom.rs ([93.87.244.166]
 helo=fx.arvanta.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mps@arvanta.net>) id 1smDXS-0003I2-KE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:32:48 -0400
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.11])
 by fx.arvanta.net (Postfix) with ESMTP id A07104B39;
 Thu, 05 Sep 2024 16:32:41 +0200 (CEST)
Date: Thu, 5 Sep 2024 16:32:25 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] util/util/cpuinfo-riscv.c: fix riscv64 build on musl libc
Message-ID: <20240905143225.GA14304@m1pro.arvanta.net>
References: <20240905112440.10438-1-mps@arvanta.net>
 <CAFEAcA9KSNmqQL5AYoHg0y4mV9SJPg6-rRsp8JzWt_7q4B9TaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9KSNmqQL5AYoHg0y4mV9SJPg6-rRsp8JzWt_7q4B9TaA@mail.gmail.com>
Received-SPF: pass client-ip=93.87.244.166; envelope-from=mps@arvanta.net;
 helo=fx.arvanta.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On Thu, 2024-09-05 at 14:45, Peter Maydell wrote:
> On Thu, 5 Sept 2024 at 14:19, Milan P. Stanić <mps@arvanta.net> wrote:
> >
> > build fails on musl libc (alpine linux) with this error:
> >
> > ../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
> > ../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (first use in this function); did you mean 'riscv_hwprobe'?
> >    63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
> >       |                     ^~~~~~~~~~~~~~~~~~
> >       |                     riscv_hwprobe
> > ../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is reported only once for each function it appears in
> > ninja: subcommand failed
> >
> > add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build
> >
> > Signed-off-by: Milan P. Stanić <mps@arvanta.net>
> > ---
> >  util/cpuinfo-riscv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> > index 497ce12680..f4779ed1fb 100644
> > --- a/util/cpuinfo-riscv.c
> > +++ b/util/cpuinfo-riscv.c
> > @@ -5,6 +5,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "host/cpuinfo.h"
> > +#include "asm/unistd.h"
> >
> >  #ifdef CONFIG_ASM_HWPROBE_H
> >  #include <asm/hwprobe.h>
> > --
> 
> Hi; thanks for this patch. I think the new include line should
> go inside the #ifdef CONFIG_ASM_HWPROBE_H block you can
> see in the patch here, because the __NR_riscv_hwprobe symbol
> we want from it is only used by code that's guarded by that ifdef.
> (Otherwise we'll probably fail to compile on non-Linux hosts.)
> 
> System header includes should also use <...>, not "...".

Right. Will send patch v2 soon.

Thanks for help

-- 
Kind regards

> thanks
> -- PMM

