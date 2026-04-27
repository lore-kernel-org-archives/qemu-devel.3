Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F6FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUa-0008HR-3D; Mon, 27 Apr 2026 08:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-00087G-R2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-0005hk-Nl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso101474605e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294096; x=1777898896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xLiDu/iz5AsiqDXEjMsCtuoCWzBBhHTKjCH3+u/R2jY=;
 b=J5siPrjKN43LRkWd+ubuzJ413Fl4Z2hJ6VuS1n0u6U56GUR16DOWISMCVKPPv2BkGq
 I1TOvwAl7QsSNWVLxMKM8BF4dmEAuqCl5J6RIqZVO47l8NK5nmNp2F1Ozr0pwuhovHzI
 UlwhfPIGDH9yIFFZaMh1Or5i5C8A/EjLPfKv5CGjk924nfqX58ksf3u6/spSvus41qmd
 d0m0czGXYK1XG3fOmdL0CJdbS2QOpfl7k8wGmWlp/uwo7XNoFza6uwwCGseapZGSmchM
 isPUTtr+eH6iZmvdrMMRQ01TdnsqTw3RK3jIdCzVILQIIgGFhAQ9nuXxFbC0tiL4OEai
 2ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294096; x=1777898896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xLiDu/iz5AsiqDXEjMsCtuoCWzBBhHTKjCH3+u/R2jY=;
 b=UxUtuI6RSWeA92lk17wNaVz18MaIGc8qJU2DBw/ndawT1fb/Jm3Ch7T4FLMoKRlyEz
 aqIC6Mj9lp5xPxKdFPgVdD1djP1mLSw+Fhc2yFGKm1CUENx1TMGloiPzzqWELxpmq+oV
 FK6wh7/kheHdw55W3iE4w1b6p99Wmlay1q3Qi8sO3hOcdJTI3XRQctoEGm0JKyOTGXN6
 OQObpcJiXZE8lUn3ZxBPSDiw2riT0raIa9warqhtt6Oh+K9GuVJXzoN9QOAnKCaXp7WD
 wY3N7LRuv/i4wn54A3WTCWA3Pf7KfcQElhsfo9NcNdcsEEQfBmar+aZVHR9a9VVOHf1j
 2jVw==
X-Gm-Message-State: AOJu0YwvqrJdk3RlmsoL4pRkWbm335FAFOFp1O3dcYhmXUpmlYZ6v8fz
 rcGLHwFjl0E8y338cQnyeEG9bU7dZ4rzubtabyxE7wIEW98THCve2ia27HstPbDLe/mVAtiIprs
 gzwqA
X-Gm-Gg: AeBDieskSek9DxD2qDbIl9W8ePHTGKtM20S+YYXBDCgmqYPyrlbD+GDsJC7CzO18uXy
 Hgm85cAALNMVkKAhrC3lfaS0YcRYpLxkMPjFOgBDquYhs/ToXvMmMpEKIfxSO/1Y+MgYGln3XjJ
 LP/hneK6JdLn1rKqRG1BOMCvZd9gAVGjXwBRG1K8wOCf7Z51euCUeRRH5oGBeQK7AtqnB4M1gwR
 rZY16eaMbpl2b13kbMAEtYarvtbbhy/DewOx6kF56rCUlLMCKP0bt+69RXB84YBjFqRnEFCSsT9
 3NHHgJFZHWzmh3bn7nNOwj6YBBE8Ykguu6fYZU/3fwHQ/BIL6xprQcrnnCpzUWgGsiv4tRL+vV6
 q3GjLYvLSHi3gkkL9tNfuvLguD27tWdikJrWHY45QAsRXQXi2dKFh/xYm64b7laleLcr2EQFqeI
 zcElSBdaqh7v/IPg8sIflAI69GtdbTSraR1loHgjomXALBcIJl+3dO3LFG2Cplf4WhFfACi+gTd
 Lzzf4Gm9BSZB4mOefU8BW71MWo1ubhZqchfqcfZPlTPq+LIqHt2
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a53ea1500mr320879035e9.2.1777294095819; 
 Mon, 27 Apr 2026 05:48:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/63] hw/display: Add i.MX6UL LCDIF device model
Date: Mon, 27 Apr 2026 13:47:13 +0100
Message-ID: <20260427124738.966578-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

From: Yucai Liu <1486344514@qq.com>

Implement a basic i.MX6UL LCDIF controller model with MMIO registers,
frame-done interrupt behavior, and framebuffer-backed display updates
for RGB565 and XRGB8888 input formats.

