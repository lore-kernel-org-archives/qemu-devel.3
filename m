Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390F1F3ED4A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkRn-0004B8-UW; Sat, 11 Apr 2026 22:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRl-0004Ae-KU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:13 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRj-0008FP-M6
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:13 -0400
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8a1e1817db6so28502546d6.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960471; x=1776565271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4TyZefY9NFwD1+f8ide9sGoKm39GlSzIyT0VGj0ISI=;
 b=tGR+cNuiqwInExOc6KWoKPguozWozJB3pO6TsIkkq6ztHyoQUpH+13E9pQmxrFzCd1
 usPBr2Ou5fvvwFL+wENqbiq0SrPCPcUdqvC2za+N7SMFpaIQlETbClh/oRXfe42JpIun
 n0nuCmUJllypww8NcdM9RB7s88uoV/TFoxLiHLXGCV+1ZyNW1gEVJikmxo6mQvWsiL3C
 EAx8ofw6CjUDDjF/uoYBUKZmwcACNZMQZDg7wGPjI6wHmW5NbV2kFFiMEtTsdGryu+le
 4ekB/WGP9g7WTpCQSvkbC3xm14tXwQItwAI59sSbDQD/8mEvauDm7o7CFSKbVSVmYdUg
 dOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960471; x=1776565271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r4TyZefY9NFwD1+f8ide9sGoKm39GlSzIyT0VGj0ISI=;
 b=HreLh32IWRt7MS6EekHZWWaMp+7qAK6BkDzqE8rxT+Oq0v+9+xE9Dv59KPkJqfWg9H
 iLSEPcana7ds7cCGqkQHTTHZ1x/aRCeibyAtN42C0lJyXaCwFNjOvxrOEs+KbQ2AbfRx
 XlzSjTT7fFI7E8M/DiiyRV3MKEIxsPJW8I/Ip+ld+hMbjxcFiWlKeuf1C0PI8R0Hqimq
 Kl0B4q+pGsEd7NEMBHugOHX+FDUSfRYcpz6bonPlzr7sP3yUefkOv+zUpCSszJSzZ98n
 8WW2T/hs9eZf8fga9EXPJ5myzov5fUzKLbDodeR5nC8nFsXYfGwN3SpibMn7bAv8ljCj
 B80g==
X-Gm-Message-State: AOJu0YzAnANg6cwz7arB7od6KSkUaHo48iZ205RcbI+R55zwV9LqDVPL
 lmeYkfLKgjPe/6UcaUgr54CtGpZbQmnMnMpWY72YNmhyxGjY4l7X0ITciSjWFDOHKQKdJioy
X-Gm-Gg: AeBDieucV965Skbc5SwSRWGEdD8u7iaTIZxHOQTvDhuTFGNxJ5ZL3CINdvCfmpqC9+O
 8lLUjFCOOREcR/pJA7RTCUmqaEO6MIym9Ps9szGG11L3shR+kFIJIOiOTQhhplhEXzIv0an3eoI
 2BXqx0BlwsnuijeZb46QMiPsdzgd/HpVc+6NwaiTjwkZ2iyjp8+5CqEydxWDvJPeE+9mvqf+Uyc
 LffFLApjCRzHJTm8oa+ZNSWkzWn/+TJPDw11a2pwVywLJM9v5+djxk5uzKa75+8UdiW1uTJsGje
 dj/beM6N3TkdIL51/d72LnHuYM0dx0gMG0QkYf7yqgB6rH/dKQjgk7YdfqZslUvk4S98BMF7/XI
 mjc1JW0sv2pHZ4GruczjcdfATZtsHvBSIsPkIAuswiSNxnN8glsu17HWCsJagqaf4dF9vKlRRYl
 H5AMnuI3+Z/3D0Jy0CqSbvh3xb5SdGpWDlRbcTZ+FxWJLP5RFEdm0FOAE0ccAuaavm5fJNW6dvn
 w7K3lc=
X-Received: by 2002:ad4:4ea7:0:b0:89c:9fa2:5de9 with SMTP id
 6a1803df08f44-8ac862a63dbmr150577846d6.36.1775960470682; 
 Sat, 11 Apr 2026 19:21:10 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:10 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 1/7] target/riscv: deprecate 'debug' CPU property
Date: Sun, 12 Apr 2026 10:20:18 +0800
Message-ID: <99f0437cbb0169ffa318af4864ee48af22abeb17.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf43.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 docs/about/deprecated.rst         |  7 +++++
 target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6d6a71326..cba050334b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -452,6 +452,13 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
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
index 38286b6b40..6208201538 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -210,7 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -783,7 +783,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -947,7 +947,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1126,6 +1126,14 @@ static void riscv_cpu_init(Object *obj)
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
@@ -1240,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
     MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
@@ -2654,8 +2663,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
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
index 734fa079f2..44235bfaa1 100644
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
@@ -159,7 +160,6 @@ BOOL_FIELD(ext_xlrbr)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
-BOOL_FIELD(debug)
 BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cfd076b368..93b4864933 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -776,7 +776,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
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
index f3f7808895..0613450691 100644
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
2.53.0


