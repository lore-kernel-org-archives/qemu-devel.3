Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB387CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQol-00063o-E2; Wed, 10 Apr 2024 01:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQoN-0004sO-7n; Wed, 10 Apr 2024 01:47:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQoL-000271-Lb; Wed, 10 Apr 2024 01:47:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 414815D4FF;
 Wed, 10 Apr 2024 08:46:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 06E0FB0166;
 Wed, 10 Apr 2024 08:44:19 +0300 (MSK)
Received: (nullmailer pid 4182120 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 39/41] hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS
 if int group is disabled
Date: Wed, 10 Apr 2024 08:44:00 +0300
Message-Id: <20240410054416.4181891-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

If the group of the highest priority pending interrupt is disabled
via ICC_IGRPEN*, the ICC_HPPIR* registers should return
INTID_SPURIOUS, not the interrupt ID.  (See the GIC architecture
specification pseudocode functions ICC_HPPIR1_EL1[] and
HighestPriorityPendingInterrupt().)

Make HPPIR reads honour the group disable, the way we already do
when determining whether to preempt in icc_hppi_can_preempt().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240328153333.2522667-1-peter.maydell@linaro.org
(cherry picked from commit 44e25fbc1900c99c91a44e532c5bd680bc403459)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index f71b3b07d8..ddfbc69d65 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1065,7 +1065,7 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
@@ -1102,7 +1102,7 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
      */
     bool irq_is_secure;
 
-    if (cs->hppi.prio == 0xff) {
+    if (icc_no_enabled_hppi(cs)) {
         return INTID_SPURIOUS;
     }
 
-- 
2.39.2


