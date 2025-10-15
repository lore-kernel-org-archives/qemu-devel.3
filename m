Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB45CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90yt-0005nC-Rj; Wed, 15 Oct 2025 08:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v90yr-0005lB-9W; Wed, 15 Oct 2025 08:51:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v90yl-00070j-UL; Wed, 15 Oct 2025 08:51:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA14B59703F;
 Wed, 15 Oct 2025 14:51:37 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id c9fKtgpdMHdG; Wed, 15 Oct 2025 14:51:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 98B3D5972E9; Wed, 15 Oct 2025 14:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96F925972DE;
 Wed, 15 Oct 2025 14:51:35 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:51:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/ppc/e500: Check for compatible CPU type instead
 of aborting ungracefully
In-Reply-To: <20251015111243.1585018-1-thuth@redhat.com>
Message-ID: <c2b57b2a-e24f-427b-0769-82465eb4032f@eik.bme.hu>
References: <20251015111243.1585018-1-thuth@redhat.com>
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

On Wed, 15 Oct 2025, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> When using the ppce500 machine with an embedded CPU type that has
> the right MMU model, but is not part of the e500 CPU family, QEMU
> currently aborts ungracefully:
>
> $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
> qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
>  Assertion `n >= 0 && n < gpio_list->num_in' failed.
> Aborted (core dumped)
>
> The ppce500 machine expects a CPU with certain GPIO interrupt pins,
> so let's replace the coarse check for the MMU_BOOKE206 model with
> a more precise check that only allows CPUs from the e500 family.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> v2: Drop the old check for the MMU_BOOKE206 model
>
> hw/ppc/e500.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 723c97fad2e..3d69428f31c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -20,6 +20,7 @@
> #include "qemu/guest-random.h"
> #include "exec/target_page.h"
> #include "qapi/error.h"
> +#include "cpu-models.h"
> #include "e500.h"
> #include "e500-ccsr.h"
> #include "net/net.h"
> @@ -942,9 +943,8 @@ void ppce500_init(MachineState *machine)
>         env = &cpu->env;
>         cs = CPU(cpu);
>
> -        if (env->mmu_model != POWERPC_MMU_BOOKE206) {
> -            error_report("MMU model %i not supported by this machine",
> -                         env->mmu_model);
> +        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
> +            error_report("This machine needs a CPU from the e500 family");
>             exit(1);
>         }
>
>

