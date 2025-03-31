Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668BFC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEqS-0001mG-66; Mon, 31 Mar 2025 09:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzEqO-0001hA-AW; Mon, 31 Mar 2025 09:06:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzEqJ-0002Pf-No; Mon, 31 Mar 2025 09:06:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so93825895ad.1; 
 Mon, 31 Mar 2025 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743426377; x=1744031177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzh1qgkhNjA1nynFGcAZCiEoUtMYQAcwvUP95TWGW8g=;
 b=TVu68iCKB+LLA0U5w95QLPIM0A5SnIup3jmOIU9cP1f8RjPEUK1AwoLNGBSJ5VEYGF
 GEVLYYg0Vk1i8LUGBnPLlcNklfADc4rLv2oF29k7JszUEgYOHFPb+lztJ/ZyhHG+wQ3J
 bzXMJouXpkSmH51cf4qO7bsVuZtBgAbetCEIuUF2syLxUqT7i/bqfqtoHDAsnqoQcN9O
 sjM/4w1LaEVrmk0vHHpvGoFcQzrlzvaPjDAVJ/Xm8dTuRnlVdQqJbVk9uGJvI99Ib0d+
 MBhFrRv/xvibk2NbqNCRZ7Fr3/1NmU0j8/zbAVV9Zxr4gOUWNUYaR/Gg2F4+DmN1xPFT
 8srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426377; x=1744031177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzh1qgkhNjA1nynFGcAZCiEoUtMYQAcwvUP95TWGW8g=;
 b=FL/k9lVYMYbhKnciTHnJqlWgTZ4CMCB7eABSyShxjO7fklbCG0O+/1EQa0EQxSSYx4
 KWKN4JIElJwXqxT9hFKCm0DRGZUJt9FSNgCAZhx66h3K4DYnMS9xlb+4Lol6XAPjd3dz
 13Lm7+9wofqQG3cUgszZwukoTEyrQScAIokEB+xfQFPiyq8Ov2WdrW7nPiFBuWuos8tK
 NrcIqV3LQGOfdTRnKOdbdccmZSn4i3M2vuNb/jZWvQUlhfeB/rdsZ9Pla3k3Co0Paprg
 sxOEijPAJFY+R5kdgL2EP5NmAVVBLZRgRx9dQuJYnj9a2EETQ3SUYgfKBiWZZFbOt7NO
 rCYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnQvoBd2oKNWjUS1lZCJeTndZiyOIGt+VdERtzU6C/jYQy+yXSZJ+gbpiFtn23spFME8Fmsw1gj37z@nongnu.org
X-Gm-Message-State: AOJu0Yx0+gHuvKe0QYbkusmC7jhJcKQwZCjf2M+xlCToIJ0yZwZjwZvT
 TiqmjZ/NXHWC/3tRtI7ADerpGnMpAdDALISgCFhRYcP5vj1FSewSmjjEfw==
X-Gm-Gg: ASbGnctZfxTpJSODsa+3VQuUuCTl6fwQ4acEYEhoSqL0PLs22BnFw2jHC3ESkqeLibj
 LRnMouOWJME30ht8cbvx1QKFvonWrESvixw1mj3+cXvqTA8mAPx29saITHToOg0eXPiA75kLJyE
 nW5vQI/nMbRX1AXDOYBHP5PgTPzl7rzSeQw/lra6695NGtQfAWO0NpGsZMOOvcmAT57mBESiAl8
 h9Wb50jJr0HXVvvY9MIqFPx9+dXpobmq7If9RhBGQY8sA8ktiBPHxGf6V2yIxrUip7M2N8xo8jr
 HvV6OzHzZDdoxmVvkb10yFZmSnHeuVgHbTQIiWxox3SFSc9RtA==
X-Google-Smtp-Source: AGHT+IEl73pDOYIiEfpH5LgLwZzrMcbsRfIcgZjh+4nCYUqAnyRGQ6XmQHicvRxD+G/fkYJp61Irag==
X-Received: by 2002:a17:902:ccd0:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-2292f947b68mr122537525ad.8.1743426377322; 
 Mon, 31 Mar 2025 06:06:17 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ecbb3sm68310955ad.235.2025.03.31.06.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:06:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH] pnv/xive: Expand implementation of XIVE physical thread
 enables
