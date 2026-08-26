Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494BEC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLl2-000586-2X; Wed, 26 Aug 2026 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLkz-00057Z-TM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:05 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLky-0004i0-8X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso310741a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781963; x=1788386763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1EEiUbMbW/MI8AGgrTJhmMkX6IzYkEgELvPtrWZws5s=;
 b=CaTAQh/EPkE9wB/aaiQCg/DMDs02RB0OCAEVadhKyABd/Boyts9MZSzkqpez+Ny+6I
 CS7ySaRgMW0PtDZf5TthWK7l3ZtR+5t3+wl8jTRyYPQ1YlbwdIOj4PtCPIrYuYCbF5O5
 e08/pAFx0raO2JgCINopTVDmPYWYAj1+xADV5S46lB6HuDz9ZYXrwWv4AhMfigw3xbyY
 5pCKPOGNBLtmWTK7gZVZafFfjC92gxt0InBd4E2idXr+6NfT9eqrU1M/F0KnkwQx+iK8
 VJPruoy5DXBh6sLVShzkZGhcbQuo+C7SJiRfQU3ejGsQSWrSTHq0y2q7+ofwhsg0MCci
 FD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781963; x=1788386763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1EEiUbMbW/MI8AGgrTJhmMkX6IzYkEgELvPtrWZws5s=;
 b=YGLVsGf1Mu3fKXXtk74Mu2yti0er8xH2s5ViqlVvJCDLdT3EB6OqNkqxWPhJKL6fHY
 7HyR3oRFpb87ermBnRuEKLimnO/xg1S0ai2PRgtf1I1qsLP4nzWEyA4qcyfxCOfRybGS
 wGiiYP8xYPipIloXG7axi/HO69E9w4h2SCuFxG1IxDcUyCmISwhBq+f3ctff0l/uJkuh
 H5QA/4+JnwnLnQMgfbBdVScztr4emIOoHgTMiuIcjRue+lMcGatXH28f4BwWxkYZEngc
 B9ih5nyNLsGTXqGy382SG7bgbYU1u/QTT0pbBoSJwrgfUxsImyTg5DDgumSU4bQbojqz
 jyPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvbNFnjS/8iay93k/sW3ak/r2DkUwv6ZYB5nI+OiDcDmAuBw7LSR9G7yWpReh/dW55HPU5UaC36hiv@nongnu.org
X-Gm-Message-State: AFuF++kXrf2l5+WaKqHDKoeEJhM8cS/jog+mxzaflJVNNIU2d8UOPXs8
 Mni9xFI2rcBCHNSPCtjdAiDnD6WL3iB0YBrRZonkmT0Eb5SVpX/+A1QL
X-Gm-Gg: AR+sD10uB7+gakCvvxHat8WoKeFutHyypm/j1tpbxt1s20iZyjW1fQqCwsDPNZFIT/g
 8ICk6K2/VjStT1TxHFPRFInavkmHpfdFuKiZloyyLQL8mMk2IBdrDAOBMAqpgEbpNFLX1ZZ2H7n
 05dbUChFiu8NZbYeMLXRNCu22nglM/vdzXsJlAjEWCE0S/X8ja0PPqMDwt0Rs6A4zBGXKbaDdjo
 82YFPgZtGzuenzLxovPNJ1/soHfowJwFV/dIbE7oqy4dsgr4SRaGpw3RCuV6m2jOkJVzlTIOAzr
 koO14882Lo12Rf6W/ZMvjWdM39Fvr8me0L5KDrY6IpoI0f+GWB8tcEC84OzBR++bo3Xj5wIJBdS
 0fUqDXHNUaPGUQ5EplUVylzMN7/o3E2Kj1u2MZWS5Nb1iusHiz+BzzvAZR7/CN4A7eA5qF0TT8r
 EnnUsaZlHlqcZcMO602/gqlYyRgoBOyG/CF67VTq7U6Zk5DFhZ8f/XPdG3/XXxzssP909gGweth
 wdXE+/EhD0SXcF4v5yIobLtzkPHiJbl6o/5B3rTt6QF+63EBE5+n1knfyw3VAYiT79dh+/v/9Xv
 wYUdIJXMMQ/Q8g1nGdm0
X-Received: by 2002:a17:90a:e7ca:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-3966d3ba166mr20146999a91.5.1787781962830; 
 Wed, 26 Aug 2026 15:06:02 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:06:02 -0700 (PDT)
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
Subject: [PATCH 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
Date: Thu, 27 Aug 2026 07:35:13 +0930
Message-ID: <20260826220528.54516-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826220528.54516-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
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


