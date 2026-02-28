Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E245FEE4EE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 17:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwODq-0003xV-P7; Sat, 28 Feb 2026 12:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwODn-0003xC-Ie
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:35:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vwODk-0003Qg-ME
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 12:35:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A658B5969FC;
 Sat, 28 Feb 2026 18:35:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id nqnzULUCv_W2; Sat, 28 Feb 2026 18:35:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C9D55969F2; Sat, 28 Feb 2026 18:35:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7717B5969E4;
 Sat, 28 Feb 2026 18:35:11 +0100 (CET)
Date: Sat, 28 Feb 2026 18:35:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 17/18] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <20260227203944.746471-18-chad@jablonski.xyz>
Message-ID: <bacdcf5e-6382-734d-d29e-c1ec435f5572@eik.bme.hu>
References: <20260227203944.746471-1-chad@jablonski.xyz>
 <20260227203944.746471-18-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 27 Feb 2026, Chad Jablonski wrote:
> Writing to any of the HOST_DATA0-7 registers pushes the written data
> into a 128-bit accumulator. When the accumulator is full a flush is

So this is no longer true as you increased the accumulator to 256? Then 
the commit message needs to be updated too. I wonder if Mach64 had 64 bit 
ops which was then increased to 128 in Rage128. Then is it further 
increased in Rage128Pro and Radeon (in which case can it increase further 
in later chips?), or we have double the bits so host data writes can keep 
writing values to the other half while the 2D engine uses the already 
written half. Does it matter if we don't emulate a concurent 2D engine 
yet? If not maybe we can keep only 128 bits for now to simplify this and 
only implement it when we make 2D engine run concurrently in the future?

> triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
> will also initiate a flush. The flush itself is left for the next patch.
>
> Unaligned HOST_DATA* writes result in, from what I can tell, undefined
> behavior on real hardware. A well-behaved driver shouldn't be doing this
> anyway. For that reason they are not handled here at all.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

You should only keep R-b tags if the patch was not changed or only 
trivially changed otherwise it needs to be reviewed again so you should 
drop previous R-b tag.

> ---
> hw/display/ati.c      | 32 ++++++++++++++++++++++++++++++++
> hw/display/ati_dbg.c  |  9 +++++++++
> hw/display/ati_int.h  | 11 +++++++++++
> hw/display/ati_regs.h |  9 +++++++++
> 4 files changed, 61 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 6cf243bcf9..3757b8426e 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1024,6 +1024,33 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case SRC_SC_BOTTOM:
>         s->regs.src_sc_bottom = data & 0x3fff;
>         break;
> +    case HOST_DATA0:
> +    case HOST_DATA1:
> +    case HOST_DATA2:
> +    case HOST_DATA3:
> +    case HOST_DATA4:
> +    case HOST_DATA5:
> +    case HOST_DATA6:
> +    case HOST_DATA7:
> +        if (!s->host_data.active) {
> +            break;
> +        }
> +        s->host_data.acc[s->host_data.next] = data;
> +        if (s->host_data.next % ATI_HOST_DATA_FLUSH_WORDS ==
> +                ATI_HOST_DATA_FLUSH_WORDS - 1) {
> +            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +        }
> +        s->host_data.next = (s->host_data.next + 1) %
> +                ARRAY_SIZE(s->host_data.acc);

Indents are off here and in the previous if above.

> +        break;
> +    case HOST_DATA_LAST:
> +        if (!s->host_data.active) {
> +            break;
> +        }
> +        s->host_data.acc[s->host_data.next] = data;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "HOST_DATA finish flush not yet implemented\n");
> +        break;
>     default:
>         break;
>     }
> @@ -1129,6 +1156,11 @@ static void ati_vga_reset(DeviceState *dev)
>     /* reset vga */
>     vga_common_reset(&s->vga);
>     s->mode = VGA_MODE;
> +
> +    s->host_data.active = false;
> +    s->host_data.next = 0;
> +    s->host_data.row = 0;
> +    s->host_data.col = 0;
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
> index 98f57ca5fa..b285b6eba5 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -32,6 +32,8 @@
>
> #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
> #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
> +#define ATI_HOST_DATA_FLUSH_BITS 128
> +#define ATI_HOST_DATA_FLUSH_WORDS (ATI_HOST_DATA_FLUSH_BITS / 32)

I think these may not be the best constants as you still do a lot of 
calculation with them so maybe it could be simplified but I don't know 
how. If there's no visible difference in output with normal usage only in 
corned cases that only happened during testing then maybe it's too early 
to try to implement this and we could go back to the previous 128 bit 
accumulator unless you found some real world usage where this would 
matter. Otherwise I think this would only matter with a concurent 2D 
engine where host data writes could continue in the other half of the 256 
bit register while the 2D engine does the operation on the already written 
half. So if we get the same graphical result with only storing 128 bits 
for now we could do that and rething this when we can run the 2D engine 
concurrently.

Regards,
BALATON Zoltan

> #define TYPE_ATI_VGA "ati-vga"
> OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
> @@ -95,6 +97,14 @@ typedef struct ATIVGARegs {
>     uint32_t default_tile;
> } ATIVGARegs;
>
> +typedef struct ATIHostDataState {
> +    bool active;
> +    uint32_t row;
> +    uint32_t col;
> +    uint32_t next;
> +    uint32_t acc[ATI_HOST_DATA_FLUSH_WORDS * 2];
> +} ATIHostDataState;
> +
> struct ATIVGAState {
>     PCIDevice dev;
>     VGACommonState vga;
> @@ -112,6 +122,7 @@ struct ATIVGAState {
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
> +    ATIHostDataState host_data;
> };
>
> const char *ati_reg_name(int num);
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 3999edb9b7..48f15e9b1d 100644
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

