Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F58CDD0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3L6W-00053Q-Q4; Tue, 22 Oct 2024 16:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3L6V-00052i-2i; Tue, 22 Oct 2024 16:03:43 -0400
Received: from smtp5-g21.free.fr ([2a01:e0c:1:1599::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1t3L6R-0004Hl-6Z; Tue, 22 Oct 2024 16:03:42 -0400
Received: from debtag.home (unknown
 [IPv6:2a01:cb00:13da:d200:7cf5:aa34:e526:681b])
 (Authenticated sender: castet.matthieu@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 936215FF3F;
 Tue, 22 Oct 2024 22:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1729627409;
 bh=Y1XczkptPUaL5JqERs0e5MtTVPI+G3JTY7wWyUZHLys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=teuWhAreGribyrurf3MbmVVt+M/u+LI/8ckxP1B4dsQj5m6m+Oe5w9uFLecErA1RS
 lNMze9lb2QOkDDyIdipMckjRUSDCD9n3+Z+T0VcB6Dfez9fE1GE7/EQmIEyx6EJO0f
 tIs3n/y/83Jl1HvO9BX/TxJ9BNxM+/wREXVDN9ytfyzwlLB0UFEYvhma5fTzH6mpJI
 6lqe9HuXXQqzxOtmvhRAIFdxsn8hGXI+1oLYLQxLplQWa8XYA31bt8Oth6PxqE/l8Y
 GCQBpmDCkFp5+dmKu/BAv6i8n3a5Vw6Oi1s5zqy9gr2YqmYawcNOt4tLglvLzsffFG
 7/l3Q9/tD0S8w==
From: Matthieu Castet <castet.matthieu@free.fr>
To: castet.matthieu@free.fr
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM cores),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/1] target/arm: Add cortex-m0+ support
Date: Tue, 22 Oct 2024 22:03:10 +0200
Message-Id: <20241022200310.175432-2-castet.matthieu@free.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022200310.175432-1-castet.matthieu@free.fr>
References: <20241022200310.175432-1-castet.matthieu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:e0c:1:1599::14;
 envelope-from=castet.matthieu@free.fr; helo=smtp5-g21.free.fr
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

Signed-off-by: Matthieu Castet<castet.matthieu@free.fr>
---
 hw/intc/armv7m_nvic.c    | 38 +++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c         |  4 ++--
 target/arm/ptw.c         | 23 +++++++++++++++++++----
 target/arm/tcg/cpu-v7m.c | 21 ++++++++++++++++++++-
 4 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 98f3cf59bc..ed084e9db3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1386,7 +1386,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return (cpu->env.pmsav7.drbar[region] & ~0x1f) | (region & 0xf);
     }
-    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
     case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
@@ -1876,6 +1876,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+                if (offset != 0xd9c)
+                        goto bad_offset;
+
+                /* do not support size less than 256 */
+                value &= ~0xe0;
+        }
+
         if (value & (1 << 4)) {
             /* VALID bit means use the region number specified in this
              * value and also update MPU_RNR.REGION with that value.
@@ -1900,12 +1908,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         tlb_flush(CPU(cpu));
         break;
     }
-    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
-    case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
-    case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
-    case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
+    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
+    case 0xda8: /* MPU_RASR_A1 (v6M/v7M), MPU_RLAR_A1 (v8M) */
+    case 0xdb0: /* MPU_RASR_A2 (v6M/v7M), MPU_RLAR_A2 (v8M) */
+    case 0xdb8: /* MPU_RASR_A3 (v6M/v7M), MPU_RLAR_A3 (v8M) */
     {
         int region = cpu->env.pmsav7.rnr[attrs.secure];
+        int rsize;
 
         if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             /* PMSAv8M handling of the aliases is different from v7M:
@@ -1926,6 +1935,25 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        rsize = extract32(value, 1, 5);
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            if (offset != 0xda0)
+                goto bad_offset;
+            /* for armv6-m rsize >= 7 (min 256) */
+            if (rsize < 7) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                        "MPU region size too small %d\n", rsize);
+                return;
+            }
+        }
+
+        /* for armv7-m rsize >= 4 (min 32) */
+        if (rsize < 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "MPU region size too small %d\n", rsize);
+            return;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return;
         }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1320fd8c8f..875e3aab69 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -508,7 +508,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                            sizeof(*env->pmsav8.rlar[M_REG_S])
                            * cpu->pmsav7_dregion);
                 }
