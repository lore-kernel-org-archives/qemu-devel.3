Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77710CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJx-00060i-4A; Wed, 01 Oct 2025 03:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJj-0005vx-PO
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJE-0003du-Tr
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Ul0C2a/hJLKF/gidGN+nOYSzrLT+OLY7P5tEI0N3Hgk=; b=VVyGL/IJ3AyPkIR
 4kDeDH1mclnKoKRXMdxmLGRUFVxF9QPFDTIwHzPa9mpxi0GIRJbiz1N81y+H4DmT3DqLO9xDMKwmM
 wR8dOEZ7JAvqZ+rODTe4RC9a1iIScW9RDib8psUAuWedRAZeOInmhE25J5RDMNF++2IqPB9P0yrp/
 v8=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 33/33] target/riscv: Make pmp.h target_ulong agnostic
Date: Wed,  1 Oct 2025 09:33:06 +0200
Message-ID: <20251001073306.28573-34-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
CPUArchState.  CSR declaraions are only used in target/ and are moved to
csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
parameter is fixed to 8 bits, similar to previous commits.

Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
migration from older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/csr.h     | 12 ++++++++++++
 target/riscv/pmp.h     | 20 +++++---------------
 target/riscv/machine.c | 10 +++++-----
 target/riscv/pmp.c     |  9 +++++----
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index 552e6c5de5..3752a0ef43 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -78,4 +78,16 @@ void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
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
index e322904637..c9b0ee6c58 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,8 +22,6 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
-#include "cpu.h"
-
 typedef enum {
     PMP_READ  = 1 << 0,
     PMP_WRITE = 1 << 1,
@@ -50,7 +48,7 @@ typedef enum {
 } mseccfg_field_t;
 
 typedef struct {
-    target_ulong addr_reg;
+    uint64_t addr_reg;
     uint8_t  cfg_reg;
 } pmp_entry_t;
 
@@ -65,21 +63,13 @@ typedef struct {
     uint32_t num_rules;
 } pmp_table_t;
 
-void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-                      target_ulong val);
-target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
-
-void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
-uint64_t mseccfg_csr_read(CPURISCVState *env);
+typedef struct CPUArchState CPURISCVState;
 
-void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
-                       target_ulong val);
-target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
+                        int size, pmp_priv_t privs,
                         pmp_priv_t *allowed_privs,
-                        target_ulong mode);
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
+                        uint8_t mode);
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index aa71aa6eb1..6b92ac02b3 100644
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
index 85199c7387..6089e2730e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
@@ -272,7 +273,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index, hwaddr addr)
  */
 static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
                                        pmp_priv_t *allowed_privs,
-                                       target_ulong mode)
+                                       uint8_t mode)
 {
     bool ret;
 
@@ -331,8 +332,8 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
  * Return false if no match
  */
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
-                        target_ulong size, pmp_priv_t privs,
-                        pmp_priv_t *allowed_privs, target_ulong mode)
+                        int size, pmp_priv_t privs,
+                        pmp_priv_t *allowed_privs, uint8_t mode)
 {
     int i = 0;
     int pmp_size = 0;
@@ -662,7 +663,7 @@ uint64_t mseccfg_csr_read(CPURISCVState *env)
  * To avoid this we return a size of 1 (which means no caching) if the PMP
  * region only covers partial of the TLB page.
  */
-target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
+uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
 {
     hwaddr pmp_sa;
     hwaddr pmp_ea;
-- 
2.51.0


