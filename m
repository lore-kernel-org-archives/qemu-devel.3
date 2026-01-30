Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3339ED73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhZF-0004Q8-9E; Fri, 30 Jan 2026 01:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZA-0004Mf-IO
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:14 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZ8-0000mL-F0
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:12 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c46d68f2b4eso995633a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752869; x=1770357669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3Ehf8gpRirSwWFvC1evxvNlbaGlS0CFlL5MsKC3Hrg=;
 b=jtqzbeK4RnHtReoa0OBYSsutZqMN2e1bFQsUxGPHnOAG+PUvJaQeswKmHlgO4xezq8
 FDDc8guGK/25dkESOrkvBKK9fupuYJ2cvPcNBA8I4fWQJRfT1IkHT/Z9roiTm7LdD6sU
 MB1Ez2kfNGZr80MkYFC0yhk4FnswuMw94pUaKSliugCDqWCSWuLLXpN2m2QUIo1OrqFb
 MB25CCXiwnC4np6+tVAaY8QjxTZtcsP36MyzOGS6F5akshrViaidYce0iooa4Lew+jay
 3LYwU2kFsJHw+6Jvg0MCHscgiykgy/em8iBRjhhTLvS1xtLRAyeSa9crzUSs/dt30ouZ
 +K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752869; x=1770357669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3Ehf8gpRirSwWFvC1evxvNlbaGlS0CFlL5MsKC3Hrg=;
 b=hweoaDZlLDqix5zc/56jdaYzkB0P5UvXjhgMVVKp7GnOW5JHzdUZopifCFwpugHiTX
 oj8cPf+9uoIGe6kT/9LWJNGFiQlIne60jvPHMkmBA+L404KtRbpXSsm8rgc/zkStfDi8
 ALtZmAJveCTiQb8fCY+dS6ik5yk8qKJ7SM4AyyREoqnZT7wEGwrIAxTj7G9UNiMJj0lO
 sUv/1POAm6c0VUBcfapTXKDalW06wx2EfKzbs88lJxQg811pYB4NfBRouzxahVHk51uF
 hwGZSCzL7dJqNrUzz1jjhBnG31AaKazf+47i+eDHMKX8iWTBiZfGOArhNg+A1X+qEJzc
 vzlA==
X-Gm-Message-State: AOJu0YyUUyNl8c7i6A78xEAtY/unQEj9FW5C1QXiZA+HXX3Z7EXFRNMK
 JWs5VapIXPlI1vEpsDsm+2Xdg3OdW2biiH/VFNedZbl/Sjp3aJha2LWY
X-Gm-Gg: AZuq6aLGW/+/k2tv/lR5BRHwEHchx1qin3VuxfY9HoRcW766IDDqJfmyuRSCgXj+ukL
 Ws9Mtzn7r/yyOcW+rdA75/AtP68D3CPII4vCsCRhLWOushjt/3iVRF0KsR9MbU/ALmLoSBOusd7
 PvRPikKkYP7hvEG/Z1hkkIdmwT6oQjgUkMrLnin88hYbCDSXEU91Dcs4gkVeLleOl8QlyUtYw72
 Sa2ZI9AjQYBMgp806ij+J2kgv+Bz+OxdIh7br9TgqbT4TpSHA+9CY6c3SaEshgD367atAWncIF3
 zPGETnR5TVeZNrRjnZmhAY1y8CHALnx7K4vRYtcOD7yvJvfQ+Q0oYjueME8RP4kyFwerEFwI53G
 Kmo9QgGCjesLeLrGNyiK785LmJLIQ5wGZFUr2Pgl5ge3Qe1wDfywx5L1Bb9UW5zzF8tsV9ClrHq
 Sv6P30VUEozdQdW8gCVG4AmffgB+dJHe2XCUxzbNJkaDlQ8TcjJOA1o6Ha97Y=
X-Received: by 2002:a17:903:3b83:b0:2a7:757b:35ad with SMTP id
 d9443c01a7336-2a8d9937cd4mr16579915ad.42.1769752868981; 
 Thu, 29 Jan 2026 22:01:08 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm66274585ad.2.2026.01.29.22.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 22:01:08 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v4 2/7] target/riscv: add sdext debug CSRs state
Date: Fri, 30 Jan 2026 14:00:01 +0800
Message-ID: <6cbae2d3248275c050942c196f6b6e16d1ad4eee.1769751489.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x543.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
them to Debug Mode (or host debugger access).

The Sdext is not fully implemented, so it is disabled by default.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c                |  11 +++
 target/riscv/cpu.h                |   4 +
 target/riscv/cpu_bits.h           |  33 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
 target/riscv/machine.c            |  20 +++++
 6 files changed, 195 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fa4e09f17..9b08ef9fb0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -210,6 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -782,6 +783,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
