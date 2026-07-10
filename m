Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F15C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Q1-0000PL-7C; Thu, 09 Jul 2026 22:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Py-00007O-UJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:47 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pu-0008QN-1S
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:46 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c966b9ee9cbso202892a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652200; x=1784257000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1aBYxOdNdM0M1LVW5YLXAtduBlDkMIf+QsNgh/2nAw=;
 b=hLO8ijf7uDVohNSjA1s5xyd9wHjJsDjTb5Ulvl1dFf39DGbpFhTqvG+To5yjI6dI4q
 A9Yyxy8ka9LEqUbWmJmKABO4qRH3LDpFPZ40566WeKDFiQKAB0zmVB0HTQ+ADn1gtwf/
 K6KLn3qpY9ZEH0emhMlgdKMZ+HR1lib1TgSGArDIIRl9IHFFYJMwv8c64yov1rLU8hGb
 5qoWjmO/QOb5Fsh9PxSTnkknzL8THOA69YBs4dnLeFUsLe9UZofh5xFQlZJC9lX5uXdP
 Z+zf+pvX/AzmFEg46QS19ZCqz87Wcp0xCAfUNg1wY/WNYr+CH1ZGLMhVTYcP6knSOu8X
 pvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652200; x=1784257000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X1aBYxOdNdM0M1LVW5YLXAtduBlDkMIf+QsNgh/2nAw=;
 b=VNe1U8YV7x+aGs/7/FoY7Gj2akqltidbV4gwCaBNgUhnjOVQ7ZFjSHJB8GjDHGHpjM
 EFxBuoSt7jFKBqYkssQeJHTGoAWk94frWA4+XvRzlzn+M2zBG3Y+1IXsDbVxvcr9GBkr
 N/vUWwMNxG5gB+YwDKznhpn85g4pljT+j9vuHETjEPdpWok1tbkgHiMDdaH834R7klk2
 JaU3AwAxVWYDiioA454Hb7TCkxYA+weIZxzXF0QAUg73OkFQF0KS9VsQvcEsLs4mjdUn
 I2Jh71Ou6MbbNXVcUoswCI0MbUnlXdccY3xltWh9cMkpo+Yg+iPZBW9/xpRDq9b87Msp
 TNbw==
X-Gm-Message-State: AOJu0YwN94hYpDZzPhyY6jc3v2XI/teBBVR/t+H1z04mI9ekpYgDLpWH
 7/Y4oSuz+GtBMxIwQU41Iktqf1Chpln396gBriCeYve3nZTMBXYc8xuOvzL96w==
X-Gm-Gg: AfdE7clLOSHEEKiQxEgpaE6IazEr6U1JQfPw+dFbBdkR4rVxVHwnFK0SjLIUuvaHtO3
 UE9UGTC4TqP/n1WIeWnJB5pnoS8zmMAGmKT9SC6i4P9wsbFM7n/a6jFjfWBBDEWahK1gKbM5p/o
 z2RqmutwXS3ldIreeRUtVU0tfrx8dNkmK3gOnOnF8ZtnDEnHFfIxwtx5RXFKkUVxe2eycVH8B0K
 MeKYXaLXXedou2PWRjm3DmtjSaNdafrkKBu8pKhrbtyVJ/11dX9uir+Ns40TsrCdd3GcC7DARFO
 Prph69yeQadwPUP7Bthrjt6M5NPRFelu6iyZFIdfS+31cwmSiuVUA9dpzJkDqbPinhmE234QRw0
 lSP/rXfLdnDKu1/Pse8G6G7CiPSFtOZtp2QDFS1sL4kJSKIMV05g68UsRaNuLpzlhh4vYvIUFlg
 Qm8CIe+M8IAOcqmoLKZMvmgrZO41esGA4jhDIKw9f9Pw==
X-Received: by 2002:a05:6a20:6f04:b0:3b7:9c18:c681 with SMTP id
 adf61e73a8af0-3c0bce21d5bmr12525047637.9.1783652199963; 
 Thu, 09 Jul 2026 19:56:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/40] target/riscv: move some irq helpers to cpu.c
