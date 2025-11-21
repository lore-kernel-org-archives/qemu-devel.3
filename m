Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDEBCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd7F-0004tH-Hz; Fri, 21 Nov 2025 21:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcmK-0002eU-KI; Fri, 21 Nov 2025 20:51:08 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMckG-0005R8-UW; Fri, 21 Nov 2025 20:51:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5FB316CA43;
 Fri, 21 Nov 2025 21:44:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82698321C7F;
 Fri, 21 Nov 2025 21:44:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 08/81] target/riscv/kvm: read/write KVM regs via env
 size
Date: Fri, 21 Nov 2025 21:43:07 +0300
Message-ID: <20251121184424.1137669-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

We're going to add support for scounteren in the next patch. KVM defines
as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
field. This will cause the current code to read/write a 64 bit CSR in a
32 bit field when running in a 64 bit CPU.

To prevent that, change the current logic to honor the size of the QEMU
storage instead of the KVM CSR reg.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250429124421.223883-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 775ac57e0a54b9127bd2ad005675772870cd1932)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 2bc0dcb804..66bdd6bf17 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
     const char *description;
     target_ulong offset;
     uint64_t kvm_reg_id;
+    uint32_t prop_size;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
@@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
 #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
     {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
      .kvm_reg_id = reg_id}
 
 static KVMCPUConfig kvm_csr_cfgs[] = {
@@ -646,9 +648,9 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
             return ret;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
-            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
         } else {
             g_assert_not_reached();
@@ -671,9 +673,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
             continue;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
         } else {
             g_assert_not_reached();
-- 
2.47.3


