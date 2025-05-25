Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313CEC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJAB7-0005yD-Qk; Sun, 25 May 2025 08:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9i-0004Vo-F2; Sun, 25 May 2025 08:08:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9f-0003Db-8k; Sun, 25 May 2025 08:08:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DCE0124E4F;
 Sun, 25 May 2025 15:08:17 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6A73B215FB6;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 29/59] target/riscv: pmp: fix checks on writes to
 pmpcfg in Smepmp MML mode
Date: Sun, 25 May 2025 15:07:46 +0300
Message-Id: <20250525120818.273372-6-mjt@tls.msk.ru>
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

With Machine Mode Lockdown (mseccfg.MML) set and RLB not set, checks on pmpcfg
writes would match the wrong cases of Smepmp truth table.

The existing code allows writes for the following cases:
- L=1, X=0: cases 8, 10, 12, 14
- L=0, RWX!=WX: cases 0-2, 4-6
This leaves cases 3, 7, 9, 11, 13, 15 for which writes are ignored.

From the Smepmp specification: "Adding a rule with executable privileges that
either is M-mode-only or a locked Shared-Region is not possible (...)" This
description matches cases 9-11, 13 of the truth table.

This commit implements an explicit check for these cases by using
pmp_get_epmp_operation to convert between PMP configuration and Smepmp truth
table cases.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-4-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 19cf1a7d9e59b71bf8d6571d4747e5c82667c3d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 7d65dc24a5..c5f6cdaccb 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -75,6 +75,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
     return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
 }
 
+/*
+ * Check whether `val` is an invalid Smepmp config value
+ */
+static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
+{
+    /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
+    if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
+        return 0;
+    }
+
+    /*
+     * Adding a rule with executable privileges that either is M-mode-only
+     * or a locked Shared-Region is not possible
+     */
+    switch (pmp_get_smepmp_operation(val)) {
+    case 0:
+    case 1:
+    case 2:
+    case 3:
+    case 4:
+    case 5:
+    case 6:
+    case 7:
+    case 8:
+    case 12:
+    case 14:
+    case 15:
+        return 0;
+    case 9:
+    case 10:
+    case 11:
+    case 13:
+        return 1;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Count the number of active rules.
  */
@@ -103,44 +141,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        bool readonly = true;
-
-        if (riscv_cpu_cfg(env)->ext_smepmp) {
-            /* mseccfg.RLB is set */
-            if (MSECCFG_RLB_ISSET(env)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is not set */
-            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is set */
-            if (MSECCFG_MML_ISSET(env)) {
-                /* not adding execute bit */
-                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
-                    readonly = false;
-                }
-                /* shared region and not adding X bit */
-                if ((val & PMP_LOCK) != PMP_LOCK &&
-                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
-                    readonly = false;
-                }
-            }
-        } else {
-            readonly = pmp_is_readonly(env, pmp_index);
-        }
-
-        if (readonly) {
+        if (pmp_is_readonly(env, pmp_index)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - read only\n");
-        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
-            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
-            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
-                !MSECCFG_MML_ISSET(env)) {
-                return false;
-            }
+        } else if (pmp_is_invalid_smepmp_cfg(env, val)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - invalid\n");
+        } else {
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
-- 
2.39.5


