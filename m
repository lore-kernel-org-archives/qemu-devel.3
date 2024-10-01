Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB86CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfw8-0000oC-Uz; Tue, 01 Oct 2024 12:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfui-0005cA-6c
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfub-00069O-Dc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cca239886so3296169f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800784; x=1728405584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RhbqOipw/0Q0UgKOmZRJYcOhNAbsy3Cg3OL+PeaEZ2Y=;
 b=YSHbL/x75i2nlQ71fYS/POMfY0wD9IQueojgLz4410iqNYvkhGwAyepufBTlubju+A
 6TB4HySu9Ch/DDz8axm6DagCTIRVyIuslQCZnMRv/tIRNv5CelYT1jjQp6nlm3TOwr/x
 hsGeFPnc91SyHMvCP2epVdLXWwltIu/183w1IIg7Vq+LlpB/dt6i/S9kRhSDaBVyWAu8
 DPpW1sG8gr4+7wWaZD6QoLNVqy/yVCr+299RS/0N0Xq930UCvtNBfKyl+h42gAiwaJvm
 hEAyZgDvq5trds3mQWXoID7NjJHYvPv68OLb5ALAI8yNfFa1qmZ1ZqLvZxpW5IkurRaQ
 LlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800784; x=1728405584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhbqOipw/0Q0UgKOmZRJYcOhNAbsy3Cg3OL+PeaEZ2Y=;
 b=G7/guN1yD9rJQliwZMatSpYLFJhgkEwdU8ZbDX8WU8NfgUHQB0Fab2jOd3dR72KVy4
 9ZSua4DHqpuHGI2HfgKvtac5Ocu0YsU+PmOcBkzoP+ggqFwRnQ8zpQGwhexG/ncU8Gl3
 gw8e+iWjJycFqMGbsrHSdwFCWB12Ys/7oC3E1hhotKvG5kt89I6vxTtGAXQdTu9Df8N8
 r6NeWvyKC1dwlEogY1h1+S8NWg87g7Yiv2/fU5TxSnjf7pHqI7NYuZy6x+NdHgkyKumy
 ZKCEBbopNU3OD7zxh1xJOJHziuBkrPd3RrLDq1AcjaVdhxNd2Ct8EGYQcUoAtqgQGnuD
 Dgig==
X-Gm-Message-State: AOJu0YwsqcRGm1RpiDtQPew6fj39HEiAgWEMLMWZpJI70UxlT4vVRtOd
 OpJQ19u47PftdwNZCnmBhndGOgp5vA94K+SVK7AXj6bhMCXOtjlFfxYRPYESnU2EL+yNbYhEN7G
 e
X-Google-Smtp-Source: AGHT+IGiudWhDiC9CTpo9dbslYuWPMy/rltl8jjKS69qNMpNC/19tcqrzyeytMUAFX+/7ZWdMkTXGQ==
X-Received: by 2002:a5d:67ca:0:b0:374:c2cf:c01c with SMTP id
 ffacd0b85a97d-37cfba183camr124755f8f.48.1727800783900; 
 Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/54] hw/misc: Remove omap_sdrc device
Date: Tue,  1 Oct 2024 17:39:08 +0100
Message-Id: <20241001163918.1275441-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The omap_sdrc device is only in OMAP2, which we are removing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-43-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |   7 --
 hw/misc/omap_sdrc.c   | 167 ------------------------------------------
 hw/misc/meson.build   |   1 -
 3 files changed, 175 deletions(-)
 delete mode 100644 hw/misc/omap_sdrc.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index b0bd1e6f540..dcd338c7c49 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -147,12 +147,6 @@ hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
 hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
                                        int region);
 
-/* OMAP2 SDRAM controller */
-struct omap_sdrc_s;
-struct omap_sdrc_s *omap_sdrc_init(MemoryRegion *sysmem,
-                                   hwaddr base);
-void omap_sdrc_reset(struct omap_sdrc_s *s);
-
 /* OMAP2 general purpose memory controller */
 struct omap_gpmc_s;
 struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
