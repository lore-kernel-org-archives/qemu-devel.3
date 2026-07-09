Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634B2C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfCE-0005Pi-IE; Wed, 08 Jul 2026 23:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfCD-0005PP-Be
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:13:05 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1whfCB-0005yX-Qb
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:13:05 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-37fc02e660bso502063a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783566782; x=1784171582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dOlaHkDVo2fS7llYKd3HgpxhrbHqdexVmAk0QASwx1Q=;
 b=BcCY2DkE7J5aEUhCBbYwc4I1T2dDyuO2OOLLDG1P+HqtpzxS/te9dEcqUesCpRh0s0
 xuflX1kyo6m/97qcL8cLwq8hghIPRPLhLsTWwRf2H0ZM8J4EmSSgCEHyCUufVXSrGwaj
 hYOuyeXdixLYc3u6XWkHLDrMfL8V3lgE04nYFbeNFd+tonEiyvEgrRf61DwWkvwbYoDn
 HiDfGPfWgnVjTpcFGZGQX4fOWu/TXnUlEgvBEy7+FTspjD59/5GzAifZx+CwKyVP0ZjS
 yNz66iGoL3Jo60ls/iopkVPSjbOor0OTRYkXSRfiGHbe96k+mzP/k7RDO0wbBkdobSJQ
 mKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783566782; x=1784171582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dOlaHkDVo2fS7llYKd3HgpxhrbHqdexVmAk0QASwx1Q=;
 b=LkbBSpMw+012a6mCBjO2S9B0GWWSYyPLho1oNt8lacK5o9q95h0p5/arm191FWm9Bo
 G08mOVu/9zecT5DPR09Pm1oQNA6wX6pZFURFhkkNwvXUXzPpWqtjhUK/ipGXNbE4DoDX
 oxg/1lOotgLg+Yx8ts58nM8jBYS1WuknBcGjY2ZB0UrmjlasMx8rCz0CM7hlzBIhzGti
 g1gMHVd+nUw0VTpPkhn5rSjIACx0maVqeDSqxrraVWcptsLsliB1rHC4zknfWrF1FiSO
 XHltLgl8LB0/PbxVVsajUJc+eDSzHnTA03bt+V8g1zeF38PSUdmxj4PBDj3DYyBwWuBs
 Xpmw==
X-Gm-Message-State: AOJu0YwW/QGHmXgm1JUP90u0keU0q09tfammFZWpVCSoVMT2eqxb4TB/
 s3KGPjHklVvOzmYomS9PgaVkMECALYG/Y131gtiQP/t7MNBVyyaUYtvfMRKsvJnR
X-Gm-Gg: AfdE7cmmmm/GF2vjC7eMYeB4HqpLRXPqtOjW9XghjUjYscKAYxihfRTE/3vX8x0YsJO
 LgKkgSUhpepSGTTA8Ce3D5V0EE1cdKXCjveQO9PU3R/UfDSFzKvexhZq1qNw9FMh8VnExpxqC88
 jk9vJSnO7/MAPwUqb/0qEIa0r8opNAMewdCRVvc589N5ClKNitzIKy0lN1jRml60OyJIXo+8hwo
 Q6q+3vxyuiM/7R9RxH+5nnLiPqniHCwyWRFOZAw0F0PetPffXKJdrbv+iBLZVogw115RmYnv/J9
 R85264O/Kd4VE6XBDaXOipFcfc6/RvZuZsBmBkZh0MJ9AUgfMXYEdV5ILcLZirRJ2drPBN+5FWp
 QwD3qk+wivfsN8UwTYf48cOLOJHqh0GrLU6UJUUIZQfZOYJpFKAsESwuPOtbMMJHw/BghG40o1Q
 GB0E/koCIZv2xOysAGxmZ0yD+hHuQW
X-Received: by 2002:a17:90b:4b86:b0:381:610b:e77d with SMTP id
 98e67ed59e1d1-38941cc4c9cmr5085387a91.29.1783566782424; 
 Wed, 08 Jul 2026 20:13:02 -0700 (PDT)
Received: from localhost.localdomain ([212.135.212.213])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a5516949asm392988a91.1.2026.07.08.20.12.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jul 2026 20:13:01 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <163wangjack@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:K230 Machines)
Subject: [RFC PATCH 2/2] hw/riscv/k230: wire up the RMU device
Date: Thu,  9 Jul 2026 11:12:37 +0800
Message-ID: <20260709031237.21284-3-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709031237.21284-1-163wangjack@gmail.com>
References: <20260709031237.21284-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jack Wang <163wangjack@gmail.com>

Replace the "rmu" create_unimplemented_device() stub with a real
K230RmuState instance mapped at the K230_DEV_RMU memmap entry, select
K230_RMU from the K230 Kconfig, and document the device.

Closes: gevico/qemu-camp-2026-k230#11
Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
 docs/system/riscv/k230.rst |  1 +
 hw/riscv/Kconfig           |  1 +
 hw/riscv/k230.c            | 10 +++++++---
 include/hw/riscv/k230.h    |  2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..3f2313a127 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
+* K230 Reset Management Unit (RMU)
 * 5 UART
 
 Boot options
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..bffa4e69c8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -149,3 +149,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_RMU
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 502281c52c..b55e90c0d2 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-rmu",  &s->rmu,    TYPE_K230_RMU);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -206,6 +207,12 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* RMU (reset management unit) */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rmu), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rmu), 0, memmap[K230_DEV_RMU].base);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -268,9 +275,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
                                 memmap[K230_DEV_CMU].size);
 
-    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
-                                memmap[K230_DEV_RMU].size);
-
     create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
                                 memmap[K230_DEV_BOOT].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..13f2a1ab0b 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/misc/k230_rmu.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230RmuState rmu;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
-- 
2.53.0


