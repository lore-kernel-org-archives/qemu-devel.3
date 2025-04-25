Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1948CC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HNL-0001Cw-BY; Fri, 25 Apr 2025 07:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNH-0001Bb-W3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNA-0006Wg-E9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2264aefc45dso33989085ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581051; x=1746185851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5neQGzLPcsmIj+eh2EIpFmSDwCQhG6xSq9AiQ9ifoDM=;
 b=kYaacMHDvK0JfDSwft12zqklR43i1lbXTpEOTIE8Nhg/96FiJrnBEMJ44AQN2M1EXF
 ju56R3DuyOt24dZBXzHVBC5gzD9QkZNjnc/52m5cTRTH6HUXmL6cTLXy79CzwjwZRfSl
 mjhaKWEbfDHcm6vvclxHM4M0jrO9Fg5WDm0QBK2SaUco/GUTa/f1W4j3Cmzfm64PcZQT
 E+lrZ8rBT5NvlpZCi4R7HLnJ5WGZaRyqjTI0805MzIwF2mrvcMVgs9tKHQtGyi7hmE+x
 SN0aaLx4H9ZA49OVW6RDk72E5PUPs+1/2Pjfc6v+xJQNhHh1CFNZGHxdABrW1VYYSLAw
 m8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581051; x=1746185851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5neQGzLPcsmIj+eh2EIpFmSDwCQhG6xSq9AiQ9ifoDM=;
 b=js89Zce51UkNmdZVhyDjUaNk6eHBiJEno9A6NMm+8GzqisxbIPDqQ6XOh9gAvTDnyY
 dPS+aqxcmoqaY3UN1FUI+nzl2SDFhDJP/vcgb+Dh/VLkMYvn0GdcH1diPZwXgx6GR0iw
 vv2+g2LMgHwuhFEcGpkH7SUUB5S+YjA1B4u7pTeujOKV5uweOauiAjP3gIeblVjG6GLu
 6+F4EJkLgGEnyUAtyPgJ8n8IZbUDE+LSxNqRxisiqTke1i4xvGkYjq+zrkGhTA9yOpNz
 7avtpcuSEVzb5rXpbf+HEUMuuJr8rqLf3XgfueDzKhUD/6UpTPI2DbkBwRhoST5X+lhV
 ezBg==
X-Gm-Message-State: AOJu0YxO6rzkIWP+JbeWCqSJlniSAQM+9wnCjJgCXtNkYd+bjkZzlYRC
 S8TjfuY98ofRsRAkRaKQBWapN3JZi53+h2NksTTTr0htbj1zYHtgLAozZDJIl2Wn9gRPt5KMuxe
 +
X-Gm-Gg: ASbGncsYK7UYF3nmZL0H3BP00HFdcXU6u8UjNTt3kvv/I7Xh8Sh3yVHCgk+AtdGetJm
 FjpRTS/v87iNEDowiqCA7ckOvQ/uEMLmNY/MjTd8GR58wWDqzspqq8tiYxL1r22hMNzp1mLaEIW
 uAjMEqhR4ZpYfU1kwHnQOtf9pliuVJWPe3FCaY4qsmI2z4PvuVduqbwggkArXgtSG7EAjmXAZgJ
 RXWGrWH7NnD3U/PJoW1JDq8xS2v7S0l5uCqP47CXS92Wqy7QUdrv4n0GDChraBdG4EBdK5meq9k
 C8Y85BtbZHZv1ctL4DHacSneYgjIEsHO459t61Z7WWEhF52rGUzxnS67N/6BjTcXlf5QdOQA/15
 ufaE=
X-Google-Smtp-Source: AGHT+IE09FD0cMsBA13zqSe/F/Y43aUMRL01g/uuovEtGNz0oaczZm+0oMmgf5I5WHhOjP9AdOPPXw==
X-Received: by 2002:a17:903:1c6:b0:224:192a:9154 with SMTP id
 d9443c01a7336-22dbf5fa834mr28954235ad.26.1745581051402; 
 Fri, 25 Apr 2025 04:37:31 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a40sm29881055ad.147.2025.04.25.04.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:37:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/9] target/riscv/kvm: turn kvm_riscv_reg_id_ulong() in a
 macro
Date: Fri, 25 Apr 2025 08:37:00 -0300
Message-ID: <20250425113705.2741457-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

We need the reg_id_ulong() helper to be a macro to be able to create a
static array of KVMCPUConfig that will hold CSR information.

Despite the amount of changes all of them are tedious/trivial:

- replace instances of "kvm_riscv_reg_id_ulong" with
  "KVM_RISCV_REG_ID_ULONG";

- RISCV_CORE_REG(), RISCV_CSR_REG(), RISCV_CONFIG_REG() and
  RISCV_VECTOR_CSR_REG() only receives one 'name' arg. Remove unneeded
  'env' variables when applicable.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 99 ++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c91ecdfe59..fd66bc1759 100644
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