Date: Mon, 31 Mar 2025 23:06:09 +1000
Message-ID: <20250331130610.607706-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Clearing the physical thread enable register should reset the
TCTX state and reject accesses to it. xive currently does not
model this.

skiboot firmware uses this register to reset the XIVE TIMA state
(see xive_reset_enable_thread()), which can be in an arbitrary state
e.g., when called by OPAL_XIVE_RESET after kexec, or by skiboot's
fast-reboot feature).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I posted a skiboot patch to detect an improperly reset TIMA and warn,
which fires before this QEMU patch and is solved afterward.

https://lists.ozlabs.org/pipermail/skiboot/2025-March/019172.html

A not-yet posted QEMU xive patch that checks for validity of TIMA
operations based on whether or not CAM rings are enabled is what
detected this issue in the first place.

This implementation seems to solve the problem.

Thanks,
Nick

 include/hw/ppc/xive.h |   1 +
 hw/intc/pnv_xive.c    | 126 ++++++++++++++++++++++++++++++++----------
 hw/intc/pnv_xive2.c   | 122 +++++++++++++++++++++++++++++-----------
 hw/intc/xive.c        |  11 ++++
 hw/intc/trace-events  |   2 +
 5 files changed, 202 insertions(+), 60 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 538f4386817..a61e973eaa3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -352,6 +352,7 @@ struct XiveTCTX {
     DeviceState parent_obj;
 
     CPUState    *cs;
+    bool        cpu_enabled; /* Physical Thread Enabled (used by pnv_xive) */
     qemu_irq    hv_output;
     qemu_irq    os_output;
 
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ccbe95a58ea..10ee3de0d50 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -455,21 +455,6 @@ static int pnv_xive_set_pq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
     return 0;
 }
 
-/*
- * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
- * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
- * second register covers cores 16-23 (normal) or 8-11 (fused).
- */
-static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
-{
-    int pir = ppc_cpu_pir(cpu);
-    uint32_t fc = PNV9_PIR2FUSEDCORE(pir);
-    uint64_t reg = fc < 8 ? PC_THREAD_EN_REG0 : PC_THREAD_EN_REG1;
-    uint32_t bit = pir & 0x3f;
-
-    return xive->regs[reg >> 3] & PPC_BIT(bit);
-}
-
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool crowd, bool cam_ignore, uint8_t priority,
@@ -486,15 +471,13 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
 
         for (j = 0; j < cc->nr_threads; j++) {
             PowerPCCPU *cpu = pc->threads[j];
-            XiveTCTX *tctx;
+            XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
             int ring;
 
-            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+            if (!tctx->cpu_enabled) {
                 continue;
             }
 
-            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-
             /*
              * Check the thread context CAM lines and record matches.
              */
@@ -545,13 +528,10 @@ static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
  */
 static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
 {
-    int pir = ppc_cpu_pir(cpu);
-    XivePresenter *xptr = XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
+    XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+    XivePresenter *xptr = tctx->xptr;
     PnvXive *xive = PNV_XIVE(xptr);
 
-    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
-        xive_error(xive, "IC: CPU %x is not enabled", pir);
-    }
     return xive;
 }
 
@@ -902,6 +882,76 @@ static void pnv_xive_vst_set_data(PnvXive *xive, uint64_t vsd, bool pc_engine)
     }
 }
 
