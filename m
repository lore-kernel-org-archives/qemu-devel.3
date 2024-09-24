Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ED1CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2aK-0002eE-Df; Tue, 24 Sep 2024 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1st2aE-0002cY-SG; Tue, 24 Sep 2024 06:15:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1st2aC-0004SK-CV; Tue, 24 Sep 2024 06:15:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A64714E601B;
 Tue, 24 Sep 2024 12:15:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ubQ3YcTVPEfA; Tue, 24 Sep 2024 12:15:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 635654E603D; Tue, 24 Sep 2024 12:15:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5DE6F746F60;
 Tue, 24 Sep 2024 12:15:43 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:15:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 08/23] hw/ppc/ppce500_ccsr: Log access to unimplemented
 registers
In-Reply-To: <20240923093016.66437-9-shentey@gmail.com>
Message-ID: <308608c8-8ea8-dedc-26c8-3a10016e9b9c@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-9-shentey@gmail.com>
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> The CCSR space is just a container which is meant to be covered by platform
> device memory regions. However, QEMU only implements a subset of these devices.
> Add some logging to see which devices a guest attempts to access.

An aleternative solution for a similar problem is this:
https://patchew.org/QEMU/20240520101007.A25A34E602E@zero.eik.bme.hu/
I don't know if that would be simpler for this device as well.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ppc/ppce500_ccsr.c | 33 +++++++++++++++++++++++++++++++--
> hw/ppc/trace-events   |  3 +++
> 2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
> index 191a9ceec3..28942b2348 100644
> --- a/hw/ppc/ppce500_ccsr.c
> +++ b/hw/ppc/ppce500_ccsr.c
> @@ -15,14 +15,43 @@
>  */
>
> #include "qemu/osdep.h"
> +#include "qemu/log.h"
> #include "e500-ccsr.h"
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
> static void e500_ccsr_init(Object *obj)
> {
>     PPCE500CCSRState *ccsr = CCSR(obj);
>
> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
> -                       MPC8544_CCSRBAR_SIZE);
> +    memory_region_init_io(&ccsr->ccsr_space, obj, &ppce500_ccsr_ops, obj,
> +                          "e500-ccsr", MPC8544_CCSRBAR_SIZE);
>     sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
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

