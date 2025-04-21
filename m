Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D93BC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 09:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6nkQ-0005ZZ-7d; Mon, 21 Apr 2025 05:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u6nkM-0005Xa-Oc
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 05:47:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u6nkK-0000E5-H0
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 05:47:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227914acd20so37662765ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745228843; x=1745833643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXJeNfsAZ6hA+l8T57FZAI2ZxHCiBOWiIM/wn2t3kAA=;
 b=mm/oWycGBGQHVNzyR0ZsKlKU0rW+sg7AFSC2tM/qTN1OJxGtz76gc7sai2ZxFWze/2
 BaoloWyqG4X9rIHfAzG3J6lOMOJhIcstRTnQ6d6np4SWn1T9iFNigwu1F6A/6/5bM83C
 HcuEJ8irj2Lgns968KHJEIi4XUHze1KmePJIU5Ii44K1TxAhkfPeS6lnn9bOEAv6L0ie
 ES3zFozZE52K7gLj9CyJjeu1IhbBOb5i7KESXErXdiuSXlh8zlrMGDPeFAkFcOleedcw
 umi3n1lmtfa9wRzanNRodH17oGVsEcyi+EQWrrL+IrJ1XO2AGX/GQoBHwoWgi5vwUGW7
 MicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745228843; x=1745833643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXJeNfsAZ6hA+l8T57FZAI2ZxHCiBOWiIM/wn2t3kAA=;
 b=g/wNFz42faM/C7C+9Rj9ZVqFNgnQC58oVjlSOwN/5p9PaUyEERQVcRgxJkrJJBv9Wl
 LrmowdToaSJ9pe8AOIjBzGnrgGzNzQJxJ/jnBZQ4bwHnKr/Rywbk+2QKZrQj9s7aBsUb
 I3Guti9u5NQYGw8avbpBo8XzOSfJhLkPpnP28jdgaRo1hpY1l9BA0oW07Gvq9VyYwDX8
 6vzYy2VLQ8fjz9mmV+YDns9bCZ2Gjjv05mv0Xfah4BTUJCluTXPVqvvX9tz9XCjaCyDv
 4jc7WzxGHFP4MFxk6NKT+WNirrw65/qDXj9THY78/lIOfiEEcm3bIOIm9JzBiXeMdcq8
 5/WQ==
X-Gm-Message-State: AOJu0YzNCjDIfwugewt526zEAHhgo8i1H04m7s+bKb4nlGZdOkkKKJk8
 OG74rKNjzkLkqbzM7HeQYfcokKHvTNteqiFQnF+8leawD1dLDVdZXIGrB8LLz/+GMVMqnYLdl4P
 5SxCyiUwQUWeYkOMqt93eJukHfNBXIkRGOlcArbSSxKUl9o103AFx7TTRtDSxQPIaDTlG1/CNou
 RtQDYbdfWDJY0bv1h5CYPDJ4oKwujS8rq3B8LJXPEqgw==
X-Gm-Gg: ASbGnctOSqsof+dGY81YLfKLaWLfxfwqIvFtudHkfe+ouL6hFlGGleZKInmEQzsKVEo
 sESFot/UeOiS51Q4yYb+7hAykQMsQWDamlHtRj71Tn3yIU4FlmJXxc0KDZgVp8nS8dpZjmU+hYL
 Aby3Mw0Lhl9nit4UVyYbGmt477D8cUZyaF/kKtRdgDEHnCVzYbPPxiS7YVBBYgjuy7OzZ+BzxhS
 5GwwWPV/d/fa3XCH7tO4VSggGZCv4f82bZNK8gPi/JEWZi/nA5EgQwfbo4VCx5+6pZO3I2Oek5o
 nnAe0LzO52qsBstaKoMKY5QO/nti74IPKBm6bL02GfxHqMImhjIHrzd5vIIW4jLJUX9Bm9RAnnJ
 tmwhv
X-Google-Smtp-Source: AGHT+IGLWvXZMMiyRYjEwu431APQjspeFV5LDg3sfHt+6v30zxhgrxML0/jiKEUv449J8VeHPrLPNQ==
X-Received: by 2002:a17:902:cf05:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22c50d8c10fmr168123895ad.26.1745228842464; 
 Mon, 21 Apr 2025 02:47:22 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([147.161.192.170])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee330bsm6162137a91.3.2025.04.21.02.47.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Apr 2025 02:47:21 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 2/2] target/riscv: Make PMP region count configurable
Date: Mon, 21 Apr 2025 17:46:56 +0800
Message-ID: <20250421094656.48997-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421094656.48997-1-jay.chang@sifive.com>
References: <20250421094656.48997-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previously, the number of PMP regions was hardcoded to 16 in QEMU.
This patch replaces the fixed value with a new `pmp_regions` field,
allowing platforms to configure the number of PMP regions.

If no specific value is provided, the default number of PMP regions
remains 16 to preserve the existing behavior.

A new CPU parameter num-pmp-regions has been introduced to the QEMU
command line. For example:

	-cpu rv64, g=true, c=true, pmp=true, num-pmp-regions=8

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/cpu.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h     |  2 +-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  5 ++++-
 target/riscv/machine.c |  3 ++-
 target/riscv/pmp.c     | 28 ++++++++++++++++---------
 6 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..528d77b820 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -512,6 +512,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.pmp_regions = 8;
 }
 
 static void rv64_sifive_e_cpu_init(Object *obj)
