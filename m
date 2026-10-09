Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D8CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wV-0004vR-P9; Thu, 08 Oct 2026 23:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vb-0004eF-23
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:49 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vY-0005mR-Lj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:46 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id DE82CDFE8;
 Fri, 09 Oct 2026 08:35:41 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 10/23] target/loongarch: handle LVZ exception and vm_exit
Date: Fri,  9 Oct 2026 11:05:06 +0800
Message-ID: <dd6bcea43f94cc6bbb21294289d211324654fdb5.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add EXCCODE_GSPR and EXCCODE_HVC macros. Execute real vm exit at end of
loongarch_cpu_do_interrupt().

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h         |  2 ++
 target/loongarch/tcg/tcg_cpu.c | 28 ++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 891eea47bd..3e3ae2bfa7 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -95,6 +95,8 @@ FIELD(FCSR0, CAUSE, 24, 5)
 #define  EXCCODE_WPEM                EXCODE(19, 1)
 #define  EXCCODE_BTD                 EXCODE(20, 0)
 #define  EXCCODE_BTE                 EXCODE(21, 0)
+#define  EXCCODE_GSPR                EXCODE(22, 0)
+#define  EXCCODE_HVC                 EXCODE(23, 0)
 #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
 
 /* cpucfg[0] bits */
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 101fe6fc7a..6f1ba12edb 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -44,6 +44,8 @@ static const struct TypeExcp excp_names[] = {
     {EXCCODE_BCE, "Bound Check Exception"},
     {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
     {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
+    {EXCCODE_HVC, "Hypervisor call"},
     {EXCP_HLT, "EXCP_HLT"},
 };
 
@@ -78,9 +80,11 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
     bool update_badinstr = 1;
     int cause = -1;
+    bool real_guest = !env->vm_exit && env_vm_level(env);
+    CPUSysState *sys = get_sys(env, real_guest);
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
     bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
     uint64_t last_pc = env->pc;
@@ -96,17 +100,17 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
 
     switch (cs->exception_index) {
     case EXCCODE_DBP:
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
+        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
+        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
         goto set_DERA;
     set_DERA:
-        sys->CSR_DERA = env->pc;
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
-        set_pc(env, sys->CSR_EENTRY + 0x480);
+        host->CSR_DERA = env->pc;
+        host->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
+        set_pc(env, host->CSR_EENTRY + 0x480);
         break;
     case EXCCODE_INT:
-        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
-            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
+        if (FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)) {
+            host->CSR_DBG = FIELD_DP64(host->CSR_DBG, CSR_DBG, DEI, 1);
             goto set_DERA;
         }
         QEMU_FALLTHROUGH;
@@ -117,6 +121,8 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         update_badinstr = 0;
         break;
     case EXCCODE_BCE:
+    case EXCCODE_GSPR:
+    case EXCCODE_HVC:
         sys->CSR_BADV = env->pc;
         QEMU_FALLTHROUGH;
     case EXCCODE_SYS:
@@ -218,6 +224,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index = -1;
+    if (env->vm_exit) {
+        host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM, 0);
+        set_sys(env, VM_LEVEL0);
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
+    }
+    env->vm_exit = false;
 }
 
 static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.55.0


