Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD2EC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8d8f-000404-Ev; Mon, 21 Sep 2026 08:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yhv-0006b6-Qx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:44:59 -0400
Received: from out-131.mta0.migadu.com ([2001:41d0:1004:224b::83]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1x8Yht-000665-Vh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:44:59 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=kPmJSsdV69w6Xb0zUY7kjI4w++wJtH7CYxl3NJK6p1g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789976696; v=1; x=1790581496;
 b=sdfsd7WY8KI4jsjUAsytMyX1TxL2z4sP4sESO88UTb/L9VxRVwb+eHad6cFVArBVwcI2W/Ot
 O++YDIpedviAhEgQf554qc77gkeE1JHMIonA5jjwI7ESthT+MrWSUN1AjwAeuPvDCdD60gXwnGE
 QyQNq9cmxBwauGIzxodW7LSQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 7935730cc60c79cc;
 Mon, 21 Sep 2026 07:44:56 +0000
X-Mizu-Trace-ID: 7935730cc60c79cc
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: [PATCH 1/2] target/arm: Fix next timer tick when the offset puts the
 count ahead
Date: Mon, 21 Sep 2026 08:44:50 +0100
Message-Id: <20260921074451.3158645-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260921074451.3158645-1-fuad.tabba@linux.dev>
References: <20260921074451.3158645-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::83;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:27:51 -0400
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
---
 target/arm/helper.c               |  9 +++++----
 tests/tcg/aarch64/system/vtimer.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6..f89f41fe63 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1575,11 +1575,12 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
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
2.39.5


