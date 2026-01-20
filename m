Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7BDD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi72I-0005Ef-PV; Tue, 20 Jan 2026 03:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72H-0005Ce-1S
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:25 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72E-00032z-Ra
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:24 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so1878148a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897461; x=1769502261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IIJ+faclScSBNq5NpxC/1LmlPlQSbjBx402NxvLJP4=;
 b=bpTlZwYHH9pkzBIq7dzhQIHMz9IOY5aVyPjjXjr9QRqOkgIOh75HQTpgmdR4zktq9L
 ovD+8hHChwaB8CexZMKvc2batP7qKH7yUdFe7hRMKaUhCTlWLWzkQyHNsRU2yjckT82H
 4n3d1X3ciPnhQn3UIVwjdBjX58chwxMqpUZzzGcz6d8s66dteMqcJ0RJfXDcRmJfmHI9
 oCOrFAEjtMtmSVl+WJtFx98tX84+bXM6BoKHABkUGi28qjjqFcUyqyFpND+IYUKJ3T2/
 5mxaI1pRuqH/A0cnmJT7uN55tgCFZQeMw18WMixbaQQAgpldwYfJmp94wcTF8q5gUiqD
 r8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897461; x=1769502261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3IIJ+faclScSBNq5NpxC/1LmlPlQSbjBx402NxvLJP4=;
 b=N3K4QBSeaIzELlGCP73eScD3GFoxAlmS7KSaRavKdCi6zCoRWmEZG1k5OktApO+AER
 s4HiAiNFsQOhKFa7QCe+o2M9lnk7W+2+OKlW1NKrZAAB0ip8MOcLA9Q3FCZ3u9hKT94b
 M2P/NzjRKnbGrmeNFKF6d4/YdBaJpaZp2AR/c/ViKZmdxTCon6yYmJ4Lgq7Ps9q7W8JF
 52CqBCTqwdYpEc02LHpsPRqQbk6xW5KhB89xyaYvolMfHX6cd07jepRhtgUmVMlDE++C
 WIsn3HxtlajCHqZuaywMrSJujEba6vUQFgDs7VpxATuC3TND8B9kIqY9+/K3nVj8qdFR
 Nz+w==
X-Gm-Message-State: AOJu0YwhRUT4HopywIeTOeXf0M9M7K7fuEWRLcatBYuf27GAw6TEZ626
 fUC8bADEbvPw0mFQX+MuYfHI+HbC+tG4v0Wxrvu9SxCaiGuR2xIVJDze
X-Gm-Gg: AZuq6aKRKLjMOCMROm+mbVyUs55ieqcbgK9hNIRf51TJ55FXNvFl7CX37iFU3HBhI8H
 s8lr68PMLqiQG1bOrIhdCXzoUdmB8RqAnkdjoKrJ5eaEEOM+jLfDi3KSpI6aIUFmddL1N9ClQhu
 rytx2sdBoczBdiAnzjYUTYq8rhu7zNckhuTrPCcAyhHfOcCgPqkLW2/C5FEivXtarsG1c9rlQsI
 XgvfV03L4sevPMGlDko+WTub3nZNdnKCcKZikk9t+DQjJwX9pn/x+fVRrLcnwX8O1iZl0nZ6uw4
 KpVI52JvTWOfu5PeM7nrns26DmOBMCzgHIsUhSrWMxrEY+2AjhcV7r/wBLvclibMCa/6tfWKGAC
 bc93N0YTIoWBp7g2qr6yU3DBTMhhpzYzqCNE9xNuUmdNU6Cu0uQ9BhK5IW4XYNHRRl4z9vxt8X2
 onTvPbkoy6hcTCqPJpDYbRA30sMyqrNl5ZN/KxTs6d2ft39ZS3UGwwaC12FA==
X-Received: by 2002:a17:90b:4d0c:b0:34f:6312:f225 with SMTP id
 98e67ed59e1d1-352678f31eamr14658510a91.14.1768897461261; 
 Tue, 20 Jan 2026 00:24:21 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274573a7esm4273592a91.11.2026.01.20.00.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:24:20 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [RFC PATCH v2 1/7] target/riscv: deprecate 'debug' CPU property
