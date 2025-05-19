Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A3FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs40-0001gk-QJ; Mon, 19 May 2025 00:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrof-00086g-T4; Mon, 19 May 2025 00:09:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrob-0004L9-65; Mon, 19 May 2025 00:09:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-231e011edfaso27285275ad.0; 
 Sun, 18 May 2025 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627763; x=1748232563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WDtzA+XYDp39rtlfgqOtch6IxjNnqHxzQ6CqndLUpE=;
 b=bO53fVi+A8PKnNibLwZT/ezn5dzNNLfagAOQjbia/4H86Qc2w+BzXa1FnNnzBhdkYd
 Ej3oJgSVRZCJb5UA4e7bpiw/nbRy841jjwaAMj4mX3sLJ9LRi8u3DvyxElLWgWz64jVn
 P1skrd7JfX/Q4IgEnPPUbSnxSfPoJ8vEEXiIhN0ZB2m/ePI97SuONH3g4ptLtFgi+nce
 tKmBPMPgdREfnpozLeOxsIArzUyI9ObIn5lQP1ZC6kmLFbkjbpzuSHEm44S1xei2k86I
 RFdbbp1kQXInto9j4ke/R/N0EoqWdLJTJ85XXZgDBquHn46AUm1V/UipQWQYOVoQL1pN
 uemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627763; x=1748232563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WDtzA+XYDp39rtlfgqOtch6IxjNnqHxzQ6CqndLUpE=;
 b=wO02lzuyhara22H/S0M5yHTSGr9d9xmHTAIi+k3/sYJ9RNGEj1ftvzgE+dlnlkNd+6
 bhAMqwHDjakeBLUH3f/Xx4CZHUS/OSgj7/UPMhtIoW/doggtFgRN0nc7cW7iAX+YGyba
 uYvi2kVvo/kuUB31RCezkCpB5v4jDG9FPzKHtXscyVl0HheoYN5MFrEJ9Go/aPOHUTUI
 knFs8vF+UJWsKs9zQtEPuua81tJQRpZ3rjWIqhmbtYeid6JrSE3U9ythLi1CE0tA/uKh
 nDGUGXnOMNIhinUQ0WQ8rvF9TefF1M/B3RhQtz/IFZLUFnj1yKPmeI6epgAyJO4XpX+b
 yv/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtEKA6se0m9lyhC41MQxAu1yOCcoyS8jzxZacBfd0iw4Ej83Wo9/YZU9hn3OnjJUdYEcnKF4ukzuUNag==@nongnu.org
X-Gm-Message-State: AOJu0YyKs7qhN5YRLCDso5zBtlIbkyNCs0NlUX+DN9ylPK0ydOeKP9PB
 cKXdSBK1fWDJVm8Hj1Ibec2Ij7B2T1LhfzA32ENBAq2S05/CqezU8jlgnLCURw==
X-Gm-Gg: ASbGncuuaPaTNrkzDtFznFy7pUyJhCuC9jOM4DSESCCR/6Yz+98l8bQNgo/I2506TbI
 kq6vvFR8hrK8yTAy6g9oryNvpvQ7SpKXSpbbXRBEreQKTw3MauvicUf6so6Q4VLqIobHaJLOQFJ
 3Zs26TMid8fRTXK8PzSvQBP//972/5nYN8k3ZAgZTC1TM+9LWX8Z3+zdmqyGCG/AzJbeD34Tmi2
 p+5d8IUz1GtLXdunsqYkWOQzPSfNVCiRd5poqRXlT53RkBwBeWBoQhuFYCYnXVO3aOj8TOpnHd+
 8iSgFDHmlyAJPODODqyFa67FmAuLAHJIKCs6acPjh9r8yWrWw5V3DkqoPddB/CirmndPrKmFqUT
 eIQdox4BAagAvvw4Ox0Bm6KgAprJHDd/aTpBSHTfhB3T1rH0T8OyJ+2PT
X-Google-Smtp-Source: AGHT+IGgOP99SfoMAM81E+kaGQOievJcI9ZjVtPflRN5SBcJtTx//iP4A7BfjJZdSp9lNIDPHXIVMw==
X-Received: by 2002:a17:903:3304:b0:231:e05c:8aa2 with SMTP id
 d9443c01a7336-231e05c8b8bmr94358675ad.30.1747627762736; 
 Sun, 18 May 2025 21:09:22 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 42/56] target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a
 macro
Date: Mon, 19 May 2025 14:05:39 +1000
Message-ID: <20250519040555.3797167-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We need the reg_id_ulong() helper to be a macro to be able to create a
static array of KVMCPUConfig that will hold CSR information.

Despite the amount of changes all of them are tedious/trivial:

- replace instances of "kvm_riscv_reg_id_ulong" with
  "KVM_RISCV_REG_ID_ULONG";

- RISCV_CORE_REG(), RISCV_CSR_REG(), RISCV_CONFIG_REG() and
  RISCV_VECTOR_CSR_REG() only receives one 'name' arg. Remove unneeded
  'env' variables when applicable.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/kvm/kvm-cpu.c | 99 ++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b037cb2781..509c875a19 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -64,23 +64,11 @@ static bool cap_has_mp_state;
 #define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
                                          type | idx)
 
-static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
-                                 uint64_t idx)
-{
-    uint64_t id = KVM_REG_RISCV | type | idx;
-
-    switch (riscv_cpu_mxl(env)) {
-    case MXL_RV32:
-        id |= KVM_REG_SIZE_U32;
-        break;
-    case MXL_RV64:
-        id |= KVM_REG_SIZE_U64;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return id;
-}
+#if defined(TARGET_RISCV64)
+#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U64(type, idx)
+#else
+#define KVM_RISCV_REG_ID_ULONG(type, idx) KVM_RISCV_REG_ID_U32(type, idx)
+#endif
 
 static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
 {
@@ -103,16 +91,16 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     return kvm_encode_reg_size_id(id, size_b);
 }
 
-#define RISCV_CORE_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
+#define RISCV_CORE_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
 
-#define RISCV_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
+#define RISCV_CSR_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CSR, \
                            KVM_REG_RISCV_CSR_REG(name))
 
