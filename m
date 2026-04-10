Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCAF45A0B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGf6-0003E6-Lr; Fri, 10 Apr 2026 14:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGf2-0003D6-Uk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGf0-00052D-Ry
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso2356128f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775845972; x=1776450772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9eezskDYP8au4TA0u/saRPDrZUnsxGoUmThaVieUzw=;
 b=HIqJrVb/eErryRweJT+pEdgZWR7pXjecGJf6hnNYKPd463dquLSalrKON0A5r1BaDI
 9wqAGQIuAlQw9MxwISit7oy7Ty1klH/tmdQUZgPz4cJW3ZK0anVn8/1K0WV6r1yHsDcr
 DqYQua3x5xiAV3zvG6YFM/O+v4BglvrLpAXyLkm1yTpWqCAhUvU1X08r8XbY1b5hg6Xy
 AYaIZ/vOIQQ2NvuQkfj9TqDT8cN1gIcmVKiYA37DC85Mlloj2X821bts18K5T0kDy/XZ
 /W6qQTCTWfyPXiM8ScQTW6PK6hEDhMnpEGoaoLV/e258YNOOMD5ngnp+UwZj+chvG1VO
 dV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775845972; x=1776450772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9eezskDYP8au4TA0u/saRPDrZUnsxGoUmThaVieUzw=;
 b=PHIQDB72hbueon3YV1zxMO3p9ZnXvpnWYOdmr+L9PGZHvp4u8wkOAE8PWpBcnVxYfZ
 RqceoqwA3Hgn+hyxbX1gfwCAw9M5sEeXqJ9EtR8W3XmWDmWSSp6ifBMccFmWOq2rGG4d
 jdEeSadlLFxc3jLkhF4vm+iKdk9LG0Z2rqlHIquk0Zw9CaeLlMzyxrXP3UXhO6wPrPf1
 Bd7Y3GAcMg2YKjz0ykEmH0qopQp7/wOdYrS7LrgQmov18IA0QSuwtj82czjqHt3jhx5O
 hqDBHDMqpQIZT+iWw7R3Smg7t8mJSQMaaUjpWujuLa1AOsi+MMieTzgILwFgEFfdCjE0
 4lbA==
X-Gm-Message-State: AOJu0YzcAJ1vTMOw3ztMRsSy6ejGrwXDYGvWmvl4hn/48qroCzuSl6UB
 MGKaoiPDQHNg3F+/vmS2aD4JP1MWSlF+xi1heLhxG+MQlgja+lRwUxCXfLVYJTBeJZjIZevNM8o
 9WG3j84M=
X-Gm-Gg: AeBDiesZSkQnVdH47MK172DbDStno7U2EOCxo8rL17ZskbuJ1FPvylizTocVQmu4CqS
 ppg7gd80M/a5MINxrvySrbtd4hh9PwKLZUJP589W4n2G5xCDdw6v9xyM5cGSQaH7FLYwzw7U9ll
 X4nOVbS5gTnsMKvf3BmX/46UWsnEjJJcf9TqBlBGjmUlaH9NRGBvU/TuYWi9noVigzZ2CRD1lj9
 LhSfg0lx0pLdJUWMs/VxFpDJy1TVVwCNwHXcL+zOLflViE7sGFeu1YhXL5NxctS9L7LkwxAoiTQ
 9w1XiPFSql6HWGbdBBDh0zDFx9Z5mfCtFZ0HzPmUCjEKJ/EscWqdH5U90vAFx4fGbep9xWu/fPw
 j9cAQb5VS4+deLDxXVZTofEczxSrhk9u5A3nWt70cNrar7uU40/HSl6ydkCWRcDftoGkNjrr7O9
 G1mLE/CzkY9QmZYkYNMHzjW3ejFncqCL9dk96cVcIdSu3nQZ4FDKNGUECwgXvCTg4ugorfFjc1E
 zlYgDJAjPjDC/GcuZ+Yic2S5dXZPsw=
X-Received: by 2002:a05:6000:2586:b0:43c:f925:8fc0 with SMTP id
 ffacd0b85a97d-43d642dd84fmr6449431f8f.50.1775845972488; 
 Fri, 10 Apr 2026 11:32:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a85sm9344714f8f.24.2026.04.10.11.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 11:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent copies
Date: Fri, 10 Apr 2026 19:32:49 +0100
Message-ID: <20260410183249.4046456-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410183249.4046456-1-peter.maydell@linaro.org>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 hw/display/cirrus_vga_rop2.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

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
2.43.0


