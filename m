Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB56CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfvC-0006qM-32; Tue, 01 Oct 2024 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfun-0005it-4C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuf-0006AQ-1Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so70642205e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800787; x=1728405587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K5CAF3xeZNgN75dseT+ocleLwhFg2QpwVKYO8jUGrF0=;
 b=OMorRqfboXn7bjd9pt8N4Kv1VWFI2clPVlaZKth/chWlxSPYmBFS4EduolBIW2xS+6
 pvDQh8xLiIe+w2nJTPayGg0F0+++K8Towjv/3spQeQPQ5aSwxwXMu/WGVwIBoXDJ1Y/a
 SnP1GOek9bbQ0I8HWcCYGllzaEcck+OvME02Y2tJK9YYnd3kXr0LRBJ7WFaiVyntD5Hm
 NvBey/PJFIeVJYi7klERvEXVsfw5Z+GFEJavPQl6+YYVNuH8pssSxUuNIkrx9VGSkIEq
 vDVuKtdOKldlFShOGpqgAAPmIMkPuIxHwQIg0HeIkxxTvDeAESCiBhH9ROrGlPphsF2q
 KWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800787; x=1728405587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5CAF3xeZNgN75dseT+ocleLwhFg2QpwVKYO8jUGrF0=;
 b=WU2Y+L1TBG94NopW193xU1DizUFmie/iJdIWbd7gMAssxvCJ92SDcMZA+3ir7pbFjA
 8PpXuZQSVZdhrnrxM+S9LBYtCyeOdcoIOBZF+ypwEm9SUt1Sge3D7OA9jzimXZWo1SuR
 pm5mWup5x/AqyC4t31NJi9jkG0TvJE7QjNuIdTzxWaIuy+dl/wm7SCz7I/+lmDhsijuP
 th8VMokLyKnlBojj6PdzonlR3/GGVWj5XCeKaoOB/3UjhwPG9wpe8HA/t5r7AXTmdz2z
 ZrjUd/n+2d71cAc92zZmDSx0aH2yQONg8IIaXCG5tfuEaC1WmAN4DIaXFa1FKXzmE76o
 cEVA==
X-Gm-Message-State: AOJu0YwVBQCheq3ETinXlYG1XlE/iY1ENyLKo1dwldyqkcDbumw2d1X4
 XmpsMWFOPwaI7jv8gA9SPDQK41jyzP+m0IFi7b+oSMYSqagqND1D5Dg6grmyTL2zGZBlSEhAvqL
 E
X-Google-Smtp-Source: AGHT+IF37jcr4accTh9HK7lAcvzqoYhtkiWusGUK9DodTqu2epVSoMTU7X/reqAIm/bexMeIHUUX0A==
X-Received: by 2002:a05:600c:3c9b:b0:42c:c8be:4215 with SMTP id
 5b1f17b1804b1-42f777b0cc1mr1316725e9.4.1727800787284; 
 Tue, 01 Oct 2024 09:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/54] hw/display: Remove omap_dss
Date: Tue,  1 Oct 2024 17:39:14 +0100
Message-Id: <20241001163918.1275441-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The omap_dss device is OMAP2 only, and we are removing it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240903160751.4100218-50-peter.maydell@linaro.org
---
 include/hw/arm/omap.h  |   19 -
 hw/display/omap_dss.c  | 1093 ----------------------------------------
 hw/display/meson.build |    1 -
 3 files changed, 1113 deletions(-)
 delete mode 100644 hw/display/omap_dss.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 82721b46fa0..2300b97716d 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -734,23 +734,6 @@ struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
                                         struct omap_dma_lcd_channel_s *dma,
                                         omap_clk clk);
 
