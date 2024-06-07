Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CD7C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:03:07 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf4x-0001sa-8c; Fri, 07 Jun 2024 15:16:47 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4v-0001rb-Cd; Fri, 07 Jun 2024 15:16:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4t-0002uL-J1; Fri, 07 Jun 2024 15:16:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF8B06E562;
 Fri,  7 Jun 2024 22:14:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DAA07E275C;
 Fri,  7 Jun 2024 22:13:58 +0300 (MSK)
Received: (nullmailer pid 529434 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 53/71] target/riscv/kvm: Fix exposure of Zkr
Date: Fri,  7 Jun 2024 22:13:34 +0300
Message-Id: <20240607191356.529336-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

The Zkr extension may only be exposed to KVM guests if the VMM
implements the SEED CSR. Use the same implementation as TCG.

Without this patch, running with a KVM which does not forward the
SEED CSR access to QEMU will result in an ILL exception being
injected into the guest (this results in Linux guests crashing on
boot). And, when running with a KVM which does forward the access,
QEMU will crash, since QEMU doesn't know what to do with the exit.

Fixes: 3108e2f1c69d ("target/riscv/kvm: update KVM exts to Linux 6.8")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240422134605.534207-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 86997772fa807f3961e5aeed97af7738adec1b43)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3b1a02b944..52fb8c15d0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -821,6 +821,9 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
+
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..829d8346ed 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4267,10 +4267,8 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
 #endif
 
 /* Crypto Extension */
-static RISCVException rmw_seed(CPURISCVState *env, int csrno,
-                               target_ulong *ret_value,
-                               target_ulong new_value,
-                               target_ulong write_mask)
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask)
 {
     uint16_t random_v;
     Error *random_e = NULL;
@@ -4294,6 +4292,18 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
         rval = random_v | SEED_OPST_ES16;
     }
 
+    return rval;
+}
+
+static RISCVException rmw_seed(CPURISCVState *env, int csrno,
+                               target_ulong *ret_value,
+                               target_ulong new_value,
+                               target_ulong write_mask)
+{
+    target_ulong rval;
+
+    rval = riscv_new_csr_seed(new_value, write_mask);
+
     if (ret_value) {
         *ret_value = rval;
     }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index ee69ea9785..243a624fee 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1418,6 +1418,28 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
+{
+    target_ulong csr_num = run->riscv_csr.csr_num;
+    target_ulong new_value = run->riscv_csr.new_value;
+    target_ulong write_mask = run->riscv_csr.write_mask;
+    int ret = 0;
+
+    switch (csr_num) {
+    case CSR_SEED:
+        run->riscv_csr.ret_value = riscv_new_csr_seed(new_value, write_mask);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: un-handled CSR EXIT for CSR %lx\n",
+                      __func__, csr_num);
+        ret = -1;
+        break;
+    }
+
+    return ret;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -1425,6 +1447,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_RISCV_SBI:
         ret = kvm_riscv_handle_sbi(cs, run);
         break;
+    case KVM_EXIT_RISCV_CSR:
+        ret = kvm_riscv_handle_csr(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
-- 
2.39.2