@@ -529,6 +530,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
     cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.pmp_regions = 8;
 }
 
 static void rv64_thead_c906_cpu_init(Object *obj)
@@ -761,6 +763,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.pmp_regions = 8;
 }
 
 static void rv32_sifive_e_cpu_init(Object *obj)
@@ -778,6 +781,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
     cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
+    cpu->cfg.pmp_regions = 8;
 }
 
 static void rv32_ibex_cpu_init(Object *obj)
@@ -1478,6 +1482,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.pmp_regions = 16;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1935,6 +1940,46 @@ static const PropertyInfo prop_pmp = {
     .set = prop_pmp_set,
 };
 
+static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    visit_type_uint16(v, name, &value, errp);
+
+    if (cpu->cfg.pmp_regions != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > 16) {
+        error_setg(errp, "Number of PMP regions exceeds maximum available");
+        return;
+    } else if (value > 64) {
+        error_setg(errp, "Number of PMP regions exceeds maximum available");
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmp_regions = value;
+}
+
+static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.pmp_regions;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_num_pmp_regions = {
+    .type = "uint16",
+    .description = "num-pmp-regions",
+    .get = prop_num_pmp_regions_get,
+    .set = prop_num_pmp_regions_set,
+};
+
 static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
@@ -2934,6 +2979,7 @@ static const Property riscv_cpu_properties[] = {
 
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
+    {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..50d58c15f2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MMU_USER_IDX 3
 
-#define MAX_RISCV_PMPS (16)
+#define MAX_RISCV_PMPS (64)
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8a843482cc..8c805b45f6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -189,6 +189,7 @@ struct RISCVCPUConfig {
     uint16_t cbom_blocksize;
     uint16_t cbop_blocksize;
     uint16_t cboz_blocksize;
+    uint16_t pmp_regions;
     bool mmu;
     bool pmp;
     bool debug;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f8f61ffff5..65f91be9c0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -736,7 +736,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
 static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
-        if (csrno <= CSR_PMPCFG3) {
+        uint16_t MAX_PMPCFG = (env->priv_ver >= PRIV_VERSION_1_12_0) ?
++                              CSR_PMPCFG15 : CSR_PMPCFG3;
+
+        if (csrno <= MAX_PMPCFG) {
             uint32_t reg_index = csrno - CSR_PMPCFG0;
 
             /* TODO: RV128 restriction check */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 889e2b6570..c3e4e78802 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
     int i;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         pmp_update_rule_addr(env, i);
     }
     pmp_update_rule_nums(env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c685f7f2c5..3439295d41 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -121,7 +121,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
  */
 static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 {
-    if (pmp_index < MAX_RISCV_PMPS) {
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
+
+    if (pmp_index < pmp_regions) {
         return env->pmp_state.pmp[pmp_index].cfg_reg;
     }
 
@@ -135,7 +137,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
  */
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
-    if (pmp_index < MAX_RISCV_PMPS) {
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
+
+    if (pmp_index < pmp_regions) {
         if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
             /* no change */
             return false;
@@ -235,9 +239,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 void pmp_update_rule_nums(CPURISCVState *env)
 {
     int i;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     env->pmp_state.num_rules = 0;
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
         if (PMP_AMATCH_OFF != a_field) {
@@ -331,6 +336,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
     int pmp_size = 0;
     hwaddr s = 0;
     hwaddr e = 0;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
@@ -355,7 +361,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
      * 1.10 draft priv spec states there is an implicit order
      * from low to high
      */
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         s = pmp_is_in_range(env, i, addr);
         e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
@@ -526,8 +532,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 {
     trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
     bool is_next_cfg_tor = false;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    if (addr_index < MAX_RISCV_PMPS) {
+    if (addr_index < pmp_regions) {
         if (env->pmp_state.pmp[addr_index].addr_reg == val) {
             /* no change */
             return;
@@ -537,7 +544,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
          * In TOR mode, need to check the lock bit of the next pmp
          * (if there is a next).
          */
-        if (addr_index + 1 < MAX_RISCV_PMPS) {
+        if (addr_index + 1 < pmp_regions) {
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
             is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
@@ -572,8 +579,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
     target_ulong val = 0;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    if (addr_index < MAX_RISCV_PMPS) {
+    if (addr_index < pmp_regions) {
         val = env->pmp_state.pmp[addr_index].addr_reg;
         trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
     } else {
@@ -591,6 +599,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
     uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
     /* Update PMM field only if the value is valid according to Zjpm v1.0 */
     if (riscv_cpu_cfg(env)->ext_smmpm &&
         riscv_cpu_mxl(env) == MXL_RV64 &&
@@ -602,7 +611,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     /* RLB cannot be enabled if it's already 0 and if any regions are locked */
     if (!MSECCFG_RLB_ISSET(env)) {
-        for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        for (i = 0; i < pmp_regions; i++) {
             if (pmp_is_locked(env, i)) {
                 val &= ~MSECCFG_RLB;
                 break;
@@ -658,6 +667,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
     hwaddr tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
     hwaddr tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
     int i;
+    uint16_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     /*
      * If PMP is not supported or there are no PMP rules, the TLB page will not
@@ -668,7 +678,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
         return TARGET_PAGE_SIZE;
     }
 
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) == PMP_AMATCH_OFF) {
             continue;
         }
-- 
2.48.1


