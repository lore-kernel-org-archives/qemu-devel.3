Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D611AEEEC1C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbRI1-0005Z9-74; Thu, 01 Jan 2026 17:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRHy-0005Ym-EX
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:37:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRHw-0007y6-I0
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:37:02 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D9F9C596A03;
 Thu, 01 Jan 2026 23:36:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 35_uSd5bKzza; Thu,  1 Jan 2026 23:36:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD31E5969F6; Thu, 01 Jan 2026 23:36:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DBB985969FF;
 Thu, 01 Jan 2026 23:36:56 +0100 (CET)
Date: Thu, 1 Jan 2026 23:36:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 10/11] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <20251118154812.57861-11-chad@jablonski.xyz>
Message-ID: <269baa49-0d5d-b0e7-bf78-391d059f6abb@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-11-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Writing to any of the HOST_DATA0-7 registers pushes the written data
> into a 128-bit accumulator. When the accumulator is full a flush is
> triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
> will also initiate a flush. The flush itself is left for the next patch.
>
> Unaligned HOST_DATA* writes result in, from what I can tell, undefined
> behavior on real hardware. A well-behaved driver shouldn't be doing this
> anyway. For that reason they are not handled here at all.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 33 +++++++++++++++++++++++++++++++++
> hw/display/ati_dbg.c  |  9 +++++++++
> hw/display/ati_int.h  |  9 +++++++++
> hw/display/ati_regs.h |  9 +++++++++
> 4 files changed, 60 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index cfb5dc2fb8..dc302eb6f2 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -555,6 +555,13 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
>     }
> }
>
> +static void ati_host_data_reset(ATIHostDataState *hd)
> +{
> +    hd->next = 0;
> +    hd->row = 0;
> +    hd->col = 0;
> +}
> +
> static void ati_mm_write(void *opaque, hwaddr addr,
>                            uint64_t data, unsigned int size)
> {
> @@ -830,6 +837,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         break;
>     case DST_WIDTH:
>         s->regs.dst_width = data & 0x3fff;
> +        ati_host_data_reset(&s->host_data);
>         ati_2d_blt(s);
>         break;
>     case DST_HEIGHT:
> @@ -880,6 +888,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_HEIGHT_WIDTH:
>         s->regs.dst_width = data & 0x3fff;
>         s->regs.dst_height = (data >> 16) & 0x3fff;
> +        ati_host_data_reset(&s->host_data);
>         ati_2d_blt(s);
>         break;
>     case DP_GUI_MASTER_CNTL:
> @@ -910,6 +919,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_WIDTH_X:
>         s->regs.dst_x = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> +        ati_host_data_reset(&s->host_data);
>         ati_2d_blt(s);
>         break;
>     case SRC_X_Y:
> @@ -923,6 +933,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DST_WIDTH_HEIGHT:
>         s->regs.dst_height = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> +        ati_host_data_reset(&s->host_data);
>         ati_2d_blt(s);
>         break;
>     case DST_HEIGHT_Y:
> @@ -1017,6 +1028,26 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         break;
>     case SRC_SC_BOTTOM:
>         s->regs.src_sc_bottom = data & 0x3fff;
> +    case HOST_DATA0:
> +    case HOST_DATA1:
> +    case HOST_DATA2:
> +    case HOST_DATA3:
> +    case HOST_DATA4:
> +    case HOST_DATA5:
> +    case HOST_DATA6:
> +    case HOST_DATA7:
> +        s->host_data.acc[s->host_data.next] = data;

You could make this shorter and simpler by always incrementing next as:
s->host_data.acc[s->host_data.next++] = data;
Then test for >= 4 and flush and reset in that case so we don't need two 
breaks out from the block but it can just go to the last break otherwise 
which seems to be a less confusing flow to me.

Regards,
BALATON Zoltan

> +        if (s->host_data.next >= 3) {
> +            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +            s->host_data.next = 0;
> +            break;
> +        }
> +        s->host_data.next += 1;
> +        break;
> +    case HOST_DATA_LAST:
> +        s->host_data.acc[s->host_data.next] = data;
> +        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +        ati_host_data_reset(&s->host_data);
>         break;
>     default:
>         break;
> @@ -1123,6 +1154,8 @@ static void ati_vga_reset(DeviceState *dev)
>     /* reset vga */
>     vga_common_reset(&s->vga);
>     s->mode = VGA_MODE;
> +
> +    ati_host_data_reset(&s->host_data);
> }
>
> static void ati_vga_exit(PCIDevice *dev)
> diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
> index 3ffa7f35df..5c799d540a 100644
> --- a/hw/display/ati_dbg.c
> +++ b/hw/display/ati_dbg.c
> @@ -252,6 +252,15 @@ static struct ati_regdesc ati_reg_names[] = {
>     {"MC_SRC1_CNTL", 0x19D8},
>     {"TEX_CNTL", 0x1800},
>     {"RAGE128_MPP_TB_CONFIG", 0x01c0},
> +    {"HOST_DATA0", 0x17c0},
> +    {"HOST_DATA1", 0x17c4},
> +    {"HOST_DATA2", 0x17c8},
> +    {"HOST_DATA3", 0x17cc},
> +    {"HOST_DATA4", 0x17d0},
> +    {"HOST_DATA5", 0x17d4},
> +    {"HOST_DATA6", 0x17d8},
> +    {"HOST_DATA7", 0x17dc},
> +    {"HOST_DATA_LAST", 0x17e0},
>     {NULL, -1}
> };
>
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index 1e999b11c2..b9142ce6d8 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -15,6 +15,7 @@
> #include "hw/i2c/bitbang_i2c.h"
> #include "vga_int.h"
> #include "qom/object.h"
> +#include "qemu/units.h"
>
> /*#define DEBUG_ATI*/
>
> @@ -95,6 +96,13 @@ typedef struct ATIVGARegs {
>     uint16_t src_sc_right;
> } ATIVGARegs;
>
> +typedef struct ATIHostDataState {
> +    uint32_t row;
> +    uint32_t col;
> +    uint32_t next;
> +    uint32_t acc[4];
> +} ATIHostDataState;
> +
> struct ATIVGAState {
>     PCIDevice dev;
>     VGACommonState vga;
> @@ -112,6 +120,7 @@ struct ATIVGAState {
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
> +    ATIHostDataState host_data;
> };
>
> const char *ati_reg_name(int num);
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 02025eef36..9eb68fbec6 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -252,6 +252,15 @@
> #define DP_T12_CNTL                             0x178c
> #define DST_BRES_T1_LNTH                        0x1790
> #define DST_BRES_T2_LNTH                        0x1794
> +#define HOST_DATA0                              0x17c0
> +#define HOST_DATA1                              0x17c4
> +#define HOST_DATA2                              0x17c8
> +#define HOST_DATA3                              0x17cc
> +#define HOST_DATA4                              0x17d0
> +#define HOST_DATA5                              0x17d4
> +#define HOST_DATA6                              0x17d8
> +#define HOST_DATA7                              0x17dc
> +#define HOST_DATA_LAST                          0x17e0
> #define SCALE_SRC_HEIGHT_WIDTH                  0x1994
> #define SCALE_OFFSET_0                          0x1998
> #define SCALE_PITCH                             0x199c
>

