Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B543C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJAAt-0005Gy-PY; Sun, 25 May 2025 08:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9d-0004Sq-Q2; Sun, 25 May 2025 08:08:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9a-0003Bl-5y; Sun, 25 May 2025 08:08:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48BF7124E4D;
 Sun, 25 May 2025 15:08:17 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 551B9215FB4;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?LIU=20Zhiwei=C2=A0?= <zhiwei_liu@linux.alibaba.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 27/59] target/riscv: pmp: don't allow RLB to bypass
 rule privileges
Date: Sun, 25 May 2025 15:07:44 +0300
Message-Id: <20250525120818.273372-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Loïc Lefort <loic@rivosinc.com>

When Smepmp is supported, mseccfg.RLB allows bypassing locks when writing CSRs
but should not affect interpretation of actual PMP rules.

This is not the case with the current implementation where pmp_hart_has_privs
calls pmp_is_locked which implements mseccfg.RLB bypass.

This commit implements the correct behavior by removing mseccfg.RLB bypass from
pmp_is_locked.

RLB bypass when writing CSRs is implemented by adding a new pmp_is_readonly
function that calls pmp_is_locked and check mseccfg.RLB. pmp_write_cfg and
pmpaddr_csr_write are changed to use this new function.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei  <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-2-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 4541d205f03cf1529439f68d2ec5056685189399)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b0841d44f4..e1e5ca589e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
  */
 static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
 {
-    /* mseccfg.RLB is set */
-    if (MSECCFG_RLB_ISSET(env)) {
-        return 0;
-    }
-
     if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
         return 1;
     }
@@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
     return 0;
 }
 
+/*
+ * Check whether a PMP is locked for writing or not.
+ * (i.e. has LOCK flag and mseccfg.RLB is unset)
+ */
+static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
+{
+    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
+}
+
 /*
  * Count the number of active rules.
  */
@@ -90,39 +94,38 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        bool locked = true;
+        bool readonly = true;
 
         if (riscv_cpu_cfg(env)->ext_smepmp) {
             /* mseccfg.RLB is set */
             if (MSECCFG_RLB_ISSET(env)) {
-                locked = false;
+                readonly = false;
             }
 
             /* mseccfg.MML is not set */
-            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index)) {
-                locked = false;
+            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
+                readonly = false;
             }
 
             /* mseccfg.MML is set */
             if (MSECCFG_MML_ISSET(env)) {
                 /* not adding execute bit */
                 if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
-                    locked = false;
+                    readonly = false;
                 }
                 /* shared region and not adding X bit */
                 if ((val & PMP_LOCK) != PMP_LOCK &&
                     (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
-                    locked = false;
+                    readonly = false;
                 }
             }
         } else {
-            if (!pmp_is_locked(env, pmp_index)) {
-                locked = false;
-            }
+            readonly = pmp_is_readonly(env, pmp_index);
         }
 
-        if (locked) {
-            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
+        if (readonly) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - read only\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
             /* If !mseccfg.MML then ignore writes with encoding RW=01 */
             if ((val & PMP_WRITE) && !(val & PMP_READ) &&
@@ -524,14 +527,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
             is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
-            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
+            if (pmp_is_readonly(env, addr_index + 1) && is_next_cfg_tor) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "ignoring pmpaddr write - pmpcfg + 1 locked\n");
+                              "ignoring pmpaddr write - pmpcfg+1 read only\n");
                 return;
             }
         }
 
-        if (!pmp_is_locked(env, addr_index)) {
+        if (!pmp_is_readonly(env, addr_index)) {
             if (env->pmp_state.pmp[addr_index].addr_reg != val) {
                 env->pmp_state.pmp[addr_index].addr_reg = val;
                 pmp_update_rule_addr(env, addr_index);
@@ -542,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "ignoring pmpaddr write - locked\n");
+                          "ignoring pmpaddr write - read only\n");
         }
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.39.5


