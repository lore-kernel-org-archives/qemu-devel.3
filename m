Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4D4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whn6H-0001f0-QD; Thu, 09 Jul 2026 07:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1whn60-0001ec-TB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:39:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1whn5x-0005Q7-NY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:39:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxZehOiE9qS9UBAA--.6409S3;
 Thu, 09 Jul 2026 19:38:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxbsVNiE9qw8wGAA--.30790S2;
 Thu, 09 Jul 2026 19:38:53 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH V4] target/loongarch: clear the registers when cpu is reset
Date: Thu,  9 Jul 2026 19:19:01 +0800
Message-Id: <20260709111901.61597-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxbsVNiE9qw8wGAA--.30790S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Use virt-manager to start a virtual machine, and then use the following
command to manually trigger the crash of the virtual machine:
echo c > /proc/sysrq-trigger

After the VM is abnormal, the ESTAT register has a certain probability of
remaining interrupted. Then the VM is forced to restart and the VM is
suspended in the interrupt handling function during startup.

In order to clear the remaining interrupt information in the ESTAT
register, we performed this operation during the reset process, while also
checking and optimizing the status of other CSR registers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Song Gao <gaosong@loongson.cn>

changelog:
V3->V4:
Remove the field end_reset_fields from the CPUSysState structure, and
rearrange other fields as needed to avoid them being zeroed out.

V2->V3:
Remove or update outdated comments related to this patch.

V1->V2:
1.Add a description of the issues related to this patch
2.Replace the macro definition MAX_PERF_EVENTS with the variable
perf_event_num as the condition for the for loop.
3.Rebase against the latest codebase.
4.Refer to the usage of end_reset_fields on ARM and other architectures,
and modify the current implementation accordingly.

 target/loongarch/cpu.c | 56 ++++++++----------------------------------
 target/loongarch/cpu.h | 19 ++++++++------
 2 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..11b7e374c3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -601,11 +601,19 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
+    uint64_t reg_prcfg2;
 
     if (lacc->parent_phases.hold) {
         lacc->parent_phases.hold(obj, type);
     }
 
+    reg_prcfg2 = sys->CSR_PRCFG2;
+    /*
+     * Workaround for edk2-stable202408, CSR PGD register is set only if
+     * its value is equal to zero for boot cpu, it causes reboot issue.
+     */
+    memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
+
 #ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
 
@@ -620,47 +628,12 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
                            R_TLBENTRY_32_PPN_MASK;
     }
 #endif
-    env->fcsr0 = 0x0;
 
-    int n;
-    /* Set csr registers value after reset, see the manual 6.4. */
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
     sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
-
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
-
-    sys->CSR_MISC = 0;
-
-    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
-    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
-
-    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
-    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
     sys->CSR_CPUID = cs->cpu_index;
-    sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
-    sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
-    sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
-    sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
     sys->CSR_TID = cs->cpu_index;
-    /*
-     * Workaround for edk2-stable202408, CSR PGD register is set only if
-     * its value is equal to zero for boot cpu, it causes reboot issue.
-     *
-     * Here clear CSR registers relative with TLB.
-     */
-    sys->CSR_PGDH = 0;
-    sys->CSR_PGDL = 0;
-    sys->CSR_PWCH = 0;
-    sys->CSR_EENTRY = 0;
-    sys->CSR_TLBRENTRY = 0;
-    sys->CSR_MERRENTRY = 0;
+    sys->CSR_PRCFG2 = reg_prcfg2;
+
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
     if (sys->CSR_PRCFG2 == 0) {
         sys->CSR_PRCFG2 = 0x3fffff000;
@@ -668,18 +641,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     tlb_ps = ctz32(sys->CSR_PRCFG2);
     sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
     sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
-    for (n = 0; n < 4; n++) {
-        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0, 0);
-        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1, 0);
-        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2, 0);
-        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3, 0);
-    }
 
 #ifndef CONFIG_USER_ONLY
     env->pc = 0x1c000000;
-#ifdef CONFIG_TCG
-    memset(env->tlb, 0, sizeof(env->tlb));
-#endif
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cs);
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..28760bdca4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -390,16 +390,11 @@ typedef struct CPUArchState {
     uint32_t fcsr0;
     lbt_t  lbt;
 
-    uint32_t cpucfg[21];
-    uint32_t pv_features;
-    uint64_t vendor_id;
-    uint64_t cpu_id;
     CPUSysState sys_states[1];
 
     struct {
         uint64_t guest_addr;
     } stealtime;
-    uint32_t perf_event_num;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
@@ -409,12 +404,22 @@ typedef struct CPUArchState {
     uint64_t llval_high; /* For 128-bit atomic SC.Q */
     uint64_t llbit_scq; /* Potential LL.D+LD.D+SC.Q sequence in effect */
     uint64_t hw_pte_mask; /* Mask of architecturally-defined (hardware) PTE bits. */
-#endif
+
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
+#endif
 #endif
 
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    uint32_t cpucfg[21];
+    uint32_t pv_features;
+    uint64_t vendor_id;
+    uint64_t cpu_id;
+    uint32_t perf_event_num;
+
+#ifndef CONFIG_USER_ONLY
     AddressSpace *address_space_iocsr;
     uint32_t mp_state;
 #endif
-- 
2.39.1


