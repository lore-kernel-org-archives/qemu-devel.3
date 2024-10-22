Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B69D2C546
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EE4-00075p-LN; Tue, 22 Oct 2024 08:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3EDz-0006zv-4W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:42:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t3EDw-00022G-Vm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:42:58 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx++HInRdnUDYFAA--.12282S3;
 Tue, 22 Oct 2024 20:42:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx2OLHnRdn8tMHAA--.46501S2;
 Tue, 22 Oct 2024 20:42:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Use physical cpu id about CSR CPUID for
 sysemu
Date: Tue, 22 Oct 2024 20:42:47 +0800
Message-Id: <20241022124247.873232-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx2OLHnRdn8tMHAA--.46501S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For user tcg, there is no physical cpu id provided and logic cpuid
is used. For system emulation, physical cpu id is provided, initial
value of register CSR CPUID can be set from physical cpu id.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c           | 3 ++-
 target/loongarch/cpu.c            | 7 ++++++-
 target/loongarch/tcg/csr_helper.c | 4 ----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 2ae1a42c46..78b6fce81b 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -42,7 +42,8 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
     CPUArchId *archid;
 
     archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
+    /* For offlined cpus, archid->cpu may be NULL */
+    if (archid && archid->cpu) {
         return CPU(archid->cpu);
     }
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7212fb5f8f..d4659e8d45 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -510,8 +510,10 @@ static void loongarch_max_initfn(Object *obj)
 static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
+    int n;
 
     if (lacc->parent_phases.hold) {
         lacc->parent_phases.hold(obj, type);
@@ -522,7 +524,6 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 #endif
     env->fcsr0 = 0x0;
 
-    int n;
     /* Set csr registers value after reset, see the manual 6.4. */
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
@@ -543,7 +544,11 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
     env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
     env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
+#ifndef CONFIG_USER_ONLY
+    env->CSR_CPUID = cpu->phy_id;
+#else
     env->CSR_CPUID = cs->cpu_index;
+#endif
     env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
     env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
     env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefa..2aeca2343d 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -37,10 +37,6 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 
 target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
 {
-    LoongArchCPU *lac = env_archcpu(env);
-
-    env->CSR_CPUID = CPU(lac)->cpu_index;
-
     return env->CSR_CPUID;
 }
 

base-commit: cc5adbbd50d81555b8eb73602ec16fde40b55be4
-- 
2.39.3


