Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E27FCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5e-0001qA-W4; Tue, 03 Sep 2024 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5Z-0001Pl-P6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5V-0002xt-KZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so1626730f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379740; x=1725984540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ke08yY4/dopOYtA2QapUAC0xejTJLaqgAeW0nPXO+d4=;
 b=f1gtZ1nrWpZ70GVrb/EJx00c/7VxiK+4R1AIK9Z9sUv5REtGjJEKAKOOXFP1nfqJq9
 zKTSRFLbbA/UJQSweilHP5PNEz+dMKHEAu2SZm4Y64ZCdZh7s+XJUVjeZD+scGwR5WMo
 7xqzqjs3pLwtFBvApH0Sv/XHW5/CHQ1WY9btHpFpj+U560gc4sheNBiaIPLZTDVnkS7t
 74om1KN1QriDnrk1eaUrkWGQO4CP92JQj3DA94sWMS4mleRZ2/ynKKhrEHwhLLclILY5
 ofY+j1dfPeBNBDBG9RXJri1Te4bv7TL8SrBC3hLnwZ59XPrYhckHmFxl53XZXLQKTffG
 m49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379740; x=1725984540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ke08yY4/dopOYtA2QapUAC0xejTJLaqgAeW0nPXO+d4=;
 b=ipbsf++Bl9zt5Xbo5vGN9Ydik09mMLu3abtAHz8Aanwivx85HTMmXkAMnqtHOlfbQ6
 q2J08OCbbV03R6b9GRDrn6klgp8n1wwJwr71bYUQCR00S++/J560XPxb6wEH6Kfj7TDT
 /fG6iVbkcTzH4tRHHp0/5XlexVQ8qdtYlbzuLKsssy7B+K9l5OwtpmqugI+bXxgNYu+X
 0oQ7wsd6xGWYTOfTnW39JjjQJJjDgl6w/fAEOSApuk/zJ+KtG2X9R/Lm3UrYbrGfsf5D
 lYOXPzwbyBYUKIRM8EGP0fuyxAW8U7yRbzsDEOtC8LdEHmMg59jNsLuLY9JKnWkB4Bwp
 2V1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDg90N1Fu+bt+A5RokA8w78aStROY2v5IQa0uRmYeGsc3KANfgbj4hAOwC5pFj0wiAKGZnJ888fkkd@nongnu.org
X-Gm-Message-State: AOJu0YzmBz2GRJPwkaexqHD335B6rz0Q7ZWujLri2/A5dPyoEczvgAK2
 to6Kcuoa0ObgFnPtzDw/9BsY8HAwkl//CAHp8SCvf2VzTfS+sFZVInlKJuPdeDFULOPC4y9Qcxw
 C
X-Google-Smtp-Source: AGHT+IGF5RMPbu9V1C4CbduAsqSU6Vs1Xkm4JhjaGKmENWuy0aaQjfqxoMlWPSpwzlMWULvJHSdOIg==
X-Received: by 2002:a5d:40c5:0:b0:371:87d4:8f12 with SMTP id
 ffacd0b85a97d-374c945c787mr5338156f8f.17.1725379739932; 
 Tue, 03 Sep 2024 09:08:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 45/53] hw/timer: Remove omap_synctimer
Date: Tue,  3 Sep 2024 17:07:43 +0100
Message-Id: <20240903160751.4100218-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Remove the omap_synctimer device, which is only in the OMAP2 SoC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 1292d9530ca..fe131666b17 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -22,7 +22,6 @@ system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
-system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
 system_ss.add(when: 'CONFIG_PXA2XX_TIMER', if_true: files('pxa2xx_timer.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_systmr.c'))
 system_ss.add(when: 'CONFIG_SH_TIMER', if_true: files('sh_timer.c'))
-- 
2.34.1


