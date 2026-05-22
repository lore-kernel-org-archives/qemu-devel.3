Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9DFCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXa-0002gb-O7; Fri, 22 May 2026 17:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWI-0008LL-2S; Fri, 22 May 2026 17:35:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWE-0007fw-MO; Fri, 22 May 2026 17:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=xpUowTyyWJeBPe5IePWV9iZYXFcd+RAilS0Mrr0J+KQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=emx2kblKqKYxZGz5FWcAT3hh/M4UxVC+60m8fyZXYawKN+zAeWqqLqQUMWN79NV5O
 ZugWONK2RIvY/nHZwtuRVtlsctjGcnhT2FfDnvmMcql9nIeGAsB6JyskyySxxHbtVR
 96vUJ7l1T2+ycy3lnfWnIdTEbP7G11hS1StVYBXQSAFK14x1ltv1fCYLdE4LLV/139
 qpbjF1Enl50b6AgAYuwOhbXGWLvT+yVh7wHn5AOb3NJA03Jp0Iebhu0j/CT6HcW6Zo
 Xkz82fidv00pYGfwUSO9t4LhPEKT8rupEDugB+X31yX/meuXvcAD2zR7EbkdnB5ctB
 Tu3FxuJooWHyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 183C31AFAD6;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 393DF3B715C;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chad Jablonski <chad@jablonski.xyz>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 71/94] ati-vga: fix ati_set_dirty address calculation
Date: Sat, 23 May 2026 00:33:28 +0300
Message-ID: <20260522213356.806058-13-mjt@tls.msk.ru>
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
(cherry picked from commit 6197c11dd5d2d5deefc553a663a37139e38c5ac9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 504d1c5708..48498677c7 100644
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
2.47.3


