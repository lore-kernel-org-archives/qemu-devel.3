Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B32CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNwA-0001O2-JM; Fri, 08 May 2026 12:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw7-0001MY-I4
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw5-0000y1-NA
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so1797659f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257220; x=1778862020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PtzGnpVjDazZsMTuEWeXTJxfwNGMpG9knZvWyMwkhQ=;
 b=G3Pe80YZUGdSrffvRbxPcuKcoT3Fb4+VbyjnZevDwjdimyMHeX94oGHtew0QL+3vcD
 xouybegJJbxby6rnnL9V6TldWHePVZEuewuFvcemh+16Puigf/cftoFm2/E7Oz0elqKg
 VkW+k1Ig7ZDQDoDiTM+hwba+CzB/UlkY+ukjPJWNJ2n3zL6FX3S2GC/aezk1/Bvi+Yrc
 iOwhQW7MvFtwW5Q0wIkO5pfAdhy8a/7GoX4p6gSqteKEhW/AjWuquoZJAtjRqN/9XmPC
 R1vFfJ20COV7makuoav2oNU4gt4Vd38L1SZ4qktQW07WpecfbysWhw4gOeqgqWpZPS0e
 O6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257220; x=1778862020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9PtzGnpVjDazZsMTuEWeXTJxfwNGMpG9knZvWyMwkhQ=;
 b=JlpOiDEw6VSU8cm0a0hnlmn/xNfP6qfeF7CeDl/4nzHIPDjOWD944f7HhvvzGy5HyO
 /S/Y4Q2eilLwAJWZMlbRII0BSFvaOaRRLyUqK5Q85FiDOrTfXuCisZq85XVVP/JLYMZH
 o07IZgGBEnCrMSe6MkeoPVUY8T3kEuWy5Pk9dh1q+D5yGuP0TERsGVCLmP1iKoTtlAKd
 jXF+O3tGKkaKRB8doNY1re1YXHeSPm8AIpPL3FVC4tF2BiJKdtZbDZ+1brQiu4Iu+Jaq
 0cNTnT+Ne40h+mhPfb2Ck+ty1+Tpi5dc3Qo4OqpMRJ5RQwmddUszWCtqIHMM32SOy/YV
 pCbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0p1wAnOVEwQxLBgx8Q/zRauX1CL4GyaDXiqczRVZSo2rjoa8qdseK589YHZnjw5BP1CfI0b8q42eM@nongnu.org
X-Gm-Message-State: AOJu0YxA0wCGHG8Re+QX5EvgIxgpM+NlY/M3aoxKa7OpvCn/8bAwY+B6
 bJgVX9x9Rk3AUIUrsJSWPUeok91Eu3RlFB7aRAZ4LKUa04Nds3qIKJ3R376MH9MreLk=
X-Gm-Gg: Acq92OGqRvelYMQ7l2E+M+ivAKO2BtH8Fi+RDlPq7EA9FnKo8ivRUHXIpAZijsEqCmg
 b88amLt6B8+fJvDVpfPT0/naxPdu4anZLAwkwMlkOrsWwtrnd4EHrQ6bBWcVOnU1oYNq/zXSSbq
 xS1TuI17gsZnT5Igj/ZgrmUNIKESh2aTWy4jg0rXP2syTPMBSRNB4Dpt9BYNOJUE1OW3JyhIOjP
 DQ4IG5mDCKF8xwtMNrQl29pDsXwfhNHiTSBbOU8BfUafHKeEvMUpoEGZPJrofwYqsYje4qTqnEp
 jING+SkZxVO9DDlLrjTy6D5qhGNGb92Gknul7Mo9nAJTXhmfzbmPawJUfqlg4NAjoVA+fiBmIzQ
 MXxO/h50sQti4VOHk7QmXdGhGv6RtJ+VXoENQZvKnbBt+0iwUmNyRdrQns9pl0dsEVPhVCxOykf
 CyOi+ur+Hn3lJnHucJOKUIa/gCzSeHK+0iAwi9S5cpASzfkl9/0s8QQqPGzAhnxFnkUZtK/TERy
 fGvl1g1WYxjBwOr0NiYRELc0MRLSJowPnRyzcMyfA==