+
     if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
@@ -1132,6 +1139,9 @@ static void riscv_cpu_init(Object *obj)
      */
     cpu->cfg.ext_sdtrig = true;
 
+    /* sdext is not fully implemented, so it is disabled by default. */
+    cpu->cfg.ext_sdext = false;
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
@@ -1246,6 +1256,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("sdext", ext_sdext, false),
     MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
     MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53..2a265faae5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -476,6 +476,10 @@ struct CPUArchState {
 
     /* True if in debugger mode.  */
     bool debugger;
+    bool debug_mode;
+    target_ulong dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..bb59f7ff56 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,39 @@
 #define CSR_DCSR            0x7b0
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
+#define CSR_DSCRATCH1       0x7b3
+
+/* DCSR fields */
+#define DCSR_XDEBUGVER_SHIFT    28
+#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_EXTCAUSE_SHIFT     24
+#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
+#define DCSR_CETRIG             BIT(19)
+#define DCSR_PELP               BIT(18)
+#define DCSR_EBREAKVS           BIT(17)
+#define DCSR_EBREAKVU           BIT(16)
+#define DCSR_EBREAKM            BIT(15)
+#define DCSR_EBREAKS            BIT(13)
+#define DCSR_EBREAKU            BIT(12)
+#define DCSR_STEPIE             BIT(11)
+#define DCSR_STOPCOUNT          BIT(10)
+#define DCSR_STOPTIME           BIT(9)
+#define DCSR_CAUSE_SHIFT        6
+#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
+#define DCSR_V                  BIT(5)
+#define DCSR_MPRVEN             BIT(4)
+#define DCSR_NMIP               BIT(3)
+#define DCSR_STEP               BIT(2)
+#define DCSR_PRV_MASK           0x3u
+
+#define DCSR_CAUSE_EBREAK       1
+#define DCSR_CAUSE_TRIGGER      2
+#define DCSR_CAUSE_HALTREQ      3
+#define DCSR_CAUSE_STEP         4
+#define DCSR_CAUSE_RESET        5
+#define DCSR_CAUSE_GROUP        6
+#define DCSR_CAUSE_OTHER        7
 
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 1e9162281f..e0d70fe8c7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 870fad87ac..3e38c943e0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (!env->debug_mode && !env->debugger) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_visible_mask(CPURISCVState *env)
+{
+    target_ulong mask = (target_ulong)-1;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!riscv_has_ext(env, RVH)) {
+        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
+    }
+    if (!riscv_has_ext(env, RVS)) {
+        mask &= ~DCSR_EBREAKS;
+    }
+    if (!riscv_has_ext(env, RVU)) {
+        mask &= ~DCSR_EBREAKU;
+    }
+    if (!cpu->cfg.ext_zicfilp) {
+        mask &= ~DCSR_PELP;
+    }
+    if (!cpu->cfg.ext_smdbltrp) {
+        mask &= ~DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException read_dcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = env->dcsr & dcsr_visible_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_writable_mask(CPURISCVState *env)
+{
+    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
+                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
+                        DCSR_STEP | DCSR_PRV_MASK;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    mask |= DCSR_MPRVEN;
+
+    if (riscv_has_ext(env, RVH)) {
+        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
+    }
+    if (riscv_has_ext(env, RVS)) {
+        mask |= DCSR_EBREAKS;
+    }
+    if (riscv_has_ext(env, RVU)) {
+        mask |= DCSR_EBREAKU;
+    }
+    if (cpu->cfg.ext_zicfilp) {
+        mask |= DCSR_PELP;
+    }
+    if (cpu->cfg.ext_smdbltrp) {
+        mask |= DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException write_dcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    target_ulong mask = dcsr_writable_mask(env);
+    target_ulong new_val = env->dcsr;
+
+    new_val &= ~mask;
+    new_val |= val & mask;
+    new_val &= ~DCSR_XDEBUGVER_MASK;
+    new_val |= DCSR_DEBUGVER(4);
+    env->dcsr = new_val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dpc(CPURISCVState *env, int csrno,
+                               target_ulong *val)
+{
+    *val = env->dpc & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dpc(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
+{
+    env->dpc = val & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dscratch(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    *val = env->dscratch[index];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dscratch(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    env->dscratch[index] = val;
+    return RISCV_EXCP_NONE;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 /* Execution environment configuration setup */
 static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
                                    target_ulong *val)
@@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
+#endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 62c51c8033..52264cf047 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_sdtrig,
+        &vmstate_sdext,
         NULL
     }
 };
-- 
2.52.0