Place the LCDIF device under hw/display and build it via a dedicated
CONFIG_IMX6UL_LCDIF symbol. Model register fields with
registerfields.h helpers and provide migration support via vmstate.

Signed-off-by: Yucai Liu <1486344514@qq.com>
Message-id: 20260412110240.93116-2-yangyanglan718@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                       |   2 +
 hw/display/Kconfig                |   4 +
 hw/display/imx6ul_lcdif.c         | 453 ++++++++++++++++++++++++++++++
 hw/display/meson.build            |   1 +
 include/hw/display/imx6ul_lcdif.h |  37 +++
 5 files changed, 497 insertions(+)
 create mode 100644 hw/display/imx6ul_lcdif.c
 create mode 100644 include/hw/display/imx6ul_lcdif.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 50a8e161c6..a23ff5279e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,8 +894,10 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx6ul-evk.c
 F: hw/arm/fsl-imx6ul.c
+F: hw/display/imx6ul_lcdif.c
 F: hw/misc/imx6ul_ccm.c
 F: include/hw/arm/fsl-imx6ul.h
+F: include/hw/display/imx6ul_lcdif.h
 F: include/hw/misc/imx6ul_ccm.h
 F: docs/system/arm/mcimx6ul-evk.rst
 
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1e95ab28ef..b3593fe981 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -25,6 +25,10 @@ config PL110
     bool
     select FRAMEBUFFER
 
+config IMX6UL_LCDIF
+    bool
+    select FRAMEBUFFER
+
 config SII9022
     bool
     depends on I2C