Date: Tue, 20 Jan 2026 16:23:57 +0800
Message-ID: <65b52195193a368dce4315e2194402a5aee55e01.1768892407.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.

We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
all of a sudden the existence of this flag is now weird. Do we keep it
as a 'sdtrig' only or do we add 'sdext'?

The solution proposed here is to deprecate it. The flag was introduced a
long time ago as a way to encapsulate support for all debug related
CSRs.  Today we have specific debug trigger extensions and there's no
more use for a generic 'debug' flag. Users should be encouraged to
enable/disable extensions directly instead of using "made-up" flags that
exists only in a QEMU context.

The following changes are made:

- 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
  cpu->cfg;
- All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
- Two explicit getters and setters for the 'debug' property were added.
  The property will simply get/set ext_sdtrig;
- vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
  will impact migration between QEMU 10.2 to newer versions, but we're
  still in a point where the migration break cost isn't big enough to
  justify adding migration compatibility scaffolding.

Finally, deprecated.rst was updated to deprecate 'debug' and encourage
users to use 'ext_sdtrig' instead.

[1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/about/deprecated.rst         |  7 +++++
 target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88efa3aa80..420bff8d0d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -478,6 +478,13 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+``debug=true|false`` on RISC-V CPUs (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
+extension. Users are advised to enable/disable ``sdtrig`` directly instead
+of using ``debug``.
+
 Backwards compatibility
 -----------------------
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c2a9da0fe8..f1b977f0ee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -211,7 +211,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -790,7 +790,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -953,7 +953,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1132,6 +1132,14 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    /*
+     * 'debug' started being deprecated in 11.0, been just a proxy
+     * to set ext_sdtrig ever since. It has been enabled by default
+     * for a long time though, so we're stuck with setting set 'strig'
+     * by default too. At least for now ...
+     */
+    cpu->cfg.ext_sdtrig = true;
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
@@ -1246,6 +1254,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
     MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
@@ -2682,8 +2691,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static void prop_debug_set(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+    cpu->cfg.ext_sdtrig = value;
+}
+
+/*
+ * DEPRECATED_11.0: just a proxy for ext_sdtrig.
+ */
+static const PropertyInfo prop_debug = {
+    .type = "bool",
+    .description = "DEPRECATED: use 'sdtrig' instead.",
+    .get = prop_debug_get,
+    .set = prop_debug_set,
+};
+
 static const Property riscv_cpu_properties[] = {
-    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    {.name = "debug", .info = &prop_debug},
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 353a932c36..a8c133d663 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
 BOOL_FIELD(ext_smcdeleg)
@@ -159,7 +160,6 @@ BOOL_FIELD(ext_xmipslsp)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
-BOOL_FIELD(debug)
 BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 05c7ec8352..870fad87ac 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -777,7 +777,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a879..62c51c8033 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
 };
 #endif
 
-static bool debug_needed(void *opaque)
+static bool sdtrig_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdtrig;
 }
 
-static int debug_post_load(void *opaque, int version_id)
+static int sdtrig_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
@@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_debug = {
-    .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .needed = debug_needed,
-    .post_load = debug_post_load,
+static const VMStateDescription vmstate_sdtrig = {
+    .name = "cpu/sdtrig",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
@@ -425,8 +425,8 @@ static const VMStateDescription vmstate_sstc = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 11,
-    .minimum_version_id = 11,
+    .version_id = 12,
+    .minimum_version_id = 12,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
@@ -492,13 +492,13 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_kvmtimer,
 #endif
         &vmstate_envcfg,
-        &vmstate_debug,
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
         &vmstate_ssp,
         &vmstate_ctr,
         &vmstate_sstc,
+        &vmstate_sdtrig,
         NULL
     }
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c095bc9efd..1343f21d08 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.52.0


