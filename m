Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41510CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JnA-0005U4-SW; Wed, 24 Sep 2025 03:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jn7-0005Sl-1o
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:54 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmv-0003PA-LH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4MiCprU9r/vpqTGEXJAcvIEUzceAukG6LI+srcuMH+0=; b=upWmIsNwLWktvuB
 RJBTmbNDv7Iy4ILA55tfcJL+ftxmjxAtUGa9v4WY1yl7tx9g/4bKN0ugWmH6eaRwltcp4bBOOEZjQ
 T9NAAvD4+3axi4Pbfup9W0JKTvToCb2EVoGLOZqCqfr8x5dOXuyBHttrexxxdJXxLdRhgS24WhwM6
 fk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 10/34] target/riscv: Fix size of gpr and gprh
Date: Wed, 24 Sep 2025 09:21:00 +0200
Message-ID: <20250924072124.6493-11-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
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

gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
fixing their size to 64 bits makes sense.

gpr is also fixed to 64 bits since all direct uses of env->gpr
correctly zero extend/truncate to/from target_ulong, meaning
!TARGET_RISCV64 will behave as expected.

We do however need to be a bit careful when mapping 64-bit fields to
32-bit TCGv globals on big endian hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h       |  4 ++--
 target/riscv/cpu.c       |  2 +-
 target/riscv/machine.c   |  4 ++--
 target/riscv/translate.c | 17 +++++++++++++++--
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b0d6e74ea3..2cd69fa150 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -212,8 +212,8 @@ typedef struct PMUFixedCtrState {
 } PMUFixedCtrState;
 
 struct CPUArchState {
-    target_ulong gpr[32];
-    target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
+    uint64_t gpr[32];
+    uint64_t gprh[32]; /* 64 top bits of the 128-bit registers */
 
     /* vector coprocessor state. */
     uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..3c910e44cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -584,7 +584,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
-                     riscv_int_regnames[i], env->gpr[i]);
+                     riscv_int_regnames[i], (target_ulong) env->gpr[i]);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 7b00cb4804..9a14a805ef 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -180,7 +180,7 @@ static const VMStateDescription vmstate_rv128 = {
     .minimum_version_id = 1,
     .needed = rv128_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gprh, RISCVCPU, 32),
         VMSTATE_UINT64(env.mscratchh, RISCVCPU),
         VMSTATE_UINT64(env.sscratchh, RISCVCPU),
         VMSTATE_END_OF_LIST()
@@ -404,7 +404,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .minimum_version_id = 10,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
         VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..2f8c7a6465 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -26,6 +26,7 @@
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
+#include "exec/tswap.h"
 #include "semihosting/semihost.h"
 
 #include "internals.h"
@@ -1427,12 +1428,24 @@ void riscv_translate_init(void)
      */
     cpu_gpr[0] = NULL;
     cpu_gprh[0] = NULL;
+    /*
+     * Be careful with big endian hosts when mapping 64-bit CPUArchState fields
+     * to 32-bit TCGv globals.  An offset of 4 bytes is applied so the least
+     * significant bytes are correctly written to.
+     */
+#if HOST_BIG_ENDIAN && !defined(TARGET_RISCV64)
+    size_t field_offset = 4;
+#else
+    size_t field_offset = 0;
+#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
+            offsetof(CPURISCVState, gpr[i]) + field_offset,
+            riscv_int_regnames[i]);
         cpu_gprh[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
+            offsetof(CPURISCVState, gprh[i]) + field_offset,
+            riscv_int_regnamesh[i]);
     }
 
     for (i = 0; i < 32; i++) {
-- 
2.51.0