-            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+            } else if (arm_feature(env, ARM_FEATURE_M)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
                 memset(env->pmsav7.drsr, 0,
@@ -2454,7 +2454,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+        arm_feature(env, ARM_FEATURE_M)) {
         uint32_t nr = cpu->pmsav7_dregion;
 
         if (nr > 0xff) {
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index dd40268397..fa771907e3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2383,6 +2383,13 @@ static bool pmsav7_use_background_region(ARMCPU *cpu, ARMMMUIdx mmu_idx,
     return regime_sctlr(env, mmu_idx) & SCTLR_BR;
 }
 
+/* armv6m PMSAv6 is mostly compatible with PMSAv7,
+ * main difference :
+ * - min region size is 256 instead of 32
+ * - TEX can be only 0 (Tex not used by qemu)
+ * - no alias register
+ * - HardFault instead of MemManage
+ */
 static bool get_phys_addr_pmsav7(CPUARMState *env,
                                  S1Translate *ptw,
                                  uint32_t address,
@@ -2423,11 +2430,19 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                 continue;
             }
 
-            if (!rsize) {
+            /* Issue warning for invalid values
+             * for armv7-m rsize >= 4 (min 32)
+             * for armv6-m rsize >= 7 (min 256)
+             */
+            if (!rsize ||
+                (arm_feature(env, ARM_FEATURE_M) && (
+                       rsize < 7 ||
+                       (rsize < 4 && !arm_feature(env, ARM_FEATURE_V7))))) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "DRSR[%d]: Rsize field cannot be 0\n", n);
+                              "DRSR[%d]: Rsize field cannot be %d\n", n, rsize);
                 continue;
             }
+
             rsize++;
             rmask = (1ull << rsize) - 1;
 
@@ -3515,8 +3530,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
-        } else if (arm_feature(env, ARM_FEATURE_V7)) {
-            /* PMSAv7 */
+        } else if (arm_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATURE_M)) {
+            /* PMSAv7 or PMSAv6 */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
         } else {
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 58e54578d6..01bc5d4375 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -76,6 +76,20 @@ static void cortex_m0_initfn(Object *obj)
     cpu->isar.id_isar6 = 0x00000000;
 }
 
+static void cortex_m0p_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    /* cortex-m0p is a cortex-m0 with
+     * vtor and mpu extension
+     */
+    cortex_m0_initfn(obj);
+
+    cpu->midr = 0x410cc601;
+    cpu->pmsav7_dregion = 8;
+}
+
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -111,6 +125,7 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
+    /* VFPv4-SP */
     cpu->isar.mvfr0 = 0x10110021;
     cpu->isar.mvfr1 = 0x11000011;
     cpu->isar.mvfr2 = 0x00000000;
@@ -141,6 +156,7 @@ static void cortex_m7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x411fc272; /* r1p2 */
     cpu->pmsav7_dregion = 8;
+    /* VFPv5 DP */
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x12000011;
     cpu->isar.mvfr2 = 0x00000040;
@@ -173,6 +189,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
+    /* VFPv5 DP */
     cpu->isar.mvfr0 = 0x10110021;
     cpu->isar.mvfr1 = 0x11000011;
     cpu->isar.mvfr2 = 0x00000040;
@@ -209,7 +226,7 @@ static void cortex_m55_initfn(Object *obj)
     cpu->revidr = 0;
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
-    /* These are the MVFR* values for the FPU + full MVE configuration */
+    /* These are the MVFR* values for the FPv5-D16-M + full MVE configuration */
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x12100211;
     cpu->isar.mvfr2 = 0x00000040;
@@ -267,6 +284,8 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
 static const ARMCPUInfo arm_v7m_cpus[] = {
     { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m0p",  .initfn = cortex_m0p_initfn,
+                             .class_init = arm_v7m_class_init },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-- 
2.39.5


