Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C9BC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKK-0002Hz-PL; Tue, 29 Apr 2025 08:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKJ-0002C3-58
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:43 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKG-0004MS-HU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso6571829a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930678; x=1746535478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOpiOx5SFtyMw4NePdfRwxvIac5AkMf5xXQqY8g3kvc=;
 b=Aai25GKrQ+YOkBpf4WTByvm84Pyoopetx99UwdF8oYy+AOjRyGP6r/TTDGAU4KX9cH
 ip4WqJspkggDWsXTX+FeC8GVlCd8MaIXT+xvYJj9vTlYsCNeEVuOgr5gINaG5GYhY2ww
 UZZS4s/InOxdTgp37gq1huCuTVbEZhurMRWkYTsjCyR+VXyKLdJMxpmy2YVPsbm3ufNr
 Ny/fuiZzQM8kXsBuVt6e+biyh98e6j3xjAQcp4xIWlT1w8go3srpFln2BUUvBXkuG278
 iQ/e3vYCRymwgPccJww0gM6L4HMhJgV2+RHcnw84I4hdJTv77snzHQszv0htAC+afu7v
 yZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930678; x=1746535478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOpiOx5SFtyMw4NePdfRwxvIac5AkMf5xXQqY8g3kvc=;
 b=ajVb5nCWoBQgbrHVRpm8fDbS9/2+nge3TOzKiVzO9oZqMsjlnh6lvwTU9xLXVta3rT
 aiN5WMDE6JnbVUTHM14rxeqBDr1YiENX5mOBuMnoIPJzSqCKNLjmvCtUGLWaWvB7rt6j
 fq2krCfVzogw61d/UHxKY4UdkcEtXcfMhtL9Vt8OfYYJl80JVRmLTr919OLiN14+t0Po
 xJxhw0E0SRGYgqLop8SCxQvXrpQ7aYvXXo3JM3MOUyMzlM+u2AZUGA/fRfnyPVDkFwaY
 yXJODJV0P98AZPr/vibB1lFMJGSHtjOBi/hQMqzBkBod860S4vkWDMhUZXxN4ITtKUp7
 5Jjw==
X-Gm-Message-State: AOJu0Yxt1idqwSJ4H4kbG/3OmaccS1Y0sgXsiV6hEGNEzR7gar+EbB+s
 De9CqEOGXFEToZMwLZOfubgMdTDjVv25JPbglnoDV7ZmUTjmtXKGIPr6a3/jwZDCIXw0Yb1kjCD
 u
X-Gm-Gg: ASbGncsfGRsXF4zeGSAKg0rmOfaGOr3MKjGrdkd8zJ85MNrBMmovzd4QjqT1KnPN29q
 l4giFxOWbYlJQhbCiInLE6QQnDpPy+926+mggCGChJd4XNe9DnKrMD5LSWRpH0ZbhaNzjZLE9Cg
 HwvpxJaeOqPuF43xXPFPglODUN1eVc3ykoxL7Na1WfZCsuab+mvO8J8FNG6nM2fy5f0k65WUiU+
 OGr255Sa4yjaY8nl+vjiYWoYKQPqVn4PHP11W+0uSKa3cq6KQT8SsXph19nTM20k5JaTnSJFW8k
 BOEgEhSDM/KGHnyHIlSwybDMjctkHFGu6rLOiSEMzUs=
X-Google-Smtp-Source: AGHT+IEvfFMfGfPleYPZOIZ4DWF5BpD5vZvaGo2grh5+/jeTqOFfjkH3Sz2Jkz92EWTDqcZ2zmpEGw==
X-Received: by 2002:a17:90b:1c09:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-30a2159bd80mr4702056a91.31.1745930678556; 
 Tue, 29 Apr 2025 05:44:38 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/9] target/riscv/kvm: add kvm_csr_cfgs[]
Date: Tue, 29 Apr 2025 09:44:17 -0300
Message-ID: <20250429124421.223883-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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
index fd66bc1759..f881e7eb5d 100644
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
+    KVM_CSR_CFG("sstatus",    mstatus,    RISCV_CSR_REG(sstatus)),
+    KVM_CSR_CFG("sie",        mie,        RISCV_CSR_REG(sie)),
+    KVM_CSR_CFG("stvec",      stvec,      RISCV_CSR_REG(stvec)),
+    KVM_CSR_CFG("sscratch",   sscratch,   RISCV_CSR_REG(sscratch)),
+    KVM_CSR_CFG("sepc",       sepc,       RISCV_CSR_REG(sepc)),
+    KVM_CSR_CFG("scause",     scause,     RISCV_CSR_REG(scause)),
+    KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
+    KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
+    KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+};
+
+static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
+{
+    return (void *)&cpu->env + csr_cfg->offset;
+}
+
+static uint32_t kvm_cpu_csr_get_u32(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
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


