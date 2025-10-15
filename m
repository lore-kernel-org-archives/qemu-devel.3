Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F818CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yZl-0001qx-M8; Wed, 15 Oct 2025 06:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8yZj-0001qb-Hh; Wed, 15 Oct 2025 06:17:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8yZe-0007Be-Ne; Wed, 15 Oct 2025 06:17:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3813B5972E3;
 Wed, 15 Oct 2025 12:17:29 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id l2waVepzRVc3; Wed, 15 Oct 2025 12:17:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ED81E5972DE; Wed, 15 Oct 2025 12:17:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBC6359703F;
 Wed, 15 Oct 2025 12:17:26 +0200 (CEST)
Date: Wed, 15 Oct 2025 12:17:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
In-Reply-To: <20251015065742.1562288-1-thuth@redhat.com>
Message-ID: <bc32be80-a01e-7ec7-f073-9a8b7b0eeec8@eik.bme.hu>
References: <20251015065742.1562288-1-thuth@redhat.com>
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
> so let's check for a compatible model before we try to wire some
> pins that don't exist.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> hw/ppc/e500.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 723c97fad2e..d40b7a618db 100644
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
> @@ -947,6 +948,10 @@ void ppce500_init(MachineState *machine)
>                          env->mmu_model);
>             exit(1);
>         }

I think you can drop the mmu_model check above now becuase it's a no-op 
after the stricter check for e500 you added so no need to keep that 
separate error, the new check catches that too.

Regards,
BALATON Zoltan

> +        if (!(POWERPC_CPU_GET_CLASS(cpu)->svr & POWERPC_SVR_E500)) {
> +            error_report("This machine needs a CPU from the e500 family");
> +            exit(1);
> +        }
>
>         /*
>          * Secondary CPU starts in halted state for now. Needs to change
>

