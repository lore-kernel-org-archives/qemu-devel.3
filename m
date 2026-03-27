Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A47610ED662
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CJ-00076o-Or; Fri, 27 Mar 2026 07:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CF-00073k-6U
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CB-0008Ii-Sx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486b96760easo22060375e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610262; x=1775215062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dm3ZhTnNkibm1ZUH9sNTVGo5VIBCJ1V2I2Dxuffa51g=;
 b=CZ9uepkdyVB8hTCoZDl4FMflOT5L7YSA/+p0orqA0YFzzV5MW2C+xXgillkFLW3gGo
 C7gnKNKz+vsx1QGl1ge2ov6/ObXHsigVCOeMmUBSukvqyzRQ9q1khXxrspP+oik+pAgB
 6gCB3oODjz6zFS28V6EjaaihbRySmuJcLrvecE1bFUb4SnBLLAwVH6Nnim+fv0sCcvL4
 ZbLehn5pr5mEDBOWG8AHNC/GT41tc/J3xdfXbvu/+zC9DQErppJnZdO57E5UeQeRzhjs
 Nq6EPvCKarDUnqVAKoCfWBw7OmqiprI7PHczU77bg5sNstXeu1egN7YTdZdORuplv6y/
 5SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610262; x=1775215062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dm3ZhTnNkibm1ZUH9sNTVGo5VIBCJ1V2I2Dxuffa51g=;
 b=TgSA+Np7/tuLxEzaWHxo6IeuCpuQ9O0vkrxE42j9eQDHeMU8trDMbM6o/Bt8EspVPF
 tMh3Ve04HPfAR8xWSCDKCdD2bBpAT1iTSwaiyCc6CiiHD1wj3RBlUYECGE4n8E3JwCV2
 Ap4XGpqwtSvtHOBFtGvb1XEsgNoMUFAQNj82gPKrwejfzydOEoiFPm0Ha7OQFYp5n8o+
 gUY5nORzhsCpFwKYB93AHqLoDnj6rxzsDMrO+IcXpR9kir+gxC5WpWkGNF2GbPvrHPb7
 9LL/5CB6OV9sPpcGnTia1O0DwiRBfHTCg/NSUe5GYbhnIouBcU8SGlPe9SE14WoNHi3y
 yjgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6c+zlNNn2ygNkiAcKzoVADKdIY4D6u0e2lDlow6NmUJBdM/CzGxUcSgTzEO4oVRb+RwzwX2ZIgchf@nongnu.org
X-Gm-Message-State: AOJu0Yw/HDYjFvnS6MFD2JWhCe2e2H7+djWnRU4lEe4yfKP4fmRbnX5f
 MbRiqDfgftT4G3cbsKHUSXECfgsoslk6K1ffoWNOyKDlc40oA9BTz3jfzvtzVx+VvAQLzzQGgdh
 qVwH0Zbo=
X-Gm-Gg: ATEYQzy4VOexuaYOIWPoZz/XopfR8X1rHYbFuAiDiBrEpGEEgeP69CJ/AsHDgQp7j9J
 d9/V//1wvb+6iZLLp6tR89YiLTppEwU/pU7OynJx2a2+1LPZUXMHkDEZQu0827q9aey5DAYZxQH
 Iq9Y/T9QDnKbsyo/TPqaaHND6kW/EruNBuR78X9W/rIDpb2Znhhhcr9TI7a5yEO826elmmN+o7/
 OJ7//JJy8sIXXsc25Ernf0oQ8qRWO642n/lqClnwiq8i4Sn2y12fLqJOtXM+g3LQgz8+jf6OVqP
 wILK23A2fh89kKyf+viQvA0THT2Z9lnsd//dyO8YCsJm+45bTF5vpojkE+2OQuYuiNKb9nzhVK9
 gouRDvYOrReknMt7VYNOXFuV0ULnCIa3XQQxuhwiPFDwTgJScWn9jE423ddiN/lyXnIsZHvF0aH
 t2t9OkwoQ15rCwUdwTWiRq6fIAYX7oClh5ag30wWj+h+FNbwGsnNMhXN3eOgd7eMnsyAibCJKZY
 R4LxYTO6iXTeei5CB+rn25UB+aLZUA=
X-Received: by 2002:a05:600c:1f13:b0:487:169:9f64 with SMTP id
 5b1f17b1804b1-48727d73709mr34294785e9.12.1774610262053; 
 Fri, 27 Mar 2026 04:17:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 42/65] target/arm: GICv5 cpuif: Calculate the highest
 priority PPI
Date: Fri, 27 Mar 2026 11:16:37 +0000
Message-ID: <20260327111700.795099-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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
index 5966ebde05..eaed42f49f 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -12,6 +12,8 @@
 #ifndef HW_INTC_ARM_GICv5_TYPES_H
 #define HW_INTC_ARM_GICv5_TYPES_H
 
+#include "hw/core/registerfields.h"
+
 /*
  * The GICv5 has four physical Interrupt Domains. This numbering must
  * match the encoding used in IRS_IDR0.INT_DOM.
@@ -86,4 +88,23 @@ typedef enum GICv5TriggerMode {
 
 #define PRIO_IDLE 0xff
 
+/*
+ * We keep track of candidate highest possible pending interrupts
+ * using this struct.
+ *
+ * Unlike GICv3, we don't need a separate NMI bool, because for GICv5
+ * superpriority is signaled by @prio == 0.
+ *
+ * In this struct the intid includes the interrupt type in bits
+ * [31:29] (i.e. it is in the form defined by R_TJPHS).
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
index d7c4095b39..85a3ab293f 100644
--- a/meson.build
+++ b/meson.build
@@ -3684,6 +3684,7 @@ if have_system or have_user
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
index 33e4762ef4..6f8062ba17 100644
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
+     * Recalculate the HPPI PPI: this is the best PPI which is
+     * enabled, pending and not active.
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


