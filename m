Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 09:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCark-0007Af-Jn; Wed, 07 May 2025 05:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uCari-0007AQ-9C
 for qemu-devel@nongnu.org; Wed, 07 May 2025 05:14:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uCard-0005ap-Gv
 for qemu-devel@nongnu.org; Wed, 07 May 2025 05:14:58 -0400
Received: from loongson.cn (unknown [223.64.120.156])
 by gateway (Coremail) with SMTP id _____8AxQK2FJBtoYv7XAA--.9670S3;
 Wed, 07 May 2025 17:14:45 +0800 (CST)
Received: from lvm.. (unknown [223.64.120.156])
 by front1 (Coremail) with SMTP id qMiowMBxXsV_JBtos6q5AA--.12892S2;
 Wed, 07 May 2025 17:14:43 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, WANG Rui <wangrui@loongson.cn>,
 mengqinggang <mengqinggang@loongson.cn>
Subject: [RFC PATCH v2] target/loongarch: Fix incorrect rounding in fnm{add,
 sub} under certain modes
Date: Wed,  7 May 2025 17:14:55 +0800
Message-ID: <20250507091455.3257138-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsV_JBtos6q5AA--.12892S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJF4xXr18Zr18WFyUCFW8KrX_yoWDuFyDpF
 9rurs2kr48AF4xZFnrt3ZrCrn5Wr43J342q3srGry0vr43tF4UCr4rKa4DuF1jg34jgw4a
 qFZYk3y7Ga1UWagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patch fixes incorrect results for `[xv]fnm{add,sub}.{s,d}`
instructions when rounding toward {zero, positive, negative}.

According to the LoongArch ISA specification, the result of an
instruction like `FNMSUB.D` is computed as:

  FR[fd] = -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])

Here, `FP64_fusedMultiplyAdd()` performs a fused multiply-add operation
compliant with IEEE 754-2008. The negation is applied to the fully
rounded result of the fused operation - not to any intermediate value.
This behavior is specifiec to LoongArch and differs from other arches,
which is why the existing `float_muladd_negate_result` flag does not
model it correctly.

To address this, I introduce a new flag `float_muladd_negate_rounded_result`,
which applies the negation after rounding. This ensures that rounding
decisions based on the sign of the result are handled correctly.

Reported-by: mengqinggang <mengqinggang@loongson.cn>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
v1 -> v2:
- Introduce `float_muladd_negate_rounded_result`
---
 fpu/softfloat.c                               | 42 ++++++++++++++++---
 include/fpu/softfloat.h                       |  3 +-
 .../tcg/insn_trans/trans_farith.c.inc         | 10 +++--
 target/loongarch/tcg/vec_helper.c             |  8 ++--
 tests/tcg/loongarch64/Makefile.target         |  2 +
 tests/tcg/loongarch64/test_fnmsub.c           | 25 +++++++++++
 tests/tcg/loongarch64/test_vfnmsub.c          | 27 ++++++++++++
 7 files changed, 102 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/loongarch64/test_fnmsub.c
 create mode 100644 tests/tcg/loongarch64/test_vfnmsub.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 34c962d6bd..2691e89a03 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2234,13 +2234,18 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
                       int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
+    float16 r;
 
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
     float16_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float16_round_pack_canonical(pr, status);
+    r = float16_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = float16_chs(r);
+    }
+    return r;
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -2254,13 +2259,18 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
                       int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
+    float32 r;
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
     float32_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float32_round_pack_canonical(pr, status);
+    r = float32_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = float32_chs(r);
+    }
+    return r;
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -2268,13 +2278,18 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
                       int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
+    float64 r;
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
-    return float64_round_pack_canonical(pr, status);
+    r = float64_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = float64_chs(r);
+    }
+    return r;
 }
 
 static bool force_soft_fma;
@@ -2422,39 +2437,54 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
                           int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
+    float64 r;
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    r = float64r32_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = float64_chs(r);
+    }
+    return r;
 }
 
 bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
                                       int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
+    bfloat16 r;
 
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
     bfloat16_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    r = bfloat16_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = bfloat16_chs(r);
