Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4518CC61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiB-000814-01; Sat, 29 Aug 2026 19:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Si9-00080R-7E; Sat, 29 Aug 2026 19:43:45 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Si6-0006BT-Vf; Sat, 29 Aug 2026 19:43:44 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXWzZ5GmLz7xf0;
 Sun, 30 Aug 2026 01:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047018;
 bh=RMucFzJPN2MoGUfPz33012reZYmnxRZy02J6azk5YUM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hBJztcWL0MBIyd8VcJpKa5v9W2R4iF7QKC5JjVwt8uUAvD7ur7cruaF84PMdnpBEW
 FQVxPheMIQLy2O1UIyP4rLl/e8H5h0aB4RUsygawniD5sPgd5GnLUM57Z+xGPu+oc+
 e103lig8xC6Hqo/xAXNYwRzFO8PVt9rT9N7TKDTO4NxaOm4S7BrKAgDH5k/9Yi5BJ6
 z0JTRogJMFfR3VI5b7vbHSI9TgDmrA3bQDzH+ElwUOFyhcBWJjgnlbBTi6x2aCNYeG
 PoGpFe6SNtHL1Xt/LjYWML6gXnfQN2F73YKPMixxpvN7yb/UJLVTcpdIxg2lVBs4ZY
 ygcN1dHBeRRYw==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzZ3DfLz7vrV;
 Sun, 30 Aug 2026 01:43:38 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RFC v2 01/30] target/arm: support Cortex-M0+ MPU
Date: Sun, 30 Aug 2026 01:42:35 +0200
Message-ID: <20260829234308.33725-2-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Cortex-M0+ implementations may provide an Armv6 PMSA MPU with eight regions. QEMU already marks M-profile CPUs as PMSA, but only exposes and allocates the existing region model for Armv7 CPUs. This prevents a Cortex-M0+ board from enabling its optional MPU.

Use QEMU's PMSAv7 state and translation path for the compatible Armv6-M MPU register layout. Permit CONTROL.nPRIV changes when the optional MPU is present and clear the region state on reset.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/intc/armv7m_nvic.c     |  3 +++
 target/arm/cpu.c          | 12 +++++++++---
 target/arm/ptw.c          |  3 ++-
 target/arm/tcg/m_helper.c | 10 +++++++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a7651f831e..3140599ac1 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1626,6 +1626,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         break;
     case 0xd08: /* Vector Table Offset.  */
         cpu->env.v7m.vecbase[attrs.secure] = value & 0xffffff80;
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
+            cpu->env.v7m.vecbase[!attrs.secure] = value & 0xffffff80;
+        }
         break;
     case 0xd0c: /* Application Interrupt/Reset Control (AIRCR) */
         if ((value >> R_V7M_AIRCR_VECTKEY_SHIFT) == 0x05fa) {
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
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f..b366a8d3dd 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3901,7 +3901,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
-        } else if (arm_feature(env, ARM_FEATURE_V7)) {
+        } else if (arm_feature(env, ARM_FEATURE_V7) ||
+                   arm_feature(env, ARM_FEATURE_M)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f4ba93b291..667b2a3cbd 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -16,6 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "exec/page-protection.h"
+#include "exec/cputlb.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst-common.h"
 #include "semihosting/common-semi.h"
@@ -2775,9 +2776,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                            !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_M_MAIN) ||
+                           env_archcpu(env)->has_mpu)) {
+            uint32_t old_control = env->v7m.control[env->v7m.secure];
+
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
+            if ((old_control ^ env->v7m.control[env->v7m.secure]) &
+                R_V7M_CONTROL_NPRIV_MASK) {
+                tlb_flush(env_cpu(env));
+            }
         }
         if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
             /*
-- 
2.55.0


