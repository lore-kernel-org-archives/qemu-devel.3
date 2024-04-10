Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3981CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQlL-0004lT-Qt; Wed, 10 Apr 2024 01:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlJ-0004l3-NV; Wed, 10 Apr 2024 01:44:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlH-0001IG-MT; Wed, 10 Apr 2024 01:44:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBAAE5D4DD;
 Wed, 10 Apr 2024 08:46:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A009DB0144;
 Wed, 10 Apr 2024 08:44:16 +0300 (MSK)
Received: (nullmailer pid 4182015 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 05/41] target/arm: Fix SME full tile indexing
Date: Wed, 10 Apr 2024 08:43:26 +0300
Message-Id: <20240410054416.4181891-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

For the outer product set of insns, which take an entire matrix
tile as output, the argument is not a combined tile+column.
Therefore using get_tile_rowcol was incorrect, as we extracted
the tile number from itself.

The test case relies only on assembler support for SME, since
no release of GCC recognizes -march=armv9-a+sme yet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1620
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230622151201.1578522-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: dropped now-unneeded changes to sysregs CFLAGS]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 1f51573f7925b80e79a29f87c7d9d6ead60960c0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate-sme.c b/target/arm/translate-sme.c
index 7b87a9df63..65f8495bdd 100644
--- a/target/arm/translate-sme.c
+++ b/target/arm/translate-sme.c
@@ -103,6 +103,21 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/*
+ * Resolve tile.size[0] to a host pointer.
+ * Used by e.g. outer product insns where we require the entire tile.
+ */
+static TCGv_ptr get_tile(DisasContext *s, int esz, int tile)
+{
+    TCGv_ptr addr = tcg_temp_new_ptr();
+    int offset;
+
+    offset = tile * sizeof(ARMVectorReg) + offsetof(CPUARMState, zarray);
+
+    tcg_gen_addi_ptr(addr, cpu_env, offset);
+    return addr;
+}
+
 static bool trans_ZERO(DisasContext *s, arg_ZERO *a)
 {
     if (!dc_isar_feature(aa64_sme, s)) {
@@ -279,8 +294,7 @@ static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     pn = pred_full_reg_ptr(s, a->pn);
     pm = pred_full_reg_ptr(s, a->pm);
@@ -310,8 +324,7 @@ static bool do_outprod(DisasContext *s, arg_op *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
@@ -337,8 +350,7 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 118d069073..5e4ea7c998 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -24,7 +24,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 # Pauth Tests
@@ -51,6 +51,11 @@ AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
+# SME Tests
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+AARCH64_TESTS += sme-outprod1
+endif
+
 # System Registers Tests
 AARCH64_TESTS += sysregs
 
diff --git a/tests/tcg/aarch64/sme-outprod1.c b/tests/tcg/aarch64/sme-outprod1.c
new file mode 100644
index 0000000000..6e5972d75e
--- /dev/null
+++ b/tests/tcg/aarch64/sme-outprod1.c
@@ -0,0 +1,83 @@
+/*
+ * SME outer product, 1 x 1.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+
+extern void foo(float *dst);
+
+asm(
+"	.arch_extension sme\n"
+"	.type foo, @function\n"
+"foo:\n"
+"	stp x29, x30, [sp, -80]!\n"
+"	mov x29, sp\n"
+"	stp d8, d9, [sp, 16]\n"
+"	stp d10, d11, [sp, 32]\n"
+"	stp d12, d13, [sp, 48]\n"
+"	stp d14, d15, [sp, 64]\n"
+"	smstart\n"
+"	ptrue p0.s, vl4\n"
+"	fmov z0.s, #1.0\n"
+/*
+ * An outer product of a vector of 1.0 by itself should be a matrix of 1.0.
+ * Note that we are using tile 1 here (za1.s) rather than tile 0.
+ */
+"	zero {za}\n"
+"	fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n"
+/*
+ * Read the first 4x4 sub-matrix of elements from tile 1:
+ * Note that za1h should be interchangable here.
+ */
+"	mov w12, #0\n"
+"	mova z0.s, p0/m, za1v.s[w12, #0]\n"
+"	mova z1.s, p0/m, za1v.s[w12, #1]\n"
+"	mova z2.s, p0/m, za1v.s[w12, #2]\n"
+"	mova z3.s, p0/m, za1v.s[w12, #3]\n"
+/*
+ * And store them to the input pointer (dst in the C code):
+ */
+"	st1w {z0.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z1.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z2.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z3.s}, p0, [x0]\n"
+"	smstop\n"
+"	ldp d8, d9, [sp, 16]\n"
+"	ldp d10, d11, [sp, 32]\n"
+"	ldp d12, d13, [sp, 48]\n"
+"	ldp d14, d15, [sp, 64]\n"
+"	ldp x29, x30, [sp], 80\n"
+"	ret\n"
+"	.size foo, . - foo"
+);
+
+int main()
+{
+    float dst[16];
+    int i, j;
+
+    foo(dst);
+
+    for (i = 0; i < 16; i++) {
+        if (dst[i] != 1.0f) {
+            break;
+        }
+    }
+
+    if (i == 16) {
+        return 0; /* success */
+    }
+
+    /* failure */
+    for (i = 0; i < 4; ++i) {
+        for (j = 0; j < 4; ++j) {
+            printf("%f ", (double)dst[i * 4 + j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
-- 
2.39.2


