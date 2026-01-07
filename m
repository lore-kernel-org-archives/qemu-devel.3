Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C9CF6BE9
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdL13-0006jd-4E; Tue, 06 Jan 2026 23:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdL11-0006j4-Cz
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:19:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdL0z-0007P3-QM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:19:23 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B79A0596A0A;
 Wed, 07 Jan 2026 05:19:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rLsqVngGMbyS; Wed,  7 Jan 2026 05:19:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AAE2C5969FD; Wed, 07 Jan 2026 05:19:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A348E5969F6;
 Wed, 07 Jan 2026 05:19:18 +0100 (CET)
Date: Wed, 7 Jan 2026 05:19:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/9] ati-vga: Store DP_DATATYPE and DP_MIX fields
 independently
In-Reply-To: <20260106185700.2102742-2-chad@jablonski.xyz>
Message-ID: <e42c1494-118f-f608-d9a5-2b1d72977c6f@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-2-chad@jablonski.xyz>
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
> DP_GUI_MASTER_CNTL accesses the same values as DP_DATATYPE and DP_MIX.
> This was not reflected in how we stored register state. This meant that
> you could easily end up with stale state in one or the other register.
>
> This stores each field directly instead of packing them into a field
> named after the register. The register handlers then shift bits around
> if needed. This not only keeps things in sync but means less shifting
> and masking when using these values internally.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 41 +++++++++++++++++++++++++++++++++--------
> hw/display/ati_2d.c   | 12 ++++++------
> hw/display/ati_int.h  | 10 ++++++++--
> hw/display/ati_regs.h | 33 +++++++++++++++++++++++++++++----
> 4 files changed, 76 insertions(+), 20 deletions(-)
[...]
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..fce9270635 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -381,6 +381,12 @@
> #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
>
> /* DP_DATATYPE bit constants */
> +#define DP_DATATYPE_DST_DATATYPE_MASK           0x0000000f
> +#define DP_DATATYPE_BRUSH_DATATYPE_MASK         0x00000f00
> +#define DP_DATATYPE_SRC_DATATYPE_MASK           0x00030000
> +#define DP_DATATYPE_HOST_BE_EN                  0x20000000
> +#define DP_DATATYPE_BYTE_PIX_ORDER              0x40000000
> +#define DP_DATATYPE_CONVERSION_TEMP             0x80000000
> #define DST_8BPP                                0x00000002
> #define DST_15BPP                               0x00000003
> #define DST_16BPP                               0x00000004
> @@ -394,6 +400,11 @@
> #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
> #define GMC_SRC_CLIP_DEFAULT                    0x00000000
> #define GMC_DST_CLIP_DEFAULT                    0x00000000
> +#define GMC_BRUSH_DATATYPE_MASK                 0x000000f0
> +#define GMC_DST_DATATYPE_MASK                   0x00000f00
> +#define GMC_SRC_DATATYPE_MASK                   0x00003000

This will probably be gone in next version but for naming I'd stick to the 
docs and use the names that it calls the fields as so no need to add _MASK 
as these names seem to be meant for the field so we can name the mask that 
extract that field like that so would just be GMC_SRC_DATATYPE and so on.

Regards,
BALATON Zoltan

> +#define GMC_BYTE_PIX_ORDER                      0x00004000
> +#define GMC_CONVERSION_TEMP                     0x00008000
> #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
> #define GMC_SRC_DSTCOLOR                        0x00003000
> #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
> @@ -404,12 +415,24 @@
> #define GMC_WRITE_MASK_SET                      0x40000000
> #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
>
> +/* DP_GUI_MASTER_CNTL DP_SRC_DATATYPE named constants */
> +#define GMC_SRC_DATATYPE_MASK                   0x00003000
> +#define GMC_SRC_DATATYPE_MONO_FRGD_BKGD         0
> +#define GMC_SRC_DATATYPE_MONO_FRGD              1
> +#define GMC_SRC_DATATYPE_COLOR                  3
> +
> +/* DP_GUI_MASTER_CNTL DP_SRC_SOURCE named constants */
> +#define GMC_SRC_SOURCE_MASK                     0x07000000
> +#define GMC_SRC_SOURCE_MEMORY                   2
> +#define GMC_SRC_SOURCE_HOST_DATA                3
> +#define GMC_SRC_SOURCE_HOST_DATA_ALIGNED        4
> +
> /* DP_GUI_MASTER_CNTL ROP3 named constants */
> #define GMC_ROP3_MASK                           0x00ff0000
> -#define ROP3_BLACKNESS                          0x00000000
> -#define ROP3_SRCCOPY                            0x00cc0000
> -#define ROP3_PATCOPY                            0x00f00000
> -#define ROP3_WHITENESS                          0x00ff0000
> +#define ROP3_BLACKNESS                          0
> +#define ROP3_SRCCOPY                            0xcc
> +#define ROP3_PATCOPY                            0xf0
> +#define ROP3_WHITENESS                          0xff
>
> #define SRC_DSTCOLOR                            0x00030000
>
> @@ -434,6 +457,8 @@
> #define DST_POLY_EDGE                           0x00040000
>
> /* DP_MIX bit constants */
> +#define DP_MIX_SRC_SOURCE_MASK                  0x00000700
> +#define DP_MIX_ROP3_MASK                        0x00ff0000
> #define DP_SRC_RECT                             0x00000200
> #define DP_SRC_HOST                             0x00000300
> #define DP_SRC_HOST_BYTEALIGN                   0x00000400
>

