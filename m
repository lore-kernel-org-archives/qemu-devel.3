Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF201C35FF3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKwd-00066D-GZ; Sat, 15 Mar 2025 02:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKtu-0008Un-Ma; Sat, 15 Mar 2025 02:21:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKts-0003jY-EH; Sat, 15 Mar 2025 02:21:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFCA9FF9EF;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C72171CAC58;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7EBA3558F5; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 35/51] target/arm: Refactor handling of timer offset
 for direct register accesses
Date: Sat, 15 Mar 2025 09:17:41 +0300
Message-Id: <20250315061801.622606-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

When reading or writing the timer registers, sometimes we need to
apply one of the timer offsets.  Specifically, this happens for
direct reads of the counter registers CNTPCT_EL0 and CNTVCT_EL0 (and
their self-synchronized variants CNTVCTSS_EL0 and CNTPCTSS_EL0).  It
also applies for direct reads and writes of the CNT*_TVAL_EL*
registers that provide the 32-bit downcounting view of each timer.

We currently do this with duplicated code in gt_tval_read() and
gt_tval_write() and a special-case in gt_virt_cnt_read() and
gt_cnt_read().  Refactor this so that we handle it all in a single
function gt_direct_access_timer_offset(), to parallel how we handle
the offset for indirect accesses.

The call in the WFIT helper previously to gt_virt_cnt_offset() is
now to gt_direct_access_timer_offset(); this is the correct
behaviour, but it's not immediately obvious that it shouldn't be
considered an indirect access, so we add an explanatory comment.

This commit should make no behavioural changes.

(Cc to stable because the following bugfix commit will
depend on this one.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-6-peter.maydell@linaro.org
(cherry picked from commit 02c648a0a103a1a7b2c077ec5a81da9907f45544)
(Mjt: context fix in target/arm/internals.h)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6f741f5c00..2dbd308ed2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2722,14 +2722,6 @@ static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
     return 0;
 }
 
-static uint64_t gt_phys_cnt_offset(CPUARMState *env)
-{
-    if (arm_current_el(env) >= 2) {
-        return 0;
-    }
-    return gt_phys_raw_cnt_offset(env);
-}
-
 static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
 {
     /*
@@ -2756,6 +2748,52 @@ static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
     }
 }
 
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for direct accesses to the
+     * counter registers CNTPCT and CNTVCT, and for direct accesses
+     * to the CNT*_TVAL registers.
+     *
+     * This isn't exactly the same as the indirect-access offset,
+     * because here we also care about what EL the register access
+     * is being made from.
+     *
+     * This corresponds to the access pseudocode for the registers.
+     */
+    uint64_t hcr;
+
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        if (arm_current_el(env) >= 2) {
+            return 0;
+        }
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
+        switch (arm_current_el(env)) {
+        case 2:
+            hcr = arm_hcr_el2_eff(env);
+            if (hcr & HCR_E2H) {
+                return 0;
+            }
+            break;
+        case 0:
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                return 0;
+            }
+            break;
+        }
+        return env->cp15.cntvoff_el2;
+    case GTIMER_HYP:
+    case GTIMER_SEC:
+    case GTIMER_HYPVIRT:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2828,34 +2866,14 @@ static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
-}
-
-uint64_t gt_virt_cnt_offset(CPUARMState *env)
-{
-    uint64_t hcr;
-
-    switch (arm_current_el(env)) {
-    case 2:
-        hcr = arm_hcr_el2_eff(env);
-        if (hcr & HCR_E2H) {
-            return 0;
-        }
-        break;
-    case 0:
-        hcr = arm_hcr_el2_eff(env);
-        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-            return 0;
-        }
-        break;
-    }
-
-    return env->cp15.cntvoff_el2;
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+    return gt_get_countervalue(env) - offset;
 }
 
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    return gt_get_countervalue(env) - offset;
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2876,16 +2894,7 @@ static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = 0;
-
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
     return do_tval_read(env, timeridx, offset);
 }
@@ -2903,16 +2912,8 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = 0;
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
     do_tval_write(env, timeridx, value, offset);
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e37f459af3..d2a9cc9aa7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1814,7 +1814,8 @@ int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
 uint64_t gt_get_countervalue(CPUARMState *env);
 /*
  * Return the currently applicable offset between the system counter
- * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
+ * and the counter for the specified timer, as used for direct register
+ * accesses.
  */
-uint64_t gt_virt_cnt_offset(CPUARMState *env);
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx);
 #endif
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5aef45d9c4..3aa709ceff 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -427,7 +427,13 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
-    uint64_t offset = gt_virt_cnt_offset(env);
+    /*
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
     uint64_t cntvct = cntval - offset;
     uint64_t nexttick;
 
-- 
2.39.5


