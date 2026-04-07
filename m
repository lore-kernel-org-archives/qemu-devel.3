Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F510F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYOY-00008d-0J; Wed, 08 Apr 2026 15:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYK8-0002Gt-Oh
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:12:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAESJ-0005VJ-Ki
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso41857445e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599170; x=1776203970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhn2eC+DMoiExYnjeUurcV+Nld88cdr8TS7kyXuZAbU=;
 b=csyioh4UJfR+ATnIXGJLW73VxeW3X8PAwpBUzRptus9mWC7qCnEPrB3rcS2DSIBbAB
 1V0WWqrCnZyAvIspYCDgtkcaC1cDi3feVu2ZzQmjXCCCiFgmJIFXft/3mxPI674iJU5z
 NNzCaJt0fg/xHi2jxlUAZMEf4sfLYFtwL9ErEOGOrMW+LHpIa1clT+ZG8qFZl7TwZvzp
 w+TyNM0WLmWGUfv/NXTOO0qCVHbGsleJMLtaRx/uoWGPpbyA9/lNCqUrBVQCTDkxE/+O
 rab8iPQKT/O5kud+iu605luw1VFHGxeaM+vIwh9XZpqfd2L/WUyp2JBJdGeXW0aer3lS
 Au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599170; x=1776203970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhn2eC+DMoiExYnjeUurcV+Nld88cdr8TS7kyXuZAbU=;
 b=WHqpslVprOzjD5V0Mrd+NkBh+9/pZ8ExQb4MIvVFAAd74ng5RKW+38ne6kGixGT67R
 XZudFxgo/9yKfwTCYrJEHB155fgQar15Jrh9LKOMJc5cO2psqAIU72kElRczR/rqgMxd
 7HfKhG0thsii5O2KwDjGUcXDa/i9ikdKmgXkbm7o3OyWWBSBtgKFFxtmo0T9Ntcxesp4
 hy+mB6iYVb/bS+/4k1igTxAD+rNOAkCAZeqb3prt9b9UidhmP/y+q1v9rN9JTbnvgo/x
 0pmC9GxT7osT6P35efJWbPHtpfQhqS5FHK5k40uNJq/TKZWgWiWivVYSnlfW8vvXVmzX
 PS3A==
X-Gm-Message-State: AOJu0YxIyuIOhupboOnE9usUenzqz8A3ZpBgV+isixVP/0GwvRl3Y20y
 cN+YZcPGZVIIsWFfvALZyryKrnT0Wrwhe/dUB6ei6YwNI5AfY0by+l7hCJyErWxRe84+p8K1KvP
 m0obW+mA=
X-Gm-Gg: AeBDiesVn8Os4LuRQY/QifVemMkiKvUWugP5EOj1j58O+7yIL6Xjgmc3adNgUUjqDY+
 +qKhnqQUiUce+LjM94i/RJAZ6q6TczB0t9zoIkENauUBUJxFlbqEgqV75f0nu7Q2e0N60R+qd7I
 BiEaP06y4UIdDQPQ7se/daleTzM6OfNbkR6PJT5Fho1YDYWU4JDniVQ/U6t7a6m3jnYQX37SNum
 SBqhCH4gAy7zdDuaJv9WGjPpVKPxuc8I4nv2aS0zPsC8YTN4/kZzNiBbGutDLTPvmpD/lGxUoZw
 EMMJuHQLKT3oQQYErQqBztD85y1b6bYmrFiGp0+/L6QzEo9QA3SiR0ih9jlxxAZky0TN9yH4Upr
 wipvn1NyA/hcUJ8f8NcoCAhOKw5PYnrYIhhZiSnvt+0P8tZ87/Q7LTztmVym30r9dr2vW91dKwu
 5i9EvvxfrdKDvi5nuu0SGrlGgzyNjwMlZsxFcGH+696H8+6skuQtAv4VEnMdd6m26rRYga7chl
X-Received: by 2002:a05:600c:4447:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48899785c7bmr292690955e9.17.1775599169827; 
 Tue, 07 Apr 2026 14:59:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5016sm57075155f8f.33.2026.04.07.14.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 4/6] ati-vga: Fix setting CRTC_OFFSET
Date: Tue,  7 Apr 2026 23:58:58 +0200
Message-ID: <20260407215900.63390-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Offset (display start address) should also be updated when changing
the register value not only on mode change. Fix the register write
mask to hard code bits 0:2 to 0 as the chip docs say and update the
start address on register write. This fixes virtual screen panning for
screens larger than displayed resolution.

As this register allows values that cannot be handled by the VBE_DISPI
X and Y offsets (which is restricted by line length) we add a function
to set it directly not through the VBE offsets.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <2b8af6022aba06aa98a249ae67922de29d82d86f.1775228029.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 97d871b1e22..a283afbfff5 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -48,6 +48,19 @@ static const struct {
 
 enum { VGA_MODE, EXT_MODE };
 
+static void ati_vga_set_offset(VGACommonState *vga, uint32_t offs)
+{
+    int bypp = DIV_ROUND_UP(vga->vbe_regs[VBE_DISPI_INDEX_BPP], BITS_PER_BYTE);
+
+    if (!bypp ||
+        vga->vbe_regs[VBE_DISPI_INDEX_YRES] *
+        vga->vbe_regs[VBE_DISPI_INDEX_VIRT_WIDTH] * bypp + offs >
+        vga->vbe_size) {
+        return;
+    }
+    vga->vbe_start_addr = offs / 4;
+}
+
 static void ati_vga_switch_mode(ATIVGAState *s)
 {
     DPRINTF("%d -> %d\n",
@@ -109,26 +122,12 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_ENABLED |
                 VBE_DISPI_LFB_ENABLED | VBE_DISPI_NOCLEARMEM |
                 (s->regs.dac_cntl & DAC_8BIT_EN ? VBE_DISPI_8BIT_DAC : 0));
-            /* now set offset and stride after enable as that resets these */
+            /* now set offset and stride because enable resets these */
             if (stride) {
-                int bypp = DIV_ROUND_UP(bpp, BITS_PER_BYTE);
-
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_VIRT_WIDTH);
                 vbe_ioport_write_data(&s->vga, 0, stride);
-                stride *= bypp;
-                if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
-                    vbe_ioport_write_index(&s->vga, 0,
-                                           VBE_DISPI_INDEX_X_OFFSET);
-                    vbe_ioport_write_data(&s->vga, 0, offs % stride / bypp);
-                }
-                vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
-                vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=%x\n",
-                        s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
-                        s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
-                        s->vga.vbe_start_addr);
             }
+            ati_vga_set_offset(&s->vga, offs);
         }
     } else {
         /* VGA mode enabled */
@@ -737,7 +736,8 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.crtc_v_sync_strt_wid = data & 0x9f0fff;
         break;
     case CRTC_OFFSET:
-        s->regs.crtc_offset = data & 0xc7ffffff;
+        s->regs.crtc_offset = data & 0x87fffff8;
+        ati_vga_set_offset(&s->vga, s->regs.crtc_offset & 0x07ffffff);
         break;
     case CRTC_OFFSET_CNTL:
         s->regs.crtc_offset_cntl = data; /* FIXME */
-- 
2.53.0


