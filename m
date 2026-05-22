Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E467CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXM-0000xO-NW; Fri, 22 May 2026 17:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVj-0008AH-QP; Fri, 22 May 2026 17:34:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVg-0007aZ-QO; Fri, 22 May 2026 17:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485632; bh=CLg/NbHjbYspAMq0P5vc2TeituRBmfACUveDQ2y4HgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a+nn50sH13Edk9qi+HbkNNQYyjvUH6Z5jTJRiiC7QSSO/0vL+jCJeSbL+JdR/QVg7
 iSgQ7OHXZI1yPELxSE9LmqGUS7xTfuz5zTzUohNRrQNXQAq0SVqZX6lwLd3oEHUZGl
 MSstgJXX48jrO+6WZR89P5U3xnH3y4Fy+ioeA2ta42G0QUc6F55vgA8MnsPSyrt5eD
 m0IAOyfEbDgaIlBhWVSdwHf3e49n2JOVTt48EAhMwBNuFRB0VqNXxkQXujA2p/AQnk
 siEP/kvDBKJLwRezGVPSZrObcj8xmh7RmhMAUZEgMrhGVSvCd0JOcWBoSq6lTPIOo3
 866LSuMIj6GYw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B041F1AFAD0;
 Sat, 23 May 2026 00:33:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D0D253B7156;
 Sat, 23 May 2026 00:33:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 65/94] hw/display/cirrus_vga: Fix packed-24
 color-expansion transparent pattern fills
Date: Sat, 23 May 2026 00:33:22 +0300
Message-ID: <20260522213356.806058-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The Cirrus Logic VGA card has "pattern fill" blit modes where it
repeatedly copies an 8x8 source pattern to the display.  For the
"color expansion" subtype of these, the source pixel format is an 8x8
monochrome bitmap, and the destination can be any of 8, 16, 24 or
32bpp.  We implemented these wrong for the 24bpp case, in a way that
results in a complaint from the undefined-behavior sanitizer about a
shift by a negative value.

For these pattern fills, the GR2F register includes a field which
specifies how much to skip at the start of each scanline.  In the 8,
16 and 32 bit cases, this field is 3 bits and is a count of pixels to
skip.  We get this case right.  However, for the 24 bit case, the
field is 5 bits and is a count of destination bytes to skip.  We
tried to add support for 24-bits in commit ad81218e40e27 ("depth=24
write mask fix (Volker Ruppert)") in 2005.  However we got this
wrong, because when we need to skip, for example, 30 bytes in the
destination, this is 10 input pixels but the whole pattern is only 8
pixels wide, and we ended up with a negative bitpos for the first bit
to use in the pattern.

Fix the bug by masking srcskipleft in the 24-bit case so that it
correctly gives the first pixel to use in the pattern even if we skip
so many pixels that we have wrapped around to what would have been
the second copy of the pattern to the destination.

This patch was produced based on the information in the CL-GD5446
Technical Reference Manual, specifically sections 5.8 "GR2F: BLT
Destination Left-Side Clipping" and 9.4.8 "Pattern Fills".

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3377
Fixes: ad81218e40e27 ("depth=24 write mask fix (Volker Ruppert)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <20260410183249.4046456-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit aefeecb413a8e404ecb6d210cc32d60da176a336)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index b208b7348a..8be35ec6e2 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -191,10 +191,29 @@ glue(glue(glue(cirrus_colorexpand_pattern_transp_, ROP_NAME), _),DEPTH)
     int x, y, bitpos, pattern_y;
     unsigned int bits, bits_xor;
     unsigned int col;
+
+    /*
+     * Copy from an 8x8 monochrome pattern with color expansion.
+     */
+
 #if DEPTH == 24
+    /*
+     * For packed-24 modes, GR2F bits [4:0] are a count of destination
+     * bytes to be suppressed for each scanline, which we keep in
+     * dstskipleft. Our srcskipleft is the number of pixels to skip
+     * within the 8x8 source pattern to match up with that number
+     * of suppressed bytes. As the pattern repeats every 8 bits we
+     * take the number of pixels mod 8.
+     */
     int dstskipleft = s->vga.gr[0x2f] & 0x1f;
-    int srcskipleft = dstskipleft / 3;
+    int srcskipleft = (dstskipleft / 3) & 0x7;
 #else
+    /*
+     * In all other modes, GR2F bits [2:0] are a count of how many
+     * destination pixels to suppress for each scanline, which is our
+     * srcskipleft. We get dstskipleft, the number of bytes to skip,
+     * by multiplying this by the bytes-per-pixel.
+     */
     int srcskipleft = s->vga.gr[0x2f] & 0x07;
     int dstskipleft = srcskipleft * (DEPTH / 8);
 #endif
-- 
2.47.3


