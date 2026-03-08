Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1B6EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkK-0005XQ-DG; Sun, 08 Mar 2026 18:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkI-0005R2-EH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkG-0003UU-JK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso98477215e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009426; x=1773614226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tqix9hZK5KUL0kTLt7mTimTwZwRjziRtwjEO0THOpg=;
 b=DibqQ1hEDVqNfmBeiMfxup02t3Jm4zSHm5Ur1luBgHM32hfA9g/pHRgkZXYxF+ckvY
 I1DIg0oLQnCV26hKI0zELRPZfHNJb1R/3DpgtC62jKQPLWN/VNtLKOYjecdWz2JJv28G
 LKqjja9ai9gzo3s4nVmDzkCLTrdJp7cf95T+IVfnaCpbya+4dfm3wq5/MEKFwzIyQFLi
 fnB4qiRUbfFLjM3gR/yMW16zBOwmJ3YmMBGVED4c73pomvPG8NFgy+WMUhsgf26K0AZe
 gFajRJZb9nE4c1JitucVxiLavinCwOwELRyuQIDmp3zVH2GuP9bE9VdvA7gumZat6Z9E
 MvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009426; x=1773614226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4tqix9hZK5KUL0kTLt7mTimTwZwRjziRtwjEO0THOpg=;
 b=VsZsiSLDbp8JqbHIcC/TB4OLr56s3ikJp/IjY6WmDyZKcGC8KqIQ2aRj9ymQejeasg
 UBXYFCyKQgNBgXLXBmhoi3hTTLlPj1A2MCSXOjZHoxcU565FqExSKyig68yz/AFSbZ9K
 Nf1hKZRElStk234OUADUkzMYjTe/c89R55hwvOM538rPGvAkSx+KySH7yoKaN4CbfwYN
 02GFtkwIywA6Ds9MAShvFf0euVoWYQL9vanzKVaRwvXqkZZpMd0NYXklsm2a3xp07R6V
 xpRvy0EtKph8/GdzGkVFjKET79RJyLUPXC6Dxk21TEGnibQAylatHtkTaueZhWOLdLMb
 yf+Q==
X-Gm-Message-State: AOJu0Yw1CgDHxed9pFybETOFP3e4gwCU8CpTqCXPG5BrAl2+BK7tcYVn
 VWVtHgXDGKwlOJkTN2zA86jmlM91OiNCf0AbLV7W5lvbMxYQhq+X3XcueBD4m52Duah0obzzcOq
 2nnDNhSU=
X-Gm-Gg: ATEYQzzBkSuxAQeezYEXS+UKSubXjnFnjrxPtoDZkcfaxqH/4hZ/Ko+iCFI154zC6Uf
 c3gg12YKsjOQlBJW3y1az3lrD05JMqUU/jQQYQyck8RHnGEpxY4hl5N4RnVwmeKy9CCQxKamFUf
 sQutGZguz0Xx1tkyCheJfqbgo26AjyxNCzeXNhnXynvri+P7+uCjQSMClEGiBQ6cfW0NoNqRPK0
 VAwCvWYQW6MgfcRJg65WNH9EHNSatBrf4FD3nyJNFHA13U2w+oIMP9d9wtLs99+Dz084tel8Ocm
 t7VOqYRtlr9Ui0sBBlBH0bkYK6Q5tZM+AOMetjKphaH46WvulmeRf9xORL6T0zaB/4isjZ1uURV
 X8y2zvVDcNgVit0qEGIYgGsrOzbxS1dDrjjXukuB0Rtcejc/WADee8etlyoSXTOBMRQepegcmCT
 WhDMyHLiqiZKOVB7GoSNxV3Tdea8Wy9GjiXQCDczhtUhsLpwLMHU4j4qUgU7hCC1Rm+mI705d2x
 G3TxMkCdiwgqN8E
X-Received: by 2002:a05:600c:8b5b:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48526927a4dmr152076035e9.15.1773009426052; 
 Sun, 08 Mar 2026 15:37:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a310b8fsm52849395e9.11.2026.03.08.15.37.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/49] ati-vga: Add scissor clipping register support
