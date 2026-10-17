Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC1CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zt-0008FL-0t; Sat, 17 Oct 2026 14:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Za-0008B3-AZ; Sat, 17 Oct 2026 14:56:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ZX-0003ap-PC; Sat, 17 Oct 2026 14:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263355; bh=wFkHxyhR169SE3chauQHfiLVvhY1OZkz35c0gV/+EMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EHmp6NbrsnHvPuwu8QaSG5kbiII6biG0lcP7MZuhuAXj32lwMrDDjTNxEyFAzszck
 mzDTagxN4ITrHM85zalhICy5+N475OaZHp7+IPKcbYo26vnnqmf7YsJgOvSgAKhxcD
 cVI4avlxc62rKeNKxk9CUoGMwuHBv6Lw5w5kxMItKmlYmPb2RUokLaHKjsVV+w96qn
 PYm1OYRTcwjx47vNVYBSWnq656uEc9l2OnN4JFVOz3m3VrkGYPTZTWzPC1rrZbs/pJ
 5H039RE6peM2ltmyo6izOtKVHHKw89sG8g7Mlcjm15rqaqezdaGEpdH+1VUPo4CYTM
 GaJb0aSJHaXuw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 910261DE6A2;
 Sat, 17 Oct 2026 21:55:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D59544336D;
 Sat, 17 Oct 2026 21:55:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 02/63] target/arm: Fix next timer tick when the
 offset puts the count ahead
Date: Sat, 17 Oct 2026 21:54:18 +0300
Message-ID: <20261017185528.722197-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

gt_recalc_timer() arms the timer for the ISTATUS 0->1 transition at
count == cval + offset, treating an overflow of that sum as "beyond
the counter's wrap" and arming at INT64_MAX. That reading is valid
only when offset <= count. When offset > count (a CNTVOFF_EL2 or
CNTPOFF_EL2 that puts the timer's counter ahead of the physical
count), the sum overflows for every cval still in the future and the
wrapped value is the correct next tick, which is what the code used
before commit 8d37a1425b99. The timer then never fires on its own.

A KVM guest whose counter is set ahead of the host's, as the
arch_timer_edge_cases selftest does via KVM_REG_ARM_TIMER_CNT, gets
its timer interrupt only when the vCPU is next loaded and KVM
rewrites the timer registers, so a guest polling for the interrupt
hangs.
Reproduced with VHE, nVHE and pKVM hosts on QEMU 11.0.0. The test
passes on hardware.

Test count + (cval - (count - offset)) for overflow instead, so only a
physical count past 2^64 is "never", and add a vtimer test case with
an offset that puts the count ahead.

Fixes: 8d37a1425b99 ("target/arm: Handle overflow in calculation of next timer tick")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20260921074451.3158645-2-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 66d4ea65a064421057f10c4a26d727beedbd1971)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e607f4a458..b2b5faa550 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2607,11 +2607,12 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         } else {
             /*
              * Next transition is when (count - offset) == cval, i.e.
-             * when count == (cval + offset).
-             * If that would overflow, then again we set up the next interrupt
-             * for "as far in the future as possible" for the code below.
+             * cval - (count - offset) ticks from now. If count plus that
+             * overflows, set up "as far in the future as possible" below.
              */
-            if (uadd64_overflow(gt->cval, offset, &nexttick)) {
+            uint64_t remaining = gt->cval - (count - offset);
+
+            if (uadd64_overflow(count, remaining, &nexttick)) {
                 nexttick = UINT64_MAX;
             }
         }
diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
index 7d725eced3..e1cfad36be 100644
--- a/tests/tcg/aarch64/system/vtimer.c
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -27,6 +27,7 @@
 
 int main(void)
 {
+    uint64_t freq, now;
     int i;
 
     ml_printf("VTimer Test\n");
@@ -44,5 +45,32 @@ int main(void)
         ml_printf("%d: cntv_cval_el0=%lx\n", i, read_sysreg(cntv_cval_el0));
     }
 
+    /*
+     * An offset that puts the virtual count ahead of the physical one,
+     * so cval + cntvoff wraps for every future cval. The timer must
+     * still fire. ISTATUS is set by the expiry, so poll it with a bound.
+     */
+    write_sysreg(cntv_ctl_el0, 0);
+    write_sysreg(cntvoff_el2, -(1ULL << 60));
+    asm volatile("isb");
+
+    freq = read_sysreg(cntfrq_el0);
+    now = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_cval_el0, now + freq / 100);
+    write_sysreg(cntv_ctl_el0, 1);
+
+    ml_printf("cntvoff_el2=%lx\n", read_sysreg(cntvoff_el2));
+    ml_printf("cntvct_el0=%lx\n", now);
+    ml_printf("cntv_cval_el0=%lx\n", read_sysreg(cntv_cval_el0));
+
+    while (!(read_sysreg(cntv_ctl_el0) & 4)) {
+        if (read_sysreg(cntvct_el0) - now > freq) {
+            ml_printf("FAIL: ISTATUS not set within 1s: cntv_ctl_el0=%lx\n",
+                      read_sysreg(cntv_ctl_el0));
+            return 1;
+        }
+    }
+    ml_printf("ISTATUS set at cntvct_el0=%lx\n", read_sysreg(cntvct_el0));
+
     return 0;
 }
-- 
2.47.3


