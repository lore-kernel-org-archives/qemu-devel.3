Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4E3D743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHi-0001Xt-Sn; Wed, 20 Nov 2024 20:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHg-0001WD-EJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHd-0004WP-DS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=MkoZS5Eq2jzUTLA5ZLNru01SQe4ERiiU1sa7s9RAVVk=; b=B9e2n/WGT0vK5Ay
 QsuyY8C0qOM4af/q78rMJfsu9999M6PD1KQUcIX7+jphjNtW/zySV3MuYnwgZGC84ZO1jtTxclLEI
 xQ/stN/6hIu2glfeBF/jLv8jTTLMu4Q11llmjAbt0tDfg61x3mJ2XWOvrdcvNvmzaq3mVdDZZ+aV+
 JE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 03/43] accel/tcg: Add gvec size changing operations
Date: Thu, 21 Nov 2024 02:49:07 +0100
Message-ID: <20241121014947.18666-4-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
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

Adds new functions to the gvec API for truncating, sign- or zero
extending vector elements.  Currently implemented as helper functions,
these may be mapped onto host vector instructions in the future.

For the time being, allows translation of more complicated vector
instructions by helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tcg-runtime-gvec.c     | 41 +++++++++++++++++
 accel/tcg/tcg-runtime.h          | 22 +++++++++
 include/tcg/tcg-op-gvec-common.h | 18 ++++++++
 tcg/tcg-op-gvec.c                | 78 ++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index afca89baa1..685c991e6a 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1569,3 +1569,44 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+#define DO_SZ_OP1(NAME, DSTTY, SRCTY)                                      \
+void HELPER(NAME)(void *d, void *a, uint32_t desc)                         \
+{                                                                          \
+    intptr_t oprsz = simd_oprsz(desc);                                     \
+    intptr_t elsz = oprsz/sizeof(DSTTY);                                   \
+    intptr_t i;                                                            \
+                                                                           \
+    for (i = 0; i < elsz; ++i) {                                           \
+        SRCTY aa = *((SRCTY *) a + i);                                     \
+        *((DSTTY *) d + i) = aa;                                           \
+    }                                                                      \
+    clear_high(d, oprsz, desc);                                            \
+}
+
+#define DO_SZ_OP2(NAME, INTTY, DSTSZ, SRCSZ) \
+    DO_SZ_OP1(NAME##SRCSZ##_##DSTSZ, INTTY##DSTSZ##_t, INTTY##SRCSZ##_t)
+
+DO_SZ_OP2(gvec_trunc, uint, 32, 64)
+DO_SZ_OP2(gvec_trunc, uint, 16, 64)
+DO_SZ_OP2(gvec_trunc, uint, 8,  64)
+DO_SZ_OP2(gvec_trunc, uint, 16, 32)
+DO_SZ_OP2(gvec_trunc, uint, 8,  32)
+DO_SZ_OP2(gvec_trunc, uint, 8,  16)
+
+DO_SZ_OP2(gvec_zext, uint, 64, 32)
+DO_SZ_OP2(gvec_zext, uint, 64, 16)
+DO_SZ_OP2(gvec_zext, uint, 64, 8)
+DO_SZ_OP2(gvec_zext, uint, 32, 16)
+DO_SZ_OP2(gvec_zext, uint, 32, 8)
+DO_SZ_OP2(gvec_zext, uint, 16, 8)
+
+DO_SZ_OP2(gvec_sext, int, 64, 32)
+DO_SZ_OP2(gvec_sext, int, 64, 16)
+DO_SZ_OP2(gvec_sext, int, 64, 8)
+DO_SZ_OP2(gvec_sext, int, 32, 16)
+DO_SZ_OP2(gvec_sext, int, 32, 8)
+DO_SZ_OP2(gvec_sext, int, 16, 8)
+
+#undef DO_SZ_OP1
+#undef DO_SZ_OP2
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0a4d31eb48..5045655bf8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,3 +1,4 @@
+#include "tcg/tcg.h"
 DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
@@ -328,3 +329,24 @@ DEF_HELPER_FLAGS_4(gvec_leus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_leus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_trunc64_32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_trunc64_16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_trunc64_8,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_trunc32_16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_trunc32_8,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_trunc16_8,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_zext32_64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_zext16_64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_zext8_64,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_zext16_32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_zext8_32,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_zext8_16,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sext32_64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sext16_64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sext8_64,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sext16_32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sext8_32,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sext8_16,  TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 65553f5f97..39b0c2f64e 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -390,6 +390,24 @@ void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t cofs,
                          uint32_t oprsz, uint32_t maxsz);
 
+/*
+ * Perform vector element truncation/extension operations
+ */
+
+void tcg_gen_gvec_trunc(unsigned vecde, unsigned vecse,
+                        uint32_t dofs, uint32_t aofs,
+                        uint32_t doprsz, uint32_t aoprsz,
+                        uint32_t maxsz);
+
+void tcg_gen_gvec_zext(unsigned vecde, unsigned vecse,
+                       uint32_t dofs, uint32_t aofs,
+                       uint32_t doprsz, uint32_t aoprsz,
+                       uint32_t maxsz);
+
+void tcg_gen_gvec_sext(unsigned vecde, unsigned vecse,
+                       uint32_t dofs, uint32_t aofs,
+                       uint32_t doprsz, uint32_t aoprsz,
+                       uint32_t maxsz);
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 97e4df221a..80649dc0d2 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -4008,3 +4008,81 @@ void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
 
     tcg_gen_gvec_4(dofs, aofs, bofs, cofs, oprsz, maxsz, &g);
 }
