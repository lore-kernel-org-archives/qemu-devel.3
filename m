Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC49CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvdd-0005fr-Dn; Thu, 25 Jun 2026 21:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1wcvdX-0005fY-AP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:45:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1wcvdT-0004MM-Ez
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:45:42 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxzem12T1qZywYAA--.60395S3;
 Fri, 26 Jun 2026 09:45:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxquC02T1qvmKzAA--.12077S2;
 Fri, 26 Jun 2026 09:45:25 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH V3] target/loongarch: clear the registers when cpu is reset
Date: Fri, 26 Jun 2026 09:18:57 +0800
Message-Id: <20260626011857.1888867-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxquC02T1qvmKzAA--.12077S2
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
register, we carried out the operation and checked the status of other
registers during the reset process:

Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
reset state when the CPU is reset.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Song Gao <gaosong@loongson.cn>

changelog:
V2->V3:
Remove or update outdated comments related to this patch.

V1->V2:
1.Add a description of the issues related to this patch
2.Replace the macro definition MAX_PERF_EVENTS with the variable
perf_event_num as the condition for the for loop.
3.Rebase against the latest codebase.
4.Refer to the usage of end_reset_fields on ARM and other architectures,
and modify the current implementation accordingly.

 target/loongarch/cpu-csr.h |  7 ++++++
 target/loongarch/cpu.c     | 51 ++++++++++++++++----------------------
 target/loongarch/cpu.h     | 22 +++++++++-------
 3 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..d936af8e57 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -211,6 +211,13 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
 #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
 #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
 
+FIELD(CSR_PERFCTRL, EV, 0, 10)
+FIELD(CSR_PERFCTRL, PLV0, 16, 1)
+FIELD(CSR_PERFCTRL, PLV1, 17, 1)
+FIELD(CSR_PERFCTRL, PLV2, 18, 1)
+FIELD(CSR_PERFCTRL, PLV3, 19, 1)
+FIELD(CSR_PERFCTRL, PMIE, 20, 1)
+
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
 FIELD(CSR_DBG, DST, 0, 1)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..654abfd36a 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -623,44 +623,37 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->fcsr0 = 0x0;
 
     int n;
-    /* Set csr registers value after reset, see the manual 6.4. */
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
 
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
-    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
-
-    sys->CSR_MISC = 0;
+    /*
+     * Workaround for edk2-stable202408, CSR PGD register is set only if
+     * its value is equal to zero for boot cpu, it causes reboot issue.
+     */
+    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
 
-    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
-    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
+    /* Set csr registers value after reset, see the manual 6.4. */
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
 
-    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
-    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
     sys->CSR_CPUID = cs->cpu_index;
     sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
     sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
     sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
     sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
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
+    sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 0);
+    for (n = 0; n < env->perf_event_num; n++) {
+        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV0, 0);
+        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV1, 0);
+        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV2, 0);
+        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV3, 0);
+        sys->CSR_PERFCTRL[n] = FIELD_DP64(sys->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PMIE, 0);
+    }
+
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
     if (sys->CSR_PRCFG2 == 0) {
         sys->CSR_PRCFG2 = 0x3fffff000;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..2576239b31 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -325,22 +325,30 @@ typedef struct CPUSysState {
     uint64_t CSR_MISC;
     uint64_t CSR_ECFG;
     uint64_t CSR_ESTAT;
+    uint64_t CSR_PGDL;
+    uint64_t CSR_PGDH;
+    uint64_t CSR_EENTRY;
+    uint64_t CSR_PWCH;
+    uint64_t CSR_RVACFG;
+    uint64_t CSR_TLBRENTRY;
+    uint64_t CSR_MERRENTRY;
+    /* Msg interrupt registers */
+    uint64_t CSR_MSGIS[N_MSGIS];
+
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
     uint64_t CSR_ERA;
     uint64_t CSR_BADV;
     uint64_t CSR_BADI;
-    uint64_t CSR_EENTRY;
     uint64_t CSR_TLBIDX;
     uint64_t CSR_TLBEHI;
     uint64_t CSR_TLBELO0;
     uint64_t CSR_TLBELO1;
     uint64_t CSR_ASID;
-    uint64_t CSR_PGDL;
-    uint64_t CSR_PGDH;
     uint64_t CSR_PGD;
     uint64_t CSR_PWCL;
-    uint64_t CSR_PWCH;
     uint64_t CSR_STLBPS;
-    uint64_t CSR_RVACFG;
     uint64_t CSR_CPUID;
     uint64_t CSR_PRCFG1;
     uint64_t CSR_PRCFG2;
@@ -354,7 +362,6 @@ typedef struct CPUSysState {
     uint64_t CSR_LLBCTL;
     uint64_t CSR_IMPCTL1;
     uint64_t CSR_IMPCTL2;
-    uint64_t CSR_TLBRENTRY;
     uint64_t CSR_TLBRBADV;
     uint64_t CSR_TLBRERA;
     uint64_t CSR_TLBRSAVE;
@@ -365,7 +372,6 @@ typedef struct CPUSysState {
     uint64_t CSR_MERRCTL;
     uint64_t CSR_MERRINFO1;
     uint64_t CSR_MERRINFO2;
-    uint64_t CSR_MERRENTRY;
     uint64_t CSR_MERRERA;
     uint64_t CSR_MERRSAVE;
     uint64_t CSR_CTAG;
@@ -375,8 +381,6 @@ typedef struct CPUSysState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
-    /* Msg interrupt registers */
-    uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
     uint64_t CSR_MSGIE;
 } CPUSysState;
-- 
2.39.1


