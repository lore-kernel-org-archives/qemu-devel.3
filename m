Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0FBC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FcV-0007ov-A1; Fri, 25 Apr 2025 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcO-0007i1-H9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcL-0001GU-7A
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso24219285ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745574307; x=1746179107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPyR9ISg3Z6Gzq43oyU6p3l7xjpmxyGvN24IK2eZha8=;
 b=FsEhOiabi1+0aW5FlCGFKzdblFafVa1gp19Zl8+1ik2bxxG8IlORiOhUgHBc4JWIMi
 WmI/Ujop1Vmip/Fs7Rc1AVovRQzbj+fAAquqy6E9dY0l1t02t4BDahVyB1n9kd8CEB/l
 UumO6PerQoKrveBLS2BOcKGJ/iuvZUvk4SzbFppfn7b2QKVNl/asKvkcUE2Ijos8svFH
 yjrygxrntWSNuqXxeJszxb43lduZfuQKuzqL8ztgwoXKD/g3RyLOsakR8UZR/9uisjQV
 1jxUfif8vpp2OnIGBvs9XJcXZeA1BbCdWIELpLfj2BCXK7BCQL//HFQRQFVVE3FTMwDX
 deEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574307; x=1746179107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPyR9ISg3Z6Gzq43oyU6p3l7xjpmxyGvN24IK2eZha8=;
 b=LYA7AjBQIogLjrNjnBCiiyjdR3wWdy8KNWDem20kT+5DBKvWaY/ojm37NLeFG3KQXL
 +LtB0eQnji2ZPuhf2JsKfSxX1fx91ZOncS55ekK3f1rF1AVtwfWTtqqeTA+zZydsgPgx
 B05WAI6cUn64bhhNTdi+XJHJLsDmXA4fHSHkUebgqtIvumHZP0qvzbFIzGKz7Z3Eph9R
 OvNtMIog3EouU+sQmk6gnhtpf8BWhmR+0Y47D76V1KMdc8Hy9tVtJWIqmbUBsQ9N/ucg
 iM43hieVKvlT6Z+ManDtXUF5RL+XR3UnCiQU/x6u24K8S3thun1hlCMfv+cmw0z4jG81
 493g==
X-Gm-Message-State: AOJu0Yy/hrZNAQEsj5R/g5Dgu24YYP1yhKRiup56dP4xv3KwohqpBTeA
 GPqKqO8b6Tj+o1G3nLap1YW1ybQ8KdwkPzsaPrAVzjisY2QlzQQ8GqR6NpEkpufIQUh6jTvu6zt
 Mj6Z0/Rzgl0bBV7R1F5wKyg5F5CbsfCpPbfh+ODB1I42QK0qqzBYknnAJmFGhQPdXxT7mapxlzM
 xuxVjhNUZDtfNQOlvzGp8MPBBMQgBnI4MiVGOyDJOZAdiy
X-Gm-Gg: ASbGncu0AqbT48BLgVJhvNH0ezua7KqUod+6bKJq+eOv3aJpJnw3SHKwzJ/pcylVEBS
 fz+spyghTB+zZFAjhPJduj4NyvsFVmgz+I0CgswtfJwcQ9GHpPLMv8rrDJnus2Y2MiVItMdXUek
 wDklGj7+z+Edp3puUOLG7iNqLWebv6kEFtoOR+nz3JqiPIgcWKmfr+PrsxwGKMVd6RgE9wlzCrh
 Tq0Sw+cbWVdTvvDR1rjP1xSYE1z91h7zx4XPyPUbhpM63N7uHyjT4gqtjCuzz47PVFNb8uWeM6P
 VUnv/Q2FORVCUqEnhWR8IPNj3L9iHcyNWL2iutDe90IuR7hT9Vgcr8dsRE+LREdV6Y6qbTOBjPp
 JreDv8vFu+uZC34FP5Xl+
X-Google-Smtp-Source: AGHT+IEqq3nt6n75tIdmubGO21PuetqxIPHl6yVqppq6my43SHCp951bQdTpK7NfhDB0+eKdyJIGFg==
X-Received: by 2002:a17:90b:5101:b0:305:2d27:7ba0 with SMTP id
 98e67ed59e1d1-309f7d87675mr2877505a91.6.1745574306984; 
 Fri, 25 Apr 2025 02:45:06 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.228.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f27e22dasm2288826a91.17.2025.04.25.02.45.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 02:45:06 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 2/2] target/riscv: Make PMP region count configurable
Date: Fri, 25 Apr 2025 17:44:52 +0800
Message-ID: <20250425094452.17013-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425094452.17013-1-jay.chang@sifive.com>
References: <20250425094452.17013-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/riscv/cpu.c                | 54 +++++++++++++++++++++++++++++--
 target/riscv/cpu.h                |  2 +-
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                |  5 ++-
 target/riscv/machine.c            |  3 +-
 target/riscv/pmp.c                | 28 ++++++++++------
 6 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee20bd7ca2..9cab08f9df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.pmp_regions = 16;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1574,6 +1575,46 @@ static const PropertyInfo prop_pmp = {
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
@@ -2573,6 +2614,7 @@ static const Property riscv_cpu_properties[] = {
 
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
+    {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
@@ -2895,6 +2937,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
         .cfg.mmu = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
         .priv_spec = PRIV_VERSION_LATEST,
     ),
 
@@ -2941,7 +2984,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_MBARE,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
-        .cfg.pmp = true
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 8
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
@@ -2952,7 +2996,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-        .cfg.pmp = true
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 8
     ),
 
 #if defined(TARGET_RISCV32) || \
@@ -2970,6 +3015,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
         .cfg.ext_smepmp = true,
 
         .cfg.ext_zba = true,
@@ -3044,6 +3090,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xtheadmempair = true,
         .cfg.ext_xtheadsync = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
 
         .cfg.mvendorid = THEAD_VENDOR_ID,
 
@@ -3067,6 +3114,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.rvv_ta_all_1s = true,
         .cfg.misa_w = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
         .cfg.cbom_blocksize = 64,
         .cfg.cbop_blocksize = 64,
         .cfg.cboz_blocksize = 64,
@@ -3123,6 +3171,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
         .cfg.ext_zicbom = true,
         .cfg.cbom_blocksize = 64,
         .cfg.cboz_blocksize = 64,
@@ -3167,6 +3216,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         .cfg.mmu = true,
         .cfg.pmp = true,
+        .cfg.pmp_regions = 8,
 
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 679f417336..de4517c4f8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -162,7 +162,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MMU_USER_IDX 3
 
-#define MAX_RISCV_PMPS (16)
+#define MAX_RISCV_PMPS (64)
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59f134a419..d80eb1eb7b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
 TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
+TYPED_FIELD(uint16_t, pmp_regions, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 41cf469615..daaef8c438 100644
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
index df2d5bad8d..e9a179ae55 100644
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


