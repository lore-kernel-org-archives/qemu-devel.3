Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C1ACCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuhD-0003Nq-VX; Mon, 03 Nov 2025 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFuh6-0003NP-Hx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:34:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFugz-0003tR-7N
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:33:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E377E5972E8;
 Mon, 03 Nov 2025 14:33:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id u_p2S-1aR1lm; Mon,  3 Nov 2025 14:33:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CF3725972E4; Mon, 03 Nov 2025 14:33:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE0BB5972E2;
 Mon, 03 Nov 2025 14:33:47 +0100 (CET)
Date: Mon, 3 Nov 2025 14:33:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/7] ati-vga: Implement foreground and background
 color register writes
In-Reply-To: <20251103033608.120908-4-chad@jablonski.xyz>
Message-ID: <c37e9ad2-24a4-e16e-83e4-805d400d50f8@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-4-chad@jablonski.xyz>
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
> These are straightforward 32-bit register write handlers. They're
> necessary for a future patch which will use them for color expansion
> from monochrome host data transfers.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index eb9b30672f..bf7a037e64 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -926,6 +926,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DP_CNTL:
>         s->regs.dp_cntl = data;
>         break;
> +    case DP_SRC_FRGD_CLR:
> +        s->regs.dp_src_frgd_clr = data;
> +        break;
> +    case DP_SRC_BKGD_CLR:
> +        s->regs.dp_src_bkgd_clr = data;
> +        break;
>     case DP_DATATYPE:
>         s->regs.dp_datatype = data & 0xe0070f0f;
>         break;
>

