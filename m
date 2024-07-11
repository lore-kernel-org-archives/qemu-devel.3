Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB047C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueq-0000zG-Co; Thu, 11 Jul 2024 10:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRuem-0000aj-Lh; Thu, 11 Jul 2024 10:20:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueV-0005l5-U2; Thu, 11 Jul 2024 10:20:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b4267ccfcso860154b3a.3; 
 Thu, 11 Jul 2024 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707605; x=1721312405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puAh8AKYBf/kGCM5eTy9qpxHcT0Dr7J5AOeGF/jG3KU=;
 b=lOmlJKmcak+KypOBR4qOYhoSIB/Qfl4VtwEcvXsjTX5h2slmAMDQ91XITQ0fNJEC6a
 u2aLBhL2Wx4TJ+o7ekJgO9HfJQnXDy8tufcdt/y1SUM7LN3jkHT2tJS8T0uwFpzIiFyf
 f6JbAzORuxGQC8h1TH4zOaDKjz8GIrrTDDmvPTHDVifoCXvmTf6jGtDD+KhTk0Jd+LBn
 XtopgZsuzadNfVFk5uadabgCwnaPDuXXZv50YttQ2X0V5w3ZKbNpP0pVpXrDnLP7DGwr
 yM5BYFyah2bt1QwW3idjOitiJ3Q2++iWDuMv38leJ87QtJ2NirJmEhd5tsK9ncEFff3m
 4sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707605; x=1721312405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puAh8AKYBf/kGCM5eTy9qpxHcT0Dr7J5AOeGF/jG3KU=;
 b=n7i+8GT2VxVbXsDf4MuSBuB+l9/XB5i0Hq9XkJcMRjQbUSAwsGK6QDJX69VmKF88vu
 5HYpkh58Gd3EzKlqjfGDOZZKuttUGqrlTCFT8BpDteH2zLKG8KRfuJgEwZ4oQb2WMQxT
 1BLMogMriqCIgvYK3r9Y6asUVo8tEwREkTXOIT93ZmoqJ1tGQJgQd3c8L9eBdDPJStrm
 D09iqIu3Cpqja6+YfTkKwMaT4tytb6rCw4OtxD++U7nfgt48J2LzWGHXJ/u2hGLvp5d9
 odVjmCbvy5BSLhSAIK73i2jBjZ8O2D9qDpE0cgT+3/qRtl8HtjZqSmDydT57dRNeAYxg
 riuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM+e1Ck2ycdkg8B8nZiGNJ5D4XH/L/2WkvlJXPI+F6LN9Qf3zmVLgRtXTRAf4jd1hL2n7W/MwXetikXnvI/QGQ7sxr3nE=
X-Gm-Message-State: AOJu0YwYQ4VCPbmxX17/gzT8/0VGx419Rt7tJw3IZFSwU1FkfEhrSUiW
 zTTKPGIkzSSRCPgpFmXQa1MFuxkLI7Y4VaxVzwSUXFarFsOQI6C41C0BepJo
X-Google-Smtp-Source: AGHT+IFMKA7tZ5qDKUtNRAHXbPiklf/iIerMRuWnFHR9EGTee/JqCdLXThrWqJjIAuUEQ8unbJnnNA==
X-Received: by 2002:a05:6a00:b45:b0:705:a450:a9a2 with SMTP id
 d2e1a72fcca58-70b435561ebmr10320089b3a.13.1720707605256; 
 Thu, 11 Jul 2024 07:20:05 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:20:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 17/18] ppc/pnv: Implement POWER10 PC xscom registers for
 direct controls
Date: Fri, 12 Jul 2024 00:18:49 +1000
Message-ID: <20240711141851.406677-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PC unit in the processor core contains xscom registers that provide
low level status and control of the CPU.

This implements "direct controls" sufficient for OPAL (skiboot) firmware
use, which is to stop threads and send them non-maskable IPIs in the
form of SRESET interrupts.

POWER10 is sufficiently different (particularly QME and special wakeup)
from POWER9 that it is not trivial to implement by reusing the code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/core/cpu.h     |  8 ++++
 include/hw/ppc/pnv.h      |  2 +
 include/hw/ppc/pnv_core.h |  3 ++
 hw/ppc/pnv.c              | 19 +++++++--
 hw/ppc/pnv_core.c         | 88 ++++++++++++++++++++++++++++++++++++---
 system/cpus.c             | 10 +++++
 6 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..410e7d6f03 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -984,6 +984,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
  */
 void cpu_exit(CPUState *cpu);
 
