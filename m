Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBAECEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfvC-0006v8-R8; Tue, 01 Oct 2024 12:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuj-0005ff-GR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfud-0006A1-CS
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so20165545e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800786; x=1728405586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m6tPZvdqCcLp9Z7epWPNdtOB9CLTYpwOU9D1H5zmta4=;
 b=SOoqggAX68qET1mziEe25kj6oeRKfQhF8NmCNM8xkanUMe+j+qsKIA5DJzI8lrL65P
 B0Gj8+To5fk1DCsAv9jBLtZjHdoG5hKD2dZL2dyJE0UuoYzlLkriMbjX5KopWPbekuFA
 55OMSk9GpYqR8OAgjgg1NaEmFSHnTYmrD0p2EBJDxcf7Z1qh1h04UkWq2X712JJDBwkO
 IW1uG1CWKj6cIbE/5xj0BxHeY2WS8qq75M49B5lZwbIsQRYB/lOIz3v4Nbe8x1sSpK3R
 8UmOL+XN0FcXF+v/6n+HNePANnoG8FQtXC/nNVZytoe+2hneCbPSNksMRpR9NkMN8xSK
 WTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800786; x=1728405586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6tPZvdqCcLp9Z7epWPNdtOB9CLTYpwOU9D1H5zmta4=;
 b=n56/+V48VxEB7GN/+0CGSO83rIw/zh1ilhcHLC4qIL6lV1YYrpyvksHqz5Vr3IEH4L
 UVnjexnGHGKE1PT0l9DNUruoDT6T0t8VQjQQUz1b1Avfq/qU05mEKroYwmHz8KTsbDWf
 An67JVjzB2Kd7FEMF56j0cENg/f3SZbWx10Co7aVFTaCXx7iQWMnNYBYDj1O6kLU5xLU
 bTIOrmXfXzDts0SxD2h2IDlN9Uw4gHPFzdGlr21k7OGKodgcqAzXet2RwqcTT9n0dEXJ
 Qkq/jsEeH4A0KdBOaIQLSdGUcGUK6cS+vFsnpTJRcBxB2mQKuZlREOxwaxk28eKxcE94
 ZLbw==
X-Gm-Message-State: AOJu0YxIKt3n2EiFl0lkn98cVXOnjVWwNoYQf42GaiGuYiSjzw4/FWOs
 2aeJE+SyvN5mIVrOmumQOSVoXNel6UAZMzKn5I0HkHYH3L8cmBKaBmhYQLYp1Jy8ow9abR2caAr
 n
X-Google-Smtp-Source: AGHT+IF9q7PwlqBNSMUJLme+zelMT6zvNWmoV3dq3bbvKlFkDe0ZJGUXv+8tM5rVfMfHzq7w//B8SA==
X-Received: by 2002:a05:600c:2246:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f777b982amr918645e9.14.1727800785753; 
 Tue, 01 Oct 2024 09:39:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/54] hw/timer: Remove omap_synctimer
