Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BC8C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CNJ-0005Wy-U7; Mon, 14 Sep 2026 15:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CN3-0005Sm-FU; Mon, 14 Sep 2026 15:29:41 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CN1-00035M-OZ; Mon, 14 Sep 2026 15:29:41 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hkFb62n7MzBqYN;
 Mon, 14 Sep 2026 21:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789414178;
 bh=mC5RfBj6ylyOwDGowPmggfi/LrsOz8J7K11WQCUcqXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D3atsqv4miufLiJ4+ZIYGkutfWaVrx1wOa2BOCA9e1lnzRlWlZqFwWNkuMNdC6j4O
 NcnSqQyJHobDn57A++5oihVKA2/jd3dZdDZV5vwrYhZVu+2hY/btjUBc2cZsgL5AL4
 lQhFNjv1TIjBDPizlHS9QGG7SCPrFLyoFosqrDIJtZQs0mQ/5p+5AxOzXDh1rBi/xU
 9a3b6trLpc2U1JCg1XD9C1yF01CyMvfflDC3Fk/XdNXC1fMo8g54tRUuuEQqNp78bK
 SMr+ESgSN1slqwOa4C5CPNOCoNJjpFys4ZaJ5Pt7mf9GdFE65lqccSCfvSOjUGuOgu
 eusB/LC91ruJg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hkFb616YNz6sxf;
 Mon, 14 Sep 2026 21:29:38 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 6/6] target/arm: extend PMSAv7 support to v6-M CPUs
Date: Mon, 14 Sep 2026 21:23:22 +0200
Message-ID: <20260914192323.29250-7-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU conditions PMSAv7 storage, reset, allocation, the pmsav7-dregion property,
migration and address translation on ARM_FEATURE_V7, which prevents the Armv6-M
MPU from being used. The checks are widened to also accept ARM_FEATURE_M while
preserving the PMSAv8 path for v8-M CPUs (PMSAv8 is tested first and the
migration vmstate excludes v8-M with !ARM_FEATURE_V8). This lets a Cortex-M0+
declare and use its MPU regions without setting ARM_FEATURE_V7, while v8-M CPUs
continue to use PMSAv8 storage and migration.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 target/arm/cpu.c     | 12 +++++++++---
 target/arm/machine.c |  3 ++-
 target/arm/ptw.c     |  3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

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
index cb9e73fc0a..f537502d3b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3908,7 +3908,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
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


