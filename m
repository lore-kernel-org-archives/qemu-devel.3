Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2255DD64060
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVenC-0001E7-Jj; Tue, 16 Dec 2025 18:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen6-0001CZ-I2
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVen4-0006mH-Fs
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=vaTs1VnbsgKYFk8rZjeEaioTtQMT1eDTmwJ9+Jy4GbM=; b=xD8La5KHboaFf6w
 feyOhLUO5Ak7i2g4F+3wNeICCx7Beu+BWfDH5nI/iKoS9/j9fvIz3oS9WHumiC38WtpCfK6cAFMjh
 zzsEircaNsYkCyFt3aYK3k5CGTDxEUn5Fsbi0Qt2fuABXnu7VL8s7AedmuEL79SHPjRdnfCnqjdUg
 fo=;
Date: Wed, 17 Dec 2025 00:51:16 +0100
Subject: [PATCH 11/14] target/riscv: Make pmu.h target-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-hw-riscv-cpu-int-v1-11-d24a4048d3aa@rev.ng>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/pmu.h | 2 +-
 target/riscv/pmu.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index ca40cfeed6..273d8f3f94 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -34,7 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 9701c8cba6..d818c2f8f6 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -115,7 +115,8 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
  *  new priv and new virt values are passed in as arguments.
  */
 static void riscv_pmu_icount_update_priv(CPURISCVState *env,
-                                         target_ulong newpriv, bool new_virt)
+                                         privilege_mode_t newpriv,
+                                         bool new_virt)
 {
     uint64_t *snapshot_prev, *snapshot_new;
     uint64_t current_icount;
@@ -155,7 +156,8 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
 }
 
 static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
-                                        target_ulong newpriv, bool new_virt)
+                                        privilege_mode_t newpriv,
+                                        bool new_virt)
 {
     uint64_t *snapshot_prev, *snapshot_new;
     uint64_t current_ticks;
@@ -190,7 +192,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     counter_arr[env->priv] += delta;
 }
 
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt)
 {
     riscv_pmu_cycle_update_priv(env, newpriv, new_virt);

-- 
2.51.0


