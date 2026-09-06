Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B83C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3InQ-0002I9-Rz; Sun, 06 Sep 2026 15:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InP-0002Ha-G8; Sun, 06 Sep 2026 15:44:55 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InN-0006xg-Kj; Sun, 06 Sep 2026 15:44:55 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdLJ84XrNzBqYr;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723880;
 bh=5nHljIdPrCJuvJ91IvLCz3fRWW4+wFJPa3ERcaZZBtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uAhXIlBBAEq/sBXdd5xH7y4ilcXBTqK0SM0nBRnNOQc48zkVnekuLIqMdhp6xv0/t
 FJ159a3FxSzTOS5Z4BuI2ruCVGAAp6dcZOCyCZ1YwSFgHZD3G6+HpNjx1e5cVa7bpd
 N3MuhU/Ee68swP1FEoCNKUwdUJegVCdOxB20CMJ+XCJtgrMeXIU4Gkx8gl9dxMp0xB
 7iT4qmu7Knd6SFOy73OQh+eB/g87yaYWCtCeXrR4kHL3iWejytM/QuCNt2cTDJgttK
 GrxoSnmWuLCKiVTzB+ip6fCOhu/LjyBL8lR7TxVP6B3PoZW1xZuIqAPelM2Z9905Pe
 jX+Bf5ooiE8Bg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ8356fz7wXp;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH v3 03/36] target/arm: support Cortex-M0+ MPU
Date: Sun,  6 Sep 2026 21:44:02 +0200
Message-ID: <20260906194438.93046-4-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Cortex-M0+ implementations may provide an Armv6-M PMSA MPU with eight
regions. QEMU uses its historical v7m/PMSAv7 naming for M-profile code
shared by v6-M and v7-M, but currently exposes, allocates and migrates the
existing region model only when ARM_FEATURE_V7 is set. This prevents a
Cortex-M0+ board from enabling its optional MPU.

Allow non-v8 M-profile CPUs to use the existing PMSAv7 state, migration
state and translation path. Restrict the shared register model to the v6-M
layout: do not expose the v7-M alias registers or TEX bits, and reject
region sizes below the v6-M minimum of 256 bytes.

The dedicated PMSAv8 path remains selected first for v8-M CPUs. Expose the
pmsav7-dregion property and clear region state on reset.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/intc/armv7m_nvic.c | 27 ++++++++++++++++++++++++++-
 target/arm/cpu.c      | 12 +++++++++---
 target/arm/machine.c  |  3 ++-
 target/arm/ptw.c      | 10 +++++++---
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c1ceb7450f..a702bd0c38 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1405,6 +1405,11 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return cpu->env.pmsav8.rbar[attrs.secure][region];
         }
 
+        if (offset != 0xd9c &&
+            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return 0;
         }
@@ -1432,6 +1437,11 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return cpu->env.pmsav8.rlar[attrs.secure][region];
         }
 
+        if (offset != 0xda0 &&
+            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return 0;
         }
@@ -1919,6 +1929,11 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        if (offset != 0xd9c &&
+            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
+
         if (value & (1 << 4)) {
             /* VALID bit means use the region number specified in this
              * value and also update MPU_RNR.REGION with that value.
@@ -1969,12 +1984,22 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
             return;
         }
 
+        if (offset != 0xda0 &&
+            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
+
         if (region >= cpu->pmsav7_dregion) {
             return;
         }
 
         cpu->env.pmsav7.drsr[region] = value & 0xff3f;
-        cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        } else {
+            /* Armv6-M has XN, AP, S, C and B, but no TEX field. */
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x1707;
+        }
         tlb_flush(CPU(cpu));
         break;
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e..f58a1db843 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -617,7 +617,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
                            sizeof(*env->pmsav8.rlar[M_REG_S])
                            * cpu->pmsav7_dregion);
                 }
-            } else if (arm_feature(env, ARM_FEATURE_V7)) {
+            } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                       arm_feature(env, ARM_FEATURE_M)) {
                 memset(env->pmsav7.drbar, 0,
                        sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
                 memset(env->pmsav7.drsr, 0,
@@ -1656,7 +1657,11 @@ static void arm_cpu_post_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
-        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+        /*
+         * QEMU's PMSAv7 state also models the Armv6-M MPU register layout.
+         */
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7) ||
+            arm_feature(&cpu->env, ARM_FEATURE_M)) {
             qdev_property_add_static(DEVICE(obj),
                                      &arm_cpu_pmsav7_dregion_property);
         }
@@ -2332,7 +2337,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-        arm_feature(env, ARM_FEATURE_V7)) {
+        (arm_feature(env, ARM_FEATURE_V7) ||
+         arm_feature(env, ARM_FEATURE_M))) {
         uint32_t nr = cpu->pmsav7_dregion;
 
         if (nr > 0xff) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7005f4e5d7..53a2734d25 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -584,7 +584,8 @@ static bool pmsav7_needed(void *opaque)
     CPUARMState *env = &cpu->env;
 
     return arm_feature(env, ARM_FEATURE_PMSA) &&
-           arm_feature(env, ARM_FEATURE_V7) &&
+           (arm_feature(env, ARM_FEATURE_V7) ||
+            arm_feature(env, ARM_FEATURE_M)) &&
            !arm_feature(env, ARM_FEATURE_V8);
 }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f..6cb8a8394a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2748,9 +2748,12 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
                 continue;
             }
 
-            if (!rsize) {
+            if (!rsize ||
+                (arm_feature(env, ARM_FEATURE_M) &&
+                 !arm_feature(env, ARM_FEATURE_V7) && rsize < 7)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "DRSR[%d]: Rsize field cannot be 0\n", n);
+                              "DRSR[%d]: invalid Rsize field 0x%x\n",
+                              n, rsize);
                 continue;
             }
             rsize++;
@@ -3901,7 +3904,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
-        } else if (arm_feature(env, ARM_FEATURE_V7)) {
+        } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                   arm_feature(env, ARM_FEATURE_M)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
-- 
2.55.0