Date: Sun,  8 Mar 2026 23:34:06 +0100
Message-ID: <20260308223433.25503-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
to default clipping.

Scissor clipping is used when rendering text in X.org. The r128 driver
sends host data much wider than is necessary to draw a glyph and cuts it
down to size using clipping before rendering. The actual clipping
implementation follows in a future patch.

This also includes a very minor refactor of the combined
default_sc_bottom_right field in the registers struct to
default_sc_bottom and default_sc_right. This was done to
stay consistent with the other scissor registers and prevent repeated
masking and extraction.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260303024730.1489136-7-chad@jablonski.xyz>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_int.h  |  9 +++++-
 hw/display/ati_regs.h |  2 ++
 hw/display/ati.c      | 70 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 708cc1dd3a3..98f57ca5fa4 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -78,14 +78,21 @@ typedef struct ATIVGARegs {
     uint32_t dp_brush_frgd_clr;
     uint32_t dp_src_frgd_clr;
     uint32_t dp_src_bkgd_clr;
+    uint16_t sc_top;
+    uint16_t sc_left;
+    uint16_t sc_bottom;
+    uint16_t sc_right;
+    uint16_t src_sc_bottom;
+    uint16_t src_sc_right;
     uint32_t dp_cntl;
     uint32_t dp_datatype;
     uint32_t dp_mix;
     uint32_t dp_write_mask;
     uint32_t default_offset;
     uint32_t default_pitch;
+    uint16_t default_sc_bottom;
+    uint16_t default_sc_right;
     uint32_t default_tile;
-    uint32_t default_sc_bottom_right;
 } ATIVGARegs;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 0a0825db048..3999edb9b71 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,6 +397,8 @@
 #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
 #define GMC_SRC_CLIP_DEFAULT                    0x00000000
 #define GMC_DST_CLIP_DEFAULT                    0x00000000
+#define GMC_SRC_CLIPPING                        0x00000004
+#define GMC_DST_CLIPPING                        0x00000008
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 26fc74b19b3..6cf243bcf95 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -514,7 +514,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = s->regs.default_sc_bottom_right;
+        val = (s->regs.default_sc_bottom << 16) |
+              s->regs.default_sc_right;
+        break;
+    case SC_TOP:
+        val = s->regs.sc_top;
+        break;
+    case SC_LEFT:
+        val = s->regs.sc_left;
+        break;
+    case SC_BOTTOM:
+        val = s->regs.sc_bottom;
+        break;
+    case SC_RIGHT:
+        val = s->regs.sc_right;
+        break;
+    case SRC_SC_BOTTOM:
+        val = s->regs.src_sc_bottom;
+        break;
+    case SRC_SC_RIGHT:
+        val = s->regs.src_sc_right;
+        break;
+    case SC_TOP_LEFT:
+    case SC_BOTTOM_RIGHT:
+    case SRC_SC_BOTTOM_RIGHT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Read from write-only register 0x%x\n", (unsigned)addr);
         break;
     default:
         break;
@@ -877,6 +902,16 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             s->regs.dst_offset = s->regs.default_offset;
             s->regs.dst_pitch = s->regs.default_pitch;
         }
+        if (!(data & GMC_SRC_CLIPPING)) {
+            s->regs.src_sc_right = s->regs.default_sc_right;
+            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
+        }
+        if (!(data & GMC_DST_CLIPPING)) {
+            s->regs.sc_top = 0;
+            s->regs.sc_left = 0;
+            s->regs.sc_right = s->regs.default_sc_right;
+            s->regs.sc_bottom = s->regs.default_sc_bottom;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -956,7 +991,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
+        s->regs.default_sc_right = data & 0x3fff;
+        s->regs.default_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_TOP_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        s->regs.sc_top = (data >> 16) & 0x3fff;
+        break;
+    case SC_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        break;
+    case SC_TOP:
+        s->regs.sc_top = data & 0x3fff;
+        break;
+    case SC_BOTTOM_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        s->regs.sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        break;
+    case SC_BOTTOM:
+        s->regs.sc_bottom = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        s->regs.src_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SRC_SC_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM:
+        s->regs.src_sc_bottom = data & 0x3fff;
         break;
     default:
         break;
-- 
2.53.0


