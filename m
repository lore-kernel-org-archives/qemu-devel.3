Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDFACFB424
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 17:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxUo1-0002FC-AV; Sun, 06 Oct 2024 13:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxUnx-0002Ea-EP; Sun, 06 Oct 2024 13:12:26 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxUnu-000269-O5; Sun, 06 Oct 2024 13:12:25 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2DE4B4E6004;
 Sun, 06 Oct 2024 19:12:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id P9Wq9uwLE9g3; Sun,  6 Oct 2024 19:12:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E294C4E6001; Sun, 06 Oct 2024 19:12:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0E2F746F60;
 Sun, 06 Oct 2024 19:12:16 +0200 (CEST)
Date: Sun, 6 Oct 2024 19:12:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 08/23] hw/ppc/ppce500_ccsr: Log access to unimplemented
 registers
In-Reply-To: <20241005194603.23139-9-shentey@gmail.com>
Message-ID: <a201615f-90b1-1d8e-75ea-0766e231a0a8@eik.bme.hu>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-9-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, 5 Oct 2024, Bernhard Beschow wrote:
> The CCSR space is just a container which is meant to be covered by platform
> device memory regions. However, QEMU only implements a subset of these devices.
> Add some logging to see which devices a guest attempts to access.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ppc/ppce500_ccsr.c | 32 +++++++++++++++++++++++++++++++-
> hw/ppc/trace-events   |  3 +++
> 2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
> index 5d0e1e0e89..6659560674 100644
> --- a/hw/ppc/ppce500_ccsr.c
> +++ b/hw/ppc/ppce500_ccsr.c
> @@ -13,12 +13,42 @@
>
> #include "qemu/osdep.h"
> #include "ppce500_ccsr.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +
> +static uint64_t ppce500_ccsr_io_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    uint64_t value = 0;
> +
> +    trace_ppce500_ccsr_io_read(addr, value, size);
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unimplemented [0x%" HWADDR_PRIx "] -> 0\n",
> +                  __func__, addr);

I'm not sure having both unimp log and traces is the best way. I thought 
unimp log with an unimplemented device area would be the simplest and 
least intrusive for the code but if you prefer traces then maybe we don't 
need unimp logs. But adding these otherwise empty functions (which won't 
get populated as subdevices have their own regions) still bothers me a bit 
but not enough to block this if others have no opinion on it.

I also had this patch:
https://patchew.org/QEMU/cover.1728232526.git.balaton@eik.bme.hu/
which I first thought might help but that's about guest_errors not unimp 
logs so does not apply here. What other unimp logs get in the way here 
that makes traces a better choice?

Regards,
BALATON Zoltan

> +
> +    return value;
> +}
> +
> +static void ppce500_ccsr_io_write(void *opaque, hwaddr addr, uint64_t value,
> +                                  unsigned size)
> +{
> +    trace_ppce500_ccsr_io_write(addr, value, size);
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unimplemented [0x%" HWADDR_PRIx "] <- 0x%" PRIx32 "\n",
> +                  __func__, addr, (uint32_t)value);
> +}
> +
> +static const MemoryRegionOps ppce500_ccsr_ops = {
> +    .read = ppce500_ccsr_io_read,
> +    .write = ppce500_ccsr_io_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
>
> static void ppce500_ccsr_init(Object *obj)
> {
>     PPCE500CCSRState *s = CCSR(obj);
>
> -    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
> +    memory_region_init_io(&s->ccsr_space, obj, &ppce500_ccsr_ops, obj,
> +                          "e500-ccsr", MPC85XX_CCSRBAR_SIZE);
>     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->ccsr_space);
> }
>
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 1f125ce841..ca4c231c9f 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -143,6 +143,9 @@ ppc_irq_cpu(const char *action) "%s"
> ppc_dcr_read(uint32_t addr, uint32_t val) "DRCN[0x%x] -> 0x%x"
> ppc_dcr_write(uint32_t addr, uint32_t val) "DRCN[0x%x] <- 0x%x"
>
> +ppce500_ccsr_io_read(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] -> 0x%08x (size: 0x%" PRIu8 ")"
> +ppce500_ccsr_io_write(uint32_t index, uint32_t val, uint8_t size) "[0x%" PRIx32 "] <- 0x%08x (size: 0x%" PRIu8 ")"
> +
> # prep_systemio.c
> prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
> prep_systemio_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
>