Date: Tue,  1 Oct 2024 17:39:11 +0100
Message-Id: <20241001163918.1275441-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove the omap_synctimer device, which is only in the OMAP2 SoC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-46-peter.maydell@linaro.org
---
 include/hw/arm/omap.h     |   8 ---
 hw/timer/omap_synctimer.c | 110 --------------------------------------
 hw/timer/meson.build      |   1 -
 3 files changed, 119 deletions(-)
 delete mode 100644 hw/timer/omap_synctimer.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index cced3d28605..982341d0079 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -676,12 +676,6 @@ struct omap_dma_lcd_channel_s {
 # define OMAP24XX_DMA_MS		63	/* Not in OMAP2420 */
 # define OMAP24XX_DMA_EXT_DMAREQ5	64
 
-/* OMAP2 sysctimer */
-struct omap_synctimer_s;
-struct omap_synctimer_s *omap_synctimer_init(struct omap_target_agent_s *ta,
-                struct omap_mpu_state_s *mpu, omap_clk fclk, omap_clk iclk);
-void omap_synctimer_reset(struct omap_synctimer_s *s);
-
 struct omap_uart_s;
 struct omap_uart_s *omap_uart_init(hwaddr base,
                 qemu_irq irq, omap_clk fclk, omap_clk iclk,
@@ -929,8 +923,6 @@ struct omap_mpu_state_s {
     /* OMAP2-only peripherals */
     struct omap_l4_s *l4;
 
-    struct omap_synctimer_s *synctimer;
-
     struct omap_mcspi_s *mcspi[2];
 
     struct omap_dss_s *dss;
diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
deleted file mode 100644
index d93a9344ede..00000000000
--- a/hw/timer/omap_synctimer.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * TI OMAP2 32kHz sync timer emulation.
- *
- * Copyright (C) 2007-2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) any later version of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-#include "qemu/osdep.h"
-#include "qemu/timer.h"
-#include "hw/arm/omap.h"
-struct omap_synctimer_s {
-    MemoryRegion iomem;
-    uint32_t val;
-    uint16_t readh;
-};
-
-/* 32-kHz Sync Timer of the OMAP2 */
-static uint32_t omap_synctimer_read(struct omap_synctimer_s *s) {
-    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 0x8000,
-                    NANOSECONDS_PER_SECOND);
-}
-
-void omap_synctimer_reset(struct omap_synctimer_s *s)
-{
-    s->val = omap_synctimer_read(s);
-}
-
-static uint32_t omap_synctimer_readw(void *opaque, hwaddr addr)
-{
-    struct omap_synctimer_s *s = opaque;
-
-    switch (addr) {
-    case 0x00:	/* 32KSYNCNT_REV */
-        return 0x21;
-
-    case 0x10:	/* CR */
-        return omap_synctimer_read(s) - s->val;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static uint32_t omap_synctimer_readh(void *opaque, hwaddr addr)
-{
-    struct omap_synctimer_s *s = opaque;
-    uint32_t ret;
-
-    if (addr & 2)
-        return s->readh;
-    else {
-        ret = omap_synctimer_readw(opaque, addr);
-        s->readh = ret >> 16;
-        return ret & 0xffff;
-    }
-}
-
-static uint64_t omap_synctimer_readfn(void *opaque, hwaddr addr,
-                                      unsigned size)
-{
-    switch (size) {
-    case 1:
-        return omap_badwidth_read32(opaque, addr);
-    case 2:
-        return omap_synctimer_readh(opaque, addr);
-    case 4:
-        return omap_synctimer_readw(opaque, addr);
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void omap_synctimer_writefn(void *opaque, hwaddr addr,
-                                   uint64_t value, unsigned size)
-{
-    OMAP_BAD_REG(addr);
-}
-
-static const MemoryRegionOps omap_synctimer_ops = {
-    .read = omap_synctimer_readfn,
-    .write = omap_synctimer_writefn,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_synctimer_s *omap_synctimer_init(struct omap_target_agent_s *ta,
-                struct omap_mpu_state_s *mpu, omap_clk fclk, omap_clk iclk)
-{
-    struct omap_synctimer_s *s = g_malloc0(sizeof(*s));
-
-    omap_synctimer_reset(s);
-    memory_region_init_io(&s->iomem, NULL, &omap_synctimer_ops, s, "omap.synctimer",
-                          omap_l4_region_size(ta, 0));
-    omap_l4_attach(ta, 0, &s->iomem);
-
-    return s;
-}
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 73cb9541269..f5f9eed2d0a 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -21,7 +21,6 @@ system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
-system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
 system_ss.add(when: 'CONFIG_PXA2XX_TIMER', if_true: files('pxa2xx_timer.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
 system_ss.add(when: 'CONFIG_SH_TIMER', if_true: files('sh_timer.c'))
-- 
2.34.1


