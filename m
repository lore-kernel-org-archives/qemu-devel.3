Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1DBC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reew8-0004VS-0X; Mon, 26 Feb 2024 12:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevx-000482-N6
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevv-00078U-JN
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a8b79b46so4768735e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969109; x=1709573909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgxgQMnqYvptEpW+MzXMom2BVnIVN63/TeZ44omQsrM=;
 b=O7T4VvPJm7D5pdsxd+xAaXnu6CMYKatBtyMOfgwEaps97pB2eoaHlSSDEWbR7qHUIc
 9q4s+8g+CJqqn3ahFSw/YWn71PaYQH1OQGfv4yz8+wAX6hVCjCzl1NwLQxxlsWKBLaQ7
 T62fLpWARkx9sDqSGACqAYom+jVMHV52syJ7yp6Odqlg/T1SbymEE1G1KQlH1Xoih/EI
 S25+f0SZIHs4U9TKYGm4eLyvjOwAqgyb9kChXKWOR1uG4bZJ8XbUqtvZg72zlv8EUouE
 37UrmiSrM19em/caAV9J72TKr1WDlQvPtsA+iS2++2KmlyT8yvgamU6wmwP1OpGRAO0Q
 rFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969109; x=1709573909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgxgQMnqYvptEpW+MzXMom2BVnIVN63/TeZ44omQsrM=;
 b=Dm4OqmmMvauHrczX0qTs7LhmBBK1w8V6Lyn/UNW5ms+StDqJ4Do/L38c+g5zm/z2QJ
 2e+Zvp0OPX/czOjnYeWajLrjG0SmmsBGMRhDcBLYVzAlUL5mHW1mNJQQ77LHYm17aZbW
 ujPUyn2tDqRHTtE+xyy8LtZhtvAnxCv/YbJYT5IzTvBBE7vdjkyZv7UvqoZDPiscALVa
 BY1sX3YV8yIJ4jrpZBPT8n3rb/K9o8Lrpt1hTjMgArma7Ls/PcGRcxlBQLp99oRTA1qM
 r383mkYf8CdOFB+t4jcUGxgk9JjYhYaeXiCdLpcawd84k5Qo+c/V6av8MmoGB99+D6Nv
 I+Pw==
X-Gm-Message-State: AOJu0Yyza1+rr0YWG0xrORpOhj2TJLIbjwy+qvVsNiO5tMB61xTk5Sut
 2ya88IUofIjaKcZ/28TMiSNqqcJz/5Q9PXn18YJa5FXrBCHkXZFT84ypygBb2D/nuS5wQgLNxVN
 H
X-Google-Smtp-Source: AGHT+IHZHZByb62pRZtWr0x/5dB1MQCZrelDWtUmECOWCGKe2cNGvqvrzITTqaHZMp3/WG66jYRfkw==
X-Received: by 2002:a05:600c:35cc:b0:412:a72c:9d9c with SMTP id
 r12-20020a05600c35cc00b00412a72c9d9cmr1611244wmq.17.1708969109772; 
 Mon, 26 Feb 2024 09:38:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 11-20020a05600c234b00b00412704a0e4asm12527590wmq.2.2024.02.26.09.38.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 09:38:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/6] hw/display/exynos4210_fimd: Pass frame buffer memory
 region as link
Date: Mon, 26 Feb 2024 18:38:02 +0100
Message-ID: <20240226173805.289-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226173805.289-1-philmd@linaro.org>
References: <20240226173805.289-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the Exynos4210fimdState::'framebuffer-memory' property. Have
the board set it. We don't need to call sysbus_address_space()
anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/exynos4210.c          |  2 ++
 hw/display/exynos4210_fimd.c | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index ab18836943..e3f1de2631 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -770,6 +770,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /*** Display controller (FIMD) ***/
     dev = qdev_new("exynos4210.fimd");
+    object_property_set_link(OBJECT(dev), "framebuffer-memory",
+                             OBJECT(system_mem), &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_FIMD0_BASE_ADDR);
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 84687527d5..5712558e13 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
@@ -32,6 +33,7 @@
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 /* Debug messages configuration */
@@ -302,6 +304,7 @@ struct Exynos4210fimdState {
     MemoryRegion iomem;
     QemuConsole *console;
     qemu_irq irq[3];
+    MemoryRegion *fbmem;
 
     uint32_t vidcon[4];     /* Video main control registers 0-3 */
     uint32_t vidtcon[4];    /* Video time control registers 0-3 */
@@ -1119,7 +1122,6 @@ static void exynos4210_fimd_invalidate(void *opaque)
  * VIDOSDA, VIDOSDB, VIDWADDx and SHADOWCON registers */
 static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     Exynos4210fimdWindow *w = &s->window[win];
     hwaddr fb_start_addr, fb_mapped_len;
 
@@ -1147,8 +1149,7 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
         memory_region_unref(w->mem_section.mr);
     }
 
-    w->mem_section = memory_region_find(sysbus_address_space(sbd),
-                                        fb_start_addr, w->fb_len);
+    w->mem_section = memory_region_find(s->fbmem, fb_start_addr, w->fb_len);
     assert(w->mem_section.mr);
     assert(w->mem_section.offset_within_address_space == fb_start_addr);
     DPRINT_TRACE("Window %u framebuffer changed: address=0x%08x, len=0x%x\n",
@@ -1924,6 +1925,12 @@ static const GraphicHwOps exynos4210_fimd_ops = {
     .gfx_update  = exynos4210_fimd_update,
 };
 
+static Property exynos4210_fimd_properties[] = {
+    DEFINE_PROP_LINK("framebuffer-memory", Exynos4210fimdState, fbmem,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void exynos4210_fimd_init(Object *obj)
 {
     Exynos4210fimdState *s = EXYNOS4210_FIMD(obj);
@@ -1944,6 +1951,11 @@ static void exynos4210_fimd_realize(DeviceState *dev, Error **errp)
 {
     Exynos4210fimdState *s = EXYNOS4210_FIMD(dev);
 
+    if (!s->fbmem) {
+        error_setg(errp, "'framebuffer-memory' property was not set");
+        return;
+    }
+
     s->console = graphic_console_init(dev, 0, &exynos4210_fimd_ops, s);
 }
 
@@ -1954,6 +1966,7 @@ static void exynos4210_fimd_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &exynos4210_fimd_vmstate;
     dc->reset = exynos4210_fimd_reset;
     dc->realize = exynos4210_fimd_realize;
+    device_class_set_props(dc, exynos4210_fimd_properties);
 }
 
 static const TypeInfo exynos4210_fimd_info = {
-- 
2.41.0


