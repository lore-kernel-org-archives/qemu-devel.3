Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C082C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qLy-0002CH-4n; Tue, 08 Sep 2026 03:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3qLv-0002Aj-5z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3qLr-000073-AG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxztKKup9qrrcJAA--.27763S3;
 Tue, 08 Sep 2026 15:34:34 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxDc+Eup9qSQ0dAA--.29522S3;
 Tue, 08 Sep 2026 15:34:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/5] target/loongarch: clear the registers when cpu is reset
Date: Tue,  8 Sep 2026 15:35:44 +0800
Message-ID: <20260908073548.3249551-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908073548.3249551-1-maobibo@loongson.cn>
References: <20260908073548.3249551-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDc+Eup9qSQ0dAA--.29522S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr15Zr4fWF4UGFyfuw4Dtrc_yoWxAr1Upr
 43KF9Fkw48KF43Crn5X398AFn8Zw1xGw1xt3sxKr1Fkayvgr93ZFWvqr1SkFWDZry5ur4x
 XrnrJrW2gF47Z3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

From: Xianglai Li <lixianglai@loongson.cn>

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
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 54 +++++++-----------------------------------
 target/loongarch/cpu.h | 34 ++++++++++++++++----------
 2 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 84a130956d..18d73ebc1b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -623,6 +623,13 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
         lacc->parent_phases.hold(obj, type);
     }
 
+    /*
+     * Workaround for edk2-stable202408, CSR PGD register is set only if
+     * its value is equal to zero for boot cpu, it causes reboot issue.
+     */
+    memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
+    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
+
 #ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
 
@@ -637,47 +644,11 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
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
+
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
     if (sys->CSR_PRCFG2 == 0) {
         sys->CSR_PRCFG2 = 0x3fffff000;
@@ -685,18 +656,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
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
index 97db3b453f..d83dcef6f8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -334,7 +334,6 @@ typedef struct CPUSysState {
     uint64_t CSR_TLBEHI;
     uint64_t CSR_TLBELO0;
     uint64_t CSR_TLBELO1;
-    uint64_t CSR_ASID;
     uint64_t CSR_PGDL;
     uint64_t CSR_PGDH;
     uint64_t CSR_PGD;
@@ -343,9 +342,6 @@ typedef struct CPUSysState {
     uint64_t CSR_STLBPS;
     uint64_t CSR_RVACFG;
     uint64_t CSR_CPUID;
-    uint64_t CSR_PRCFG1;
-    uint64_t CSR_PRCFG2;
-    uint64_t CSR_PRCFG3;
     uint64_t CSR_SAVE[16];
     uint64_t CSR_TID;
     uint64_t CSR_TCFG;
@@ -380,6 +376,14 @@ typedef struct CPUSysState {
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
     uint64_t CSR_MSGIE;
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    uint64_t CSR_ASID;
+    uint64_t CSR_PRCFG1;
+    uint64_t CSR_PRCFG2;
+    uint64_t CSR_PRCFG3;
 } CPUSysState;
 
 typedef struct CPUArchState {
@@ -391,16 +395,9 @@ typedef struct CPUArchState {
     uint32_t fcsr0;
     lbt_t  lbt;
 
-    uint32_t cpucfg[21];
-    uint32_t pv_features;
-    uint64_t vendor_id;
-    uint64_t cpu_id;
-    CPUSysState sys_states[1];
-
     struct {
         uint64_t guest_addr;
     } stealtime;
-    uint32_t perf_event_num;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
@@ -410,12 +407,23 @@ typedef struct CPUArchState {
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
+    CPUSysState sys_states[1];
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
2.54.0


