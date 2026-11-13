Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377B60A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx3-0004I0-A6; Fri, 13 Nov 2026 03:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvt-00036u-2J
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:54 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvr-0007QN-3k
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:52 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 880741DD;
 Fri, 13 Nov 2026 14:16:39 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 21/26] target/loongarch: add LVZ to CSR helpers
Date: Fri, 13 Nov 2026 16:45:36 +0800
Message-ID: <e06a774bb70bf98d7f7ac12bd8b8e576b3de435f.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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

Add actual LVZ handling to all CSR helpers.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/csr_helper.c | 49 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 5ff89f0d10..f5b6a3d1f9 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -21,7 +21,7 @@
 target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env,
                                  target_ulong val, uint32_t vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     int64_t old_v = sys->CSR_STLBPS;
 
     /*
@@ -44,7 +44,7 @@ target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env,
 target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env, uint32_t vm_level)
 {
     int64_t v;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     if (sys->CSR_TLBRERA & 0x1) {
         v = sys->CSR_TLBRBADV;
@@ -64,7 +64,11 @@ target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env, uint32_t vm_level)
 target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env, uint32_t vm_level)
 {
     LoongArchCPU *lac = env_archcpu(env);
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
+
+    if (vm_level) {
+        return sys->CSR_CPUID;
+    }
 
     sys->CSR_CPUID = CPU(lac)->cpu_index;
 
@@ -73,13 +77,14 @@ target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env, uint32_t vm_level)
 
 target_ulong HELPER(csrrd_tval)(CPULoongArchState *env, uint32_t vm_level)
 {
-    return cpu_loongarch_get_timer_ticks(env_timer(env));
+    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
+    return cpu_loongarch_get_timer_ticks(timer);
 }
 
 target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env, uint32_t vm_level)
 {
     int irq, new;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
 
     irq = find_first_bit((unsigned long *)sys->CSR_MSGIS, 256);
     if (irq < 256) {
@@ -101,11 +106,20 @@ target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env, uint32_t vm_level)
 target_ulong HELPER(csrwr_estat)(CPULoongArchState *env,
                                 target_ulong val, uint32_t vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     int64_t old_v = sys->CSR_ESTAT;
 
-    /* Only IS[1:0] can be written */
+    /* When guest = 0, only IS[1:0] can be written.
+     * When guest = 1, ecode and esubcode of
+     * VM_LEVEL1 can be written by VM_LEVEL0.
+     */
     sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
+    if (vm_level) {
+        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 2, 11,
+                                   extract64(val, 2, 11));
+        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 16, 15,
+                                   extract64(val, 16, 15));
+    }
     /*
      * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
      * Make sure the CPU interrupt request state tracks the pending bits,
@@ -113,7 +127,7 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env,
      */
     if (sys->CSR_ESTAT != old_v) {
         bql_lock();
-        loongarch_cpu_update_irq(env_archcpu(env), false);
+        loongarch_cpu_update_irq(env_archcpu(env), vm_level);
         bql_unlock();
     }
 
@@ -123,7 +137,7 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env,
 target_ulong HELPER(csrwr_asid)(CPULoongArchState *env,
                                target_ulong val, uint32_t vm_level)
 {
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     int64_t old_v = sys->CSR_ASID;
 
     /* Only ASID filed of CSR_ASID can be written */
@@ -137,7 +151,7 @@ target_ulong HELPER(csrwr_asid)(CPULoongArchState *env,
 target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env,
                                target_ulong val, uint32_t vm_level)
 {
-    CPUTimerState *timer = env_timer(env);
+    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
     CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
     int64_t old_v = sys->CSR_TCFG;
 
@@ -149,7 +163,7 @@ target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env,
 target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env,
                                 target_ulong val, uint32_t vm_level)
 {
-    CPUTimerState *timer = env_timer(env);
+    CPUTimerState *timer = vm_level ? env_guest_timer(env) : env_timer(env);
     int64_t old_v = 0;
 
     if (val & 0x1) {
@@ -164,7 +178,7 @@ target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env,
                                target_ulong val, uint32_t vm_level)
 {
     uint8_t shift, ptbase;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *sys = get_sys(env, vm_level);
     int64_t old_v = sys->CSR_PWCL;
 
     /*
@@ -189,16 +203,17 @@ target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env,
 target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env,
                                target_ulong val, uint32_t vm_level)
 {
-    uint8_t has_ptw;
-    CPUSysState *sys = env_sys(env);
+    uint8_t host_has_ptw;
+    CPUSysState *sys = get_sys(env, vm_level);
     int64_t old_v = sys->CSR_PWCH;
 
     val = FIELD_DP64(val, CSR_PWCH, RESERVE, 0);
-    has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
-    if (!has_ptw) {
+    //host can't read guest cpucfg
+    host_has_ptw = FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW);
+    if (!host_has_ptw) {
         val = FIELD_DP64(val, CSR_PWCH, HPTW_EN, 0);
     }
 
     sys->CSR_PWCH = val;
     return old_v;
- }
+}
-- 
2.56.0


