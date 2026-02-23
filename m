Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF9EC1115
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZLa-00030g-KP; Mon, 23 Feb 2026 12:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKr-0002aD-1M
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKo-0000Kd-LC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso34588105e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866181; x=1772470981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uf0z29WMtG/mt6ISfZ3ohk7fvcxH24A5mMic2WNxUsI=;
 b=OvGqPGZPpv0MEYDXE5SCt++tHL3F3J7Ze7ibQdnWmGYbUNdG5eJq+mLyHXBBcb7unv
 0YLkkvUxQh+2t3PLWg9BZFms/4e6yh+1pjlihJ3bAldM7P3k+cAAntyCPn8sQLuG9DRj
 Ku8FZljvGcoR5QF/bZm9QJxBH3VwrCDeVSOsKpxMYXDcD85L7yxGqKDr8VyHIJPqLnew
 Oj81WY8+xmuCPIQmQbtyxu8jrdnQSYD1YRD2QeMfZ+SMERKRY0gIlIgonYh/kK4PGb3s
 guV6BDsR302aR7ThWTb6CjaeqeunZfiEHw7SHbrRDq8Gobmlr7m8gg0nvbkMiOycOQ4V
 m/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866181; x=1772470981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uf0z29WMtG/mt6ISfZ3ohk7fvcxH24A5mMic2WNxUsI=;
 b=KWs3A8iutes0uqqWCH+gIvcuerP7kbWJIul44hU5K8ulh9E+VYwTLy60QLjo1Tb3sB
 sNfwMHa7U1Nx/T1LwpMuqpGHGNT9v8yVYCppZbJjLwgTuzhWIhVn5Mo5LpSXGR2hA/1i
 2rjfK6MkO7ow9Boxgn4atRU8vqpTjoVE7PzH+8kTMy0L47liODObDk8YCgW0IlY6lmkn
 QOfTKd+isKb2Fcy3J3S7sV/ZKgJEb/6WhfHONPPkRJ7deZox1+T2vz0oPbsvdqmOCZBK
 GfN+q80cduStHyf8fZhzEx01hMwRDsY5Toka5N3rhVHah0ID2wy4p+QGNn4Lpl8Tmu+4
 Gl1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9id+7J3Qa9lz8KTibTd7W0JkQba1ZcVKQN1gjC6BtZDWg6AQISufEFIZTJobcu4AIVmzyCyz5Omd6@nongnu.org
X-Gm-Message-State: AOJu0YwTtRKpA02WJ3RqTNadisXHaAhh4XdzODs63++rI9eMuQModsdc
 MqncCPTAMDAtPVr5PklLdTIx3ay1+y4RtoausvM3mO77nKIcgcAN0cvMZo0d8tTAM24=
X-Gm-Gg: AZuq6aLN82Gg4F4oFEJELiOPQNTILPD56E/3/uO24BEoLhJszam90K5/i31xN6KddBn
 QeokzaKqzjDBo8leAeynKxMhbexLSrl5T5QO3+UcdojRH1KAUVxCZmhTuqrZcNy0QMWQD7sGHxN
 7NYanCVldiavHWc0qANQeR/sgHrYVBabyh8nDWFAwQNkKOWa/bSFm2EJRvLQ2tj0A0ywL/0Pvzb
 aa6i/EvL2zJ7tqsvrEeM8WVgI4txhvRMPBZCN3AXR4rDWY7J+0aobEfNIa9xTB6om8oEwtMFkMw
 C93vePH4S4FaKpJ9kSZRtWdqNgZqMEoA1ZayA3hFjiiZkolL+phXo4Q+82lwwfDDffyQuVz/yFG
 v9QC4qtJ1SdbfsPTfe33AUKmMOCVAAij3m5iaZwUcvwy3EhgOOfyPBNK4WAbqN+wYvJTOgW8FkE
 /FfRezbUDXzuuVSH0v9FUFuaE7ZFWo+lPQMJfCmYnWWuyWkLJ/U+l5zovbimakzMtIgiUxekDu+
 IjKapjm3VJ54fkv0ttxWZ+Ez5fbcuM=
X-Received: by 2002:a05:600c:6291:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-483a95b7157mr164235445e9.12.1771866181091; 
 Mon, 23 Feb 2026 09:03:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 41/65] target/arm: GICv5 cpuif: Calculate the highest priority
 PPI
Date: Mon, 23 Feb 2026 17:01:48 +0000
Message-ID: <20260223170212.441276-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

When the state of PPIs changes, recalculate the highest priority PPI.
In subsequent commits we will use this cached value to provide the
HPPI info to the guest, decide whether to signal IRQ or FIQ, handle
interrupt acknowldge from the guest, and so on.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv5_types.h | 21 +++++++++++
 meson.build                       |  1 +
 target/arm/cpu.h                  |  3 ++
 target/arm/tcg/gicv5-cpuif.c      | 58 +++++++++++++++++++++++++++++++
 target/arm/tcg/trace-events       |  5 +++
 target/arm/tcg/trace.h            |  1 +
 6 files changed, 89 insertions(+)
 create mode 100644 target/arm/tcg/trace-events
 create mode 100644 target/arm/tcg/trace.h

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index b69ad137aa..2c552cd3c5 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -12,6 +12,8 @@
 #ifndef HW_INTC_ARM_GICv5_TYPES_H
 #define HW_INTC_ARM_GICv5_TYPES_H
 
