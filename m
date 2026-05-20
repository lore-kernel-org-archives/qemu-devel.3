Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB591CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgNk-000545-TT; Wed, 20 May 2026 08:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgNS-0004gJ-N2; Wed, 20 May 2026 08:50:23 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgNP-0002hl-Q9; Wed, 20 May 2026 08:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=t2hXVP/pFfq/n8n1WIHKqO9gqrs57J49/eLBv1H+x7Q=; b=KTZtqmL7MTjxF5e
 19sI5GuC4OpJiv42427d2oYH1zDAVnuRaQkU3OzZmFdc3qB7Mjj/RMe2+55Bi5osXhJ/ZYnbcT+Ip
 rrhfg84HeIS4Tt8TJ90Tj0rfTPxANxOaJVIw3NPcd1PtXMpOm5aRMkjHnjwUBe4UplKDVy5eQXUTN
 Tc=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 25/27] target/riscv: Make pmp.h target_ulong agnostic
Date: Wed, 20 May 2026 14:54:03 +0200
Message-ID: <20260520125406.28693-26-anjo@rev.ng>
In-Reply-To: <20260520125406.28693-1-anjo@rev.ng>
References: <20260520125406.28693-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
CPUArchState.  CSR declarations are only used in target/ and are moved to
csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
parameter is fixed to 8 bits, similar to previous commits.

Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
migration from older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.h     | 12 ++++++++++++
 target/riscv/pmp.h     | 19 +++++--------------
 target/riscv/machine.c | 10 +++++-----
 target/riscv/pmp.c     | 10 ++++++----
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 4cca3a000a..c791260f83 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -87,4 +87,16 @@ extern const RISCVCSR th_csr_list[];
 /* Implemented in mips_csr.c */
 extern const RISCVCSR mips_csr_list[];
 
+/* PMP CSRs, defined in pmp.c */
+void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
+                      target_ulong val);
+target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
+uint64_t mseccfg_csr_read(CPURISCVState *env);
+
+void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
+                       target_ulong val);
+target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
+
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 91130289d8..eae305ac6f 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,7 +22,6 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
-#include "exec/target_long.h"
 #include "cpu.h"
 
 typedef enum {
@@ -52,7 +51,7 @@ typedef enum {
 } mseccfg_field_t;
 
 typedef struct {
-    target_ulong addr_reg;
+    uint64_t addr_reg;
     uint8_t  cfg_reg;
 } pmp_entry_t;
 
@@ -67,21 +66,13 @@ typedef struct {
     uint32_t num_rules;
 } pmp_table_t;
 
-void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-                      target_ulong val);
-target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+typedef struct CPUArchState CPURISCVState;
 
-void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
-uint64_t mseccfg_csr_read(CPURISCVState *env);
-
-void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
-                       target_ulong val);
-target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
+                        int size, pmp_priv_t privs,
                         pmp_priv_t *allowed_privs,
-                        target_ulong mode);
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
+                        privilege_mode_t mode);
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 36f4c3251d..13eb292c4a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -48,10 +48,10 @@ static int pmp_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_pmp_entry = {
     .name = "cpu/pmp/entry",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(addr_reg, pmp_entry_t),
+        VMSTATE_UINT64(addr_reg, pmp_entry_t),
         VMSTATE_UINT8(cfg_reg, pmp_entry_t),
         VMSTATE_END_OF_LIST()
     }
@@ -59,8 +59,8 @@ static const VMStateDescription vmstate_pmp_entry = {
 
 static const VMStateDescription vmstate_pmp = {
     .name = "cpu/pmp",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmp_needed,
     .post_load = pmp_post_load,
     .fields = (const VMStateField[]) {
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index bc4ab8ad15..9b26a3c1b4 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
@@ -310,7 +311,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index, hwaddr addr)
  */
 static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
                                        pmp_priv_t *allowed_privs,
-                                       target_ulong mode)
+                                       privilege_mode_t mode)
 {
     bool ret;
 
@@ -373,8 +374,9 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
  * have no functional impact in QEMU emulation.
  */
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
-                        pmp_priv_t *allowed_privs, target_ulong mode)
+                        int size, pmp_priv_t privs,
+                        pmp_priv_t *allowed_privs,
+                        privilege_mode_t mode)
 {
     int i = 0;
     int pmp_size = 0;
@@ -724,7 +726,7 @@ uint64_t mseccfg_csr_read(CPURISCVState *env)
  * To avoid this we return a size of 1 (which means no caching) if the PMP
  * region only covers partial of the TLB page.
  */
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
 {
     hwaddr pmp_sa;
     hwaddr pmp_ea;
-- 
2.52.0