X-Received: by 2002:a05:6000:1a85:b0:43d:26a2:f8c3 with SMTP id
 ffacd0b85a97d-4515d3dca3cmr20624415f8f.35.1778257219837; 
 Fri, 08 May 2026 09:20:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm6226998f8f.10.2026.05.08.09.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:20:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/display/exynos4210_fimd: Assume display surface is
 32bpp
Date: Fri,  8 May 2026 17:20:13 +0100
Message-ID: <20260508162013.2751001-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508162013.2751001-1-peter.maydell@linaro.org>
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

For a long time QEMU has guaranteed that the console surface is 32bpp
and not anything else.  This old display device still has code
assuming it might be something else.  Remove the code that made
put_pixel_toqemu a function pointer indirection, and use
put_to_qemufb_pixel32() directly.

This removes the last hw_error() in this file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 62 ++----------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 0c9e42ec52..daed85e22c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
 #include "exec/cpu-common.h"
@@ -867,37 +866,6 @@ static void draw_line_mapcolor(Exynos4210fimdWindow *w, uint8_t *src,
 }
 
 /* Write RGB to QEMU's GraphicConsole framebuffer */
-
-static int put_to_qemufb_pixel8(const rgba p, uint8_t *d)
-{
-    uint32_t pixel = rgb_to_pixel8(p.r, p.g, p.b);
-    *(uint8_t *)d = pixel;
-    return 1;
-}
-
-static int put_to_qemufb_pixel15(const rgba p, uint8_t *d)
-{
-    uint32_t pixel = rgb_to_pixel15(p.r, p.g, p.b);
-    *(uint16_t *)d = pixel;
-    return 2;
-}
-
-static int put_to_qemufb_pixel16(const rgba p, uint8_t *d)
-{
-    uint32_t pixel = rgb_to_pixel16(p.r, p.g, p.b);
-    *(uint16_t *)d = pixel;
-    return 2;
-}
-
-static int put_to_qemufb_pixel24(const rgba p, uint8_t *d)
-{
-    uint32_t pixel = rgb_to_pixel24(p.r, p.g, p.b);
-    *(uint8_t *)d++ = (pixel >>  0) & 0xFF;
-    *(uint8_t *)d++ = (pixel >>  8) & 0xFF;
-    *(uint8_t *)d++ = (pixel >> 16) & 0xFF;
-    return 3;
-}
-
 static int put_to_qemufb_pixel32(const rgba p, uint8_t *d)
 {
     uint32_t pixel = rgb_to_pixel24(p.r, p.g, p.b);
@@ -905,32 +873,6 @@ static int put_to_qemufb_pixel32(const rgba p, uint8_t *d)
     return 4;
 }
 
-/* Routine to copy pixel from internal buffer to QEMU buffer */
-static int (*put_pixel_toqemu)(const rgba p, uint8_t *pixel);
-static inline void fimd_update_putpix_qemu(int bpp)
-{
-    switch (bpp) {
-    case 8:
-        put_pixel_toqemu = put_to_qemufb_pixel8;
-        break;
-    case 15:
-        put_pixel_toqemu = put_to_qemufb_pixel15;
-        break;
-    case 16:
-        put_pixel_toqemu = put_to_qemufb_pixel16;
-        break;
-    case 24:
-        put_pixel_toqemu = put_to_qemufb_pixel24;
-        break;
-    case 32:
-        put_pixel_toqemu = put_to_qemufb_pixel32;
-        break;
-    default:
-        hw_error("exynos4210.fimd: unsupported BPP (%d)", bpp);
-        break;
-    }
-}
-
 /* Routine to copy a line from internal frame buffer to QEMU display */
 static void fimd_copy_line_toqemu(int width, uint8_t *src, uint8_t *dst)
 {
@@ -938,7 +880,7 @@ static void fimd_copy_line_toqemu(int width, uint8_t *src, uint8_t *dst)
 
     do {
         src += get_pixel_ifb(src, &p);
-        dst += put_pixel_toqemu(p, dst);
+        dst += put_to_qemufb_pixel32(p, dst);
     } while (--width);
 }
 
@@ -1336,7 +1278,7 @@ static bool exynos4210_fimd_update(void *opaque)
         int bpp;
 
         bpp = surface_bits_per_pixel(surface);
-        fimd_update_putpix_qemu(bpp);
+        assert(bpp == 32);
         bpp = (bpp + 1) >> 3;
         d = surface_data(surface);
         for (line = first_line; line <= last_line; line++) {
-- 
2.43.0