+/*
+ * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
+ * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
+ * second register covers cores 16-23 (normal) or 8-11 (fused).
+ */
+static bool pnv_xive_is_cpu_thread_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir = ppc_cpu_pir(cpu);
+    uint32_t fc = PNV9_PIR2FUSEDCORE(pir);
+    uint64_t reg = fc < 8 ? PC_THREAD_EN_REG0 : PC_THREAD_EN_REG1;
+    uint32_t bit = pir & 0x3f;
+
+    return xive->regs[reg >> 3] & PPC_BIT(bit);
+}
+
+/*
+ * Check for updates to CPU physical thread enable register and bring
+ * cpu threads up and down. When a thread is disabled:
+ * - All the associated processor exception lines are set inactive.
+ * - A FIR bit is set on any CI operations to the associated TIMA.
+ * - Any CI store data to the associated TIMA is ignored.
+ * - All load response data to the associated TIMA is all ones.
+ * - All TIMA context values are reset to zero.
+ */
+static void pnv_xive_update_cpu_thread_enables(PnvXive *xive)
+{
+    PnvChip *chip = xive->chip;
+    int i, j;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        for (j = 0; j < cc->nr_threads; j++) {
+            PowerPCCPU *cpu = pc->threads[j];
+            XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+            if (pnv_xive_is_cpu_thread_enabled(xive, cpu)) {
+                if (tctx->cpu_enabled) {
+                    continue;
+                }
+                trace_pnv_xive_pter_enable(tctx->cs->cpu_index);
+                tctx->cpu_enabled = true;
+            } else {
+                if (!tctx->cpu_enabled) {
+                    continue;
+                }
+                trace_pnv_xive_pter_disable(tctx->cs->cpu_index);
+                xive_tctx_reset(tctx); /* This clears ->cpu_enabled */
+            }
+        }
+    }
+}
+
+static bool __pnv_xive_check_tctx_enabled(const char *func, XiveTCTX *tctx)
+{
+    if (tctx->cpu_enabled) {
+        return true;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: CPU[%d] invalid write access to TIMA "
+                                   "with physical thread enable cleared\n",
+                                   tctx->cs->cpu_index);
+    /* TODO: This should set a FIR bit */
+    return false;
+}
+
+#define pnv_xive_check_tctx_enabled(tctx)        \
+            __pnv_xive_check_tctx_enabled(__func__, tctx)
+
 /*
  * Interrupt controller MMIO region. The layout is compatible between
  * 4K and 64K pages :
@@ -1138,15 +1188,19 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
 
     case PC_THREAD_EN_REG0_SET:
         xive->regs[PC_THREAD_EN_REG0 >> 3] |= val;
+        pnv_xive_update_cpu_thread_enables(xive);
         break;
     case PC_THREAD_EN_REG1_SET:
         xive->regs[PC_THREAD_EN_REG1 >> 3] |= val;
+        pnv_xive_update_cpu_thread_enables(xive);
         break;
     case PC_THREAD_EN_REG0_CLR:
         xive->regs[PC_THREAD_EN_REG0 >> 3] &= ~val;
+        pnv_xive_update_cpu_thread_enables(xive);
         break;
     case PC_THREAD_EN_REG1_CLR:
         xive->regs[PC_THREAD_EN_REG1 >> 3] &= ~val;
+        pnv_xive_update_cpu_thread_enables(xive);
         break;
 
     /*
@@ -1575,6 +1629,7 @@ static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXive *xive)
     PnvChip *chip = xive->chip;
     uint64_t tctxt_indir = xive->regs[PC_TCTXT_INDIR0 >> 3];
     PowerPCCPU *cpu = NULL;
+    XiveTCTX *tctx;
     int pir;
 
     if (!(tctxt_indir & PC_TCTXT_INDIR_VALID)) {
@@ -1589,12 +1644,9 @@ static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXive *xive)
         return NULL;
     }
 
-    /* Check that HW thread is XIVE enabled */
-    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
-        xive_error(xive, "IC: CPU %x is not enabled", pir);
-    }
+    tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 
-    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+    return tctx;
 }
 
 static void xive_tm_indirect_write(void *opaque, hwaddr offset,
@@ -1602,6 +1654,10 @@ static void xive_tm_indirect_write(void *opaque, hwaddr offset,
 {
     XiveTCTX *tctx = pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
 
+    if (!pnv_xive_check_tctx_enabled(tctx)) {
+        return;
+    }
+
     xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size);
 }
 
@@ -1610,6 +1666,10 @@ static uint64_t xive_tm_indirect_read(void *opaque, hwaddr offset,
 {
     XiveTCTX *tctx = pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
 
+    if (!pnv_xive_check_tctx_enabled(tctx)) {
+        return -1;
+    }
+
     return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
 }
 
@@ -1634,6 +1694,10 @@ static void pnv_xive_tm_write(void *opaque, hwaddr offset,
     PnvXive *xive = pnv_xive_tm_get_xive(cpu);
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 
+    if (!pnv_xive_check_tctx_enabled(tctx)) {
+        return;
+    }
+
     xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
 }
 
@@ -1643,6 +1707,10 @@ static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigned size)
     PnvXive *xive = pnv_xive_tm_get_xive(cpu);
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 
+    if (!pnv_xive_check_tctx_enabled(tctx)) {
+        return -1;
+    }
+
     return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);
 }
 
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 0b81dad6ba5..90bdde01e20 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "system/reset.h"
 #include "system/qtest.h"
