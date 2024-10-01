Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A2CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfvx-0007iG-9j; Tue, 01 Oct 2024 12:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svful-0005ii-GC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuf-0006AX-Bb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so52533025e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800788; x=1728405588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lwsHTtg6rTbPZPYtEry2/6Zbdr+xpcaEOCG17/iy/9Y=;
 b=X5EXXK9w5iypQUSGE/HWtZSHxnQnzYt0671JsdknlOb0vflXPwjjQyL3ER1qb76feN
 4nfVFQoVQjrSy2y3hbbdepXsmMzY2c9uh+jw8yhRuQgE/IyeoaKVELgZQwU8rxjlqQoF
 wbWaEtO8Xj58z5fuAHAWm+yvjGiRO9f+kIhEAMN76gUPe2rLveQeSvOXJcm7CiQNnPUk
 uxZ8gkzOpkQihQ/mSdsKL3ZFIp8SNaV7s1em/MrzdrwZIAyvXF3MySiD7q6APSljSEdP
 seW6ns6pDq8/yTtsWr2NHnJBn1aKa/9JBY3wM7/Hq2R7+WoCJdh/yJhJkXTPS+oyJVIl
 DqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800788; x=1728405588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwsHTtg6rTbPZPYtEry2/6Zbdr+xpcaEOCG17/iy/9Y=;
 b=i6VSTVLdNmVZN5sOceeRbGxpLwVdf1l269onlEjbJgYFnKRPKnwF1WEljrBDlYH8++
 H5Og1VyzMO2v/34g9FUGdEbGSW672G8Trp0f0pC8AzuCjZuMH6mbZmIYyq6BLbyDWJ58
 s9HWl7zX6wN/0CHGLbV0FTTKIm7M/mEp4IJXGRtUP+sfm6SHQhtWLtSdQZt+jnIXomzW
 Zh1ng8e68wKRcpSu9wxrAhku/xTdXbtzPFgqanDi5TYuYOaPkuGcxYPIcXSY75R5XZ6h
 hJ4RdiTz8TktnVQ4SXQxXImP7W/IIvF7B+ZgkYYyVe/1uT9T3WUJhJmvdrA6mQ1CtagZ
 BZbg==
X-Gm-Message-State: AOJu0YxWyLs8TCFfjbj16z1mmZz2W1kYN8qorPNJs761kaPiepP5l8C6
 4Y6PlyHYlc2GNE2aqnF44Q6hjjwfiAhoeLRUP6unMx7Q4Lp6KOLS8YH+h4aAyU3pz4lrW+kx+5S
 O
X-Google-Smtp-Source: AGHT+IGSX/XsaLi/ogK19Y51AC5l08BhyBQmpJeaB5ojcPeoMmkHfLYE9F6kj99pMrC9U4TNYoBWWQ==
X-Received: by 2002:a05:600c:1d08:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-42f777b1f6emr1111915e9.4.1727800787708; 
 Tue, 01 Oct 2024 09:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/54] hw/misc: Remove omap_l4 device
Date: Tue,  1 Oct 2024 17:39:15 +0100
Message-Id: <20241001163918.1275441-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The omap_l4 device is OMAP2 only, so we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-51-peter.maydell@linaro.org
---
 include/hw/arm/omap.h |  42 -----------
 hw/misc/omap_l4.c     | 162 ------------------------------------------
 hw/misc/meson.build   |   1 -
 3 files changed, 205 deletions(-)
 delete mode 100644 hw/misc/omap_l4.c

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 2300b97716d..f82b820d4d8 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -108,45 +108,6 @@ DECLARE_INSTANCE_CHECKER(Omap1GpioState, OMAP1_GPIO,
 /* TODO: clock framework (see above) */
 void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk);
 
