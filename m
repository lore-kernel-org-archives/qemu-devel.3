Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFEEC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVV-00060V-04; Fri, 25 Apr 2025 12:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVI-0005qa-Qb
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:18 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVG-0008L5-Fb
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so2179088a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596932; x=1746201732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Uq/rLXIS8ug5SKK/6uy5oyF7TJvUXA2Q9EXkRFfaBA=;
 b=FKn/Ofz86ol5CkgBNvfpMWpww+YutGcvmj5Cx0Zx/P8rzZI5cOVzqeoD58fyaxUqYs
 BU0w/a2RJbz5ToE0uUMp7vXYpmJZrExRj+VW+sSHTu3u4XiTe2sTiZpZPm1phUSk8kb+
 XL7PCsW3IE8/k9x8CIwDCsC+TRJb7mZE0JkGAAyuI0qAWs018G0I7kPFk9cobvuGFF2x
 NGKo/k8Q/cEMKnhmAUgcvea56hKmvq5GbtOC9VXSX4X7D9YnVX2oNBlqm12oa6CMJ+Tl
 4WP+tSmoYzjyyP+wu0K5hEB9E9AxqfLubehn3zJjt0mOqKw1rM75l5TRsdXeUs/CfCqU
 FFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596932; x=1746201732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Uq/rLXIS8ug5SKK/6uy5oyF7TJvUXA2Q9EXkRFfaBA=;
 b=hd/5yEWGlJyxOKMoISFPDWQ09l7DbQXADvT5sI/yJKrV6WayvxmSjSGhlTxVv3+xlD
 RlTuWuqb26nmOz1dReVUauyZb7cLc88gTOjTXZpANUU+WPACZTQOwb3cP6tXr4JMARTu
 eKbo+Jz/g6ilUs25p7UgRhVkrW9JfTIQfoSBdRKuNVRU5WWNyuEjj5anCh6cSbx6x9Pf
 siu5ueJCHp+7Q9Zr6CHclkuJWrNyr1kUzljgENJ2Mb9Tl24NQZykhX9jCdl9UeMaMcgp
 WvBbKXx3BX3Tkp0WBR5YngOWuZxH8YVd9jNA8w1x9WbPuLcfCbOEcRU/ZzUvJ2NM40aB
 2zwg==
X-Gm-Message-State: AOJu0YwA69Eu095ryTlkLZ0c2gj5Dn4T4yEk1Meb0jRtG6VGSfdCqrug
 VWnUrxlRAKtQE7ThdF/SlMvaTWfnoW0kqpwKnctYUWqgBkT4FEyBx4nCqVY4WrrhEg0hedYR7fT
 b
X-Gm-Gg: ASbGncvUd99rsz8BH6zOCHFWyLqQuFPLCfJT6fRJW9GqwojUVEquswc0dO/1T1lM0pu
 qg14XbyX2d21u5lLayXkIJ2CK1TaMmlrv56JAJgkozG8v0sNhFgpSMTKUZzpHcgNWqYpf5cwYDE
 PQh+qVjxJcIlZAFcttvXb6VKvwsB/oLgocUh1XtS7dfUiBstwUx4yXkYvByAi6LlgvUgwXdlvBR
 V8AOviiHk6LiUR/kuKJ/X7yKiDWA16eOH5pYrpnfNIOsp8haOzx0D3t960C+mApQs9b6HJ7I+9R
 DRYUxYITtjfqOTHGjLMD6r8DeySyKB3ppBtc4YFqZyA+todMiUjIq/JYtrxphgeePpHB
X-Google-Smtp-Source: AGHT+IGWntJ8BdmmmO8HLMFPWXPXnvkqaifuhzit9YVgmilTbooyzsVLnq34twFn+enqwItCyGOdPQ==
X-Received: by 2002:a17:90b:4f46:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-309f7da0a24mr4695670a91.2.1745596931499; 
 Fri, 25 Apr 2025 09:02:11 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/9] target/riscv/kvm: minor fixes/tweaks
Date: Fri, 25 Apr 2025 13:01:55 -0300
Message-ID: <20250425160203.2774835-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9214ce490c..accad4c28e 100644
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


