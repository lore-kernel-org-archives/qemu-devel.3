Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB71CC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toPQL-00025Y-36; Sat, 01 Mar 2025 11:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toPQI-000251-Pc; Sat, 01 Mar 2025 11:10:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1toPQF-0006ih-TI; Sat, 01 Mar 2025 11:10:42 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B22B4E60F7;
 Sat, 01 Mar 2025 17:10:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id O7D769hbvTK1; Sat,  1 Mar 2025 17:10:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48D894E603E; Sat, 01 Mar 2025 17:10:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 46ED774577C;
 Sat, 01 Mar 2025 17:10:35 +0100 (CET)
Date: Sat, 1 Mar 2025 17:10:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <20250115211544.307124E602F@zero.eik.bme.hu>
Message-ID: <aabb2da4-3eaa-2a5f-b461-01727c380372@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Wed, 15 Jan 2025, BALATON Zoltan wrote:
> This allows guests to set the CCSR base address. Also store and return
> values of the local access window registers but their functionality
> isn't implemented.

Bernhard,

If you have no alternative patch you plan to submit for next release 
should we merge this for now? This helps running u-boot binaries even if 
it's not enough alone but would be one patch less in my local tree. Or do 
you know about a problem with this patch why this should not be merged?

Regards,
BALATON Zoltan

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/ppc/e500-ccsr.h |  4 +++
> hw/ppc/e500.c      | 79 ++++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/e500-ccsr.h
> index 249c17be3b..cfbf96e181 100644
> --- a/hw/ppc/e500-ccsr.h
> +++ b/hw/ppc/e500-ccsr.h
> @@ -4,12 +4,16 @@
> #include "hw/sysbus.h"
> #include "qom/object.h"
>
> +#define NR_LAWS 12
> +
> struct PPCE500CCSRState {
>     /*< private >*/
>     SysBusDevice parent;
>     /*< public >*/
>
>     MemoryRegion ccsr_space;
> +
> +    uint32_t law_regs[NR_LAWS * 2];
> };
>
> #define TYPE_CCSR "e500-ccsr"
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 64f8c766b4..376cb4cb37 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -43,6 +43,7 @@
> #include "qemu/host-utils.h"
> #include "qemu/option.h"
> #include "hw/pci-host/ppce500.h"
> +#include "qemu/log.h"
> #include "qemu/error-report.h"
> #include "hw/platform-bus.h"
> #include "hw/net/fsl_etsec/etsec.h"
> @@ -1331,11 +1332,83 @@ void ppce500_init(MachineState *machine)
>     boot_info->dt_size = dt_size;
> }
>
> +static int law_idx(hwaddr addr)
> +{
> +    int idx;
> +
> +    addr -= 0xc08;
> +    idx = 2 * ((addr >> 5) & 0xf);
> +    if (addr & 8) {
> +        idx++;
> +    }
> +    assert(idx < 2 * NR_LAWS);
> +    return idx;
> +}
> +
> +static uint64_t law_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PPCE500CCSRState *s = opaque;
> +    uint64_t val = 0;
> +
> +    switch (addr) {
> +    case 0:
> +        val = s->ccsr_space.addr >> 12;
> +        break;
> +    case 0xc08 ... 0xd70:
> +        val = s->law_regs[law_idx(addr)];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register read"
> +                      "0x%" HWADDR_PRIx "\n", addr);
> +    }
> +    return val;
> +}
> +
> +static void law_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    PPCE500CCSRState *s = opaque;
> +
> +    switch (addr) {
> +    case 0:
> +        val &= 0xffff00;
> +        memory_region_set_address(&s->ccsr_space, val << 12);
> +        break;
> +    case 0xc08 ... 0xd70:
> +    {
> +        int idx = law_idx(addr);
> +
> +        qemu_log_mask(LOG_UNIMP, "Unimplemented local access register write"
> +                      "0x%" HWADDR_PRIx " <- 0x%" PRIx64 "\n", addr, val);
> +        val &= (idx & 1) ? 0x80f0003f : 0xffffff;
> +        s->law_regs[idx] = val;
> +        break;
> +    }
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register write"
> +                      "0x%" HWADDR_PRIx "\n", addr);
> +    }
> +}
> +
> +static const MemoryRegionOps law_ops = {
> +    .read = law_read,
> +    .write = law_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> static void e500_ccsr_initfn(Object *obj)
> {
> -    PPCE500CCSRState *ccsr = CCSR(obj);
> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
> -                       MPC8544_CCSRBAR_SIZE);
> +    PPCE500CCSRState *s = CCSR(obj);
> +    MemoryRegion *mr;
> +
> +    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC8544_CCSRBAR_SIZE);
> +
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_io(mr, obj, &law_ops, s, "local-access", 4096);
> +    memory_region_add_subregion(&s->ccsr_space, 0, mr);
> }
>
> static const TypeInfo e500_ccsr_info = {
>