diff --git a/hw/display/imx6ul_lcdif.c b/hw/display/imx6ul_lcdif.c
new file mode 100644
index 0000000000..33cd00fbe1
--- /dev/null
+++ b/hw/display/imx6ul_lcdif.c
@@ -0,0 +1,453 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/display/imx6ul_lcdif.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/display/framebuffer.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "ui/pixel_ops.h"
+
+#define LCDIF_MMIO_SIZE             (16 * KiB)
+#define LCDIF_RESET_CTRL1           0x000f0000
+
+REG32(CTRL, 0x00)
+    FIELD(CTRL, RUN, 0, 1)
+    FIELD(CTRL, WORD_LENGTH, 8, 2)
+REG32(CTRL1, 0x10)
+    FIELD(CTRL1, CUR_FRAME_DONE_IRQ, 9, 1)
+    FIELD(CTRL1, CUR_FRAME_DONE_IRQ_EN, 13, 1)
+    FIELD(CTRL1, BYTE_PACKING_FORMAT, 16, 4)
+REG32(V4_TRANSFER_COUNT, 0x30)
+    FIELD(V4_TRANSFER_COUNT, H_COUNT, 0, 16)
+    FIELD(V4_TRANSFER_COUNT, V_COUNT, 16, 16)
+REG32(V4_CUR_BUF, 0x40)
+REG32(V4_NEXT_BUF, 0x50)
+REG32(AS_NEXT_BUF, 0x230)
+
+#define REG_SET                     0x4
+#define REG_CLR                     0x8
+#define REG_TOG                     0xc
+
+#define CTRL_WORD_LENGTH_16         0
+#define CTRL_WORD_LENGTH_24         3
+
+#define FRAME_PERIOD_NS             (16 * 1000 * 1000ULL)
+
+enum IMX6ULLCDIFReg {
+    IMX6UL_LCDIF_REG_CTRL = A_CTRL >> 4,
+    IMX6UL_LCDIF_REG_CTRL1 = A_CTRL1 >> 4,
+    IMX6UL_LCDIF_REG_V4_TRANSFER_COUNT = A_V4_TRANSFER_COUNT >> 4,
+    IMX6UL_LCDIF_REG_V4_CUR_BUF = A_V4_CUR_BUF >> 4,
+    IMX6UL_LCDIF_REG_V4_NEXT_BUF = A_V4_NEXT_BUF >> 4,
+    IMX6UL_LCDIF_REG_AS_NEXT_BUF = A_AS_NEXT_BUF >> 4,
+};
+
+static inline bool imx6ul_lcdif_reg_exists(hwaddr reg)
+{
+    return (reg >> 4) < IMX6UL_LCDIF_REGS_NUM;
+}
+
+static inline bool imx6ul_lcdif_reg_has_setclr(hwaddr reg)
+{
+    switch (reg) {
+    case A_CTRL:
+    case A_CTRL1:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static inline bool imx6ul_lcdif_is_running(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl = s->regs[IMX6UL_LCDIF_REG_CTRL];
+
+    return FIELD_EX32(ctrl, CTRL, RUN);
+}
+
+static inline bool imx6ul_lcdif_frame_done_pending(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = s->regs[IMX6UL_LCDIF_REG_CTRL1];
+
+    return FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
+}
+
+static void imx6ul_lcdif_schedule_frame(IMX6ULLCDIFState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    timer_mod(s->frame_timer, now + FRAME_PERIOD_NS);
+}
+
+static void imx6ul_lcdif_maybe_schedule_frame(IMX6ULLCDIFState *s)
+{
+    if (imx6ul_lcdif_is_running(s) && !imx6ul_lcdif_frame_done_pending(s)) {
+        imx6ul_lcdif_schedule_frame(s);
+    } else {
+        timer_del(s->frame_timer);
+    }
+}
+
+static void imx6ul_lcdif_update_irq(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = s->regs[IMX6UL_LCDIF_REG_CTRL1];
+    bool level = FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ_EN) &&
+                 FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void imx6ul_lcdif_frame_done(IMX6ULLCDIFState *s)
+{
+    uint32_t ctrl1 = s->regs[IMX6UL_LCDIF_REG_CTRL1];
+
+    ctrl1 = FIELD_DP32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ, 1);
+    s->regs[IMX6UL_LCDIF_REG_CTRL1] = ctrl1;
+    imx6ul_lcdif_update_irq(s);
+}
+
+static void imx6ul_lcdif_draw_line_rgb565(void *opaque, uint8_t *dst,
+                                          const uint8_t *src, int width,
+                                          int dststep)
+{
+    uint32_t *dst32 = (uint32_t *)dst;
+    int i;
+
+    for (i = 0; i < width; i++) {
+        uint16_t pixel = lduw_le_p(src);
+        uint8_t r = ((pixel >> 11) & 0x1f) << 3;
+        uint8_t g = ((pixel >> 5) & 0x3f) << 2;
+        uint8_t b = (pixel & 0x1f) << 3;
+
+        *dst32++ = rgb_to_pixel32(r, g, b);
+        src += 2;
+    }
+}
+
+static void imx6ul_lcdif_draw_line_xrgb8888(void *opaque, uint8_t *dst,
+                                            const uint8_t *src, int width,
+                                            int dststep)
+{
+    uint32_t *dst32 = (uint32_t *)dst;
+    int i;
+
+    for (i = 0; i < width; i++) {
+        uint32_t pixel = ldl_le_p(src);
+        uint8_t r = (pixel >> 16) & 0xff;
+        uint8_t g = (pixel >> 8) & 0xff;
+        uint8_t b = pixel & 0xff;
+
+        *dst32++ = rgb_to_pixel32(r, g, b);
+        src += 4;
+    }
+}
+
+static void imx6ul_lcdif_update_display(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+    uint32_t transfer_count = s->regs[IMX6UL_LCDIF_REG_V4_TRANSFER_COUNT];
+    uint32_t width = FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, H_COUNT);
+    uint32_t height = FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, V_COUNT);
+    uint32_t ctrl = s->regs[IMX6UL_LCDIF_REG_CTRL];
+    uint32_t frame_base = s->regs[IMX6UL_LCDIF_REG_V4_CUR_BUF];
+    drawfn fn;
+    int first = 0;
+    int last = 0;
+    int src_width;
+
+    if (!imx6ul_lcdif_is_running(s) || width == 0 || height == 0) {
+        return;
+    }
+
+    switch (FIELD_EX32(ctrl, CTRL, WORD_LENGTH)) {
+    case CTRL_WORD_LENGTH_16:
+        s->src_bpp = 2;
+        fn = imx6ul_lcdif_draw_line_rgb565;
+        break;
+    case CTRL_WORD_LENGTH_24:
+        s->src_bpp = 4;
+        fn = imx6ul_lcdif_draw_line_xrgb8888;
+        break;
+    default:
+        return;
+    }
+
+    if (surface_width(surface) != width || surface_height(surface) != height) {
+        qemu_console_resize(s->con, width, height);
+        surface = qemu_console_surface(s->con);
+        s->invalidate = true;
+    }
+
+    src_width = width * s->src_bpp;
+    if (s->invalidate || s->fb_base != frame_base ||
+        s->src_width != src_width || s->rows != height) {
+        framebuffer_update_memory_section(&s->fbsection, get_system_memory(),
+                                          frame_base, height, src_width);
+        s->fb_base = frame_base;
+        s->src_width = src_width;
+        s->rows = height;
+    }
+
+    framebuffer_update_display(surface, &s->fbsection, width, height,
+                               src_width, surface_stride(surface), 0,
+                               s->invalidate, fn, s, &first, &last);
+    if (first >= 0) {
+        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
+    }
+
+    s->invalidate = false;
+}
+
+static void imx6ul_lcdif_invalidate_display(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    s->invalidate = true;
+}
+
+static const GraphicHwOps imx6ul_lcdif_graphic_ops = {
+    .invalidate = imx6ul_lcdif_invalidate_display,
+    .gfx_update = imx6ul_lcdif_update_display,
+};
+
+static void imx6ul_lcdif_frame_timer_cb(void *opaque)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    if (!imx6ul_lcdif_is_running(s) || imx6ul_lcdif_frame_done_pending(s)) {
+        return;
+    }
+
+    imx6ul_lcdif_frame_done(s);
+}
+
+static uint64_t imx6ul_lcdif_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+    hwaddr reg = offset & ~0xf;
+    uint32_t idx;
+
+    assert(size == 4);
+    assert(!(offset & 0x3));
+    assert(offset < LCDIF_MMIO_SIZE);
+
+    idx = reg >> 4;
+    if (idx >= ARRAY_SIZE(s->regs)) {
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void imx6ul_lcdif_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    IMX6ULLCDIFState *s = opaque;
+    hwaddr reg = offset & ~0xf;
+    uint32_t idx;
+    uint32_t oldv;
+
+    assert(size == 4);
+    assert(!(offset & 0x3));
+    assert(offset < LCDIF_MMIO_SIZE);
+
+    if (!imx6ul_lcdif_reg_exists(reg)) {
+        return;
+    }
+
+    idx = reg >> 4;
+    oldv = s->regs[idx];
+
+    switch (offset & 0xf) {
+    case 0:
+        s->regs[idx] = (uint32_t)value;
+        break;
+    case REG_SET:
+        if (!imx6ul_lcdif_reg_has_setclr(reg)) {
+            return;
+        }
+        s->regs[idx] = oldv | (uint32_t)value;
+        break;
+    case REG_CLR:
+        if (!imx6ul_lcdif_reg_has_setclr(reg)) {
+            return;
+        }
+        s->regs[idx] = oldv & ~(uint32_t)value;
+        break;
+    case REG_TOG:
+        if (!imx6ul_lcdif_reg_has_setclr(reg)) {
+            return;
+        }
+        s->regs[idx] = oldv ^ (uint32_t)value;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    switch (reg) {
+    case A_CTRL:
+        if (!FIELD_EX32(oldv, CTRL, RUN) &&
+            FIELD_EX32(s->regs[idx], CTRL, RUN)) {
+            s->invalidate = true;
+            graphic_hw_invalidate(s->con);
+            imx6ul_lcdif_maybe_schedule_frame(s);
+            break;
+        }
+        if (FIELD_EX32(oldv, CTRL, RUN) &&
+            !FIELD_EX32(s->regs[idx], CTRL, RUN)) {
+            timer_del(s->frame_timer);
+        }
+        break;
+    case A_CTRL1:
+        if (FIELD_EX32(oldv, CTRL1, CUR_FRAME_DONE_IRQ) &&
+            !FIELD_EX32(s->regs[idx], CTRL1, CUR_FRAME_DONE_IRQ)) {
+            imx6ul_lcdif_maybe_schedule_frame(s);
+        }
+        break;
+    case A_V4_TRANSFER_COUNT:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case A_V4_CUR_BUF:
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        break;
+    case A_V4_NEXT_BUF:
+        s->regs[IMX6UL_LCDIF_REG_V4_CUR_BUF] = s->regs[idx];
+        imx6ul_lcdif_frame_done(s);
+        s->invalidate = true;
+        graphic_hw_invalidate(s->con);
+        imx6ul_lcdif_maybe_schedule_frame(s);
+        return;
+    case A_AS_NEXT_BUF:
+        imx6ul_lcdif_frame_done(s);
+        imx6ul_lcdif_maybe_schedule_frame(s);
+        return;
+    default:
+        break;
+    }
+
+    imx6ul_lcdif_update_irq(s);
+}
+
+static const MemoryRegionOps imx6ul_lcdif_ops = {
+    .read = imx6ul_lcdif_read,
+    .write = imx6ul_lcdif_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx6ul_lcdif_reset(DeviceState *dev)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[IMX6UL_LCDIF_REG_CTRL1] = LCDIF_RESET_CTRL1;
+    s->fb_base = 0;
+    s->src_width = 0;
+    s->rows = 0;
+    s->src_bpp = 0;
+    s->invalidate = true;
+    timer_del(s->frame_timer);
+    imx6ul_lcdif_update_irq(s);
+}
+
+static int imx6ul_lcdif_post_load(void *opaque, int version_id)
+{
+    IMX6ULLCDIFState *s = opaque;
+
+    s->fb_base = 0;
+    s->src_width = 0;
+    s->rows = 0;
+    s->src_bpp = 0;
+    s->invalidate = true;
+
+    imx6ul_lcdif_update_irq(s);
+    if (imx6ul_lcdif_is_running(s) &&
+        !imx6ul_lcdif_frame_done_pending(s) &&
+        !timer_pending(s->frame_timer)) {
+        imx6ul_lcdif_schedule_frame(s);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_imx6ul_lcdif = {
+    .name = TYPE_IMX6UL_LCDIF,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = imx6ul_lcdif_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX6ULLCDIFState, IMX6UL_LCDIF_REGS_NUM),
+        VMSTATE_TIMER_PTR(frame_timer, IMX6ULLCDIFState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx6ul_lcdif_realize(DeviceState *dev, Error **errp)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
+
+    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                  imx6ul_lcdif_frame_timer_cb, s);
+    s->invalidate = true;
+    memory_region_init_io(&s->iomem, OBJECT(dev), &imx6ul_lcdif_ops, s,
+                          TYPE_IMX6UL_LCDIF, LCDIF_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    s->con = graphic_console_init(dev, 0, &imx6ul_lcdif_graphic_ops, s);
+}
+
+static void imx6ul_lcdif_unrealize(DeviceState *dev)
+{
+    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
+
+    timer_del(s->frame_timer);
+    timer_free(s->frame_timer);
+    s->frame_timer = NULL;
+
+    if (s->con) {
+        graphic_console_close(s->con);
+        s->con = NULL;
+    }
+}
+
+static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = imx6ul_lcdif_realize;
+    dc->unrealize = imx6ul_lcdif_unrealize;
+    dc->vmsd = &vmstate_imx6ul_lcdif;
+    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
+    dc->desc = "i.MX6UL LCDIF";
+}
+
+static const TypeInfo imx6ul_lcdif_info = {
+    .name = TYPE_IMX6UL_LCDIF,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX6ULLCDIFState),
+    .class_init = imx6ul_lcdif_class_init,
+};
+
+static void imx6ul_lcdif_register_types(void)
+{
+    type_register_static(&imx6ul_lcdif_info);
+}
+
+type_init(imx6ul_lcdif_register_types)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index e730c289b1..ffecedbf70 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -12,6 +12,7 @@ system_ss.add(when: ['CONFIG_VGA_CIRRUS', 'CONFIG_VGA_ISA'], if_true: files('cir
 system_ss.add(when: 'CONFIG_G364FB', if_true: files('g364fb.c'))
 system_ss.add(when: 'CONFIG_JAZZ_LED', if_true: files('jazz_led.c'))
 system_ss.add(when: 'CONFIG_PL110', if_true: files('pl110.c'))
+system_ss.add(when: 'CONFIG_IMX6UL_LCDIF', if_true: files('imx6ul_lcdif.c'))
 system_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
 system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
 system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
diff --git a/include/hw/display/imx6ul_lcdif.h b/include/hw/display/imx6ul_lcdif.h
new file mode 100644
index 0000000000..42fee2fd1d
--- /dev/null
+++ b/include/hw/display/imx6ul_lcdif.h
@@ -0,0 +1,37 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * i.MX6UL LCDIF controller
+ *
+ * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
+ */
+
+#ifndef IMX6UL_LCDIF_H
+#define IMX6UL_LCDIF_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/timer.h"
+#include "ui/console.h"
+
+#define TYPE_IMX6UL_LCDIF "imx6ul-lcdif"
+#define IMX6UL_LCDIF_REGS_NUM ((0x230 >> 4) + 1)
+OBJECT_DECLARE_SIMPLE_TYPE(IMX6ULLCDIFState, IMX6UL_LCDIF)
+
+struct IMX6ULLCDIFState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    MemoryRegionSection fbsection;
+    qemu_irq irq;
+    QemuConsole *con;
+    QEMUTimer *frame_timer;
+    uint32_t fb_base;
+    uint32_t src_width;
+    uint32_t rows;
+    uint8_t src_bpp;
+    bool invalidate;
+    uint32_t regs[IMX6UL_LCDIF_REGS_NUM];
+};
+
+#endif /* IMX6UL_LCDIF_H */
-- 
2.43.0


