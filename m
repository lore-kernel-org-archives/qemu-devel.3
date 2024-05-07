Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08D3C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPW-0003YS-A7; Tue, 07 May 2024 04:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPH-0003MP-Vh; Tue, 07 May 2024 04:42:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPF-0003DH-6W; Tue, 07 May 2024 04:42:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CC3364BC6;
 Tue,  7 May 2024 11:42:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7ACC8C85AF;
 Tue,  7 May 2024 11:42:29 +0300 (MSK)
Received: (nullmailer pid 1026517 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 02/16] target/riscv/kvm: change KVM_REG_RISCV_FP_D to
 u64
Date: Tue,  7 May 2024 11:42:01 +0300
Message-Id: <20240507084226.1026455-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KVM_REG_RISCV_FP_D regs are always u64 size. Using kvm_riscv_reg_id() in
RISCV_FP_D_REG() ends up encoding the wrong size if we're running with
TARGET_RISCV32.

Create a new helper that returns a KVM ID with u64 size and use it with
RISCV_FP_D_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 450bd6618fda3d2e2ab02b2fce1c79efd5b66084)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 2eef2be86a..82ed4455a5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -77,6 +77,11 @@ static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
     return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
 }
 
+static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
+{
+    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
+}
+
 #define RISCV_CORE_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, \
                  KVM_REG_RISCV_CORE_REG(name))
 
@@ -88,7 +93,7 @@ static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
 
 #define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
 
-#define RISCV_FP_D_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_D, idx)
+#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
 
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
@@ -579,7 +584,7 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
     if (riscv_has_ext(env, RVD)) {
         uint64_t reg;
         for (i = 0; i < 32; i++) {
-            ret = kvm_get_one_reg(cs, RISCV_FP_D_REG(env, i), &reg);
+            ret = kvm_get_one_reg(cs, RISCV_FP_D_REG(i), &reg);
             if (ret) {
                 return ret;
             }
@@ -613,7 +618,7 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
         uint64_t reg;
         for (i = 0; i < 32; i++) {
             reg = env->fpr[i];
-            ret = kvm_set_one_reg(cs, RISCV_FP_D_REG(env, i), &reg);
+            ret = kvm_set_one_reg(cs, RISCV_FP_D_REG(i), &reg);
             if (ret) {
                 return ret;
             }
-- 
2.39.2


