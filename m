Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F5F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczG-0004YP-Au; Mon, 09 Mar 2026 11:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyy-00043P-Px
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyv-0000pi-Qo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so6847315e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071840; x=1773676640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7huqZG8fYKbzFShEoa/3EqS3qxfYHPgOCMFiO0WkjF0=;
 b=rlxjoKTvbbtt7iQBqcO58NG8D6aKGZmHJLjgyStLjRzxsmMkLN8MgKrx9pO6G3WnCA
 8kfBmKGKBQQWGHWADKbGZoMK8guGwoLHF8aByaCv/iYCwlbI5YkVmzDvSKpVf0WAQ8KG
 sRyrFkpj+493bSH2k08oybv3bCnson2dHDtbf83stuREWVV2e3PHvumzIRI+U9b7Z3Gq
 Xn7lCYrkE+tNGq3hbLt4A0Glus3PcYoirSXt2Z+yB+nhCDaxnJO4D+3hgfQpdsxDwHxS
 SYSgPF15NeA/Bi6qupAOgtBp6rw2FxxsdP1bR2LLK8W4JcNX8kcB7/DETPoWVn5QOLhk
 Vd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071840; x=1773676640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7huqZG8fYKbzFShEoa/3EqS3qxfYHPgOCMFiO0WkjF0=;
 b=DHMSJ2wRZR4YuZO+OI9nv1VeJjUucfKDrbqw9b+Bml1fKfmwIdRf1MnY9M0rC9iJcE
 Dn0zYjUvScc2KS5khPTvJ9cAoyGwcYVnaDWeaDAsQBXZI9ANcwnKzNK2NUXGZSq9TxMQ
 cGdob4kcLi3KTkGWYyx1t9aBO3rvW8uWUq7V3Xo8GglrLwjDn79pE2kI7Ogti3W+5iqy
 XLHkNvR6kYDOIG/01BfcWuhuObqXS+P9vVHQU3YUeXu+pk3c6fZaa7P0EU+90e9w8ZIK
 Wz/pHndjvSN/S76t0eDdYV1T3O6QGarihWajp625YakLLhQq4oyYY/XavC+MjxoC8EtB
 wYhQ==
X-Gm-Message-State: AOJu0YwgDarMZwgOlwLtU/+O1JYx7+U388IYDni6spVi2uOJ3tmu5hV2
 xHX1X6KaTJO/efE6uCXurERPuGmExKTsw25OxLdtPEtxA/GwqQIjYQ/FtfEbM6cLLxf8Zc/seyC
 ZLNGidv0=
X-Gm-Gg: ATEYQzwNYgFH5AT3LQVMQlA9Eq1d8NYuchYVpBPKGqqyiHG3qt38CsNSTluTZkV4tGE
 1ZhbXUmDzCNZBo0zN5TqWex9IBQuKk36RyKEM+bHlnCOVQpBCWZklXSk5G0X1/v/unWVCb0ON+a
 qz8WLi59m5T9zSflQ2TgtuOjZB0LnKWvbDjxkVdxJTXPCbq/tckQA5KZ7aG0/SovnR54TXsSCYJ
 1ynSRpKSNPsurfvejkVPF+/zQFy5Bg+tW+Z+z9sGfPUqjad0HLd/7MntUWUqnjX7w7r8Iu04WRN
 tm9O4+l9bnN6NVvcbOGfNiqGFCr9pmyzg9b52vkQz/N9CH8ErcUuKnbgM3Hd2CQUUOdkhOc183e
 u5rM4Zj4YQvEJnKuSGrloeEaO6q9Afx9CzoylrXjjvua+xpPgnJuqk62Q4FhEi6YXYHp4p7sH5K
 LpnjfKjbOKQMgTT/dRNUpLAbIaR70v4DNzwBCG5CSniPQNWwwp7+Jq9yCPPT/AFFA2qXOJeLe8
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-4852a85e711mr122354585e9.2.1773071839426; 
 Mon, 09 Mar 2026 08:57:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aacd81sm694945e9.14.2026.03.09.08.57.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/49] ati-vga: Implement HOST_DATA flush to VRAM
Date: Mon,  9 Mar 2026 16:52:14 +0100
Message-ID: <20260309155219.62400-45-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
monochrome frgd, and color), however monochrome frgd support is
partial and does not properly handle transparency/leave-alone.

The flush is broken up into two steps. First, if necessary, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <8d0d4b52a16f5564e37bbc88496d7ab8d41477ac.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h  |   3 +
 hw/display/ati_regs.h |   4 ++
 hw/display/ati.c      |   6 +-
 hw/display/ati_2d.c   | 132 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 063efc7bbaa..21b74511e08 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -33,6 +33,7 @@
 
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+#define ATI_HOST_DATA_ACC_BITS 128
 
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
@@ -128,5 +129,7 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+bool ati_host_data_flush(ATIVGAState *s);
+void ati_host_data_finish(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 48f15e9b1da..b813fa119e9 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,7 +397,11 @@
 #define DST_32BPP                               0x00000006
 #define DP_DST_DATATYPE                         0x0000000f
 #define DP_BRUSH_DATATYPE                       0x00000f00
+#define SRC_MONO_FRGD_BKGD                      0x00000000
+#define SRC_MONO_FRGD                           0x00010000
+#define SRC_COLOR                               0x00030000
 #define DP_SRC_DATATYPE                         0x00030000
+#define DP_BYTE_PIX_ORDER                       0x40000000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 16dbb743e1a..bb9e0bba282 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1037,11 +1037,9 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         s->host_data.acc[s->host_data.next++] = data;
         if (addr == HOST_DATA_LAST) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA finish not yet implemented\n");
-            s->host_data.next = 0;
+            ati_host_data_finish(s);
         } else if (s->host_data.next >= 4) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
