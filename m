Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939DDC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rYt-0003Or-QX; Sun, 30 Aug 2026 22:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYr-0003OB-Vi
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:50 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYq-0007Xd-CJ
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2378316a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142547; x=1788747347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EEiUbMbW/MI8AGgrTJhmMkX6IzYkEgELvPtrWZws5s=;
 b=EAPd7fS0g5d7XnKPR8CLkpzpzVHLvR0PrgzcQQmGvu4j4171RJgBcW6ovtlIzV5IVg
 tW++8LFJfdcG9DsF+uKdfb5tpac2ww97eP9SzIhyB7zxMX+G/VX8Pcf8d5xAlmCv3626
 pJQJy8/y0ycGFMomSarlf2BA31gRC3kLuidNU2wsBnb9Ue5v4NrkMtB5bbrIFzOzMEN6
 icyKjlHufxWl+RRWlB3zbvN2fPfmSVx4+Lk5zGHSaLjm9pwxDwktXrJs+nWKy2zAa0oZ
 sSfoGZmC5DHDV/5lEsJUuFUaAZu2hiiVIn6HxQQ1l/mYpbnTBzcruf+GsoAxBQCEIsKA
 N9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142547; x=1788747347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1EEiUbMbW/MI8AGgrTJhmMkX6IzYkEgELvPtrWZws5s=;
 b=gYh0hoOewn5hEJNpOcYJ6gWUHYHYWCfDN8iy2FJuGkX2kBNZ/4EUQUoIKXEyJfxEaF
 n5rSrufhvYbMG9vu36u9c/XaTD1ZqXMRBL1qHZ9lfw9zTRJX/Jmop4LuiXJqbjxpoXAp
 9PicGPhEQSDfJyndcD+QsgkAepeBZkNV+CYzIa5q/atymjyb0tAnqCyL26suz2voJ3hp
 RBHh+g5eIolmvZkcL90UcFk0iY5s/lnGy+qOc9rJI0QJhjsy1FxwZ4ivnWbJw9Uu9UCU
 /JM01X3mGf7efndRzlx1LBbqdEF8GRuJvixGvYRZdzyflrgOhhj8x34DGpR/WU2GPO9Q
 rchQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlfU71Z0cPfcULfsPjfHjLh6LWnHcFU02ftvGz6ZjL6qL7RYoTzBsUt27XNel2CAselMxYDIIh4Vst@nongnu.org
X-Gm-Message-State: AFuF++l6a8K5UxZXsfektJotsI1ZO2UDYo7gx7DLIM+PD0uNcpyvnogV
 iJEyBLvG3pJu7qMW4aa5/dY6ekYCIBzq9sRS41TSPyreQPwj2Zke84gd
X-Gm-Gg: AYBFou3U+Nm2EHftDMcsr880Sbnx/s9uSI5MmcnCEVRcBuOzkdDEnyVwjavwAd7MvtP
 YGX7ZUWZJIYQRochSA3Gzdqymar8zLIEXk6995hxbFBDRQSsB4NSYi+l315A4gjYGhVxr7oqOHV
 bXPoTzoqKEw/omK1uAXE+QeR03sVpE3otqFw2i+6UtimoYKUr5f6uUiu9fXb6/JF0K44v9d5fOl
 hIeBzm1mCBzj+X3oOz2B2qLisgo5SOZkgD+ultS5YP3lj0ArxAVh6t569kz3vhraRzpybmf41ZX
 FeuWxeLPg+7yCMUy1PF4qLJUEkDEH2/KdxoPr22Ig0n2mHDAxsrEDFwuXRc1vakCkHoDkmqWTxw
 zW5S3XXgnB2biq5nmakUKahOSHnJONuhnHAz9wgHLqKHriIAugl5nRYT7aC4iKRSRdvho3a6FaZ
 sF+MBLQ/+geGECiGyKj3fZHyf3NE9B22TP8AYbag1JbSl0tCA0FK+cUQNf0zSV/3+kKriJG0OGW
 bF3c5DkX9AVcT90SuS+N+5NoEcGf6FA4w/bkmx3QVavOsc4fWGV62VqDHxBv8XIoGBMG6yBSS08
 2zcuK2jq//mIOX4PZ3YE
X-Received: by 2002:a17:90b:264d:b0:398:dcf6:d40e with SMTP id
 98e67ed59e1d1-398f86d88a2mr371377a91.17.1788142546874; 
 Sun, 30 Aug 2026 19:15:46 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:15:46 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
Date: Mon, 31 Aug 2026 11:44:44 +0930
Message-ID: <20260831021500.82565-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

riscv_imsic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/intc/riscv_imsic.h | 3 ++-
 hw/intc/riscv_imsic.c         | 6 ++++--
 hw/riscv/aia.c                | 6 ++++--
 hw/riscv/xiangshan_kmh.c      | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index fae999731dff..8295b1f14452 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -62,7 +62,8 @@ struct RISCVIMSICState {
     uint32_t num_irqs;
 };
 
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *mr, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids);
 
 #endif
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index d6b46cdca220..26dd10a0462c 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -495,7 +495,8 @@ type_init(riscv_imsic_register_types)
 /*
  * Create IMSIC device.
  */
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *mr, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids)
 {
     DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
@@ -518,7 +519,8 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(mr, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     if (!kvm_irqchip_in_kernel()) {
         for (i = 0; i < num_pages; i++) {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 651552c8f970..49cb14349f00 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -52,7 +52,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * m_imsic_stride,
+                riscv_imsic_create(mr,
+                                   addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
@@ -61,7 +62,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
         /* Per-socket S-level IMSICs */
         addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
         for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * s_imsic_stride,
+            riscv_imsic_create(mr,
+                               addr + i * s_imsic_stride,
                                base_hartid + i, false, 1 + aia_guests,
                                num_msis);
         }
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 94f9d02a00b9..9eb608f8c578 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -65,14 +65,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     /* M-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+        riscv_imsic_create(get_system_memory(),
+                           addr + i * IMSIC_HART_SIZE(0), i, true,
                            1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
     }
 
     /* S-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr +
+        riscv_imsic_create(get_system_memory(), addr +
                            i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
                            i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
                            XIANGSHAN_KMH_IMSIC_NUM_IDS);
-- 
2.47.3


