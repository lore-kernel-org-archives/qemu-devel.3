Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07286C98313
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxud-0000rm-Vy; Fri, 16 Jan 2026 23:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuc-0000qp-Rt
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:46 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxua-0001aU-ML
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:46 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so1709641a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624063; x=1769228863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3scFTotGQKKGR4zphWZAnM7rgTHv1T/LJMyzHvS7PM=;
 b=aU+ivg6hK/SPoafCMY9ivx0Xn1UNcOPhXAMnJfFltxVQHdbfjyCrO3jNayNKvdoii8
 z39fV0njxkGV2ggYlfTN8ARgZdlsN9H0UdKexnIQTNbt7p6edB4JdAdMdFc4ef7/K3Hi
 w/wNK88EOCgo7PjKRqTaYEY9+N3OyPZGmWA8e4lqkiyImxQoN7EAgM/pSO1mfsREI77Y
 33SqQl/MgLKBxDDUAVjlMjzJJd1Rt1HFIM/ur2sazLCdzIckvowy7IfoTyQP5tvVQdvv
 ol4LBTRr4oEX9HeX0AtkFp0AtB18EhP4sIiP6OXIrw8pajYiP6BXCimWg5xoselSrPkT
 3TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624063; x=1769228863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3scFTotGQKKGR4zphWZAnM7rgTHv1T/LJMyzHvS7PM=;
 b=fY4DGMCqcYov6vBKlZm8olww9VYhYD/0DsTvl8+fzvZIDx1bi7Aw1YerkR6PTIUCF3
 v5d+rlutqRUjDor5sxkrAFjONIWCyl+jaL1pAVEoPF+bCHYX4D+ifSETFd8kUsPwt02X
 0RLYR8iskZFt04/ujmTNaSwRFqLTJ1/PVA3/ASZ32CKU5CH9LRSZAkXCqAaNeLXsfVDx
 A7WM8sUq0uQYsea0JSiOI8cp50OZrqcjlQ5lkl2M0GlGFcKc3RLThnU6cFr4WymuX0bz
 +Tymu/ySa0aKhxPEvqWWuEwc7pCz1qLIESkcX1N2tDdb5a2nU9TqVC5tKW3Tu6VBKYMS
 6O5w==
X-Gm-Message-State: AOJu0Yyt1C068U5cK4omr5YdEA/q1h+bP17m4KODDNF1ZqI/qiC3amrD
 FEw/bmnrCQjdzUswA8tp1jQDqAhXvc2VzH7wqptRDg5idWnq+X3OHc2y
X-Gm-Gg: AY/fxX7BHhraC+Nm2efI3Sstl+1/+QZDZHMVxJ35doYme2vGRE43sz9P0RkGx4unNaF
 iWRZfkUDcJN9zW0SVuZFHNz3DDPurVtxzMSKTeJFWZ+URJ4Dk353WlzD0px0FMpnVTTdfRefI2k
 dj5vE/+j6D92t5olbnILWbnH4od7KZTyxSompS7rQ2ETaEoR6FtFxiKBbCGTOgBB2C+RPtkUtf7
 NfXjNnx59K945z76s8c+KKBQMiokGscnqF0sTYXk0agajozuwPBV/8AtmJEaKmag7U4foFqk0zB
 BY4Cnek/ev4+uDuFv3NjW+xeiy+ks2r5PzOEwUP3P61ozsTF0yP3nD3jKTFKahlz4dJT2sXo/MK
 00ZsRiFdSVcmd8ZE4TuLPlfUb2BWrY23WRshVlBoXqMY4PLPvNpHUz8w1w+IkMG/RsZx5Yu1u9D
 cLTK1zX4iHcf1OCmUDJG1kSh+vRnGaKZYaC1a2L72MVSli8J2Z/gB7ZI8UQFhOvQ==
X-Received: by 2002:a05:6a21:68c:b0:366:14ac:e1f3 with SMTP id
 adf61e73a8af0-38dfe945128mr6190008637.69.1768624063066; 
 Fri, 16 Jan 2026 20:27:43 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:42 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 2/8] riscv: add sdext debug CSRs state
Date: Sat, 17 Jan 2026 12:27:23 +0800
Message-ID: <b08647264f77e5beabc90d29673941fb372dbe39.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Also migrate the new state in vmstate_debug.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c      |   5 ++
 target/riscv/cpu.h      |   4 ++
 target/riscv/cpu_bits.h |  33 ++++++++++
 target/riscv/csr.c      | 133 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/machine.c  |   8 ++-
 5 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bc0b385cc1..d7c0f255a8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -782,6 +782,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* Default NaN value: sign bit clear, frac msb set */
     set_float_default_nan_pattern(0b01000000, &env->fp_status);
     env->vill = true;
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.ext_sdtrig) {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..18ebac830a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -482,6 +482,10 @@ struct CPUArchState {
 
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
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4f071b1db2..4a732b9364 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3171,6 +3171,131 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_sdext_available(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdext;
+}
+
+static RISCVException dcsr_predicate(CPURISCVState *env, int csrno)
+{
+    if (!riscv_sdext_available(env)) {
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
@@ -6314,6 +6439,14 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA3]    =  { "tdata3",   sdtrig, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    sdtrig, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", sdtrig, read_mcontext, write_mcontext },
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr", dcsr_predicate, read_dcsr, write_dcsr },
+    [CSR_DPC]       =  { "dpc", dcsr_predicate, read_dpc, write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", dcsr_predicate,
+                         read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", dcsr_predicate,
+                         read_dscratch, write_dscratch },
+#endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d6a0b8e357..c6fe2d8541 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -239,8 +239,8 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
@@ -248,6 +248,10 @@ static const VMStateDescription vmstate_debug = {
         VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.52.0