+    }
+    return r;
 }
 
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
                                       int flags, float_status *status)
 {
     FloatParts128 pa, pb, pc, *pr;
+    float128 r;
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
     float128_unpack_canonical(&pc, c, status);
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
-    return float128_round_pack_canonical(pr, status);
+    r = float128_round_pack_canonical(pr, status);
+    if (flags & float_muladd_negate_rounded_result) {
+        r = float128_chs(r);
+    }
+    return r;
 }
 
 /*
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c18ab2cb60..db7ea2c916 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -129,7 +129,8 @@ enum {
     float_muladd_negate_c = 1,
     float_muladd_negate_product = 2,
     float_muladd_negate_result = 4,
-    float_muladd_suppress_add_product_zero = 8,
+    float_muladd_negate_rounded_result = 8,
+    float_muladd_suppress_add_product_zero = 16,
 };
 
 /*----------------------------------------------------------------------------
diff --git a/target/loongarch/tcg/insn_trans/trans_farith.c.inc b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
index f4a0dea727..68d149647e 100644
--- a/target/loongarch/tcg/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
@@ -199,9 +199,11 @@ TRANS(fmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, 0)
 TRANS(fmadd_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, 0)
 TRANS(fmsub_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_c)
 TRANS(fmsub_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_c)
-TRANS(fnmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s, float_muladd_negate_result)
-TRANS(fnmadd_d, FP_DP, gen_muladd, gen_helper_fmuladd_d, float_muladd_negate_result)
+TRANS(fnmadd_s, FP_SP, gen_muladd, gen_helper_fmuladd_s,
+      float_muladd_negate_rounded_result)
+TRANS(fnmadd_d, FP_DP, gen_muladd, gen_helper_fmuladd_d,
+      float_muladd_negate_rounded_result)
 TRANS(fnmsub_s, FP_SP, gen_muladd, gen_helper_fmuladd_s,
-      float_muladd_negate_c | float_muladd_negate_result)
+      float_muladd_negate_c | float_muladd_negate_rounded_result)
 TRANS(fnmsub_d, FP_DP, gen_muladd, gen_helper_fmuladd_d,
-      float_muladd_negate_c | float_muladd_negate_result)
+      float_muladd_negate_c | float_muladd_negate_rounded_result)
diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
index 3faf52cbc4..d20f887afa 100644
--- a/target/loongarch/tcg/vec_helper.c
+++ b/target/loongarch/tcg/vec_helper.c
@@ -2458,12 +2458,12 @@ DO_4OP_F(vfmadd_s, 32, UW, float32_muladd, 0)
 DO_4OP_F(vfmadd_d, 64, UD, float64_muladd, 0)
 DO_4OP_F(vfmsub_s, 32, UW, float32_muladd, float_muladd_negate_c)
 DO_4OP_F(vfmsub_d, 64, UD, float64_muladd, float_muladd_negate_c)
-DO_4OP_F(vfnmadd_s, 32, UW, float32_muladd, float_muladd_negate_result)
-DO_4OP_F(vfnmadd_d, 64, UD, float64_muladd, float_muladd_negate_result)
+DO_4OP_F(vfnmadd_s, 32, UW, float32_muladd, float_muladd_negate_rounded_result)
+DO_4OP_F(vfnmadd_d, 64, UD, float64_muladd, float_muladd_negate_rounded_result)
 DO_4OP_F(vfnmsub_s, 32, UW, float32_muladd,
-         float_muladd_negate_c | float_muladd_negate_result)
+         float_muladd_negate_c | float_muladd_negate_rounded_result)
 DO_4OP_F(vfnmsub_d, 64, UD, float64_muladd,
-         float_muladd_negate_c | float_muladd_negate_result)
+         float_muladd_negate_c | float_muladd_negate_rounded_result)
 
 #define DO_2OP_F(NAME, BIT, E, FN)                       \
 void HELPER(NAME)(void *vd, void *vj,                    \
diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
index 00030a1026..e3554a500e 100644
--- a/tests/tcg/loongarch64/Makefile.target
+++ b/tests/tcg/loongarch64/Makefile.target
@@ -16,5 +16,7 @@ LOONGARCH64_TESTS  += test_fclass
 LOONGARCH64_TESTS  += test_fpcom
 LOONGARCH64_TESTS  += test_pcadd
 LOONGARCH64_TESTS  += test_fcsr
+LOONGARCH64_TESTS  += test_fnmsub
+LOONGARCH64_TESTS  += test_vfnmsub
 
 TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/test_fnmsub.c b/tests/tcg/loongarch64/test_fnmsub.c
new file mode 100644
index 0000000000..47fef92cb7
--- /dev/null
+++ b/tests/tcg/loongarch64/test_fnmsub.c
@@ -0,0 +1,25 @@
+#include <assert.h>
+#include <stdint.h>
+#include <fenv.h>
+
+int main()
+{
+    double x, y, z;
+    union {
+        uint64_t i;
+        double d;
+    } u;
+
+    x = 0x1.0p256;
+    y = 0x1.0p256;
+    z = 0x1.0p-256;
+
+    fesetround(FE_DOWNWARD);
+    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
+        :[x]"+f"(x)
+        :[y]"f"(y), [z]"f"(z));
+
+    u.d = x;
+    assert(u.i == 0xdfefffffffffffffUL);
+    return 0;
+}
diff --git a/tests/tcg/loongarch64/test_vfnmsub.c b/tests/tcg/loongarch64/test_vfnmsub.c
new file mode 100644
index 0000000000..8c332674ae
--- /dev/null
+++ b/tests/tcg/loongarch64/test_vfnmsub.c
@@ -0,0 +1,27 @@
+#include <assert.h>
+#include <stdint.h>
+#include <fenv.h>
+
+int main()
+{
+    uint64_t x, y, z;
+
+    x = 0x4ff0000000000000UL;
+    y = 0x4ff0000000000000UL;
+    z = 0x2ff0000000000000UL;
+
+    fesetround(FE_DOWNWARD);
+    asm("vreplgr2vr.d $vr0, %[x]\n\t"
+        "vreplgr2vr.d $vr1, %[y]\n\t"
+        "vreplgr2vr.d $vr2, %[z]\n\t"
+        "vfnmsub.d $vr0, $vr0, $vr1, $vr2\n\t"
+        "vpickve2gr.d %[x], $vr0, 0\n\t"
+        "vpickve2gr.d %[y], $vr0, 1\n\t"
+        :[x]"+&r"(x), [y]"+&r"(y)
+        :[z]"r"(z)
+        :"$f0", "$f1", "$f2");
+
+    assert(x == 0xdfefffffffffffffUL);
+    assert(y == 0xdfefffffffffffffUL);
+    return 0;
+}
-- 
2.49.0


