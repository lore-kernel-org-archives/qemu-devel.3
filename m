Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B810BC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKT-0002d1-M2; Tue, 29 Apr 2025 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKO-0002TC-SF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKJ-0004Mo-1R
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso6002035a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930681; x=1746535481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R37KMDljb4CsAfrDdBRy5Wnf5bfrROiq1X3f4Wy4iUE=;
 b=hMkgP6tPYe/nYoZ2B03YpckCh0asnSINM0tSY8K7f265//siB2uKIqML1UU4TlkmF7
 k08QbDWzsXoovsZg4ZYRSnKPSAaSBHJfZpexbX9aV8ybigkF8gpsrerZ8isH3Js1OcT5
 BO3OT9rvi2z441Ejt6nLUeGv4rWvFiG7gvUFHaFyrO4DgFBAkgnrblEYKBJlsy76v7IE
 iUrQS0+m/ZMm7YcTLWJ/fFs6WKfk+djg+LFU5D0la2/kZggXNk7+VUs6pPyl9Tg0wfut
 ZTABqDSuC7Spu3V1rAV9p5++RDHYUOeoXoa99XmcJUB5l7sTbe41nymMdEbQDcHWdmbV
 GUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930681; x=1746535481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R37KMDljb4CsAfrDdBRy5Wnf5bfrROiq1X3f4Wy4iUE=;
 b=OgfjC7L0O141NPecWgodLThucBROmfKL8qHFj9APXRp5swMbXo9hHCClaqqGwGLMiv
 +CpwiV7E12fUnAAao09olTmizPs3OlsfeXd2PHtIDkd+92JwnIDm+nfSpXw6ISQQiOAr
 TPX7N9d71zme5LDtv/vajGEXR3+L7e5Br47zkFjH/oNAKA9BCVWqcRdMcqJBwKPqgT3d
 3G73+JOqUvLT2Zacc7MtSN1mPBKIcEBcSpUbZYjYwZinirM5gQDtI3+sIEmGiZZw+byb
 44Q5bihzqZtnz1zxraXtj95HHimeCGlKaVwuxR0eI8IWUCH7HIIpumqmu7RodtBJrp4z
 wAkA==
X-Gm-Message-State: AOJu0YwqIPu7UWNDb0+6AWkUVplH26pbypZFcEWNDqHpcDPwgtWNeE3h
 gL8zmhxelTwjgKLDHSF0YkthTMCcTAy8FxAcr7zKkoNyuh9uoUR81/MPEp94t6JZ7F10xMDOBMD
 D
X-Gm-Gg: ASbGncuawJR3QXbxM2zFWL7EQ/cT8ldQ9rh90Qt26jHxJ3ODD5oGmLQpja/bjz2GD4H
 A1+rvY1dIVSX2UjTTWhO52JJevEH8GwHgvmttYwrz3ntQXKJXydErBoljYKi4Yovo/KRyigMeAC
 GTrBwGebAKdjIf4Tx1tblyGhemBTFusvJYzIOXdHDmw8wnnZYQpnpMoxZ3dylzs9jS2iTesv9Ed
 fwbsEImiP/Y1lGHJp73YM7m7QPFdl6WueylxsFjvkSgEsYSqiEALusAMZoejIA2ji4J7lcY9o7J
 TL9d/uiD2YQORqHNL2L6o2XO65qdnVMosOiZj62E3SeIUUAI2TEYCg==
X-Google-Smtp-Source: AGHT+IEL7xROVk7A114uX5GJ4gtABYjYPFKjD/BY6PAVzNL2L5h33hYbGTAsByTFWNnAKDGAj1PocQ==
X-Received: by 2002:a17:90b:4c09:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-30a2155ece6mr6017273a91.18.1745930680952; 
 Tue, 29 Apr 2025 05:44:40 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v5 6/9] target/riscv/kvm: do not read unavailable CSRs
Date: Tue, 29 Apr 2025 09:44:18 -0300
Message-ID: <20250429124421.223883-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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

[1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
This happens because the kernel does not know 'senvcfg', making it
unable to boot because QEMU is reading/wriiting it without any checks.

After converting the CSRs to do "automated" get/put reg procedures in
the previous patch we can now scan for availability. Two functions are
created:

- kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
  forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
  return as indication that the CSR isn't available. This will be use in
  absence of KVM_GET_REG_LIST;

- kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
  to check if the CSRs ids are present.

kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_cfg() to reflect that
the function is also dealing with CSRs.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 62 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f881e7eb5d..1ce747d047 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -636,6 +636,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
         if (ret) {
             return ret;
@@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
         } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
@@ -1090,6 +1098,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
     }
 }
 
+static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
+{
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+        struct kvm_one_reg reg;
+
+        reg.id = csr_cfg->kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            if (errno == EINVAL) {
+                csr_cfg->supported = false;
+            } else {
+                error_report("Unable to read KVM CSR %s: %s",
+                             csr_cfg->name, strerror(errno));
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            csr_cfg->supported = true;
+        }
+    }
+}
+
 static int uint64_cmp(const void *a, const void *b)
 {
     uint64_t val1 = *(const uint64_t *)a;
@@ -1146,7 +1180,26 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+    uint64_t reg_id;
+
+    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        reg_id = csr_cfg->kvm_reg_id;
+        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
+                             sizeof(uint64_t), uint64_cmp);
+        if (!reg_search) {
+            continue;
+        }
+
+        csr_cfg->supported = true;
+    }
+}
+
+static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
@@ -1163,7 +1216,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
      * (EINVAL). Use read_legacy() in this case.
      */
     if (errno == EINVAL) {
-        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
+        return;
     } else if (errno != E2BIG) {
         /*
          * E2BIG is an expected error message for the API since we
@@ -1226,6 +1281,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
+    kvm_riscv_read_csr_cfg(reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1239,7 +1295,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
 
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
-    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.49.0


