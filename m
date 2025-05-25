Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549EFC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7sd-0006rh-HQ; Sun, 25 May 2025 05:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7sc-0006rQ-Cb; Sun, 25 May 2025 05:42:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7sa-0004WM-Mv; Sun, 25 May 2025 05:42:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9099124DD7;
 Sun, 25 May 2025 12:42:46 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AC5DA215EFF;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 37/62] target/riscv: pmp: move Smepmp operation
 conversion into a function
Date: Sun, 25 May 2025 12:42:20 +0300
Message-Id: <20250525094246.174612-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
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

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-3-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 915b203745540e908943758f78f5da49e0a15e45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a1b36664fc..cfb535638e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -31,6 +31,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
 
+/*
+ * Convert the PMP permissions to match the truth table in the Smepmp spec.
+ */
+static inline uint8_t pmp_get_smepmp_operation(uint8_t cfg)
+{
+    return ((cfg & PMP_LOCK) >> 4) | ((cfg & PMP_READ) << 2) |
+           (cfg & PMP_WRITE) | ((cfg & PMP_EXEC) >> 2);
+}
+
 /*
  * Accessor method to extract address matching type 'a field' from cfg reg
  */
@@ -352,16 +361,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
 
-        /*
-         * Convert the PMP permissions to match the truth table in the
-         * Smepmp spec.
-         */
-        const uint8_t smepmp_operation =
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
-            (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_EXEC) >> 2);
-
         if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
             /*
              * If the PMP entry is not off and the address is in range,
@@ -380,6 +379,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
                 /*
                  * If mseccfg.MML Bit set, do the enhanced pmp priv check
                  */
+                const uint8_t smepmp_operation =
+                    pmp_get_smepmp_operation(env->pmp_state.pmp[i].cfg_reg);
+
                 if (mode == PRV_M) {
                     switch (smepmp_operation) {
                     case 0:
-- 
2.39.5


