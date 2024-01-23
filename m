Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8FC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJT0-0003Z6-0i; Tue, 23 Jan 2024 11:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSy-0003Xq-2a
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:36 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSt-0007a2-78
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:35 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2907748497dso2114077a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706026649; x=1706631449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlLC6Ot4/dn/UCAb/W6JpULetzzTz/g5dq77T6/tyqo=;
 b=nWK+EV6i2j9AtKyAHZXx0NKCnATZ5KZbgd+oar2QXO28vrzXTsT4z+8tFxo/mp4UBs
 48pz2WnniRxdpxjZhfkJPK73tzhlYogUk8qfPV+shD1Wo9xwsR6I8UM85NhdR+EIqVQU
 dHsIgrR9RBIDCLBw0VLKCtvZjWutoLlUvNjX9WGsh316FJbBoLzh7yxziZ2rb/eKsHqw
 uqzegQXv+U6M6rF4cEkK1bhumqahnhjqo+q2lTN/e6M+P8Ra437VXeZFDCisfpjfOjOt
 SVl++9p0mvZD1CQ86HIHVJFhi5Wgn2jq5MLlvZs//lkCK+xrVXpFU/oaItRtZjUcodDA
 /B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026649; x=1706631449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlLC6Ot4/dn/UCAb/W6JpULetzzTz/g5dq77T6/tyqo=;
 b=fxmkOXqpEmGeIPBPAWq8APKSJKSQ2d2CG59/93ZDxtOZESN1X5p4Q2L4i19PSpBFto
 XTqbWzo4hHT0NLkvJy/M9rhuC5skYAQj2h2Uj7vWcZjHHHSQqpyXrEvRjNcPeZXptR13
 ySH8IBPachS2WLT2F5WLRrH3VLDUsKf3R92Hf+IC73p5AUkr7LtQSzYibwBlgP8rBXK9
 oD5dtCw56WNs7FOmcw8rcO8RxCQuIhu10/OdER7qFca2ymxHD4O8lKO/BS/BHx4rAKKM
 C89Ge9r7lhE9Yex9yy/97JiPcGrwseE7tqf7RRyj/Sd9CWLJ0Uy8prFUMuXtk1+vSNdE
 wpFQ==
X-Gm-Message-State: AOJu0Yy/uV1SiVOjDfCnuwbgIv2EWr5zkJKB4BKXBQqQItPfVWHLz3QM
 62bnh4PBu3fnAxg8zz/i/XbcenX0+jP1po+7vZGERyYJTLMWgNfXG9Y40NJnEJtCmxDW9UWonuT
 d
X-Google-Smtp-Source: AGHT+IHEQL40+wUcxdYC+VK/FZ+GvweSj5l870dP+8SwcUgqckjFoL0epxkJeynJb6tKY3Paadu8+A==
X-Received: by 2002:a17:90b:157:b0:290:2c5:b231 with SMTP id
 em23-20020a17090b015700b0029002c5b231mr3017397pjb.81.1706026649486; 
 Tue, 23 Jan 2024 08:17:29 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 u14-20020a17090ac88e00b0028bcc2a47e9sm11755686pjt.38.2024.01.23.08.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:17:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/3] target/riscv/kvm: initialize 'vlenb' via get-reg-list
Date: Tue, 23 Jan 2024 13:17:13 -0300
Message-ID: <20240123161714.160149-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123161714.160149-1-dbarboza@ventanamicro.com>
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

KVM will check for the correct 'reg_size' when accessing the vector
registers, erroring with EINVAL if we encode the wrong size in reg ID.
Vector registers varies in size with the vector length in bytes, or
'vlenb'. This means that we need the current 'vlenb' being used by the
host, otherwise we won't be able to fetch all vector regs.

We'll deal with 'vlenb' first. Its support was added in Linux 6.8 as a
get-reg-list register. We'll read 'vlenb' via get-reg-list and mark the
register as 'supported'. All 'vlenb' ops via kvm_arch_get_registers()
and kvm_arch_put_registers() will only be done if the reg is supported,
i.e. we fetched it in get-reg-list during init.

If the user sets a new vlenb value using the 'vlen' property, throw an
error if the user value differs from the host.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 85 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 902180e8a5..3812481971 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -352,6 +352,13 @@ static KVMCPUConfig kvm_cboz_blocksize = {
     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
 };
 
+static KVMCPUConfig kvm_v_vlenb = {
+    .name = "vlenb",
+    .offset = CPU_CFG_OFFSET(vlenb),
+    .kvm_reg_id =  KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_VECTOR |
+                   KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)
+};
+
 static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
 {
     CPURISCVState *env = &cpu->env;
@@ -684,7 +691,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
 
 static int kvm_riscv_get_regs_vector(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     int ret = 0;
 
@@ -710,12 +718,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    if (kvm_v_vlenb.supported) {
+        ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+        if (ret) {
+            return ret;
+        }
+        cpu->cfg.vlenb = reg;
+    }
+
     return 0;
 }
 
 static int kvm_riscv_put_regs_vector(CPUState *cs)
 {
-    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     target_ulong reg;
     int ret = 0;
 
@@ -737,6 +754,14 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
 
     reg = env->vtype;
     ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    if (kvm_v_vlenb.supported) {
+        reg = cpu->cfg.vlenb;
+        ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+    }
 
     return ret;
 }
@@ -921,6 +946,33 @@ static int uint64_cmp(const void *a, const void *b)
     return 0;
 }
 
+static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
+                                 struct kvm_reg_list *reglist)
+{
+    struct kvm_one_reg reg;
+    struct kvm_reg_list *reg_search;
+    uint64_t val;
+    int ret;
+
+    reg_search = bsearch(&kvm_v_vlenb.kvm_reg_id, reglist->reg, reglist->n,
+                         sizeof(uint64_t), uint64_cmp);
+
+    if (reg_search) {
+        reg.id = kvm_v_vlenb.kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_report("Unable to read vlenb register, error code: %s",
+                         strerrorname_np(errno));
+            exit(EXIT_FAILURE);
+        }
+
+        kvm_v_vlenb.supported = true;
+        cpu->cfg.vlenb = val;
+    }
+}
+
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     KVMCPUConfig *multi_ext_cfg;
@@ -995,6 +1047,10 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (cpu->cfg.ext_zicboz) {
         kvm_riscv_read_cbomz_blksize(cpu, kvmcpu, &kvm_cboz_blocksize);
     }
+
+    if (riscv_has_ext(&cpu->env, RVV)) {
+        kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
+    }
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1566,7 +1622,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     int ret;
 
     /* short-circuit without spinning the scratch CPU */
-    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz) {
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz &&
+        !riscv_has_ext(env, RVV)) {
         return;
     }
 
@@ -1613,6 +1670,28 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    /* Users are setting vlen, not vlenb */
+    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
+        if (!kvm_v_vlenb.supported) {
+            error_setg(errp, "Unable to set 'vlenb': register not supported");
+            return;
+        }
+
+        reg.id = kvm_v_vlenb.kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read vlenb register, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.vlenb != val) {
+            error_setg(errp, "Unable to set 'vlen' to a different "
+                       "value than the host (%lu)", val * 8);
+            return;
+        }
+    }
+
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
-- 
2.43.0


