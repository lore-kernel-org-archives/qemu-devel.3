Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F0210FCACC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81iD-0000EM-2X; Wed, 01 Apr 2026 15:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w81iA-0000CL-HH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:58:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w81i8-0007hx-47
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:58:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D240A596A1D;
 Wed, 01 Apr 2026 21:58:38 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OItP4PhxMYzN; Wed,  1 Apr 2026 21:58:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB24C596A23; Wed, 01 Apr 2026 21:58:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C96B2596A22;
 Wed, 01 Apr 2026 21:58:36 +0200 (CEST)
Date: Wed, 1 Apr 2026 21:58:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH] hw/display: modernise the vga debug code (!!GenAI!!)
In-Reply-To: <20260330222900.982404-1-alex.bennee@linaro.org>
Message-ID: <6256588b-7b98-f908-160f-2f0f884999b1@eik.bme.hu>
References: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
 <20260330222900.982404-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-170091141-1775073516=:57447"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-170091141-1775073516=:57447
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Mar 2026, Alex Bennée wrote:
> @@ -1660,11 +1604,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>         s->cursor_invalidate(s);
>     }
>
> -#if 0
> -    printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
> -           width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
> -           s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
> -#endif
> +    trace_vga_draw_graphic(width, height, v, s->params.line_offset,
> +                           s->cr[9], s->cr[VGA_CRTC_MODE],
> +                           s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
> +
>     addr1 = (s->params.start_addr * 4);
>     y_start = -1;
>     d = surface_data(surface);

I've found moving this to line 1678 into an else branch of if 
(!full_update) so it's only logged once when parameters change would 
probably be better. I haven't looked at the other logs as I only needed 
this one at this time. The point is that it probably needs more thought 
than automatic conversion so unless somebody wants to do that it's easier 
to leave it as it is or convert them one by one.

Regards,
BALATON Zoltan
--3866299591-170091141-1775073516=:57447--

