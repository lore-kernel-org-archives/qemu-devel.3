Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAB5C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKuf-00029k-4M; Sat, 15 Mar 2025 02:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKta-0007mU-3F; Sat, 15 Mar 2025 02:21:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKtX-0003jR-GW; Sat, 15 Mar 2025 02:21:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EBD26FF9EE;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C327A1CAC57;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7C493558F3; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 34/51] target/arm: Always apply CNTVOFF_EL2 for
 CNTV_TVAL_EL02 accesses
Date: Sat, 15 Mar 2025 09:17:40 +0300
Message-Id: <20250315061801.622606-34-mjt@tls.msk.ru>
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

Currently we handle CNTV_TVAL_EL02 by calling gt_tval_read() for the
EL1 virt timer.  This is almost correct, but the underlying
CNTV_TVAL_EL0 register behaves slightly differently.  CNTV_TVAL_EL02
always applies the CNTVOFF_EL2 offset; CNTV_TVAL_EL0 doesn't do so if
we're at EL2 and HCR_EL2.E2H is 1.

We were getting this wrong, because we ended up in
gt_virt_cnt_offset() and did the E2H check.

Factor out the tval read/write calculation from the selection of the
offset, so that we can special case gt_virt_tval_read() and
gt_virt_tval_write() to unconditionally pass CNTVOFF_EL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-5-peter.maydell@linaro.org
(cherry picked from commit 4aecd4b442d7abb4355896d878ffc9b028625b01)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a881e890e9..6f741f5c00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2867,6 +2867,12 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
+static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
+{
+    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
+                      (gt_get_countervalue(env) - offset));
+}
+
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
@@ -2881,8 +2887,16 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
         break;
     }
 
-    return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
-                      (gt_get_countervalue(env) - offset));
+    return do_tval_read(env, timeridx, offset);
+}
+
+static void do_tval_write(CPUARMState *env, int timeridx, uint64_t value,
+                          uint64_t offset)
+{
+    trace_arm_gt_tval_write(timeridx, value);
+    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
+                                         sextract64(value, 0, 32);
+    gt_recalc_timer(env_archcpu(env), timeridx);
 }
 
 static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2899,11 +2913,7 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
         offset = gt_phys_cnt_offset(env);
         break;
     }
-
-    trace_arm_gt_tval_write(timeridx, value);
-    env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-                                         sextract64(value, 0, 32);
-    gt_recalc_timer(env_archcpu(env), timeridx);
+    do_tval_write(env, timeridx, value, offset);
 }
 
 static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3035,13 +3045,21 @@ static void gt_virt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_virt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_tval_read(env, ri, GTIMER_VIRT);
+    /*
+     * This is CNTV_TVAL_EL02; unlike the underlying CNTV_TVAL_EL0
+     * we always apply CNTVOFF_EL2. Special case that here rather
+     * than going into the generic gt_tval_read() and then having
+     * to re-detect that it's this register.
+     * Note that the accessfn/perms mean we know we're at EL2 or EL3 here.
+     */
+    return do_tval_read(env, GTIMER_VIRT, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    gt_tval_write(env, ri, GTIMER_VIRT, value);
+    /* Similarly for writes to CNTV_TVAL_EL02 */
+    do_tval_write(env, GTIMER_VIRT, value, env->cp15.cntvoff_el2);
 }
 
 static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.39.5


