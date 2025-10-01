Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA0CCD180
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rIe-0005Km-8H; Wed, 01 Oct 2025 03:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIb-0005KO-E0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:30:53 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rIU-0003RU-Gt
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=fD+d4xMHP1K3jVD7TLyUDXmHaaSzUNt6ptYAnz+DLx8=; b=dNZ/zDd9v5goRrz
 uP2WhzRsyuhIBPQSR+c/xTxS9q000md/9S3y/3YyXA09a7fvnKL0H//agU01ZWzbeqbQQs7irpNF2
 Z8GIlcn4Kx69XAPTxowEVCQ+f4cw6YBZwmxyv1tmTQScwH6Z+FduGDIvnJ7x3MRuQSL3ocE9L26Hh
 Dk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 07/33] target/riscv: Combine minstretcfg and minstretcfgh
Date: Wed,  1 Oct 2025 09:32:40 +0200
Message-ID: <20251001073306.28573-8-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

According to version 20250508 of the privileged specification,
minstretcfg is a 64-bit register and minstretcfgh refers to the top
32 bits of this register when XLEN == 32.  No real advantage is
gained by keeping them separate, and combining them allows for slight
simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 60f7611c00..d8f0818b08 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -420,8 +420,7 @@ struct CPUArchState {
 
     /* PMU cycle & instret privilege mode filtering */
     uint64_t mcyclecfg;
-    target_ulong minstretcfg;
-    target_ulong minstretcfgh;
+    uint64_t minstretcfg;
 
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 77d0bd7bca..83f6526723 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1115,7 +1115,8 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
 static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    *val = env->minstretcfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->minstretcfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1142,7 +1143,7 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
 static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
                                         target_ulong *val)
 {
-    *val = env->minstretcfgh;
+    *val = extract64(env->minstretcfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1159,7 +1160,8 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
 
-    env->minstretcfgh = val & inh_avail_mask;
+    env->minstretcfg = deposit64(env->minstretcfg, 32, 32,
+                                 val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1249,8 +1251,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     if (counter_idx == 0) {
         cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
-        cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
-                  env->minstretcfg;
+        cfg_val = env->minstretcfg;
     } else {
         cfg_val = env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
@@ -1572,12 +1573,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
         }
         break;
     case 2:          /* INSTRETCFGH */
+        cfgh = extract64(env->minstretcfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MINSTRETCFGH_BIT_MINH;
-            env->minstretcfgh = (new_val & wr_mask) |
-                                (env->minstretcfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
         } else {
-            *val = env->minstretcfgh;
+            *val = cfgh;
         }
         break;
     default:
-- 
2.51.0


