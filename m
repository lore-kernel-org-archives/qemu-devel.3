Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27755CF6BE1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 00:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdHSw-00006k-6z; Tue, 06 Jan 2026 19:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHSv-00006T-4O
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:31:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHSt-0006CN-Ka
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:31:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A79F1596A0A;
 Wed, 07 Jan 2026 01:31:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 47BT1fOEukkC; Wed,  7 Jan 2026 01:31:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A85205969FD; Wed, 07 Jan 2026 01:31:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A6D595969F6;
 Wed, 07 Jan 2026 01:31:51 +0100 (CET)
Date: Wed, 7 Jan 2026 01:31:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <20260106185700.2102742-9-chad@jablonski.xyz>
Message-ID: <0694659c-9825-6acd-53b2-a930177e47ce@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-9-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
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
> hw/display/ati.c      | 32 ++++++++++++++++++++++++++++++++
> hw/display/ati_dbg.c  |  9 +++++++++
> hw/display/ati_int.h  |  9 +++++++++
> hw/display/ati_regs.h |  9 +++++++++
> 4 files changed, 59 insertions(+)
>
[...]
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index d9ac8ee135..3029dc7e3c 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -14,6 +14,7 @@
> #include "hw/i2c/bitbang_i2c.h"
> #include "vga_int.h"
> #include "qom/object.h"
> +#include "qemu/units.h"

This include seems to be unneeded.

Regards,
BALATON Zoltan

> /*#define DEBUG_ATI*/
>
> @@ -97,6 +98,13 @@ typedef struct ATIVGARegs {
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
> @@ -113,6 +121,7 @@ struct ATIVGAState {
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
> +    ATIHostDataState host_data;
> };
>
> const char *ati_reg_name(int num);
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 9c638314f0..c8bbafe1c6 100644
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

