Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06273C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 05:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFozx-0003kB-Av; Sat, 08 Jun 2024 01:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1sFi5o-0001rc-NJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 18:29:52 -0400
Received: from b-painless.mh.aa.net.uk ([2001:8b0:0:30::52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1sFi5m-000051-KX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 18:29:52 -0400
Received: from thunderhill.nvidia.com ([216.228.112.22]
 helo=localhost.localdomain)
 by painless-b.tch.aa.net.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jholdsworth@nvidia.com>) id 1sFi5k-007UAh-0u;
 Fri, 07 Jun 2024 23:29:48 +0100
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous mode
Date: Fri,  7 Jun 2024 15:29:33 -0700
Message-ID: <20240607222933.45791-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=2001:8b0:0:30::52;
 envelope-from=jholdsworth@nvidia.com; helo=b-painless.mh.aa.net.uk
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Jun 2024 01:52:16 -0400
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
Reply-to:  Joel Holdsworth <jholdsworth@nvidia.com>
From:  Joel Holdsworth via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the existing design, TTCR is prone to undercounting when running in
continuous mode. This manifests as a timer interrupt appearing to
trigger a few cycles prior to the deadline set in SPR_TTMR_TP.

When the timer triggers, the virtual time delta in nanoseconds between
the time when the timer was set, and when it triggers is calculated.
This nanoseconds value is then divided by TIMER_PERIOD (50) to compute
an increment of cycles to apply to TTCR.

However, this calculation rounds down the number of cycles causing the
undercounting.

A simplistic solution would be to instead round up the number of cycles,
however this will result in the accumulation of timing error over time.

This patch corrects the issue by calculating the time delta in
nanoseconds between when the timer was last reset and the timer event.
This approach allows the TTCR value to be rounded up, but without
accumulating error over time.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 hw/openrisc/cputimer.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 835986c4db..ddc129aa48 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -29,7 +29,8 @@
 /* Tick Timer global state to allow all cores to be in sync */
 typedef struct OR1KTimerState {
     uint32_t ttcr;
-    uint64_t last_clk;
+    uint32_t ttcr_offset;
+    uint64_t clk_offset;
 } OR1KTimerState;
 
 static OR1KTimerState *or1k_timer;
@@ -37,6 +38,8 @@ static OR1KTimerState *or1k_timer;
 void cpu_openrisc_count_set(OpenRISCCPU *cpu, uint32_t val)
 {
     or1k_timer->ttcr = val;
+    or1k_timer->ttcr_offset = val;
+    or1k_timer->clk_offset = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
 
 uint32_t cpu_openrisc_count_get(OpenRISCCPU *cpu)
@@ -53,9 +56,8 @@ void cpu_openrisc_count_update(OpenRISCCPU *cpu)
         return;
     }
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    or1k_timer->ttcr += (uint32_t)((now - or1k_timer->last_clk)
-                                    / TIMER_PERIOD);
-    or1k_timer->last_clk = now;
+    or1k_timer->ttcr = (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD +
+        or1k_timer->ttcr_offset;
 }
 
 /* Update the next timeout time as difference between ttmr and ttcr */
@@ -69,7 +71,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
     }
 
     cpu_openrisc_count_update(cpu);
-    now = or1k_timer->last_clk;
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     if ((cpu->env.ttmr & TTMR_TP) <= (or1k_timer->ttcr & TTMR_TP)) {
         wait = TTMR_TP - (or1k_timer->ttcr & TTMR_TP) + 1;
@@ -110,7 +112,8 @@ static void openrisc_timer_cb(void *opaque)
     case TIMER_NONE:
         break;
     case TIMER_INTR:
-        or1k_timer->ttcr = 0;
+        /* Zero the count by applying a negative offset to the counter */
+        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
         break;
     case TIMER_SHOT:
         cpu_openrisc_count_stop(cpu);
@@ -137,8 +140,8 @@ static void openrisc_count_reset(void *opaque)
 /* Reset the global timer state. */
 static void openrisc_timer_reset(void *opaque)
 {
-    or1k_timer->ttcr = 0x00000000;
-    or1k_timer->last_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    OpenRISCCPU *cpu = opaque;
+    cpu_openrisc_count_set(cpu, 0);
 }
 
 static const VMStateDescription vmstate_or1k_timer = {
@@ -147,7 +150,8 @@ static const VMStateDescription vmstate_or1k_timer = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ttcr, OR1KTimerState),
-        VMSTATE_UINT64(last_clk, OR1KTimerState),
+        VMSTATE_UINT32(ttcr_offset, OR1KTimerState),
+        VMSTATE_UINT64(clk_offset, OR1KTimerState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.44.1


