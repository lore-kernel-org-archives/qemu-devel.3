Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BEDC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKAo-0008Gy-Ie; Tue, 06 May 2025 11:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uCKAh-0008EH-Rb
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:25:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uCKAe-0001Wo-7O
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:25:27 -0400
Received: from loongson.cn (unknown [223.64.120.156])
 by gateway (Coremail) with SMTP id _____8DxbKzXKRpoz+jWAA--.25153S3;
 Tue, 06 May 2025 23:25:11 +0800 (CST)
Received: from lvm.. (unknown [223.64.120.156])
 by front1 (Coremail) with SMTP id qMiowMCx_cbRKRpoemC3AA--.9610S2;
 Tue, 06 May 2025 23:25:09 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu@hev.cc, WANG Rui <wangrui@loongson.cn>,
 mengqinggang <mengqinggang@loongson.cn>
Subject: [PATCH] target/loongarch: Fix incorrect rounding in fnm{add,
 sub} under certain modes
Date: Tue,  6 May 2025 23:26:00 +0800
Message-ID: <20250506152600.2521399-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cbRKRpoemC3AA--.9610S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw15Jw4xJr1DCr48Aw43urX_yoW7Xryrpr
 yfursakrs7JFZ7J3Z3Jw15WF15Jr4rC3W7Z3ZxJr1I9w4UKry8Zw1xKrW29FWDG3yUWr1S
 v3ZayF4xKF1UWagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

This patch fixes incorrect results for [xv]fnm{add,sub}.{s,d}
instructions when rounding toward zero, postive, negative.

According to the LoongArch ISA specification, these instructions perform
a fused multiply-add followed by a negation of the final result.

Previously, the sign inversion was applied before fused operation, which
interfered with rounding decisions that depend on the result sign --
leading to deviations from the expected behavior. This patch corrects
the implementation by applying the negation after fused multiply-add,
ensuring that rounding is performed on the correct intermediate result.

Reported-by: mengqinggang <mengqinggang@loongson.cn>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 target/loongarch/tcg/fpu_helper.c     |  8 ++++++++
 target/loongarch/tcg/vec_helper.c     |  7 ++++++-
 tests/tcg/loongarch64/Makefile.target |  2 ++
 tests/tcg/loongarch64/test_fnmsub.c   | 20 ++++++++++++++++++++
 tests/tcg/loongarch64/test_vfnmsub.c  | 27 +++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/loongarch64/test_fnmsub.c
 create mode 100644 tests/tcg/loongarch64/test_vfnmsub.c

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index fc3fd0561e..970b88ac56 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -389,9 +389,13 @@ uint64_t helper_fmuladd_s(CPULoongArchState *env, uint64_t fj,
                           uint64_t fk, uint64_t fa, uint32_t flag)
 {
     uint64_t fd;
+    uint32_t neg_res;
 
+    neg_res = flag & float_muladd_negate_result;
+    flag ^= neg_res;
     fd = nanbox_s(float32_muladd((uint32_t)fj, (uint32_t)fk,
                                  (uint32_t)fa, flag, &env->fp_status));
+    fd |= neg_res ? 0x80000000ULL : 0;
     update_fcsr0(env, GETPC());
     return fd;
 }
@@ -400,8 +404,12 @@ uint64_t helper_fmuladd_d(CPULoongArchState *env, uint64_t fj,
                           uint64_t fk, uint64_t fa, uint32_t flag)
 {
     uint64_t fd;
+    uint32_t neg_res;
 
+    neg_res = flag & float_muladd_negate_result;
+    flag ^= neg_res;
     fd = float64_muladd(fj, fk, fa, flag, &env->fp_status);
+    fd |= neg_res ? 0x8000000000000000ULL : 0;
     update_fcsr0(env, GETPC());
     return fd;
 }
diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
index 3faf52cbc4..c48e3662d1 100644
--- a/target/loongarch/tcg/vec_helper.c
+++ b/target/loongarch/tcg/vec_helper.c
@@ -2446,10 +2446,15 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, void *va,                    \
     VReg *Vk = (VReg *)vk;                                                   \
     VReg *Va = (VReg *)va;                                                   \
     int oprsz = simd_oprsz(desc);                                            \
+    uint32_t flag = flags;                                                   \
+    uint32_t neg_res;                                                        \
                                                                              \
+    neg_res = flag & float_muladd_negate_result;                             \
+    flag ^= neg_res;                                                         \
     vec_clear_cause(env);                                                    \
     for (i = 0; i < oprsz / (BIT / 8); i++) {                                \
-        Vd->E(i) = FN(Vj->E(i), Vk->E(i), Va->E(i), flags, &env->fp_status); \
+        Vd->E(i) = FN(Vj->E(i), Vk->E(i), Va->E(i), flag, &env->fp_status);  \
+        Vd->E(i) |= neg_res ? (1ULL << (BIT - 1)) : 0;                       \
         vec_update_fcsr0(env, GETPC());                                      \
     }                                                                        \
 }
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
index 0000000000..0c8514f33d
--- /dev/null
+++ b/tests/tcg/loongarch64/test_fnmsub.c
@@ -0,0 +1,20 @@
+#include <assert.h>
+#include <stdint.h>
+#include <fenv.h>
+
+int main()
+{
+    double x, y, z;
+
+    *(uint64_t *)&x = 0x4ff0000000000000UL;
+    *(uint64_t *)&y = 0x4ff0000000000000UL;
+    *(uint64_t *)&z = 0x2ff0000000000000UL;
+
+    fesetround(FE_DOWNWARD);
+    asm("fnmsub.d %[x], %[x], %[y], %[z]\n\t"
+        :[x]"+f"(x)
+        :[y]"f"(y), [z]"f"(z));
+
+    assert(*(uint64_t *)&x == 0xdfefffffffffffffUL);
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


