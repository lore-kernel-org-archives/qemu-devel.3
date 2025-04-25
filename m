Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E1C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HNI-0001Bm-OV; Fri, 25 Apr 2025 07:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNF-00019i-Hg
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8HNA-0006X1-Um
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:37:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso25980395ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745581054; x=1746185854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+z6XdUA6CWaSyeqlDqpxdNBJeRsM7KQpEgf6LmCeL4=;
 b=ertYbVFJmRuesZv1gwnbg6SvUDtD4oAv58U7z6cgPOcc4LWTjjVxe8jiiRUveq3Tbj
 /YhM9jsMbhbE1pztVC02oaTLwZnjXrsU1D/HzcDF0G5XONY6GdA4nE5IW+ZVBOEFlXpy
 tGklfeBalCpOFw26AlBJ1F9jVNzqUBS/kIgGKpB4ayzlU/Ubb0/Kc7CjkFaC3mmhRLRR
 5Fix1GjcBug7+96M6bq9nC/fZZxzCKnqzR7q50uEFHOApW5JT5UoChsWAM99fthM6iR2
 2JLMkvgzzso4AFSezZ59mUYStapX0lSKModXUEDZ1JDPiuftgal+nDLcsD04OrMYkaxK
 Ig1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581054; x=1746185854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+z6XdUA6CWaSyeqlDqpxdNBJeRsM7KQpEgf6LmCeL4=;
 b=TZHkVQ8vpl+feiS+SewZcPT4hlUAop7XlZ6Lm5iJnjCPLme1smqtdapPsRPuXA6Gt4
 UCpRkoDDpF22T7xKJd0WQOfdw7Tpfc6ESHoQR15w+LmopbLwFvdLTw//tJ21J8ZAAl37
 xrBTaZjs5f3TBX1plrvJhaLRTWmwlHbdQGKDVbBwQxWSVGK510w26us/6+bS3SyoToeJ
 87J/qgvsFRAEXbtqSBZ3Swjqvq1eNYfIdeBDWWsFy8aOKOI7auYjdJ9ma96M+45ewtip
 sc3HDVfduNqp5009zG0TICQjeRqCmYYwm9gTs6wT/Ria17g2AMXK/XoQYSLTAKWhI4I5
 C2NA==
X-Gm-Message-State: AOJu0YzqipdhrS72Z7INXwUTL32JkssQmsVDaHYzCXLJbCT+ql+ltAsd
 JuzISVsfOzZFeHgAXvEASc29BESnREaogYBzFBpGrpFHg2f7LJMtrDpLG6jO6mik74Z2/nw13Pn
 c
X-Gm-Gg: ASbGncui+OT+66mmXNB3h1FwHfM8AO0/0e/3ObDqW8zdZ+WFHlcnZRXA4P7TsNapIwl
 UTpNazSy3DcSpnwqs/hB+cduq7Ly8eO/VMuCkQEMRJrzuBjy/5Sh7PRDo9kuRfsB29q11qiggXg
 g/AkvjoQ06LhjPIb9C+V9UYGLQZOkuJGxIMfyUT3PBIi+VpaDgf34PjNo6Yy5k+OKPzspG5Cc0F
 GX7oS2yVZPdP6rMWJ3lf5nFuG2gSAucczWqUNN/w9Dh4OXnEv7LP9Kc2xu8Qa+FcexT9iFx/HhL
 iSjG54U7lREDQqLcX2iH7kB/fgFGWIXvcJLGqRrTQXm+7wnoUSW9lDfYl7I6v00HdLqT
X-Google-Smtp-Source: AGHT+IGNRX4jyXrF4BWovtnVXr3TxkBzaKwHZZsEKSPNreJRfbBktfTDu8STRByDbREyTLIPks7ovw==
X-Received: by 2002:a17:903:3042:b0:223:fb3a:8647 with SMTP id
 d9443c01a7336-22dbf6403b2mr25903585ad.41.1745581054275; 
 Fri, 25 Apr 2025 04:37:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a40sm29881055ad.147.2025.04.25.04.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 04:37:33 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 5/9] target/riscv/kvm: add kvm_csr_cfgs[]
Date: Fri, 25 Apr 2025 08:37:01 -0300
Message-ID: <20250425113705.2741457-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

At this moment we're not checking if the host has support for any
specific CSR before doing get/put regs. This will cause problems if the
host KVM doesn't support it (see [1] as an example).