Date: Fri, 10 Jul 2026 12:55:04 +1000
Message-ID: <20260710025525.1704417-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_cpu_has_work() uses a handful of irq pending functions from
cpu_helper.c.  There is a very high possibility that KVM doesn't need
the current implermentation of has_work(), but the common accel code
needs an implementation of this callback (see cpu_exec_class_post_init)
otherwise the KVM driver won't initialize.

Move the relevant irq helpers to cpu.c to allow KVM to keep using the
current has_work implementation, allowing --disable-tcg to work.  We'll
circle it back to evaluate a proper KVM implementation for it in a later
date.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-14-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |   5 +
 target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
 target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
 3 files changed, 192 insertions(+), 187 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 82430ecec6..396d9253e6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -640,6 +640,11 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env);
 int riscv_cpu_mirq_pending(CPURISCVState *env);
 int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio);
+
+
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 508e8dc03e..fe24751379 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -745,6 +745,193 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
 }
 
 #ifndef CONFIG_USER_ONLY
+/*
+ * Default priorities of local interrupts are defined in the
+ * RISC-V Advanced Interrupt Architecture specification.
+ *
+ * ----------------------------------------------------------------
+ *  Default  |
+ *  Priority | Major Interrupt Numbers
+ * ----------------------------------------------------------------
+ *  Highest  | 47, 23, 46, 45, 22, 44,
+ *           | 43, 21, 42, 41, 20, 40
+ *           |
+ *           | 11 (0b),  3 (03),  7 (07)
+ *           |  9 (09),  1 (01),  5 (05)
+ *           | 12 (0c)
+ *           | 10 (0a),  2 (02),  6 (06)
+ *           |
+ *           | 39, 19, 38, 37, 18, 36,
+ *  Lowest   | 35, 17, 34, 33, 16, 32
+ * ----------------------------------------------------------------
+ */
+static const uint8_t default_iprio[64] = {
+    /* Custom interrupts 48 to 63 */
+    [63] = IPRIO_MMAXIPRIO,
+    [62] = IPRIO_MMAXIPRIO,
+    [61] = IPRIO_MMAXIPRIO,
+    [60] = IPRIO_MMAXIPRIO,
+    [59] = IPRIO_MMAXIPRIO,
+    [58] = IPRIO_MMAXIPRIO,
+    [57] = IPRIO_MMAXIPRIO,
+    [56] = IPRIO_MMAXIPRIO,
+    [55] = IPRIO_MMAXIPRIO,
+    [54] = IPRIO_MMAXIPRIO,
+    [53] = IPRIO_MMAXIPRIO,
+    [52] = IPRIO_MMAXIPRIO,
+    [51] = IPRIO_MMAXIPRIO,
+    [50] = IPRIO_MMAXIPRIO,
+    [49] = IPRIO_MMAXIPRIO,
+    [48] = IPRIO_MMAXIPRIO,
+
+    /* Custom interrupts 24 to 31 */
+    [31] = IPRIO_MMAXIPRIO,
+    [30] = IPRIO_MMAXIPRIO,
+    [29] = IPRIO_MMAXIPRIO,
+    [28] = IPRIO_MMAXIPRIO,
+    [27] = IPRIO_MMAXIPRIO,
+    [26] = IPRIO_MMAXIPRIO,
+    [25] = IPRIO_MMAXIPRIO,
+    [24] = IPRIO_MMAXIPRIO,
+
+    [47] = IPRIO_DEFAULT_UPPER,
+    [23] = IPRIO_DEFAULT_UPPER + 1,
+    [46] = IPRIO_DEFAULT_UPPER + 2,
+    [45] = IPRIO_DEFAULT_UPPER + 3,
+    [22] = IPRIO_DEFAULT_UPPER + 4,
+    [44] = IPRIO_DEFAULT_UPPER + 5,
+
+    [43] = IPRIO_DEFAULT_UPPER + 6,
+    [21] = IPRIO_DEFAULT_UPPER + 7,
+    [42] = IPRIO_DEFAULT_UPPER + 8,
+    [41] = IPRIO_DEFAULT_UPPER + 9,
+    [20] = IPRIO_DEFAULT_UPPER + 10,
+    [40] = IPRIO_DEFAULT_UPPER + 11,
+
+    [11] = IPRIO_DEFAULT_M,
+    [3]  = IPRIO_DEFAULT_M + 1,
+    [7]  = IPRIO_DEFAULT_M + 2,
+
+    [9]  = IPRIO_DEFAULT_S,
+    [1]  = IPRIO_DEFAULT_S + 1,
+    [5]  = IPRIO_DEFAULT_S + 2,
+
+    [12] = IPRIO_DEFAULT_SGEXT,
+
+    [10] = IPRIO_DEFAULT_VS,
+    [2]  = IPRIO_DEFAULT_VS + 1,
+    [6]  = IPRIO_DEFAULT_VS + 2,
+
+    [39] = IPRIO_DEFAULT_LOWER,
+    [19] = IPRIO_DEFAULT_LOWER + 1,
+    [38] = IPRIO_DEFAULT_LOWER + 2,
+    [37] = IPRIO_DEFAULT_LOWER + 3,
+    [18] = IPRIO_DEFAULT_LOWER + 4,
+    [36] = IPRIO_DEFAULT_LOWER + 5,
+
+    [35] = IPRIO_DEFAULT_LOWER + 6,
+    [17] = IPRIO_DEFAULT_LOWER + 7,
+    [34] = IPRIO_DEFAULT_LOWER + 8,
+    [33] = IPRIO_DEFAULT_LOWER + 9,
+    [16] = IPRIO_DEFAULT_LOWER + 10,
+    [32] = IPRIO_DEFAULT_LOWER + 11,
+};
+
+uint8_t riscv_cpu_default_priority(int irq)
+{
+    if (irq < 0 || irq > 63) {
+        return IPRIO_MMAXIPRIO;
+    }
+
+    return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
+};
+
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio)
+{
+    int irq, best_irq = RISCV_EXCP_NONE;
+    unsigned int prio, best_prio = UINT_MAX;
+
+    if (!pending) {
+        return RISCV_EXCP_NONE;
+    }
+
+    irq = ctz64(pending);
+    if (!((extirq == IRQ_M_EXT) ? riscv_cpu_cfg(env)->ext_smaia :
+                                  riscv_cpu_cfg(env)->ext_ssaia)) {
+        return irq;
+    }
+
+    pending = pending >> irq;
+    while (pending) {
+        prio = iprio[irq];
+        if (!prio) {
+            if (irq == extirq) {
+                prio = extirq_def_prio;
+            } else {
+                prio = (riscv_cpu_default_priority(irq) < extirq_def_prio) ?
+                       1 : IPRIO_MMAXIPRIO;
+            }
+        }
+        if ((pending & 0x1) && (prio <= best_prio)) {
+            best_irq = irq;
+            best_prio = prio;
+        }
+        irq++;
+        pending = pending >> 1;
+    }
+
+    return best_irq;
+}
+
+/*
+ * Doesn't report interrupts inserted using mvip from M-mode firmware or
+ * using hvip bits 13:63 from HS-mode. Those are returned in
+ * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
+ */
+uint64_t riscv_cpu_all_pending(CPURISCVState *env)
+{
+    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
+    uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
+    uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
+
+    return (env->mip | vsgein | vstip) & env->mie;
+}
+
+int riscv_cpu_mirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
+                    ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+
+    return riscv_cpu_pending_to_irq(env, IRQ_M_EXT, IPRIO_DEFAULT_M,
+                                    irqs, env->miprio);
+}
+
+int riscv_cpu_sirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
+    uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
+
+    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
+                                    irqs | irqs_f, env->siprio);
+}
+
+int riscv_cpu_vsirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
+    uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
+    uint64_t vsbits;
+
+    /* Bring VS-level bits to correct position */
+    vsbits = irqs & VS_MODE_INTERRUPTS;
+    irqs &= ~VS_MODE_INTERRUPTS;
+    irqs |= vsbits >> 1;
+
+    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
+                                    (irqs | irqs_f_vs), env->hviprio);
+}
+
 bool riscv_cpu_has_work(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 310c18db46..250bb20481 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -330,193 +330,6 @@ int riscv_cpu_hviprio_index2irq(int index, int *out_irq, int *out_rdzero)
     return 0;
 }
 
