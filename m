Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D73CEEEC1C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbRcM-0003I7-DN; Thu, 01 Jan 2026 17:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRcJ-0003HY-LI
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:58:03 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRcG-000833-Dh
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:58:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA8EA596A03;
 Thu, 01 Jan 2026 23:57:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id t0zAz95gS-CL; Thu,  1 Jan 2026 23:57:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EA60B5969FF; Thu, 01 Jan 2026 23:57:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8AF85969F6;
 Thu, 01 Jan 2026 23:57:53 +0100 (CET)
Date: Thu, 1 Jan 2026 23:57:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 11/11] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <20251118154812.57861-12-chad@jablonski.xyz>
Message-ID: <52c0918b-dd96-2a47-5221-2bd34eeaa7f7@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-12-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
> text rendering in X. Currently supports only the monochrome
> foreground/background datatype with the SRCCOPY ROP.
>
> The flush is broken up into two steps for clarity. First, expansion of the
> monochrome bits to the destination color depth. Then the expanded pixels
> are clipped and copied into VRAM.

I've tested it with MorphOS and TVPaint but it does not seem to work for 
that driver. It never writes HOST_DATA_LAST, only 0 or 0 1 or sometimes 
0-7 but never LAST so it must rely on results being flushed after enough 
writes. I got some traces like these below in case you can guess what 
might be needed for it.

ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_read 4 0x16c4 DP_DATATYPE -> 0x30d06
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x6
ati_mm_write 4 0x16c8 DP_MIX <- 0xcc0300
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x18103cb
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x18903d2
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x18103cb
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x18903d2
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x15d8 DP_SRC_FRGD_CLR <- 0xff000000
ati_mm_write 4 0x15dc DP_SRC_BKGD_CLR <- 0xffececec
ati_mm_write 4 0x1438 DST_Y_X <- 0x18103cb
ati_mm_write 4 0x1434 SRC_Y_X <- 0x0
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0x200008
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: cc
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (971,385) 32x8 > v
ati_2d_blt: pixman_blt(0x7f71a1b09000, 0x7f71a1200000, 640, 2048, 32, 32, 0, 0, 971, 385, 8, 8)
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xce007c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x38de00ce
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xf638de
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xe600f6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc600e6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x187c00c6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c00187c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c00
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_write 4 0x16c8 DP_MIX <- 0xf00200
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x147c DP_BRUSH_FRGD_CLR <- 0xffffffff
ati_mm_write 4 0x1438 DST_Y_X <- 0x17e03c7
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0x1000f
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: f0
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (967,382) 1x15 > v
ati_2d_blt: pixman_fill(0x7f71a1200000, 2048, 32, 967, 382, 1, 15, ffffffff)

