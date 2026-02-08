Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12575EF06EA
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 20:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpBFe-0005bo-P8; Sun, 08 Feb 2026 15:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBFd-0005bb-Fq
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:19:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpBFb-000605-D3
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 15:19:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 78FD85969F6;
 Sun, 08 Feb 2026 21:19:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4yCMWYOKu6DX; Sun,  8 Feb 2026 21:19:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 76DBA5969F3; Sun, 08 Feb 2026 21:19:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 754FF5969F1;
 Sun, 08 Feb 2026 21:19:18 +0100 (CET)
Date: Sun, 8 Feb 2026 21:19:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 10/18] ati-vga: Use local variables for register values
 in ati_2d_blt
In-Reply-To: <20260204164606.3425246-11-chad@jablonski.xyz>
Message-ID: <48fe0972-d34e-9a94-ec39-eae8ea30d094@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-11-chad@jablonski.xyz>
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

On Wed, 4 Feb 2026, Chad Jablonski wrote:
> ati_2d_blt uses a mixture of locals and direct register access of needed
> state. This assigns all values derived from register state to local
> variables. It prepares the function for a larger refactor that removes
> the dependency on the full device and direct register access entirely.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 97 ++++++++++++++++++++++++---------------------
> 1 file changed, 52 insertions(+), 45 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index e8b9bf5f70..618aedc3da 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -65,10 +65,20 @@ void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
> -    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> -    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    bool use_pixman_fill = s->use_pixman & BIT(0);
> +    bool use_pixman_blt = s->use_pixman & BIT(1);
> +    int rop3 = s->regs.dp_mix & GMC_ROP3_MASK;

Next patch has uint32_t rop3 but since GMC_ROP3_MASK masks out sign bit 
probably does not matter maybe only for consistency.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