We'll use the same approach done with the CPU extensions: read all known
KVM CSRs during init() to check for availability, then read/write them
if they are present. This will be made by either using get-reglist or by
directly reading the CSRs.

For now we'll just convert the CSRs to use a kvm_csr_cfg[] array,
reusing the same KVMCPUConfig abstraction we use for extensions, and use
the array in (get|put)_csr_regs() instead of manually listing them. A
lot of boilerplate will be added but at least we'll automate the get/put
procedure for CSRs, i.e. adding a new CSR in the future will be a matter
of adding it in kvm_csr_regs[] and everything else will be taken care
of.

Despite all the code changes no behavioral change is made.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h         |   1 +
 target/riscv/kvm/kvm-cpu.c | 121 ++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 679f417336..f5a60d0c52 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -79,6 +79,7 @@ const char *riscv_get_misa_ext_name(uint32_t bit);
 const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
+#define ENV_CSR_OFFSET(_csr) offsetof(CPURISCVState, _csr)
 
 typedef struct riscv_cpu_profile {
     struct riscv_cpu_profile *u_parent;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index fd66bc1759..7cbe566e5f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -114,22 +114,6 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
                            KVM_REG_RISCV_VECTOR_CSR_REG(name))
 
-#define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
-#define KVM_RISCV_SET_CSR(cs, env, csr, reg) \
-    do { \
-        int _ret = kvm_set_one_reg(cs, RISCV_CSR_REG(csr), &reg); \
-        if (_ret) { \
-            return _ret; \
-        } \
-    } while (0)
-
 #define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
         int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
@@ -251,6 +235,53 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+#define KVM_CSR_CFG(_name, _env_prop, reg_id) \
+    {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .kvm_reg_id = reg_id}
+
+static KVMCPUConfig kvm_csr_cfgs[] = {
+    KVM_CSR_CFG("sstatus", mstatus, RISCV_CSR_REG(sstatus)),
+    KVM_CSR_CFG("sie", mie, RISCV_CSR_REG(sie)),
+    KVM_CSR_CFG("stvec", stvec, RISCV_CSR_REG(stvec)),
+    KVM_CSR_CFG("sscratch", sscratch, RISCV_CSR_REG(sscratch)),
+    KVM_CSR_CFG("sepc", sepc, RISCV_CSR_REG(sepc)),
+    KVM_CSR_CFG("scause", scause, RISCV_CSR_REG(scause)),
+    KVM_CSR_CFG("stval", stval, RISCV_CSR_REG(stval)),
+    KVM_CSR_CFG("sip", mip, RISCV_CSR_REG(sip)),
+    KVM_CSR_CFG("satp", satp, RISCV_CSR_REG(satp)),
+};
+
+static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    return (void *)&cpu->env + csr_cfg->offset;
+}
+
+static uint64_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val32;
+}
+
+static uint64_t kvm_cpu_csr_get_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    return *val64;
+}
+
+static void kvm_cpu_csr_set_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint32_t val)
+{
+    uint32_t *val32 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val32 = val;
+}
+
+static void kvm_cpu_csr_set_u64(RISCVCPU *cpu, KVMCPUConfig *csr_cfg,
+                                uint64_t val)
+{
+    uint64_t *val64 = kvmconfig_get_env_addr(cpu, csr_cfg);
+    *val64 = val;
+}
+
 #define KVM_EXT_CFG(_name, _prop, _reg_id) \
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .kvm_reg_id = _reg_id}
@@ -598,34 +629,52 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
-    KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_GET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_GET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_GET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_GET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_GET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
+        } else {
+            g_assert_not_reached();
+        }
+    }
 
     return 0;
 }
 
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint64_t reg;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+            reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
+        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+            reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
+        } else {
+            g_assert_not_reached();
+        }
 
-    KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
-    KVM_RISCV_SET_CSR(cs, env, sie, env->mie);
-    KVM_RISCV_SET_CSR(cs, env, stvec, env->stvec);
-    KVM_RISCV_SET_CSR(cs, env, sscratch, env->sscratch);
-    KVM_RISCV_SET_CSR(cs, env, sepc, env->sepc);
-    KVM_RISCV_SET_CSR(cs, env, scause, env->scause);
-    KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
-    KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
-    KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+        ret = kvm_set_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
 
     return 0;
 }
-- 
2.49.0


