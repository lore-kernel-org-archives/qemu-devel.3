Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B3606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ho38fJeG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAv6-0005xl-4u; Thu, 19 Nov 2026 17:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv4-0005x1-A3
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:54 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv1-0004Gr-Nl
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:53 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84E866115E;
 Thu, 19 Nov 2026 22:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4686F1F000C6;
 Thu, 19 Nov 2026 22:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795128469;
 bh=BB3Ub95FbHuB1A/cShSmZhYpai1KsSReEoj2D9G4WkU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ho38fJeGVtrTG/YD1ASxLtPVkeyWtLf+klG9MQ5kKaRd4YDNJGocqFlZzcXIQ18y6
 X3Vk1T7/exeObBd1od3PjWspkZ9UOhwNy8XQ5EMdbAmd+5MmyG4c3KiQtep3NUgaMs
 KoBJjdepSBS1ko83XQmHGhfqNFjGfsAavfdNTrKGnMb6bDD6QnW74efO5iXf65CkjB
 Ohwm9Oeowp6cDHLmHBI8REV+QVHjTxkmQdgd/C+jCryqYeopFx/Q8EcHjpmcOzg0Z1
 pivzajQTRzVMUJOKw9TZ9nWUGqcf3YEW6B6GYDZSd+3JSgt7kClTb1F+Wgt5wRt7o7
 cpdne/FbNUPTw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/4] target/hppa: clear EIRR under the BQL and keep the
 interval timer matching
Date: Thu, 19 Nov 2026 23:47:41 +0100
Message-ID: <20261119224744.31309-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119224744.31309-1-deller@kernel.org>
References: <20261119224744.31309-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

An unlocked EIRR clear could drop a tick set by the main loop thread,
leaving the guest clock dead. HP-UX 10.20 installs wedged this way.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/int_helper.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 598d1c6cef..da9c7c6457 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -25,6 +25,7 @@
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
 #include "qemu/plugin.h"
+#include "qemu/timer.h"
 
 static void eval_interrupt(HPPACPU *cpu)
 {
@@ -78,14 +79,34 @@ const MemoryRegionOps hppa_io_eir_ops = {
 
 void hppa_cpu_alarm_timer(void *opaque)
 {
+    HPPACPU *cpu = opaque;
+
     /* Raise interrupt 0.  */
     io_eir_write(opaque, 0, 0, 4);
+
+    /*
+     * Re-arm the alarm one counter wrap later.  The hardware compares CR16
+     * against a free running 32-bit counter, so the match recurs every
+     * 2^32 counts, which is 2^34 ns at the 250 MHz shown to the guest.
+     * This brings the model closer to that and limits a lost tick to a
+     * 17 s stall instead of a dead clock.
+     */
+    cpu->env.cr[CR_IT] += 1ULL << 34;
+    timer_mod(cpu->alarm_timer, cpu->env.cr[CR_IT]);
 }
 
 void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
 {
-    env->cr[CR_EIRR] &= ~val;
+    /*
+     * Clear EIRR under the BQL.  io_eir_write() sets EIRR bits from the main
+     * loop thread for the interval timer and for device interrupts, and it
+     * holds the BQL.  This helper runs in the vCPU thread, so an unlocked
+     * read-modify-write here drops any bit set between the load and the
+     * store.  A dropped interval timer bit is never re-armed and the guest
+     * clock stops, which is how HP-UX 10.20 installs wedged under load.
+     */
     bql_lock();
+    env->cr[CR_EIRR] &= ~val;
     eval_interrupt(env_archcpu(env));
     bql_unlock();
 }
-- 
2.54.0


