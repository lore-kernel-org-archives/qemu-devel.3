Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED325CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJ0-0005XE-Gh; Wed, 01 Oct 2025 03:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIn-0005No-Mx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIW-0003Qu-4f
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=GEWNFhGKe8bX29w4np/041m+yKBZEmJhkOsVFMdByTE=; b=obQf6o+DH7CBooH
 EpeHZMAfKloUx9rFFCj5SkNbgRcK3QMwO2hszi8Pz+POHl5c1tiy2BFJBXL9HXt3BxnZnkKpwk5ay
 IqgGQ4wtM7zhx2yt4H7maAl8vwkf+5fNW4Ht2MUwlKPUQDswCflNW/f8/3GxxOV5GC/+RHUw2hoxL
 Qo=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 06/33] target/riscv: Combine mcyclecfg and mcyclecfgh
Date: Wed,  1 Oct 2025 09:32:39 +0200
Message-ID: <20251001073306.28573-7-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

According to version 20250508 of the privileged specification, mcyclecfg
is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
register when XLEN == 32.  No real advantage is gained by keeping
them separate, and combining them allows for slight simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 64b9964028..60f7611c00 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -419,8 +419,7 @@ struct CPUArchState {
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
-    target_ulong mcyclecfg;
-    target_ulong mcyclecfgh;
+    uint64_t mcyclecfg;
     target_ulong minstretcfg;
     target_ulong minstretcfgh;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2d8916ee40..77d0bd7bca 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1060,7 +1060,8 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    *val = env->mcyclecfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1070,7 +1071,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mcyclecfg = val;
+        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
     } else {
         /* Set xINH fields if priv mode supported */
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
@@ -1089,7 +1090,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = env->mcyclecfgh;
+    *val = extract64(env->mcyclecfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1107,7 +1108,7 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
-    env->mcyclecfgh = val & inh_avail_mask;
+    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1246,8 +1247,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     g_assert(rv32 || !upper_half);
 
     if (counter_idx == 0) {
-        cfg_val = rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
-                  env->mcyclecfg;
+        cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
         cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
@@ -1521,8 +1521,12 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
 }
 
 static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                          target_ulong new_val, uint64_t wr_mask)
 {
+    /*
+     * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
+     * are retained.
+     */
     switch (cfg_index) {
     case 0:             /* CYCLECFG */
         if (wr_mask) {
@@ -1548,8 +1552,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
 }
 
 static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                           target_ulong new_val, target_ulong wr_mask)
 {
+    uint64_t cfgh;
 
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -1557,12 +1562,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
+        cfgh = extract64(env->mcyclecfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MCYCLECFGH_BIT_MINH;
-            env->mcyclecfgh = (new_val & wr_mask) |
-                              (env->mcyclecfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = env->mcyclecfgh;
+            *val = cfgh;
         }
         break;
     case 2:          /* INSTRETCFGH */
-- 
2.51.0


