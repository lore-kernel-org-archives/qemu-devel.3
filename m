Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD8CA6018
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0vY-0004dh-PY; Thu, 08 Oct 2026 23:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vS-0004cX-VS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:38 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vQ-0005le-1c
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:38 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 16450E002;
 Fri, 09 Oct 2026 08:35:32 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 03/23] target/loongarch: add LVZ feature switcher
Date: Fri,  9 Oct 2026 11:04:59 +0800
Message-ID: <7c70892a1a7155a2ad3fe1495cdf29168ec6fe5b.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add LVZ property and AVAIL_LVZ macro based on cpucfg.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.c       | 33 +++++++++++++++++++++++++++++++--
 target/loongarch/cpu.h       |  6 ++++++
 target/loongarch/translate.h |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e1245235be..664763137d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -267,11 +267,33 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
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
+
+    if (kvm_enabled()) {
+        /* lvz can not be only enabled in kvm mode currently */
+        return;
+    }
+
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
@@ -283,6 +305,9 @@ static void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_msgint);
     object_property_add_bool(obj, "ptw", loongarch_get_ptw,
                              loongarch_set_ptw);
+    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
+                             loongarch_set_lvz);
+
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
 
     if (kvm_enabled()) {
@@ -336,8 +361,12 @@ static void loongarch_la464_initfn(Object *obj)
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
index c0edcc9065..918378ee9a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -460,6 +460,7 @@ struct ArchCPU {
     CPULoongArchState env;
     uint32_t  phy_id;
     OnOffAuto lbt;
+    OnOffAuto lvz;
     OnOffAuto pmu;
     OnOffAuto ptw;
     OnOffAuto lsx;
@@ -520,6 +521,11 @@ static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
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
2.55.0