+#include "hw/core/registerfields.h"
+
 /*
  * The GICv5 has four physical Interrupt Domains. This numbering
  * must match the encoding used in IRS_IDR0.INT_DOM.
@@ -87,4 +89,23 @@ typedef enum GICv5TriggerMode {
 
 #define PRIO_IDLE 0xff
 
+/*
+ * We keep track of candidate highest possible pending interrupts
+ * using this struct.
+ *
+ * Unlike GICv3, we don't need a separate NMI bool, because for
+ * GICv5 superpriority is signaled by @prio == 0.
+ *
+ * In this struct the intid includes the interrupt type in bits [31:29]
+ * (i.e. it is in the form defined by R_TJPHS).
+ */
+typedef struct GICv5PendingIrq {
+    uint32_t intid;
+    uint8_t prio;
+} GICv5PendingIrq;
+
+/* Fields in a generic 32-bit INTID, per R_TJPHS */
+FIELD(INTID, ID, 0, 24)
+FIELD(INTID, TYPE, 29, 3)
+
 #endif
diff --git a/meson.build b/meson.build
index 414c8ea7e2..04b87c1ee6 100644
--- a/meson.build
+++ b/meson.build
@@ -3665,6 +3665,7 @@ if have_system or have_user
     'hw/core',
     'target/arm',
     'target/arm/hvf',
+    'target/arm/tcg',
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6841b6748f..e0a7d02386 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -612,6 +612,9 @@ typedef struct CPUArchState {
         uint64_t ppi_enable[GICV5_NUM_PPIS / 64];
         /* The PRIO regs have 1 byte per PPI, so 8 PPIs to a register */
         uint64_t ppi_priority[GICV5_NUM_PPIS / 8];
+
+        /* Cached highest-priority pending PPI for each domain */
+        GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index d0521ce7fd..48cf14b4d0 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -11,6 +11,7 @@
 #include "internals.h"
 #include "cpregs.h"
 #include "hw/intc/arm_gicv5_stream.h"
+#include "trace.h"
 
 FIELD(GIC_CDPRI, ID, 0, 24)
 FIELD(GIC_CDPRI, TYPE, 29, 3)
@@ -105,6 +106,57 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
     return hap < 32 ? hap : PRIO_IDLE;
 }
 
+static void gic_recalc_ppi_hppi(CPUARMState *env)
+{
+    /*
+     * Recalculate the HPPI PPI: this is the best PPI which
+     * is enabled, pending and not active.
+     */
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_hppi); i++) {
+        env->gicv5_cpuif.ppi_hppi[i].intid = 0;
+        env->gicv5_cpuif.ppi_hppi[i].prio = PRIO_IDLE;
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_active); i++) {
+        uint64_t en_pend_nact = env->gicv5_cpuif.ppi_enable[i] &
+            env->gicv5_cpuif.ppi_pend[i] &
+            ~env->gicv5_cpuif.ppi_active[i];
+
+        while (en_pend_nact) {
+            /*
+             * When EL3 is supported ICC_PPI_DOMAINR<n>_EL3 tells us
+             * the domain of each PPI. While we only support EL1, the
+             * domain is always NS.
+             */
+            GICv5Domain ppi_domain = GICV5_ID_NS;
+            uint8_t prio;
+            int ppi;
+            int bit = ctz64(en_pend_nact);
+
+            en_pend_nact &= ~(1 << bit);
+
+            ppi = i * 64 + bit;
+            prio = extract64(env->gicv5_cpuif.ppi_priority[ppi / 8],
+                             (ppi & 7) * 8, 5);
+
+            if (prio < env->gicv5_cpuif.ppi_hppi[ppi_domain].prio) {
+                uint32_t intid = 0;
+
+                intid = FIELD_DP32(intid, INTID, ID, ppi);
+                intid = FIELD_DP32(intid, INTID, TYPE, GICV5_PPI);
+                env->gicv5_cpuif.ppi_hppi[ppi_domain].intid = intid;
+                env->gicv5_cpuif.ppi_hppi[ppi_domain].prio = prio;
+            }
+        }
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ppi_hppi); i++) {
+      trace_gicv5_recalc_ppi_hppi(i,
+                                  env->gicv5_cpuif.ppi_hppi[i].intid,
+                                  env->gicv5_cpuif.ppi_hppi[i].prio);
+    }
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -200,6 +252,7 @@ static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t old = raw_read(env, ri);
     raw_write(env, ri, old & ~value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -207,6 +260,7 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint64_t old = raw_read(env, ri);
     raw_write(env, ri, old | value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -217,6 +271,7 @@ static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
     raw_write(env, ri, old & ~value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -227,18 +282,21 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
     raw_write(env, ri, old | value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_ppi_hppi(env);
 }
 
 static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
     raw_write(env, ri, value);
+    gic_recalc_ppi_hppi(env);
 }
 
 /*
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
new file mode 100644
index 0000000000..7dc5f781c5
--- /dev/null
+++ b/target/arm/tcg/trace-events
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# See docs/devel/tracing.rst for syntax documentation.
+
+# gicv5-cpuif.c
+gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
diff --git a/target/arm/tcg/trace.h b/target/arm/tcg/trace.h
new file mode 100644
index 0000000000..c6e89d018b
--- /dev/null
+++ b/target/arm/tcg/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm_tcg.h"
-- 
2.43.0


