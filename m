Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4510D637A0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHIO-0000Hk-G3; Wed, 13 Nov 2024 12:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1tBHIN-0000HX-JI; Wed, 13 Nov 2024 12:36:47 -0500
Received: from smtp5-g21.free.fr ([2a01:e0c:1:1599::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <castet.matthieu@free.fr>)
 id 1tBHIL-0005pe-CE; Wed, 13 Nov 2024 12:36:47 -0500
Received: from debtag.home (unknown
 [IPv6:2a01:cb00:13da:d200:7cf5:aa34:e526:681b])
 (Authenticated sender: castet.matthieu@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id D93646013D;
 Wed, 13 Nov 2024 18:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1731519399;
 bh=IpfB1+Mxu1MpllLtPKH4w749edExyAs+tXA5y6HQ9XU=;
 h=From:To:Cc:Subject:Date:From;
 b=HZWdApXD8sC4rfPS1PsuSeBoHtlKLXDWSDIv0c/mVxzxqafj+Z7jZmEA8nNKF1swj
 nuKl+yaF+VdrsbeBFuYeLrMT+W8daNYXMLtmh9LshS5bvjMokJp2/A2EgF0PDVCudQ
 Jx7yojaNG8ZTHCJJjroGZSC4oZkniEojKYSFiEpytrQhRUXkV5uenKIYin/9OSTPdY
 aYCQDItXjhzo6Typ+z2qpv1YB8areJyPn8T4fPKgqiqaCB0YPqFxYjewPI/BBFDHwc
 okA6bHoETZMSpPPnS4lJGPYttCJWwWzOsE9qdm1WFSbvoJyezNpXPSPr1gzIdDQjxO
 jYv/VTwnniOuA==
From: Matthieu Castet <castet.matthieu@free.fr>
To: qemu-devel@nongnu.org
Cc: Matthieu Castet <castet.matthieu@free.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [PATCH v2] target/arm: Add cortex-m0+ support
Date: Wed, 13 Nov 2024 18:36:22 +0100
Message-Id: <20241113173622.79447-1-castet.matthieu@free.fr>
X-Mailer: git-send-email 2.39.5
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
 hw/intc/armv7m_nvic.c    | 51 ++++++++++++++++++++++++++++++++++++++--
 target/arm/cpu.c         |  5 ++--
 target/arm/ptw.c         | 14 +++++++++--
 target/arm/tcg/cpu-v7m.c | 17 ++++++++++++++
 4 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 98f3cf59bc..41d2b98ee4 100644
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
@@ -1407,6 +1407,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             }
             return cpu->env.pmsav8.rlar[attrs.secure][region];
         }
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            /*
+             * armv6-m do not support A alias
+             */
+            if (offset != 0xda0) {
+                goto bad_offset;
+            }
+        }
 
         if (region >= cpu->pmsav7_dregion) {
             return 0;
@@ -1876,6 +1884,21 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            if (offset != 0xd9c) {
+                /*
+                 * armv6-m do not support A alias
+                 */
+                goto bad_offset;
+            }
+
+            /*
+             * armv6-m do not support region address with alignement
+             * less than 256. Force alignement.
+             */
+            value &= ~0xe0;
+        }
+
         if (value & (1 << 4)) {
             /* VALID bit means use the region number specified in this
              * value and also update MPU_RNR.REGION with that value.
@@ -1900,12 +1923,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         tlb_flush(CPU(cpu));
         break;
     }
-    case 0xda0: /* MPU_RASR (v7M), MPU_RLAR (v8M) */
+    case 0xda0: /* MPU_RASR (v6M/v7M), MPU_RLAR (v8M) */
     case 0xda8: /* MPU_RASR_A1 (v7M), MPU_RLAR_A1 (v8M) */
     case 0xdb0: /* MPU_RASR_A2 (v7M), MPU_RLAR_A2 (v8M) */
     case 0xdb8: /* MPU_RASR_A3 (v7M), MPU_RLAR_A3 (v8M) */
     {
         int region = cpu->env.pmsav7.rnr[attrs.secure];
+        int rsize;
+        int rsize_min;
 
         if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
             /* PMSAv8M handling of the aliases is different from v7M:
@@ -1926,6 +1951,28 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            if (offset != 0xda0) {
+                /*
+                 * armv6-m do not support A alias
+                 */
+                goto bad_offset;
+            }
+        }
+
+        rsize = extract32(value, 1, 5);
+        /*
+         * for armv6-m rsize >= 7 (min 256)
+         * for armv7-m rsize >= 4 (min 32)
+         */
+        rsize_min = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 4 : 7;
+
+        if (rsize < rsize_min) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "MPU region size too small %d\n", rsize);
+            return;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return;
         }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b95..818c93ed2c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -520,7 +520,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                            sizeof(*env->pmsav8.rlar[M_REG_S])
                            * cpu->pmsav7_dregion);
                 }
-            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+            } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                       arm_feature(env, ARM_FEATURE_M)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
                 memset(env->pmsav7.drsr, 0,
@@ -2471,7 +2472,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+        (arm_feature(env, ARM_FEATURE_V7) || arm_feature(env, ARM_FEATURE_M))) {
         uint32_t nr = cpu->pmsav7_dregion;
 
         if (nr > 0xff) {
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9849949508..4203a94d54 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3517,8 +3517,18 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
-        } else if (arm_feature(env, ARM_FEATURE_V7)) {
-            /* PMSAv7 */
+        } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                   arm_feature(env, ARM_FEATURE_M)) {
+            /*
+             * PMSAv7 or armv6-m PMSAv6
+             *
+             * armv6-m PMSAv6 is mostly compatible with PMSAv7,
+             * main difference :
+             * - min region size is 256 instead of 32
+             * - TEX can be only 0 (Tex not used by qemu)
+             * - no alias register
+             * - HardFault instead of MemManage
+             */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
         } else {
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 58e54578d6..1570a2cf13 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -76,6 +76,21 @@ static void cortex_m0_initfn(Object *obj)
     cpu->isar.id_isar6 = 0x00000000;
 }
 
+static void cortex_m0p_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    /*
+     * cortex-m0p is a cortex-m0 with
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
@@ -267,6 +282,8 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
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


