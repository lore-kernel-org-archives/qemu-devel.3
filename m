Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D574CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgaF-0001dI-GM; Tue, 12 May 2026 02:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZc-0000QH-OE
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZa-0007oW-IT
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso35010975e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567189; x=1779171989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z97yc5ej7ciCg7EXR/9lOGcsIIseUEUiyXY4n4ob4ck=;
 b=nKP69l+Zz6WbuW1PiostDNoE2Inp3np/YH3tCjEEleriaq89frRo3xMRtb/rjnBSJm
 PLrYSJpwKYO4ky5hNIKlbne6Mb2ExZ+LVDHW8bLHQcWJrTaE4SgyzjLJcdoV+ZHZmZH/
 lNZnRh7XhvOMzZ0TDdlaxxVIK/FJ3CNzGnrcHV1xKtRJHBqViVwmBlNejIV2/QohQflg
 xIudUOnLAcmpIRFH9JRBanKK10Nyi1vTAvJpHrIFY0Yc5pG4SeQUph+Fg1EareTRQ1GF
 3pa40w8xQhpep9CuIZAgNsI76tAwVOcmuAe5yq7b/PwJ66TLYEB9Z5y5/LKHnG2GB1EO
 tfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567189; x=1779171989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z97yc5ej7ciCg7EXR/9lOGcsIIseUEUiyXY4n4ob4ck=;
 b=DZeIxg6GmRKsvjaaa56htnLHFSu39ZdCYzoqbTg89lrUgT+0me4s8mZovSQ6Ry2+EE
 26U/CKoq9joKBND7l+G1VjC+Ez1NYdhN+yr4uhojhtrjiplMIAU039GB0E66oIcMHMiY
 G7BmGGo4LbFnIgm2rfhbLkrDR7t4qc/B8jtmY7gQ3o0wHhFYqsPEK7Geol449GZfJLYG
 xt1zqVPbbq9SX1gmzQhT6P4OxsVfPKj+3jJnbnrHXSRA9fwykiprMcxChDheE7u4jUjF
 CqDBHSTOuGYaFt3Q82kPitvuNmS4Ov3/a9XczDB+5YPiLfarvodOXs+laWPBBemF7mxv
 xg3Q==
X-Gm-Message-State: AOJu0Yy8NZ7bu2eYBpyeONMOD/1DU29WmSz/E587ncuNQSfPAup6pY5+
 LIX3abdomkX7aA1ooq2M2i58jbqfsguHLhHUY2wz+zMfis17HYxH7c//RP0qaqw1RjUPc8+l0c6
 nsJzeLqc=
X-Gm-Gg: Acq92OEmSFSusi320vPF8vuNXrNswCpcDzSoshZil8Ab57btI1OU8Gty1gpwyVaLjnj
 h85+rHES3sljNvp7NCUzLn4MSoIKbmkaXiwquoorUxuiDzGx9YDs6nErcLgY/htxUTKIvHzqdTk
 g95wXS1/znSygfO6RMODlmdi6ibkTjte1V5o+nQREuw/CNqMo872lPLDkESQoT4qn2SWo+cwvni
 vPuPlFrWI0v2zciVz6pxv4Bi/ixjjaKav/hLlXByhG6HR+axIuuTECcRDt3vrDQj4MVsF6t19RG
 2fZxXW3HAUWH8AqFaZNzvZRk0OuH+oShemUpndZCFULW9kPJmlqxyg3zf9s4b+sW52kmXUgyaPu
 TOT5fVXveYygXbukXeRGvqsFpTi2KZ2mFR+iKaNY/RrykgMHcOSo0KqmlnKmK/uELnExVmZ4rze
 lQnLipIppp8cZ4sSNKM5ZoJMJeab5Nk0nvU5W+DgRiojYc6uTZgEo9yAKPagOuJ7TQAdB4q12qc
 NlBdrhe1aQ=
X-Received: by 2002:a05:600c:8904:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-48e6767ddf9mr191883165e9.10.1778567188468; 
 Mon, 11 May 2026 23:26:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e62a2desm12281745e9.9.2026.05.11.23.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] ati-vga: fix ati_set_dirty address calculation
Date: Tue, 12 May 2026 08:21:41 +0200
Message-ID: <20260512062142.67998-41-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Chad Jablonski <chad@jablonski.xyz>

This fixes three bugs with the ati_set_dirty address calculation.

First, vbe_start_addr is a word offset. All other values in the
calculation are byte offsets. It must be converted to bytes.

Second, when setting the dirty region with memory_region_set_dirty
the vbe_start_addr is used to calculate the start of the dirty region.
This is a problem because the vbe_start_addr is the offset at which scan out
begins. This puts it in the visible screen coordinate system. The dirty
region however is in the virtual screen coordinate system. This can cause both
overmarking and missed updates. This is removed from the calculation.

Third, when the start address of a blit is outside of the bounds check
the entire blit is missed and not set to dirty. This happens even if the
blit does partially overlap with the visible screen. The fix here is to
find the intersection of the visible screen and the blit and mark only
that region as dirty.

This does not attempt to apply clipping to the blit. So there will be
overmarking in some cases.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
[balaton: drop excess parenthesis, use offsets instead of pointers]
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260506153920.C6B27596978@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 504d1c57085..48498677c7e 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -69,18 +69,28 @@ typedef struct {
 static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
     DisplaySurface *ds = qemu_console_surface(vga->con);
+    unsigned int bypp = ctx->bpp / 8;
+    hwaddr dirty_start = ctx->dst_offset + ctx->dst.x * bypp +
+                         ctx->dst.y * ctx->dst_stride;
+    hwaddr dirty_end = dirty_start + ctx->dst.width * bypp +
+                       (ctx->dst.height - 1) * ctx->dst_stride;
+    /*
+     * The blit may be outside of the visible screen (e.g. virtual desktops.)
+     * Dirty only the intersection of the visible screen and the blit.
+     */
+    hwaddr vis_start = vga->vbe_start_addr * 4;
+    hwaddr vis_end = vis_start + vga->vbe_regs[VBE_DISPI_INDEX_YRES] *
+                       vga->vbe_line_offset;
+    hwaddr start = MAX(vis_start, dirty_start);
+    hwaddr end = MIN(vis_end, dirty_end);
 
     (void)ds;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
             ctx->rop3 >> 16);
-    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
-        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
-        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
-        memory_region_set_dirty(&vga->vram,
-                                vga->vbe_start_addr + ctx->dst_offset +
-                                ctx->dst.y * ctx->dst_stride,
-                                ctx->dst.height * ctx->dst_stride);
+
+    if (start < end) {
+        memory_region_set_dirty(&vga->vram, start, end - start);
     }
 }
 
-- 
2.53.0


