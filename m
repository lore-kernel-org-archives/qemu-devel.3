Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD2606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=UKAfhDHr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Hb-0005rD-V5; Mon, 16 Nov 2026 15:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HO-0004nq-Ok; Mon, 16 Nov 2026 15:26:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HM-0006ow-DN; Mon, 16 Nov 2026 15:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=wOfKdIR2XWwneHGofuhzI0Uv08hx5A0T3VMCirD7IM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UKAfhDHrJq2ZMPewX+lJm9xRkij2u0XXvnGHmV5X7glJcKLpocLkhkwd4j87M+X2F
 oqW5yTJbJexhCQ3VPtPa5wh7yJRlU9uyYcvdTU30LWQ1X7J6JRmT5mfX7EuwR4GKD/
 ql20X2Ojp+5ZzbNBjXR8uX6b3xzWRjt7xOZD72CCsWo8gkVe6GoIhtrGlhZ6SrCprp
 iBtuQlKC9zAifLSwdNyatRqcnyZ/hz6dYtclzetISuPIkuXbLaKqUfyu/i0xe40yVJ
 awhADWWueNEyV2qTLeHjI20K7/LvCaIyEy2ovje2JdrjWNxy6QNxY/BevQoi6lFk6Q
 2vTmiAp2jlBNA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB06C1E719C;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A77F445FBC8;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7D2F6B8E54; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harshit Mukhedkar <harshit007k@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 07/63] target/riscv: fix uninitialised upper half in
 pmu_timer_trigger_irq()
Date: Mon, 16 Nov 2026 23:24:46 +0300
Message-ID: <20261116202554.535325-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harshit Mukhedkar <harshit007k@gmail.com>

pmu_timer_trigger_irq() reads the counter by passing
(target_ulong *)&curr_ctr_val to riscv_pmu_read_ctr(). On RV32 that
pointer is to a 32 bit type, so only half of the uint64_t gets written
and the rest is whatever was on the stack. The high word read from
riscv_pmu_read_ctr() is then ORed in on top of that, and the result is
compared against the software written counter to decide whether to raise
LCOFI. A stray bit in the garbage half can make that comparison wrong.

Read the low and high halves into their own target_ulong variables and
assemble the 64-bit value explicitly.

This was found while looking at #4724, whose reported mhpmcounterh
mismatch is fixed separately by 57b484e2d232.

Fixes: 74112400df65 ("target/riscv: More accurately model priv mode filtering.")
Cc: qemu-stable@nongnu.org
Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261023093522.34335-1-harshit007k@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9164d533ecaebd9d07f61e5fc7026cc9afa80e92)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 1a4658319b1..0165faf06b8 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -355,7 +355,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
     int64_t irq_trigger_at;
-    uint64_t curr_ctr_val, curr_ctrh_val;
+    target_ulong ctr_lo = 0, ctr_hi = 0;
+    uint64_t curr_ctr_val;
     uint64_t ctr_val;
 
     if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
@@ -383,12 +384,19 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
-    ctr_val = counter->mhpmcounter_val;
+    /*
+     * riscv_pmu_read_ctr() stores a target_ulong, so on RV32 each call fills
+     * only 32 bits. Read each half into its own target_ulong and build the
+     * 64 bit value explicitly instead of passing a cast uint64_t pointer,
+     * which would leave the upper half uninitialised.
+     */
+    riscv_pmu_read_ctr(env, &ctr_lo, false, ctr_idx);
+    curr_ctr_val = ctr_lo;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
-        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
+        riscv_pmu_read_ctr(env, &ctr_hi, true, ctr_idx);
+        curr_ctr_val |= (uint64_t)ctr_hi << 32;
     }
+    ctr_val = counter->mhpmcounter_val;
 
     /*
      * We can not accommodate for inhibited modes when setting up timer. Check
-- 
2.47.3


