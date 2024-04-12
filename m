Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D27C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBaQ-0001Ys-IE; Fri, 12 Apr 2024 03:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBaO-0001YQ-CA; Fri, 12 Apr 2024 03:44:36 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBaK-0000S5-Kj; Fri, 12 Apr 2024 03:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712907866; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=hKbo4P0vi87lED25C2k2TdmTf1KALgcOHYKTjpACgqs=;
 b=NQ29oGTcqR49ovH3DRUlTWGTfw8/40AxDtqdTyarOUiHG/9hZJlo1IZRBp/VzcgX11mPSNEOoE3e4J7ZvQgfHZjzXHCYmDRprJb2jLVcvvhsSEYl21cOKUC6huH9UjRbcULz52eh47LpPYjb/B7aim8p9piJkV4fYnxZeeXegEM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NQAh5_1712907864; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NQAh5_1712907864) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:44:25 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 03/65] target/riscv: Add properties for XTheadVector extension
Date: Fri, 12 Apr 2024 15:36:33 +0800
Message-ID: <20240412073735.76413-4-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Add ext_xtheadvector properties.
In this patch, we add ext_xtheadvector in RISCVCPUConfig
for XTheadVector as a start. In rv64_thead_c906_cpu_init,
we make ext_xtheadvector equals false to avoid affecting
other extensions when it is not fully implemented.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/cpu.c         |  3 +++
 target/riscv/cpu_cfg.h     |  2 ++
 target/riscv/cpu_helper.c  |  2 +-
 target/riscv/tcg/tcg-cpu.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3f21c976ba..05652e8c87 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -201,6 +201,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadmemidx, PRIV_VERSION_1_11_0, ext_xtheadmemidx),
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
+    ISA_EXT_DATA_ENTRY(xtheadvector, PRIV_VERSION_1_11_0, ext_xtheadvector),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 
     DEFINE_PROP_END_OF_LIST(),
@@ -541,6 +542,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.ext_xtheadmemidx = true;
     cpu->cfg.ext_xtheadmempair = true;
     cpu->cfg.ext_xtheadsync = true;
+    cpu->cfg.ext_xtheadvector = false;
 
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
@@ -1567,6 +1569,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
+    MULTI_EXT_CFG_BOOL("xtheadvector", ext_xtheadvector, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..da85e94e04 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -149,6 +149,7 @@ struct RISCVCPUConfig {
     bool ext_xtheadmemidx;
     bool ext_xtheadmempair;
     bool ext_xtheadsync;
+    bool ext_xtheadvector;
     bool ext_XVentanaCondOps;
 
     uint32_t pmu_mask;
@@ -205,6 +206,7 @@ MATERIALISE_EXT_PREDICATE(xtheadmac)
 MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
+MATERIALISE_EXT_PREDICATE(xtheadvector)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..5882b65321 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
 
-    if (cpu->cfg.ext_zve32f) {
+    if (cpu->cfg.ext_zve32f || cpu->cfg.ext_xtheadvector) {
         /*
          * If env->vl equals to VLMAX, we can use generic vector operation
          * expanders (GVEC) to accerlate the vector operations.
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 483774e4f8..f7a105b30e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -281,6 +281,25 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void th_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
+                              Error **errp)
+{
+    uint32_t vlen = cfg->vlenb << 3;
+
+    if (vlen < 32) {
+        error_setg(errp,
+                   "In XTheadVector extension, VLEN must be "
+                   "greater than or equal to 32");
+    }
+
+    if (vlen < cfg->elen) {
+        error_setg(errp,
+                   "In XTheadVector extension, VLEN must be "
+                   "greater than or equal to ELEN");
+        return;
+    }
+}
+
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
@@ -485,6 +504,20 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_xtheadvector && riscv_has_ext(env, RVV)) {
+        error_setg(errp, "XTheadVector extension is incompatible with "
+                         "RVV extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_xtheadvector) {
+        th_cpu_validate_v(env, &cpu->cfg, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     if (riscv_has_ext(env, RVV)) {
         riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
         if (local_err != NULL) {
-- 
2.44.0


