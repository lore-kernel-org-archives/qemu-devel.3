Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A51AC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKu3-0000dM-11; Sat, 15 Mar 2025 02:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKtS-0007I3-Sn; Sat, 15 Mar 2025 02:21:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKtQ-0003hE-GK; Sat, 15 Mar 2025 02:21:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFC29FF9EB;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B73811CAC54;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 75523558ED; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 31/51] target/arm: Apply correct timer offset when
 calculating deadlines
Date: Sat, 15 Mar 2025 09:17:37 +0300
Message-Id: <20250315061801.622606-31-mjt@tls.msk.ru>
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

When we are calculating timer deadlines, the correct definition of
whether or not to apply an offset to the physical count is described
in the Arm ARM DDI4087 rev L.a section D12.2.4.1.  This is different
from when the offset should be applied for a direct read of the
counter sysreg.

We got this right for the EL1 physical timer and for the EL1 virtual
timer, but got all the rest wrong: they should be using a zero offset
always.

Factor the offset calculation out into a function that has a comment
documenting exactly which offset it is calculating and which gets the
HYP, SEC, and HYPVIRT cases right.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-2-peter.maydell@linaro.org
(cherry picked from commit db6c2192839ee0282d38f6f6666a87e0629fcd13)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8df38a30a1..417801d9c3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2727,6 +2727,32 @@ static uint64_t gt_phys_cnt_offset(CPUARMState *env)
     return gt_phys_raw_cnt_offset(env);
 }
 
+static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for indirect accesses to the timer.
+     * This is the Offset value as defined in D12.2.4.1 "Operation of the
+     * CompareValue views of the timers".
+     *
+     * The condition here is not always the same as the condition for
+     * whether to apply an offset register when doing a direct read of
+     * the counter sysreg; those conditions are described in the
+     * access pseudocode for each counter register.
+     */
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
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
@@ -2736,8 +2762,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * Timer enabled: calculate and set current ISTATUS, irq, and
          * reset timer to when ISTATUS next has to change
          */
-        uint64_t offset = timeridx == GTIMER_VIRT ?
-            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
+        uint64_t offset = gt_indirect_access_timer_offset(&cpu->env, timeridx);
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
-- 
2.39.5


