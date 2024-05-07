Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15964C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPN-0003SF-GN; Tue, 07 May 2024 04:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPI-0003N5-JP; Tue, 07 May 2024 04:42:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPG-0003DR-4z; Tue, 07 May 2024 04:42:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA80764BC7;
 Tue,  7 May 2024 11:42:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8C2B9C85B0;
 Tue,  7 May 2024 11:42:29 +0300 (MSK)
Received: (nullmailer pid 1026521 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 03/16] target/riscv/kvm: change timer regs size to u64
Date: Tue,  7 May 2024 11:42:02 +0300
Message-Id: <20240507084226.1026455-3-mjt@tls.msk.ru>
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

KVM_REG_RISCV_TIMER regs are always u64 according to the KVM API, but at
this moment we'll return u32 regs if we're running a RISCV32 target.

Use the kvm_riscv_reg_id_u64() helper in RISCV_TIMER_REG() to fix it.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 10f86d1b845087d14b58d65dd2a6e3411d1b6529)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 82ed4455a5..ddbe820e10 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -88,7 +88,7 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
 #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
                  KVM_REG_RISCV_CSR_REG(name))
 
-#define RISCV_TIMER_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_TIMER, \
+#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
 #define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
@@ -111,17 +111,17 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
         } \
     } while (0)
 
-#define KVM_RISCV_GET_TIMER(cs, env, name, reg) \
+#define KVM_RISCV_GET_TIMER(cs, name, reg) \
     do { \
-        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
+        int ret = kvm_get_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
         if (ret) { \
             abort(); \
         } \
     } while (0)
 
-#define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
+#define KVM_RISCV_SET_TIMER(cs, name, reg) \
     do { \
-        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
+        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(name), &reg); \
         if (ret) { \
             abort(); \
         } \
@@ -649,10 +649,10 @@ static void kvm_riscv_get_regs_timer(CPUState *cs)
         return;
     }
 
-    KVM_RISCV_GET_TIMER(cs, env, time, env->kvm_timer_time);
-    KVM_RISCV_GET_TIMER(cs, env, compare, env->kvm_timer_compare);
-    KVM_RISCV_GET_TIMER(cs, env, state, env->kvm_timer_state);
-    KVM_RISCV_GET_TIMER(cs, env, frequency, env->kvm_timer_frequency);
+    KVM_RISCV_GET_TIMER(cs, time, env->kvm_timer_time);
+    KVM_RISCV_GET_TIMER(cs, compare, env->kvm_timer_compare);
+    KVM_RISCV_GET_TIMER(cs, state, env->kvm_timer_state);
+    KVM_RISCV_GET_TIMER(cs, frequency, env->kvm_timer_frequency);
 
     env->kvm_timer_dirty = true;
 }
@@ -666,8 +666,8 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
         return;
     }
 
-    KVM_RISCV_SET_TIMER(cs, env, time, env->kvm_timer_time);
-    KVM_RISCV_SET_TIMER(cs, env, compare, env->kvm_timer_compare);
+    KVM_RISCV_SET_TIMER(cs, time, env->kvm_timer_time);
+    KVM_RISCV_SET_TIMER(cs, compare, env->kvm_timer_compare);
 
     /*
      * To set register of RISCV_TIMER_REG(state) will occur a error from KVM
@@ -676,7 +676,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * TODO If KVM changes, adapt here.
      */
     if (env->kvm_timer_state) {
-        KVM_RISCV_SET_TIMER(cs, env, state, env->kvm_timer_state);
+        KVM_RISCV_SET_TIMER(cs, state, env->kvm_timer_state);
     }
 
     /*
@@ -685,7 +685,7 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
      * during the migration.
      */
     if (migration_is_running(migrate_get_current()->state)) {
-        KVM_RISCV_GET_TIMER(cs, env, frequency, reg);
+        KVM_RISCV_GET_TIMER(cs, frequency, reg);
         if (reg != env->kvm_timer_frequency) {
             error_report("Dst Hosts timer frequency != Src Hosts");
         }
-- 
2.39.2


