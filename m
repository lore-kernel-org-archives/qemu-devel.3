Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469A6CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVK-0000cW-Bj; Tue, 12 May 2026 02:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVC-0000bL-CF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgV9-0003ov-Ml
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:21:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so2804155f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566912; x=1779171712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CzFrN52xeD/rKozWspEAMehNfHxgV2xjJ/hvz+/wxcg=;
 b=QTo0X7ppc1AfXfj4wESNqXglwnBa6l0UgNK/XLu6IHgpDbgUjvDJjXIxZ/wQ64LXUH
 nyta0guKX8iUDzSFmMoDDnq43LMMYGzDA+C5h70y/gW/HjUkB5dEjVeGCa4MTdKR/yZE
 2dLJPoAtRwYOP7Ak3XruMWn6txBcO4SCg1s8D7/8MU5C/GY2+t3Pz/yduOM0hOqcJxN1
 MV0zSnIeR1Xu2kSDELo8SMwnZciLLjvnEs40BfX6OBvA2Qx4p7Bg0oubKAAyLMFmYKLo
 ViFPP6MgB8jVvLptgh+P0dWm9Zpfa+rPhYtN/PkCB7wCHHfi2gs50gSQMZV2Ty+tW+q0
 /SlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566912; x=1779171712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CzFrN52xeD/rKozWspEAMehNfHxgV2xjJ/hvz+/wxcg=;
 b=ohEpppT3ekXrgo1VeCRV0mW+HDF2RZjVsdP6jkdEv45LifqC9QfVbw55QZA3JC+Sfs
 +qzpGKeLudk1OtfUnek229ikT8CuVTlLOGAPIHQYerGtSXfBDNeQzYN0tGYGC4uiQ+r4
 UN7lP/JHe3yQt3FvSjYrt5LlfA0AcczYBfXxIz/U3CYn7V+bGtyKpGDrSeieBhanVv2R
 tjaCFHV7rC9YiGk901eVovN1aSUhm3vxVhMWA9V836gVoxqRA3HoZV/+C4ll1lvRAntl
 Qd2NRyOMhlCsL0weN/XYP6j1LjGHHNSsAY0EDt44ELCIBT/B10XXzW55kui3HAmziinB
 20wg==
X-Gm-Message-State: AOJu0YwzoVLrqsc8wdp1k5876yoGclrt+YKh4rvbknij72xs/mnviRzA
 3C2m/N39IN1kmzVQj/aqJ64o6oGoFo0mVN//2w9+9hUs3cq1eDj9i0HgWykBaF+9VeR3EqTbTN3
 N6rfogp8=
X-Gm-Gg: Acq92OEd7eQFL3s3jkrS5spxCdRKMOoAEe2Z2CTSUWhgqyqTbgsptEvYyJwwkb9GtoL
 lqdf3Dcr+bNjcs4jL4kMiUKYuq7Ry17N1d5A+TEiaKYvQ5C7tmJy+88FQ/vyBI0OKh44+EqdsHL
 75E2hBM8x5klFnNgu5VL4KFWxDMu3mcLUZPN3QquEPlRihB4d4evj5HWsUrwzSgOKJvN42mnEnI
 LF3OfBRxXL7yGVGh6PgstBtly3tk/kE3zQT07KINQZpHsmBjTsXxqDWdizPBQEnf14LEgeZ6mqW
 5c3KiIURMyaQkI2H1LXD18wHkLLebIcqzYgi7zUPxb+LmDotEEoX3ywmkOmDx33pEJWDlQYbTKJ
 +PYRMZ37vTNqZ5fXz+Hxt+4OEmK/xzhlO2UAVj02PLPZu3JlEZ9nWpfltvaEOuFZMRn9IEEkVhG
 Cr+i8arLPtw4YqKr5I09xiENuLiQAfL3BDKg8UsxR8LNuMXMjWzwF58cTuocBUy1wTBWZAGa/Y
X-Received: by 2002:a05:6000:310e:b0:43e:aa88:f1a1 with SMTP id
 ffacd0b85a97d-4568ca51624mr18282841f8f.30.1778566912236; 
 Mon, 11 May 2026 23:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm29569044f8f.20.2026.05.11.23.21.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] hw/display/cirrus_vga: Fix packed-24 color-expansion
 transparent pattern fills
Date: Tue, 12 May 2026 08:21:02 +0200
Message-ID: <20260512062142.67998-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
---
 hw/display/cirrus_vga_rop2.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index b208b7348ad..8be35ec6e20 100644
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
2.53.0


