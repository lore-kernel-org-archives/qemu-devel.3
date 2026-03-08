Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D0EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkX-00063c-Sm; Sun, 08 Mar 2026 18:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkV-0005vn-Lj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkU-0003WL-1i
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so3617018f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009440; x=1773614240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pEcmCtk5Y5SmYmBzYXMrn+DWhfnlB/6nRRhyFttZBcI=;
 b=nl6Pub/HZe3mE+q38FT0QZlJD3LllaH7nt9mydaeSgfpgaBcZHSdlrQWcJNYDqSVOT
 VJH4BS93EY8TgUyMpcQDaiehp6y97rpeuyhzosIZM1N9niXfyx0ghTOOB/5/vodIvVP9
 Ken5IT6fGWPaHyxGv4toQzwOeSxGWgSto0D288XoVC9VyOHBY7RRqUVIErTyDiQTqELZ
 JBXFyxgbPPUFTloomfgX5eCvg7FMFojZPnXcylkkzOHMFoc8Kzv/NjO5lwmffVZ2IbhY
 0S61TrEzvhCXfHgUZU0dgPp57wjljD5pRDm5ryGXey7wp1RQDQzIhSGLAmHwLZ0iLFlO
 cgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009440; x=1773614240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pEcmCtk5Y5SmYmBzYXMrn+DWhfnlB/6nRRhyFttZBcI=;
 b=ubvCyqBC39R6ytxibXjlNJa1qf6KiAnzhXt86Q0rTmQ7zjWz3ztABo0lPTWnqdgqPz
 ZulQ1hbueSH2Jxc0pw5j8COTFxlBUkpJOsu/y6RxFoVyvO0GKaDxXQB3omJ2XQQdtOfc
 dKrkYgjpi8ZXXFEcmKip6IWVRGCC05FdnoG7HAa0w7wocYh7IkS8AG9g3i/mzAx8P60y
 iU1Cly2qAmcBifUAm6ntQZVdwxAyesGHyNRJUfNA7uTtS90aW+Nj9WqUtKQ+F8aosA2p
 ebP7h3n45Gxbl3Tup+j1e3fBr63UsCyES/iCzt7c6lytj+q84ATdotpi3nsfxzDXVB+m
 SAgw==
X-Gm-Message-State: AOJu0YyWXixW9Dxtdzxat+4XDL/ISpu7jJt0YjBGj8UPLKgVHc+CEW+7
 csVWM5T0ZGMFurytZFPjbKGohmgGjwxm9paw284CfC1diX0mjEEOYPtgqFTWUIx8T3++/q0KDhp
 OCSbkcxo=
X-Gm-Gg: ATEYQzygFI/XURpZIOro22vuy62TvXLYeGgG3wCj0JjGiHuiQeYfnCcDQYe8IIVn2qv
 LrbXmvXh9e/JzhAerx4hoXzWUtmK2YSiUSuNZO7tuVf4G+JkVq6bbZoDcQadLWqpJ06Op3QW/xL
 suvQfP4bwasVMVArXfisRBbu4Bf5lyGfBKue8LRFFRhiQa6S4inrbfVxlvwCSqYYCtcCGLtr6+C
 16iGwVIeIKX0OCA4LE+0gBqDMeY9eDcx+cfgFHR2zV53641Pq873Fe70jmtMpdcca10wXRrCAno
 RwxbFG5zLDqohXwSrBnEjUHGBTG5BBR0RlHEB+hnzMkHn+ey15YAGNYb99UomAX38Iw84XilG6F
 TmSOTVVlv91IvPDa+I2HzahfFO9m6JB7chv79kXfjXNReP+Ko9KBLH/sxiJ4yQD99TGk4yXbYZj
 CUf8e/sLSyBGngoDg5ViWWRWGMbgr/BRJX0+R90Qm84OLwH+I9YhdbFq0FrNm3DNSz496qUlmf6
 RxXww==
X-Received: by 2002:a05:6000:2911:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-439da351b41mr16853379f8f.16.1773009440002; 
 Sun, 08 Mar 2026 15:37:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3f267sm20281131f8f.31.2026.03.08.15.37.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/49] ati-vga: Consolidate dirty region tracking in ati_2d_blt
Date: Sun,  8 Mar 2026 23:34:08 +0100
Message-ID: <20260308223433.25503-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Both supported ROPs follow the same memory set dirty logic.
This consolidates that logic to remove the duplication.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-9-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index cfc7bf97899..8e192802d3a 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -43,15 +43,29 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
+static void ati_set_dirty(ATIVGAState *s,
+                          const uint8_t *dst_bits, unsigned dst_y)
+{
+    VGACommonState *vga = &s->vga;
+    DisplaySurface *ds = qemu_console_surface(vga->con);
+
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
+            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
+            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+                   vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
+        memory_region_set_dirty(&vga->vram,
+                                vga->vbe_start_addr + s->regs.dst_offset
+                                                    + dst_y * surface_stride(ds),
+                                s->regs.dst_height * surface_stride(ds));
+    }
+}
+
 void ati_2d_blt(ATIVGAState *s)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    DisplaySurface *ds = qemu_console_surface(s->vga.con);
-    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
-            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
-            surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
     unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
                       s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
     unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
@@ -166,14 +180,6 @@ void ati_2d_blt(ATIVGAState *s)
                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
-        }
         break;
     }
     case ROP3_PATCOPY:
@@ -216,18 +222,13 @@ void ati_2d_blt(ATIVGAState *s)
                 }
             }
         }
-        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                    s->regs.dst_offset +
-                                    dst_y * surface_stride(ds),
-                                    s->regs.dst_height * surface_stride(ds));
-        }
         break;
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+        return;
     }
+
+    ati_set_dirty(s, dst_bits, dst_y);
 }
-- 
2.53.0


