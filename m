Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3D4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENrg-0003Kl-6j; Wed, 07 Oct 2026 05:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9w-0001Ef-04; Wed, 07 Oct 2026 04:37:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9t-0006WG-IN; Wed, 07 Oct 2026 04:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=xt0A8L2JLKBMYvHjCO+7hPWUPsVRLzaRiTc30QzyD9E=; b=iuHDqrE4XyrDZdj
 YLqh3pv+Uvzc50ml2VDoVADn0ELwxUw0FNUHH/aqqW6w0CNjTDaqGnV8rYPsCxoGN5Bugk8osMQa5
 ysrXfXDHu5VZoGOu4XY+ILU8iFMeHkMlJFGDMkAMBR0S/8GOc77fRiIdOWvvyQF1U10cZMyaJ83jl
 14=;
Date: Wed, 07 Oct 2026 10:43:09 +0200
Subject: [PATCH v2 03/18] target/riscv: Move pmu CSR read to csr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-3-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362619; l=2605;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=MhVfgEeYih5zZaa3oYtfTNn9V1R/uzFpbRO112c5EyM=;
 b=ZdIGXqSGj4pHyk0WmscI4Pd+0EBRKpFU2vwwAxoRlW7J/iIvrSBSmN3ynUfdqe4y7T49MSlHG
 JJD83qVN2PgCzUQ34klx6p7bfA89zIirkoRsbwdynB4ksCc52/A86VK
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

pmu.c can then be compiled once for system-mode alongside csr.c/csr.h
in a follow up commit, since it's otherwise target agnostic.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/csr.h       | 4 ++++
 target/riscv/tcg/pmu.h       | 3 ---
 target/riscv/tcg/pmu.c       | 5 +++--
 target/riscv/tcg/meson.build | 2 --
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 53ba3b4a4d..03f96cce04 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -99,4 +99,8 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 
+/* Used in pmu.c */
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+                                  bool upper_half, uint32_t ctr_idx);
+
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index fbdbfe7600..7e42359f87 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -21,7 +21,6 @@
 
 #include "cpu.h"
 #include "qapi/error.h"
-#include "exec/target_long.h"
 
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
@@ -38,7 +37,5 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
 void riscv_pmu_decr_instret(CPURISCVState *env);
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 1a4658319b..c8acb85df4 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -20,8 +20,9 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "cpu.h"
-#include "pmu.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/tcg/pmu.h"
+#include "target/riscv/tcg/csr.h"
 #include "exec/icount.h"
 #include "system/device_tree.h"
 
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index a05ab642f4..954dfc10e0 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -25,5 +25,3 @@ riscv_system_ss.add(files(
   'pmu.c',
   'th_csr.c',
 ))
-
-

-- 
2.52.0


