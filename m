Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6BFCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5X-0001D8-Q8; Tue, 03 Sep 2024 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5V-00010Y-Rc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5S-0002wf-U1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:09:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so35261195e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379737; x=1725984537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o9jcoqLAJDH+O2oDxtRL1b8qAB8s8mJNaREJywv6u2Y=;
 b=JvgmVMSjmywZMjgcxPZxt/0wHjCKZ/2pPieUkm65767lYkMFCtx0F+tJuUmNxt0Zgf
 SxC2XRUiWn+PIfFog6veZ2KVwO/EBQXH0UAxVNsp/qDcWTFSOMRvEka8Dbvhuhtko66P
 GxCl//2K469REJ/fj52GRqzwx2KWAq3kTyuOReHj2Qrxxq7/G8HUvtEuREEYS65pR4gZ
 XcoTKqv3xyNntJEp/1aX6hAYShx5yGcaJMct1MDZ/0ueImtc/qdvvtlXAVj4sGVwD2eG
 j7EZKAUUnu9MgGxErYKck0+CvXCajb902BpWdBba6ao5h5Y5DWUbdPCXFZpeSOAglo0I
 WDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379737; x=1725984537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9jcoqLAJDH+O2oDxtRL1b8qAB8s8mJNaREJywv6u2Y=;
 b=vlz1SZIIHQbLSpK4HaiuWFJFZT/H4Fv95w0IN8bPEOQ3EOxltmAfQsHXoiJcA1hk0c
 Ar1VqGRWKUvOBmYl3yJmJEYRuMWjNZ/LB9pk3ElN4cAsA17QiQvGBTBlqqgfOE88Mxmn
 XMWGFgYfGeAxtJlShKIfadO8gMzABsWt7u/gj6qfFOu9hSrkSDj72UwhjXn2L6NiqO5M
 UyNIvpWQjZF9iebOP+w1JZ41BGlKe9He2+F4htHMCFw5/IqKVh0atgewLwvMPSJc+3pd
 XV5vCAy0epBv5WoBM/egrdhx5UulPDG/W5rRo0JjyPwLHCOoq123hZXFVJnWE9K72MKt
 ONBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfOeB3xihaM5gMqxcdMXW0bYFQnY2fBaE0+tLLfb5z8ARMUpR1xejoE8XACVJLe2GSY1TSjNQuNXRX@nongnu.org
X-Gm-Message-State: AOJu0Yy6Z8S2jRniBFGsQhPY5T+pjDUPCfgStNi+rTE2LaLcDU4sl/81
 SgD///0xHaxBFkAWFsNwFLTqO1RGNHDPw3InDx85utuvAsV8DnTqUQww7mXDHgCra8ylSuXlFue
 H
X-Google-Smtp-Source: AGHT+IHk8Hwh8Zzl0/KYcKQMwkRgnBGTUImGGPTQSE+fHpNAfnQyK6zyJU0GN12OfB4oH1AKd7OHyQ==
X-Received: by 2002:a05:600c:3b8e:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-42bb01b91dbmr158200825e9.12.1725379737390; 
 Tue, 03 Sep 2024 09:08:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 42/53] hw/misc: Remove omap_sdrc device
Date: Tue,  3 Sep 2024 17:07:40 +0100
Message-Id: <20240903160751.4100218-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