+#include "trace.h"
 
 #include <libfdt.h>
 
@@ -612,16 +613,6 @@ static uint32_t pnv_xive2_get_config(Xive2Router *xrtr)
     return cfg;
 }
 
-static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
-{
-    int pir = ppc_cpu_pir(cpu);
-    uint32_t fc = PNV10_PIR2FUSEDCORE(pir);
-    uint64_t reg = fc < 8 ? TCTXT_EN0 : TCTXT_EN1;
-    uint32_t bit = pir & 0x3f;
-
-    return xive->tctxt_regs[reg >> 3] & PPC_BIT(bit);
-}
-
 static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
                                bool crowd, bool cam_ignore, uint8_t priority,
@@ -640,15 +631,13 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
 
         for (j = 0; j < cc->nr_threads; j++) {
             PowerPCCPU *cpu = pc->threads[j];
-            XiveTCTX *tctx;
+            XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
             int ring;
 
-            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
+            if (!tctx->cpu_enabled) {
                 continue;
             }
 
-            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-
             if (gen1_tima_os) {
                 ring = xive_presenter_tctx_match(xptr, tctx, format, nvt_blk,
                                                  nvt_idx, cam_ignore,
@@ -721,15 +710,13 @@ static int pnv_xive2_broadcast(XivePresenter *xptr,
 
         for (j = 0; j < cc->nr_threads; j++) {
             PowerPCCPU *cpu = pc->threads[j];
-            XiveTCTX *tctx;
+            XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
             int ring;
 
-            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
+            if (!tctx->cpu_enabled) {
                 continue;
             }
 
-            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-
             if (gen1_tima_os) {
                 ring = xive_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
                                                  nvt_idx, ignore, 0);
@@ -758,13 +745,10 @@ static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
  */
 static PnvXive2 *pnv_xive2_tm_get_xive(PowerPCCPU *cpu)
 {
-    int pir = ppc_cpu_pir(cpu);
-    XivePresenter *xptr = XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
+    XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+    XivePresenter *xptr = tctx->xptr;
     PnvXive2 *xive = PNV_XIVE2(xptr);
 
-    if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
-        xive2_error(xive, "IC: CPU %x is not enabled", pir);
-    }
     return xive;
 }
 
@@ -1734,6 +1718,71 @@ static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static bool pnv_xive2_is_cpu_thread_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
+{
+    int pir = ppc_cpu_pir(cpu);
+    uint32_t fc = PNV10_PIR2FUSEDCORE(pir);
+    uint64_t reg = fc < 8 ? TCTXT_EN0 : TCTXT_EN1;
+    uint32_t bit = pir & 0x3f;
+
+    return xive->tctxt_regs[reg >> 3] & PPC_BIT(bit);
+}
+
+/*
+ * Check for updates to CPU physical thread enable register and bring
+ * cpu threads up and down. When a thread is disabled:
+ * - All the associated processor exception lines are set inactive.
+ * - A FIR bit is set on any CI operations to the associated TIMA.
+ * - Any CI store data to the associated TIMA is ignored.
+ * - All load response data to the associated TIMA is all ones.
+ * - All TIMA context values are reset to zero.
+ */
+static void pnv_xive2_update_cpu_thread_enables(PnvXive2 *xive)
+{
+    PnvChip *chip = xive->chip;
+    int i, j;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        for (j = 0; j < cc->nr_threads; j++) {
+            PowerPCCPU *cpu = pc->threads[j];
+            XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+            if (pnv_xive2_is_cpu_thread_enabled(xive, cpu)) {
+                if (tctx->cpu_enabled) {
+                    continue;
+                }
+                trace_pnv_xive_pter_enable(tctx->cs->cpu_index);
+                tctx->cpu_enabled = true;
+            } else {
+                if (!tctx->cpu_enabled) {
+                    continue;
+                }
+                trace_pnv_xive_pter_disable(tctx->cs->cpu_index);
+                xive_tctx_reset(tctx); /* This clears ->cpu_enabled */
+            }
+        }
+    }
+}
+
+static bool __pnv_xive2_check_tctx_enabled(const char *func, XiveTCTX *tctx)
+{
+    if (tctx->cpu_enabled) {
+        return true;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: CPU[%d] invalid write access to TIMA "
+                                   "with physical thread enable cleared\n",
+                                   tctx->cs->cpu_index);
+    /* TODO: This should set a FIR bit */
+    return false;
+}
+
+#define pnv_xive2_check_tctx_enabled(tctx)        \
+            __pnv_xive2_check_tctx_enabled(__func__, tctx)
+
 static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
                                      uint64_t val, unsigned size)
 {
@@ -1768,6 +1817,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
         xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
         return;
     }
+    pnv_xive2_update_cpu_thread_enables(xive);
 }
 
 static const MemoryRegionOps pnv_xive2_ic_tctxt_ops = {
@@ -2099,6 +2149,7 @@ static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
 {
     PnvChip *chip = xive->chip;
     PowerPCCPU *cpu = NULL;
+    XiveTCTX *tctx;
 
     cpu = pnv_chip_find_cpu(chip, pir);
     if (!cpu) {
@@ -2106,11 +2157,9 @@ static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
         return NULL;
     }
 
-    if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
-        xive2_error(xive, "IC: CPU %x is not enabled", pir);
-    }
+    tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 
-    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+    return tctx;
 }
 
 static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
@@ -2127,7 +2176,9 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
+        if (pnv_xive2_check_tctx_enabled(tctx)) {
+            val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
+        }
     }
 
     return val;
