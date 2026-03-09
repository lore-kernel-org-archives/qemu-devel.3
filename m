Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EE0FCA192
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziLz-00080k-56; Mon, 09 Mar 2026 17:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vziLx-00080U-9L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:41:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vziLu-00010X-UR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:41:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D9E1D5969E7;
 Mon, 09 Mar 2026 22:41:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kHQIO21vaHdD; Mon,  9 Mar 2026 22:41:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD5E15969E6; Mon, 09 Mar 2026 22:41:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DB90A5966F4;
 Mon, 09 Mar 2026 22:41:22 +0100 (CET)
Date: Mon, 9 Mar 2026 22:41:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
In-Reply-To: <20260309212206.2457691-1-chad@jablonski.xyz>
Message-ID: <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, 9 Mar 2026, Chad Jablonski wrote:
> Cast default_sc_bottom to uint32_t before shifting left to prevent
> sign extension when assigning to uint64_t.
>
> Fixes: CID 1645615
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 6cf243bcf9..f9773e1154 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val |= s->regs.default_tile << 16;
>         break;
>     case DEFAULT_SC_BOTTOM_RIGHT:
> -        val = (s->regs.default_sc_bottom << 16) |
> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>               s->regs.default_sc_right;
>         break;
>     case SC_TOP:

I think this is not needed. This is likely a false positive from Coverity 
because the valid bits for sc regs are bits 13:0 which we enforce on write 
so you should not get sign extension here. We typically don't do such 
fixes for these but mark them in Coverity but cc'd Peter Maydell who knows 
this better.

Regards,
BALATON Zoltan

