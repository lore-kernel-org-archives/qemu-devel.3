Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2B1C369CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgF-0008GJ-83; Thu, 17 Apr 2025 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofk-00083G-By
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:48:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofi-0004UN-Em
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:48:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22928d629faso7368365ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894129; x=1745498929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jngenDttp0u1Ci11+IBOi2+NPLfqzMg0yYPv26jlRH4=;
 b=HbEw4GLmY+A2TanVbVUoCAfWnAOBX+PVIqRWFZ+EGsKLqpm8/C5rvFKnDNAzXoa8ba
 fSGl3zk7BZJFtwArHMXsw9qd0R5AAc8n8aagdybt2v0Znd1BW41KYDn7dRY5qqgELdnN
 +I4xiDWdojKHv435EZNZcJVq5hs7peGA28bsvUvKdZ2WqJwsTRiDKHTSx4WNWPtTjP1M
 gkgNGwUMaelNwyYui8e8Q5sepMUSSgl58+2HFWDj5K4Afc/taTuJ+xxp58UFUhYMKxyo
 QcDHYRpztsoO7k1rHcAX00KZ5Uw3JtwZnMN+90pOzQPqpvb/cDOBN4mlYb4a3GVQUUZ6
 9Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894129; x=1745498929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jngenDttp0u1Ci11+IBOi2+NPLfqzMg0yYPv26jlRH4=;
 b=thuskvW+OXsaoWuDIwFrnujdQ2zA/yOWkktTzz3qXVy9hFOioI/nrJB6QP/ifEW5kG
 ifpK8SW0mPkiVgtqf66+ZqiVWmdO6ct6O1YISIooRKQ6jkv5dmseU1/ZhVMyY68DIgLJ
 tz2Ai1DKPfA58TAatqOVIdewu27Sx7n7lKgQoNyOjaX7gA3cumKC315BgUNUqGSRMgiC
 tGLeqbaDvIxBzxX1ZxDdSKlwOHY0rluG2PUhimYIZlaPvmfDKMy3GtZnBz5Vfkvo6RR3
 SqeIr38sov0o5npw8Ool8i46ouWMjQg9G5dzdZRJdf8oTS9TWe9VxZHMe3vTJP6bIa/C
 K6OQ==
X-Gm-Message-State: AOJu0YytwEES8odWRfmmJVNeZFCFKaBt9PheS1iViYZLjAZ0NzUOPCxV
 uwqG9UqQcQvttOu7dXIlXz+rgyN4qDIVnf22zOGXEDiWXRCUlPpo0znewel8e5y1hhotAx8w6oF
 V
X-Gm-Gg: ASbGncsfKKXQvayp9P7vRz3EK/qOkWKToDhBC9REUQpLtIWDsCFT86YE2CWhO8/Usq9
 ZpH7hMYVcoclVDdkfLBmqsOuYL4/3TbOjqYR+vDgkhMUlVDbM0Gduy14wH7S6ok4t4ygsOOi61R
 sZ5Mao+I2JhBkPsTpS5e+JgE3olijytYm5L9lg98hc/eCFZtn78fmFQ0NmVcE1IIqn5ACwORZQt
 +YZKCKIg2kZZJB2jpBCxvctmrJjLDjBla3MMZ63u2hf2S/8czz7QwGSLT+I47qNBvGeiXMZqVrm
 WdyO7ZALr4MLi08jlyHJY9YWWCfPfdLuX7k8EmBBC6pWrEdd65uKY826Se4fkvBRtV5G
X-Google-Smtp-Source: AGHT+IFFnw9mq6S/Bm5JG4zc1mRk3bRqshulHSQu1vRkh/0JolMxB7lnu1fMe2mWMsjX0R4kvfQY9A==
X-Received: by 2002:a17:902:ec83:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22c35982438mr83566805ad.49.1744894128648; 
 Thu, 17 Apr 2025 05:48:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:48:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/7] target/riscv/kvm: minor fixes/tweaks
Date: Thu, 17 Apr 2025 09:48:33 -0300
Message-ID: <20250417124839.1870494-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Remove an unused 'KVMScratchCPU' pointer argument in
kvm_riscv_check_sbi_dbcn_support().

Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
make a future patch diff easier to read, when changes in
kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.

Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0f4997a918..afe3d3e609 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -613,19 +613,6 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
-{
-    env->mstatus = 0;
-    env->mie = 0;
-    env->stvec = 0;
-    env->sscratch = 0;
-    env->sepc = 0;
-    env->scause = 0;
-    env->stval = 0;
-    env->mip = 0;
-    env->satp = 0;
-}
-
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
@@ -660,6 +647,19 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     return 0;
 }
 
+static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
+{
+    env->mstatus = 0;
+    env->mie = 0;
+    env->stvec = 0;
+    env->sscratch = 0;
+    env->sepc = 0;
+    env->scause = 0;
+    env->stval = 0;
+    env->mip = 0;
+    env->satp = 0;
+}
+
 static int kvm_riscv_get_regs_fp(CPUState *cs)
 {
     int ret = 0;
@@ -1078,7 +1078,6 @@ static int uint64_cmp(const void *a, const void *b)
 }
 
 static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
-                                             KVMScratchCPU *kvmcpu,
                                              struct kvm_reg_list *reglist)
 {
     struct kvm_reg_list *reg_search;
@@ -1197,7 +1196,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
     }
 
-    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
+    kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
-- 
2.49.0