-/*
- * Default priorities of local interrupts are defined in the
- * RISC-V Advanced Interrupt Architecture specification.
- *
- * ----------------------------------------------------------------
- *  Default  |
- *  Priority | Major Interrupt Numbers
- * ----------------------------------------------------------------
- *  Highest  | 47, 23, 46, 45, 22, 44,
- *           | 43, 21, 42, 41, 20, 40
- *           |
- *           | 11 (0b),  3 (03),  7 (07)
- *           |  9 (09),  1 (01),  5 (05)
- *           | 12 (0c)
- *           | 10 (0a),  2 (02),  6 (06)
- *           |
- *           | 39, 19, 38, 37, 18, 36,
- *  Lowest   | 35, 17, 34, 33, 16, 32
- * ----------------------------------------------------------------
- */
-static const uint8_t default_iprio[64] = {
-    /* Custom interrupts 48 to 63 */
-    [63] = IPRIO_MMAXIPRIO,
-    [62] = IPRIO_MMAXIPRIO,
-    [61] = IPRIO_MMAXIPRIO,
-    [60] = IPRIO_MMAXIPRIO,
-    [59] = IPRIO_MMAXIPRIO,
-    [58] = IPRIO_MMAXIPRIO,
-    [57] = IPRIO_MMAXIPRIO,
-    [56] = IPRIO_MMAXIPRIO,
-    [55] = IPRIO_MMAXIPRIO,
-    [54] = IPRIO_MMAXIPRIO,
-    [53] = IPRIO_MMAXIPRIO,
-    [52] = IPRIO_MMAXIPRIO,
-    [51] = IPRIO_MMAXIPRIO,
-    [50] = IPRIO_MMAXIPRIO,
-    [49] = IPRIO_MMAXIPRIO,
-    [48] = IPRIO_MMAXIPRIO,
-
-    /* Custom interrupts 24 to 31 */
-    [31] = IPRIO_MMAXIPRIO,
-    [30] = IPRIO_MMAXIPRIO,
-    [29] = IPRIO_MMAXIPRIO,
-    [28] = IPRIO_MMAXIPRIO,
-    [27] = IPRIO_MMAXIPRIO,
-    [26] = IPRIO_MMAXIPRIO,
-    [25] = IPRIO_MMAXIPRIO,
-    [24] = IPRIO_MMAXIPRIO,
-
-    [47] = IPRIO_DEFAULT_UPPER,
-    [23] = IPRIO_DEFAULT_UPPER + 1,
-    [46] = IPRIO_DEFAULT_UPPER + 2,
-    [45] = IPRIO_DEFAULT_UPPER + 3,
-    [22] = IPRIO_DEFAULT_UPPER + 4,
-    [44] = IPRIO_DEFAULT_UPPER + 5,
-
-    [43] = IPRIO_DEFAULT_UPPER + 6,
-    [21] = IPRIO_DEFAULT_UPPER + 7,
-    [42] = IPRIO_DEFAULT_UPPER + 8,
-    [41] = IPRIO_DEFAULT_UPPER + 9,
-    [20] = IPRIO_DEFAULT_UPPER + 10,
-    [40] = IPRIO_DEFAULT_UPPER + 11,
-
-    [11] = IPRIO_DEFAULT_M,
-    [3]  = IPRIO_DEFAULT_M + 1,
-    [7]  = IPRIO_DEFAULT_M + 2,
-
-    [9]  = IPRIO_DEFAULT_S,
-    [1]  = IPRIO_DEFAULT_S + 1,
-    [5]  = IPRIO_DEFAULT_S + 2,
-
-    [12] = IPRIO_DEFAULT_SGEXT,
-
-    [10] = IPRIO_DEFAULT_VS,
-    [2]  = IPRIO_DEFAULT_VS + 1,
-    [6]  = IPRIO_DEFAULT_VS + 2,
-
-    [39] = IPRIO_DEFAULT_LOWER,
-    [19] = IPRIO_DEFAULT_LOWER + 1,
-    [38] = IPRIO_DEFAULT_LOWER + 2,
-    [37] = IPRIO_DEFAULT_LOWER + 3,
-    [18] = IPRIO_DEFAULT_LOWER + 4,
-    [36] = IPRIO_DEFAULT_LOWER + 5,
-
-    [35] = IPRIO_DEFAULT_LOWER + 6,
-    [17] = IPRIO_DEFAULT_LOWER + 7,
-    [34] = IPRIO_DEFAULT_LOWER + 8,
-    [33] = IPRIO_DEFAULT_LOWER + 9,
-    [16] = IPRIO_DEFAULT_LOWER + 10,
-    [32] = IPRIO_DEFAULT_LOWER + 11,
-};
-
-uint8_t riscv_cpu_default_priority(int irq)
-{
-    if (irq < 0 || irq > 63) {
-        return IPRIO_MMAXIPRIO;
-    }
-
-    return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
-};
-
-static int riscv_cpu_pending_to_irq(CPURISCVState *env,
-                                    int extirq, unsigned int extirq_def_prio,
-                                    uint64_t pending, uint8_t *iprio)
-{
-    int irq, best_irq = RISCV_EXCP_NONE;
-    unsigned int prio, best_prio = UINT_MAX;
-
-    if (!pending) {
-        return RISCV_EXCP_NONE;
-    }
-
-    irq = ctz64(pending);
-    if (!((extirq == IRQ_M_EXT) ? riscv_cpu_cfg(env)->ext_smaia :
-                                  riscv_cpu_cfg(env)->ext_ssaia)) {
-        return irq;
-    }
-
-    pending = pending >> irq;
-    while (pending) {
-        prio = iprio[irq];
-        if (!prio) {
-            if (irq == extirq) {
-                prio = extirq_def_prio;
-            } else {
-                prio = (riscv_cpu_default_priority(irq) < extirq_def_prio) ?
-                       1 : IPRIO_MMAXIPRIO;
-            }
-        }
-        if ((pending & 0x1) && (prio <= best_prio)) {
-            best_irq = irq;
-            best_prio = prio;
-        }
-        irq++;
-        pending = pending >> 1;
-    }
-
-    return best_irq;
-}
-
-/*
- * Doesn't report interrupts inserted using mvip from M-mode firmware or
- * using hvip bits 13:63 from HS-mode. Those are returned in
- * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
- */
-uint64_t riscv_cpu_all_pending(CPURISCVState *env)
-{
-    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
-    uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
-    uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
-
-    return (env->mip | vsgein | vstip) & env->mie;
-}
-
-int riscv_cpu_mirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
-                    ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
-
-    return riscv_cpu_pending_to_irq(env, IRQ_M_EXT, IPRIO_DEFAULT_M,
-                                    irqs, env->miprio);
-}
-
-int riscv_cpu_sirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
-    uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
-
-    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                    irqs | irqs_f, env->siprio);
-}
-
-int riscv_cpu_vsirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
-    uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
-    uint64_t vsbits;
-
-    /* Bring VS-level bits to correct position */
-    vsbits = irqs & VS_MODE_INTERRUPTS;
-    irqs &= ~VS_MODE_INTERRUPTS;
-    irqs |= vsbits >> 1;
-
-    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                    (irqs | irqs_f_vs), env->hviprio);
-}
-
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     uint64_t irqs, pending, mie, hsie, vsie, irqs_f, irqs_f_vs;
-- 
2.54.0