@@ -954,7 +948,6 @@ struct omap_mpu_state_s {
     struct omap_gp_timer_s *gptimer[12];
     struct omap_synctimer_s *synctimer;
 
-    struct omap_sdrc_s *sdrc;
     struct omap_gpmc_s *gpmc;
 
     struct omap_mcspi_s *mcspi[2];
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
deleted file mode 100644
index 6aa1b3ef7fb..00000000000
--- a/hw/misc/omap_sdrc.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * TI OMAP SDRAM controller emulation.
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
-#include "hw/arm/omap.h"
-
-/* SDRAM Controller Subsystem */
-struct omap_sdrc_s {
-    MemoryRegion iomem;
-    uint8_t config;
-};
-
-void omap_sdrc_reset(struct omap_sdrc_s *s)
-{
-    s->config = 0x10;
-}
-
-static uint64_t omap_sdrc_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_sdrc_s *s = opaque;
-
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:	/* SDRC_REVISION */
-        return 0x20;
-
-    case 0x10:	/* SDRC_SYSCONFIG */
-        return s->config;
-
-    case 0x14:	/* SDRC_SYSSTATUS */
-        return 1;						/* RESETDONE */
-
-    case 0x40:	/* SDRC_CS_CFG */
-    case 0x44:	/* SDRC_SHARING */
-    case 0x48:	/* SDRC_ERR_ADDR */
-    case 0x4c:	/* SDRC_ERR_TYPE */
-    case 0x60:	/* SDRC_DLLA_SCTRL */
-    case 0x64:	/* SDRC_DLLA_STATUS */
-    case 0x68:	/* SDRC_DLLB_CTRL */
-    case 0x6c:	/* SDRC_DLLB_STATUS */
-    case 0x70:	/* SDRC_POWER */
-    case 0x80:	/* SDRC_MCFG_0 */
-    case 0x84:	/* SDRC_MR_0 */
-    case 0x88:	/* SDRC_EMR1_0 */
-    case 0x8c:	/* SDRC_EMR2_0 */
-    case 0x90:	/* SDRC_EMR3_0 */
-    case 0x94:	/* SDRC_DCDL1_CTRL */
-    case 0x98:	/* SDRC_DCDL2_CTRL */
-    case 0x9c:	/* SDRC_ACTIM_CTRLA_0 */
-    case 0xa0:	/* SDRC_ACTIM_CTRLB_0 */
-    case 0xa4:	/* SDRC_RFR_CTRL_0 */
-    case 0xa8:	/* SDRC_MANUAL_0 */
-    case 0xb0:	/* SDRC_MCFG_1 */
-    case 0xb4:	/* SDRC_MR_1 */
-    case 0xb8:	/* SDRC_EMR1_1 */
-    case 0xbc:	/* SDRC_EMR2_1 */
-    case 0xc0:	/* SDRC_EMR3_1 */
-    case 0xc4:	/* SDRC_ACTIM_CTRLA_1 */
-    case 0xc8:	/* SDRC_ACTIM_CTRLB_1 */
-    case 0xd4:	/* SDRC_RFR_CTRL_1 */
-    case 0xd8:	/* SDRC_MANUAL_1 */
-        return 0x00;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_sdrc_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_sdrc_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x00:	/* SDRC_REVISION */
-    case 0x14:	/* SDRC_SYSSTATUS */
-    case 0x48:	/* SDRC_ERR_ADDR */
-    case 0x64:	/* SDRC_DLLA_STATUS */
-    case 0x6c:	/* SDRC_DLLB_STATUS */
-        OMAP_RO_REG(addr);
-        return;
-
-    case 0x10:	/* SDRC_SYSCONFIG */
-        if ((value >> 3) != 0x2)
-            fprintf(stderr, "%s: bad SDRAM idle mode %i\n",
-                    __func__, (unsigned)value >> 3);
-        if (value & 2)
-            omap_sdrc_reset(s);
-        s->config = value & 0x18;
-        break;
-
-    case 0x40:	/* SDRC_CS_CFG */
-    case 0x44:	/* SDRC_SHARING */
-    case 0x4c:	/* SDRC_ERR_TYPE */
-    case 0x60:	/* SDRC_DLLA_SCTRL */
-    case 0x68:	/* SDRC_DLLB_CTRL */
-    case 0x70:	/* SDRC_POWER */
-    case 0x80:	/* SDRC_MCFG_0 */
-    case 0x84:	/* SDRC_MR_0 */
-    case 0x88:	/* SDRC_EMR1_0 */
-    case 0x8c:	/* SDRC_EMR2_0 */
-    case 0x90:	/* SDRC_EMR3_0 */
-    case 0x94:	/* SDRC_DCDL1_CTRL */
-    case 0x98:	/* SDRC_DCDL2_CTRL */
-    case 0x9c:	/* SDRC_ACTIM_CTRLA_0 */
-    case 0xa0:	/* SDRC_ACTIM_CTRLB_0 */
-    case 0xa4:	/* SDRC_RFR_CTRL_0 */
-    case 0xa8:	/* SDRC_MANUAL_0 */
-    case 0xb0:	/* SDRC_MCFG_1 */
-    case 0xb4:	/* SDRC_MR_1 */
-    case 0xb8:	/* SDRC_EMR1_1 */
-    case 0xbc:	/* SDRC_EMR2_1 */
-    case 0xc0:	/* SDRC_EMR3_1 */
-    case 0xc4:	/* SDRC_ACTIM_CTRLA_1 */
-    case 0xc8:	/* SDRC_ACTIM_CTRLB_1 */
-    case 0xd4:	/* SDRC_RFR_CTRL_1 */
-    case 0xd8:	/* SDRC_MANUAL_1 */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-        return;
-    }
-}
-
-static const MemoryRegionOps omap_sdrc_ops = {
-    .read = omap_sdrc_read,
-    .write = omap_sdrc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_sdrc_s *omap_sdrc_init(MemoryRegion *sysmem,
-                                   hwaddr base)
-{
-    struct omap_sdrc_s *s = g_new0(struct omap_sdrc_s, 1);
-
-    omap_sdrc_reset(s);
-
-    memory_region_init_io(&s->iomem, NULL, &omap_sdrc_ops, s, "omap.sdrc", 0x1000);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
-
-    return s;
-}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 01b77ca200f..7c9addbe68f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -77,7 +77,6 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
   'omap_gpmc.c',
   'omap_l4.c',
-  'omap_sdrc.c',
   'omap_tap.c',
 ))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files(
-- 
2.34.1