+/**
+ * cpu_pause:
+ * @cpu: The CPU to pause.
+ *
+ * Resumes CPU, i.e. puts CPU into stopped state.
+ */
+void cpu_pause(CPUState *cpu);
+
 /**
  * cpu_resume:
  * @cpu: The CPU to resume.
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c56d152889..b7858d310d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
 
+void pnv_cpu_do_nmi_resume(CPUState *cs);
+
 /*
  * BMC helpers
  */
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c8784777a4..1de79a818e 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -109,6 +109,9 @@ OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
 struct PnvQuad {
     DeviceState parent_obj;
 
+    bool special_wakeup_done;
+    bool special_wakeup[4];
+
     uint32_t quad_id;
     MemoryRegion xscom_regs;
     MemoryRegion xscom_qme_regs;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 575f18958d..71b2b3806c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2747,11 +2747,24 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
          */
         env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
+    if (arg.host_int) {
+        cpu_resume(cs);
+    }
+}
+
+static void pnv_cpu_do_nmi(CPUState *cs, int resume)
+{
+    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(resume));
+}
+
+void pnv_cpu_do_nmi_resume(CPUState *cs)
+{
+    pnv_cpu_do_nmi(cs, 1);
 }
 
-static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
+static void do_pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
 {
-    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    pnv_cpu_do_nmi(CPU(cpu), 0);
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
@@ -2760,7 +2773,7 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
-        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
+        pnv_chip_foreach_cpu(pnv->chips[i], do_pnv_cpu_do_nmi, NULL);
     }
 }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e03ac5441e..a685a5dc1b 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -185,16 +185,40 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  */
 
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
+#define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
+#define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
     uint64_t val = 0;
 
     switch (offset) {
     case PNV10_XSCOM_EC_CORE_THREAD_STATE:
-        val = 0;
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (cs->halted) {
+                val |= PPC_BIT(56 + i);
+            }
+        }
+        break;
+    case PNV10_XSCOM_EC_CORE_THREAD_INFO:
+        break;
+    case PNV10_XSCOM_EC_CORE_RAS_STATUS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+            if (cs->stopped) {
+                val |= PPC_BIT(0 + 8*i) | PPC_BIT(1 + 8*i);
+            }
+        }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
@@ -207,9 +231,45 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
 
     switch (offset) {
+    case PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (val & PPC_BIT(7 + 8*i)) { /* stop */
+                val &= ~PPC_BIT(7 + 8*i);
+                cpu_pause(cs);
+            }
+            if (val & PPC_BIT(6 + 8*i)) { /* start */
+                val &= ~PPC_BIT(6 + 8*i);
+                cpu_resume(cs);
+            }
+            if (val & PPC_BIT(4 + 8*i)) { /* sreset */
+                val &= ~PPC_BIT(4 + 8*i);
+                pnv_cpu_do_nmi_resume(cs);
+            }
+            if (val & PPC_BIT(3 + 8*i)) { /* clear maint */
+                /*
+                 * Hardware has very particular cases for where clear maint
+                 * must be used and where start must be used to resume a
+                 * thread. These are not modelled exactly, just treat
+                 * this and start the same.
+                 */
+                val &= ~PPC_BIT(3 + 8*i);
+                cpu_resume(cs);
+            }
+        }
+        if (val) {
+            qemu_log_mask(LOG_UNIMP, "%s: unimp bits in DIRECT_CONTROLS 0x%016lx\n", __func__, val);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -528,6 +588,7 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
 static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
 
@@ -535,10 +596,14 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
      * Forth nibble selects the core within a quad, mask it to process read
      * for any core.
      */
-    switch (offset & ~0xf000) {
-    case P10_QME_SPWU_HYP:
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
     case P10_QME_SSH_HYP:
-        return 0;
+        val = 0;
+        if (eq->special_wakeup_done) {
+            val |= PPC_BIT(1); /* SPWU DONE */
+            val |= PPC_BIT(4); /* SSH SPWU DONE */
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -550,9 +615,22 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
+    bool set;
+    int i;
 
-    switch (offset) {
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
+    case P10_QME_SPWU_HYP:
+        set = !!(val & PPC_BIT(0));
+        eq->special_wakeup_done = set;
+        for (i = 0; i < 4; i++) {
+            /* These bits select cores in the quad */
+            if (offset & PPC_BIT32(16 + i)) {
+                eq->special_wakeup[i] = set;
+            }
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
diff --git a/system/cpus.c b/system/cpus.c
index d3640c9503..083abbc393 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -613,6 +613,16 @@ void pause_all_vcpus(void)
     bql_lock();
 }
 
+void cpu_pause(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        qemu_cpu_stop(cpu, true);
+    } else {
+        cpu->stop = true;
+        qemu_cpu_kick(cpu);
+    }
+}
+
 void cpu_resume(CPUState *cpu)
 {
     cpu->stop = false;
-- 
2.45.1