-/* OMAP2 l4 Interconnect */
-struct omap_l4_s;
-struct omap_l4_region_s {
-    hwaddr offset;
-    size_t size;
-    int access;
-};
-struct omap_l4_agent_info_s {
-    int ta;
-    int region;
-    int regions;
-    int ta_region;
-};
-struct omap_target_agent_s {
-    MemoryRegion iomem;
-    struct omap_l4_s *bus;
-    int regions;
-    const struct omap_l4_region_s *start;
-    hwaddr base;
-    uint32_t component;
-    uint32_t control;
-    uint32_t status;
-};
-struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
-                               hwaddr base, int ta_num);
-
-struct omap_target_agent_s;
-struct omap_target_agent_s *omap_l4ta_get(
-    struct omap_l4_s *bus,
-    const struct omap_l4_region_s *regions,
-    const struct omap_l4_agent_info_s *agents,
-    int cs);
-hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
-                                         int region, MemoryRegion *mr);
-hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
-                                       int region);
-hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
-                                       int region);
-
 /*
  * Common IRQ numbers for level 1 interrupt handler
  * See /usr/include/asm-arm/arch-omap/irqs.h in Linux.
@@ -890,9 +851,6 @@ struct omap_mpu_state_s {
         uint16_t dsp_idlect2;
         uint16_t dsp_rstct2;
     } clkm;
-
-    /* OMAP2-only peripherals */
-    struct omap_l4_s *l4;
 };
 
 /* omap1.c */
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
deleted file mode 100644
index b7875489da3..00000000000
--- a/hw/misc/omap_l4.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * TI OMAP L4 interconnect emulation.
- *
- * Copyright (C) 2007-2009 Nokia Corporation
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
-struct omap_l4_s {
-    MemoryRegion *address_space;
-    hwaddr base;
-    int ta_num;
-    struct omap_target_agent_s ta[];
-};
-
-struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
-                               hwaddr base, int ta_num)
-{
-    struct omap_l4_s *bus = g_malloc0(
-                    sizeof(*bus) + ta_num * sizeof(*bus->ta));
-
-    bus->address_space = address_space;
-    bus->ta_num = ta_num;
-    bus->base = base;
-
-    return bus;
-}
-
-hwaddr omap_l4_region_base(struct omap_target_agent_s *ta,
-                                       int region)
-{
-    return ta->bus->base + ta->start[region].offset;
-}
-
-hwaddr omap_l4_region_size(struct omap_target_agent_s *ta,
-                                       int region)
-{
-    return ta->start[region].size;
-}
-
-static uint64_t omap_l4ta_read(void *opaque, hwaddr addr, unsigned size)
-{
-    struct omap_target_agent_s *s = opaque;
-
-    if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
-    }
-
-    switch (addr) {
-    case 0x00:	/* COMPONENT */
-        return s->component;
-
-    case 0x20:	/* AGENT_CONTROL */
-        return s->control;
-
-    case 0x28:	/* AGENT_STATUS */
-        return s->status;
-    }
-
-    OMAP_BAD_REG(addr);
-    return 0;
-}
-
-static void omap_l4ta_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    struct omap_target_agent_s *s = opaque;
-
-    if (size != 4) {
-        omap_badwidth_write32(opaque, addr, value);
-        return;
-    }
-
-    switch (addr) {
-    case 0x00:	/* COMPONENT */
-    case 0x28:	/* AGENT_STATUS */
-        OMAP_RO_REG(addr);
-        break;
-
-    case 0x20:	/* AGENT_CONTROL */
-        s->control = value & 0x01000700;
-        if (value & 1)					/* OCP_RESET */
-            s->status &= ~1;				/* REQ_TIMEOUT */
-        break;
-
-    default:
-        OMAP_BAD_REG(addr);
-    }
-}
-
-static const MemoryRegionOps omap_l4ta_ops = {
-    .read = omap_l4ta_read,
-    .write = omap_l4ta_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,
-        const struct omap_l4_region_s *regions,
-        const struct omap_l4_agent_info_s *agents,
-        int cs)
-{
-    int i;
-    struct omap_target_agent_s *ta = NULL;
-    const struct omap_l4_agent_info_s *info = NULL;
-
-    for (i = 0; i < bus->ta_num; i ++)
-        if (agents[i].ta == cs) {
-            ta = &bus->ta[i];
-            info = &agents[i];
-            break;
-        }
-    if (!ta) {
-        fprintf(stderr, "%s: bad target agent (%i)\n", __func__, cs);
-        exit(-1);
-    }
-
-    ta->bus = bus;
-    ta->start = &regions[info->region];
-    ta->regions = info->regions;
-
-    ta->component = ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    ta->status = 0x00000000;
-    ta->control = 0x00000200;	/* XXX 01000200 for L4TAO */
-
-    memory_region_init_io(&ta->iomem, NULL, &omap_l4ta_ops, ta, "omap.l4ta",
-                          omap_l4_region_size(ta, info->ta_region));
-    omap_l4_attach(ta, info->ta_region, &ta->iomem);
-
-    return ta;
-}
-
-hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
-                                         int region, MemoryRegion *mr)
-{
-    hwaddr base;
-
-    if (region < 0 || region >= ta->regions) {
-        fprintf(stderr, "%s: bad io region (%i)\n", __func__, region);
-        exit(-1);
-    }
-
-    base = ta->bus->base + ta->start[region].offset;
-    if (mr) {
-        memory_region_add_subregion(ta->bus->address_space, base, mr);
-    }
-
-    return base;
-}
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b7e97e47cf9..a2951951b59 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -75,7 +75,6 @@ system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
-  'omap_l4.c',
 ))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_mbox.c',
-- 
2.34.1