-/* omap_dss.c */
-struct rfbi_chip_s {
-    void *opaque;
-    void (*write)(void *opaque, int dc, uint16_t value);
-    void (*block)(void *opaque, int dc, void *buf, size_t len, int pitch);
-    uint16_t (*read)(void *opaque, int dc);
-};
-struct omap_dss_s;
-void omap_dss_reset(struct omap_dss_s *s);
-struct omap_dss_s *omap_dss_init(struct omap_target_agent_s *ta,
-                MemoryRegion *sysmem,
-                hwaddr l3_base,
-                qemu_irq irq, qemu_irq drq,
-                omap_clk fck1, omap_clk fck2, omap_clk ck54m,
-                omap_clk ick1, omap_clk ick2);
-void omap_rfbi_attach(struct omap_dss_s *s, int cs, struct rfbi_chip_s *chip);
-
 /* omap_mmc.c */
 struct omap_mmc_s;
 struct omap_mmc_s *omap_mmc_init(hwaddr base,
@@ -910,8 +893,6 @@ struct omap_mpu_state_s {
 
     /* OMAP2-only peripherals */
     struct omap_l4_s *l4;
-
-    struct omap_dss_s *dss;
 };
 
 /* omap1.c */
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
deleted file mode 100644
index f33fc7606d3..00000000000
--- a/hw/display/omap_dss.c
+++ /dev/null
@@ -1,1093 +0,0 @@
-/*
- * OMAP2 Display Subsystem.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "hw/hw.h"
-#include "hw/irq.h"
-#include "ui/console.h"
-#include "hw/arm/omap.h"
-
-struct omap_dss_s {
-    qemu_irq irq;
-    qemu_irq drq;
-    DisplayState *state;
-    MemoryRegion iomem_diss1, iomem_disc1, iomem_rfbi1, iomem_venc1, iomem_im3;
-
-    int autoidle;
-    int control;
-    int enable;
-
-    struct omap_dss_panel_s {
-        int enable;
-        int nx;
-        int ny;
-
-        int x;
-        int y;
-    } dig, lcd;
-
-    struct {
-        uint32_t idlemode;
-        uint32_t irqst;
-        uint32_t irqen;
-        uint32_t control;
-        uint32_t config;
-        uint32_t capable;
-        uint32_t timing[4];
-        int line;
-        uint32_t bg[2];
-        uint32_t trans[2];
-
-        struct omap_dss_plane_s {
-            int enable;
-            int bpp;
-            int posx;
-            int posy;
-            int nx;
-            int ny;
-
-            hwaddr addr[3];
-
-            uint32_t attr;
-            uint32_t tresh;
-            int rowinc;
-            int colinc;
-            int wininc;
-        } l[3];
-
-        int invalidate;
-        uint16_t palette[256];
-    } dispc;
-
-    struct {
-        int idlemode;
-        uint32_t control;
-        int enable;
-        int pixels;
-        int busy;
-        int skiplines;
-        uint16_t rxbuf;
-        uint32_t config[2];
-        uint32_t time[4];
-        uint32_t data[6];
-        uint16_t vsync;
-        uint16_t hsync;
-        struct rfbi_chip_s *chip[2];
-    } rfbi;
-};
-
-static void omap_dispc_interrupt_update(struct omap_dss_s *s)
-{
-    qemu_set_irq(s->irq, s->dispc.irqst & s->dispc.irqen);
-}
-
-static void omap_rfbi_reset(struct omap_dss_s *s)
-{
-    s->rfbi.idlemode = 0;
-    s->rfbi.control = 2;
-    s->rfbi.enable = 0;
-    s->rfbi.pixels = 0;
-    s->rfbi.skiplines = 0;
-    s->rfbi.busy = 0;
-    s->rfbi.config[0] = 0x00310000;
-    s->rfbi.config[1] = 0x00310000;
-    s->rfbi.time[0] = 0;
-    s->rfbi.time[1] = 0;
-    s->rfbi.time[2] = 0;
-    s->rfbi.time[3] = 0;
-    s->rfbi.data[0] = 0;
-    s->rfbi.data[1] = 0;
-    s->rfbi.data[2] = 0;
-    s->rfbi.data[3] = 0;
-    s->rfbi.data[4] = 0;
-    s->rfbi.data[5] = 0;
-    s->rfbi.vsync = 0;
-    s->rfbi.hsync = 0;
-}
-
-void omap_dss_reset(struct omap_dss_s *s)
-{
-    s->autoidle = 0;
-    s->control = 0;
-    s->enable = 0;
-
-    s->dig.enable = 0;
-    s->dig.nx = 1;
-    s->dig.ny = 1;
-
-    s->lcd.enable = 0;
-    s->lcd.nx = 1;
-    s->lcd.ny = 1;
-
-    s->dispc.idlemode = 0;
-    s->dispc.irqst = 0;
-    s->dispc.irqen = 0;
-    s->dispc.control = 0;
-    s->dispc.config = 0;
-    s->dispc.capable = 0x161;
-    s->dispc.timing[0] = 0;
-    s->dispc.timing[1] = 0;
-    s->dispc.timing[2] = 0;
-    s->dispc.timing[3] = 0;
-    s->dispc.line = 0;
-    s->dispc.bg[0] = 0;
-    s->dispc.bg[1] = 0;
-    s->dispc.trans[0] = 0;
-    s->dispc.trans[1] = 0;
-
-    s->dispc.l[0].enable = 0;
-    s->dispc.l[0].bpp = 0;
-    s->dispc.l[0].addr[0] = 0;
-    s->dispc.l[0].addr[1] = 0;
-    s->dispc.l[0].addr[2] = 0;
-    s->dispc.l[0].posx = 0;
-    s->dispc.l[0].posy = 0;
-    s->dispc.l[0].nx = 1;
-    s->dispc.l[0].ny = 1;
-    s->dispc.l[0].attr = 0;
-    s->dispc.l[0].tresh = 0;
-    s->dispc.l[0].rowinc = 1;
-    s->dispc.l[0].colinc = 1;
-    s->dispc.l[0].wininc = 0;
-
-    omap_rfbi_reset(s);
-    omap_dispc_interrupt_update(s);
-}
-
-static uint64_t omap_diss_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:  /* DSS_REVISIONNUMBER */
-        return 0x20;
-
-    case 0x10:  /* DSS_SYSCONFIG */
-        return s->autoidle;
-
-    case 0x14:  /* DSS_SYSSTATUS */
-        return 1;                       /* RESETDONE */
-
-    case 0x40:  /* DSS_CONTROL */
-        return s->control;
-
-    case 0x50:  /* DSS_PSA_LCD_REG_1 */
-    case 0x54:  /* DSS_PSA_LCD_REG_2 */
-    case 0x58:  /* DSS_PSA_VIDEO_REG */
-        /* TODO: fake some values when appropriate s->control bits are set */
-        return 0;
-
-    case 0x5c:  /* DSS_STATUS */
-        return 1 + (s->control & 1);
-
-    default:
-        break;
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_diss_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x00:  /* DSS_REVISIONNUMBER */
-    case 0x14:  /* DSS_SYSSTATUS */
-    case 0x50:  /* DSS_PSA_LCD_REG_1 */
-    case 0x54:  /* DSS_PSA_LCD_REG_2 */
-    case 0x58:  /* DSS_PSA_VIDEO_REG */
-    case 0x5c:  /* DSS_STATUS */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x10:  /* DSS_SYSCONFIG */
-        if (value & 2)                      /* SOFTRESET */
-            omap_dss_reset(s);
-        s->autoidle = value & 1;
-        break;
-
-    case 0x40:  /* DSS_CONTROL */
-        s->control = value & 0x3dd;
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_diss_ops = {
-    .read = omap_diss_read,
-    .write = omap_diss_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static uint64_t omap_disc_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x000: /* DISPC_REVISION */
-        return 0x20;
-
-    case 0x010: /* DISPC_SYSCONFIG */
-        return s->dispc.idlemode;
-
-    case 0x014: /* DISPC_SYSSTATUS */
-        return 1;                       /* RESETDONE */
-
-    case 0x018: /* DISPC_IRQSTATUS */
-        return s->dispc.irqst;
-
-    case 0x01c: /* DISPC_IRQENABLE */
-        return s->dispc.irqen;
-
-    case 0x040: /* DISPC_CONTROL */
-        return s->dispc.control;
-
-    case 0x044: /* DISPC_CONFIG */
-        return s->dispc.config;
-
-    case 0x048: /* DISPC_CAPABLE */
-        return s->dispc.capable;
-
-    case 0x04c: /* DISPC_DEFAULT_COLOR0 */
-        return s->dispc.bg[0];
-    case 0x050: /* DISPC_DEFAULT_COLOR1 */
-        return s->dispc.bg[1];
-    case 0x054: /* DISPC_TRANS_COLOR0 */
-        return s->dispc.trans[0];
-    case 0x058: /* DISPC_TRANS_COLOR1 */
-        return s->dispc.trans[1];
-
-    case 0x05c: /* DISPC_LINE_STATUS */
-        return 0x7ff;
-    case 0x060: /* DISPC_LINE_NUMBER */
-        return s->dispc.line;
-
-    case 0x064: /* DISPC_TIMING_H */
-        return s->dispc.timing[0];
-    case 0x068: /* DISPC_TIMING_V */
-        return s->dispc.timing[1];
-    case 0x06c: /* DISPC_POL_FREQ */
-        return s->dispc.timing[2];
-    case 0x070: /* DISPC_DIVISOR */
-        return s->dispc.timing[3];
-
-    case 0x078: /* DISPC_SIZE_DIG */
-        return ((s->dig.ny - 1) << 16) | (s->dig.nx - 1);
-    case 0x07c: /* DISPC_SIZE_LCD */
-        return ((s->lcd.ny - 1) << 16) | (s->lcd.nx - 1);
-
-    case 0x080: /* DISPC_GFX_BA0 */
-        return s->dispc.l[0].addr[0];
-    case 0x084: /* DISPC_GFX_BA1 */
-        return s->dispc.l[0].addr[1];
-    case 0x088: /* DISPC_GFX_POSITION */
-        return (s->dispc.l[0].posy << 16) | s->dispc.l[0].posx;
-    case 0x08c: /* DISPC_GFX_SIZE */
-        return ((s->dispc.l[0].ny - 1) << 16) | (s->dispc.l[0].nx - 1);
-    case 0x0a0: /* DISPC_GFX_ATTRIBUTES */
-        return s->dispc.l[0].attr;
-    case 0x0a4: /* DISPC_GFX_FIFO_TRESHOLD */
-        return s->dispc.l[0].tresh;
-    case 0x0a8: /* DISPC_GFX_FIFO_SIZE_STATUS */
-        return 256;
-    case 0x0ac: /* DISPC_GFX_ROW_INC */
-        return s->dispc.l[0].rowinc;
-    case 0x0b0: /* DISPC_GFX_PIXEL_INC */
-        return s->dispc.l[0].colinc;
-    case 0x0b4: /* DISPC_GFX_WINDOW_SKIP */
-        return s->dispc.l[0].wininc;
-    case 0x0b8: /* DISPC_GFX_TABLE_BA */
-        return s->dispc.l[0].addr[2];
-
-    case 0x0bc: /* DISPC_VID1_BA0 */
-    case 0x0c0: /* DISPC_VID1_BA1 */
-    case 0x0c4: /* DISPC_VID1_POSITION */
-    case 0x0c8: /* DISPC_VID1_SIZE */
-    case 0x0cc: /* DISPC_VID1_ATTRIBUTES */
-    case 0x0d0: /* DISPC_VID1_FIFO_TRESHOLD */
-    case 0x0d4: /* DISPC_VID1_FIFO_SIZE_STATUS */
-    case 0x0d8: /* DISPC_VID1_ROW_INC */
-    case 0x0dc: /* DISPC_VID1_PIXEL_INC */
-    case 0x0e0: /* DISPC_VID1_FIR */
-    case 0x0e4: /* DISPC_VID1_PICTURE_SIZE */
-    case 0x0e8: /* DISPC_VID1_ACCU0 */
-    case 0x0ec: /* DISPC_VID1_ACCU1 */
-    case 0x0f0 ... 0x140:   /* DISPC_VID1_FIR_COEF, DISPC_VID1_CONV_COEF */
-    case 0x14c: /* DISPC_VID2_BA0 */
-    case 0x150: /* DISPC_VID2_BA1 */
-    case 0x154: /* DISPC_VID2_POSITION */
-    case 0x158: /* DISPC_VID2_SIZE */
-    case 0x15c: /* DISPC_VID2_ATTRIBUTES */
-    case 0x160: /* DISPC_VID2_FIFO_TRESHOLD */
-    case 0x164: /* DISPC_VID2_FIFO_SIZE_STATUS */
-    case 0x168: /* DISPC_VID2_ROW_INC */
-    case 0x16c: /* DISPC_VID2_PIXEL_INC */
-    case 0x170: /* DISPC_VID2_FIR */
-    case 0x174: /* DISPC_VID2_PICTURE_SIZE */
-    case 0x178: /* DISPC_VID2_ACCU0 */
-    case 0x17c: /* DISPC_VID2_ACCU1 */
-    case 0x180 ... 0x1d0:   /* DISPC_VID2_FIR_COEF, DISPC_VID2_CONV_COEF */
-    case 0x1d4: /* DISPC_DATA_CYCLE1 */
-    case 0x1d8: /* DISPC_DATA_CYCLE2 */
-    case 0x1dc: /* DISPC_DATA_CYCLE3 */
-        return 0;
-
-    default:
-        break;
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_disc_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x010: /* DISPC_SYSCONFIG */
-        if (value & 2)                      /* SOFTRESET */
-            omap_dss_reset(s);
-        s->dispc.idlemode = value & 0x301b;
-        break;
-
-    case 0x018: /* DISPC_IRQSTATUS */
-        s->dispc.irqst &= ~value;
-        omap_dispc_interrupt_update(s);
-        break;
-
-    case 0x01c: /* DISPC_IRQENABLE */
-        s->dispc.irqen = value & 0xffff;
-        omap_dispc_interrupt_update(s);
-        break;
-
-    case 0x040: /* DISPC_CONTROL */
-        s->dispc.control = value & 0x07ff9fff;
-        s->dig.enable = (value >> 1) & 1;
-        s->lcd.enable = (value >> 0) & 1;
-        if (value & (1 << 12))          /* OVERLAY_OPTIMIZATION */
-            if (!((s->dispc.l[1].attr | s->dispc.l[2].attr) & 1)) {
-                fprintf(stderr, "%s: Overlay Optimization when no overlay "
-                        "region effectively exists leads to "
-                        "unpredictable behaviour!\n", __func__);
-            }
-        if (value & (1 << 6)) {             /* GODIGITAL */
-            /* XXX: Shadowed fields are:
-             * s->dispc.config
-             * s->dispc.capable
-             * s->dispc.bg[0]
-             * s->dispc.bg[1]
-             * s->dispc.trans[0]
-             * s->dispc.trans[1]
-             * s->dispc.line
-             * s->dispc.timing[0]
-             * s->dispc.timing[1]
-             * s->dispc.timing[2]
-             * s->dispc.timing[3]
-             * s->lcd.nx
-             * s->lcd.ny
-             * s->dig.nx
-             * s->dig.ny
-             * s->dispc.l[0].addr[0]
-             * s->dispc.l[0].addr[1]
-             * s->dispc.l[0].addr[2]
-             * s->dispc.l[0].posx
-             * s->dispc.l[0].posy
-             * s->dispc.l[0].nx
-             * s->dispc.l[0].ny
-             * s->dispc.l[0].tresh
-             * s->dispc.l[0].rowinc
-             * s->dispc.l[0].colinc
-             * s->dispc.l[0].wininc
-             * All they need to be loaded here from their shadow registers.
-             */
-        }
-        if (value & (1 << 5)) {             /* GOLCD */
-             /* XXX: Likewise for LCD here.  */
-        }
-        s->dispc.invalidate = 1;
-        break;
-
-    case 0x044: /* DISPC_CONFIG */
-        s->dispc.config = value & 0x3fff;
-        /* XXX:
-         * bits 2:1 (LOADMODE) reset to 0 after set to 1 and palette loaded
-         * bits 2:1 (LOADMODE) reset to 2 after set to 3 and palette loaded
-         */
-        s->dispc.invalidate = 1;
-        break;
-
-    case 0x048: /* DISPC_CAPABLE */
-        s->dispc.capable = value & 0x3ff;
-        break;
-
-    case 0x04c: /* DISPC_DEFAULT_COLOR0 */
-        s->dispc.bg[0] = value & 0xffffff;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x050: /* DISPC_DEFAULT_COLOR1 */
-        s->dispc.bg[1] = value & 0xffffff;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x054: /* DISPC_TRANS_COLOR0 */
-        s->dispc.trans[0] = value & 0xffffff;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x058: /* DISPC_TRANS_COLOR1 */
-        s->dispc.trans[1] = value & 0xffffff;
-        s->dispc.invalidate = 1;
-        break;
-
-    case 0x060: /* DISPC_LINE_NUMBER */
-        s->dispc.line = value & 0x7ff;
-        break;
-
-    case 0x064: /* DISPC_TIMING_H */
-        s->dispc.timing[0] = value & 0x0ff0ff3f;
-        break;
-    case 0x068: /* DISPC_TIMING_V */
-        s->dispc.timing[1] = value & 0x0ff0ff3f;
-        break;
-    case 0x06c: /* DISPC_POL_FREQ */
-        s->dispc.timing[2] = value & 0x0003ffff;
-        break;
-    case 0x070: /* DISPC_DIVISOR */
-        s->dispc.timing[3] = value & 0x00ff00ff;
-        break;
-
-    case 0x078: /* DISPC_SIZE_DIG */
-        s->dig.nx = ((value >>  0) & 0x7ff) + 1;        /* PPL */
-        s->dig.ny = ((value >> 16) & 0x7ff) + 1;        /* LPP */
-        s->dispc.invalidate = 1;
-        break;
-    case 0x07c: /* DISPC_SIZE_LCD */
-        s->lcd.nx = ((value >>  0) & 0x7ff) + 1;        /* PPL */
-        s->lcd.ny = ((value >> 16) & 0x7ff) + 1;        /* LPP */
-        s->dispc.invalidate = 1;
-        break;
-    case 0x080: /* DISPC_GFX_BA0 */
-        s->dispc.l[0].addr[0] = (hwaddr) value;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x084: /* DISPC_GFX_BA1 */
-        s->dispc.l[0].addr[1] = (hwaddr) value;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x088: /* DISPC_GFX_POSITION */
-        s->dispc.l[0].posx = ((value >>  0) & 0x7ff);       /* GFXPOSX */
-        s->dispc.l[0].posy = ((value >> 16) & 0x7ff);       /* GFXPOSY */
-        s->dispc.invalidate = 1;
-        break;
-    case 0x08c: /* DISPC_GFX_SIZE */
-        s->dispc.l[0].nx = ((value >>  0) & 0x7ff) + 1;     /* GFXSIZEX */
-        s->dispc.l[0].ny = ((value >> 16) & 0x7ff) + 1;     /* GFXSIZEY */
-        s->dispc.invalidate = 1;
-        break;
-    case 0x0a0: /* DISPC_GFX_ATTRIBUTES */
-        s->dispc.l[0].attr = value & 0x7ff;
-        if (value & (3 << 9))
-            fprintf(stderr, "%s: Big-endian pixel format not supported\n",
-                            __func__);
-        s->dispc.l[0].enable = value & 1;
-        s->dispc.l[0].bpp = (value >> 1) & 0xf;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x0a4: /* DISPC_GFX_FIFO_TRESHOLD */
-        s->dispc.l[0].tresh = value & 0x01ff01ff;
-        break;
-    case 0x0ac: /* DISPC_GFX_ROW_INC */
-        s->dispc.l[0].rowinc = value;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x0b0: /* DISPC_GFX_PIXEL_INC */
-        s->dispc.l[0].colinc = value;
-        s->dispc.invalidate = 1;
-        break;
-    case 0x0b4: /* DISPC_GFX_WINDOW_SKIP */
-        s->dispc.l[0].wininc = value;
-        break;
-    case 0x0b8: /* DISPC_GFX_TABLE_BA */
-        s->dispc.l[0].addr[2] = (hwaddr) value;
-        s->dispc.invalidate = 1;
-        break;
-
-    case 0x0bc: /* DISPC_VID1_BA0 */
-    case 0x0c0: /* DISPC_VID1_BA1 */
-    case 0x0c4: /* DISPC_VID1_POSITION */
-    case 0x0c8: /* DISPC_VID1_SIZE */
-    case 0x0cc: /* DISPC_VID1_ATTRIBUTES */
-    case 0x0d0: /* DISPC_VID1_FIFO_TRESHOLD */
-    case 0x0d8: /* DISPC_VID1_ROW_INC */
-    case 0x0dc: /* DISPC_VID1_PIXEL_INC */
-    case 0x0e0: /* DISPC_VID1_FIR */
-    case 0x0e4: /* DISPC_VID1_PICTURE_SIZE */
-    case 0x0e8: /* DISPC_VID1_ACCU0 */
-    case 0x0ec: /* DISPC_VID1_ACCU1 */
-    case 0x0f0 ... 0x140:   /* DISPC_VID1_FIR_COEF, DISPC_VID1_CONV_COEF */
-    case 0x14c: /* DISPC_VID2_BA0 */
-    case 0x150: /* DISPC_VID2_BA1 */
-    case 0x154: /* DISPC_VID2_POSITION */
-    case 0x158: /* DISPC_VID2_SIZE */
-    case 0x15c: /* DISPC_VID2_ATTRIBUTES */
-    case 0x160: /* DISPC_VID2_FIFO_TRESHOLD */
-    case 0x168: /* DISPC_VID2_ROW_INC */
-    case 0x16c: /* DISPC_VID2_PIXEL_INC */
-    case 0x170: /* DISPC_VID2_FIR */
-    case 0x174: /* DISPC_VID2_PICTURE_SIZE */
-    case 0x178: /* DISPC_VID2_ACCU0 */
-    case 0x17c: /* DISPC_VID2_ACCU1 */
-    case 0x180 ... 0x1d0:   /* DISPC_VID2_FIR_COEF, DISPC_VID2_CONV_COEF */
-    case 0x1d4: /* DISPC_DATA_CYCLE1 */
-    case 0x1d8: /* DISPC_DATA_CYCLE2 */
-    case 0x1dc: /* DISPC_DATA_CYCLE3 */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_disc_ops = {
-    .read = omap_disc_read,
-    .write = omap_disc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void omap_rfbi_transfer_stop(struct omap_dss_s *s)
-{
-    if (!s->rfbi.busy)
-        return;
-
-    /* TODO: in non-Bypass mode we probably need to just deassert the DRQ.  */
-
-    s->rfbi.busy = 0;
-}
-
-static void omap_rfbi_transfer_start(struct omap_dss_s *s)
-{
-    void *data;
-    hwaddr len;
-    hwaddr data_addr;
-    int pitch;
-    static void *bounce_buffer;
-    static hwaddr bounce_len;
-
-    if (!s->rfbi.enable || s->rfbi.busy)
-        return;
-
-    if (s->rfbi.control & (1 << 1)) {               /* BYPASS */
-        /* TODO: in non-Bypass mode we probably need to just assert the
-         * DRQ and wait for DMA to write the pixels.  */
-        qemu_log_mask(LOG_UNIMP, "%s: Bypass mode unimplemented\n", __func__);
-        return;
-    }
-
-    if (!(s->dispc.control & (1 << 11)))            /* RFBIMODE */
-        return;
-    /* TODO: check that LCD output is enabled in DISPC.  */
-
-    s->rfbi.busy = 1;
-
-    len = s->rfbi.pixels * 2;
-
-    data_addr = s->dispc.l[0].addr[0];
-    data = cpu_physical_memory_map(data_addr, &len, false);
-    if (data && len != s->rfbi.pixels * 2) {
-        cpu_physical_memory_unmap(data, len, 0, 0);
-        data = NULL;
-        len = s->rfbi.pixels * 2;
-    }
-    if (!data) {
-        if (len > bounce_len) {
-            bounce_buffer = g_realloc(bounce_buffer, len);
-        }
-        data = bounce_buffer;
-        cpu_physical_memory_read(data_addr, data, len);
-    }
-
-    /* TODO bpp */
-    s->rfbi.pixels = 0;
-
-    /* TODO: negative values */
-    pitch = s->dispc.l[0].nx + (s->dispc.l[0].rowinc - 1) / 2;
-
-    if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0])
-        s->rfbi.chip[0]->block(s->rfbi.chip[0]->opaque, 1, data, len, pitch);
-    if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1])
-        s->rfbi.chip[1]->block(s->rfbi.chip[1]->opaque, 1, data, len, pitch);
-
-    if (data != bounce_buffer) {
-        cpu_physical_memory_unmap(data, len, 0, len);
-    }
-
-    omap_rfbi_transfer_stop(s);
-
-    /* TODO */
-    s->dispc.irqst |= 1;                    /* FRAMEDONE */
-    omap_dispc_interrupt_update(s);
-}
-
-static uint64_t omap_rfbi_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:  /* RFBI_REVISION */
-        return 0x10;
-
-    case 0x10:  /* RFBI_SYSCONFIG */
-        return s->rfbi.idlemode;
-
-    case 0x14:  /* RFBI_SYSSTATUS */
-        return 1 | (s->rfbi.busy << 8);             /* RESETDONE */
-
-    case 0x40:  /* RFBI_CONTROL */
-        return s->rfbi.control;
-
-    case 0x44:  /* RFBI_PIXELCNT */
-        return s->rfbi.pixels;
-
-    case 0x48:  /* RFBI_LINE_NUMBER */
-        return s->rfbi.skiplines;
-
-    case 0x58:  /* RFBI_READ */
-    case 0x5c:  /* RFBI_STATUS */
-        return s->rfbi.rxbuf;
-
-    case 0x60:  /* RFBI_CONFIG0 */
-        return s->rfbi.config[0];
-    case 0x64:  /* RFBI_ONOFF_TIME0 */
-        return s->rfbi.time[0];
-    case 0x68:  /* RFBI_CYCLE_TIME0 */
-        return s->rfbi.time[1];
-    case 0x6c:  /* RFBI_DATA_CYCLE1_0 */
-        return s->rfbi.data[0];
-    case 0x70:  /* RFBI_DATA_CYCLE2_0 */
-        return s->rfbi.data[1];
-    case 0x74:  /* RFBI_DATA_CYCLE3_0 */
-        return s->rfbi.data[2];
-
-    case 0x78:  /* RFBI_CONFIG1 */
-        return s->rfbi.config[1];
-    case 0x7c:  /* RFBI_ONOFF_TIME1 */
-        return s->rfbi.time[2];
-    case 0x80:  /* RFBI_CYCLE_TIME1 */
-        return s->rfbi.time[3];
-    case 0x84:  /* RFBI_DATA_CYCLE1_1 */
-        return s->rfbi.data[3];
-    case 0x88:  /* RFBI_DATA_CYCLE2_1 */
-        return s->rfbi.data[4];
-    case 0x8c:  /* RFBI_DATA_CYCLE3_1 */
-        return s->rfbi.data[5];
-
-    case 0x90:  /* RFBI_VSYNC_WIDTH */
-        return s->rfbi.vsync;
-    case 0x94:  /* RFBI_HSYNC_WIDTH */
-        return s->rfbi.hsync;
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_rfbi_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_dss_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x10:  /* RFBI_SYSCONFIG */
-        if (value & 2)                      /* SOFTRESET */
-            omap_rfbi_reset(s);
-        s->rfbi.idlemode = value & 0x19;
-        break;
-
-    case 0x40:  /* RFBI_CONTROL */
-        s->rfbi.control = value & 0xf;
-        s->rfbi.enable = value & 1;
-        if (value & (1 << 4) &&                 /* ITE */
-                        !(s->rfbi.config[0] & s->rfbi.config[1] & 0xc))
-            omap_rfbi_transfer_start(s);
-        break;
-
-    case 0x44:  /* RFBI_PIXELCNT */
-        s->rfbi.pixels = value;
-        break;
-
-    case 0x48:  /* RFBI_LINE_NUMBER */
-        s->rfbi.skiplines = value & 0x7ff;
-        break;
-
-    case 0x4c:  /* RFBI_CMD */
-        if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0])
-            s->rfbi.chip[0]->write(s->rfbi.chip[0]->opaque, 0, value & 0xffff);
-        if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1])
-            s->rfbi.chip[1]->write(s->rfbi.chip[1]->opaque, 0, value & 0xffff);
-        break;
-    case 0x50:  /* RFBI_PARAM */
-        if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0])
-            s->rfbi.chip[0]->write(s->rfbi.chip[0]->opaque, 1, value & 0xffff);
-        if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1])
-            s->rfbi.chip[1]->write(s->rfbi.chip[1]->opaque, 1, value & 0xffff);
-        break;
-    case 0x54:  /* RFBI_DATA */
-        /* TODO: take into account the format set up in s->rfbi.config[?] and
-         * s->rfbi.data[?], but special-case the most usual scenario so that
-         * speed doesn't suffer.  */
-        if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0]) {
-            s->rfbi.chip[0]->write(s->rfbi.chip[0]->opaque, 1, value & 0xffff);
-            s->rfbi.chip[0]->write(s->rfbi.chip[0]->opaque, 1, value >> 16);
-        }
-        if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1]) {
-            s->rfbi.chip[1]->write(s->rfbi.chip[1]->opaque, 1, value & 0xffff);
-            s->rfbi.chip[1]->write(s->rfbi.chip[1]->opaque, 1, value >> 16);
-        }
-        if (!-- s->rfbi.pixels)
-            omap_rfbi_transfer_stop(s);
-        break;
-    case 0x58:  /* RFBI_READ */
-        if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0])
-            s->rfbi.rxbuf = s->rfbi.chip[0]->read(s->rfbi.chip[0]->opaque, 1);
-        else if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1])
-            s->rfbi.rxbuf = s->rfbi.chip[1]->read(s->rfbi.chip[1]->opaque, 1);
-        if (!-- s->rfbi.pixels)
-            omap_rfbi_transfer_stop(s);
-        break;
-
-    case 0x5c:  /* RFBI_STATUS */
-        if ((s->rfbi.control & (1 << 2)) && s->rfbi.chip[0])
-            s->rfbi.rxbuf = s->rfbi.chip[0]->read(s->rfbi.chip[0]->opaque, 0);
-        else if ((s->rfbi.control & (1 << 3)) && s->rfbi.chip[1])
-            s->rfbi.rxbuf = s->rfbi.chip[1]->read(s->rfbi.chip[1]->opaque, 0);
-        if (!-- s->rfbi.pixels)
-            omap_rfbi_transfer_stop(s);
-        break;
-
-    case 0x60:  /* RFBI_CONFIG0 */
-        s->rfbi.config[0] = value & 0x003f1fff;
-        break;
-
-    case 0x64:  /* RFBI_ONOFF_TIME0 */
-        s->rfbi.time[0] = value & 0x3fffffff;
-        break;
-    case 0x68:  /* RFBI_CYCLE_TIME0 */
-        s->rfbi.time[1] = value & 0x0fffffff;
-        break;
-    case 0x6c:  /* RFBI_DATA_CYCLE1_0 */
-        s->rfbi.data[0] = value & 0x0f1f0f1f;
-        break;
-    case 0x70:  /* RFBI_DATA_CYCLE2_0 */
-        s->rfbi.data[1] = value & 0x0f1f0f1f;
-        break;
-    case 0x74:  /* RFBI_DATA_CYCLE3_0 */
-        s->rfbi.data[2] = value & 0x0f1f0f1f;
-        break;
-    case 0x78:  /* RFBI_CONFIG1 */
-        s->rfbi.config[1] = value & 0x003f1fff;
-        break;
-
-    case 0x7c:  /* RFBI_ONOFF_TIME1 */
-        s->rfbi.time[2] = value & 0x3fffffff;
-        break;
-    case 0x80:  /* RFBI_CYCLE_TIME1 */
-        s->rfbi.time[3] = value & 0x0fffffff;
-        break;
-    case 0x84:  /* RFBI_DATA_CYCLE1_1 */
-        s->rfbi.data[3] = value & 0x0f1f0f1f;
-        break;
-    case 0x88:  /* RFBI_DATA_CYCLE2_1 */
-        s->rfbi.data[4] = value & 0x0f1f0f1f;
-        break;
-    case 0x8c:  /* RFBI_DATA_CYCLE3_1 */
-        s->rfbi.data[5] = value & 0x0f1f0f1f;
-        break;
-
-    case 0x90:  /* RFBI_VSYNC_WIDTH */
-        s->rfbi.vsync = value & 0xffff;
-        break;
-    case 0x94:  /* RFBI_HSYNC_WIDTH */
-        s->rfbi.hsync = value & 0xffff;
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_rfbi_ops = {
-    .read = omap_rfbi_read,
-    .write = omap_rfbi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static uint64_t omap_venc_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:  /* REV_ID */
-    case 0x04:  /* STATUS */
-    case 0x08:  /* F_CONTROL */
-    case 0x10:  /* VIDOUT_CTRL */
-    case 0x14:  /* SYNC_CTRL */
-    case 0x1c:  /* LLEN */
-    case 0x20:  /* FLENS */
-    case 0x24:  /* HFLTR_CTRL */
-    case 0x28:  /* CC_CARR_WSS_CARR */
-    case 0x2c:  /* C_PHASE */
-    case 0x30:  /* GAIN_U */
-    case 0x34:  /* GAIN_V */
-    case 0x38:  /* GAIN_Y */
-    case 0x3c:  /* BLACK_LEVEL */
-    case 0x40:  /* BLANK_LEVEL */
-    case 0x44:  /* X_COLOR */
-    case 0x48:  /* M_CONTROL */
-    case 0x4c:  /* BSTAMP_WSS_DATA */
-    case 0x50:  /* S_CARR */
-    case 0x54:  /* LINE21 */
-    case 0x58:  /* LN_SEL */
-    case 0x5c:  /* L21__WC_CTL */
-    case 0x60:  /* HTRIGGER_VTRIGGER */
-    case 0x64:  /* SAVID__EAVID */
-    case 0x68:  /* FLEN__FAL */
-    case 0x6c:  /* LAL__PHASE_RESET */
-    case 0x70:  /* HS_INT_START_STOP_X */
-    case 0x74:  /* HS_EXT_START_STOP_X */
-    case 0x78:  /* VS_INT_START_X */
-    case 0x7c:  /* VS_INT_STOP_X__VS_INT_START_Y */
-    case 0x80:  /* VS_INT_STOP_Y__VS_INT_START_X */
-    case 0x84:  /* VS_EXT_STOP_X__VS_EXT_START_Y */
-    case 0x88:  /* VS_EXT_STOP_Y */
-    case 0x90:  /* AVID_START_STOP_X */
-    case 0x94:  /* AVID_START_STOP_Y */
-    case 0xa0:  /* FID_INT_START_X__FID_INT_START_Y */
-    case 0xa4:  /* FID_INT_OFFSET_Y__FID_EXT_START_X */
-    case 0xa8:  /* FID_EXT_START_Y__FID_EXT_OFFSET_Y */
-    case 0xb0:  /* TVDETGP_INT_START_STOP_X */
-    case 0xb4:  /* TVDETGP_INT_START_STOP_Y */
-    case 0xb8:  /* GEN_CTRL */
-    case 0xc4:  /* DAC_TST__DAC_A */
-    case 0xc8:  /* DAC_B__DAC_C */
-        return 0;
-
-    default:
-        break;
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_venc_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, size);
-        return;
-    }
-
-    switch (addr) {
-    case 0x08:  /* F_CONTROL */
-    case 0x10:  /* VIDOUT_CTRL */
-    case 0x14:  /* SYNC_CTRL */
-    case 0x1c:  /* LLEN */
-    case 0x20:  /* FLENS */
-    case 0x24:  /* HFLTR_CTRL */
-    case 0x28:  /* CC_CARR_WSS_CARR */
-    case 0x2c:  /* C_PHASE */
-    case 0x30:  /* GAIN_U */
-    case 0x34:  /* GAIN_V */
-    case 0x38:  /* GAIN_Y */
-    case 0x3c:  /* BLACK_LEVEL */
-    case 0x40:  /* BLANK_LEVEL */
-    case 0x44:  /* X_COLOR */
-    case 0x48:  /* M_CONTROL */
-    case 0x4c:  /* BSTAMP_WSS_DATA */
-    case 0x50:  /* S_CARR */
-    case 0x54:  /* LINE21 */
-    case 0x58:  /* LN_SEL */
-    case 0x5c:  /* L21__WC_CTL */
-    case 0x60:  /* HTRIGGER_VTRIGGER */
-    case 0x64:  /* SAVID__EAVID */
-    case 0x68:  /* FLEN__FAL */
-    case 0x6c:  /* LAL__PHASE_RESET */
-    case 0x70:  /* HS_INT_START_STOP_X */
-    case 0x74:  /* HS_EXT_START_STOP_X */
-    case 0x78:  /* VS_INT_START_X */
-    case 0x7c:  /* VS_INT_STOP_X__VS_INT_START_Y */
-    case 0x80:  /* VS_INT_STOP_Y__VS_INT_START_X */
-    case 0x84:  /* VS_EXT_STOP_X__VS_EXT_START_Y */
-    case 0x88:  /* VS_EXT_STOP_Y */
-    case 0x90:  /* AVID_START_STOP_X */
-    case 0x94:  /* AVID_START_STOP_Y */
-    case 0xa0:  /* FID_INT_START_X__FID_INT_START_Y */
-    case 0xa4:  /* FID_INT_OFFSET_Y__FID_EXT_START_X */
-    case 0xa8:  /* FID_EXT_START_Y__FID_EXT_OFFSET_Y */
-    case 0xb0:  /* TVDETGP_INT_START_STOP_X */
-    case 0xb4:  /* TVDETGP_INT_START_STOP_Y */
-    case 0xb8:  /* GEN_CTRL */
-    case 0xc4:  /* DAC_TST__DAC_A */
-    case 0xc8:  /* DAC_B__DAC_C */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_venc_ops = {
-    .read = omap_venc_read,
-    .write = omap_venc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static uint64_t omap_im3_read(void *opaque, hwaddr addr,
-                              unsigned size)
-{
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x0a8: /* SBIMERRLOGA */
-    case 0x0b0: /* SBIMERRLOG */
-    case 0x190: /* SBIMSTATE */
-    case 0x198: /* SBTMSTATE_L */
-    case 0x19c: /* SBTMSTATE_H */
-    case 0x1a8: /* SBIMCONFIG_L */
-    case 0x1ac: /* SBIMCONFIG_H */
-    case 0x1f8: /* SBID_L */
-    case 0x1fc: /* SBID_H */
-        return 0;
-
-    default:
-        break;
-    }
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_im3_write(void *opaque, hwaddr addr,
-                           uint64_t value, unsigned size)
-{
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x0b0: /* SBIMERRLOG */
-    case 0x190: /* SBIMSTATE */
-    case 0x198: /* SBTMSTATE_L */
-    case 0x19c: /* SBTMSTATE_H */
-    case 0x1a8: /* SBIMCONFIG_L */
-    case 0x1ac: /* SBIMCONFIG_H */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_im3_ops = {
-    .read = omap_im3_read,
-    .write = omap_im3_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_dss_s *omap_dss_init(struct omap_target_agent_s *ta,
-                MemoryRegion *sysmem,
-                hwaddr l3_base,
-                qemu_irq irq, qemu_irq drq,
-                omap_clk fck1, omap_clk fck2, omap_clk ck54m,
-                omap_clk ick1, omap_clk ick2)
-{
-    struct omap_dss_s *s = g_new0(struct omap_dss_s, 1);
-
-    s->irq = irq;
-    s->drq = drq;
-    omap_dss_reset(s);
-
-    memory_region_init_io(&s->iomem_diss1, NULL, &omap_diss_ops, s, "omap.diss1",
-                          omap_l4_region_size(ta, 0));
-    memory_region_init_io(&s->iomem_disc1, NULL, &omap_disc_ops, s, "omap.disc1",
-                          omap_l4_region_size(ta, 1));
-    memory_region_init_io(&s->iomem_rfbi1, NULL, &omap_rfbi_ops, s, "omap.rfbi1",
-                          omap_l4_region_size(ta, 2));
-    memory_region_init_io(&s->iomem_venc1, NULL, &omap_venc_ops, s, "omap.venc1",
-                          omap_l4_region_size(ta, 3));
-    memory_region_init_io(&s->iomem_im3, NULL, &omap_im3_ops, s,
-                          "omap.im3", 0x1000);
-
-    omap_l4_attach(ta, 0, &s->iomem_diss1);
-    omap_l4_attach(ta, 1, &s->iomem_disc1);
-    omap_l4_attach(ta, 2, &s->iomem_rfbi1);
-    omap_l4_attach(ta, 3, &s->iomem_venc1);
-    memory_region_add_subregion(sysmem, l3_base, &s->iomem_im3);
-
-#if 0
-    s->state = graphic_console_init(omap_update_display,
-                                    omap_invalidate_display, omap_screen_dump, s);
-#endif
-
-    return s;
-}
-
-void omap_rfbi_attach(struct omap_dss_s *s, int cs, struct rfbi_chip_s *chip)
-{
-    if (cs < 0 || cs > 1)
-        hw_error("%s: wrong CS %i\n", __func__, cs);
-    s->rfbi.chip[cs] = chip;
-}
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 2b1693ad728..20a94973fa2 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -25,7 +25,6 @@ system_ss.add(when: 'CONFIG_BOCHS_DISPLAY', if_true: files('bochs-display.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_fimd.c'))
 system_ss.add(when: 'CONFIG_FRAMEBUFFER', if_true: files('framebuffer.c'))
 
-system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dss.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_fb.c'))
 system_ss.add(when: 'CONFIG_SM501', if_true: files('sm501.c'))
 system_ss.add(when: 'CONFIG_TCX', if_true: files('tcx.c'))
-- 
2.34.1


