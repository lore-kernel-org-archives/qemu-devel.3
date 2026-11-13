Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvQ-0002oz-EE; Fri, 13 Nov 2026 03:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvN-0002lj-8X
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:21 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvK-0007P3-KI
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:21 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 984D4850;
 Fri, 13 Nov 2026 14:16:13 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 02/26] target/loongarch: add LVZ feature switcher
Date: Fri, 13 Nov 2026 16:45:17 +0800
Message-ID: <36fdd3a6725a52993c079360f8d236cbd8f18d96.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add LVZ property and AVAIL_LVZ macro based on cpucfg.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c       | 29 +++++++++++++++++++++++++++--
 target/loongarch/cpu.h       |  6 ++++++
 target/loongarch/translate.h |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5a88ecf522..d8f3af4f31 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -270,11 +270,27 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
     cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
 }
 
+static bool loongarch_get_lvz(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lvz != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->lvz = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, value);
+    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER,
+                                    value ? 1 : 0);
+}
+
 static void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
     cpu->lbt = ON_OFF_AUTO_OFF;
+    cpu->lvz = ON_OFF_AUTO_AUTO;
     cpu->pmu = ON_OFF_AUTO_OFF;
     cpu->lsx = ON_OFF_AUTO_AUTO;
     cpu->lasx = ON_OFF_AUTO_AUTO;
@@ -286,6 +302,11 @@ static void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_msgint);
     object_property_add_bool(obj, "ptw", loongarch_get_ptw,
                              loongarch_set_ptw);
+    if (tcg_enabled()) {
+        object_property_add_bool(obj, "lvz", loongarch_get_lvz,
+                                loongarch_set_lvz);
+       }
+
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
 
     if (kvm_enabled()) {
@@ -339,8 +360,12 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, FP_SP, 1);
     data = FIELD_DP32(data, CPUCFG2, FP_DP, 1);
     data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
-    data = FIELD_DP32(data, CPUCFG2, LSX, 1),
-    data = FIELD_DP32(data, CPUCFG2, LASX, 1),
+    data = FIELD_DP32(data, CPUCFG2, LSX, 1);
+    data = FIELD_DP32(data, CPUCFG2, LASX, 1);
+    if (tcg_enabled()) {
+        data = FIELD_DP32(data, CPUCFG2, LVZ, 1);
+        data = FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
+    }
     data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
     data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
     data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index f39925fd69..623b57e332 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -462,6 +462,7 @@ struct ArchCPU {
     CPULoongArchState env;
     uint32_t  phy_id;
     OnOffAuto lbt;
+    OnOffAuto lvz;
     OnOffAuto pmu;
     OnOffAuto ptw;
     OnOffAuto lsx;
@@ -525,6 +526,11 @@ static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
     return &env->sys_states[vm_level];
 }
 
+static inline bool cpu_has_lvz(CPULoongArchState *env)
+{
+    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 8aa8325dc6..a7c165982c 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -24,6 +24,7 @@
 #define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
 #define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
 #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
 #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
-- 
2.56.0