[...]

ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_read 4 0x16c4 DP_DATATYPE -> 0x30d06
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x10006
ati_mm_write 4 0x16c8 DP_MIX <- 0xcc0300
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x10203d2
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x10a0429
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x10203d2
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x10a0429
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x15d8 DP_SRC_FRGD_CLR <- 0xff000000
ati_mm_write 4 0x15dc DP_SRC_BKGD_CLR <- 0xfff3f3f3
ati_mm_write 4 0x1438 DST_Y_X <- 0x10203d2
ati_mm_write 4 0x1434 SRC_Y_X <- 0x0
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0x600008
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: cc
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (978,258) 96x8 > v
ati_2d_blt: pixman_blt(0x7f71a1b09000, 0x7f71a1200000, 640, 2048, 32, 32, 0, 0, 978, 258, 88, 8)
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0x0
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x600
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc6
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0x0
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x600
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7cfc7cc0
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xec00fc7c
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc67c7e7c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc6c6c67c
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xfe00c6c6
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc6c6c6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xfec0c006
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xd600c6fe
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xfec6c6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc0c0c6c6
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc600c6c0
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc0c6c6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7cc07c7c
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc600c67c
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc67c7e7c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x0
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0x0
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x7c000000
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_write 4 0x16c8 DP_MIX <- 0xf00200
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x147c DP_BRUSH_FRGD_CLR <- 0xfff3f3f3
ati_mm_write 4 0x1438 DST_Y_X <- 0x111037d
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0xf10050
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: f0
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (893,273) 241x80 > v
ati_2d_blt: pixman_fill(0x7f71a1200000, 2048, 32, 893, 273, 241, 80, fff3f3f3)
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_write 4 0x16c8 DP_MIX <- 0xf00200
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x147c DP_BRUSH_FRGD_CLR <- 0xff1670e0
ati_mm_write 4 0x1438 DST_Y_X <- 0x111037d
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0xf10008
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: f0
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (893,273) 241x8 > v
ati_2d_blt: pixman_fill(0x7f71a1200000, 2048, 32, 893, 273, 241, 8, ff1670e0)
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_read 4 0x16c4 DP_DATATYPE -> 0x30d06
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x10006
ati_mm_write 4 0x16c8 DP_MIX <- 0xcc0300
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x111037d
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x1190464
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x111037d
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x1190464
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x15d8 DP_SRC_FRGD_CLR <- 0xff000000
ati_mm_write 4 0x15dc DP_SRC_BKGD_CLR <- 0xfff3f3f3
ati_mm_write 4 0x1438 DST_Y_X <- 0x111037d
ati_mm_write 4 0x1434 SRC_Y_X <- 0x0
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0x1000008
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: cc
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (893,273) 256x8 > v
ati_2d_blt: pixman_blt(0x7f71a1b09000, 0x7f71a1200000, 640, 2048, 32, 32, 0, 0, 893, 273, 232, 8)
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xfc
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xfc7c7c18
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x0
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x18fcfe18
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0x7c000060
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0x7c1c
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0x7c1c0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0xc6fc7c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc6
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc6c6c678
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x180000
ati_mm_write 4 0x17cc HOST_DATA3 <- 0xc6c078
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0xc6000060
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0xce3c
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0xc63c0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x7cc600ce
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c7e7cc6
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc6c60618
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x187cfc
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x38c6fc18
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0xc00000f8
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0xc600de6c
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0xc66c0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x6fc00de
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc6c606fc
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xfc7c7c18
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc6c6
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x18fc0618
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0xfc000060
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0x6c00f6cc
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0x7ccc0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x7ed800f6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xfec67ed8
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc0c6c018
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0xc6c0
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x18c60618
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0xc6000060
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0x3800e6fe
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0xc6fe0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0xc6cc00e6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0xc07ec6cc
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc0c6c018
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x18c6c0
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x18c6c618
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0xc6000066
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0x6c00c60c
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0xc60c0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x7ec600c6
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c067ec6
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0xc07cfe18
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x187cc0
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x18fc7c18
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0x7c00003c
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0xc6007c0c
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0x7c0c0000
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x7c
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x17c0 HOST_DATA0 <- 0x7c0000
ati_mm_write 4 0x17c4 HOST_DATA1 <- 0x0
ati_mm_write 4 0x17c8 HOST_DATA2 <- 0x0
ati_mm_write 4 0x17cc HOST_DATA3 <- 0x0
ati_mm_write 4 0x17d0 HOST_DATA4 <- 0x0
ati_mm_write 4 0x17d4 HOST_DATA5 <- 0x0
ati_mm_write 4 0x17d8 HOST_DATA6 <- 0x0
ati_mm_write 4 0x17dc HOST_DATA7 <- 0x0
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16e8 DEFAULT_SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16ec SC_TOP_LEFT <- 0x0
ati_mm_write 4 0x16f0 SC_BOTTOM_RIGHT <- 0x1fff1fff
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_read 4 0x1740 GUI_STAT -> 0x40
ati_mm_write 4 0x1404 DST_OFFSET <- 0x0
ati_mm_write 4 0x1408 DST_PITCH <- 0x100
ati_mm_write 4 0x16c8 DP_MIX <- 0xf00200
ati_mm_write 4 0x16c4 DP_DATATYPE <- 0x30d06
ati_mm_write 4 0x16c0 DP_CNTL <- 0x3
ati_mm_write 4 0x147c DP_BRUSH_FRGD_CLR <- 0xfff3f3f3
ati_mm_write 4 0x1438 DST_Y_X <- 0x119037d
ati_mm_write 4 0x1598 DST_WIDTH_HEIGHT <- 0xf10008
ati_2d_blt: 0x7f71a1200000 0 ds: 0x7f71a1200000 8192 32 rop: f0
ati_2d_blt: 9474048 0 0, 80 256 256, (0,0) -> (893,281) 241x8 > v
ati_2d_blt: pixman_fill(0x7f71a1200000, 2048, 32, 893, 281, 241, 8, fff3f3f3)

