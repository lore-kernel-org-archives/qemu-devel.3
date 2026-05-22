Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CC6CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXT-0001i9-Kv; Fri, 22 May 2026 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVn-0008Ax-IG; Fri, 22 May 2026 17:34:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXVj-0007bl-LK; Fri, 22 May 2026 17:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485632; bh=nSbJccUXo9jKpv2H2W8hWaOn1ytKiY+C0ZzYGiaskuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RsG09TQe67nmSeBAr8AOYPzYMQgUj76C8MtKHuyptoKQ79Yl2ZEsAz9VLHbqPqZmF
 MC7Jtq7paw7lyHfiF6XiVo7umfqOX2AF3rK7kjEx8K3pe9cSDijbbEtZldFSJC4tdP
 RhszTNrg86yRk8t/EgDCRhDQ/5mpabPXbQbvcm/WTsTbsv2H72jEbZU5XRNnnGz9yV
 3+pwJo4PpH5VnxgjBj5tuQuMDV426LoEO6zP8AxGyQnoV9XS3Nu7NClfJ069CPeAqx
 ohFLBGk5aa/6p5AfX8CQIiM8Maqyxvtsc3yze2eSm06yyYaXdzfjHbY7LRExpl4Vcg
 JEvGWZZfpuTeg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C127A1AFAD1;
 Sat, 23 May 2026 00:33:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E28023B7157;
 Sat, 23 May 2026 00:33:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 66/94] hw/display/cirrus_vga: Fix packed-24
 color-expansion transparent copies
Date: Sat, 23 May 2026 00:33:23 +0300
Message-ID: <20260522213356.806058-8-mjt@tls.msk.ru>
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

For the "color expansion" subtype of raster operations, the source
pixel format is a monochrome bitmap, and the destination can be any
of 8, 16, 24 or 32bpp.

For these pattern operations, the GR2F register includes a field
which specifies how much to skip at the start of each scanline.  In
the 8, 16 and 32 bit cases, this field is 3 bits and is a count of
pixels to skip.  We get this case right.  However, for the 24 bit
case, the field is 5 bits and is a count of destination bytes to
skip.

In commit ad81218e40e27 ("depth=24 write mask fix (Volker Ruppert)")
in 2005, we updated the code to (attempt to) handle the 5-bit mask
case.  However, we don't do the right thing when the 5-bit mask
indicates that we need to skip more than 8 bits of the input bitmap:
we will right-shift the 0x80 constant completely off the right hand
side, and will be off-by-one for all the source bitmap loads.

Fix this by calculating the whole number of input bytes we need to
skip and the residual number of bits.  In the 8/16/32bpp case the
bytes to skip is always zero.

Cc: qemu-stable@nongnu.org
Fixes: ad81218e40e27 ("depth=24 write mask fix (Volker Ruppert)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <20260410183249.4046456-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 27d14251b904e6dd60c1053a893b52e085f48a3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index 8be35ec6e2..33f9b3b613 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -108,12 +108,34 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
     unsigned int col;
     unsigned bitmask;
     unsigned index;
+
+    /*
+     * Raster ops where the source is a monochrome bitmap with
+     * color expansion to 8/16/24/32bpp destination.
+     */
+
 #if DEPTH == 24
+    /*
+     * For packed-24 modes, GR2F bits [4:0] are a count of destination
+     * bytes to be suppressed for each scanline, which we keep in
+     * dstskipleft. We want to track the number of whole bytes
+     * to skip in the source (always either 0 or 1) and the number
+     * of bits within the byte to skip.
+     */
     int dstskipleft = s->vga.gr[0x2f] & 0x1f;
-    int srcskipleft = dstskipleft / 3;
+    int srcskipleftbits = (dstskipleft / 3) & 0x7;
+    int srcskipleftbytes = (dstskipleft / 3) >> 3;
 #else
-    int srcskipleft = s->vga.gr[0x2f] & 0x07;
-    int dstskipleft = srcskipleft * (DEPTH / 8);
+    /*
+     * In all other modes, GR2F bits [2:0] are a count of how many
+     * destination pixels to suppress for each scanline, which is our
+     * srcskipleftbits. We get dstskipleft, the number of bytes to
+     * skip, by multiplying this by the bytes-per-pixel. In these
+     * modes we never need to skip an entire source byte.
+     */
+    int srcskipleftbits = s->vga.gr[0x2f] & 0x07;
+    int srcskipleftbytes = 0;
+    int dstskipleft = srcskipleftbits * (DEPTH / 8);
 #endif
 
     if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
@@ -125,7 +147,8 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
     }
 
     for(y = 0; y < bltheight; y++) {
-        bitmask = 0x80 >> srcskipleft;
+        bitmask = 0x80 >> srcskipleftbits;
+        srcaddr += srcskipleftbytes;
         bits = cirrus_src(s, srcaddr++) ^ bits_xor;
         addr = dstaddr + dstskipleft;
         for (x = dstskipleft; x < bltwidth; x += (DEPTH / 8)) {
-- 
2.47.3


