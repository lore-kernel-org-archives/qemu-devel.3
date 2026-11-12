Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999A606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LX1ViSaF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSP-0002M1-Nr; Thu, 12 Nov 2026 04:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRc-0001nb-La; Thu, 12 Nov 2026 04:50:13 -0500
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRT-0002z2-Qh; Thu, 12 Nov 2026 04:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476978; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=0+QmosQaUvj77IJqM050H4gloREgBJmGLYFruWMTSD8=;
 b=LX1ViSaFMtfTwJ26lkW5EQY7b8hdoOyPSoNT4SfOB9bZdRtl7okuDrNJE+LS3/3D8QJlqCjNUBclPKQ1F6Oz2pANJmd92KOJIUYAI7hBDvuUq/9SjNT500ViizTkOJy3dS99MTyQ3Fs+9FUBFk7eNthbg+vzzIHSOLYndU4YLkY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdct_1794476975; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdct_1794476975 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:35 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 12 Nov 2026 17:49:17 +0800
Subject: [PATCH v4 11/14] target/riscv: Process PMU timer expiry on the
 owner vCPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-riscv-pmu-correctness-v4-11-e9067bdf4df5@linux.alibaba.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
In-Reply-To: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=2541;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=sZPadpLoQTwcc1siEMiPw/FTsQEz344Ju8iam7hMD5g=;
 b=gbi8xHEgraFLWdgqHDzGGXDZYTwetMOzvZL/mAupZDzJBEnUnZ/7WtuuM1PjGv22n6BlvMRYH
 czPnBRloBZmARyA+Fb/t0pjKKnhhoponUfPDjmsEYa43auK5DjCyZdA
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PMU timer callback can race MTTCG execution and CSR writes while
reading the event map and updating counters, OF and MIP.

Queue counter checks on the owning vCPU. The callback atomically sets
pmu_timer_work_pending and queues work only if it was previously false.
The vCPU clears the flag before checking counters and rebuilding the
timer. Timer expirations before the flag is cleared are covered by that
check; the first expiration afterward queues another check.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h     |  1 +
 target/riscv/tcg/pmu.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d7cc36bc621def7bf3dae33e133807e5f5e13b5f..360d08b9d4448023ce96211b8bc9cafa77366c40 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -591,6 +591,7 @@ struct ArchCPU {
     QEMUTimer *pmu_timer;
     uint64_t pmu_timer_instret_snapshot;
     bool pmu_timer_stalled;
+    bool pmu_timer_work_pending;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 08298010b6d06f5792fa14ff81fe2f7a28c6476f..6286552a4ebf614df0252f84ddfadbc25d8d2258 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -663,15 +663,29 @@ void riscv_pmu_rebuild_timer(CPURISCVState *env)
     riscv_pmu_rebuild_timer_internal(env, false);
 }
 
+static void riscv_pmu_timer_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+
+    /*
+     * An expiry before this exchange is covered by the following counter
+     * check. The first expiry after it sets pmu_timer_work_pending and queues
+     * another check.
+     */
+    qatomic_xchg(&cpu->pmu_timer_work_pending, false);
+    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
+}
+
 /* Timer callback for instret and cycle counter overflow */
 void riscv_pmu_timer_cb(void *priv)
 {
     RISCVCPU *cpu = priv;
 
-    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
+    if (!qatomic_xchg(&cpu->pmu_timer_work_pending, true)) {
+        async_run_on_cpu(CPU(cpu), riscv_pmu_timer_work, RUN_ON_CPU_NULL);
+    }
 }
 
-
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 {
     if (cpu->cfg.pmu_mask & (COUNTEREN_CY | COUNTEREN_TM | COUNTEREN_IR)) {

-- 
2.43.0