-            s->host_data.next = 0;
+            ati_host_data_flush(s);
         }
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 1cfd350769c..37fe6c17ee9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -47,6 +47,7 @@ static int ati_bpp_from_datatype(const ATIVGAState *s)
 typedef struct {
     int bpp;
     uint32_t rop3;
+    bool host_data_active;
     bool left_to_right;
     bool top_to_bottom;
     uint32_t frgd_clr;
@@ -85,6 +86,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
     ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
@@ -178,9 +180,10 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return false;
         }
-        if (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
+        if (!ctx->host_data_active &&
+            (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
             ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x +
-            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end) {
+            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -300,8 +303,133 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+
+    /* Finish any active HOST_DATA blits before starting a new blit */
+    ati_host_data_finish(s);
+
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* Begin a HOST_DATA blit */
+        s->host_data.active = true;
+        s->host_data.next = 0;
+        s->host_data.col = 0;
+        s->host_data.row = 0;
+        return;
+    }
     setup_2d_blt_ctx(s, &ctx);
     if (ati_2d_do_blt(&ctx, s->use_pixman)) {
         ati_set_dirty(&s->vga, &ctx);
     }
 }
+
+bool ati_host_data_flush(ATIVGAState *s)
+{
+    ATI2DCtx ctx, chunk;
+    uint32_t fg = s->regs.dp_src_frgd_clr;
+    uint32_t bg = s->regs.dp_src_bkgd_clr;
+    unsigned bypp, pix_count, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
+
+    if (!s->host_data.active) {
+        return false;
+    }
+    if (src_source != DP_SRC_HOST) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: unsupported src_source %x\n", src_source);
+        return false;
+    }
+    if (src_datatype != SRC_MONO_FRGD_BKGD && src_datatype != SRC_MONO_FRGD &&
+        src_datatype != SRC_COLOR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: undefined src_datatype %x\n",
+                      src_datatype);
+        return false;
+    }
+
+    setup_2d_blt_ctx(s, &ctx);
+
+    if (!ctx.left_to_right || !ctx.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported blit direction %c%c\n",
+                      ctx.left_to_right ? '>' : '<',
+                      ctx.top_to_bottom ? 'v' : '^');
+        return false;
+    }
+
+    bypp = ctx.bpp / 8;
+
+    if (src_datatype == SRC_COLOR) {
+        pix_count = ATI_HOST_DATA_ACC_BITS / ctx.bpp;
+        memcpy(pix_buf, &s->host_data.acc[0], sizeof(s->host_data.acc));
+    } else {
+        pix_count = ATI_HOST_DATA_ACC_BITS;
+        /* Expand monochrome bits to color pixels */
+        idx = 0;
+        for (int word = 0; word < 4; word++) {
+            for (int byte = 0; byte < 4; byte++) {
+                uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
+                for (int i = 0; i < 8; i++) {
+                    bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
+                    uint32_t color = is_fg ? fg : bg;
+                    stn_he_p(&pix_buf[idx], bypp, color);
+                    idx += bypp;
+                }
+            }
+        }
+    }
+
+    /* Copy and then modify blit ctx for use in a chunked blit */
+    chunk = ctx;
+    chunk.src_bits = pix_buf;
+    chunk.src.y = 0;
+    chunk.src_stride = ATI_HOST_DATA_ACC_BITS * bypp;
+
+    /* Blit one scanline chunk at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    DPRINTF("blt %dpx @ row: %d, col: %d\n", pix_count, row, col);
+    while (idx < pix_count && row < ctx.dst.height) {
+        unsigned pix_in_scanline = MIN(pix_count - idx,
+                                       ctx.dst.width - col);
+        chunk.src.x = idx;
+        /* Build a rect for this scanline chunk */
+        chunk.dst.x = ctx.dst.x + col;
+        chunk.dst.y = ctx.dst.y + row;
+        chunk.dst.width = pix_in_scanline;
+        chunk.dst.height = 1;
+        DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
+                pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
+        if (ati_2d_do_blt(&chunk, s->use_pixman)) {
+            ati_set_dirty(&s->vga, &chunk);
+        }
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= ctx.dst.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.next = 0;
+    s->host_data.row = row;
+    s->host_data.col = col;
+    if (s->host_data.row >= ctx.dst.height) {
+        s->host_data.active = false;
+    }
+
+    return s->host_data.active;
+}
+
+void ati_host_data_finish(ATIVGAState *s)
+{
+    if (ati_host_data_flush(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "HOST_DATA blit ended before all data was written\n");
+    }
+    s->host_data.active = false;
+}
-- 
2.53.0


