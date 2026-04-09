Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBFDF31E22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqGl-0003It-Tq; Thu, 09 Apr 2026 10:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGh-0003F9-A1
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:22:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGf-00039N-Cu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:22:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so567439f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775744519; x=1776349319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjuOAzMxe2056w6Ss/yMMT0oZPZyJj/YY1kbGnOufgk=;
 b=BhlOCzMI3J7NKM1pDL6dlIcm6S6EQpxuUJNwIB0Ri0UgatrH7+jRb00b4AwG0LvNiI
 r5mLnKUPqTptntyj+D/nmakDUuRtvePWoE0rpbPe8dBTNFQmpRPeMpWJLb2Xj3+jbIyL
 ZV7LxNPbWIyUlMUdLxHQ/wwDnhV9iSw6LgaMfvT8W7fMcxbcoCEvCdk7UX1oP5UJwC2a
 OszcMKzgoC1x2g8fPaRp8b5/rR4HqMkq7ynnMDDCCoJ21jB1Gw0XzI4HWIc9PTN6S22u
 zetXq+3dSX0grak6QoqBjPpt3nKMXRbrBAZB8NCkKD9cKWI2hy5d7zT6lhZvSprM/aHt
 lxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744519; x=1776349319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VjuOAzMxe2056w6Ss/yMMT0oZPZyJj/YY1kbGnOufgk=;
 b=bTn4acBUuKF9850KrSefUKt0Mr2geK8Jv48S+17Y9xP2gJvCL4tPTjeSQfVsne7bZE
 9uXNA6pvxWlcX0bDDpJyG/7VCKyqHfWwQs0H8CiSKkoIAmmO39mryI7YT0czlRxcs2RV
 xipv28f9VTFqdqr1uZXnb6Aeby6uv17ds7BJY3SE1Bhk3/xP6LA9zamkTOxhwCMsPo7f
 sfX6SRFa4doGv9z8zk438sNBXBbRNjU3ftg2wrSfgN0Lgq7uAzRs3x6zNXncfFxMNgvh
 EG1zM12ddp9taKlpxv4qrQ4TSZp0JxepXc6TeNBE8Ti2ZwegdDFW2NUFSjeF6yeunycO
 mx/w==
X-Gm-Message-State: AOJu0YwLBk25aZAFqaMTOkOBygZ/np5gKd/zETzIgAMB/TYKuabSTaW9
 X+HFl7q+Z0oSVOcptflCBCtKzVCv4wldMNEicU//wqV4yaQocOYnXv//k/BLLHVxMNm8BzxYVSL
 QyEnYpw8=
X-Gm-Gg: AeBDiesKhNisGh7JIqN3u0Eh5gFUBx/k8l9B+/OW/Wiek3cS7wBdPuBh4ytq8b63Hwx
 x8UbSxTOB14akEPU0SaFg0UmGNSQ2tNDYA6uB/GjbUTdSER6hT4AyVAg11Ccr3WoXQrCXuRPDH7
 FLFLJ6uaIScamaPuAzr76bfmaAQrhYkZ/R6uxLAKvCpUD/gvtewem27Y/tmO4HKGUKh12tS0Rj2
 LJt/NSbk3+LXrk13iEe85TsrkDJEejznrykryNFBd1oI/dt55YUvHovhI6B9FthOhytQOOEk0AD
 CspZknd88UIc1FMwd2Fo0oIQaqs04WPF7mRcHj6kuhVHXJ5dyFATnliQhCvG83b3JI05qbDCVNk
 heie9JRsu5Gfqa562y0e6/TI0WfW1NRaDlXy8L4w6d6XhWxw/VrE9aO4JinFAkfHaEO01ej+eW2
 kaAtxX0IGrLErCtAZxjqLKnoBH3VmJv22siPwH7rOJ0s8Uz8tqnH1jE9Ngx4J12LHlRqa1cKSm
X-Received: by 2002:a05:6000:40ca:b0:43b:80a0:d92 with SMTP id
 ffacd0b85a97d-43d5a1b107dmr5243479f8f.45.1775744519260; 
 Thu, 09 Apr 2026 07:21:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d5e969bbfsm5043612f8f.1.2026.04.09.07.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 07:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] ati-vga: Fix check for overflowing vram
Date: Thu,  9 Apr 2026 16:21:35 +0200
Message-ID: <20260409142137.58349-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409142137.58349-1-philmd@linaro.org>
References: <20260409142137.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Take into account the bytes per pixels when checking for accessing
beyond end of vram area.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260408104935.1A55A5969F6@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index f0f77cecc65..504d1c57085 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -146,6 +146,7 @@ static uint32_t make_filler(int bpp, uint32_t color)
 static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
+    unsigned int x, y, i, j, bypp = ctx->bpp / 8;
 
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -156,8 +157,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         return false;
     }
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
-        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
+        ctx->dst_bits >= ctx->vram_end - bypp ||
+        ctx->dst_bits + ctx->dst.x * bypp + (ctx->dst.y + ctx->dst.height) *
+        ctx->dst_stride >= ctx->vram_end - bypp) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
@@ -194,8 +196,9 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
-            ctx->src_bits >= ctx->vram_end || ctx->src_bits + vis_src.x +
-            (vis_src.y + vis_dst.height) * ctx->src_stride >= ctx->vram_end)) {
+            ctx->src_bits >= ctx->vram_end - bypp ||
+            ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
+            ctx->src_stride >= ctx->vram_end - bypp)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -240,7 +243,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             fallback = true;
         }
         if (fallback) {
-            unsigned int y, i, j, bypp = ctx->bpp / 8;
             for (y = 0; y < vis_dst.height; y++) {
                 i = vis_dst.x * bypp;
                 j = vis_src.x * bypp;
@@ -299,7 +301,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 #endif
         {
             /* fallback when pixman failed or we don't want to call it */
-            unsigned int x, y, i, bypp = ctx->bpp / 8;
             for (y = 0; y < vis_dst.height; y++) {
                 i = vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stride;
                 for (x = 0; x < vis_dst.width; x++, i += bypp) {
-- 
2.53.0


