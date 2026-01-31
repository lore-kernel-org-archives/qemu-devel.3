Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB4D7976A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm81m-0003Rn-3o; Sat, 31 Jan 2026 05:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm81f-0003GH-Gy
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:16:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm81e-0000QF-1F
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:16:23 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DBBE5596A3F;
 Sat, 31 Jan 2026 11:16:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZKHwRblgOxZV; Sat, 31 Jan 2026 11:16:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D77BC596A0A; Sat, 31 Jan 2026 11:16:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D5FC25969FD;
 Sat, 31 Jan 2026 11:16:18 +0100 (CET)
Date: Sat, 31 Jan 2026 11:16:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 03/20] ati-vga: Read aliased values from
 DP_GUI_MASTER_CNTL
In-Reply-To: <20260130145005.731129-4-chad@jablonski.xyz>
Message-ID: <50df306a-f796-6c56-c5aa-8bebfc0f242f@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-4-chad@jablonski.xyz>
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

On Fri, 30 Jan 2026, Chad Jablonski wrote:
> DP_GUI_MASTER_CNTL aliases several fields from DP_DATATYPE and DP_MIX.
> These were being written correctly but not returned on a read of
> DP_GUI_MASTER_CNTL.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c      | 8 +++++++-
> hw/display/ati_regs.h | 5 +++++
> 2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 777a6b0a2e..028efd13e1 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -460,7 +460,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val = s->regs.dst_y;
>         break;
>     case DP_GUI_MASTER_CNTL:
> -        val = s->regs.dp_gui_master_cntl;
> +        /* DP_GUI_MASTER_CNTL aliases fields from DP_MIX and DP_DATATYPE */
> +        val = s->regs.dp_gui_master_cntl |
> +              ((s->regs.dp_datatype & DP_BRUSH_DATATYPE) >> 4) |
> +              ((s->regs.dp_datatype & DP_DST_DATATYPE) << 8) |
> +              ((s->regs.dp_datatype & DP_SRC_DATATYPE) >> 4) |
> +              (s->regs.dp_mix & DP_ROP3) |
> +              ((s->regs.dp_mix & DP_SRC_SOURCE) << 16);
>         break;
>     case SRC_OFFSET:
>         val = s->regs.src_offset;
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..0a0825db04 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -386,6 +386,9 @@
> #define DST_16BPP                               0x00000004
> #define DST_24BPP                               0x00000005
> #define DST_32BPP                               0x00000006
> +#define DP_DST_DATATYPE                         0x0000000f
> +#define DP_BRUSH_DATATYPE                       0x00000f00
> +#define DP_SRC_DATATYPE                         0x00030000
>
> #define BRUSH_SOLIDCOLOR                        0x00000d00
>
> @@ -437,6 +440,8 @@
> #define DP_SRC_RECT                             0x00000200
> #define DP_SRC_HOST                             0x00000300
> #define DP_SRC_HOST_BYTEALIGN                   0x00000400
> +#define DP_SRC_SOURCE                           0x00000700
> +#define DP_ROP3                                 0x00ff0000
>
> /* LVDS_GEN_CNTL constants */
> #define LVDS_BL_MOD_LEVEL_MASK                  0x0000ff00
>

