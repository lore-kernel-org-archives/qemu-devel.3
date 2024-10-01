Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D032CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfvj-0007GP-2K; Tue, 01 Oct 2024 12:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svful-0005ih-7v
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfue-0006AJ-9l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so2880789f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800787; x=1728405587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Io4aaYTyyHjNJLLU/fe4VlIjMSgoiqly+g2WCJztiA=;
 b=WXfzBpmi6FRa2/bCiU5TCInZUbewtyDOx5Slfy8Kmut9oGs8PDZQ+bcGJYb9xgOHyq
 beUStCl7D3p3mBu/AaMEh//0IiZ5ZXAHbn+5DMjuh2Yhh8lUA1+s7rvdHB+Ch+W5QBrz
 8UEHfUoA9mNbe6atkmL5OVASUZmNeT1zVlTEsBAJTAmZgFO2UX+Uzqm/sro38vy+JLjJ
 7YXXZabOqvB9AaB7sLSbjFx3bcAJYTRnf5c5lKU09eAayZw+sJ51fsISVRDbFwZITMX4
 jpqnWJp7jy08gkSLIf+23weYjBKlBKKWoUJxhv9M6Pl0nOXCp8kT9BGzLY9fYT1Qj6+Q
 PNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800787; x=1728405587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Io4aaYTyyHjNJLLU/fe4VlIjMSgoiqly+g2WCJztiA=;
 b=chsqXzc93ZMCTDbHCSk0mqb15hT+piiPkcP0F3r6ceDtyi2Q2crIWFVNI3uZTHn3WG
 hhRzc/YkSCdrRrr6xtN9N6q/nASGnXFAZlvnew7mwmZPPcn27DUFKdlbKnzY/NQ1iNkO
 SwLXFfmblB4Vj+6jDd1gV9pR7qgk15FXyN9iCjou6orzulxH7ZVmjVJkhWXt9E5DMTsA
 6b7VF9s9N/45LJu0jZWt2ymjURqQQsOFGQ/YnKhO5UTp2VZ3LquSfXK8bS1jMnBoamtx
 YnWsbbdBUHVCAhR8z+qo4OrHxN1p5RcbnwWKSbs3PQY7sLXFqobyrnvKRCMfc4cF6yf8
 A0jg==
X-Gm-Message-State: AOJu0Yzjp9NvLGQi/rTXtHd3bz7+XV9sL/0l7SPrU8ex4F9Jxja3O2uk
 4cVXHBKwL+Cz+dLk2PuKB5PF8ZxeuDZjReFR/KiWJJSCiUncrMyfao5kWIfs+stX3SLCO0Oswwq
 l
X-Google-Smtp-Source: AGHT+IGHvtNW6aMVe+QFf46IgS64PQNBtvLGkCktF32rNJgYyCgiurxAFIgVYMMLyTjFAmKQz0mtdA==
X-Received: by 2002:adf:e541:0:b0:374:c64e:3ff1 with SMTP id
 ffacd0b85a97d-37cf28ad82dmr2089727f8f.17.1727800786710; 
 Tue, 01 Oct 2024 09:39:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/54] hw/misc: Remove omap_tap device
Date: Tue,  1 Oct 2024 17:39:13 +0100
Message-Id: <20241001163918.1275441-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The omap_tap device is OMAP2 only, and we are removing it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-49-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |   3 --
 hw/misc/omap_tap.c    | 117 ------------------------------------------
 hw/misc/meson.build   |   1 -
 3 files changed, 121 deletions(-)
 delete mode 100644 hw/misc/omap_tap.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 118874d8775..82721b46fa0 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -725,9 +725,6 @@ struct I2SCodec {
 struct omap_mcbsp_s;
 void omap_mcbsp_i2s_attach(struct omap_mcbsp_s *s, I2SCodec *slave);
 
-void omap_tap_init(struct omap_target_agent_s *ta,
-                struct omap_mpu_state_s *mpu);
-
 /* omap_lcdc.c */
 struct omap_lcd_panel_s;
 void omap_lcdc_reset(struct omap_lcd_panel_s *s);
diff --git a/hw/misc/omap_tap.c b/hw/misc/omap_tap.c
deleted file mode 100644
index 4d7fb7d85f1..00000000000
--- a/hw/misc/omap_tap.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * TI OMAP TEST-Chip-level TAP emulation.
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
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/arm/omap.h"
-
-/* TEST-Chip-level TAP */
-static uint64_t omap_tap_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_mpu_state_s *s = opaque;
-
-    if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x204:	/* IDCODE_reg */
-        switch (s->mpu_model) {
-        case omap2420:
-        case omap2422:
-        case omap2423:
-            return 0x5b5d902f;	/* ES 2.2 */
-        case omap2430:
-            return 0x5b68a02f;	/* ES 2.2 */
-        case omap3430:
-            return 0x1b7ae02f;	/* ES 2 */
-        default:
-            hw_error("%s: Bad mpu model\n", __func__);
-        }
-
-    case 0x208:	/* PRODUCTION_ID_reg for OMAP2 */
-    case 0x210:	/* PRODUCTION_ID_reg for OMAP3 */
-        switch (s->mpu_model) {
-        case omap2420:
-            return 0x000254f0;	/* POP ESHS2.1.1 in N91/93/95, ES2 in N800 */
-        case omap2422:
-            return 0x000400f0;
-        case omap2423:
-            return 0x000800f0;
-        case omap2430:
-            return 0x000000f0;
-        case omap3430:
-            return 0x000000f0;
-        default:
-            hw_error("%s: Bad mpu model\n", __func__);
-        }
-
-    case 0x20c:
-        switch (s->mpu_model) {
-        case omap2420:
-        case omap2422:
-        case omap2423:
-            return 0xcafeb5d9;	/* ES 2.2 */
-        case omap2430:
-            return 0xcafeb68a;	/* ES 2.2 */
-        case omap3430:
-            return 0xcafeb7ae;	/* ES 2 */
-        default:
-            hw_error("%s: Bad mpu model\n", __func__);
-        }
-
-    case 0x218:	/* DIE_ID_reg */
-        return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    case 0x21c:	/* DIE_ID_reg */
-        return 0x54 << 24;
-    case 0x220:	/* DIE_ID_reg */
-        return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    case 0x224:	/* DIE_ID_reg */
-        return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_tap_write(void *opaque, hwaddr addr,
-                           uint64_t value, unsigned size)
-{
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    OMAP_BAD_REG(addr);
-}
-
-static const MemoryRegionOps omap_tap_ops = {
-    .read = omap_tap_read,
-    .write = omap_tap_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-void omap_tap_init(struct omap_target_agent_s *ta,
-                struct omap_mpu_state_s *mpu)
-{
-    memory_region_init_io(&mpu->tap_iomem, NULL, &omap_tap_ops, mpu, "omap.tap",
-                          omap_l4_region_size(ta, 0));
-    omap_l4_attach(ta, 0, &mpu->tap_iomem);
-}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 122084b1694..b7e97e47cf9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -76,7 +76,6 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
 system_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
   'omap_l4.c',
-  'omap_tap.c',
 ))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_mbox.c',
-- 
2.34.1


