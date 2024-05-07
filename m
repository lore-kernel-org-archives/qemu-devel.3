Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1732CC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPI-0003Kb-0H; Tue, 07 May 2024 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPD-0003K1-M1; Tue, 07 May 2024 04:42:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GP8-0003Ca-Dw; Tue, 07 May 2024 04:42:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6300F64BC5;
 Tue,  7 May 2024 11:42:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 513EAC85AE;
 Tue,  7 May 2024 11:42:27 +0300 (MSK)
Received: (nullmailer pid 1026510 invoked by uid 1000);
 Tue, 07 May 2024 08:42:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 01/16] target/riscv/kvm: change KVM_REG_RISCV_FP_F to
 u32
Date: Tue,  7 May 2024 11:42:00 +0300
Message-Id: <20240507084226.1026455-1-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

KVM_REG_RISCV_FP_F regs have u32 size according to the API, but by using
kvm_riscv_reg_id() in RISCV_FP_F_REG() we're returning u64 sizes when
running with TARGET_RISCV64. The most likely reason why no one noticed
this is because we're not implementing kvm_cpu_synchronize_state() in
RISC-V yet.

Create a new helper that returns a KVM ID with u32 size and use it in
RISCV_FP_F_REG().

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 49c211ffca00fdf7c0c29072c224e88527a14838)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c1675158fe..2eef2be86a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -72,6 +72,11 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
     return id;
 }
 
+static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
+{
+    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
+}
+
 #define RISCV_CORE_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, \
                  KVM_REG_RISCV_CORE_REG(name))
 
@@ -81,7 +86,7 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 #define RISCV_TIMER_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
-#define RISCV_FP_F_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_F, idx)
+#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
 
 #define RISCV_FP_D_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_D, idx)
 
@@ -586,7 +591,7 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
     if (riscv_has_ext(env, RVF)) {
         uint32_t reg;
         for (i = 0; i < 32; i++) {
-            ret = kvm_get_one_reg(cs, RISCV_FP_F_REG(env, i), &reg);
+            ret = kvm_get_one_reg(cs, RISCV_FP_F_REG(i), &reg);
             if (ret) {
                 return ret;
             }
@@ -620,7 +625,7 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
         uint32_t reg;
         for (i = 0; i < 32; i++) {
             reg = env->fpr[i];
-            ret = kvm_set_one_reg(cs, RISCV_FP_F_REG(env, i), &reg);
+            ret = kvm_set_one_reg(cs, RISCV_FP_F_REG(i), &reg);
             if (ret) {
                 return ret;
             }
-- 
2.39.2


