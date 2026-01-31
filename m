Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5A9D79769
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 10:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm86A-0007Li-Nt; Sat, 31 Jan 2026 05:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm869-0007LF-9y
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:21:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vm867-0000tG-Cp
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 05:21:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C0142596A0A;
 Sat, 31 Jan 2026 11:20:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Sj8oUNVdiGhS; Sat, 31 Jan 2026 11:20:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA9965969FD; Sat, 31 Jan 2026 11:20:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8F585969F2;
 Sat, 31 Jan 2026 11:20:54 +0100 (CET)
Date: Sat, 31 Jan 2026 11:20:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 07/20] ati-vga: Remove dst_x/y updates after blit
In-Reply-To: <20260130145005.731129-8-chad@jablonski.xyz>
Message-ID: <00ab0025-db8f-aacb-1b52-524fbec01f3c@eik.bme.hu>
References: <20260130145005.731129-1-chad@jablonski.xyz>
 <20260130145005.731129-8-chad@jablonski.xyz>
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
> The Mobility M6 register reference (DST_HEIGHT_WIDTH) states that dst_y is
> updated after a blit but this appears to not be the case.
>
> Hardware testing revealed that both the R128 and R100 do not update
> dst_x or dst_y after a blit, regardless of the source. This removes
> the update.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati_2d.c | 6 ------
> 1 file changed, 6 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index a8c4c534b9..cfc7bf9789 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -174,10 +174,6 @@ void ati_2d_blt(ATIVGAState *s)
>                                     dst_y * surface_stride(ds),
>                                     s->regs.dst_height * surface_stride(ds));
>         }
> -        s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                         dst_x + s->regs.dst_width : dst_x);
> -        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
>         break;
>     }
>     case ROP3_PATCOPY:
> @@ -228,8 +224,6 @@ void ati_2d_blt(ATIVGAState *s)
>                                     dst_y * surface_stride(ds),
>                                     s->regs.dst_height * surface_stride(ds));
>         }
> -        s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                         dst_y + s->regs.dst_height : dst_y);
>         break;
>     }
>     default:
>