-#define RISCV_CONFIG_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
+#define RISCV_CONFIG_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG, \
                            KVM_REG_RISCV_CONFIG_REG(name))
 
 #define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
@@ -122,13 +110,13 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
-#define RISCV_VECTOR_CSR_REG(env, name) \
-    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
+#define RISCV_VECTOR_CSR_REG(name) \
+    KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -136,7 +124,7 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 
 #define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
     do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
+        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
         if (_ret) { \
             return _ret; \
         } \
@@ -244,7 +232,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
         /* If we're here we're going to disable the MISA bit */
         reg = 0;
-        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                     misa_cfg->kvm_reg_id);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
@@ -430,7 +418,6 @@ static KVMCPUConfig kvm_sbi_dbcn = {
 
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
-    CPURISCVState *env = &cpu->env;
     uint64_t id, reg;
     int i, ret;
 
@@ -441,7 +428,7 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
             continue;
         }
 
-        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                     multi_ext_cfg->kvm_reg_id);
         reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
         ret = kvm_set_one_reg(cs, id, &reg);
@@ -566,14 +553,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     target_ulong reg;
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
-    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
     if (ret) {
         return ret;
     }
     env->pc = reg;
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
         if (ret) {
             return ret;
@@ -592,13 +579,13 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     CPURISCVState *env = &RISCV_CPU(cs)->env;
 
     reg = env->pc;
-    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(env, regs.pc), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
     if (ret) {
         return ret;
     }
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret) {
@@ -796,26 +783,26 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
         return 0;
     }
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
     if (ret) {
         return ret;
     }
     env->vstart = reg;
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
     if (ret) {
         return ret;
     }
     env->vl = reg;
 
-    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
     if (ret) {
         return ret;
     }
     env->vtype = reg;
 
     if (kvm_v_vlenb.supported) {
-        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
             return ret;
         }
@@ -853,26 +840,26 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     }
 
     reg = env->vstart;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vstart), &reg);
     if (ret) {
         return ret;
     }
 
     reg = env->vl;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vl), &reg);
     if (ret) {
         return ret;
     }
 
     reg = env->vtype;
-    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vtype), &reg);
     if (ret) {
         return ret;
     }
 
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
-        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
 
         for (int i = 0; i < 32; i++) {
             /*
@@ -951,25 +938,24 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
 
 static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
-    CPURISCVState *env = &cpu->env;
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = RISCV_CONFIG_REG(env, mvendorid);
+    reg.id = RISCV_CONFIG_REG(mvendorid);
     reg.addr = (uint64_t)&cpu->cfg.mvendorid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
 
-    reg.id = RISCV_CONFIG_REG(env, marchid);
+    reg.id = RISCV_CONFIG_REG(marchid);
     reg.addr = (uint64_t)&cpu->cfg.marchid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve marchid from host, error %d", ret);
     }
 
-    reg.id = RISCV_CONFIG_REG(env, mimpid);
+    reg.id = RISCV_CONFIG_REG(mimpid);
     reg.addr = (uint64_t)&cpu->cfg.mimpid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
@@ -984,7 +970,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = RISCV_CONFIG_REG(env, isa);
+    reg.id = RISCV_CONFIG_REG(isa);
     reg.addr = (uint64_t)&env->misa_ext_mask;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
 
@@ -1001,11 +987,10 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
 static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
                                          KVMCPUConfig *cbomz_cfg)
 {
-    CPURISCVState *env = &cpu->env;
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+    reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                     cbomz_cfg->kvm_reg_id);
     reg.addr = (uint64_t)kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
@@ -1019,7 +1004,6 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
                                            KVMScratchCPU *kvmcpu)
 {
-    CPURISCVState *env = &cpu->env;
     uint64_t val;
     int i, ret;
 
@@ -1027,7 +1011,7 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
         struct kvm_one_reg reg;
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                         multi_ext_cfg->kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
@@ -1159,7 +1143,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         multi_ext_cfg = &kvm_multi_ext_cfgs[i];
-        reg_id = kvm_riscv_reg_id_ulong(&cpu->env, KVM_REG_RISCV_ISA_EXT,
+        reg_id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_ISA_EXT,
                                         multi_ext_cfg->kvm_reg_id);
         reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
                              sizeof(uint64_t), uint64_cmp);
@@ -1338,12 +1322,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
 
 static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
 {
-    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     uint64_t id;
     int ret;
 
-    id = RISCV_CONFIG_REG(env, mvendorid);
+    id = RISCV_CONFIG_REG(mvendorid);
     /*
      * cfg.mvendorid is an uint32 but a target_ulong will
      * be written. Assign it to a target_ulong var to avoid
@@ -1355,13 +1338,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
         return ret;
     }
 
-    id = RISCV_CONFIG_REG(env, marchid);
+    id = RISCV_CONFIG_REG(marchid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
     if (ret != 0) {
         return ret;
     }
 
-    id = RISCV_CONFIG_REG(env, mimpid);
+    id = RISCV_CONFIG_REG(mimpid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
 
     return ret;
@@ -1911,7 +1894,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     if (cpu->cfg.ext_zicbom &&
         riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cbom_blocksize.kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
@@ -1930,7 +1913,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     if (cpu->cfg.ext_zicboz &&
         riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
 
-        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+        reg.id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
                                         kvm_cboz_blocksize.kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
-- 
2.49.0


