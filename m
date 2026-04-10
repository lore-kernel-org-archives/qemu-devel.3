Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F1F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGf5-0003De-MS; Fri, 10 Apr 2026 14:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGf2-0003D7-Un
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGf0-000521-QP
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cf73bbfbdso1447416f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775845972; x=1776450772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU2AVvFa5Q7oPg8IgegmSYKlHHXfypWTPcMMS/P4M7M=;
 b=X9BMtu1nLCurOHOTC8wC8QXT4pHz5/6/u4ubtxKPV9YO5LqaI96DuuOv7GV0oQPBHV
 NHr3Rze+/egdHI7uyZXmCbTXE70C3nPaOqTF92cWxklq82lsqd3noZ5/wQmPyvCy53jW
 AHv69x1MTo+Q6g8R+6BHWDAsgx1exgtqYHD6lSHCVbzIXYHERn0M9hl+gTM3SNzHrJ1l
 zJ5pcjEJel7J/g4vfTwGKC2EQvGlWOzOmD/chltMzBK/bjbNBaFkjZCpCID6ckqRiRht
 C6UOkliIrEptRNMGmCs9krUWljz06tVJ4TtiZIdS9TRm42P0tps5TidjiyI0ppudGWRI
 5kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775845972; x=1776450772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SU2AVvFa5Q7oPg8IgegmSYKlHHXfypWTPcMMS/P4M7M=;
 b=duWhoggsCf5MpaSNu0UhF3v0KIqzkTDr6o1bkPLgnU34sIBpALrVZPgJGXSsxi9ELM
 riU0GKz7z04SNlcyxI9h+pod6zHa2Yaz3UItlDUEilU1wvh4VO1BCIWVEBIsZHW8hucs
 Iyx5gfACYS/44KIq337cMhJhcjidBoZbrZ2Q/80UoCP5u7eZcKZ3udPqLhvHOY020TZf
 k9XHbuAE1xjKR8rNCWwxMW0LDz0AaQlUSqqnC4fL1oYDlqLTb0Gc/I5yd5Krpg8nEd7b
 vP7chHQ7aSzuTBR1GRv5oKURfGq/NYQTvlhZq3uc7+FXxR63ynoB9sk6GnPPa0kj0LHL
 kl4g==
X-Gm-Message-State: AOJu0YzBsQqWTHV6iWZSwlTY8Jo0rpVJwx9eewsMZIFqtK4QjRH+XzQI
 KyAb2ZoEPWq+Q+t9umaWeAWHpu1XryQNsXY2zjkL1zCkfn5XtgwoHBZe9vV4b1F441i7jgYZXFF
 wbSH+2tI=
X-Gm-Gg: AeBDievSwcEsmxvN9Gw+ZK8evt3Z+wwW8cyO4loVXQ2BfvynBXFWPuBb7LIwNKNWAiG
 ql1YKApy43FZGVJyf/rvJaQNOgNw+0zT0p8MBFlBzfmNQknTPXDPccRrZEoACJhJkL7ubd0sNjv
 gpoycDMpM+wzKRPV8sQM0o8Xe7ByBZeOBVQMpIE3kpomhVwCOCxSciP1fq82zV/ZqZWPRajtWtm
 dybr8KaVzj8SaMKio5RPdlQUjrd9b9a2WmVHd1QUqFgovbvOO+Rb3iWVpQ0V1COzsrLKRVhOTUi
 9X35VIx1SFC1TVFs48ce/DN5P1QukqWfg/VAE8Y5Jj7NQdshrCm3v4QuW1/aYws3HoF6xZOdRrN
 HqZe+TkQckTjY1uy8mkR+ayQ80JLNmqsxsaFT/Dg16e0iuLFpyiHq6ATn+8KkgQaG9M8sHgQLFQ
 MN6WzDVDf7k+H8FthIFnAc3oWuAo7T8jzaYZ38hgDRTFatHMmZw32+Z/0NFYrsv7q3dFi7tE5Dc
 yux0LUZzu15URhgeJKYM6VcI0+T+Geu/9gXw9C1OA==
X-Received: by 2002:a05:6000:24c2:b0:43b:8f30:39bb with SMTP id
 ffacd0b85a97d-43d642ab9a7mr6288988f8f.24.1775845971658; 
 Fri, 10 Apr 2026 11:32:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a85sm9344714f8f.24.2026.04.10.11.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 11:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent pattern fills
Date: Fri, 10 Apr 2026 19:32:48 +0100
Message-ID: <20260410183249.4046456-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410183249.4046456-1-peter.maydell@linaro.org>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
---
 hw/display/cirrus_vga_rop2.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

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
2.43.0


