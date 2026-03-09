Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A218F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzczO-00053J-NZ; Mon, 09 Mar 2026 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyW-0003Zs-Vi
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcyU-0000nl-2e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b790af67so4879094f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071812; x=1773676612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oxfOws3Bamemn9Q2Htt4dbPST3MdqkFHwhKudwpIJYA=;
 b=w1VWyrFQalRmRLJz8NvKau4XyFq7zkwJ1y+7wMonUnmqoKCm6TYFeng5xF4IKeBpEY
 GSYXhivTkC1wqftHIr8gw3McajqCLuflvRRU9sCYyUKZRaSfO/iGaPclMUo3MmXQqEmX
 PHNz2NLTPGd3MU7z6JGCby5nZdfMsfw/5xp+FEsqDtEnLkr843Keg4uasdJmdnmpHmi4
 0Eq9YSXKQNy2BZGllfMvbAbbH4Bry9LlL7YP8rVcsTVTU2z+O/F1phiTpD6DtzLwE1M2
 oTyCYckTpzLBWA4wfCz1clndj6NM+FUAB+VxdsWyIxu6LlvLszMe3zwXJ/FYldcoiQky
 eFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071812; x=1773676612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oxfOws3Bamemn9Q2Htt4dbPST3MdqkFHwhKudwpIJYA=;
 b=sKL3j6t/bmSOQ0MUsNvVBd+16EPJAGwen0XflVKwoqIe/ZumKT9gk9c8op8JOQncN7
 B0luUJwkFPMH3R/4IL9Bs6J5wRSlYdo3RlbAZSLq2lLta8Ni1EzpmiKUPMLThporT4Qh
 xfJDqGZ3fi0uV3lH5zf4iWzqkZSv8idPD4YfHy7yDDXGekORGZ8escTSX3ikUUStKuY6
 NeYcAFmfvsDk87BOZcuFz5jSOcmh7YTByV630j8jPLN1emlsN2Zv4gE8AXf9dGu6U/ZW
 L4r8msWdCAgT5ziAieIjHM5/RgI4jvT8JTkU5/TMijfAcAGXS/oGb1gKj9XyjeLKxL5x
 3PAA==
X-Gm-Message-State: AOJu0YzOA/3kO0FFFE2V4+q9tjygA+qC3m+f1QNRRwXY9d91JyzH5uUd
 nWWzOzovXJol/rGl7xnTA/U2oyLcqhVJ8nDHYrgbnu7LFDqggAJgp9oQ+sxEG8w1WekFYzdiH+5
 5wfYm/jE=
X-Gm-Gg: ATEYQzzyilvCFYhYmUKbgs2+aYODgJnbozU/7WNUI80IxZ9YseoxFspxcrl04K+ZNFQ
 pBXgoUqH4htF+4l9WdeVGrHd6/DONIp5Dv7vAAUqj9Nt1j+T3QCiuEFa5W6u4MZVeYoyrmlhr8R
 oYc+mCwKBrLqwfTaPUTRglorpliz2+UtFdEseAx6p6Jx8RlhEOk2yursbG7hxyj8BCu92qlXjFV
 /KN5v8chHEiZMeYGye7bgVZ4GzrRT0/OacRBa3e4fPeBkmhLMstmwaS5JBCaTEau19GBzlWaFuQ
 flJQ8OfFit6c4Y+MpDOlDMhOICkQ+yAKVEuYoOQKU4aNNP2AMjCxhcFGyqiQL9EghpgwypFXcgI
 fs4Wr1kfFHk7uhYpnye/Sf3sK5kmpMZY2hsdcRxrUu2PbCzO/sZaBNLi66Uq2FnsISqimrNj6U+
 jjNZoFjig+rI4KuDde7f4AvoJdUj7park1Wx9h+T6on5a3DRBNy4LD6Hgmy5ia9INeOaOhuQz8
X-Received: by 2002:a05:6000:2307:b0:439:c1a7:9dee with SMTP id
 ffacd0b85a97d-439efeb0512mr310744f8f.0.1773071812078; 
 Mon, 09 Mar 2026 08:56:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm27776223f8f.15.2026.03.09.08.56.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/49] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Mon,  9 Mar 2026 16:52:10 +0100
Message-ID: <20260309155219.62400-41-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

ati_2d_do_blt returns a bool that is true when the blit succeeded, which
means that a screen region will need to be set dirty. Otherwise false is
returned.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
[balaton: Fix build without pixman]
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <367949c50ca140a2d18ae66234dafbbc586b553c.1773020351.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index ef4d2e21b5e..aa2e540a510 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,24 +123,21 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
-    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
+        return false;
     }
     if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
+        return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
         ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
         (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-        return;
+        return false;
     }
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
@@ -148,14 +145,14 @@ void ati_2d_blt(ATIVGAState *s)
         bool fallback = false;
         if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
-            return;
+            return false;
         }
         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff ||
             ctx->src_bits >= ctx->vram_end ||
             ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height) *
             ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
+            return false;
         }
 
         DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",
@@ -265,8 +262,17 @@ void ati_2d_blt(ATIVGAState *s)
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       ctx->rop3 >> 16);
-        return;
+        return false;
     }
 
-    ati_set_dirty(&s->vga, ctx);
+    return true;
+}
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    if (ati_2d_do_blt(s, &ctx)) {
+        ati_set_dirty(&s->vga, &ctx);
+    }
 }
-- 
2.53.0


