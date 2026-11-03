Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7812606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=Hz19Yn+o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOK2B-0000u5-60; Tue, 03 Nov 2026 14:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOK1w-0000qt-J5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:18:48 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOK1t-0007s1-Nu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=DNfsGRGG5uQKioWtNEVt/QstjH+52mQuUs3K5rPiDEk=; b=Hz19Yn+obYkhnKQ
 +6T9BBB8DthW8+4KdMsNTUGiO1BzVGeC4u1hEiQ07PjYy4Pru+rCwfxVukzwdmoWUvaHSs+CDs9xC
 Obf1xduiDh4GQif1l5EyoNOwCGKRpPIxD/4idx6hSjwnpGVViVUiE7BNvE385suzxeM+32mtWhz24
 bI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v1 3/6] target/hexagon: Forward return address to HLX
 load/store helpers
Date: Tue,  3 Nov 2026 20:23:55 +0100
Message-ID: <20261103192358.28589-4-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-1-anjo@rev.ng>
References: <20261103192358.28589-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes: 2db29a3615a5ad2a3 ("target/hexagon: add HLX helper support")
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/macros.h     | 13 +++++++++----
 target/hexagon/hlx_helper.c | 31 ++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 2748e26d6c..5799016ea4 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -22,6 +22,7 @@
 #include "hex_regs.h"
 #include "reg_fields.h"
 #include "accel/tcg/getpc.h"
+#include "hlx_helper.h"
 
 #define GET_FIELD(FIELD, REGIN) \
     fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
@@ -738,8 +739,10 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
                             EA, tcg_constant_i32(ABOVE), \
                             tcg_constant_i32(BELOW))
 #else
-#define fLOADMML(EA, DST, ABOVE, BELOW) \
-    do { HELPER(hlx_load_vec)(env, &(DST), (EA), (ABOVE), (BELOW)); } while (0)
+#define fLOADMML(EA, DST, ABOVE, BELOW)                                \
+    do {                                                               \
+        hlx_load_vec_ra(env, &(DST), (EA), (ABOVE), (BELOW), GETPC()); \
+    } while (0)
 #endif
 
 /* The helper logs the store for packet commit. */
@@ -748,8 +751,10 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
     gen_helper_hlx_store_vec(tcg_env, EA, tcg_constant_ptr((intptr_t)&(SRC)), \
                              tcg_constant_i32(ABOVE), tcg_constant_i32(BELOW))
 #else
-#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
-    do { HELPER(hlx_store_vec)(env, (EA), &(SRC), (ABOVE), (BELOW)); } while (0)
+#define fSTOREMML(EA, SRC, ABOVE, BELOW)                                \
+    do {                                                                \
+        hlx_store_vec_ra(env, (EA), &(SRC), (ABOVE), (BELOW), GETPC()); \
+    } while (0)
 #endif
 
 /* Helpers receive .new registers in future_LRegs. */
diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
index c063706cfa..bc638f6403 100644
--- a/target/hexagon/hlx_helper.c
+++ b/target/hexagon/hlx_helper.c
@@ -7,6 +7,7 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
+#include "hlx_helper.h"
 #include "hlx/hlx.h"
 #include "hw/hexagon/hexagon_hlx.h"
 #include "accel/tcg/probe.h"
@@ -15,40 +16,52 @@
 #define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
 
 /* Align down to 2KB. Above and below are unused in V85. */
-void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
-                          target_ulong ea, uint32_t above, uint32_t below)
+void hlx_load_vec_ra(CPUHexagonState *env, void *dst_void,
+                     target_ulong ea, uint32_t above, uint32_t below,
+                     uintptr_t ra)
 {
     HLXVector *dst = (HLXVector *)dst_void;
     target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
-    uintptr_t raddr = GETPC();
     int mmu_idx = cpu_mmu_index(env_cpu(env), false);
 
     /* A 2KB-aligned access stays within one page. */
-    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx,
-                            raddr);
+    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, ra);
 
     if (host) {
         memcpy(dst, host, HLX_VEC_SIZE_BYTES);
     } else {
         for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
-            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, raddr);
+            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, ra);
             memcpy(&dst->ub[i], &val, 8);
         }
     }
 }
 
-void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
-                           void *src_void, uint32_t above, uint32_t below)
+void hlx_store_vec_ra(CPUHexagonState *env, target_ulong ea,
+                      void *src_void, uint32_t above, uint32_t below,
+                      uintptr_t ra)
 {
     target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
     int mmu_idx = cpu_mmu_index(env_cpu(env), false);
 
-    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, GETPC());
+    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, ra);
     memcpy(&env->hlx_store_data, src_void, sizeof(HLXVector));
     env->hlx_store_va = aligned_ea;
     env->hlx_store_pending = true;
 }
 
+void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
+                          target_ulong ea, uint32_t above, uint32_t below)
+{
+    hlx_load_vec_ra(env, dst_void, ea, above, below, GETPC());
+}
+
+void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
+                           void *src_void, uint32_t above, uint32_t below)
+{
+    hlx_store_vec_ra(env, ea, src_void, above, below, GETPC());
+}
+
 void HELPER(hlx_commit_store)(CPUHexagonState *env)
 {
     target_ulong va = env->hlx_store_va;
-- 
2.52.0