+
+void tcg_gen_gvec_trunc(unsigned vecde, unsigned vecse,
+                        uint32_t dofs, uint32_t aofs,
+                        uint32_t doprsz, uint32_t aoprsz,
+                        uint32_t maxsz)
+{
+    gen_helper_gvec_2 * const fns[4][4] = {
+        [MO_64] = {
+            [MO_32] = gen_helper_gvec_trunc64_32,
+            [MO_16] = gen_helper_gvec_trunc64_16,
+            [MO_8]  = gen_helper_gvec_trunc64_8,
+        },
+        [MO_32] = {
+            [MO_16] = gen_helper_gvec_trunc32_16,
+            [MO_8]  = gen_helper_gvec_trunc32_8,
+        },
+        [MO_16] = {
+            [MO_8]  = gen_helper_gvec_trunc16_8,
+        },
+    };
+
+    gen_helper_gvec_2 *fn = fns[vecse][vecde];
+    tcg_debug_assert(fn != 0 && vecse > vecde);
+
+    tcg_gen_gvec_2_ool(dofs, aofs, doprsz, maxsz, 0, fn);
+}
+
+void tcg_gen_gvec_zext(unsigned vecde, unsigned vecse,
+                       uint32_t dofs, uint32_t aofs,
+                       uint32_t doprsz, uint32_t aoprsz,
+                       uint32_t maxsz)
+{
+    gen_helper_gvec_2 * const fns[4][4] = {
+        [MO_8] = {
+            [MO_16] = gen_helper_gvec_zext8_16,
+            [MO_32] = gen_helper_gvec_zext8_32,
+            [MO_64] = gen_helper_gvec_zext8_64,
+        },
+        [MO_16] = {
+            [MO_32] = gen_helper_gvec_zext16_32,
+            [MO_64] = gen_helper_gvec_zext16_64,
+        },
+        [MO_32] = {
+            [MO_64] = gen_helper_gvec_zext32_64,
+        },
+    };
+
+    gen_helper_gvec_2 *fn = fns[vecse][vecde];
+    tcg_debug_assert(fn != 0 && vecse < vecde);
+
+    tcg_gen_gvec_2_ool(dofs, aofs, doprsz, maxsz, 0, fn);
+}
+
+void tcg_gen_gvec_sext(unsigned vecde, unsigned vecse,
+                       uint32_t dofs, uint32_t aofs,
+                       uint32_t doprsz, uint32_t aoprsz,
+                       uint32_t maxsz)
+{
+    gen_helper_gvec_2 * const fns[4][4] = {
+        [MO_8] = {
+            [MO_16] = gen_helper_gvec_sext8_16,
+            [MO_32] = gen_helper_gvec_sext8_32,
+            [MO_64] = gen_helper_gvec_sext8_64,
+        },
+        [MO_16] = {
+            [MO_32] = gen_helper_gvec_sext16_32,
+            [MO_64] = gen_helper_gvec_sext16_64,
+        },
+        [MO_32] = {
+            [MO_64] = gen_helper_gvec_sext32_64,
+        },
+    };
+
+    gen_helper_gvec_2 *fn = fns[vecse][vecde];
+    tcg_debug_assert(fn != 0 && vecse < vecde);
+
+    tcg_gen_gvec_2_ool(dofs, aofs, doprsz, maxsz, 0, fn);
+}
-- 
2.45.2


