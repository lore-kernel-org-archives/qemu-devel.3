Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA5C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Fsc-0002yo-Fr; Sun, 06 Sep 2026 12:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsZ-0002x5-VZ; Sun, 06 Sep 2026 12:38:04 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsQ-00034R-Qr; Sun, 06 Sep 2026 12:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712658; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=ksc6jpcXXgLeXQNaH+DYLymXmDnFTGRTvna+17U5yjo=;
 b=JGmcCm96QddXbpTI6znnrKMNOy0UZkc4QU7pKa4v5A9b0EjSSFGNGITqBf7yL7xitbz4k4YeRDi05gZAYNjeHb2oxfwCSizQvDrUorLb9lJY1NxxMSnjje8u5pzpKn0MsSnpyZsErb8dpKCLqg0vIh25EpKKNz6nM9t3FXnQztg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIKQ_1788712657; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIKQ_1788712657 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:37 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:27 +0800
Subject: [PATCH 11/14] target/riscv: Process PMU timer expiry on the owner vCPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-11-5f1f41458989@linux.alibaba.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
In-Reply-To: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=2433;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=xGqFDfh9IR3JQbU7GQ/PgD80X6pKA6c3w5l7P5xkpoI=;
 b=DoM+dtGJuWp0nPnNOEJe1rcDJvDncluVdFxmKgN0heBacWbKCX2FX3WrDjdeCZ1K8ncKKgvyg
 1pYRk4rnYUlDBPjaPlOLiPHAyEdXDXYXgbvr8CSKn/lYzwMppLxoXyR
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The PMU timer callback can race MTTCG execution and CSR writes while
reading the event map and updating counters, OF and MIP.

Queue counter checks on the owning vCPU. The callback atomically sets
pmu_timer_work_pending and queues work only if it was previously false.
The vCPU clears the flag before checking counters and rebuilding the
timer. Earlier expiries are covered by that check; the first later expiry
queues another check.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h     |  1 +
 target/riscv/tcg/pmu.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 17b9929785f668487d2ec851b736d588e025fd91..a4d33f55c4e5cb6052cea6bee4c0afa46372b5c5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -583,6 +583,7 @@ struct ArchCPU {
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