@@ -2146,7 +2197,9 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
+        if (pnv_xive2_check_tctx_enabled(tctx)) {
+            xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
+        }
     }
 }
 
@@ -2175,7 +2228,9 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
     XivePresenter *xptr = XIVE_PRESENTER(xive);
 
-    xive_tctx_tm_write(xptr, tctx, offset, value, size);
+    if (pnv_xive2_check_tctx_enabled(tctx)) {
+        xive_tctx_tm_write(xptr, tctx, offset, value, size);
+    }
 }
 
 static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
@@ -2184,8 +2239,13 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
     PnvXive2 *xive = pnv_xive2_tm_get_xive(cpu);
     XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
     XivePresenter *xptr = XIVE_PRESENTER(xive);
+    uint64_t val = -1;
 
-    return xive_tctx_tm_read(xptr, tctx, offset, size);
+    if (pnv_xive2_check_tctx_enabled(tctx)) {
+        val = xive_tctx_tm_read(xptr, tctx, offset, size);
+    }
+
+    return val;
 }
 
 static const MemoryRegionOps pnv_xive2_tm_ops = {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3eb28c2265d..1f10a8ea32d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -677,6 +677,8 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
 
     trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
 
+    g_assert(tctx->cpu_enabled);
+
     /*
      * TODO: check V bit in Q[0-3]W2
      */
@@ -716,6 +718,13 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     const XiveTmOp *xto;
     uint64_t ret;
 
+    if (!tctx->cpu_enabled) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA "
+                                       "with physical thread enable cleared\n");
+        /* TODO: This should set a FIR bit */
+        return -1;
+    }
+
     /*
      * TODO: check V bit in Q[0-3]W2
      */
@@ -822,6 +831,8 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
 
 void xive_tctx_reset(XiveTCTX *tctx)
 {
+    tctx->cpu_enabled = false;
+
     memset(tctx->regs, 0, sizeof(tctx->regs));
 
     /* Set some defaults */
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 0ba9a02e739..1452dc58c2a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -291,6 +291,8 @@ xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uin
 xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
 
 # pnv_xive.c
+pnv_xive_pter_enable(int cpu_index) "CPU[%d]"
+pnv_xive_pter_disable(int cpu_index) "CPU[%d]"
 pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
 
 # goldfish_pic.c
-- 
2.47.1


