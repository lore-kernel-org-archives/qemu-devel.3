Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A78CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7O-0000i8-Ea; Fri, 15 May 2026 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7N-0000gs-H2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7L-0001es-4S
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so45662025e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842205; x=1779447005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xJ+yo9Xpc/srgF3m90Tch2SAnTNWoA4B+R95BhJnzTs=;
 b=vWfT3cgbbic2/dK4fRIuUWV6QonZMLsXUn5zxH3OL+ECQiEu8bMrYXZry6kUuDrC8G
 Cb4m7Obf33DkxgWg7ZG10AhWsWYkz6AAvOIMsOERnL4vWDxSRGzM9NLdkeDJqkff+skp
 EwH2VqLjrBBdgJIA/AE2yslhzqpqpeFcYdOUhGvNewr11d8TJ32NXCQvD/sRJjQFhjGr
 uUGbpf8BqgmpLWolQcjtCWJz2QHqCp315MY1kgMAU/RqJDV+Z0E7QrP6Z5KVp5pagbWI
 hoZByjpLHY2AUCqE2ZXvejJKcWZfIDkGihRWgU6qOixbeDVe+NGLbybJiDwjgEbxIqEZ
 QfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842205; x=1779447005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xJ+yo9Xpc/srgF3m90Tch2SAnTNWoA4B+R95BhJnzTs=;
 b=huXWlDNrsPqXL9SaZh8Qxwr9YPB58zcxHasJLPc4N+H/h8IyaTHlUwKQeWTpMIW099
 Ad7J6qs3lY5iq6aqBXcpizkYbY6qnWEhsHMp2S5EMk/WLll0PJKl6M+2nmeKccojC4pv
 +hK1vtCrvvHdL2Ozys+Vlki+l6lLoabMgIWHnuWTG5sKmVnfxpjwukHdOTHOUVid16ud
 /EbB/65eWFmvOt8ffwv7uhZZUpoZPc13rd7AMY4zSb8+ivV+rx+/w0yQ3PnEoj7hpcCT
 1gRQRxZefJijHZ73HBtONoKTcwu3ve79ZYFIE3dxwmDVAE+2eKu01+0G0QVGsMRYbLqh
 OflQ==
X-Gm-Message-State: AOJu0Yys0CaPl1fm3KFgSQtII70wznhTN84zob0ms5A2Dgk9cHmw6+ZG
 iul4FVjNziX5ivXwx8m/rT4UEmsIhUicX+lnx5uZssp8xvkKNToRGvDKAWXyftw8c+ZRO5Eh4S8
 MohK/
X-Gm-Gg: Acq92OGsrXOVDZTebWGQ+CylOGa04bzhXrCudproz7CeqVqD9ZUJuz9kk8BIX7QZEUC
 4pm4KtlmmcvDonV7aAZQw3gkCMOQLmXLhW2YBRFGWe3GSEWpMFRB4ytrnjjrfHJpMUgPyaIYT6X
 X5QwORH+Uom50xZQPp9n/irxdRE3UYF5H1bn/BJU3ktKR9Ud7dMSN6TrjnpDtGc5EWhbC4oHVpw
 tk9wpFksoTqXOxRI8QqAbN2lPAPh2gtq6sn4C9c0OZqmjXMOLQq8wDjWkCtWRvL+ZczpN0jdKaU
 TozH54EhFVKBMOYIrVM1qFHUTOsbcGsLau+nSRSM1eYt53h7gu2laCQBFFSHnH+YgfTCiPZrCj+
 RlxCMOg1r5ew9aHQN8/7ibyuqdlaAS6/I37Ue9ks+YcKtc2sc4LXAEN3opMI5m13D1LCm85Ha3n
 wU8DBAqsSFcR5PzkneVgBx8OTUk1wdx8fXMvtwo/OOgg/eFvp7Lm01QDiBAImti52qQtsXTfDEg
 7DapM58yXRF5G9WplHQsJMYDEBnff0=
X-Received: by 2002:a05:600d:2:b0:48d:112c:f582 with SMTP id
 5b1f17b1804b1-48fe60ecd1amr34676245e9.11.1778842205351; 
 Fri, 15 May 2026 03:50:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] hw/display/exynos4210_fimd: Assume display surface is
 32bpp
Date: Fri, 15 May 2026 11:49:37 +0100
Message-ID: <20260515104945.4145203-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260508162013.2751001-5-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 62 ++----------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index aa94b29971..e715183ad5 100644
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


